Return-Path: <linux-pm+bounces-18233-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F79DC2FE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 12:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB057281BAE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FF199EAD;
	Fri, 29 Nov 2024 11:43:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020077.outbound.protection.outlook.com [52.101.225.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395D17ADF7;
	Fri, 29 Nov 2024 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880580; cv=fail; b=ZC+HkSoy+JFW7c1UDvnnm03qdLm1d8HAa656mywYQIqlETDmR0qm5b892sIOCAEmFqO8ZfHyWkfZTgIk8ArJZMlTVnAY+Kc9O970ErC/pCbcykrboFhyj3CRKyzH27ffbYZAo60caPEwh6Dwj7JPA9FTBUNkS1UpPzXbNhLYHNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880580; c=relaxed/simple;
	bh=OPFfpqmoD7RTj+WQcjlqeDxFOGDGo04NRWe/wLqMNj8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WTqrpNjnwNedkKAV6EQ3irDuor0q3zlVFGA16Ka6q6E1tffiOxbrrAd5OxBwUNy3KoQki3u+1YesmkICaMUW8+C4Bk9U/yv+oUVegbUbUq1bQ5m8fMydIHqpgiCEDww5sTwvAxBkFvFlS/eFix/UuDpD9RWaMvkdEWTAS9Qt95Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZAGVXzMj7dQJv+3/cFJvcsKFVDKidR4/YzwJ9C/LcXH/+4peaRjPLAhDq5XqCAiKgd62omqU0im1YvvrdTbmIlRqXU4C0A1jTQf0D5xX6rw/ucHoW4/U5D2C250eudmlGRZr5s5nSfeWh4rsk5+wbiHDNM8LVhJhopSLIHP+Hy0m+yEomy4Y2Bfq0QOe5Y71WGb15OqlxWOnHIqmuGGdoQKt1M2NsMXto4h8O7gS85F4tMceai/zNUJXo1rMzWNPMsq3hlgdQNpEloqL4N2HX1AXr+XYavT4rMefY7NbnFa9Bkyp8do2ag901wFVRJGgPR4j1MBLfZfaRBx2PPK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCxM7qnuDpOC+v7MolssopxtPN0HdLuXcRiL+rbePfM=;
 b=YrYzuwslP519Y2OM9XiRcDIEOfeZezoUUrM/BUTth/1eYBN+k3jzFbYcHs+3IPmT6UupVQPBf0RCmyO9LK4C6/T5TwAmNyEtqjgfC/2B+mih1UNYeOeSiW5Bn8Z9WX2Qr0HewoABAkZY7Lng8C4LtTIHJ8dCIus5zVV53IMPDO5gtnImDqSNqw2kQ/lH7xzt5873J55iF9/KJY01fiXHCAqZK1e/l9Qtj/kezJ6cp5s5OcFk7d59chYl1qTGPIAO5xNQ2RUcjsj4RlsdWTFJvrUpnkABpX83e2FuYx9JzDMxtZ9yIo/X6CIcdMMAKV6e3N2ZvVDxSEAmclVcTk3VSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN2P287MB0599.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:15e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Fri, 29 Nov 2024 11:42:54 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 11:42:54 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] power: supply: Add STC3117 Fuel Gauge 
