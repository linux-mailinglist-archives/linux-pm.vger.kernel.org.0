Return-Path: <linux-pm+bounces-13426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A3969F53
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BDB1F24478
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F31257D;
	Tue,  3 Sep 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wz6kKBFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010045.outbound.protection.outlook.com [52.101.229.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8431CA69A;
	Tue,  3 Sep 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371110; cv=fail; b=mX+UaHxa4JX0KgvLNTfF66pqFruUInaXehq02NqdQ5PUjKAHgDQQF0rFi46GTXvlECm5ZBWjq1TMxxm3qwKkYPOmmhkTdslddkwPtrYguQdm2AKE2zrKJd1oGoXR5yFXUvpGsU/4L+vZ41Y4GAHNE3ZuiKAviDP+1U+MGtEK4JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371110; c=relaxed/simple;
	bh=Iin/JRb9B94GXS7k4cL1DurkqYtyX2R9gJh27FoHioA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrLt7ey1AZXOid8wVg2cNB86ELXGSKm5vIUpJND0kzxZcFvm7fjAd0DM1gFTeOchLF7TOVHiURZnvNJd8EFG420QxwGGcXbHeJegowxbqlfuAeQnZ01JTPNJBzJZWpeszUIX63uH1yW2pZoCkpQ5V3dUfAE3xoz+U2PEMuBHTcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wz6kKBFk; arc=fail smtp.client-ip=52.101.229.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkZXgJpPsa2uT8Z5Qddnzbd/c1nERkIuBOfMqxPq/y8o0+JT/SzxKYSAUwFCwvg10Q8xpuDakuk8q2sryNz2vJOfauVpv2cNfZfrbIBASz01I2mzZjYiMTHU7nD+9EVqB4HV2DDAGjkAwROttOLbP7qs8awCGrV/ReLTydZTKLS/TWFb8HKOcG7M+exvAfkD7BprRidXk7648v2CQBAKFjYLSVDfJeQKs/v4LQg6flp3/D47WCk+mEkp+TaZ3lcQ20PK2qwUu6eB3fYUifCfMhg9rNVU/s3+667KJnQ7fCdXk5HwGHIq/Ep878dwX2YSQY5hLFbj9g+6FquYY1GM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iin/JRb9B94GXS7k4cL1DurkqYtyX2R9gJh27FoHioA=;
 b=HkocxInd5U7wmkfwkXUURJsSezZciN/rH7gR65q2DOAymCPInZmijcCucrpJXa/3xXCHUl8jKzSD7NXSL0/vHpuFuIrmOEIY49PBUZJfYGzw2757cp7yAotBiKI8VByKDgBle8nZ8eAQMHPCPUCnxQIfQVNpHWSOoxXlS7EkyjuWkOJoOGLs43J6NoQyp+yXoAvFWsbu3+P/BeyzV8BTrNOK3JtMmOoiujXfufYFvnd1ionAwl/q7dZdRGYHOeHwH6QsS+PeXv55tWWTXSLRm3iGgkAJO+EJGYx3H2t5D7OoPi2YLJoQHBjI/NJbQEHJdG1HtVYceFR5g/C8JEGkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iin/JRb9B94GXS7k4cL1DurkqYtyX2R9gJh27FoHioA=;
 b=wz6kKBFkR+ZVUWoExlqUzFh/6uZXBzvG/T+G1MF5ZrlV6Ir2cfwyv8aAfvBGUxulXlA3dSLM8hTlvZ4Cl6XX9HXBIWOcp0cHNDmr2QcNb06MdTa+H3G3rLZ3bvfSg/CPypy9ov1Dtukg0asfJA6mgy/MW69n+twOQ7ydqOJBQ3g=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB9980.jpnprd01.prod.outlook.com (2603:1096:400:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:45:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:45:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, Yoshihiro
 Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Topic: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Thread-Index:
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQgAAJGICAAAE9UIAADyWwgAAHkoCAAADSkIAAB+2AgAAJdkA=
Date: Tue, 3 Sep 2024 13:45:04 +0000
Message-ID:
 <TY3PR01MB1134690F9D37E3BB4814D864386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <590a4fb2-24b2-432b-92db-534c5a52ed0b@tuxon.dev>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469FC8A9F49D9B1FA432FD86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
In-Reply-To: <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB9980:EE_
x-ms-office365-filtering-correlation-id: e4a27979-1ddc-44eb-94f0-08dccc1e9d6e
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0tIcUYwQU5uRVBDUERUNHExNG81bTFNT1M2YU5uQm4vOTZHZEtMblZqaG1q?=
 =?utf-8?B?cDk5ZTV1VzZxWUFwQUxyM1BucjNTNXdsL0E5S0RvQVU0ckhSWlJaRDBDUWcz?=
 =?utf-8?B?TnFPQzgrbU9ES1c1ejAvOEtkSDdPVFlsZFFTbUdjcEVLTmxpN0k4L2QvUTdM?=
 =?utf-8?B?VE9rQUxTWDFoeVNLd3BpMUpJSUNCZXdqRytLakw0QlJ5K2ZuUkZWZnd3b3Ex?=
 =?utf-8?B?QTdhTm5FeXdwQzhyRVByQytiRksxZTlTQzV3QVpaY0xUQVdVdkZtaG5MdmVw?=
 =?utf-8?B?UjhFbk1tdUJNRHZhTUE4WG5LTkQrMXFYMWppWnZPNzZURzgrZE1wVEdHQ1JF?=
 =?utf-8?B?R3Jja2VpSWxvUStFMW1HL3MvT1BrRUtLc3hGVVFrT3M4dHMvMHZyL1d5b3py?=
 =?utf-8?B?bHRiQjAxRFNOUjY3Kzc5RTJUNWtGeFR5MVRjdjFyU1VaUjR1L2tKQVUvY3Zs?=
 =?utf-8?B?TUFmeUNkYXM2QXNESWtxMzdIWFFLL1JxdWpEQUlyUitaTjRBTU1SNWtSRkdS?=
 =?utf-8?B?TFdIS3FOeDltQnRrV3BsVWtXME5BdkNFdkp0NjZ0ajlaOG14eHhVWlMvN205?=
 =?utf-8?B?NjRqc0JaQVc2NWtJOUFpVzJRUWk5TjRvdE1GbjJ3SThjU2xqSThXcnNCMHpx?=
 =?utf-8?B?c2RBMEZIRmZJTk9OVnpGRVVvMFVyY3dlSGozOXJFemprUzJ4cjZDT3M1ZXZV?=
 =?utf-8?B?RHp2b2ZrSXo3UjlydXlyc0Ztd29YRXF5eVNiREV4QjlnM3pIeUlvV2o1RnhU?=
 =?utf-8?B?aFNzS2hJQlkyaDRXMWR2UUdHZUZGczRTZFB1YjgwWm13K0F6bjFwam5qZWV0?=
 =?utf-8?B?clkxMGY0ckczYkJsZDlHaGo3SXV6WWp2SHBEQzlLMWE0SGFrTTNRdEEwWkZz?=
 =?utf-8?B?bVVHV1Z1YVAyOXRIenh3bTZIcEpSSytOUzdvNVF3cERLNXBhSDFlejZXUUcx?=
 =?utf-8?B?MW82TUJhSzc5VXlkcVJaYjR6THhjV0pVTmlDRUdYOFU4WGV4cjhaSnBpWmZR?=
 =?utf-8?B?NHB4ZEFYQk9GOVZ5TjlaVTAxbzhKNzFFbmIwMjhOamFFeFlycmQ4MlB2MmdT?=
 =?utf-8?B?eG5EbzNuRXo0RitUQ0tkNFhhWm5jZFNoUHZaaEhrRXRaaGczUWNYWHNPb2JR?=
 =?utf-8?B?a0pMOXhwTEd0S3FDa2MxWnRRUkt6OW9SbURQUzJDdi9TL0hRZ3pDTjZKQzdP?=
 =?utf-8?B?V2VqL3pHaG1xamJzazBKaUhoT0ZDN1Uycy8vTEJtdld5L01BeEx4VG16MlBE?=
 =?utf-8?B?NTlqdWN2TmpzVEVXU0VudDR6aW11eDZJSHk5ZkdMWm9UNUpkM1N2ZUh5Q3VM?=
 =?utf-8?B?M25IYzdWdS9CRUExY3RBWHVwOEZZNGVkc0JUblUwMEVwMnZ4bmtxMUZkVC9Y?=
 =?utf-8?B?MGR0YVVSVVNuZ2ZvaGpSaGlpOTV2NEx0OXRyMWRtVDJoWjdIQW5CMGRzWFpL?=
 =?utf-8?B?Z0ljcjQ1Z0M3eVp5VHZrYVhHUkVtU2ttUWlDdmM0bTlxNUJYRFprQ2lhUit0?=
 =?utf-8?B?TWkxcEpiR2g5NDd6M0NpZHNOQ1R4YzVzMzVOWGE4cjZMWkdtY1BMUjE3WjZh?=
 =?utf-8?B?NWJZSEc5UWxBYm5BQ0pYWS92UDlTNktCY2lsalN4Q3lRZ2F1VGZ5bnhDWTh0?=
 =?utf-8?B?RVRLWlk1UGc2blFrOWRmaVJIaS9IaDlzZnR4cFhwajJiSnlnY1R5ZStSZHM2?=
 =?utf-8?B?VVlhT0dHSHc0OHJEWklPV2Z4NGtseUtUSG01RmZWK0tQQjFaNlNiQTBqcFBk?=
 =?utf-8?B?eHNSOUdYNzFDTDJUL2ZYVHFKVzVGc1RiVUE3Z0xPZ2VuYzZGMytYTjhoUHVh?=
 =?utf-8?B?dXN2ZlgrUkw1eEVMK1crMlBweDBhcHFGKzl1Tzh0QVdzNVpHRVNPTENjbFhT?=
 =?utf-8?B?MURCTHNWZ2ViNm5XcmJHOEVwWjBPLzgvSno2c1AvajVKU1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVBqK0RzT0IwUDFTK3Z4RjhxYW91Vk12S1M2VFFBUFJOVXFlOGtGL3hJWnJB?=
 =?utf-8?B?bnltWEM1Nmd1blYvRHN4YVhoU3lVTkh2U0FveW1ORTBBb29TYzJ4MzVrOEZu?=
 =?utf-8?B?TEVZQU9ReUp3c212bXRxSWl3QkxLQ2NBR2pBNDlXakpHdlk2NkZUWncxbE1s?=
 =?utf-8?B?RDdwTDI1VWRHaVJINDVDZW8rSFRURGZRdFNxYTl4dy9OUEZGeWhNOGNTZDBK?=
 =?utf-8?B?RkdXQWdoeCs0ZUx3dlcyS2NTcWJSd21DVCsxaFBRQzZEZzE5S3VGWFFRNUpv?=
 =?utf-8?B?Z1hwWWZxbVlRdVhkUmpwV1h0K3N3Um1YTjVEY0loR3Q4L29qL2xkb0MwU2Ux?=
 =?utf-8?B?eTZlbVIrYU5JdnJseFdpekpsVW41RXNPVnByQjVuSmsxTW03QVl4bXNpajd5?=
 =?utf-8?B?bE14Z1lnbmRvNENrZ3N2L1ZnM2lsZm5qTmxaN0szYXlTa2pnMzVnWlZ4TDFD?=
 =?utf-8?B?aEJxcS8ydzJBVTZhVVlyUkxNOFY5VmtneVZBaG83WVh6UWpIZ29KSjVhVHdn?=
 =?utf-8?B?b0xxUWJqaXhRMDdxR3Z2ck04cUpLNG82NlZzaDliamJnc0FBaWdoTGlBVlFa?=
 =?utf-8?B?d3Iva0JxN2RGWjJvMU1YWjZDMTlQdHc5eEljU040d3h1MFRNc0MrTjlvZ2JB?=
 =?utf-8?B?bWphNi8rRnZqbUg4RjEvT3IzT09aYzNmQ1F0YXk3bEJERlJNWmxDMXhqaURh?=
 =?utf-8?B?ZWZxVTlYelF4Q3VXZkpGckxFMlphOVQ0a1NaSzdicWhXU3lkcEhnSUJwNmhi?=
 =?utf-8?B?TWtFY201UUhUeFhiSFd0Z05WWGROQlZPVWc1bHVXTWFVOEhGY1d3NXFQWTZI?=
 =?utf-8?B?Yys1TjI4aVpCZ0ZNRDE4VEl6bFZrREZxeFQwS0RySWxnZDhCTjlGRWVzOWti?=
 =?utf-8?B?NTE0RmduVHpRZ0VFbHp0U2xyMXdGYTNITm1NeGJaVVFNdGxreHFRWldRV3ZE?=
 =?utf-8?B?QVp6VlJhTHVWUEw2VTRuYWp1ZXZLSys0Z2Q2eENlaUlvQUNUVmRrK0R6U2tU?=
 =?utf-8?B?T0NjWkRidHRrS005M1N6TXlxSkVQSjFLVG0wc3c1WXJhcG1odjR6YllsUXc3?=
 =?utf-8?B?RDkxaWoxY09BMkcyNDhqTytkQnMxYldsTGEyZmJBRW5Ub1o0K1ppTDI3TXF0?=
 =?utf-8?B?K1dnWHEzV0xCS0pKWVphVGQ4K051ZGVYTWhrU1Eya3dzSXJmaHdrSmptNGFz?=
 =?utf-8?B?WXdTeEVEOFhValZQU3dBWDdsS2RmczB2WHdnc0p0dG1haEE0a25qMSttdXJM?=
 =?utf-8?B?S04ybnRmdGNwajBvbVJpTjl0ZkpkM2JzQ2FKMlBjZSt3L3dQMCtEZUZWdndq?=
 =?utf-8?B?UGR1eVoxaFRVOEhPS2Z0S21jNVR0aC9Ea2VWdS8yL2JRVGJOVVFWTEpnd1JS?=
 =?utf-8?B?cEwyLytXcGt5bW5DYzlzZUFjbFYyWW81R3FNeEIwamd3SSthSzlCNFdJS3dz?=
 =?utf-8?B?YjhYN1hIUUxncWFjNjhVSWRtN0dURGgybVY3QndLTitpZGdvUlo4V0Y4d2g2?=
 =?utf-8?B?R1NFdHRmbFBLTnY4dkFhK1hZVzNNUlZZVXdETFZ5TGdsSXU3YVpGajU5eXhr?=
 =?utf-8?B?MTYvZHdvK2UrT29aM01kZC9UUmkrdHdBYWI2WW1hdlhPS0wyVnYxRE9LSktr?=
 =?utf-8?B?UDJWWU9vNTRoOE53cjVIa3l5R3VjM1cxbTR4cUhydGYzbUE1RXZyejBNZlBs?=
 =?utf-8?B?SFJ5RW0xU0J4YzVYY3N5cjFGaGEwOEh2ak5adi9MQlpscmhGVTRCRTREd21J?=
 =?utf-8?B?N2QzVXZiVnJCdWs1ZmZoUXNHYitKd1E4MlJtN1lIZm5DVTR5d0dKLzUzbDNN?=
 =?utf-8?B?ZWtnV2ZKNDdKb1lrMkpyazZrcmJMYktmKytjblJXM3NEWld1VkpSTVRrNUpS?=
 =?utf-8?B?MHdhMnRKemhsellPR28vZENRZFViWGZDRFFscndrK2xrdlpraVVJaVR6QzNz?=
 =?utf-8?B?SXNjNXY0RmJXbFQyRVYycTI0V2VYME5Wcys0Rm9QcElMMDk4RUgvbkd4ZFBS?=
 =?utf-8?B?Vjl5RVhFSnB3eVU5Qk93ZEVvaVpDRjRYR3JXd3N3alRPS2FUTk5iK2VLSDd5?=
 =?utf-8?B?Z2FUbDlLSHl1Q2ZxYkRCRTVVN3hqOUpoNkNmeGUyVk1pWmd6ZDhwVENkdHlD?=
 =?utf-8?B?Ni9ueW5TZ2J5MThsOWVrVFQvTmZBa3BTZFo3ZDhZbUY5MnJPejN2QUNvZllj?=
 =?utf-8?B?OFE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a27979-1ddc-44eb-94f0-08dccc1e9d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 13:45:04.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liOg/asHDaHH95DndOcAwhgjeYzI2JDH2GWN6Dz10bBTzpGoVxEaJPvJ+qT34cNucZMSVrmK3YHkdsik52q+Rsv/Z/2chxbVS/+rbWobyqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9980

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMywgMjAyNCAxOjU3IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFk
ZCBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DDQo+IA0KPiAN
Cj4gDQo+IE9uIDAzLjA5LjIwMjQgMTU6MzcsIEJpanUgRGFzIHdyb3RlOg0KPiA+DQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogY2xhdWRpdSBiZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVy
IDMsIDIwMjQgMToyNiBQTQ0KPiA+PiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPjsgVWxmIEhhbnNzb24NCj4gPj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4+
IENjOiB2a291bEBrZXJuZWwub3JnOyBraXNob25Aa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3Jn
Ow0KPiA+PiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxA
cGVuZ3V0cm9uaXguZGU7DQo+ID4+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBtYWdudXMuZGFt
bUBnbWFpbC5jb207DQo+ID4+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBtdHVycXVldHRl
QGJheWxpYnJlLmNvbTsNCj4gPj4gc2JveWRAa2VybmVsLm9yZzsgWW9zaGloaXJvIFNoaW1vZGEN
Cj4gPj4gPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPjsNCj4gPj4gbGludXgtcGh5
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0gcmVuZXNhcy1zb2NAdmdlci5rZXJu
ZWwub3JnOw0KPiA+PiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGxpbnV4LSBjbGtAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IENsYXVkaXUgQmV6bmVhDQo+ID4+IDxjbGF1ZGl1LmJl
em5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0g
QWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+IFJaL0czUyBTb0MN
Cj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gT24gMDMuMDkuMjAyNCAxNTowMCwgQmlqdSBEYXMgd3Jv
dGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
Pj4+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+PiBT
ZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMywgMjAyNCAxMjowNyBQTQ0KPiA+Pj4+IFRvOiBDbGF1
ZGl1LkJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2PjsgVWxmIEhhbnNzb24NCj4gPj4+
PiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gPj4+PiBDYzogdmtvdWxAa2VybmVsLm9yZzsg
a2lzaG9uQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4+PiBrcnprK2R0QGtlcm5l
bC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7DQo+ID4+
Pj4gZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7IG1hZ251cy5kYW1tQGdtYWlsLmNvbTsNCj4gPj4+
PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207DQo+
ID4+Pj4gc2JveWRAa2VybmVsLm9yZzsgWW9zaGloaXJvIFNoaW1vZGENCj4gPj4+PiA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+Ow0KPiA+Pj4+IGxpbnV4LXBoeUBsaXN0cy5pbmZy
YWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+PiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0gcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOw0K
PiA+Pj4+IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPj4+PiBsaW51eC0gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgt
cG1Admdlci5rZXJuZWwub3JnOyBDbGF1ZGl1DQo+ID4+Pj4gQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4+PiBTdWJqZWN0OiBSRTogW1BBVENIIDAwLzE2XSBB
ZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMNCj4gPj4+PiBSWi9HM1MgU29D
DQo+ID4+Pj4NCj4gPj4+PiBIaSBDbGF1ZGl1LA0KPiA+Pj4+DQo+ID4+Pj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUB0dXhvbi5kZXY+DQo+ID4+Pj4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDI0
IDEyOjAwIFBNDQo+ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFs
IFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcw0KPiA+Pj4+PiBSWi9HM1MgU29DDQo+ID4+Pj4+
DQo+ID4+Pj4+DQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIDAzLjA5LjIwMjQgMTM6MzEsIEJpanUgRGFz
IHdyb3RlOg0KPiA+Pj4+Pj4+PiBEdXJpbmcgYm9vdCBjbHIgVVNCIFBXUiBSRUFEWSBzaWduYWwg
aW4gVEYtQS4NCj4gPj4+Pj4+Pj4gU1RSIGNhc2UsIHN1c3BlbmQgc2V0IFVTQiBQV1IgUkVBRFkg
c2lnbmFsIGluIFRGLUEuDQo+ID4+Pj4+Pj4+IFNUUiBjYXNlLCByZXN1bWUgY2xyIFVTQiBQV1Ig
UkVBRFkgc2lnbmFsIGluIFRGLUEuDQo+ID4+Pj4+Pj4gQXMgSSBzYWlkIHByZXZpb3VzbHksIGl0
IGNhbiBiZSBkb25lIGluIGRpZmZlcmVudCB3YXlzLiBNeSBwb2ludA0KPiA+Pj4+Pj4+IHdhcyB0
byBsZXQgTGludXggc2V0IHdoYXQgaXQgbmVlZHMgZm9yIGFsbCBpdCdzIGRldmljZXMgdG8gd29y
ay4NCj4gPj4+Pj4+PiBJIHRoaW5rIHRoZSB3YXkgdG8gZ28gZm9yd2FyZCBpcyBhDQo+ID4+Pj4+
IG1haW50YWluZXIgZGVjaXNpb24uDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSBhZ3JlZSwgdGhlcmUg
Y2FuIGJlIG4gbnVtYmVyIG9mIHNvbHV0aW9uIGZvciBhIHByb2JsZW0uDQo+ID4+Pj4+Pg0KPiA+
Pj4+Pj4gU2luY2UgeW91IG1vZGVsbGVkIHN5c3RlbSBzdGF0ZSBzaWduYWwgKFVTQiBQV1JSRFkp
IGFzIHJlc2V0DQo+ID4+Pj4+PiBjb250cm9sIHNpZ25hbCwgaXQgaXMgcmVzZXQvRFQgbWFpbnRh
aW5lcidzIGRlY2lzaW9uIHRvIHNheSB0aGUNCj4gPj4+Pj4+IGZpbmFsIHdvcmQgd2hldGhlciB0
aGlzIHNpZ25hbCBmaXRzIGluIHJlc2V0DQo+ID4+Pj4+IHN5c3RlbSBmcmFtZXdvcmsgb3Igbm90
Pw0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIHdhcyB0aGlua2luZzoNCj4gPj4+Pj4gMS8gR2VlcnQgd291
bGQgYmUgdGhlIGJlc3QgdG8gc2F5IGlmIGhlIGNvbnNpZGVycyBpdCBPSyB0byBoYW5kbGUgdGhp
cw0KPiA+Pj4+PiAgICBpbiBMaW51eA0KPiA+Pj4+DQo+ID4+Pj4gSSBhZ3JlZSBHZWVydCBpcyB0
aGUgcmlnaHQgcGVyc29uIGZvciB0YWtpbmcgU1lTVEVNIGRlY2lzaW9ucywNCj4gPj4+PiBzaW5j
ZSB0aGUgc2lnbmFsIGlzIHVzZWQgb25seSBkdXJpbmcgc3RhdGUgdHJhbnNpdGlvbnMgKFRhYmxl
DQo+ID4+Pj4gNDEuNi40IEFXTyB0byBBTExfT04gYW5kIDQxLjYuMyBBTExfT04gdG8gQVdPKQ0K
PiA+Pj4NCj4gPj4+IE9uZSBtb3JlIGluZm8sIGFzIHBlciBbMV0sIHRoaXMgVVNCIFBXUlJEWSBz
aWduYWwgc2V0dGluZyB0byBiZSBiZWZvcmUgTGludXgga2VybmVsIGJvb3RzLg0KPiA+Pg0KPiA+
PiBUaGUgImNvbnRyb2xsZWQgYnkiIGNvbHVtbiBtZW50aW9ucyBDQS01NSBvbiBQV1JSRFkgc2ln
bmFsIGNvbnRyb2wNCj4gPj4gbGluZSBhbmQgaXQgaXMgYi93IHN0ZXBzICJERFIgZXhpdHMgZnJv
bSByZXRlbnRpb24gbW9kZSIgYW5kICAiY2xvY2sNCj4gPj4gc3RhcnQgc2V0dGluZ3MgZm9yIHN5
c3RlbSBidXMgYW5kIHBlcmlwaGVyYWwgbW9kdWxlcyIuIEFGQUlDVCwgYWZ0ZXIgRERSIGV4aXN0
cyByZXRlbnRpb24gbW9kZQ0KPiBMaW51eCBpcyByZWFkeSB0byBydW4uDQo+ID4NCj4gPiBERFIg
cmV0ZW50aW9uIGV4aXQgaGFwcGVucyBpbiBURi1BIGFuZCBpdCBqdW1wcyBpbnRvIHJlc2V0IGNv
ZGUgd2hlcmUgaXQgZXhlY3V0ZXMgQkwyIGluIFRGX0EuIEJsMg0KPiBjaGVja3MgZm9yIHdhcm0g
b3IgY29sZCByZXNldC4NCj4gPiBJZiBpdCBpcyB3YXJtIHJlc2V0LCBpdCBzZXRzIHJlcXVpcmVk
IG1pbmltYWwgY2xvY2tzL3Jlc2V0cyBhbmQgcGFzcw0KPiA+IHRoZSBjb250cm9sIHRvIGxpbnV4
IGJ5IGNhbGxpbmcgdGhlIFNNQyBjYWxsYmFjayBoYW5kbGVyLiBXaGljaCBpbiB0dXJuIGNhbGxz
IHJlc3VtZShzdGVwIDExLS0+MTQpDQo+IHBhdGguDQo+IA0KPiBJcyB0aGlzIGZyb20gSFcgbWFu
dWFsIG9yIHNvbWUgc3BlY2lmaWMgZG9jdW1lbnRhdGlvbj8gSSdtIHJlZmVycmluZyBhdCAicmVz
dW1lIiA9PSAic3RlcHMgMTEtLT4xNCINCj4gDQo+ID4NCj4gPiBTdGVwIDgsIENvcnRleC1BNTUg
RXhpdCBmcm9tIEREUiByZXRlbnRpb24gbW9kZSAod2hlbiB1c2luZykgU2V0dGluZw0KPiA+IGZv
ciBleGl0aW5nIGZvcm0gRERSIHJldGVudGlvbiBtb2RlIFN0ZXAgOSwgQ29ydGV4LUE1NSBVU0Ig
UEhZIFBXUlJEWQ0KPiA+IHNpZ25hbCBjb250cm9sIChpZiB1c2UgVVNCKSBTWVNfVVNCX1BXUlJE
WSBTdGVwIDEwLCBDb3J0ZXgtQTU1IFBDSWUNCj4gPiBSU1RfUlNNX0Igc2lnbmFsIGNvbnRyb2wg
KGlmIHVzZSBQQ0llKSBTWVNfUENJRV9SU1RfUlNNX0INCj4gDQo+IE5vdGUgKmlmIHVzZSo6IGhv
dyBkb2VzIHRoZSBURi1BIGtub3cgaWYgVVNCL1BDSWUgaXMgdXNlZCBieSBMaW51eD8gVGhlIGRv
Y3VtZW50YXRpb24gbWVudGlvbiB0byBzZXQNCj4gaXQgKmlmIHVzZSouIFNhbWUgbm90ZSBpcyBv
biBBTExfT04gdG8gVkJBVFQgdHJhbnNpdGlvbiBkb2N1bWVudGF0aW9uIChuYW1lbHkgImlmIHVz
aW5nIFVTQiIsICJpZg0KPiB1c2luZyBQQ0llIikuIElmIFRGLUEgd2lsbCBkbyB0aGlzIGl0IHNo
b3VsZCBzZXQgdGhpcyBzaWduYWxzIHVuY29uZGl0aW9uYWxseS4gSXQgd2lsbCBub3QgYmUNCj4g
c29tZXRoaW5nIHdyb25nIHRob3VnaC4gV2UgZG9uJ3Qga25vdyBhdCB0aGUgbW9tZW50IHdoYXQg
dGhpcyBpbnZvbHZlcyBpbiB0ZXJtcyBvZiBwb3dlciBjb25zdW1wdGlvbiwNCj4gaWYgaXQgbWVh
bnMgc29tZXRoaW5nLi4uDQoNCklJVUMsDQpUaGUgb25seSBpbmZvcm1hdGlvbiB3ZSBoYXZlIGlz
LA0KDQoiU1lTX1VTQl9QV1JSRFkgYW5kIFNZU19QQ0lFX1JTVF9SU01fQiBhcmUgdXNlZCB3aGVu
IHRyYW5zaXRpb24gZnJvbSBBTExfT04gdG8gQVdPIChvciBmcm9tIEFXTyB0byBBTExfT04pLg0K
IldoZW4gdHVybmluZyBvZmYgVVNCIFBIWSBhbmQgUENJZSBQSFksIGlmIHRoZXkgYXJlIG5vdCBj
b250cm9sbGVkLCBQSFkgbWF5IGJyZWFrIg0KDQpBTExfT04gdG8gQVdPX01PREUgc3RhdGUgdHJh
bnNpdGlvbjogDQpVU0IvUENJZSBhcmUgcGFydCBvZiBQRF9JU09WQ0MgcG93ZXIgZG9tYWluIGFu
ZCBiZWZvcmUgdHVybmluZyBQRF9JU09WQ0MgdG8gb2ZmLA0Kd2UgbmVlZCB0byBzZXQgVVNCUFdS
UkRZIHNpZ25hbC4NCg0KQVdPX01PREUgdG8gQUxMX09OIHN0YXRlIHRyYW5zaXRpb246DQoNClR1
cm4gb24gUERfSVNPVkNDIGZpcnN0LCB0aGVuIGNsciBVU0JQV1JSRFkgc2lnbmFsIGZvciBVU0Ig
dXNhZ2UgaW4gbGludXguDQoNCk1heWJlIHdlIG5lZWQgdG8gYXNrIGh3IHRlYW0sIGV4YWN0IHVz
YWdlIG9mIFVTQlBXUlJEWSBzaWduYWwgb3RoZXIgdGhhbiBzdGF0ZSB0cmFuc2l0aW9uLg0KDQpD
aGVlcnMsDQpCaWp1DQoNCg0K

