Return-Path: <linux-pm+bounces-19157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA19EFDC8
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FF4188D379
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29161D6182;
	Thu, 12 Dec 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FjHq1Lnr"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F71C5F07;
	Thu, 12 Dec 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037240; cv=fail; b=XNMiWTZaUP8eS04LvCbcr+G1CGhzNlt3Qx1GCc5H2ctXBejPQmvbawXq/3F+Yeh/e62WJGC5XfJkQoq499m7aq+/Fkoh5xoW9/sIUWum+6lMqmOT5CeUIc8dMNWw5OYBKodmgJua9yOOPQ3z/wgl/ETdVarQQfm9Wc5OZxTKKiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037240; c=relaxed/simple;
	bh=pFRXWA2TwO/wUmImPmOAMiljT/WPmqaPXAbH6JQQMmY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TJEEBpQfnhzINYzbg9p1KFJU1gNvxQcp/9QiHggAJxt0EAWRu4ExzmAz4li49/0mh+rii5vRj8EbZdIt3aLitX98ar5xcPy7DvlN8Mwfl1P9L3xVavERLq+zpXOTeev966DInFGByQ1shsKCEymcxchvuUopNAJGoEOyBoCzux8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FjHq1Lnr; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyCyVS46FlKIVMj6CL10Q7uZ6kOSkU9fMLmzVvghEBoF3TvjXUuEmzAOUC2W9JSUjEFK8k+v3jhjMYlr0toUPRHPx02HBWhj8wzuzPQTxBpi9im5+WA/wEcRu3Cuj1I0NhvtZSL4Le/hD2zUAM0ILeKq0RBX9YKVEM07BzIK38R+2xSIpJW4NwJKb8N3C00dIJrqpj479z7NGpZQhgs4KRjaeghQ0JY0SZbo+SPyd28tuoDYR4Ux4DocFRh72rxq9fmuwDYHSZFH7Zw1IHthpZUO1RB0pg6vAXUgNS1x86m/F/xaUBk08OS8X3r9MZ4JWda7sNyQ0ZFzr8KIr4mCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu/LPt3yx4FBUCM4QCAaFywQ/R9bTTHrooRW+dw8ym0=;
 b=XKcaJX3vzM/Cv192XM7VI0ky4CcF1MHiieRdzRyO7Vjn72P6a+gSakKcC4X3cdD7rvGKJaoGJ2doyJSVLyoKXukqPjvk+N7BQg7GJEISyqcdXXPtifzGHMMBjcRTeOr0BlJl0yZhoCZTKH+antBMkufhN4NheqLHHD4F6Z1apNq0SVaXeWqjIT82yUvCjiCfGlxOPYofGNWbprsPVYO5VGxnebeKuhuCXCP777Xn/W/AA1PMqTHh5M3LDUQneemrlRJ7qRisOgmEVcEh3bjoWvoeOegneVydN3t9hc7i18HeL98tE64UQWiesd03lz6S8nUL5l2cKAFB03G+a6IvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu/LPt3yx4FBUCM4QCAaFywQ/R9bTTHrooRW+dw8ym0=;
 b=FjHq1LnrsfqsV6LltyB0hWf9C+SGdkFoLu31f0eyKdD0wwVe7SMDPAp+tYLFHnI1B6KgjsmFZW4yaeqetYIOWBiDsOkGbv0WQjrDct1pqZKGwtZNt9f/WNvchHlsUciLX1KH+0aRS3aFwFv8qUu3pdjU9dO6HYM96PgH4L3WzPykgmnjUkd7bU2D/SgqI+A95IxP8qXxbZVLv9SPzF329Cra272wPVMyEynGMueGdD71jzX0YDGOVV0GnAC4binvsEKC6LU1SscpequRRzRHSG7DeVaqRnbGHrRSNudir+4ok2yuopX6pnx7zBeEFmI4BEaeKr+s02kK0czb80pqLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 21:00:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 21:00:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 12 Dec 2024 16:00:00 -0500