Date: Fri, 29 Nov 2024 17:10:44 +0530
Message-ID: <20241129114200.13351-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB1178:EE_|PN2P287MB0599:EE_
X-MS-Office365-Filtering-Correlation-Id: c7956dab-905e-4e12-25b9-08dd106af629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5rv2aybUGhZXK5EUbjNbPFxUgdGaSQliN1yBRARHZRwalsqVyF1p3cCGKL1d?=
 =?us-ascii?Q?1vpnj5TV5Fs4QeYrm/0kclmgQ1VAXvz2p9ZQ1qFACj83sqsHF6GgJTM9a/jM?=
 =?us-ascii?Q?6YXZUb1i+Pi/5ap5O5AAx3oCIQojGw1cv/QuHZkVIWb4oU15ej0rXFwUNEZc?=
 =?us-ascii?Q?AXi/+r4JA2YHnfDY3nvBMhBqKV41AL4lXHP7SKcBUNKm2L791NnnCrtkFaRj?=
 =?us-ascii?Q?1R0xzoC9+JdF9ZeapHq0Usuo+V/ZeVtsxOkYv1bnRmxqVM5QTqLhNWOGsyTZ?=
 =?us-ascii?Q?m5pOzGuaFrCBU8GFMRGgwKJvdE7MCnpVUl4aQ03HETBbRhARqosq/ylcMJz9?=
 =?us-ascii?Q?5vbzUlNU8SI9NNwwG4ULetb7PW9QFnM2BeTfOAQe/TiriGmuvtpAzeTmoJbL?=
 =?us-ascii?Q?pTmgCdp0I20DBPy7xWuLHQE+W60bglk64RVxBeKpWtJsXbhJt4TZ12+Ejw/o?=
 =?us-ascii?Q?h960edb6emavP0TV9JkUwYvgMClBWYQpyzm4d6z79wLmcUASipKf3Bs5OtC2?=
 =?us-ascii?Q?L3QNbJFXJEh+WvKSKUAlQNWOGl83sAVTBNB2NpVyi1v8SeciWPtfjqTy0yBm?=
 =?us-ascii?Q?U0e+/XQu3CCmgBed0ZxHPYK9dpR3y37W702TqJ5wkz8nLTXR5GXgDawNstrw?=
 =?us-ascii?Q?i4/D18r/tivDzqf0JQ4MyHmH2/XRZZ9I2DE4HPf9DOKwDHeYs96igG87Uzo3?=
 =?us-ascii?Q?XJbCuoy4cdKlIXXdxvYi1cz9RnC9VhZKrj/O+sv9JNNYiS1MAnYv81uojXup?=
 =?us-ascii?Q?7U6FeNxscfn5feg3f8Pwf9cR8s4jRzrXuXD0HK3cks+j4zgvpAioS3jSdIEl?=
 =?us-ascii?Q?uZc+1vhHQDzLSHpvbSTQyoHblfEMQN7Am56huct/21fxwhz3EjFiCsYIOwb/?=
 =?us-ascii?Q?wsm+mjVxI4OXMp1MijebImG/XDkP7wJcAiPnBz9SpEKFq8zyYnVTUGSjdRf2?=
 =?us-ascii?Q?lbqoDcBbS8icEbsI5Ip24GiRbJsOPuq15kDVwG2V3Wmbl112hzjEkgio92eu?=
 =?us-ascii?Q?6hx//pMCGQsdG2nhVsl/kzLuFIK93Ix0m6oUXGzFlbWPLB7keEqptWXdxFkQ?=
 =?us-ascii?Q?ILYfFm57XlRn4GlWb2U5NdbrrO2ZTLCZ8gpJbr1mkoyEUxW0zattXu1NcIL7?=
 =?us-ascii?Q?esqZ+b8/ep8yWEZ8FiGr6UROjW7eabHDgr62txbsaF8IEYjkFjdK2Wf3IVdf?=
 =?us-ascii?Q?FsJOHo5Kh8wCDCUkurr/Cn9onqRPV/YjsgETm8CkmJEiU2mxmxW8X9c/vP1t?=
 =?us-ascii?Q?o/afvZxGh/o9tlLEpeBx2lAWT7klXGgcqOCyn1j6zC0KB4aA7n2/Zk1+WSxA?=
 =?us-ascii?Q?OTAqZmCJMhj5dKuEi+xfOsAi+6S8CP/ZxlFDRSwCwznb728wCX9iXAAo1VMe?=
 =?us-ascii?Q?/KagYO4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amHzogDsAAZzz0PoVPq04VqLTe6Y+fyvkPur/FpTSPKQM3crH7edMHFFCZC3?=
 =?us-ascii?Q?cVgIjxCoXOis8HjB944/7uYeaLlsN6snWpTknaO2g41HUyVndJCJuzGJDd3C?=
 =?us-ascii?Q?XuY3n0O/bEWbNjCAnwj5X2ItdtayCDk8NwQjGqFFyJnOwKdIbV6d7Hf41gHp?=
 =?us-ascii?Q?qdqpbxU0wV2cBgnTk66WGiN0DtXK5mHXHlDN5Yz6Lo+pvl3tKqXeGzk7phtA?=
 =?us-ascii?Q?Ljdoj4NA9qP+F7BXesKn45ENril0W0q9/xYPx4PKsnS2uG5I2fTMBAZPAdIo?=
 =?us-ascii?Q?quYQUxpywrOREKQUHXxXMztVC+RTxWTOZHxGvTNVXUb16VJJZ4YzANAoGEOD?=
 =?us-ascii?Q?rlkOs/gH4Dt1CqHK7+UdNHHdew1UHMwNCNWDJghJo39a12TyTJIf1Wtg9cQ2?=
 =?us-ascii?Q?niL4QKCKRmp/FYp9JVjX+O8WdvVPvrL6gIyyepi/eoSojcVoFqItBNJoteg2?=
 =?us-ascii?Q?NvRnG3Kg7R1Rg1zcUL5MpCRR9JNNEAUHTO4caGPn4jvXnmGRDLcPPKBBPgbn?=
 =?us-ascii?Q?XMNQnBqgJU2N/X29f8OhJN802k3YNWy3oCi5vCXLOHR8b9s+Bs3rj7nd7R7H?=
 =?us-ascii?Q?QjIYH+LMOkCpAXrj+7oPK4gRIDEmoaKqb14fBM2AKXcZKcUmJFD2yxLnMx6C?=
 =?us-ascii?Q?3XoiD9I/i9Tv7aQXchzS+xYBDmbkvL8oy4vEfgpWIDrCATkOiRtftniw5esF?=
 =?us-ascii?Q?u/KfgR0XGx9QSpo+g/KxuVBU5lP2+MYAHIFlS1t8J7boVlN9AaR2NFbdNydA?=
 =?us-ascii?Q?tskkci8Y3YtVL4LUkGJyJOTBjPn+UPxvADxRJ9JkDkB7Hq8KItQDd3wNS10I?=
 =?us-ascii?Q?UVEa2KXbnT8HGuJR3m4gUqSKHMf7Ys2U5y4d2pbYeWG7X2ljnkUlyjuEDy8e?=
 =?us-ascii?Q?5qKP7ikZkuDleMCwfm0EXBSkCCDI8FMcnqy8t152Dx2+rIMdM2dmWXPM+KVX?=
 =?us-ascii?Q?HydwrnhAkfIQQ6wW6DcrvtO2POBHA0A1nMj7hg3L+BK8HytdzHHbHHMbi/lf?=
 =?us-ascii?Q?NdGU63A3U4tamCL0EOHTWEpQf3pFl1hf8W7tZdynfjEbdkVmTPkDB/SMXcGg?=
 =?us-ascii?Q?IRr1e5kvcqKkyYFutJeWMfrJ3yiu5g7MBksAT7UqXDqhQsU1EnPps3QVYH/s?=
 =?us-ascii?Q?iUDFHMUYcT9zX+IeRuqSTBkuNsJpAKRygfYwRZ/yS1Dr/vF1U6kuTGnlAFTe?=
 =?us-ascii?Q?cRRqta8za05RAygGDppf9tXiRrIAlTMsO8zACJ1TnXd3pT2zd+x4gi+OgVTp?=
 =?us-ascii?Q?BrylZInDmTRplM/PaNYimCH7tH9jmHzCX6SNsztd9bnB5oEwJR45EXeOKb3o?=
 =?us-ascii?Q?u2VvJeIHV4u96bn4ux2ZPTFEtZOJ/e7JLZSRldYkragFanvMRRHa9W0xh++s?=
 =?us-ascii?Q?33rQ9VE6g5Ka+VYwPvDzx8IQ/Y6ZtG9PL7XZBcVHKgokmadJhR9epZXOdidl?=
 =?us-ascii?Q?rxZSPIKRQJrCquxalJDSO0Yg1I7NDma8zaOTIC40KEZQkBSFVbE9a/C4r19r?=
 =?us-ascii?Q?H80kPeLzjVSZHkeOH/OybO2GhCyLnTdBQnpX5ipceC+JFkja3ECmaQHVTzDA?=
 =?us-ascii?Q?hqvQ9/5WSMP8l5Q4AfxGVxy8uw1yudTQVFkawaGIH/TECqmVkweDUQ0utuW2?=
 =?us-ascii?Q?30+5DlzHGHVd+E2uOdO5yBA=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c7956dab-905e-4e12-25b9-08dd106af629
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 11:42:54.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0pAYBAA7EnZRPilprxs0RTCgqvBQv0Wnmqsf7UaXBYvqjv2ohqTQ1vTrhEvKehDkgJyEcN4QBINj6vfP+/rwXPC6CKc85TxfAKW7XmUedk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0599

Adds initial support for the STC3117 fuel gauge.                                
                                                                                
v4 -> v5

- Fix variable names
- Limit code line length to 80 columns
- Add interrupt and monitor-battery properties to bindings
- Correct error handling with return dev_err_probe()

Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t

v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t

Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge

Bhavin Sharma (2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  81 +++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 665 ++++++++++++++++++
 5 files changed, 762 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.43.0


