Return-Path: <linux-pm+bounces-35068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38064B8AA76
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C175F5661E3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CB31FED4;
	Fri, 19 Sep 2025 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NHMEMN5w"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010063.outbound.protection.outlook.com [52.101.228.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A688319601;
	Fri, 19 Sep 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300937; cv=fail; b=UBdQEeEjeo55VlXsT3sQIrzNH0ncyq+jiJe1aPppJKxRsWE4bYAQyAwTBZ6+Lx23GIeSAMBewrssHJ6ohrRXHOsnCZ6dE7govp0RsyChgQMwjmgBps6xYkK+uC3MQNSnH9SFZ2XMlf2XrTSADyc9bDKcyeUn0p7f/VHiVgrSQOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300937; c=relaxed/simple;
	bh=VrxF7Gn88oEmIP6JWr0ay6RcYvWzefkBQ+Z5fPYkaPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PD0j+KcYZToKHWSOp0W74LQhm2/Yo7D1g+e8/vtnItl+jGLWkIrWfw/wGGt4KPkdOf5IiPRcM6+8YKnqQAPKniIJj2kbwgokP/iyU2ESTTgj0xu0KnwC/NQB9SU6jMa5F0S7l7xpyRJsdGbo/T9HcvBm+59d1etWHRwmNnTuIpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=NHMEMN5w; arc=fail smtp.client-ip=52.101.228.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8juSV+ADGkxkoMu0RG0hajkkWV3JYOoiFGac9L12xq/dqWQMETRHBe1GJFxQOeGIVuFM3d7Erxx4TSMl0iLQkgcKAKafm9XbK5plArSba4VNT/HXbQ+VgsVR86ZFrE4PPSHE64aM7N02oZTQVXVmgNbXoRAAgUMFYU0ICjkejcGRZ1vTiFTc7ysxTsmpIdBBbXVuT/fgnldP+kRTSE4dxPDnBlBov1loOcpqvJoP9qayY0OEJt1aSp5CoOWuqBNJuTifSJT3ZP9go0WTOAIyx6ZXy3d13DtvoGk4OQsHX0nYub7dVDincoj5obtzmfJ6Qq3ERHzx+4SK6OR77jqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrxF7Gn88oEmIP6JWr0ay6RcYvWzefkBQ+Z5fPYkaPQ=;
 b=sllsPLk5ITfIms7QFbSoK15JFQsy7OygXxbDICc1OqU22qhy6F2fFUbuLC83DJpU2/iZ0dcT0WOwV1mUK2qaEsPcRj6A3XX10U1tDbMkntAWSHT/ZVXwvc/p/A2e+LHOf3HoOkEsb9IkNSd2RIcAkzFivJCa7jlUOBGul+yRduXx9P8dodtyZvlCAqjsAQ4L3BS/jaUpAxAbrs6jaoPE/MiP+mY51WOcYXS27eFzEmyZEZZ5Ovn7PtgQwjwLQ3GztCez4uxIHrfa8QGhfSt0Ra5do+I1KN/qG5hGQ1Rz22x06na6gwRGcjKWjjUD5D8Kkv82PiED5IXBcF/Wmfg+hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrxF7Gn88oEmIP6JWr0ay6RcYvWzefkBQ+Z5fPYkaPQ=;
 b=NHMEMN5wROvq0DuVNvkH1zO22FMWaGDjokRC8KhzYfekuesIQhsnLW0yh1gZQyJdrVgTyJSBEFelAXNf5TUKL/O0AMF3a1TWmyfYlRpwGuSLk/4wlNpe+VPdfuFAFvWjsdVhrtR/Kg86joo3mUn4YoXX8mEUP8mySKts4+1KzG4=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by OS9PR01MB15200.jpnprd01.prod.outlook.com (2603:1096:604:3b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Fri, 19 Sep
 2025 16:55:28 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 16:55:27 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, magnus.damm <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "robh@kernel.org"
	<robh@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "will@kernel.org" <will@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "rafael@kernel.org" <rafael@kernel.org>
Subject: RE: [PATCH v9 0/4] thermal: renesas: Add support for RZ/G3E
Thread-Topic: [PATCH v9 0/4] thermal: renesas: Add support for RZ/G3E
Thread-Index: AQHcJ/TeUvgjlZFRN0yPU8o7yk9LyrSat2+AgAABVeA=
Date: Fri, 19 Sep 2025 16:55:27 +0000
Message-ID:
 <OSCPR01MB14647C7F0729C62364D8B6ACCFF11A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
 <71ad53ba-7b72-481f-9b62-1b268cbcd912@linaro.org>
In-Reply-To: <71ad53ba-7b72-481f-9b62-1b268cbcd912@linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|OS9PR01MB15200:EE_
x-ms-office365-filtering-correlation-id: b1c80583-30c5-4aa5-cf78-08ddf79d5567
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZngycFFuMXp6ZFFWQnRUYW9GM212T0lHSVAxL0M4K3NMTk4yZ2ZucXFkZHJw?=
 =?utf-8?B?dEkxNW1jNHlLTkI1b1F5WWZOSmI0eXVrUHpBV25FOXlNK1duQldKbEp4a1U0?=
 =?utf-8?B?MVl4TzFqb1B0elBlbXkzaThUY3lPTkxCaXl2U2d5VFVYcjhIYk1tYk9mc21k?=
 =?utf-8?B?dm5iUlROWnlCK1lLQWZrdVRXS29pdEdhUDF3VUtEMEN0UDBzdk91OXZrdGdw?=
 =?utf-8?B?NlNyamxveVMxNnJTMzRjOXZYelNGa3ZhdjRPNGlXeUJCUVhZbi9QbXJ5QmJp?=
 =?utf-8?B?Wjl4QWdUZmp3eTVCcC9lVS9TNTErTWF4dENlL3lBem5kSFdsSUxYNXpKQWVh?=
 =?utf-8?B?YUhoQkN2NTVWK2J3aVJQb0tOSGxoZXFzZGNMSWVNZHFQVlRud1Jtb2VRVEV2?=
 =?utf-8?B?ODV0M0REOUZrclI3K08xQXVrWk82UEh5L0VRQ2E4K3ZucWtaeWlxVUhmaDRa?=
 =?utf-8?B?VXdkVTZjdWZ6b1NhQ3A1c0xpSWMwSjdLNy9LT3RpMzcveHR4enlhVkx6N1VF?=
 =?utf-8?B?eWhLaXVNSXZPaXRuMFliUHc3c3FYTCt0WUZzNXBQeWpxR3pMUWp4QWN1SEFI?=
 =?utf-8?B?SXR0VUZFUW1nakhoVnlEUDNOZEw2SVc2WGViTGlJOXFhUWVjV3hnd3dKeVFt?=
 =?utf-8?B?cE5OZHk2cVVadlJBVlJjQkFQdXZpUEVERWU3WU54NHJiQkJqdkw4NlAwS1Ra?=
 =?utf-8?B?UWpnTkxIdVU5dUl6VnhSbFM2ZjQ5R0h0cmo4STlaS2gwK001bDBQdGlKS2ox?=
 =?utf-8?B?VjVGdkwvLzA1R3BUWWdYTExHclU1L0szQXlmendlZXl1MWY4bCtKR0F6Yytj?=
 =?utf-8?B?UzNZVERyMWxlMjlJZGZzTGlNNE5zK3ZrOHJIU1RjUlV4YjJjT1k5aU5mKzJF?=
 =?utf-8?B?QlQ2Y2ZCeG9mOXl0TEdEQnJucHdLSE1sVTJia3Q4TDhOTXFsUndlcE5JTXlL?=
 =?utf-8?B?Rld2Z1RISXpMT01ZNTN0YjBQaUxpb0hTclRHc2pQbUVncms2cUV6czZtYzNt?=
 =?utf-8?B?WFU5QldqeWpOZnY4NnYyQ0I4enFiMVEvS09HWWV4dWtwYjZmLzh4SGxUQnpa?=
 =?utf-8?B?ODNxakZkQmhKd1BmSEdNYy93NXhzbXpUaG8vUlE4eGhWWHVLZHUwcGUwcGlj?=
 =?utf-8?B?NlNSVzRXL1d5TXJzSnMrMmlZVVV4b1hLanNhSHlPRDQ2cFhxQ1RJWUlaVElq?=
 =?utf-8?B?YzBtd1RUaWUyR0VJRE53S0ozRGZJaEE3eTZEaXBrVXZHdVRLNGZBYnc4ZmZ0?=
 =?utf-8?B?c2MwcUt6V0tEZzVlcVp3emg4blZ4M0NKUU5mcnN5cjFIQW9STWJWUG5vaG0x?=
 =?utf-8?B?QXVVQTJYemJvRnRSRStZWVdMR2MxUGp3cHNyV0xLdUhxS3NKMjJtbUFLRUVZ?=
 =?utf-8?B?Tmd4NENBTW5aV1RKQkgralZJZHZwaVRieEV3Um83Nlo3V3V5emJlYWxxSTdD?=
 =?utf-8?B?Z1M1OVhMTzNYalI2YlRjdnluYWNKQTkvVmgvSzFmMzUzUTYycTVOMEhFamV2?=
 =?utf-8?B?ODBSdk5SSUpSQkR3OStkOUdmUFhEQUlqdWRDVFc3K3dOREpUWFVFSWQ5Yk5J?=
 =?utf-8?B?UUl3QzNBdU50a2xOc2NBbTNsL01HSzc1N1BPVllVM3p0WkdCNzd1QzhNQ2VJ?=
 =?utf-8?B?UkJBTUJGaFozajF1d0c3c09oaCsvc3dJdHIxMkI3R1pHWVZEL3ZLQWJCRHFj?=
 =?utf-8?B?dmVkNXpsNHMvNGZnVSs0Vy82WHF3Qzg1bE9DU25sVEJSN0RsVVg0UkZydlFz?=
 =?utf-8?B?ZE4zdFpYRzY1NHZUSGV6V2JQYVZtZ2JLaGZOMVhjR091VkxSMCtWUzNvZUpO?=
 =?utf-8?B?NXhWSCtWd1pkcFBCV2I5OE02R2FGRkNoWE9vNmpCVGJ6ZWFkajdiejZLZU5j?=
 =?utf-8?B?RWdBQnErYjU4MzQ1aTNYSGJvaW42UTF6Mnh3K2NuWVNJczMrTm5tMkxid2Z5?=
 =?utf-8?Q?A8z335ZoywnSx1qyPR9qRg2XZLJHprTl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEdvL3FBYzRwNGJKL0IxUXFoZ0xjVHdqYXliNmZkS012WW11N3d0WTNJdGN4?=
 =?utf-8?B?UmdIZnlodmJ6b1RKU2M2N2pZNEpCU2ZNZzI0MXNaL0YzTGZkaml1cmNPcEMw?=
 =?utf-8?B?cnZIQngvWi9haEFxcXErNGZpbkxGTHBsRU9jN0RFOXJkNCtyQlpXaUlObVc0?=
 =?utf-8?B?d2ZuRlM5SU9kcHdNVHNVYVhYeG9Od3M0elZuOEdZcHlCRWtrdzhwY3BaRktD?=
 =?utf-8?B?UzFlYXE0V3FURG9vUTJXcjJacXAzR1l3eThDeXplUUZ4UCtSYkJHa3A2L2t4?=
 =?utf-8?B?azI0SWd0bGxXWnhORjRneWJMR3BWa0hyNXNmamYwdnQ4OXNoS1NzV1ltaGF5?=
 =?utf-8?B?ZmZqcm56Zyt0NEl4bGUwd1hDU1d2WkFBMmd1OWFleHFPck9KWUo2VjBpRzda?=
 =?utf-8?B?blJ2K3kwNGxmMGFScXIreFNXaEpQUUZROGlGRlJPLzBEcDNrR3NabUQ0Nll5?=
 =?utf-8?B?bjRWeHB5bkZaTmJ6NHgzMHRPQWtoZXVYZ1VicGdyMTNuNkcvVTdmSXp3TElN?=
 =?utf-8?B?QkgxRG9tb0pCYzh3Z3pvNlRpQmFhWXF4eXB4Mk8wV0VSbWg5VG52ZTZ2Q1JT?=
 =?utf-8?B?ejFSdEpOSXpqUmlycmNhZlUxd3hTeEF1dloxb0pZbHFKcUNBUGlqeklpZ3lh?=
 =?utf-8?B?OWFxOExxY1pJQ2tmKzNsUElxOUZsWlhQVXc0Nk43ekplV2p5Umc5UW5DSkVk?=
 =?utf-8?B?ZEltWGYyaWYrbGlQR1NEeDlsb1lvZUlHOXNmVzZuY094WnZDOGxZL2haVTNR?=
 =?utf-8?B?RWxHV3lCRUJaWDZxQTFKYlFCSzlaU0FXN0c2QlZBc0xOZ1BiQ1FPUWNjM2N4?=
 =?utf-8?B?RUorUEdJUUlpQzdSdmNaNGdkL0JKc0I4ZmZUMDNObTRNQUtKSVFLQWlFSnlj?=
 =?utf-8?B?OEloQ0VSU0Q4eElzRmJVYUpMeTE1YXl1QXVrODVPSnkzT1NGaE5ZT0NablA4?=
 =?utf-8?B?MkdaYW5PVVpTYk8vTTdYaWtuSCtwcFpvc3JXdDl0R2RobFBZd0hnaWk4cWpi?=
 =?utf-8?B?TGxkcmw2a1gySWh2bjJocDI1ZHpkNGhySzZqcC9ZVTR3cGk4Q3J3N2pqcVV6?=
 =?utf-8?B?ZmUxemV0TExxNWdqeTdLN2N3WFAzZ1puUFVJM2tCeHlxdm52a0FnWmR2aGNp?=
 =?utf-8?B?UmtDSldmYkFEeEo2STJzUmJUVC9EUDRzazdaaDB3Q1B2Y05sZXFhL1lwT0pP?=
 =?utf-8?B?Mm4weTk1YmtTeXd2YlB5aGVFMnFYZS9rM2xHa28vWW5BamxoMjU4MExyZHdI?=
 =?utf-8?B?NHdOVVJ4ektWL0xwWmV2VEFUSll1dUtpazVtZ0oyRDd2MDB4RHdSdzdzVnFh?=
 =?utf-8?B?YjB5ZmpOY01JTXg3UzhSTEpKUmN6VXJqUDZvTmY1WUQyM05KS0E5YnZCZTFM?=
 =?utf-8?B?eGIxRTFNa0RSZm1FY0s2clQzNGIwRSswTVhIU2JmeFgxZXlzMDRKczlydnQ3?=
 =?utf-8?B?bk1SeU4rT253b1luSUZCUFFUU3pBSENTdS9XRUNVT2dKeVdDNDVYMnBjUWNF?=
 =?utf-8?B?S01FUTZoRTc2NjU0Rm16VGxFTG4vTUxiWTV0MGtROFc1RVlsNkF0WXh4RjRX?=
 =?utf-8?B?dnN5ZVd0YU9SV1RZMHpTcFlndkJMcWlCaFZodHdQeEo5dDhSY1VOZkNzNG9o?=
 =?utf-8?B?U1FEeFNYR0hvU2FHWU9uVGZJNUxtUHdDdFFqY0Q3WmhHU0RyZ1crZEhqSFU1?=
 =?utf-8?B?ZW8vcFVBb3NVaEg4RlRCa2lQM3hnd0NjM1hDTU9Yc0x3YU82RzVlQk85dU9l?=
 =?utf-8?B?S05HQTc0NGNPdUQ1TTQzU0NVci9hZi9lcG9aUlVUeVp2bjBoNkFOVXFLaFk5?=
 =?utf-8?B?WkdkUW80elR0K0VlL0lXNkhLUEk3WlNJc3dtV1hmMGZPVTM1TUtlSVJxemFs?=
 =?utf-8?B?N1g4eXZQMDA3QmREVlVhNEcyUHR3NFdWb0g1STV0UTZkd2gzcXdBQ3JCK1l0?=
 =?utf-8?B?QmhkT21aTTFjVmJrSGdBQ3FtV2hmL1pzQlBkQjREYXp5RTNXTjZrWnFsd1Mw?=
 =?utf-8?B?SCsxOVFZKzlUNWlsTll1MDU3VE44ZkJvL3FycTZSZmxCZUNDYlBpN2Zreml3?=
 =?utf-8?B?U0RRMThVd3ZNc29QSTd1ekVEYW5ES2VGMU56S09JMCs2aHNMZjUwSklnSEZL?=
 =?utf-8?B?cnNOK0Q4dVlSUHVZekN6N0svVDB5VExMWWRmTlg5VnExbi9wRDVqek5VYmpu?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c80583-30c5-4aa5-cf78-08ddf79d5567
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 16:55:27.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5A2T0RxrnzFtLUNruz/U4h4VWgQ9eKSy+8n8zluVp0zf/rJ2rhFGrE7Xop/r1YaWF9rIyIYJcSf+FgINhbME2fuaH8dew6chJHptTJvdmCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15200

SGkgRGFuaWVsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMTksIDIwMjUgNjozNyBQTQ0KPiBU
bzogSm9obiBNYWRpZXUgPGpvaG4ubWFkaWV1LnhhQGJwLnJlbmVzYXMuY29tPjsgY29ub3IrZHRA
a2VybmVsLm9yZzsNCj4gZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7IGtyemsrZHRAa2VybmVsLm9y
ZzsgbHVrYXN6Lmx1YmFAYXJtLmNvbTsNCj4gbWFnbnVzLmRhbW0gPG1hZ251cy5kYW1tQGdtYWls
LmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiByb2JoQGtlcm5lbC5vcmc7IHJ1aS56
aGFuZ0BpbnRlbC5jb207IHNib3lkQGtlcm5lbC5vcmc7IHdpbGxAa2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY5IDAvNF0gdGhlcm1hbDogcmVuZXNhczogQWRkIHN1cHBvcnQgZm9y
IFJaL0czRQ0KPiANCj4gT24gMTcvMDkvMjAyNSAxOTowMSwgSm9obiBNYWRpZXUgd3JvdGU6DQo+
ID4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgdGVtcGVyYXR1cmUgc2Vuc29yIHVu
aXQgKFRTVSkgZm91bmQNCj4gPiBvbiB0aGUgUmVuZXNhcyBSWi9HM0UgU29DLg0KPiA+DQo+ID4g
VGhlIGluaXRpYWwgc3lzY29uIHBhdGNoIFsxXSB0aGUgc2VyaWVzIGRlcGVuZHMgb24gaGFzIGFs
cmVhZHkgYmVlbg0KPiBhY2NlcHRlZC4NCj4gPg0KPiA+IENoYW5nZXM6DQo+ID4NCj4gPiB2OToN
Cj4gPiAgICogUmVtb3ZlIGRyaXZlci1zcGVjaWZpYyByZWFkL3dyaXRlIGluZGlyZWN0aW9uIGFu
ZCB1c2UgcmVhZGwvd3JpdGVsDQo+ID4gICAqIFVzZSBkZXZtX211dGV4X2luaXQoKQ0KPiA+ICAg
KiBTd2l0Y2ggdG8gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZV9hcmdzKCkNCj4gDQo+
IA0KPiBBbnkgbW9yZSBjb21tZW50cyBvbiB0aGUgcGF0Y2hlcyA/DQo+IA0KDQpBbGwgdGhlIGNv
bW1lbnRzIHJlY2VpdmVkIGhhdmUgYmVlbiBhZGRyZXNzZWQsIGhlbmNlIHRoaXMgdjkuDQpBbG1v
c3QgYWxsIHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVzIGhhdmUgcmVjZWl2ZWQgUmIgdGFncywgZXhj
ZXB0DQp0aGUgbWFpbiBkcml2ZXIgYW5kIHRoZSBEVFMuDQoNClJlZ2FyZHMsDQpKb2huLg0KDQo+
IA0KPiAtLQ0KPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBz
b3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzDQo+IA0KPiBGb2xsb3cgTGluYXJvOiAgPGh0dHA6
Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfA0KPiA8aHR0cDovL3R3
aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8IDxodHRwOi8vd3d3LmxpbmFyby5vcmcv
bGluYXJvLQ0KPiBibG9nLz4gQmxvZw0K