Subject: [PATCH v3 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-imx91tmu-v3-2-85e756b29437@nxp.com>
References: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
In-Reply-To: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
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
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734037218; l=10296;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6kF2c/YSx7LoiU1VwjjvTmVypq+sG5LudLSU6kO8t+s=;
 b=7kTtNd81/dyL1DLuudNWdlLADsuauzCtqndFgzkp7zaFu/ihOXh/icfaiwfUtmM1H2jB7ehSH
 JkQ1kqAbi+IDzusOb+h77Ah6XbpkF2Q5CbEJ+JPIWed+Pz/2P6ClQyf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5223f8-a8ae-41f5-0a86-08dd1af0057c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzcvQ08yaEhPVDJaREhDeCswM2tlbWV3bXg4bHJPS0xsYmd5Zm1IeHdkMGR1?=
 =?utf-8?B?Wk1GcXNicVhBVlp4eW9sRTBkVWgzd25uUUFrbHNVM24zQ2ZuUG9zcFUzS1FF?=
 =?utf-8?B?YitMSE9tL2ZaYmVBRHVXcmdoK21tMkkvNHRmT3QyZXljSC92dkRBY1B3OTBR?=
 =?utf-8?B?dTdKSnZkcXFzL0JpUEVXbkpxSXMzQXM0N21JZGd5MUhDbFE2UUhGQWlGQzVU?=
 =?utf-8?B?NmVFeWdWZU44OFF0Nk9UK3d6UXc1bUw2am5rVkhjKzEyNU5PanVsM0ljMXFa?=
 =?utf-8?B?OFAxZXJJVDNWd2cxUjloVkkwM2RNUUpXQ3FwbTcwM0NhY0ZmRCtwV0lXMzV4?=
 =?utf-8?B?SjdFcThHT1V5Tm15M0ZXWkN5NXZQNDB2SDI4S1ArbmhiOGdOVkg3cHR2MnQ0?=
 =?utf-8?B?N1pRTmo2NzA4UVNUY2M4Z0lheUV4UzVma1NKZGhXVGExOUV6ZWdQR0Eza1pZ?=
 =?utf-8?B?WEhlZWJMQXBJYU1va0xHYi8rWW42eU80M2hPNkVMV1ZidWttd2x5SjRlMEZH?=
 =?utf-8?B?K2EvYjJXVjZUcU54eDI5TGl6NS9sVkJsMWdQVU1NZEVkR0RTVGVWTnozZFFL?=
 =?utf-8?B?ZjVVVUhqV2F2SFRYcXY4ZzFyMUxnbGxLemROUzdldGtKNzl3d0RUK2JJNSt6?=
 =?utf-8?B?eHQ5eXNKZ2VjaGIvSEd1L2FXR0dtZHArZmVKUHJvMDlnb0VaK00zL3YyVmVh?=
 =?utf-8?B?OE5SemZrcm50bkMvQXEzUFNPVEhSVzNCTk5veG5ZTHBiN1U2SlN4SGNKVFh6?=
 =?utf-8?B?VzBXaG0zemIwOGtCbEZaRTgwZzg0VFk0MUsrUHN4Y0F1U0EvTUFlbXY2c0ov?=
 =?utf-8?B?YkVzSUMrR0VzNkVIWnBRVS9OYUpkZ3pqZmJCTlRvVlY3c2VFTGdFRFVXVlhH?=
 =?utf-8?B?QS91b2pwTGN0U0lwRHN6MUJxY3FhL2piZHpuSEFNSkgzem4rbUVWTFVVQlY0?=
 =?utf-8?B?NzR1S1lUQThlQTBuNkFyQW9QNFhic2tQa1Y4eEN2WTNrVHFpdmpTVFMwMTJM?=
 =?utf-8?B?ZFJmMnpDL1RpN0cyTWFIRCtONk45M3dUZjNZcGdTMXNTeXQyN2ZlNzZkR09u?=
 =?utf-8?B?a3pQMnErVzNJSlVVYkp2OVYwVFpIN2hRTTFlbCtvVjd4dHN1QWFXaWZ3VW03?=
 =?utf-8?B?QUVwV2dKT1Jic3hmTkFobGw4ZlhaRTZDdzVTOElsdERnU2QzNjY3QU16cEww?=
 =?utf-8?B?OHJTWkFCZi9Jc3JKOFRkN2VzbUVqczhaQ2N1ajN4dUpleFZMZmYxUEpQbGpa?=
 =?utf-8?B?eUlFdjVjMGFiS09oZ0hvVXgxV2hrYjVONnhwbERXUkZlMmo1SVNKVVoxaFRw?=
 =?utf-8?B?VFFWSXNwS2dmcW5YWkduVllBdEMxR29kdmpNT250WTU3QTh3dGxyaUNBR0FK?=
 =?utf-8?B?QlhINzJ1L2p1ODZrTTdGSm9VTGt3QWJVb3JURTRnNUtNSkpDR05ockUvSmJS?=
 =?utf-8?B?MGp1WmZiWHA0UTdlSkc3bUJFOVhWeE9YZEpZWDg4Q1BGeU5QZHpIbFZOb0sw?=
 =?utf-8?B?eE0xZXg3RGh1MVN5blZRVmhyemZKQVdIKzlRcFNHWVZ5aFlxK1FrK0JJRDZt?=
 =?utf-8?B?bWJ5MmtlS2JSbWhOSFFGQ1NsTnl6Y3JnWXNxb2psN2pEN3EyRERtWWY3UExq?=
 =?utf-8?B?a1paM1pjVm5ucVRtRGJsa2ZlY2xwdXdLSkZDVk1HYkdTeHZvS0NuR2ZlLytu?=
 =?utf-8?B?cnFYNVpqTUJhMU1hdTNtVi9qbHNHUjBncW5NNlVwMUV2bHVuU3NTSEVHbVpu?=
 =?utf-8?B?MXRldmdxOVM3SldlM0RGWlBKU2grdEx4QzhWYU9wVDFwY05IVXQyUXd1a1da?=
 =?utf-8?B?S0MySTF6VVhycS9sRUJLMUlDa3VFVTRlWXlkRUpId2FuSXo4c3J6dHROS3NK?=
 =?utf-8?B?WDgwMzZNQUk3Q0lzY295MEVxcXpMYnlEblVuYTFUd0dId1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlhRi9yTVZBNmNQVll4TjJMb0NUZnlpZWllcTl6dnZIOTRtRlV4ay9mQ3ZU?=
 =?utf-8?B?OWxPWXpnbHlEam5IcE9HVHJidGE5d251d3VIU1RtOTZWZGg2ekFwTjlsMzVG?=
 =?utf-8?B?QnhjZWhGZ1c1UEpPR3NDdHVyTW92T0pHMkg4TjlwMHdMQTBCYytFQmJBUEx2?=
 =?utf-8?B?QlhqSnBSV1lNVWFWZlNrSW1nWjRHSWQxWXI0K25oWld3Tk1yVU1DZFNIdmtY?=
 =?utf-8?B?L1lGT2l6MDVWNWgxeTk4SVgyVmF6U0hpWWEvOVZCK1diSUlYZjA5TC9kNG92?=
 =?utf-8?B?MzB6QmU0b2pOeTdkSUU0WWhnRXNQczVtV2JpU2dkei92UnltZGRtYWpkNFJv?=
 =?utf-8?B?UCsrNUVaTXFFaFRqZ3NvRUpTY3ZFZXVLNDNEa2plMFcxeW5NRlcxenlQUkFO?=
 =?utf-8?B?ektZdGdSM2FKWkU4eXRjRTQyZ3Z0M2lvK0RSckFIWkpua2JSaGNiMVFqcElT?=
 =?utf-8?B?elJqRUl0aVFLdlhnaVYveXpDL0lXWkdreFFaa0t3bVJjWDhUamNSZXMrY3Ra?=
 =?utf-8?B?RHpJSytIaHhRNWlIbmI3NlVVRHR3Mzc0L0kzTlY4OUFGOENJUmhkZ29kRERU?=
 =?utf-8?B?REdzbmhHelF4REhnTHZZM2plSHZ1dm5WazZOTTVYM243eUVKa29wZ3JHeW9a?=
 =?utf-8?B?Q3FBa0lWbTdUYmtpZ3pHNEpQYnhuSDM1dzRsWWx0YlcrYm9rY05YZWhjQ3lC?=
 =?utf-8?B?ZDZMUVRqWEUvbzgzdWx5SDNSZFAwdDlZYjFERWlCQXBFdlIvYnRJNm0yajZV?=
 =?utf-8?B?MXpOTXdtRjlNaUxyN0JCVGoyQmozTyticGxnN2lMbnhiU1cwQlRpaDlPK2Z1?=
 =?utf-8?B?SVVkSllrNjBFOE5wdGpNMlAzdGYvYkt6NW9EU3BzYUdpWGEwcUp6SUIxQWdJ?=
 =?utf-8?B?aGxjMWlKVXJrN1J1cnYwK2J2Sno0b3lnZ0N6STNBNTZnbWZSMENvQVZkQzEx?=
 =?utf-8?B?VjFOUjdyRFRMc3k5RG1tQlJDbVI4Q29Wdjd4K0VjcVVQVXVIdDBleFVVZ1JR?=
 =?utf-8?B?ZUZVNGRpbXIrZlBKckoxVHVqTi9YS3p5QlNCWFhJUm0xa3N5UGY1QVNMcmJN?=
 =?utf-8?B?Z0U5TllUZmhERlBkVkZDbGJSSXM3L00wOWt2ZW5FUXZRSGRyRExORjlRMHhZ?=
 =?utf-8?B?WmRkYjlienNpQjBTV2pqNkJMck8vTWtSRlYwVi9uNHRXOE9IYVJ2ZkhZdWxv?=
 =?utf-8?B?K0w1dW0zR0lxSzNQR0dWbTdnaVJNcEhPRnNhaVMxVWtvZStzU3l5WjNLZDdp?=
 =?utf-8?B?Zm9EdUhyZzg1dzVkOWNUdHcvWURJMWhZVGJlTEZ6WE9FWkJuTXlvQ3JrdHZB?=
 =?utf-8?B?b1J4Vzc2RnRYOE9DL0xES2craEdGVm5xeVg0U0QwMGFVVGN0amJmRjF5Smla?=
 =?utf-8?B?VFBsZW8za3VwQTJnQ29pT2FsWEFVUnE0bmJMSHh1NDdxSk5lSGt0UnMwSzla?=
 =?utf-8?B?RUptZy91RXhiNk1QbGhrUzNaeHZhcHhCbkt6LzljL0RacEQzWmp6aVIvR2M1?=
 =?utf-8?B?S3VUZWpKU2VrZ1RlM3NPN3hxS2I2NVh5d2tmcVE4WEdabHpHVEVrREEyWHFJ?=
 =?utf-8?B?S0Y0TEhwa2VIVDk5SE5Cb2R2c2E5aDliVFNIeHJONXNmd3VMdjBqMFd1TmdJ?=
 =?utf-8?B?OU81anQxL1RPL0x5NDEwbENUQmFTK3dUYVlYWkFHQzdERGM3aHpnUG94WjVG?=
 =?utf-8?B?NE1qYUtKT255VXE0MWMrQVV4UWkzZXlkMFVRdm9BSTBMM282MzRNVFNiUmtV?=
 =?utf-8?B?Z2RUSUQ1UUlHZEMxWG83RVBtbThQN0tISlYxQ1ZjZk5hOXc5U3ZaeFk0QXR4?=
 =?utf-8?B?ZnJyQ0NXbklKMmpyamtGc25SYS9KU1hmUG1rcmwvUVEzdUFmeEpQU3RZWms4?=
 =?utf-8?B?Z2FKWlpXV1BSV1dQN2pIbXIzbHE4WnZtWWtTTVprbTFVZlBJQ0x5Qk9OanVU?=
 =?utf-8?B?bVBya2tDbGRKMm9ZYzhZMzFiemVvUStqc1NuT01DVi8vVEp2anVqUUdvTHZk?=
 =?utf-8?B?V0U3TUx5UEttTmUwc1EwREtXOTY2NDNWNFNUK2JPQ21ieHU3Q3BaYWlPOWlx?=
 =?utf-8?B?ZkNaUmY4ZVVNQ3lOK2RBaENiR29LZmJuTXBrY1g2WEZ1UVg1MXlWQWxjSkJw?=
 =?utf-8?B?elZCOWMrcm9nMVRhTmRZanoxVktadHhTd25Jc3h5eFdzYUhjRUUvQmJ0RzNk?=
 =?utf-8?Q?U3UnqJew5/H7VpeqAAndJqw493lBrLdqLBek63svKdy7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5223f8-a8ae-41f5-0a86-08dd1af0057c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:00:34.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPjDhVebg8V4T7X4l8e9xVY9PPxbtvZi9gx0+1+zqlkQqG8FKPXkY4Vu5SbgbidauB7VlvpgVil+k+vTLoKUtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

From: Pengfei Li <pengfei.li_1@nxp.com>

Introduce support for the i.MX91 thermal monitoring unit, which features a
single sensor for the CPU. The register layout differs from other chips,
necessitating the creation of a dedicated file for this.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- add IMX91_TMU_ prefix for register define
- remove unused register define
- fix missed pm_runtime_put() at error path in imx91_tmu_get_temp()
- use dev variable in probe function
- use pm_runtime_set_active() in probe
- move START to imx91_tmu_get_temp()
- use DEFINE_RUNTIME_DEV_PM_OPS()
- keep set reset value because there are not sw "reset" bit in controller,
uboot may change and enable tmu.

change from v1 to v2
- use low case for hexvalue
- combine struct imx91_tmu and tmu_sensor
- simplify imx91_tmu_start() and imx91_tmu_enable()
- use s16 for imx91_tmu_get_temp(), which may negative value
- use reverse christmas tree style
- use run time pm
- use oneshot to sample temp
- register thermal zone after hardware init
---
 drivers/thermal/Kconfig         |  10 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/imx91_thermal.c | 263 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d3f9686e26e71..da403ed86aeb1 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -296,6 +296,16 @@ config IMX8MM_THERMAL
 	  cpufreq is used as the cooling device to throttle CPUs when the passive
 	  trip is crossed.
 
+config IMX91_THERMAL
+	tristate "Temperature sensor driver for NXP i.MX91 SoC"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on OF
+	help
+	  Support for Temperature sensor found on NXP i.MX91 SoC.
+	  It supports one critical trip point and one passive trip point. The
+	  cpufreq is used as the cooling device to throttle CPUs when the passive
+	  trip is crossed.
+
 config K3_THERMAL
 	tristate "Texas Instruments K3 thermal support"
 	depends on ARCH_K3 || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 9abf43a74f2bb..08da241e6a598 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_IMX_SC_THERMAL)	+= imx_sc_thermal.o
 obj-$(CONFIG_IMX8MM_THERMAL)	+= imx8mm_thermal.o
