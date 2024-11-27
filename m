Return-Path: <linux-pm+bounces-18158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B29DAAA9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A252D164920
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A01FF7CC;
	Wed, 27 Nov 2024 15:21:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021140.outbound.protection.outlook.com [40.107.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AA1FF7C3;
	Wed, 27 Nov 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720883; cv=fail; b=a1vAlZX7/cqq2mrU8llhfvX89Ydzj2aOss3Bi+RmunVd+MQ6cP0aXj3yjwyvQQgEfEsFHycjcwQLSzcD/jMoEx7H+i8nesJhvdqPi+NMCAnNyBeIOqQOcNl5eVsVCBKoYAFg46YQFZX9L8vexE0tmxfXNrrlV75G/9+3eJ+aNNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720883; c=relaxed/simple;
	bh=ntl3Ac2N3ydEEhex3Bm8AtFI/jP9tVF2uHVpqAPaCE8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ITxch2aTBoI801oG997l9yc0vSgZKKcdcCtPhWY34TN/a/hEz1oOh5D+Yyh11Y8m4s1TLfbdzBM+IQNZyB6otCdGFDR7C7kKQE5gqD6Mok/F4rPdX5b6JvuTwNo6doWa1nQVch+yCJAG6MtquRSEfscMB56sJyUryubw+50tyjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeTQi9zgTSfHFp05/ae7dP7eOYc3m90rG3sUptRKwhjgyMWgoQFOKhI59FSEToi1HOaFUYjW53c/Txm4GlHpTQe1tbu0uDgkLrVkOK/tnSByT+vDivzG9y35FN80qiTODk/6nqm7CPHDbTXcKuhQYuWsJ+AvtLygNdKqha5ES+iXWdRrX94UiHclthtcsqTPX+1RXsiXdbUqetkL4rvQtYuwgG/PaYGHWlw09SQa+Ivt3tNEwUImGjPsxLZhstH+BpxOajJdPg4Fr9jYYqON+GHQkHCQz6ix1VZ7vcsNrPtnqAixG9Q/iJjbBSVQq8Js0osuS17sgzudQfrjd64Otg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERCylQlUm//ZxM9Il2XRos6N13JISbIz+fk0Mj1UXSE=;
 b=y3uf/pr/0S0ekLmb1kZXw/7URY1tyCfRutuOhzmbx7zPF+/SctAEPakA7R1zvp0ns5Qr7AwHvBIiBGSYZccsXfM4c6RJSoFTZMYZnW2PgLqj7fJhirDayZiE8lbY0n72czn60YdaQt+D0tSwQeHTU6eciWePBD+Ub00CfNUSnr5M/sg6/+EUug5B39yjVqivRkc5C98WuoPhV0ThARfJUGEadl5SalUIMIuTHp/lNSDvs+alUdtzT8pxXN/FQoTjOTec6f0zaCeSe1CsVSIpCdejBmLfVJcoYmhPeGP8GUTjA/IwvRrmU801hKKBcMss52Dx8lyiW3yHB52aqV0++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a1::5)
 by PN0P287MB1989.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 15:21:17 +0000
