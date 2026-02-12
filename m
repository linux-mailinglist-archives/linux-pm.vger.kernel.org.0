Return-Path: <linux-pm+bounces-42537-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF7vG6pyjWn42gAAu9opvQ
	(envelope-from <linux-pm+bounces-42537-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 07:26:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 244A812A9AC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 07:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A63593034956
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AFB296BC5;
	Thu, 12 Feb 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRoqWyXl"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7228BAB9;
	Thu, 12 Feb 2026 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877595; cv=fail; b=Pze7A23LH8ErPBcP26nblrpCdZYbJNNQ4KusMIpcf4I1qnqYa8bM1o9rKC3EGvxZqhrWr2ku6BeSj+QlDjHSNGbud/bgRRVDW7Fwe2ba5+1ZngMo2RmsoxqrCrdCyDxj0aaGSpu3hY8OkECmyXEOcjwQRg40JM1z650hSeXdwu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877595; c=relaxed/simple;
	bh=XVHcnYSsPlUyGKb7o32oFDV8W80ou/GD8cVqOl/yvRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gjRn63mU66zonO8heyc04dtkl74SMIQt8l5F9l/+3nBa36AlWfyfLmdpAqjl1Mr9d79/4K6eft0R55zURIy4cvslbgCwD7D32cgtcl62+dj3nHBzXErU1oNofzVFvJ3FICc1eo3rW56x/uwMf9NNhtpSY/IrRDbIK9rEsceU0l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRoqWyXl; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGiYgHNMGJ0JTa4Ai6H7l6KquJwDFgqE9IkoDRBVvG9Sb+7uRaQ3DB87zCrHKY+LXWD2b4hhtpt8RcEUGinBN/2LifDgvL/GcUdUqyX1+DKHBb0Ql0BC43w+UhoeAx7hrJyUQQKTyfLiJMUNieT3fveWDYTO5EArOS4SA6/01nhKoc2h+5VMtCyad37T3tMURu56UwKpB5nMaL1/L6LKwB1F4ietaCQwP7mR+8hJTwHHev7sJqKADugoZwiEDsH69eUINZ+wxqSefsaMRHovmq8GaNYB/XeWulFCBchF/CJDv8MuSsmtLQy/VjNhjAjHUxtSvVshRcZXg9Vr+ZJtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVHcnYSsPlUyGKb7o32oFDV8W80ou/GD8cVqOl/yvRE=;
 b=GMl+TFVLrgcrTQ/mXZVgVEOWIjTAk8vS57afx4Ow3oMbrrEuhzPLpK1jUWbfUxCDxq5caDb8uxoN0fGtn6w2Jqq04zmZhODxHKOCPONFnm9lF6F2y6awTQlmWJpvBqZA+rnYgdVTD9cxZ9ZNQRnwjmDGKbnwOeWhsu8NCjOv31ZJpYD0ZPffQwCVAvX8wHv/D5ywClVYm0oJmGQM1rGDIyMU5mnZFazpZPVj/Mxp2s0fEumKKHAir/OuyyeVR8ZmHWDruyVm1l79JCo1k6/uO6tcpMAbvow94uk9Ct9BgSXNCOv6WB83o3QahaYSG9rDElTqbysUDI3IYuMre3C+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVHcnYSsPlUyGKb7o32oFDV8W80ou/GD8cVqOl/yvRE=;
 b=cRoqWyXlxT+LQFChg475dwnf8so9BixtYYTXPg/pxBwgBlhrHLesIokedPjCxHdtnvqO1PZ/6Dj+pQ1XvpKegYIeywZyoAn9lVQtluQ5VdRF5DdMMhH3p84qF9z5Fdal1oQ8ou5/vMeSFMDut1xF/qnOE5p5sl/BbftOghHRIpXKrq4fgcYkIF4730o4Axq92NffJQqz8hn+Tffc5V7Bivwu1Yz4Cef4TtZypuVfGqm92yIVnCt1tpJGkFQU4gCSjXLz3y2H693wsDKFrsFCmbs+WUSw7uGtf/XvaZ/kxDAtIUrQeaqVF1CjwBrH9msrG1NmxfyDlSemVHXXpEVRzA==
Received: from DBAPR04MB7206.eurprd04.prod.outlook.com (2603:10a6:10:1a4::17)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 06:26:30 +0000
Received: from DBAPR04MB7206.eurprd04.prod.outlook.com
 ([fe80::707e:386e:2a74:b5ff]) by DBAPR04MB7206.eurprd04.prod.outlook.com
 ([fe80::707e:386e:2a74:b5ff%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 06:26:30 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: RE: [PATCH v4] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Thread-Topic: [PATCH v4] pmdomain: imx: gpcv2: Fix the imx8mm gpu hang due to
 wrong adb400 reset
Thread-Index: AQHcl3baeEHzFQIk4UGNZxKNb/VGo7V9pTmAgAD616A=
Date: Thu, 12 Feb 2026 06:26:30 +0000
Message-ID:
 <DBAPR04MB7206934830677A58DDDBA71B8760A@DBAPR04MB7206.eurprd04.prod.outlook.com>
References: <20260206-imx8mm_gpu_power_domain-v4-1-52fb603da502@nxp.com>
 <CAPDyKFqkXBa=9qW0rd4=Cf2gjVAVDw3No5DbnSQ4OFuze00Yfg@mail.gmail.com>
In-Reply-To:
 <CAPDyKFqkXBa=9qW0rd4=Cf2gjVAVDw3No5DbnSQ4OFuze00Yfg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR04MB7206:EE_|PAXPR04MB8206:EE_
x-ms-office365-filtering-correlation-id: 66bbedd8-0d07-4d2d-83a9-08de69ffa8f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R2RjemtDVUtoaUxXOSthREFUQk1yVVMrZUtocmVCMi9MVVZlQTBOekVPUG9t?=
 =?utf-8?B?UVlwK3RnWW1RazFtZ1RMQVRpMGZDS0ZKZzl5SGYwVkJwQjdOc09EMGlxVGJT?=
 =?utf-8?B?US9FZnlQcFR0S3ZpMmFmb2l2Y2hRWU1RQjNaL3J5dkZJaVBFS2FUbmxkNDFW?=
 =?utf-8?B?dnRMSkNZd2lJYnJJVndsTDJtdzNsc0lpWUZLZWFsR2kxSzhhdDEzZHRXSWM3?=
 =?utf-8?B?QVFYTFlhUHFSYmJGZWJoa2prRnRwSk9obE85YW9zdlE5Z3VabnZUMTZpc1J3?=
 =?utf-8?B?dHIvYWg3bUJOYXlSNU4yMmhJRklPaHpkSVE1cEh3dHpzblloUVJRWU1SYVBn?=
 =?utf-8?B?WUh5VDFLYzZUbW1leFRncGFudFl0azgxQ1ptSjdCRHJpTlRZMWJaRS8rZVMw?=
 =?utf-8?B?VnExWW1QcW15WDA2SEJwdGlnem9rektvZnJnWlRjVWJSMitPbkRTMXI4NG42?=
 =?utf-8?B?UlNKQWg4MDJkdkM4aVgydVBtZ0tKQXdkUWhpYkFIdUxtNCtSQnJ2QnplQkh4?=
 =?utf-8?B?OTY5NXk2b1lNSjVqMjVFN3hJYVFiNjhkZFJVamZoQ1hmSm9kTHVKOE1xM0U4?=
 =?utf-8?B?a0ZZZ1dEUXZodUxUUTJkRDZxczg5cVVIY3ROK3Q5aEFwa0NlSFdIUjVUNlVL?=
 =?utf-8?B?R0xyZkdXUHJ2V09qM0JKV3R4dWV5eVVuclNDZlVZYlpkOVdUNmRXZTBGcU9D?=
 =?utf-8?B?KzR4ckZIUW9EQ09uVm4rOHI1aFJLMk45WUNCdExOZzhQczcwVzRzenR2bElG?=
 =?utf-8?B?cllrc042MXBoTnlQQmhqTGhFTkJ2WHVRektrc2VCRjdjTXVDU2N5QzIwcWpk?=
 =?utf-8?B?S2Y0Sm9NVTM2STBEcFd3YVlFWGtHOXlWRG9YZFBka05XbGRZYjZGR2Zka2dn?=
 =?utf-8?B?dHExaW9yTnhWVXA5Nk94Z3NJT2Exc1pBRno0Tno5YVBWcE92RWxkRHl3c2M0?=
 =?utf-8?B?YVRWRDJNMmZuS0JHSXViSmI0eW5kNVcyaUJwK0huOENiYURFc0VuSmsvOW14?=
 =?utf-8?B?S2R4N1RWSk1xVncwdmdpa1BSSDE3M1Y2ZGhudWJtSDFFam4xRXYraURuNHlV?=
 =?utf-8?B?RnAwY0ZIMmVCNnA1aUk2K3ZBRTNRYnJESXVVemV5N1Q5TE5pOGl4Z3pKakNx?=
 =?utf-8?B?SHNiVTg1ZGJQRjF2QVIxQ0RGSzZPRTRndUpSdVBFQXkrcHIzUXdhbEdxa1BU?=
 =?utf-8?B?dXJBak10Mi8zL1NPQTM3eUVmd3R5VmVvcmw2QzlNQXlka3owZG1xajQ3dWs4?=
 =?utf-8?B?d09iMmVWVk1iVm9LU2ZidzNiYjdRNkl4YVdVcUJUVTM2N3lNVGxSWkRHVElT?=
 =?utf-8?B?dkVKaVVuT2g3aHQrbDFSOGhMNDZza08yQUd1RCttdGhVcFp0VDVWMThYTjQ1?=
 =?utf-8?B?RDRLVFNNcXZyRTk3bUo2QjduMUI3NVFsUXcwOHVTZlZTTWQ1aWJsejZYMVVH?=
 =?utf-8?B?VVh6bzIzNGlid1dZSElSK3oySXAwZ1kxS0p0UFVaU0hORE5ZejIvaG1DeHRX?=
 =?utf-8?B?ckFDSFExRzhtQXgvNmVCT3M4WUlZVHBMb2VkQ2xEcElwSVZrVGt1elEvMmtl?=
 =?utf-8?B?c01iM0tlOFJJMU4wbjBYaG42cTE3SUR5VS9LbnU4U1A3aGNEMzdWNVJ3bXZ3?=
 =?utf-8?B?ZDRMck5PSklBM1Qzb3VJcVo2RzRHMWp6OThwcUlBRXhzaSt4VGFwSmtzQWRX?=
 =?utf-8?B?d3Q2ZllSemNiU2VIb3NLaGZHM0VrelBzckVUQlNBMGFEU3ltTWFBZE5vZFMx?=
 =?utf-8?B?TGRXTGVzY2VEVXczY0t6NEZCOXQ2NitrYlFwTXgzem9nWitTSzVkQkU4dkdv?=
 =?utf-8?B?Y3FyZzZmcFNsS25ycCsyTDJvWjZzUUxHOVZPOHJ5cGpEclQrOHVBaGxaRmR4?=
 =?utf-8?B?bDFzV0FVMkRHeXlKME1WMHd5MlgwNnMzcUIweUl5dFhvbVNCYWR4aHE2RXZ4?=
 =?utf-8?B?WHhydEtraDlNdFVETUE5b1NvTWh5L1lyZVlQbjY3eStXNU9yVWpSdUVIMHVD?=
 =?utf-8?B?UkpWbTV1bSswdTE5QzYxWDdXMFRMNHozQmFSRlJPalVsdWZEL3VXVmFuWDVD?=
 =?utf-8?B?TXRML0pTNVc0WHFZZFpLbk1hK2thcEwyZkpwakxzdTVHc3JudXVyUWtnYkJN?=
 =?utf-8?B?TXRlSUpsa2lNdDJ4WlhiS3ZWa1JrQ2JuN1ZJajBlNlpkVTltOGFXRENLcTl0?=
 =?utf-8?Q?h/HxrU1GjYEP86vsR2WKexo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7206.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a01VV1ZnMzdiTjZJSjFQa2xpZmJ3NlNpUUdzb2pVb1g3UFBmZlZEYlJRQisv?=
 =?utf-8?B?T0RxdlEvaHZKTWl3clBibm1XR1p3Q2xEWWxoUDFwV210K2taaHJNcDN5ZXND?=
 =?utf-8?B?ckJBcEcxZ1RVbCtpYzJ1aU9YM2V0ejc5RzRuMzA2SzI3b21jYmd4cC9WeWRZ?=
 =?utf-8?B?SnMzOVBmamZZeXZtcFdicFJDd2dMcHR5QnhXNkR4WnFvUUdRckI0emd5Zm1V?=
 =?utf-8?B?dElMSjk0Yk1uN2NsZ0NkajdaZjVoeGdGM3laY3E5Rk0rUXBpaE9oU2Z5YU42?=
 =?utf-8?B?eUF4WGFYaFBBN1RLQ2ZTMFZ2YndTclJsM3ZtNE8ybmkySE92WXozZzVpbGZC?=
 =?utf-8?B?U1kxdHA1ODBWQU5veFdqYjF2M1FTVGdXclpvdmZ0N09HVzcvSktoZ3drVTR1?=
 =?utf-8?B?UGFHRExTQk1HSWRxdyt2NXpLMjBmTzZlelQ1aFVCZjlZT2d3TzBmMHliOEFZ?=
 =?utf-8?B?VitIa3lEYW5mMk51eG90Q0NuTExtS0RUSE5jbTNiWXVCeEhmVDBxU2syLzk4?=
 =?utf-8?B?VUNvV1ByeHBSZ2RHTU9QSFNSSUxUenZsZGNLWG40ZXI4dTBONlRFejIzWjdK?=
 =?utf-8?B?aXU2OWhmZDUrN1Zjc0QvbXQ5blhja05nRVM0UW5idDh3c3lGWk1DR2hKVS9n?=
 =?utf-8?B?SmN3YzIrWnZIcGdPRnFmMlMyQk41d2JhSFZTdThzblFYUEdRMWJIUUg0aE5W?=
 =?utf-8?B?WG01eUVyZ3JrQ0pJYUNtUS84QmhhTHo1NDM1TEFnWjdmbTg5cVlEVFR1QTVx?=
 =?utf-8?B?Uk1yVWkyNlVxam9PRTFScy9HeVBKY3VpU3F5M0NLM1BOYnFPU3J2S3FmNUpj?=
 =?utf-8?B?L2NnMEEwQ0xUVU5EZUd1TnlLc1RtNjdYM0NEVWFEUGNaU0dtZ3V4UmdKbDhK?=
 =?utf-8?B?MURKaUM3WU5wODJvOE50Y0NKRFE2ZDF1eWoyZ2R4dHUzQ0MzdTdMaUVoeWV3?=
 =?utf-8?B?RmRUS09ESW9yV0RaNzJCRnl3V2plUmQyTXZqZmtqUHV1eFJOallGUTJpUmpa?=
 =?utf-8?B?UlNOQkp3SEZ2OUNnaFFKeHZBQkxjYXdLZzduckNBR3k4YUQ0aG1RbWJMM1g4?=
 =?utf-8?B?UXVTbnFsZkJXNHVCUW1jMGplcStYSDR3Q1NrUzVNeSs5ejk2NkJqRGhQbHVW?=
 =?utf-8?B?SUhNQU9uZlhGK09jNld2SnJYNy9scHljUkdxWlBqNmQwMGQ3Z01uVWJURzNS?=
 =?utf-8?B?bDA1YjJwaXpxQ0Frbkk4NXpWQlQvVWdrVmZsQ2FPUlRVR2FGOUN3TTAwMi9H?=
 =?utf-8?B?b1pYRzJsV3VmWHlmWjNQcVRIYWpPS1VyVGEzdmsvQVpybGUwYUJSOXFPUnBo?=
 =?utf-8?B?TzV3aXRDWlB6bEN1V3B4MzRHMS9jRWNkMzR1bnA5QUhxSHJCalF0K0FvWUNr?=
 =?utf-8?B?TzhJRmh0ZHY0VGY0VVhlRmRBeWtQRFVxdnluTkNOem11dVplWnhaOXM0Nmd3?=
 =?utf-8?B?YUpEb0Zqbm9MNVVQdUVTeS9ZSzRNa3NzK3oxaVN3b2FvWE1PY3doeXY2bURW?=
 =?utf-8?B?ZUppVEhxTWFNSTdZK2VlV0lBNjFlNHZ0eVM5L0FwUkJxeUFseW96MTlmZjRN?=
 =?utf-8?B?UWdpNnFCRVpRK3lPT2dWZWpxTXN3RFhOZmF0NjQxTkc3YjlyazU4cXBCeEY3?=
 =?utf-8?B?c1pyRldibEtZdXkvTnpJL3BEUU5BUXlpV0JWN1pSVG1oQklyem5qR3Q0Z0tJ?=
 =?utf-8?B?SUpjcVFYNnkrZ3Rxazh5WVpNZUgxa1B4K3FSR1ZDZVgyMDUzZ0pHbWE3bm9a?=
 =?utf-8?B?Y1pveE5ITHRIYTgrc0xoOEpBd0VsUmkwNjRKSk5UWFRab0lBTUhDNXR5dnhv?=
 =?utf-8?B?ZVU4MVZYNWFlNHN2cjZtWUQ5N1BLQmh5Ti90c0RHcWRnWXdiMG1mc1l0WGRV?=
 =?utf-8?B?SnB2UStBd2Vudk1scVJ1ZkFnVVJ2RW1IaGZjZlY3dE5XSTU3bENRUFJTaFpp?=
 =?utf-8?B?ekdlLzRmZzA5bFZUak5DalcyV212K1dDRkZSOTYwK2wwRk8yZlYvMGVhUEZS?=
 =?utf-8?B?TVR4UmdWc25nUzN3ZnZPcEV6TFJITEIxQ29GNkpMK0VvQXV1QmV6UkZZRFJK?=
 =?utf-8?B?SzFWWTFKaUNFczNhT2dGUkt1WlpScTVuenJ4TElFWGlTNVNvNFV0WU1qeUM2?=
 =?utf-8?B?aVNXWXlvWld4eVNyaGZFbThHeFZ4NGFITUJQcUVnTVh0VVdFTjBpelV1cmdW?=
 =?utf-8?B?aUtjK1dzTmYyZnEvOXFBNDlwNE5POGxLSVprNlZoRWVzaEhJRGkzZEVwSTdn?=
 =?utf-8?B?YVc3bGZnM3I0NUc2ZlRUVjVzcDlKRndtRVNVZEY4WktEdExSRXEvQ3lxSklu?=
 =?utf-8?Q?soAOmLJ5Z26s6vi3Kf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7206.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbedd8-0d07-4d2d-83a9-08de69ffa8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 06:26:30.5395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mb8sFoxNur8hE9UYo12U6fOxSMlOpbf66iVYZPhaf6+UHoI3mu3DfpBUTHYtkNWEO5MphgWUuf/dYJ4GckRo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42537-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ping.bai@nxp.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,DBAPR04MB7206.eurprd04.prod.outlook.com:mid,pengutronix.de:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 244A812A9AC
X-Rspamd-Action: no action

SGkgVWxmLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIHBtZG9tYWluOiBpbXg6IGdwY3Yy
OiBGaXggdGhlIGlteDhtbSBncHUgaGFuZyBkdWUgdG8NCj4gd3JvbmcgYWRiNDAwIHJlc2V0DQo+
IA0KPiBPbiBGcmksIDYgRmViIDIwMjYgYXQgMTU6NDIsIEphY2t5IEJhaSA8cGluZy5iYWlAbnhw
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBpLk1YOE1NLCB0aGUgR1BVTUlYLCBHUFUyRCwgYW5k
IEdQVTNEIGJsb2NrcyBzaGFyZSBhIGNvbW1vbiByZXNldA0KPiA+IGRvbWFpbi4gRHVlIHRvIHRo
aXMgaGFyZHdhcmUgbGltaXRhdGlvbiwgcG93ZXJpbmcgb2ZmL29uIEdQVTJEIG9yDQo+ID4gR1BV
M0QgYWxzbyB0cmlnZ2VycyBhIHJlc2V0IG9mIHRoZSBHUFVNSVggZG9tYWluLCBpbmNsdWRpbmcg
aXRzIEFEQjQwMCBwb3J0Lg0KPiA+IEhvd2V2ZXIsIHRoZSBBREI0MDAgaW50ZXJmYWNlIG11c3Qg
YWx3YXlzIGJlIHBsYWNlZCBpbnRvIHBvd2Vy4oCRZG93bg0KPiA+IG1vZGUgYmVmb3JlIGJlaW5n
IHJlc2V0Lg0KPiA+DQo+ID4gQ3VycmVudGx5IHRoZSBHUFVNSVggYW5kIEdQVTJELzNEIHBvd2Vy
IGRvbWFpbnMgcmVseSBvbiBydW50aW1lIFBNIHRvDQo+ID4gaGFuZGxlIGRlcGVuZGVuY3kgb3Jk
ZXJpbmcuIEluIHNvbWUgY29ybmVyIGNhc2VzLCB0aGUgR1BVTUlYIHBvd2VyIG9mZg0KPiA+IHNl
cXVlbmNlIGlzIHNraXBwZWQsIGxlYXZpbmcgdGhlIEFEQjQwMCBwb3J0IGFjdGl2ZSB3aGVuIEdQ
VTJELzNEIHJlc2V0Lg0KPiA+IFRoaXMgY2F1c2VzIHRoZSBHUFVNSVggQURCNDAwIHBvcnQgdG8g
YmUgcmVzZXQgd2hpbGUgc3RpbGwgYWN0aXZlLA0KPiA+IGxlYWRpbmcgdG8gdW5wcmVkaWN0YWJs
ZSBidXMgYmVoYXZpb3IgYW5kIEdQVSBoYW5ncy4NCj4gPg0KPiA+IFRvIGF2b2lkIHRoaXMsIHJl
ZmluZSB0aGUgcG93ZXLigJFkb21haW4gY29udHJvbCBsb2dpYyBzbyB0aGF0IHRoZQ0KPiA+IEdQ
VU1JWA0KPiA+IEFEQjQwMCBwb3J0IGlzIGV4cGxpY2l0bHkgcG93ZXJlZCBkb3duIGFuZCBwb3dl
cmVkIHVwIGFzIHBhcnQgb2YgdGhlDQo+ID4gR1BVIHBvd2VyIGRvbWFpbiBvbi9vZmYgc2VxdWVu
Y2UuIFRoaXMgZW5zdXJlcyBwcm9wZXIgb3JkZXJpbmcgYW5kDQo+ID4gcHJldmVudHMgaW5jb3Jy
ZWN0IEFEQjQwMCByZXNldC4NCj4gPg0KPiA+IEZpeGVzOiAwNTU0NjczNzhiZjEgKCJkcml2ZXIg
Y29yZTogRW5hYmxlIGZ3X2Rldmxpbms9cnBtIGJ5IGRlZmF1bHQiKQ0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gU3VnZ2VzdGVkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBw
ZW5ndXRyb25peC5kZT4NCj4gPiBSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+DQo+ID4gVGVzdGVkLWJ5OiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1
dHJvbml4LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNv
bT4NCj4gDQo+IFRoaXMgZG9lc24ndCBhcHBseSBjbGVhbmx5IG9uIG15IG5leHQgYnJhbmNoLCBj
YW4geW91IHBsZWFzZSByZWJhc2UgYW5kDQo+IHJlLXN1Ym1pdCBhIG5ldyB2ZXJzaW9uPw0KPiAN
Cg0KRm9yIFY0LCBJIGp1c3QgYWRkZWQgdGhlIEZpeGVzIGFuZCBDYyBzdGFibGUga2VybmVsIHRh
Zywgbm8gb3RoZXIgY2hhbmdlcy4NCkFzIEkgc2F3IHlvdSBoYXZlIGFscmVhZHkgcGlja2VkIHRo
ZSB2MyBwYXRjaCwgeW91IGNhbiBpZ25vcmUgdGhpcyBmb3Igbm93Lg0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgdGltZS4gXl9eDQoNCkJSDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZlDQo+IA0KPiA+IC0t
LQ0KDQo=

