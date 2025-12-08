Return-Path: <linux-pm+bounces-39289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C4CABF87
	for <lists+linux-pm@lfdr.de>; Mon, 08 Dec 2025 04:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3286C300D418
	for <lists+linux-pm@lfdr.de>; Mon,  8 Dec 2025 03:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49392F7AC5;
	Mon,  8 Dec 2025 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AiNXjVIl"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD052D0636;
	Mon,  8 Dec 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164930; cv=fail; b=EuO0LahbIGjJnG8/u2FHfIUGuBJKTSshMfxWY5WpccRX2DsRjl7aWJBxYQ9onQEWw6TwkqudpzhhG2/1YJFk5r4UiOrfRI05v4Yeq7dB5i/XwXIALlf5Wwqq3bKOAAC2+fP5jj3Ur6wkaJQtlTD2oAbhdpsp+XAJEBRbFrw2hd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164930; c=relaxed/simple;
	bh=X0VxGm8HM21472jVH/rc0Py542T8lacLiffvY2Ikz60=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K++uvzU2vWFTgTFBWZQ5t5dxLYH9mVD4Wn7zfeV4zomNaBAzOXbZ2bJDx8+6Uptde2XrH1BnD2OFnsaAQCavoZx6TO+dIcVTtJ9EPCUEXQghJuTySPJcn/6/Q0FEhqkDSamVsEmsMC3cSjiGcEa237Mm1qghSS7mK6QsZQv7t38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AiNXjVIl; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS2BsluTEVviiYyvxYKehW7rbjl2GsQ/iB2i/cxEgYHC52QxekCdSTb8P33fpBx1DPGl28WgzvX1ruVVoHlLC0lV0D7uL6bnxpV2YdH43/+TGohT0CO3W7sbn6ieAL3D3ovWZcE+6anvQnp9IdhoFEKRmMwbN08ZR2MpedXDsplmzTVXZUOBNKiCabK5HKUmEalj/kWKoBtvAlOKuuHIjktovkG7XneLMY3Pefy50a5D7APzVkuJaenATbfYixkI7HF/H104AjWfCWsIky7kU1dM2HSRlKmeoqTrvokXa5yyYHNrWaHyZIxjG2Ccf9U3MzBGbI7c/s2yYi7qw4uYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJuHoRt9zy5jdNN/nFrgF/bDM41iP+Uz48GeAXnwwn8=;
 b=MQTmRJ36Gj4yc7Kfhzq5v3ZglS9v0B8JcjGvOTyz4Tv/0RKaV+IeQm/nqSlxj+HiE/U2qxQurvf5vxaLQnP/bjH4dL6Cuu/j2iyx6fXD3fV2xWArdi06FSrxDLKVBOUDv/ey0z+c3IfEOmRZMAPENZdoUr6ey/lEqtdUL3WyDs2XCC66wfjy6H/S3NmyxTIbAc35YpewDXLhhayrPvVFVbX/S5SjXrYgYnyqD3QPyEu/ZdaclWvID6IVb4wg/irOkdTk5GT5BhMX5aSjBX8uBbOi8DjM9dwFJggoehDwFLIKB1LJ6K3tu+NxZDM4jilbUIxqh9ujCP6fJ2iDg091JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJuHoRt9zy5jdNN/nFrgF/bDM41iP+Uz48GeAXnwwn8=;
 b=AiNXjVIlN+0JSXSjM1L45Zl3zGNE5ueBs811kwsUwYykuuZ2oEqMqN4SDZXSWS2sQi6hTluv+/ZNot6mr99BUTNd/ZMgB1ieQgbXjnWo881KkTqk/v4jpOlYFJ2kXkFTty1Opz1HLbWKBEsOiChSM4iCT9tA7/CWOsYtrjI5cV63phR4V3RzlmLDVso/W9tZmOZPu2cy6fmDAW7207qewzE6KhNU2oAlPhW110SFehP1s1bbdFUx1MLf+fuiGTcP0DHmGK+kJshYfL1Kdl7RhjHu5873tkfpYVlemXGYkHB8GP0mOJojf8lF8PqrmMKRaZyYKxelCzWJphwQ1Cw5/g==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GV4PR04MB11732.eurprd04.prod.outlook.com
 (2603:10a6:150:2d7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 03:35:23 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 03:35:23 +0000
From: Carlos Song <carlos.song@nxp.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Li
	<frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: Report one issue caused by different return value of
 pm_runtime_resume_and_get() in 6.18
Thread-Topic: Report one issue caused by different return value of
 pm_runtime_resume_and_get() in 6.18
Thread-Index: Adxn8mutXiqzku0WRw6dLZ0467zAtg==
Date: Mon, 8 Dec 2025 03:35:22 +0000
Message-ID:
 <VI2PR04MB11147FFAA0C0A4D8F56102967E8A2A@VI2PR04MB11147.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|GV4PR04MB11732:EE_
x-ms-office365-filtering-correlation-id: 364e02ae-bebf-423a-f65d-08de360ad1cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YttVMYX8hYwfYnUpLQq6OMbDRtCiMAum/TRC0xDeG8HlMVMbbImUEZXzH/6G?=
 =?us-ascii?Q?NKRKSeG6NVoOjtBPJWjFN6nU3JwBBavJZXne0bLcktYkS7dLNtUAARKpGEry?=
 =?us-ascii?Q?gSnEAPFn9mBnlB0Ds4+Uqy9nHl/9bFMnqWQONEduzBMJMY/L5RMwmpVOHSPi?=
 =?us-ascii?Q?rmHFec8Go9uu3HZhucMBi0L9rgQ8WpJvPsDe+zb/S7YIy+A/F0S/J+2M31sN?=
 =?us-ascii?Q?6LRx2GyTe0emvWfY6HIXQ9HS8jdmsuqnEByY4ytyib0mdUDw+f/bWsrO141Z?=
 =?us-ascii?Q?bGTgZw8yrYS9OnnKc3LIexzWnX8sOAGRmm+SIuLae34zsGAYl8WShNjR7E6m?=
 =?us-ascii?Q?nf2gf6ma+qoXlZNqDr6fd1EqpyubAW6/f8TX+J+a01zroavzAU49XrDfyoy8?=
 =?us-ascii?Q?ZE85LNUPwYINf7Z4i2hoFOZ7xDsnY4IFDjz3WNfNbJSQf1qRnTYkMFhKpfbs?=
 =?us-ascii?Q?3T0o02KQDsVoMn8ZqqX9Sgkbo1U5SxX4fX+JVq+clZAfKeQAcCpKIMI/4ZHu?=
 =?us-ascii?Q?OjgYzDa/BKFfDhEyC9hxDWZ1BWsSwyxY40gS5vTMCHHqPhPCeTeHWOYTrNPo?=
 =?us-ascii?Q?w3Vi2r3kuqOmrghGSwvwthdNXII22EwF/yfn2nKZM2nsfPiJIfSWN0CFjHAV?=
 =?us-ascii?Q?MtN7uvKjFqtJkVcb11NDAeO3AzQ/CsX2VeFefOU+9SR1+x4H0RIyro2xi/6d?=
 =?us-ascii?Q?OLL+uVoOV8PSLtTDtvo/UB3BLkF1JM1iXVZUdxeQf4NOS7YgUCosQd4RjYhL?=
 =?us-ascii?Q?kEkESMDkB5SzBQxbjyXnZqZC4twRA1H2XkHRUlQ8H1gOIekZ7cGl+eTeIHO6?=
 =?us-ascii?Q?Hp67/fBu+/v1yw0Em/HKEaJLRYmLQD3Yb7CxgXuo07hFsmoFzTFIuRwwZ8SQ?=
 =?us-ascii?Q?VnxNTdPvA8OtptFJWpUqB8nM3/adwNZN0x6MEqwxTHI2f1pH7Z+Q5vueZ36+?=
 =?us-ascii?Q?wpY6ZyLGUC17qtStUuzh7e8Yw3J+Fky+pqThVVWMmEe8dLSK436OYzxW8zsi?=
 =?us-ascii?Q?HPkz7ZJ0bPv58YuqBz5d5X3zrAiFwtiJxAKgvozfVf6rgCzAI5mTCR+QtBO9?=
 =?us-ascii?Q?LEK/WESJqVmGJRSFWSI8u4wbyF324ZnjidyZ3JZDQpp1a/2sHwWgSeVcJVm9?=
 =?us-ascii?Q?rdZse3jBuFbQ6B4tBsFSWh88JKRO5CCVPifNX8QlpOl77GvxmLvlo/p8E8WC?=
 =?us-ascii?Q?gw51OJ60sQxzJV+8M/iVLBbpzTRAo09gMeqQpZrnhnxVNI9hgpId5QE4NzXU?=
 =?us-ascii?Q?6osQtU+whit7YAZ2rbdoP9gEGxayIDMqhUX0voZX9QM3DkRa9zxsPQoWOwGd?=
 =?us-ascii?Q?XFPjeUdD3ysQ1KqzLrDwPShH7PDkcXPER/djWau5trzOUQIRTP2wA+cypTlP?=
 =?us-ascii?Q?vqGTUiG274SZaYsoh7AcFHTTG7/fOHtG6ExyppjRGbgi3T5YafUuKlkbV8bs?=
 =?us-ascii?Q?t/WEoBYa578K3MaPQiiUOH79fQeIX9XB+YAx8AnwfYFBsswRHTFG/iAdzCQ9?=
 =?us-ascii?Q?+Dd1kICZFVSCnAwmeKpSLWzvnzmocjeh6E20?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TatMwAnn1wlE/mEtOE+ab+vPTpHSz3PEf/2kYmhAjMd0YYJrIuwisNepVGwJ?=
 =?us-ascii?Q?/P5m9gDn0XByCHdOoFQ0/Quzf9y1+zKgKhx8ZKIq+1LGaGFasWnHsHbXYAGT?=
 =?us-ascii?Q?7TFmyZHPnYX+mVZ4ofb9W7FYMyzJAcyc/Lmall4dUhF1JzjDseMM4gHOCZ9r?=
 =?us-ascii?Q?FZnBRzlRXefcn272M6F5ZoNzO+QWZxrNPI90Wn+aT/+bpa7uTAv7ohFK3Z3W?=
 =?us-ascii?Q?23qmMd+DHGSxHd4UaimqsOtiEdJQliO3vXH/W1Y5UjD3zYTdhDtMTj7c5Umi?=
 =?us-ascii?Q?KH8vyEJLKJCr69HW/2g/kagOaBHMaE7cTMgThDnmbcstgY1/HHi3Z8OxjMfu?=
 =?us-ascii?Q?N/K6EyzLlq/RYhYMP6/q4cYTp3ATe711XhhmkMCq2jDVRwOyhDaOT010J5fH?=
 =?us-ascii?Q?CaZ6SrZ+lU4oUigOqp6H0uxyq+W54QQ6Kwo+IaISy+E0dLLI5I64dghEHZAZ?=
 =?us-ascii?Q?lPGJJTBAElevOPCFz1KD8BlFAVHbmfs1xTyOOUJ83z3MNBzA07TbXmJFFIYJ?=
 =?us-ascii?Q?FHKlCGkmQmJ50XXyrnB1dWYGWZBLU0N4SrbJz22/7fecJpMqvBOCJiWJApgE?=
 =?us-ascii?Q?LyQzlZItqW1zYmZU14HwwmfcngWF/70Y3lEHJRguiDdD4Uq01FACXzvsq3og?=
 =?us-ascii?Q?vZh8PoZQaK/VeW1hZmtcMu2OUhhBljMdEwIGCOFXH+wzhV6e/EhbZRPHjfBx?=
 =?us-ascii?Q?GuDdPihu8B9X0mGQetYJiLG8tbtH9K4mDlQxDNfUj+16XNRpjciV/dxp6hOB?=
 =?us-ascii?Q?5SR5nI7TZaN/dCE8S019HuDkg+NVbPsDy/XtYuGNHP8o3Q7qV/RZrc9EJFeF?=
 =?us-ascii?Q?eG2HOc8ovrwQUhUIZigSCL13tD+jI6OqUuhGfXbJ3J6No8KeYd0mKPTyBbQ8?=
 =?us-ascii?Q?e0Iqttlk/mBSudiyzGynvMYscMCYHVF4Tr+y6EBjzOSO53P4AgoTIBcsjZ3A?=
 =?us-ascii?Q?Db95uYz0MOaklfp+iVYb6nzILzM2C6fk3xF4xqYBLRCORMFX0/7ixc+8TzOz?=
 =?us-ascii?Q?TYMDhEihIWEt2Iqu/U+1alUArk00r1VPG5yFW73aIZ4WR9gL7Rv+IvD6jRXS?=
 =?us-ascii?Q?/SgXm4IqVrOOQN3VKC+xSc81OqGI9WSzIY4i8GrOMKVfnUTWeJNCAFdhV55N?=
 =?us-ascii?Q?lFEPkSiM8E9S8KbtAZWekaBx5GU6/iGz5qIumCssy7JIc9NazE4cOyGGY8d8?=
 =?us-ascii?Q?6XaYnNcbOQbFMkyuWBwvQbjGQ+bkvGRsiT2HxxpOLZuDaHEq2KqWN7yno3SQ?=
 =?us-ascii?Q?mgcJb+rEBPcnh2E+9cDnKbteX8z1ynYVUaoLaj1hZv9HLYTUchQUzDVVfaQ4?=
 =?us-ascii?Q?Gnj0nbynUBXmz85IkYQM9iUvG6lSmCKbTbIR072IDNdLk+NOZcKCgMBGc4XG?=
 =?us-ascii?Q?u0ma7qpweWxBv3pGpFpj95OnKbaKivlg1w0fLRk2pPciDqIfpnD0gTXqSw2h?=
 =?us-ascii?Q?2CaHfUfypEHKwwEoD6OaptbqAjKkrPjGDEgLdq/APYsGYQCtpNsvV7UNkuzh?=
 =?us-ascii?Q?UYPqAczpNXs3Hv+W2KD6isExZJ84nRiR5Q7mXOC/UKrFak3RztYJOK3kjcUW?=
 =?us-ascii?Q?faUwdLrNOyHhXLWzmPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e02ae-bebf-423a-f65d-08de360ad1cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 03:35:23.0448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXpwmdkcnjnVCRSivsbeN89hkhiKDCskV1k5161e54wnsotLXQzI5MDrhrsRg7P33aTvDysfuepMqPkqhfNmIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11732

Hi, Rafael

I meet one issue possibly caused by this patch set:
https://patchwork.kernel.org/project/linux-pm/patch/2336655.iZASKD2KPV@rjwy=
socki.net/

I found pm_runtime_resume_and_get() function returned different value after=
 pm_runtime_force_suspend() in 6.18 compared with 6.12.

In 6.18: pm_runtime_resume_and_get 0;
       pm_runtime_status_suspended(dev)) 0;=20
       pm_runtime_enabled(dev)) 0;

