Return-Path: <linux-pm+bounces-19322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB79F363A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8760C1644F0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE19126C0D;
	Mon, 16 Dec 2024 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=emteria.com header.i=@emteria.com header.b="S/cNsqp8"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2102.outbound.protection.outlook.com [40.107.247.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C716175BF
	for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367111; cv=fail; b=QRoF42/O+JY8JKytcjcJYXnPQkPFmbuZ6HLijnUERCgOxLOJ+tHMJMdmbIrVmmA6TXUxjMQfFFEiTMUWC8CKKRwgyxQfOmuM/qI1q3awT7byVwu/DsD4ctjjchIHG8sFH8Q1TICkZTzTrhZEH89wbTU3jvrk17OtD4bcgQOR5RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367111; c=relaxed/simple;
	bh=vGlJ3/4a7LosmWb6pDjcpMrCk0YWbI7gQioVvUc6wqc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NgGoEvpgv0fjsSJVk4gRRND2EXL7Ei2vx23aBnWbVRiueECb4FG4dqMD1y1Sf8XWy/H1y/J6qNMrdrrK8DuZNNqI0s1KusIBFU21TxiXHwncjOZVXfob0ga+CzMFzCB7EdXSjfDYNTLChQ7cVfpJZ9P2I24t9wHbbQRYGFXYLeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emteria.com; spf=pass smtp.mailfrom=emteria.com; dkim=pass (1024-bit key) header.d=emteria.com header.i=@emteria.com header.b=S/cNsqp8; arc=fail smtp.client-ip=40.107.247.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=emteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNXpjVx/FNZpUHlfkUbhGkQ3bPMllbFlnBi1QTeO3M9mMI8KB14/7gtV+vjjjY9bYBpZrmBdFmufcwZAEIURfJd+VT9un8y4iqz0R3ZQc5SQQV6330FMoEiQmQrqRAk5F9BmwU/lKJC9aq+Ypry35zuq+6WVjjm0cIMqdBD+h59B2mZwEMbjt5z8ejPGLuhaMJ7wOGckPxXw7XXpeAkSj8KnsoSgMxby/r2E2ByE/GOIG7N15TilyqxekJyNXeTt+dwsj5hCb+NhYwa+2lolR2b3WshSdlbt8l1fh9IIDSfMMs+bLMcn42MVqAsmSr9h6tH2XbfdkpL2+yORz26dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGlJ3/4a7LosmWb6pDjcpMrCk0YWbI7gQioVvUc6wqc=;
 b=enBgNmTnAf/2sMne+rixkrUxj7fKTP+rEq+bzsne8WsUqYpfLmwsQaFrcG5MK30jR5kilUaxIZMHERKEmWboow2uE45TkHnT2k+Nn+Rn3emDyfD4pPgRRjm3l+gBaKaDxIpd/4bc1VimKZTjNw8RLibUhA1Cha+1lGOzUGkABeXOZnbBliUEr1/B5B9Q7E0mY5A3Ygltz9EzgWGsfWs6MvO8XR4pGOWD2TWHqlaZRKsgPgRg2J+6GatVX7f+JGMoXFKtDwpqWCVRi3EvMClJsEa1pV5I3DM1aaf54CqpJ8J9FZof36OLQ1QBtNEd6pSNLnuJ0n8uHQ83UYPo07cfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGlJ3/4a7LosmWb6pDjcpMrCk0YWbI7gQioVvUc6wqc=;
 b=S/cNsqp8XebLDG9ScUn606d0haZiH+vdJAotGbtaVbvfHdxwOQhAMf0Ym/YBq722ZRYU0GiSjnnUUpfpcuf8ary9cuoeI/U+y1q20sqOFxM9uSJWeFcS8cguz6JOt4i624Xu0cEL38UO+Iwg8Rjjo9AP0d44wbn5G+AsS3nR5qU=
Received: from VI1PR04MB9881.eurprd04.prod.outlook.com (2603:10a6:800:1e1::11)
 by AM9PR04MB8602.eurprd04.prod.outlook.com (2603:10a6:20b:439::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:38:26 +0000
Received: from VI1PR04MB9881.eurprd04.prod.outlook.com
 ([fe80::5382:e12:e9c2:4a3e]) by VI1PR04MB9881.eurprd04.prod.outlook.com
 ([fe80::5382:e12:e9c2:4a3e%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 16:38:26 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Battery connected through CAN
Thread-Topic: Battery connected through CAN
Thread-Index: AdtP1rKQs8LnPMsSTUW0qjx60n5UkQ==
Date: Mon, 16 Dec 2024 16:38:26 +0000
Message-ID:
 <VI1PR04MB988166886CE21FBC7AF364E4823B2@VI1PR04MB9881.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB9881:EE_|AM9PR04MB8602:EE_
x-ms-office365-filtering-correlation-id: 8f65554d-6a18-4d98-fff6-08dd1df01061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7qZya9U9Sef4DeIYtygScc7hTDAzncSQogVkCJ46e9Z+vLEBLX4SVDhSZ09Z?=
 =?us-ascii?Q?/ipKP+Ct5XR+n66OnHRloMcSVrqumo3DTI9xDKDzH3Jy3LLwiJCU0o3S7TmJ?=
 =?us-ascii?Q?jrbaYTjInwuUcQ8XoDnCl7OPIEay2CyKwakSQ74nO9yHxDtFbOXpxdjtL+Ul?=
 =?us-ascii?Q?jaZ3sZ/4W4++Lf7IN5JDAhIJc1YVHuiDsYxGt8brv7QR4TePQQEDW1GRJiWB?=
 =?us-ascii?Q?guNJCEH1JQwI4+TuEXsf+pMvMEysvYzwoQDXkJzl1KUBx5R12p4Lb8Lknkw+?=
 =?us-ascii?Q?ipC55CbUxg73/QDICm+0v4yjR4YTvLxq8KlVMQn2xA7NtrR1Ol67jWBQ5wlt?=
 =?us-ascii?Q?hFpcnk7gd7NW/OPyJRTXEqBhNCZBXzhtaULx+Zos7ROmYiuR7ALA7LrG4ZFk?=
 =?us-ascii?Q?XIaOTa3EDGRnAsxnng9xajB4xuVIepbQaZpAD33wBNSsgLOxu405lSE2YT/y?=
 =?us-ascii?Q?cm1aHZEEKnWcFrLf7n3F2hFFGnUiberz1XOvkRUQx3Sv31fMHKaBGAXXNK2e?=
 =?us-ascii?Q?u3w9Z57LyvYpR3VBUVzBDamLuZPjN6QriXF4t2MotQ3H2CymOWIxGdJ+sP9a?=
 =?us-ascii?Q?sJWanb8JRrG/4i5HrI7WPFJe2Gp27bKX7/qyR7CfXEdRrESOJrz4ScohB7lU?=
 =?us-ascii?Q?CiX94LqWDOGTN5eTweI32RXXLdk1KJ/aXMRt/qmrLhHaIkN6eAlOG8j7zd5s?=
 =?us-ascii?Q?tHq014Es9FMPkeHW9EpI1ijkUEqm1zUl2I8JJz62stpfyimsUtpaom0M1KFo?=
 =?us-ascii?Q?D4LFUsHFtQgOWRpnpmbzIwCIwBt1q+w7DfGyB5UXY0AgAJPDItLsSa4cBhdc?=
 =?us-ascii?Q?ODifYn1suiv3g06CkNqjt+t14ttLrpegfq93RQ+nurZsZZmHjW30p5Q9rsUq?=
 =?us-ascii?Q?eKkrgiNP70XHYc/75ijXI9oJ0jhvCUmEcpWkdfdY2YCzs+PIeqlmyNZSSgW5?=
 =?us-ascii?Q?kJL0SbU+6HErc3K8mYAb4Zjf+7O/3/MCkbi/17qZSxBCAjCkI7m6Bvqsg43k?=
 =?us-ascii?Q?tONE6rzI1t0cl80KTYlDY64aWIS0vlL+6FbYM8y2OFdGP0lX3bWgoa73dvcs?=
 =?us-ascii?Q?wR43FsgpCn2086/4eVi0SjKiPtSb5J+r8afF+hq44l7Eqv5lbffVZ8Pv1FCx?=
 =?us-ascii?Q?Gc8ZJRnIvM2Hir1wwocIXuaMAQXYBSkCmLf74EsBUgmapSZ8RvAZIuqbI9uF?=
 =?us-ascii?Q?2fralI2GLzy7W8RfIdkEJAe73fMq4NyvpxZt/6mc//441MIv+Toj4Cm+CwXs?=
 =?us-ascii?Q?RTbmOFrp9KhiidPUjqiSgD4JAaU6QezoOXmuUQNU19JjjY+b92gmUkCuLElh?=
 =?us-ascii?Q?PQ7Cp0weMFHyE/WgtzCZ88v7KU+RaB0NU7ijjAWpRMJNtQbyRk9/j4eNBRW1?=
 =?us-ascii?Q?7oKV9LElvJ95OuhwZPMEpBeTpmoTBcCIUHH2lp5hE04FOTFiiGZYgWXEi1Om?=
 =?us-ascii?Q?nbxn82aPtz0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB9881.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NnvrfvDC4+jtm6WamSpBHAD0McAUPvU0NJ7k4w6291exv/mpHJisrwnzgvo3?=
 =?us-ascii?Q?+vAjkiMXYY3ZvseUWXRjD/wwFGTACovi0mbfp6w26FNv0cQC8ZYYpjkJiCUe?=
 =?us-ascii?Q?hA3RWVINfRorC3BrazqyomyQIJvF1WE9C3Tw8WBr4Mny0etBj04xztMXmwYU?=
 =?us-ascii?Q?TB7NgoGLFjRVeO1SV0wVrGiWe+vabpTR0lLXcjvVCQ6YYC1V7byq2iZuf1YZ?=
 =?us-ascii?Q?WAQWd9amqXsUx1hMUGDVP4c3IMgVvgEGaMoisQdobbntoUh9ZJCgK4rBNIDH?=
 =?us-ascii?Q?b2EuTs9pgjJhTax/apvSxhw6mPAIet5HxdzfyJoXiSGICfi/q65r6+CVbW10?=
 =?us-ascii?Q?tqnQe24Ky/cDGwNceRuWYmQh9rlKrun8cmv9u/WAG12rZvAZ1i0ej0n0XMTW?=
 =?us-ascii?Q?BuwXTUNqhTcLYrl3wsFi4xcpIdAaDdL9CBHiP1LbmoCA+ZyVPe2zfMn8AoYJ?=
 =?us-ascii?Q?Er4+sG1i4mMZjBSEgi1WUNAMgfr3flsZe8xZkdRY1CB0MwXpvYhZqHwt598l?=
 =?us-ascii?Q?ysOojvo+TioVM/tfcvaTmNZfwFEFCAOL7MU75+WNYTcPrCWSxwJjYQLQHapE?=
 =?us-ascii?Q?ocwPjx54Gzwsq9cB+GTYUttxkFo9LSnmVFWerkqCUmJJcf9qPfxjBfr8RxTb?=
 =?us-ascii?Q?wzQPnenB8/ZTDZiEXIhSBaKn5zXJNKrahcjh+GlSIeWvmzDZPoHy9NuSFDkV?=
 =?us-ascii?Q?vWV44dqmjGFBTQEX+dP2yuOq63j1g3i6oZTVovlEiYyGrsOSSWwGjhCsQ6a1?=
 =?us-ascii?Q?RkV+xe6f8sXu7X4DRg6AbX4S/78hf5N1BXeRjDIuNiM6jOr+EqHOxKM5JT+M?=
 =?us-ascii?Q?tKSIOfVwV9CT78Oyo0v8IPiO4A0yS1HHPGsblvH4Rj8a2wRpW+xn7HGy9MKE?=
 =?us-ascii?Q?BAD6WJ5nYR5kWYjmaOHhq6Ir6K/SRm8EK4HtWXvsO45TbTslpTFjGOMqswP5?=
 =?us-ascii?Q?lcP+Jm8n7cj/XoCx/6GTo2eGFfOZrkaPcxkyIehmjN4DOATsp11bm9YC9onA?=
 =?us-ascii?Q?vtxlWRALnHCtOwL/W6kB6GO41tCrbRVdyuJHeWXHrRYjLGzwDxv7k2IIZnOz?=
 =?us-ascii?Q?NEbd6MgCOR1MIXoRcIqPFjt0iGNLYBhTLEdvTVcKyGfgxlF732L/UAtOmD1F?=
 =?us-ascii?Q?E2GScLQBfIwYhPB+jRDDffSLXV0+cl4+deKiRIJU66BJFTRda7GVyK3GNfyk?=
 =?us-ascii?Q?h7vrmQcxhEJ57E/419rhnuMuFSHhfRotUHqWPvc9N6Quks5kFqfESawNIzqL?=
 =?us-ascii?Q?8hd5deT71xm+LLPOHE32mC+3X6AmWkPYp2Q66nroeZIhvENJdKSibSyy+6ei?=
 =?us-ascii?Q?B4+jo/3NAF+6DQeV2tRlmk9ALyLDHwVL2IWGWgcGXsFaqCdoEecADY8rr6d/?=
 =?us-ascii?Q?4fzkKAnuIXAzB5amto5lZu3ynFSO/WsN0G6XRj+XUHCIJaCXVZJOk4ix/qpy?=
 =?us-ascii?Q?F04x/mF4a/sEQvK7QH583Co7bwEEJnMyo+8uyo+LES+2Dn3xEtg7NVMoQxMs?=
 =?us-ascii?Q?dhdVAz0Qn/0ntGxMEVV1Z8/c7it+Gy9KT6ATByP3I+hPZ8yOdWpsPfIOm5x1?=
 =?us-ascii?Q?kPqvmmjt7Xd1vHzvMQ29qcAxt8kDMnKudpBZNUNFBLsfyu8ncE1aswdrgIc9?=
 =?us-ascii?Q?4xbJmW0OV2wC7GzsMQfTfT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB9881.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f65554d-6a18-4d98-fff6-08dd1df01061
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 16:38:26.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V5KsPdl/G/vBLUKVfr5v5TaBUkLWbF4s7PmVbdw0bvgcGoaj07t8zFnb/+6IrzaHWo4BPKP+FOdeyVNdGQ36uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8602

Hello,

I am building a device which will be powered by a battery. The battery is c=
onnected to the device by a CAN Bus to provide information like SOC, SOH, c=
urrent, etc.
My idea was to implement a Kernel Module for this, and my first approach wa=
s to use SocketCAN. But somehow it doesn't feel right to do so, and I didn'=
t find something similar so far.=20
Is this the right approach, or should this be done with a user-mode helper?=
 Or shouldn't this be part of the Kernel in general and completely handled =
by userspace?

Best regards,
Jan