Received: from PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db]) by PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 ([fe80::c75a:632:1645:5db%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 15:21:17 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] power: supply: Add STC3117 Fuel Gauge  
Date: Wed, 27 Nov 2024 20:49:09 +0530
Message-ID: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::34) To PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:1a1::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1171:EE_|PN0P287MB1989:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b54f1e-bcfe-4812-1e13-08dd0ef72356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iQGE5oN2Zi4tsf1SsCgu/MsdkbiuU1se7cBMYzuiVjlCcgSk/uBtE2o4mS0f?=
 =?us-ascii?Q?8k+saj1zSvV0RGd1cktLOndt2xckCy5H0aZ8wYH34SEH14meKE7j3K85SQaL?=
 =?us-ascii?Q?7uXISJy77X7uwS1mgBfvAXbgpO6QTk6dSdCW5E56yTi5emguygVX9/XDbUHO?=
 =?us-ascii?Q?XHpgs01sntry4A6M1VpOc663Ii5UwCQxPFJRbDioy7piRM2g+D+/pztFpFOy?=
 =?us-ascii?Q?t5rKcLGB2biV7tQXkCP2jbn0oVFKkjS/zDwUd70A495nYhOH+8WZYlhy/eFU?=
 =?us-ascii?Q?vOWUPjMcI4tQwLD/3/12fGBJqvTxvbbgKGzjSvHTlhNAvBq5itA62bR7hKsx?=
 =?us-ascii?Q?zAecKLAVbMCK+Jyz7rP/zhGADWLF6+rutHyTUho1WitflFFL/qiTBYBEIvAh?=
 =?us-ascii?Q?pZ/SjDalgPKvRwVFUDM8YzPefjUJ9TIOUWPRUjRUpWlzuANoebunSq9Y6h+K?=
 =?us-ascii?Q?G+mpdl8fS611YkMORidntq+NfdkYtlQ6PeQkauglYCQHCOsBqbO6NnJeXUdP?=
 =?us-ascii?Q?O9slkh+bxOvT7nTUD2JHTs4XLua4+p+ZcXg6E4vD2Jf9WhjefAsKp+En4OTc?=
 =?us-ascii?Q?m0y7a2KasAFCnNLg94KV6t6lgz6reLnOuN7fqs/RFLIP2WKhkimHGryw0A6u?=
 =?us-ascii?Q?GM+YvRD78TeyJUOABh1lAwPV0zrVxLrRMCxv9dnocZo2ZremZCrgxZhLZVdb?=
 =?us-ascii?Q?b3G2NyOLztH8mYajLd5K2mFrmyUjCdlM4/0nmBLGLmMPq6i5z86LgDg102ue?=
 =?us-ascii?Q?zaRxWWKiJUpAaaNZpkvV5OjWpeT1Pf7r8hhbE5fnvDXbNX3FbpENjQ4clxTN?=
 =?us-ascii?Q?tBPLuuj39EbWyzK49JbtKrWjirpm1uE1xOUTrjhL5ZlO2utKHJq6qFUxPI/h?=
 =?us-ascii?Q?nwIRfFkYuWZNnYKNCqA8IAoDEz0bx6Tm68NkSFNykJddQxnYrs3UWnWQRAn/?=
 =?us-ascii?Q?ViR6Eqo0i+/AV80a9Wlr+riv/B6M9WZxXqEL7NwdokIS4srdz/nc9KCSSJ8T?=
 =?us-ascii?Q?vToAoDeqsTS7i4FAcmMJM87CbonRRsdeh49YgVEk9k7B+LVXbELdjl7GIRPN?=
 =?us-ascii?Q?QyiU2CugViRNd+wz9shoIV1T5AJPW9/yG4vjoQIOI3Y1O+9V0LbtcOWn7LPD?=
 =?us-ascii?Q?5fO2P/p5IIXdFOdGcXoPDsXqGFXkTzG4kr2fOH80QJ3p93a8BC0B+YRIw1ka?=
 =?us-ascii?Q?laBf8LxQ5AgAWTNY0ak9jLvoEfsNwGLsEZbvmaKW88xcLN8Nv4wJn/x9Ya/W?=
 =?us-ascii?Q?SwyoeCmEqDro6iH09nwDAQiZ0Jj5AvG/Pc9/KYIQns+Y3Zb6QSwRwJXvRKK2?=
 =?us-ascii?Q?/tJ9tdz943MfDU3rqezSiGtUC1q8VYBvjmibzL9qhe06kvruHsUUvYSpS+xv?=
 =?us-ascii?Q?oIdCamI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1171.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2KEmtB33UXB0bTRLQ04d5MiPt5c+oPbvfhY4RcXrRf+ebyYnaJ8FIEzFDSW?=
 =?us-ascii?Q?WqRtVs0ha73kflVspSk95IlXkSw9N18eurANwWceLANWyU/mb0YzhxSqqjiV?=
 =?us-ascii?Q?sjJcjdafj5jzthc1X9hX3cA66pPefrLQyck8FAKl+jKmagTrvMfyhYaBMLqx?=
 =?us-ascii?Q?a6uC0BbYbBeGElJqNE4+YVMsobZVhdypk5qcYYXM1uiAd12HvAPnBqRkwEhA?=
 =?us-ascii?Q?8+UveSE2sEhXD0T/yLcIXPyumpYw4d7YYMGDsZlut8k+26NMPgiCi7/0aY5q?=
 =?us-ascii?Q?86VuJH2aHCvPC/5EU3ZoCfoxUl7jAa7bmsopQ3zTSYMRayrxgOZGoo4YFOEl?=
 =?us-ascii?Q?uGCfU/uI3HtjdPyCxSFjAr5KyRHXxz4wivpdYdS0iN0O/xQHEj/iS4rkLek1?=
 =?us-ascii?Q?oSB0SQ7E3JI1CRlK6wcz5b6xI7kKXVjcuuu9vK6VF30O7PJtroLI15Vdf4F3?=
 =?us-ascii?Q?CP6XuFhb7AIC0K1pvdxfOpcgHSl1Geme/+12N60LBqSSAAOkjlA6r+NpVmoS?=
 =?us-ascii?Q?iK7rKiJe8M76Wde3IEorecRXXlvXhbt/RD7775CEduTsqaexD6xoDaRwvR9J?=
 =?us-ascii?Q?txHxx/P8SlzV8rQ7xxiORgbCfZdDcKnLlOR3qZqA6XNEPq33d5WEVHrpnhDU?=
 =?us-ascii?Q?U7twBKXqxRLJF57j49dOFi6V8S05GiuuZRT4t23hflFrWcjpDvtO0Z74mMVY?=
 =?us-ascii?Q?50PrDQe2mpVAB/geIt5gVY1ggFVRzaxPPImg9p/Yox7AG6X5AjDSu35BbGPH?=
 =?us-ascii?Q?lYhV3NenDYkddzBYOGFfT5NVVjstlKJG/MoFFHvV+CdD6HNTXjhmI0GN6r0f?=
 =?us-ascii?Q?6H7HXgYbb9KVW07SAizZb3Fg73oZ3XJ8y7dZpILMdeixnl4rRP9HlUvLmjeN?=
 =?us-ascii?Q?3/7IQIRko4KqC6pC11KMY+PufcQoqhVOv/0JR3FI3eDpUg4CKNKE2rOQ3bet?=
 =?us-ascii?Q?W9ETgBChustYlmVVwF86hWdXMPdpc1liaV8qWLYyaHqxZ0PDJzR4UqceaoGL?=
 =?us-ascii?Q?4TGb//1BuLJsA3sGi9yHdJ9fScObwj4cvc/5uAdCM7tLE4oPEGP2yjFJn32X?=
 =?us-ascii?Q?9TXxo91XBJIC8llcnHvx9cbayLpjqhEA8EVeWyKaZvVt7b2kUn8QImf0zjgX?=
 =?us-ascii?Q?pjhrRTi/GRZD30aH+3BjAvNU9t3HTEEIA74uCI1sgSHWY5CEMBIijCP2xb+H?=
 =?us-ascii?Q?34Ex6Rno3hl6c8pUDrg2u7t43/fJJtWHlnK68GNwrbEsyQ4l2Dy1dLD8svZV?=
 =?us-ascii?Q?Mldh6g8Rgih+MIgNuy449k9bHADWnvMwoEE6qoCRkqYjxy8EMv40oL+o5TFD?=
 =?us-ascii?Q?QaAkdbqsMTR4JJ+hCa+sTYlASwHhQuvL+a+p+2EXU7lqw6rNwH1fWlFpYDjo?=
 =?us-ascii?Q?OsZRBIm1/mSbTnJHOB671XnrkmSeJRd5D0vy0AL7woyksZAHhYgD6GSQYDIH?=
 =?us-ascii?Q?9o0dSLAHA+ENGyxtWY1k1WKESwFDbXmAo02mEMEjJ5OeBBreboMucHRS9y18?=
 =?us-ascii?Q?znwhiC9lzNvDMqsHzQx2//+0NGtDKONe17IYEmAPQkAtYkL9jtEHR8CAyip+?=
 =?us-ascii?Q?wQrAWeVQfQilWzJxfEB6+GjB1bkZympSozvBq3oHy7uIFAGZZjN5xcmDcggn?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b54f1e-bcfe-4812-1e13-08dd0ef72356
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1171.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:21:17.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6N5MCN35352iMlJn21ZGkck3IRoA6ZuYe5822+h5ywhaCwYalii9Vxb98/YoZpIwux5CcX9OIyi7VNktypY3nkYfdcPvn+mRT6wrfyNk0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1989

From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>

Adds initial support for the STC3117 fuel gauge.

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

Bhavin Sharma(2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  53 ++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 625 ++++++++++++++++++
 5 files changed, 694 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.43.0