In 6.12: pm_runtime_resume_and_get -13;
       pm_runtime_status_suspended(dev)) 1;
       pm_runtime_enabled(dev)) 0;

This issue happened on IMX8QM LPI2C + PTN5110 typec:

LPI2C need to remain active during resume_noirq() or suspend_noirq(), this =
patch is merged to i2c-imx-lpi2c driver:
https://patchwork.kernel.org/project/imx/patch/20241227084736.1323943-1-car=
los.song@nxp.com/
LPI2C will depend on pm_runtime_force_suspend() and pm_runtime_force_resume=
() to make controller available until the system enters
suspend_noirq() and from resume_noirq().

Typec will create one tcpm kthread, tcpm kthread worker may execute some wo=
rks at the very end of system suspend or the very beginning of system resum=
e stage:
https://patchwork.kernel.org/project/imx/patch/20251202084524.208045-1-xu.y=
ang_2@nxp.com/

When tcpm kthread call lpi2c xfer after pm_runtime_force_suspend() or befor=
e pm_runtime_force_resume(), because pm_runtime_resume_and_get() return 0 i=
n 6.18 (but it return -13 in 6.12)in lpi2c_imx_master_enable(), so in 6.18 =
LPI2C will continue to write register but LPI2C ipg clk has stopped, it cau=
sed system hang.

How can I do to fix this? Can you help me some?

Best Regard
Carlos Song


