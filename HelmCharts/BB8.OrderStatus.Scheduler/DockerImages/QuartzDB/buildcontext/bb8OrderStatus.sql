USE [master]
GO


DROP LOGIN [quartz]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [quartz]    Script Date: 11/1/2023 4:22:26 PM ******/
CREATE LOGIN [quartz] WITH PASSWORD=N'MSSQL_QUARTZ_PASSWORD', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [quartz]

DROP DATABASE [QuartzOrderStatus]
GO

CREATE DATABASE [QuartzOrderStatus]
GO

USE [QuartzOrderStatus];
GO

IF OBJECT_ID(N'[dbo].[FK_QRTZ_TRIGGERS_QRTZ_JOB_DETAILS]', N'F') IS NOT NULL
ALTER TABLE [dbo].[QRTZ_TRIGGERS] DROP CONSTRAINT [FK_QRTZ_TRIGGERS_QRTZ_JOB_DETAILS];
GO

IF OBJECT_ID(N'[dbo].[FK_QRTZ_CRON_TRIGGERS_QRTZ_TRIGGERS]', N'F') IS NOT NULL
ALTER TABLE [dbo].[QRTZ_CRON_TRIGGERS] DROP CONSTRAINT [FK_QRTZ_CRON_TRIGGERS_QRTZ_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[FK_QRTZ_SIMPLE_TRIGGERS_QRTZ_TRIGGERS]', N'F') IS NOT NULL
ALTER TABLE [dbo].[QRTZ_SIMPLE_TRIGGERS] DROP CONSTRAINT [FK_QRTZ_SIMPLE_TRIGGERS_QRTZ_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[FK_QRTZ_SIMPROP_TRIGGERS_QRTZ_TRIGGERS]', N'F') IS NOT NULL
ALTER TABLE [dbo].[QRTZ_SIMPROP_TRIGGERS] DROP CONSTRAINT [FK_QRTZ_SIMPROP_TRIGGERS_QRTZ_TRIGGERS];
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QRTZ_JOB_LISTENERS_QRTZ_JOB_DETAILS]') AND parent_object_id = OBJECT_ID(N'[dbo].[QRTZ_JOB_LISTENERS]'))
ALTER TABLE [dbo].[QRTZ_JOB_LISTENERS] DROP CONSTRAINT [FK_QRTZ_JOB_LISTENERS_QRTZ_JOB_DETAILS];

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QRTZ_TRIGGER_LISTENERS_QRTZ_TRIGGERS]') AND parent_object_id = OBJECT_ID(N'[dbo].[QRTZ_TRIGGER_LISTENERS]'))
ALTER TABLE [dbo].[QRTZ_TRIGGER_LISTENERS] DROP CONSTRAINT [FK_QRTZ_TRIGGER_LISTENERS_QRTZ_TRIGGERS];