+obj-$(CONFIG_IMX91_THERMAL)	+= imx91_thermal.o
 obj-$(CONFIG_MAX77620_THERMAL)	+= max77620_thermal.o
 obj-$(CONFIG_QORIQ_THERMAL)	+= qoriq_thermal.o
 obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
new file mode 100644
index 0000000000000..62b579365fd03
--- /dev/null
+++ b/drivers/thermal/imx91_thermal.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2024 NXP.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/thermal.h>
+
+#define IMX91_TMU_STAT0				0x10
+#define IMX91_TMU_STAT0_DRDY0_IF_MASK		BIT(16)
+
+#define IMX91_TMU_DATA0				0x20
+
+#define IMX91_TMU_CTRL1_SET			0x204
+#define IMX91_TMU_CTRL1_CLR			0x208
+#define IMX91_TMU_CTRL1_EN			BIT(31)
+#define IMX91_TMU_CTRL1_START			BIT(30)
+#define IMX91_TMU_CTRL1_STOP			BIT(29)
+#define IMX91_TMU_CTRL1_RES_MASK		GENMASK(19, 18)
+#define IMX91_TMU_CTRL1_MEAS_MODE_MASK		GENMASK(25, 24)
+#define   IMX91_TMU_CTRL1_MEAS_MODE_SINGLE	0
+#define   IMX91_TMU_CTRL1_MEAS_MODE_CONTINUES	1
+#define   IMX91_TMU_CTRL1_MEAS_MODE_PERIODIC	2
+
+#define IMX91_TMU_REF_DIV			0x280
+#define IMX91_TMU_DIV_EN			BIT(31)
+#define IMX91_TMU_DIV_MASK			GENMASK(23, 16)
+#define IMX91_TMU_DIV_MAX			255
+
+#define IMX91_TMU_PUD_ST_CTRL			0x2b0
+#define IMX91_TMU_PUDL_MASK			GENMASK(23, 16)
+
+#define IMX91_TMU_TRIM1				0x2e0
+#define IMX91_TMU_TRIM2				0x2f0
+
+#define IMX91_TMU_TEMP_LOW_LIMIT		-40000
+#define IMX91_TMU_TEMP_HIGH_LIMIT		125000
+
+#define IMX91_TMU_DEFAULT_TRIM1_CONFIG		0xb561bc2d
+#define IMX91_TMU_DEFAULT_TRIM2_CONFIG		0x65d4
+
+struct imx91_tmu {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *dev;
+	struct thermal_zone_device *tzd;
+};
+
+static void imx91_tmu_start(struct imx91_tmu *tmu, bool start)
+{
+	u32 val = start ? IMX91_TMU_CTRL1_START : IMX91_TMU_CTRL1_STOP;
+
+	writel_relaxed(val, tmu->base + IMX91_TMU_CTRL1_SET);
+}
+
+static void imx91_tmu_enable(struct imx91_tmu *tmu, bool enable)
+{
+	u32 reg = enable ? IMX91_TMU_CTRL1_SET : IMX91_TMU_CTRL1_CLR;
+
+	writel_relaxed(IMX91_TMU_CTRL1_EN, tmu->base + reg);
+}
+
+static int imx91_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct imx91_tmu *tmu = thermal_zone_device_priv(tz);
+	s16 data;
+	int ret;
+	u32 val;
+
+	ret = pm_runtime_resume_and_get(tmu->dev);
+	if (ret < 0)
+		return ret;
+
+	imx91_tmu_start(tmu, true);
+
+	ret = readl_relaxed_poll_timeout(tmu->base + IMX91_TMU_STAT0, val,
+					 val & IMX91_TMU_STAT0_DRDY0_IF_MASK, 1000, 40000);
+	if (ret) {
+		ret = -EAGAIN;
+		goto out;
+	}
+
+	/* DATA0 is 16bit signed number */
+	data = readw_relaxed(tmu->base + IMX91_TMU_DATA0);
+	*temp = data * 1000 / 64;
+	if (*temp < IMX91_TMU_TEMP_LOW_LIMIT || *temp > IMX91_TMU_TEMP_HIGH_LIMIT)
+		ret = -EAGAIN;
+
+out:
+	pm_runtime_put(tmu->dev);
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops tmu_tz_ops = {
+	.get_temp = imx91_tmu_get_temp,
+};
+
+static int imx91_init_from_nvmem_cells(struct imx91_tmu *tmu)
+{
+	struct device *dev = tmu->dev;
+	u32 trim1, trim2;
+	int ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim1", &trim1);
+	if (ret)
+		return ret;
+
+	ret = nvmem_cell_read_u32(dev, "trim2", &trim2);
+	if (ret)
+		return ret;
+
+	if (trim1 == 0 || trim2 == 0)
+		return -EINVAL;
+
+	writel_relaxed(trim1, tmu->base + IMX91_TMU_TRIM1);
+	writel_relaxed(trim2, tmu->base + IMX91_TMU_TRIM2);
+
+	return 0;
+}
+
+static int imx91_tmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx91_tmu *tmu;
+	unsigned long rate;
+	u32 div;
+	int ret;
+
+	tmu = devm_kzalloc(dev, sizeof(struct imx91_tmu), GFP_KERNEL);
+	if (!tmu)
+		return -ENOMEM;
+
+	tmu->dev = dev;
+
+	tmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tmu->base))
+		return dev_err_probe(dev, PTR_ERR(tmu->base), "failed to get io resource");
+
+	tmu->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(tmu->clk))
+		return dev_err_probe(dev, PTR_ERR(tmu->clk), "failed to get tmu clock\n");
+
+	platform_set_drvdata(pdev, tmu);
+
+	/* disable the monitor during initialization */
+	imx91_tmu_enable(tmu, false);
+	imx91_tmu_start(tmu, false);
+
+	ret = imx91_init_from_nvmem_cells(tmu);
+	if (ret) {
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM1_CONFIG, tmu->base + IMX91_TMU_TRIM1);
+		writel_relaxed(IMX91_TMU_DEFAULT_TRIM2_CONFIG, tmu->base + IMX91_TMU_TRIM2);
+	}
+
+	/* The typical conv clk is 4MHz, the output freq is 'rate / (div + 1)' */
+	rate = clk_get_rate(tmu->clk);
+	div = (rate / 4000000) - 1;
+	if (div > IMX91_TMU_DIV_MAX)
+		return dev_err_probe(dev, -EINVAL, "clock divider exceed hardware limiation");
+
+	/* Set divider value and enable divider */
+	writel_relaxed(IMX91_TMU_DIV_EN | FIELD_PREP(IMX91_TMU_DIV_MASK, div),
+		       tmu->base + IMX91_TMU_REF_DIV);
+
+	/* Set max power up delay: 'Tpud(ms) = 0xFF * 1000 / 4000000' */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_PUDL_MASK, 100U), tmu->base + IMX91_TMU_PUD_ST_CTRL);
+
+	/*
+	 * Set resolution mode
+	 * 00b - Conversion time = 0.59325 ms
+	 * 01b - Conversion time = 1.10525 ms
+	 * 10b - Conversion time = 2.12925 ms
+	 * 11b - Conversion time = 4.17725 ms
+	 */
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x3), tmu->base + IMX91_TMU_CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_RES_MASK, 0x1), tmu->base + IMX91_TMU_CTRL1_SET);
+
+	writel_relaxed(IMX91_TMU_CTRL1_MEAS_MODE_MASK, tmu->base + IMX91_TMU_CTRL1_CLR);
+	writel_relaxed(FIELD_PREP(IMX91_TMU_CTRL1_MEAS_MODE_MASK, IMX91_TMU_CTRL1_MEAS_MODE_SINGLE),
+		       tmu->base + IMX91_TMU_CTRL1_SET);
+
+	imx91_tmu_enable(tmu, true);
+	pm_runtime_set_active(dev);
+	devm_pm_runtime_enable(dev);
+
+	tmu->tzd = devm_thermal_of_zone_register(dev, 0, tmu, &tmu_tz_ops);
+	if (IS_ERR(tmu->tzd))
+		return dev_err_probe(dev, PTR_ERR(tmu->tzd),
+				     "failed to register thermal zone sensor\n");
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static void imx91_tmu_remove(struct platform_device *pdev)
+{
+	struct imx91_tmu *tmu = platform_get_drvdata(pdev);
+
+	/* disable tmu */
+	imx91_tmu_start(tmu, false);
+	imx91_tmu_enable(tmu, false);
+}
+
+static int imx91_tmu_runtime_suspend(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+
+	/* disable tmu */
+	imx91_tmu_enable(tmu, false);
+
+	clk_disable_unprepare(tmu->clk);
+
+	return 0;
+}
+
+static int imx91_tmu_runtime_resume(struct device *dev)
+{
+	struct imx91_tmu *tmu = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(tmu->clk);
+	if (ret)
+		return ret;
+
+	imx91_tmu_enable(tmu, true);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(imx91_tmu_pm_ops, imx91_tmu_runtime_suspend,
+				 imx91_tmu_runtime_resume, NULL);
+
+static const struct of_device_id imx91_tmu_table[] = {
+	{ .compatible = "fsl,imx91-tmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx91_tmu_table);
+
+static struct platform_driver imx91_tmu = {
+	.driver = {
+		.name	= "imx91_thermal",
+		.pm	= pm_ptr(&imx91_tmu_pm_ops),
+		.of_match_table = imx91_tmu_table,
+	},
+	.probe = imx91_tmu_probe,
+	.remove = imx91_tmu_remove,
+};
+module_platform_driver(imx91_tmu);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("i.MX91 Thermal Monitor Unit driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


