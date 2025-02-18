Return-Path: <linux-pm+bounces-22317-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12EA3A416
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001E11894112
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80226FA79;
	Tue, 18 Feb 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SC6PMfvc"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4126FA6A;
	Tue, 18 Feb 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899401; cv=fail; b=cl0aWAWq1sP7OAGet3kE69EFBi4LVKOUVSFibmQ26nN4x0EyuE7FUnEWRpXW6kwUyHIl5w/54rWQE/TczNPeOZr8TessrQzZqhrLf+kjngDrqK1LH/pYMmLrGClKnFhEIc8EAh9xQRKtPK7RmI5Vcg0padhfGyKlntZH7GVyGRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899401; c=relaxed/simple;
	bh=OWzjANGm+6sNeXCYpPEW8gJygYuaF1zETFCVvahmdJo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TjGZncrf0s9T+2LrUO3qOtSb7sPqgC5fjk0dMa6HQsrVv5KW4KzaLUd7VCyhynXwoiNJeUDTpIAHaIL4dtEQU9sxgxq4ltffe9wMkdPCgEHOwY55UVawWwM8NiAB/XIGML6/L6rKv1y8ZAUlg13IdfKqwxu5GfHVkzwI/G207Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SC6PMfvc; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d71TFM2OOpXXiS/J/+2U0dtXhLZkb2dlrL647FELs6HM45ELGlG6s1bEoRBINZkjaZj9DPdMCf9FPXW5BW9QxUoWVfhX3HzDchIUcJP0Jj4rKry+ikRCAniyNcNo9Zu8n1n0yABXDfLoAyBQETMD6O9Kz25S7n9mcJpBFasiWp8OkOYfaAjs0s23z9Ow/Aqtt59WzZFUi5il9uY8an97SgtRXxkNdZxXNOflTvTqlDbD+aGkJA+Ntfbq7lMYcPTmS6niKLYunYC0xSa2xvf5ekTx//e/W3oNgIzsd/BeO6rj7mY7Y9ZWX5nuCX9nLJC6grmEncgUFvqpZ4wSlYGYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI/Xt1XlkRQm7Lb+L2N9lgjbmeocoI/k541RnRG1AJ8=;
 b=PfR+TotMReclpyJDDrdjfblZxeoszEHMxfCiGdaXnod9B18HTBLr1o7wgk4iGzibF4pS4avfC8yRQaP0/raCsvnQ0selh+givVBe/LFEXcQ7rIcA99u6Di2v0SuUtJVHA47MYx+5YdHgteN8+2q9Pw3Zpqo0ujsNGQll95O5R75UHm/L4n65Iy11Iu2rfqfPU5u32jrkYVix16zQXYOuRan3p/FOdM9csoN8O+buyT4YNjv3yADj4IoBvFoJ/FC+B7+3vYSa2lzaAVmxVmRKQcx5FonipeSuh6xeXLPooin1Fut0K8DnFOonhazWx0KWJzBuyv2uSM/FnGW4m4bWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI/Xt1XlkRQm7Lb+L2N9lgjbmeocoI/k541RnRG1AJ8=;
 b=SC6PMfvcRAvN+C6flWBDqFAMEx15i20zfJ6VPJHZ3qpv17DL7E5BZBtcoCRGPnE2MKNGrEtpOPC7Fz90EAmL/EphqUhY4+vl7TulkdsX2vn6Dmip7dgYZ5SGRO97cheVgbDFpUgwL35pu+9E9mPQ3EiU1KWoHUQ6Xb9C/CmhcgEuL2ABaQ0RkwIbECaTibqMsbWdBn3E+be39Lusq6pSO/6f4BS8hDPabrP2qwz31Do5Z116PXML83vyimIaKnqxYei/I0610J6222hIShARYCKgHxbLkegNhoNsXV7QAhfUD0KDeLB67ha2ocmiGXa/vgCSOr3zRTdUr2jzcvROJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11000.eurprd04.prod.outlook.com (2603:10a6:800:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:23:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 17:23:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Tue, 18 Feb 2025 12:22:57 -0500
Message-Id: <20250218-imx91tmu-v5-0-76c0b27673e6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHBtGcC/23OSw6DIBSF4a0YxqWBCwh21H00HSCPysBH1BIb4
 96LTopJh+eG7w8rmtwY3IRuxYpGF8MU+i4NcSmQaXT3cjjYtBEQ4BRIhUO7VHRu31h70NIQDlZ
 ZlJ4Po/NhOVKPZ9pNmOZ+/BzlSPfrn0ikmGCpRGUEU9Izeu+W4Wr6Fu2JCBmjJGOQmCAMtLbcK
 uXOjOUMMsYSU8JJUdZQcSbPjOeszBjfPymMdl5yRWv1Y9u2fQF/Ld5hQwEAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739899390; l=2312;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OWzjANGm+6sNeXCYpPEW8gJygYuaF1zETFCVvahmdJo=;
 b=oVTsUj6KlgmCwlkctiUY0jMkemNtA2+fGRrjcJrw9eGqw0WvDY5ujLB9xxIuhV7DmdFx0ATMV
 WPI9aidOEdzBjkjfrNiyhAIt2q4JY/fPKk3v0fHg2PXRK8z2pIIxzGo
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11000:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c297f8a-5097-416b-1725-08dd5040ee1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnpZSWlOaWxkUG5vSkRiRUFHL0NDSjJLZGdOcGZTeHZlcjlTSFhNelJvT3ky?=
 =?utf-8?B?dkRrcFVyV21RZGdKZ08rTFdTNUVhVHJWWSs3YmJUYzZBSHViRDNvUUZ0V0Uw?=
 =?utf-8?B?SzRUNDBnaFB3RUVCcm5GcjdaVnRCSlRnRTMzNHFENlY1WnJ0YW5GODNtbXhU?=
 =?utf-8?B?WjlkaVdnakhYOFNCWDk1eVdhR1U1bExrV0prWnNqbUVjVFU1VlJBYytObmc0?=
 =?utf-8?B?cXRXY3p2MzlyOXlkbmgvWHU0ejJZOUNGekJ2ZEp2RDlTNUx1OVN2bHJPRXBI?=
 =?utf-8?B?dzlFNU9hQ00yaDI3Zkx5ZmNqbnE1Q0R1UXNzN3oxSnM0Y2ZHc0VsRzJYbHFp?=
 =?utf-8?B?OG9PR1B5V3RSSTlBa0NvR04rOEpGZFNYR3JBWHhFZ2xTRjBIeTB1bnhtQXJo?=
 =?utf-8?B?bzdUNWFoS2hyRXNZbUw3OWZMN1ZsUEpjUFdTemRkeHZSYWt0TWI5MDdZQ3Fu?=
 =?utf-8?B?TlBSMllMYzVnQk40MUZmV2NOcFcyTGh5OEkwOXlQVWE0ZUNlWTRZamprZXQ0?=
 =?utf-8?B?Tm9xNFIzeFZJdmxCYVZEdjk0NG1vTjdyT0NMVUFNaG9hSWxoK0VSRXJCMmxv?=
 =?utf-8?B?YTBqOWFjT3lraTByVGxKVDRPekdDcVJlY1ZDOHorNFo2WGRVd3NuYVBYRjdB?=
 =?utf-8?B?YWlpbzl5Y3VxZ1BHRkNXdU9VN3E0anlOZEpYb05zdDJUaHVTcWF1d3hKeC9o?=
 =?utf-8?B?a1RtWEprTGZGLzc3QmIrcVdpSmhHdkM5MjF1OURDc1I2UEVRemdFbUt6YlRr?=
 =?utf-8?B?UHBEWTU5MEJDdWpkNWhyUGZxdWFDazFIczZTOTA1S0tDZU1ZRjEzWGl6ZFFW?=
 =?utf-8?B?ZDdKUFNCMUVWU0lNMERJUVQ5TkluczlHak1tYXo4WFd5d253RzZ4aE96ZFVa?=
 =?utf-8?B?ekMzQ3NMNS9sT1hBTFZuc3pJeWRoRExsZmFOR3hQN3VMNnd2Y0dpUWtEb29k?=
 =?utf-8?B?aGh4ejhjeFZDVGJadTFGYkk0UHFnY0ROVzlOcVhETGtWMGFESWFKcWp5WEhi?=
 =?utf-8?B?WFh3OVJ3aGVmdWxnaGZwL0VvVjNUSW1nWkNZbnp6SmlULzVUSTJkY2JFdDBU?=
 =?utf-8?B?RDZiN2RVdVoxWTRwRWM5V080aStaTVJMdUpxcjhVK20rTHJkY0ltVDQ0M1pP?=
 =?utf-8?B?dmY5ckN2eis4TTBwaHR0M3pvTC9KNmNRNG9sTDEyYzlubW1QWjhFdGZMYS9t?=
 =?utf-8?B?UkViaE1UZm9uamo4MW1GR3VHZ1MwQTJ1UHlTdzJTWlVDZ1hDR0RIelRqaEVY?=
 =?utf-8?B?OURqNzRWMU5YK0ZFeHloVkwvZXV6VFJhRzcxWUFqQUlTSTY3T2R6Q1BiMGk5?=
 =?utf-8?B?ZUlWV2k4b3VZZlRyaDR2V2tSTFlFUnI3SWpqcVkwUlZtMnJWQUxyUS9DNVF5?=
 =?utf-8?B?WmUxWlkzUHBCUFdidVEwTW9CQkxJaWI0a1NIRnN1SjhFM0xQd2d4cnduQ01K?=
 =?utf-8?B?WERqT2k1RDVvcmEvZ01VWnJudXNzRzIrVjhjTkMxVlpxZHNiSTgzSU9ISzlQ?=
 =?utf-8?B?SDZPbXJhVERHQ0YyY2VyZVluTTNRenB1VEZtOVM3QU5QeU5IN2lTeGlUR01Z?=
 =?utf-8?B?RE9NRUN5bkUvNzRnQk4zckZFNlMzbThFR3J4TGM1UFFvdkdUeFlRWnlKcnZH?=
 =?utf-8?B?R0NuNzRXVENYczVOVERzMDRxWVhRTmpZRXMzUHBBQjlSc3VSdGNYVk9LU1hw?=
 =?utf-8?B?SDdOc1hrSVU5OFkxSGRBRzlmU3E5dXVDVjVqais3ZHNIeWhTd1E2VDdZTCtQ?=
 =?utf-8?B?dkh0TFFxWDNyU3N4OW8wQkZZWm41UDQzV1MyUFpmV1R0Zm4vTDJ6ZTA2T3VY?=
 =?utf-8?B?L0htY3p0YzhxUTZtUzQvUHJOUXhJd3JHK3BDRDc1ZDhST2RBNmM4L2Z4NVN6?=
 =?utf-8?B?eE0xR1dKYnd6dVZicFFsREJpbWV0dXR0bGJ6VWN4eUMzVkJMWGhpTVVUNVJC?=
 =?utf-8?B?YWErTnVjMVl4b3loNXltZmUzNWFjNEFWSTdsMFV5OFVZWEdWQ1JybWMxSWRJ?=
 =?utf-8?B?czFCdGdreCt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkk1UW5sKzFPeFNTZ21xTFY5WHQ1ZGhsdEk0NGprazhKbXl0d2t6ODRWRU54?=
 =?utf-8?B?Qk5YVmUwL2NGME00dnV4ZkZJL2VRWW9tcmVxSUhFdUlwTXpSVzJJOUU0STBp?=
 =?utf-8?B?d0VXelZxQTZWSFh1b2xvV3V1aVZ2aEZRVzVuS2lMQmVqTnpCb243c3J4MnJI?=
 =?utf-8?B?S3VuMXRoRHRQYnpDNmFCaHp1Zm94N3pILzNXYWQzUTErOUxlMUZYTTRiWEV4?=
 =?utf-8?B?NXhyOUFpd0VhVi94blhwdUVDVUVqdXZreDRTYXJ6NE5TTDZCc1lKb0FMU05x?=
 =?utf-8?B?anJWTDBSaUZ3ZERsUCs2THFDaCthdk9oWElhWFJINXJEZURldC9sLytSQjhD?=
 =?utf-8?B?bktsOGt4d3BsbmxkcE54b3BkNGJTT3pBN2FwZDBwN1dvNjVDamgyNW4rbDkv?=
 =?utf-8?B?OFF2dW4vMlNDckgzRUVoRU1KZ3NCbkV3cWcyUE1qejhtVDJzVDU1ODFKVEJz?=
 =?utf-8?B?Ri9pTXd2d1k2UFh3TVl4MzBhSlYvZytTL0xBQlVkeDQzUWtnWUJnYWF6RkhG?=
 =?utf-8?B?ZlJYZjNLdG5pdUZSVXZzN29PL09ka0xNRm01SW5ZWlR2SXp4RXRiOGxQRmxQ?=
 =?utf-8?B?YjhGdzNOY0pwOEdmRDJiN25vNnF2amlWbHdGaTVwbVJDSGd3dnFRckdsNVZX?=
 =?utf-8?B?SHEvU3VDc0xacHd2bk5TS2dTYWRobUtBQ3ZBQU51Q2o4ZlN5ODg0cCtLUlg4?=
 =?utf-8?B?bm40endrNXVnU3RZdFZNUWJjUkU3OCs1WWJZcjBsR3FtZ1ZxelpCbG9DUWRj?=
 =?utf-8?B?ZmxhQUVFYXVpQy9SbkRoSjljWUYxb0t3eUdIb3Ira2lUVE9hanEyVjRnM0ty?=
 =?utf-8?B?bUNpSGw2SXBhNHRjVzVCcE1EUEplKzRTSVJSKzdkY2dIQkVNNkdLODV4bDVx?=
 =?utf-8?B?TExGL1E3MzlUYm5ReVp5OEdPcU1TYlJuYTc4S3hrcU5oS1BET1dRZGVYR24y?=
 =?utf-8?B?Tm1XOEN0R1RqdThIVDF4TktjUU02SDU3RFc2c2JzRzdWK280M0xuYW5WTlJZ?=
 =?utf-8?B?WWx6OFp5ckdtY3hzVXlvZFJ5Vy9PSlZZUThoVnZnUllBZTVqTnBuUFdWWWtE?=
 =?utf-8?B?ZU5IVG9XV2pNUzBqZktMbW9oUDZic0czbE45UVpCUmhldkwybk5tNGpoQUxV?=
 =?utf-8?B?US9iN1RldkwwZ1Vaazg4aVRVRjJ2cHRmQjI2TERsTkxtMDVqaHhDOWk2aEl6?=
 =?utf-8?B?T1RERHBlMGFpc3ZUOHNoNkpBRGMwdWwzcm1RVWJGc1FacXFpUnNjdmpnSFQv?=
 =?utf-8?B?SzNnS0NJb2NPd3MveHpqQ0Uydzc3ZUtwdnlXMytaNUNSY0MvVXd3enZka29U?=
 =?utf-8?B?MVlPMFZJMU1YUTJPMkZROFh4RnBWT2ZCd2U1ZEpYRHowU0lESjV4MlM1dlV3?=
 =?utf-8?B?UGRPa1QvcDZyeWRma3ViRU5aU0tGOGE5emovZ1dxT2hLc05HTkxUS3dHbW10?=
 =?utf-8?B?eGU0Rys3NHVJdmpkbGU0bUk5OWMxUERSU0dBSEpiQkoyQis4UDNCcXFzd0x1?=
 =?utf-8?B?eWpvZWovSGNCbW5KOFJRNHc4dHo2RzVIbURyNkpaMVN2ZFlmVTBWWmJmNmZX?=
 =?utf-8?B?cGpxaXFsS3hnVWZjL244ZkVHSFE5NlBnY0tINUxhcGowSXhobUUvUzRFWjNs?=
 =?utf-8?B?c2dnZFdWMXdTaVdCZUovekphaEJ5cHk4aUI4SVdNOTRwRW5CVGw4UXY1b3la?=
 =?utf-8?B?VVhIYmxacE54WVJ5S05HdlJMazI2d2Z2RUcvQzJsZ3pkV0o3MVo1RnVKakli?=
 =?utf-8?B?emhWZ3EweTF4SVBoVVVSZTZNZjlDdjVkeUx2Y2UwQ0JvMitIMFdjRkx5ZkJj?=
 =?utf-8?B?a1Bkc3BvYjdkVXBuaDZySmRCeUZwZzl2ZU40VTZEM3BrR0RSVjZOMUZKYmE4?=
 =?utf-8?B?d2VJVkpCQXc1ekRIVW1xYWhwUXJ0OCtUb1BleEtLdEhhci94UlJEUWQ5VzNt?=
 =?utf-8?B?YXlJMnB6STNuQzd6YTNuSHpvaENQZHp4cjIwTm5wUjFJSm5iOFY1Sjd0NFlm?=
 =?utf-8?B?VEx4WnBSdEM4dDZnWm5NMW5veGJUdi9QalJPK1VZV1kwV0VSVENGcTgvejNI?=
 =?utf-8?B?ZlhjbitxbGFiNHNpdU1DOXpqRE5Dci9xclJoR2djcHBDMWFUalMybHZFU3Mv?=
 =?utf-8?Q?SdP0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c297f8a-5097-416b-1725-08dd5040ee1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:23:16.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEvFYPnrcDyU3Zhx81md39ANuXHx4UbiddeGyaPEuA99wBi1qHyHuOwjpyD7ndd5ngCA6k/YqOdRALNqKNJ1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11000

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- Add irq support.
- change to period mode.
- Link to v4: https://lore.kernel.org/r/20241216-imx91tmu-v4-0-75caef7481b8@nxp.com

Changes in v4:
- Add Kryz's review tag for binding
- Add Marco's review tag for driver
- Use devm_add_action()
- Move pm_runtim_put before thermal_of_zone_register()
- Link to v3: https://lore.kernel.org/r/20241212-imx91tmu-v3-0-85e756b29437@nxp.com

Changes in v3:
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties

- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
  uboot may change and enable tmu.

- Link to v2: https://lore.kernel.org/r/20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com

Changes in v2:
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
- Link to v1: https://lore.kernel.org/r/20241209-imx91tmu-v1-0-7859c5387f31@nxp.com

---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  79 ++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 422 +++++++++++++++++++++
 4 files changed, 512 insertions(+)
---
base-commit: f50e59ef812d87066a5ab07c7bafc54aef378c20
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