IF OBJECT_ID(N'[dbo].[QRTZ_CALENDARS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_CALENDARS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_CRON_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_CRON_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_BLOB_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_BLOB_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_FIRED_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_FIRED_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_PAUSED_TRIGGER_GRPS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_PAUSED_TRIGGER_GRPS];
GO

IF  OBJECT_ID(N'[dbo].[QRTZ_JOB_LISTENERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_JOB_LISTENERS];

IF OBJECT_ID(N'[dbo].[QRTZ_SCHEDULER_STATE]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_SCHEDULER_STATE];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_LOCKS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_LOCKS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_TRIGGER_LISTENERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_TRIGGER_LISTENERS];

IF OBJECT_ID(N'[dbo].[QRTZ_JOB_DETAILS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_JOB_DETAILS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_SIMPLE_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_SIMPLE_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_SIMPROP_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_SIMPROP_TRIGGERS];
GO

IF OBJECT_ID(N'[dbo].[QRTZ_TRIGGERS]', N'U') IS NOT NULL
DROP TABLE [dbo].[QRTZ_TRIGGERS];
GO

CREATE TABLE [dbo].[QRTZ_CALENDARS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [CALENDAR_NAME] nvarchar(200) NOT NULL,
  [CALENDAR] varbinary(max) NOT NULL
);
GO

CREATE TABLE [dbo].[QRTZ_CRON_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [CRON_EXPRESSION] nvarchar(120) NOT NULL,
  [TIME_ZONE_ID] nvarchar(80)
);
GO

CREATE TABLE [dbo].[QRTZ_FIRED_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [ENTRY_ID] nvarchar(140) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [INSTANCE_NAME] nvarchar(200) NOT NULL,
  [FIRED_TIME] bigint NOT NULL,
  [SCHED_TIME] bigint NOT NULL,
  [PRIORITY] int NOT NULL,
  [STATE] nvarchar(16) NOT NULL,
  [JOB_NAME] nvarchar(150) NULL,
  [JOB_GROUP] nvarchar(150) NULL,
  [IS_NONCONCURRENT] bit NULL,
  [REQUESTS_RECOVERY] bit NULL
);
GO

CREATE TABLE [dbo].[QRTZ_PAUSED_TRIGGER_GRPS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL
);
GO

CREATE TABLE [dbo].[QRTZ_SCHEDULER_STATE] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [INSTANCE_NAME] nvarchar(200) NOT NULL,
  [LAST_CHECKIN_TIME] bigint NOT NULL,
  [CHECKIN_INTERVAL] bigint NOT NULL
);
GO

CREATE TABLE [dbo].[QRTZ_LOCKS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [LOCK_NAME] nvarchar(40) NOT NULL
);
GO

CREATE TABLE [dbo].[QRTZ_JOB_DETAILS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [JOB_NAME] nvarchar(150) NOT NULL,
  [JOB_GROUP] nvarchar(150) NOT NULL,
  [DESCRIPTION] nvarchar(250) NULL,
  [JOB_CLASS_NAME] nvarchar(250) NOT NULL,
  [IS_DURABLE] bit NOT NULL,
  [IS_NONCONCURRENT] bit NOT NULL,
  [IS_UPDATE_DATA] bit NOT NULL,
  [REQUESTS_RECOVERY] bit NOT NULL,
  [JOB_DATA] varbinary(max) NULL
);
GO

CREATE TABLE [dbo].[QRTZ_SIMPLE_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [REPEAT_COUNT] int NOT NULL,
  [REPEAT_INTERVAL] bigint NOT NULL,
  [TIMES_TRIGGERED] int NOT NULL
);
GO

CREATE TABLE [dbo].[QRTZ_SIMPROP_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [STR_PROP_1] nvarchar(512) NULL,
  [STR_PROP_2] nvarchar(512) NULL,
  [STR_PROP_3] nvarchar(512) NULL,
  [INT_PROP_1] int NULL,
  [INT_PROP_2] int NULL,
  [LONG_PROP_1] bigint NULL,
  [LONG_PROP_2] bigint NULL,
  [DEC_PROP_1] numeric(13,4) NULL,
  [DEC_PROP_2] numeric(13,4) NULL,
  [BOOL_PROP_1] bit NULL,
  [BOOL_PROP_2] bit NULL,
  [TIME_ZONE_ID] nvarchar(80) NULL
);
GO

CREATE TABLE [dbo].[QRTZ_BLOB_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [BLOB_DATA] varbinary(max) NULL
);
GO

CREATE TABLE [dbo].[QRTZ_TRIGGERS] (
  [SCHED_NAME] nvarchar(120) NOT NULL,
  [TRIGGER_NAME] nvarchar(150) NOT NULL,
  [TRIGGER_GROUP] nvarchar(150) NOT NULL,
  [JOB_NAME] nvarchar(150) NOT NULL,
  [JOB_GROUP] nvarchar(150) NOT NULL,
  [DESCRIPTION] nvarchar(250) NULL,
  [NEXT_FIRE_TIME] bigint NULL,
  [PREV_FIRE_TIME] bigint NULL,
  [PRIORITY] int NULL,
  [TRIGGER_STATE] nvarchar(16) NOT NULL,
  [TRIGGER_TYPE] nvarchar(8) NOT NULL,
  [START_TIME] bigint NOT NULL,
  [END_TIME] bigint NULL,
  [CALENDAR_NAME] nvarchar(200) NULL,
  [MISFIRE_INSTR] int NULL,
  [JOB_DATA] varbinary(max) NULL
);
GO

ALTER TABLE [dbo].[QRTZ_CALENDARS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_CALENDARS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [CALENDAR_NAME]
  );
GO

ALTER TABLE [dbo].[QRTZ_CRON_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_CRON_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_FIRED_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_FIRED_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [ENTRY_ID]
  );
GO

ALTER TABLE [dbo].[QRTZ_PAUSED_TRIGGER_GRPS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_PAUSED_TRIGGER_GRPS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_SCHEDULER_STATE] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_SCHEDULER_STATE] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [INSTANCE_NAME]
  );
GO

ALTER TABLE [dbo].[QRTZ_LOCKS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_LOCKS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [LOCK_NAME]
  );
GO

ALTER TABLE [dbo].[QRTZ_JOB_DETAILS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_JOB_DETAILS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_SIMPLE_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_SIMPLE_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_SIMPROP_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_SIMPROP_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_BLOB_TRIGGERS] WITH NOCHECK ADD
  CONSTRAINT [PK_QRTZ_BLOB_TRIGGERS] PRIMARY KEY  CLUSTERED
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  );
GO

