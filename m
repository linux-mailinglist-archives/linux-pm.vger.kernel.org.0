Return-Path: <linux-pm+bounces-13323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245F968272
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C03C1F21B38
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982318660B;
	Mon,  2 Sep 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Mk+GlnPZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010021.outbound.protection.outlook.com [52.101.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CD12EBEA;
	Mon,  2 Sep 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267226; cv=fail; b=Ly3nMGNja5xxQfusgIW2s1F6Jb+BU9GTdgCTiRn60bvqx1fncTNQvlyXIaJ0lazTbqVi8mlbMnpCEddhH0T5zEHhJjHz6wRRNQNrr64MCXfcjITxKwHlWIjwBicbvV/bh92c0S0Ryu1+nHyJ0Q7mUh+ATrZvGafO5AnxiQ7Ov3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267226; c=relaxed/simple;
	bh=ySEnw4Fo+ZJufa+0lPvBK2nPFSdh8pH4xPt3rbSdlgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YvwMQ908etkZQn/w1L5JAGiP94OUdrT+0LRWcI3eZ139SKFQNQaJ8DS/n07c3hyiTKz8HBN93+PZP1+GrX7QSVDfedbTIlIlbMxczoaYBdwr5G7cjhscdFOnUvhscqVzf6lVVYV4ZkbikN7Qdnq2b/GlAC/tUoQEiwCd3Ypgz00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Mk+GlnPZ; arc=fail smtp.client-ip=52.101.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsI0M2gv9wMhVvi84z0580PswWZmznp0xoqpkOepPvnpHpMx++ehtc0R80ufORgZ0lZdkm4IZe0wMPJhH+AwkoNZPrM957Is6NHDYBkMMLIuz4xpDGqgmNTWMQobNyo+k6QfcraE/jmQwW6hkjRjtRq54BnI/qeCQRbbIBk/54ZlPSBlScjCmcYYVy1VOlllzN36xYTI6xggMMt1iqwNko6DcKCA39heCERBAiejWiDQu+uafVdE+gzZbuJiWuOiJxVX6t9b9y58s1FV5Qfy9WfMotX6mmXc5TwXKhvN8d8ZOoJFVE7YREhN6Qk4/ndGDzxXcmr8j/XSZtmqJ4s4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySEnw4Fo+ZJufa+0lPvBK2nPFSdh8pH4xPt3rbSdlgw=;
 b=ZzW2PsyXqT/7yTbngxflNfaccwnt51Om/+laH8aRZpiV7HrVil+vFpTjzvru1LsrS1rfDfo4pzMtyLGFoCtisJyo/Y4nO4XhcQGuy5HGIzUjuUaGVWQT3c7G8wJrzmXvDf4S4P6p1s7tYAf5jGMSSPYKCjYEt3zSJ4LS0XNEir70ddc69gm79/KRBobjiuZJZDOGaxA4yBSjWotuLUbrKqeTZAV/IkkYH8HVy2O9dTJyTslPQB6td0rx2BShvcPRcITndwG7SlgMXWEnv3H1Bkz8QZ6I6kCtdjURqeJ5N7cJypBZpzDid6Lp8FvyteikhLR6th6CHz3FvilBvCWMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySEnw4Fo+ZJufa+0lPvBK2nPFSdh8pH4xPt3rbSdlgw=;
 b=Mk+GlnPZsz666/cB5Sji9SwIy65j7ZZc0f2/VrlKC0CnyPU95aCwlVixnHa8UjGhVbNzKnen8KDUrOEMFNkKcgRoIY0CpxVX5U70KgcDfXHaQ/fwZ7cYSGynjo++5ddYfwh0xocl2CdEKjTn6GIMaQ2zhIiYNHhx08PY5s3pGhw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB6698.jpnprd01.prod.outlook.com (2603:1096:400:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:53:37 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:53:37 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycA==
Date: Mon, 2 Sep 2024 08:53:37 +0000
Message-ID:
 <TY3PR01MB113464D53083F4C8A5DBBA36586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
In-Reply-To: <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB6698:EE_
x-ms-office365-filtering-correlation-id: c16a8e10-abc3-4902-f9da-08dccb2cbc1f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGZaMlVTOTVhWGQ4YlJOVkZzdHZrbWova0dxeFVDYTZyZmdKUnJ6U1J4eEkx?=
 =?utf-8?B?OGlkSkVKSW9ieEJzMFFkd29Ncjlxb0cyMmRQeW5jL3J1NFRLWHMxOWdKT1ZT?=
 =?utf-8?B?SmVwc1QvNGhzeEh2MFlYNnlFZWRGa2ZzRU5kYkYzZXkxNCtzLzBzdC8waFFB?=
 =?utf-8?B?UzZmVkR2MjIvdnpmZzI4OTVVM3RHdkY2ZmhIc0VUaEc4czVEQ1IxWXFNQmZ3?=
 =?utf-8?B?VlUrU3ZsZGhWQ1RYbklZbDd5T3NtMS9SNkZTN2Q0V3ZydnpzUlpNdVVDeXR3?=
 =?utf-8?B?ZzRPcE93V3JHVUlKZjJVTDVqalJsU0JBSjlFY3gxVGFGUFFFQkdUWDNYS0FU?=
 =?utf-8?B?U2dLNkJRdnJncURDRFExNnA3eUxsRWlFcUdRYUFKVlJGbk1LaGVJRXBKR1Zx?=
 =?utf-8?B?TEVQcllDM1BlRnl5TElhU1dITnhDRWlSZE5rd2s5SUdiNmN5aGxjL1Z4SENG?=
 =?utf-8?B?dTcyVW9wS3B0cU5JalpaTjdEaitSM0VoQ0xwTFhrbkNZWHJVU3ZUdzVrTXlU?=
 =?utf-8?B?S0FONkdjZTE4dEdURG5CeGQvVzNDaXVXaXNpcWQ3Y2w5M25iMFNwd1VKNjlj?=
 =?utf-8?B?ZldieXhBRVBEci9JaUE4V0VLcDhYaVNrV3UzUGVkWU1nTUpUVkV3SUZjY0ND?=
 =?utf-8?B?SFJjWHEyTXlzZThORGV3UVBnaDBMWm9GYXRjK2xoNjFyMU9zZzYvcmxTZ3lt?=
 =?utf-8?B?bGZyemFERVdyODdMdmdxWWM4RWhaejB5RDlJY3Vxa3B0bENpOUVna1NsbXds?=
 =?utf-8?B?eUY3UWsrQ0p4L1RLYzRhbm9aNXBiSlAva0NPblJZMG0wSUdac2tsVmE3eFl4?=
 =?utf-8?B?aWFkMVF3Z0RHN1k0WFo5QjN2TUt4QmRFbGhacGJnVThqdHQ5OWFRV2Jra2ly?=
 =?utf-8?B?Nm1ycFFlTVAyWWhkUUp6ekcwV1I0MzE1ZFc5VDhESTcrdnlWRStWSkNjbzFh?=
 =?utf-8?B?N29hbkxmQUdENzFWbTJXTW0yc2xjSHRzSmJ0M09sZkJpQ0JaektDVCt6TU5L?=
 =?utf-8?B?MUFzeExZVzl4dGhSRGFDdXQyVHdRVFd5TGVvK2dUYTdpaHpxM0d2cXRIcHhL?=
 =?utf-8?B?VWxUbW9HMGRvNnJhc2M0eWkyQ2ZpV3pWMTRpOFpvSU9jeFROcWFjVmRPV0I5?=
 =?utf-8?B?WEhRTzJrUWV5d09SdmNYbVhsVVZ6eW50UVlYbm14SmwrRlowTjBGMFYvc3Mv?=
 =?utf-8?B?MTJyT2lrQ3hNaGpFWXkxMnYrNHJGbEp1REI2RCtuWCtWVlQwalVRQ2lubWtD?=
 =?utf-8?B?MVFpZGdZQk94OHJNbUEvUVRndTBYaDJ3YUtmK1BEbEVQTGprS0J2TEcrY2E1?=
 =?utf-8?B?andISXZwRmIyUkprblJzVnhSbnhsUFFZbWFNd0cwRi92M3VmSisrSlhYMXA0?=
 =?utf-8?B?TnpSN2FjTWVQYlV6Wi9kb0hkY1R0RnJkd1FOdHExR1hCYktuZmMzRjRGUW1o?=
 =?utf-8?B?VStxYU95WjZhN3NTeXFsYmtvTTdKdW5uN2crRUswMDFnV0NNNm1DZlBSZXFh?=
 =?utf-8?B?OGR0aXBXZmVJK3pYR0VZOWRsSjg3NVRkRDJ0ekJsVW1kT0hZS3RBbXFnL0d0?=
 =?utf-8?B?dHkxRzFaSDg3aTdCTGxaRUxVUDJ1dUwwTDYzTWVwZFFVNWsvOE9TYmRWWTFk?=
 =?utf-8?B?dWw3aUZNY29xWUhScTcycE9CSHNsVVJGTTNVbGpPaHBWMTBEcnViclNoR2VF?=
 =?utf-8?B?aWpHZnNPaElabmhEdlcwMGJRbU9payt6YzEzUWxGcnlxYW5mQnhCeHlNQmpD?=
 =?utf-8?B?czJ4YThTRmg4RFFrb2JOQnRnb1RTTkdJMFR3YUNLT1hDZjFNbVRYMWJiZVha?=
 =?utf-8?B?Si9NMXg4clZHNHAvVS85enQ0RmR0Y1FadjR5L3RJVVNsT2ViY0krMnQzaGlx?=
 =?utf-8?B?R1NXZFJKUDBpMy83SUdxbnBHTWdrMkI2SU9USEVNS1ZsQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejRNLzYydGl5eWdja0Z4WnQ0Z05XMEp5cVM4WVBvWTMrb0NNdStrMUc4YzNa?=
 =?utf-8?B?dTYyYnA1cFpzejNDUlJvaldvSm1Vb0dXczBDTG5BQlFxenE1ZUk1eTQwQzJT?=
 =?utf-8?B?WW5teDA2RXlGQzNuUTNHaDF2NWw0MXFabHo2RlpUUGRoMVA2V0l0M2ZHT0lP?=
 =?utf-8?B?b2NING84WHBoSmpmalRwa0dTdEE2SlVWc0N6Y3NnNkNxREg0ODErcU9IVHFz?=
 =?utf-8?B?dkxyejhBcXJuZGdlM0FrLzJtcFJ4ZkZVTjk0WnBqbzB6cVFYek9CckVtd0RF?=
 =?utf-8?B?SnpiTFRCSGQyQWpDVFZpZXZpc1I4K1ZMOEExbmxBanlBLzZxWWI3SDZObkI5?=
 =?utf-8?B?QjVjSzRBd3dWellTZGk3a0F0dWRBM0dYeGtsYTB0SXp4VzJGaXpZVEYzdlla?=
 =?utf-8?B?b0U1ZStORlBibkF3YVFZdHppckFLWnRQN245SjNDTURmN2dNNW5vcFBRM1BI?=
 =?utf-8?B?cXRyMGY2eUc3L0FIMHVkMWgrMkRLUkV6STZRdEoybndqa2ZFSVFJMEc3N3Vr?=
 =?utf-8?B?aEk1cjZyY3JYZTNKYVVRMGZjNEdRY0dQYmY0ODQ2YUpXZEtITG1UY1Z3SFZp?=
 =?utf-8?B?NzNLNXpOQzhKZXdVQU9pTFVSOUdZRTVqbkJCK29Hb2ZzVFIyOVg2THlZRzd6?=
 =?utf-8?B?WmhOU2FhZllQZWRRTVF3eWwva0dpd0graGFBQXFuemFBVDNjTUFUb1lGdnlU?=
 =?utf-8?B?cTc1ZUVqT1J5b1JUZHBtWForSXN6djFrN1dhYW9KbzluREpxbm8wUjlQaDh4?=
 =?utf-8?B?eE5YbStSRmRlV2JSWlR0QklmR1lvMy9vL0hZcVRtTHRaOTRaWVU1c0RwVlo1?=
 =?utf-8?B?c0lOSzJ0Y3V4VXhjVEdNRGRxTkVYUUUrbGc4YVovU1o2VnRKbFErRDlZODNR?=
 =?utf-8?B?VXAvUnpRTW93dHBpTHVqVVkvdjVNdTZJcU4wZThvTWFvTFBTS1lDbE9lcVE5?=
 =?utf-8?B?MmtJQy9RSWFUcGRPTkRvVlZkSkxUYW9QTFJUSXg0RCtHVzh4bnpma0c0cEFU?=
 =?utf-8?B?R29rVTl4M1BwYnEzWTlFejJRenhuRTJNY1ZyS1pKQjJpVE5Qa3ZzWUdGU1NC?=
 =?utf-8?B?QU1uZ2FDV3doUGpaaVBHejVBNzR0MlF2ZDlnQ3dtaU44Z0VWVEpiNnZUanZp?=
 =?utf-8?B?TUlWMll4MytCU25WdW5oWTVSMHVGaXZQbXdRU0JhRlpzZTdlQXZLQnlJc2ha?=
 =?utf-8?B?SDVpeUp1UTU0WmdLNzd4U2J3Ym40eEhqcWRadWdZM25kMDdTWWJHZVdzbzdC?=
 =?utf-8?B?NVRqY0g0WlRnbDhOcjEzS3NPOHVsRmdKUnJvTGIyUG1iZFQ3eVlSN0Z1aXFJ?=
 =?utf-8?B?NTV6VWRRSWNySTRUVXVYZmlnWkxhalBMQndGZk91eFEvaEJZY3pyYy9RYjdF?=
 =?utf-8?B?cDk3N1E2ZGEzeFNRaEZVRE90dzljcEU3REZFejVZMDNFblhHMUdtNkJxczlm?=
 =?utf-8?B?ckw0ZmxuNkJ3aDFHaVdPRVZYYlRwWUFiclBuR1pqME9FTkUwTEdLVldkN3pK?=
 =?utf-8?B?bHhjelQvbm8rbkF5UzJBUzRLWVFaNC9kOWRvSytOdkRORFYrejZOTzhvZHVi?=
 =?utf-8?B?c21hSHl2MlFSOXN6TnVEd25DRVlmYXlVVVZ2WkI1eFhPVTR6R21sa1dPUzdT?=
 =?utf-8?B?YWRYRk9wUEFUeEp5cXdDc1NjUEdoQWxTRCsvTVNHbkVidEs4UlZEcWIzUGpT?=
 =?utf-8?B?cUlWZmVnQkIwaEJLSGk0dDV3eGczdU9yMFIyaUdJWjdSeHhaODFmSlJNcDJm?=
 =?utf-8?B?Q0pVSW1PYWpndTR2eXU0Z2FJQk82OG8waFZETXJQeFNweVJHWENtQUozTTVv?=
 =?utf-8?B?Z1JXVENsZ0l3VGh6Sk9rUzVFWVRhaVRBVkFEZ05MRW91QUdpak9PcUlMTEZO?=
 =?utf-8?B?UGlaNWZUejkrcEJFSDBxSDl1dm1JZUJtdGZZaUZxWjVLakNhRmVQci80eVhF?=
 =?utf-8?B?dHMvZlJYenMrR1o4TFpxb2pOc3FOTkVxWUZsejgzbVFabURiRmM5cDR0TmNm?=
 =?utf-8?B?M2MzTXZFZzNBMlUybjRuamJWeXArek9KeFRpNzdPaDFtZE5iaS9jQnI2S2pR?=
 =?utf-8?B?aERLYjBERWo3VjhoT1p6VFl6Z25HRGkzaktrZ0E4QnFRTzZjTytQVWxmdkJB?=
 =?utf-8?B?dGxydmdFQVRsM2RxdTNOS3FWbHVKMUphN2xnYjA3NUplbTRUWXdzUFdURVRp?=
 =?utf-8?B?Q3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c16a8e10-abc3-4902-f9da-08dccb2cbc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 08:53:37.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6PXKrk38EcofmhKTxMGtwYgV6ybcrLIqDYkkhSQ8CvASrTdnBHkvoAVOisEv+xe2h3EtVEpRwheJIAERKvU827e2Q2JMYLKBfYZ+XIyb88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6698

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBNb25kYXksIFNl
cHRlbWJlciAyLCAyMDI0IDk6NDcgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xNl0gQWRk
IGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzIFJaL0czUyBTb0MNCj4gDQo+IEhp
LCBCaWp1LA0KPiANCj4gT24gMDIuMDkuMjAyNCAxMDo1NCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4g
SGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBCaWp1IERhcw0KPiA+PiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDMxLCAyMDI0IDY6MTQg
QU0NCj4gPj4gU3ViamVjdDogUkU6IFtQQVRDSCAwMC8xNl0gQWRkIGluaXRpYWwgVVNCIHN1cHBv
cnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+IFJaL0czUyBTb0MNCj4gPj4NCj4gPj4gSGkgQ2xhdWRp
dSwNCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBj
bGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+Pj4gU2VudDogRnJp
ZGF5LCBBdWd1c3QgMzAsIDIwMjQgOToyMyBBTQ0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
MC8xNl0gQWRkIGluaXRpYWwgVVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+PiBSWi9H
M1MgU29DDQo+ID4+Pg0KPiA+Pj4gSGksIFVsZiwNCj4gPj4+DQo+ID4+PiBPbiAyOS4wOC4yMDI0
IDE4OjI2LCBVbGYgSGFuc3NvbiB3cm90ZToNCj4gPj4+PiBPbiBUaHUsIDIyIEF1ZyAyMDI0IGF0
IDE3OjI4LCBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+IHdyb3RlOg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVu
ZXNhcy5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+IEhpLA0KPiA+Pj4+Pg0KPiA+Pj4+PiBTZXJpZXMg
YWRkcyBpbml0aWFsIFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcyBSWi9HM1MgU29DLg0KPiA+
Pj4+Pg0KPiA+Pj4+PiBTZXJpZXMgaXMgc3BsaXQgYXMgZm9sbG93czoNCj4gPj4+Pj4NCj4gPj4+
Pj4gLSBwYXRjaCAwMS8xNiAgICAgICAgICAgLSBhZGQgY2xvY2sgcmVzZXQgYW5kIHBvd2VyIGRv
bWFpbiBzdXBwb3J0IGZvciBVU0INCj4gPj4+Pj4gLSBwYXRjaCAwMi0wNC8xNiAgICAgICAgLSBh
ZGQgcmVzZXQgY29udHJvbCBzdXBwb3J0IGZvciBhIFVTQiBzaWduYWwNCj4gPj4+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICB0aGF0IG5lZWQgdG8gYmUgY29udHJvbGxlZCBiZWZvcmUvYWZ0
ZXINCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICB0aGUgcG93ZXIgdG8gVVNCIGFy
ZWEgaXMgdHVybmVkIG9uL29mZi4NCj4gPj4+Pj4NCj4gPj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBQaGlsaXBwLCBVbGYsIEdlZXJ0LCBhbGwsDQo+ID4+Pj4+DQo+ID4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSSBkZXRhaWxlZCBteSBhcHByb2FjaCBmb3IgdGhpcyBpbiBw
YXRjaA0KPiA+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIDA0LzE2LCBwbGVhc2UgaGF2
ZSBhIGxvb2sgYW5kIGxldCBtZSBrbm93DQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgeW91ciBpbnB1dC4NCj4gPj4+Pg0KPiA+Pj4+IEkgaGF2ZSBsb29rZWQgYnJpZWZseS4gWW91
ciBzdWdnZXN0ZWQgYXBwcm9hY2ggbWF5IHdvcmssIGJ1dCBJIGhhdmUNCj4gPj4+PiBhIGZldyB0
aG91Z2h0cywgc2VlIGJlbG93Lg0KPiA+Pj4+DQo+ID4+Pj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJl
Y3RseSwgaXQgaXMgdGhlIGNvbnN1bWVyIGRyaXZlciBmb3IgdGhlIGRldmljZQ0KPiA+Pj4+IHRo
YXQgaXMgYXR0YWNoZWQgdG8gdGhlIFVTQiBwb3dlciBkb21haW4gdGhhdCBiZWNvbWVzIHJlc3Bv
bnNpYmxlDQo+ID4+Pj4gZm9yIGFzc2VydGluZy9kZS1hc3NlcnRpbmcgdGhpcyBuZXcgc2lnbmFs
LiBSaWdodD8NCj4gPj4+DQo+ID4+PiBSaWdodCENCj4gPj4+DQo+ID4+Pj4NCj4gPj4+PiBJbiB0
aGlzIHJlZ2FyZCwgcGxlYXNlIG5vdGUgdGhhdCB0aGUgY29uc3VtZXIgZHJpdmVyIGRvZXNuJ3Qg
cmVhbGx5DQo+ID4+Pj4ga25vdyB3aGVuIHRoZSBwb3dlciBkb21haW4gcmVhbGx5IGdldHMgcG93
ZXJlZC1vbi9vZmYuIENhbGxpbmcNCj4gPj4+PiBwbV9ydW50aW1lX2dldHxwdXQqKCkgaXMgZGVh
bGluZyB3aXRoIHRoZSByZWZlcmVuY2UgY291bnRpbmcuIEZvcg0KPiA+Pj4+IGV4YW1wbGUsIGEg
Y2FsbCB0byBwbV9ydW50aW1lX2dldCooKSBqdXN0IG1ha2VzIHN1cmUgdGhhdCB0aGUgUE0NCj4g
Pj4+PiBkb21haW4gZ2V0cy1vci1yZW1haW5zIHBvd2VyZWQtb24uIENvdWxkIHRoaXMgYmUgYSBw
cm9ibGVtIGZyb20gdGhlDQo+ID4+Pj4gcmVzZXQtc2lnbmFsIHBvaW50IG9mIHZpZXc/DQo+ID4+
Pg0KPiA+Pj4gSXQgc2hvdWxkIGJlIHNhZmUuIEZyb20gdGhlIEhXIG1hbnVhbCBJIHVuZGVyc3Rh
bmQgdGhlIGhhcmR3YXJlDQo+ID4+PiBibG9jayBpcyBzb21ldGhpbmcgbGlrZSB0aGUNCj4gPj4g
Zm9sbG93aW5nOg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiAgICAgICAgICAgICAgICAgICBVU0IgYXJl
YQ0KPiA+Pj4gICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4+PiAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4+ICAgICAgICAgIHwgUEhZIC0t
LT5VU0IgY29udHJvbGxlciAgfA0KPiA+Pj4gU1lTQyAtLT4gfCAgXiAgICAgICAgICAgICAgICAg
ICAgICB8DQo+ID4+PiAgICAgICAgICB8ICB8ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4+
ICAgICAgICAgIHwgUEhZIHJlc2V0ICAgICAgICAgICAgICAgfA0KPiA+Pj4gICAgICAgICAgKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4+DQo+ID4+IEhvdyBVU0IgUFdSUkRZIHNpZ25h
bCBpcyBjb25uZWN0ZWQgdG8gVVNCPw0KPiA+Pg0KPiA+PiBVU0IgYmxvY2sgY29uc2lzdHMgb2Yg
UEhZIGNvbnRyb2wsIFBIWSwgVVNCIEhPU1QgYW5kIFVTQiBPVEcgQ29udHJvbGxlciBJUHMuDQo+
ID4+DQo+ID4+IElzIGl0IGNvbm5lY3RlZCB0byB0b3AgbGV2ZWwgYmxvY2sgb3IgY29ubmVjdGVk
IHRvIGVhY2ggSVAncyBmb3IgdHVybmluZyBvZmYgdGhlIFVTQiByZWdpb24gcG93ZXI/DQo+ID4+
DQo+ID4+ID8gT3IgSnVzdCBQSFkgKEhXIG1hbnVhbCBtZW50aW9ucyBmb3IgQVdPLCB0aGUgVVNC
IFBXUlJEWSBzaWduYWwtPlVTQiBQSFkgUFdSUkRZIHNpZ25hbCBjb250cm9sKT8NCj4gPg0KPiA+
IEFzIHBlciB0aGUgdXBkYXRlIGZyb20gSFcgdGVhbSwNCj4gPg0KPiA+ICJTWVNfVVNCX1BXUlJE
WSBhbmQgU1lTX1BDSUVfUlNUX1JTTV9CIGFyZSB1c2VkIHdoZW4gdHJhbnNpdGlvbiBmcm9tIEFM
TF9PTiB0byBBV08gKG9yIGZyb20gQVdPIHRvDQo+IEFMTF9PTikuDQo+ID4NCj4gPiBSZWZlciB0
byBzdGVwIDgsOSBpbiBUYWJsZSA0MS4xMCBFeGFtcGxlIFRyYW5zaXRpb24gRmxvdyBPdXRsaW5l
IGZyb20gQUxMX09OIE1vZGUgdG8gQVdPIE1vZGUuDQo+ID4gUmVmZXIgdG8gc3RlcCA5LDEwIGlu
IFRhYmxlIDQxLjExIEV4YW1wbGUgVHJhbnNpdGlvbiBGbG93IE91dGxpbmUgZnJvbSBBV08gTW9k
ZSB0byBBTExfT04gTW9kZS4NCj4gDQo+IEFsbCB0aGlzIGlzIG5vdCBuZXcgaW5mb3JtYXRpb24u
DQo+IA0KPiBGcm9tIGV4cGVyaW1lbnRzLCB3ZSBuZWVkIHRvIGNvbnRyb2wgdGhlc2Ugc2lnbmFs
cyBhbHNvIHdoZW4gYm9vdGluZyBhcyBpbnRlcm1lZGlhcnkgYm9vdGluZw0KPiBhcHBsaWNhdGlv
biBtYXkgY29udHJvbCBhbmQgbGVhdmUgaXQgaW4gaW1wcm9wZXIgc3RhdGUuIFcvbyBoYXZpbmcg
U1lTQyBzaWduYWxzIGNvbmZpZ3VyZWQgcHJvcGVybHkNCj4gdGhlcmUgaXMgbm8gY2hhbmNlIGZv
ciBVU0IgdG8gd29yayAoaXQgc2hvdWxkIGJlIHRoZSBzYW1lIGZvciBQQ0llIGJ1dCBJIGhhdmVu
J3QgZXhwbG9yZWQgaXQgeWV0KS4NCj4gDQo+ID4NCj4gPiBXaGVuIHR1cm5pbmcgb2ZmIFVTQiBQ
SFkgYW5kIFBDSWUgUEhZLCBpZiB0aGV5IGFyZSBub3QgY29udHJvbGxlZCwgUEhZIG1heSBicmVh
ay4iDQo+IA0KPiBGcm9tIGV4cGVyaW1lbnRzLCBJIGtub3cgdGhpcywgYXMgdGhpcyBpcyB0aGUg
cmVhc29uIHRoZSBTWVNDIFVTQiBQV1JSRFkgaGFzIGJlZW4gaW1wbGVtZW50ZWQgaW4gTGludXgN
Cj4gYW5kIHByb3Bvc2VkIGluIHRoaXMgc2VyaWVzLg0KDQpZb3UgbWVhbiB5b3UgY2FsbCByZXNl
dCBhc3NlcnQgZm9yIFVTQiBQV1JSRFkgc2lnbmFsIGZvciBzeXN0ZW0gdHJhbnNpdGlvbiAoQVdP
IE1vZGUgdG8gQUxMX09OIE1vZGUpPz8NCg0KDQogDQo+ID4NCj4gPiBEbyB5b3UgaGF2ZSBhbnkg
cGxhbiB0byBjb250cm9sIHRoaXMgcG93ZXIgdHJhbnNpdGlvbnMoQUxMX09OIHRvIEFXTyBhbmQg
dmljZSB2ZXJzYSkgaW4gbGludXg/DQo+IA0KPiBBcyB5b3Uga25vdywgdGhlIFJaL0czUyBVU0Ig
UE0gY29kZSBpcyBhbHJlYWR5IHByZXBhcmVkLiBUaGlzIGlzIGFsc28gY29uZmlndXJpbmcgdGhl
c2Ugc2lnbmFscyB3aGVuDQo+IGdvaW5nIHRvIHN1c3BlbmQvZXhpdGluZyBmcm9tIHJlc3VtZS4g
Vy9vIGNvbmZpZ3VyaW5nIHByb3Blcmx5IHRoZXNlIHNpZ25hbHMgdGhlIFVTQiBpcyBub3Qgd29y
a2luZw0KPiBhZnRlciBhIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLg0KDQpPbmUgb3B0aW9uIGlzIHRv
IGhhbmRsZSBTWVNDIFVTQiBQV1JSRFkgc2lnbmFsIGluIFRGLUEsIGlmIHlvdSBwbGFuIHRvIGhh
bmRsZSBzeXN0ZW0gdHJhbnNpdGlvbnMgdGhlcmU/Pw0KDQpDaGVlcnMsDQpCaWp1DQoNCg0KDQo=