ALTER TABLE [dbo].[QRTZ_CRON_TRIGGERS] ADD
  CONSTRAINT [FK_QRTZ_CRON_TRIGGERS_QRTZ_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES [dbo].[QRTZ_TRIGGERS] (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[QRTZ_SIMPLE_TRIGGERS] ADD
  CONSTRAINT [FK_QRTZ_SIMPLE_TRIGGERS_QRTZ_TRIGGERS] FOREIGN KEY
  (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES [dbo].[QRTZ_TRIGGERS] (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[QRTZ_SIMPROP_TRIGGERS] ADD
  CONSTRAINT [FK_QRTZ_SIMPROP_TRIGGERS_QRTZ_TRIGGERS] FOREIGN KEY
  (
	[SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) REFERENCES [dbo].[QRTZ_TRIGGERS] (
    [SCHED_NAME],
    [TRIGGER_NAME],
    [TRIGGER_GROUP]
  ) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[QRTZ_TRIGGERS] ADD
  CONSTRAINT [FK_QRTZ_TRIGGERS_QRTZ_JOB_DETAILS] FOREIGN KEY
  (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  ) REFERENCES [dbo].[QRTZ_JOB_DETAILS] (
    [SCHED_NAME],
    [JOB_NAME],
    [JOB_GROUP]
  );
GO

-- drop indexe if they exist and rebuild if current ones
DROP INDEX IF EXISTS [IDX_QRTZ_T_J] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_JG] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_C] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_G] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_G_J] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_STATE] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_N_STATE] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_N_G_STATE] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_NEXT_FIRE_TIME] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_NFT_ST] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_NFT_MISFIRE] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_NFT_ST_MISFIRE] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_T_NFT_ST_MISFIRE_GRP] ON [dbo].[QRTZ_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_TRIG_INST_NAME] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_INST_JOB_REQ_RCVRY] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_J_G] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_JG] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_T_G] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_TG] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_G_J] ON [dbo].[QRTZ_FIRED_TRIGGERS];
DROP INDEX IF EXISTS [IDX_QRTZ_FT_G_T] ON [dbo].[QRTZ_FIRED_TRIGGERS];
GO

CREATE INDEX [IDX_QRTZ_T_G_J]                 ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, JOB_GROUP, JOB_NAME);
CREATE INDEX [IDX_QRTZ_T_C]                   ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, CALENDAR_NAME);

CREATE INDEX [IDX_QRTZ_T_N_G_STATE]           ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE INDEX [IDX_QRTZ_T_STATE]               ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, TRIGGER_STATE);
CREATE INDEX [IDX_QRTZ_T_N_STATE]             ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);
CREATE INDEX [IDX_QRTZ_T_NEXT_FIRE_TIME]      ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, NEXT_FIRE_TIME);
CREATE INDEX [IDX_QRTZ_T_NFT_ST]              ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);
CREATE INDEX [IDX_QRTZ_T_NFT_ST_MISFIRE]      ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);
CREATE INDEX [IDX_QRTZ_T_NFT_ST_MISFIRE_GRP]  ON [dbo].[QRTZ_TRIGGERS](SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

CREATE INDEX [IDX_QRTZ_FT_INST_JOB_REQ_RCVRY] ON [dbo].[QRTZ_FIRED_TRIGGERS](SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);
CREATE INDEX [IDX_QRTZ_FT_G_J]                ON [dbo].[QRTZ_FIRED_TRIGGERS](SCHED_NAME, JOB_GROUP, JOB_NAME);
CREATE INDEX [IDX_QRTZ_FT_G_T]                ON [dbo].[QRTZ_FIRED_TRIGGERS](SCHED_NAME, TRIGGER_GROUP, TRIGGER_NAME);
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'AlternateCarrierNameProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.AlternateCarrierNameProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'OutboxProcessor'
           ,'Order Status'
           ,'BB8.EFContext.Shared.BackgroundServices.OutboxProcessor, BB8.EFContext.Shared'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderMessageProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.PurchaseOrderMessageProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusRequestProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.PurchaseOrderStatusRequestProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusTimeoutProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.PurchaseOrderStatusTimeoutProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusUpdateRequestor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.PurchaseOrderStatusUpdateRequestor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'ShipmentProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.ShipmentProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'DocumentAddItemStatusProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.DocumentAddItemStatusProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0);

GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'DocumentDeleteItemStatusBySourceDocumentProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.DocumentDeleteItemStatusBySourceDocumentProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
		   ,0
		   ,0);

GO

INSERT INTO [dbo].[QRTZ_JOB_DETAILS]
           ([SCHED_NAME]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[JOB_CLASS_NAME]
           ,[IS_DURABLE]
           ,[IS_NONCONCURRENT]
		   ,[IS_UPDATE_DATA]
		   ,[REQUESTS_RECOVERY])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'VendorInvoiceRequestProcessor'
           ,'Order Status'
           ,'BB8.OrderStatus.BackgroundServices.VendorInvoiceRequestProcessor, BB8.OrderStatus.Scheduler'
           ,1
           ,1
        ,0
        ,0);

GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'AlternateCarrierName'
           ,'Order Status'
           ,'AlternateCarrierNameProcessor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'Outbox'
           ,'Order Status'
           ,'OutboxProcessor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderMessageProcessor'
           ,'Order Status'
           ,'PurchaseOrderMessageProcessor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusRequest'
           ,'Order Status'
           ,'PurchaseOrderStatusRequestProcessor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusTimeout'
           ,'Order Status'
           ,'PurchaseOrderStatusTimeoutProcessor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[JOB_NAME]
           ,[JOB_GROUP]
           ,[PRIORITY]
           ,[TRIGGER_STATE]
           ,[TRIGGER_TYPE]
           ,[START_TIME]
           ,[MISFIRE_INSTR])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusUpdateRequest'
           ,'Order Status'
           ,'PurchaseOrderStatusUpdateRequestor'
           ,'Order Status'
           ,5
           ,'WAITING'
           ,'SIMPLE'
           ,638157959135378437
           ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'AlternateCarrierName'
           ,'Order Status'
           ,-1
           ,3600000
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'Outbox'
           ,'Order Status'
           ,-1
           ,600000
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderMessageProcessor'
           ,'Order Status'
           ,-1
           ,60000
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusRequest'
           ,'Order Status'
           ,-1
           ,600000
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusTimeout'
           ,'Order Status'
           ,-1
           ,60000
		   ,0)
GO

INSERT INTO [dbo].[QRTZ_SIMPLE_TRIGGERS]
           ([SCHED_NAME]
           ,[TRIGGER_NAME]
           ,[TRIGGER_GROUP]
           ,[REPEAT_COUNT]
           ,[REPEAT_INTERVAL]
		   ,[TIMES_TRIGGERED])
     VALUES
           ('BB8.OrderStatus.Scheduler'
           ,'PurchaseOrderStatusUpdateRequest'
           ,'Order Status'
           ,-1
           ,60000
		   ,0)
GO
