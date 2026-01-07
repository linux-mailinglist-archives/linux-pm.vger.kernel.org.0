Return-Path: <linux-pm+bounces-40389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D4CFF831
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55AC3300EF56
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28C434FF4A;
	Wed,  7 Jan 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="q3hl883L"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011021.outbound.protection.outlook.com [40.107.74.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578834D919;
	Wed,  7 Jan 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805589; cv=fail; b=O9UZXXNqPZJ5zbz2lZL0XBx4WuUibVLyHgGO789xfM/opXfP9Se8YRfCuI6GiE6tz0h6joQPwRSXl3UEFRn6hHG1+LKGjBw9UbzcLdCE4/NBWjBiwVP0KVRgKkexkeBR+lc44ITuN9L3h1zg8M3wl1PK/bBkRzpB1ApWK8BEcPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805589; c=relaxed/simple;
	bh=rWaCi/N+gee6GGfwvIFJVTWaCnPtwKJHd6ohz+Z/V8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ju6vrf9oxA+ZoBifsokBmmCTqYA1ih61TaJLW8GB4/GmD+Q8KRsAaA1bWiYPbdlAwHx8r8Gl/BnPlY4Rj5Yn2PT7k5xet8ELA5YwW9P2ihckGeGX19f5mK/G6hCeZTh0+EX8ow4hheQDx4qQoJCZ6IquunmU0j03iFFGRmK4t6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=q3hl883L; arc=fail smtp.client-ip=40.107.74.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2xyJbFGsZSLqxrhm9iZYSxdc1pAN23i+trcB48MVkZBKWv6BKs5pgB5z1wrzd2ILoMH/sQSG4hJrN1q5d7rESD6eBvZAPEjZ5tU+h4tnmGoQyEcT/hwpk6K2q607Dnbti/iy00kbhtnFDdV3ifmBrRFegvaXMiV9P0+vZlRZeOP+jXrtnHoPxZVBL1lqRVNlOsa9HUqAmMlf9r8x3CBBmBRsqNeCPQdyCSM9mhcizIxnTjPr58MEcYyPFrTZmYYgdLoXT8KQaN9zRijwMOSDWRk7gY03Z4A3I6cuvtFQ3hEDHtNo7lXogc4cn3g7XmNylzhnHxeOxmGgqWyit6K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjPOu2okXug+NMCC8CGvIUj6PSSrVyIIQnXcA/eDBDU=;
 b=bEJt7Z3rs0W3kKwcdskhfoY218oycRQkYHSPkfskLT0nXlg0ybLS8Am47lE4RvG5IZonO9botAC9XLrL1usAWAh56hcSh58l2jupVUbUJwdKeP/bJbEfSL69SawEWsxBiA7xVOUXvj2hjeq099iK/bxu1diK4RT91zU74bl7P4cv1ID4R4zvH4/1hI+Y1U12JGauVkd/2jbAf++JeRsGBxIcTp9d+JKHmFx9oETEIHuV5C3y2GLWGuJqDAPLQuRZ/gR+n4CoFJuOl0/LfCM3h4QFze1SnnzTSeWy9czxvzmMuuCOENiMscTkpTer6KJL7oSG3KVrXZpvkfobLmFXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjPOu2okXug+NMCC8CGvIUj6PSSrVyIIQnXcA/eDBDU=;
 b=q3hl883LcZQ+qLAq3tA1FiRkH2vntE2Qb0UDUdKYUtnng6e/l5VJ21oXK8XlWUWG/9g8rvioWHD9kmbfm91/aZqLp+c0kNlDgtXeACCBHvQotos4Ktbpnv6KXryc12rXV2V1PZtqe48cr4FBfPNKF4k8RgJmdDKopHcyrxV4HII=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY3PR01MB11074.jpnprd01.prod.outlook.com (2603:1096:400:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Wed, 7 Jan
 2026 17:06:20 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:06:20 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	magnus.damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: RE: [PATCH v3 2/9] thermal: renesas: rzg3e: make min and max
 temperature per-chip
Thread-Topic: [PATCH v3 2/9] thermal: renesas: rzg3e: make min and max
 temperature per-chip
Thread-Index: AQHcXtVEW9h8VbAEjkSytnrj11sqErVHMejQ
Date: Wed, 7 Jan 2026 17:06:20 +0000
Message-ID:
 <TY6PR01MB17377CE455D4E2142554EA134FF84A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20251126130356.2768625-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-3-cosmin-gabriel.tanislav.xa@renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TY3PR01MB11074:EE_
x-ms-office365-filtering-correlation-id: bdb5e320-5073-4fa0-39d7-08de4e0f143f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jdvU6p6HFvKs9VBCo+nBpye9S/9qOWDusiDuM4ippTi85q8+UyiQtwr8RRUp?=
 =?us-ascii?Q?Q1n6BKTFLT2d8RFo43OogQE/oPzh4G/Peoicz0vE+uHmoKiQ4SN2QrQKMoSg?=
 =?us-ascii?Q?I2mbNVT1z65k7+AbNPhLnsjZWJ4q2hxVN407bTG6z48DDzWA+QEGTJxBYJgX?=
 =?us-ascii?Q?uBo9muRuiYtDczRHX3xZqKhvWK7HkRN1yGvW38i1AimMwl2TGLM1RqfBuTFm?=
 =?us-ascii?Q?1zcgnDh2rg11tM+9DBl8TGBJRYtAN3bt/WVh0i5slHk6dDumL8y/g1/kbjAD?=
 =?us-ascii?Q?vFhRdigjaWvswAwLHXqn/8q6gbnkeynmYRzQQF650lZaaaU4M1L3F3MSRYaK?=
 =?us-ascii?Q?b7OrJv6D5Vw5iX5FRlCdZA2WxW0kb0ZUD8JLmSqFk9YGKSbsQKyipgvnjJV6?=
 =?us-ascii?Q?PA9Qg3hF4MXw83CwpQADWNgoavcw8gksaC5bYdPBe8izqJkJudGFm5nvhQ4h?=
 =?us-ascii?Q?fVlCZgjuAQyuSU410CpdcET4FcA/iuHvdsvXiBQwyP/Qg8YDb7DQXcLCRqIx?=
 =?us-ascii?Q?7kJOCLhEtaKRCAEpwUmS2LDal01JuAw1cPVap0XSgqz6gyXuJdxo+lLfTVCi?=
 =?us-ascii?Q?pkP4zr2Keo/1yobHqGz6HHfvHO6ETm7Nbx5sNeyfW+4cuheWH3Hwr2Xm8i10?=
 =?us-ascii?Q?YtcBAjJiP4rPXWbp44ud0tqhkMPhD42N0o/WRbAYgL/+4UVdi0DYsRbxXYEl?=
 =?us-ascii?Q?i4Ad/wVetzilHBYlfnfDkujy1jv1cyT3hEFYB8/0WtWs947ZLTqnt8hquPKH?=
 =?us-ascii?Q?1894oY4tET2l/ud9rJXwc0qQANYMhIyQNpAdVSKpuf57tqbfl4pG/YIYn9Mc?=
 =?us-ascii?Q?45KN4V2Yhw5t325YAQi/ysQP46r8x2u3aPP7Xsuvis0mwJC6LWpOufN+yErS?=
 =?us-ascii?Q?GIVrVn8Qp+LUwNHvFGLYnj3I6z+6LZxuQHEIiiH+Bfl4K/lCD8zh9bvfW9Ra?=
 =?us-ascii?Q?mTfv4Lpti3RGLMwecuBJYUMNPz0mEfoPqLNCUHsT3uyFxxgnDHZEDMbc2hVt?=
 =?us-ascii?Q?C2BbrUJhCNvb3KFm1HL86QPIRn5sAKuB5Ei2IvmabySOqMRD1iOszHPt7l1Z?=
 =?us-ascii?Q?xy1y94qxGhMV/M1s3Tc1NdOytT3x/z+EuTkubgf4mTdIePyhZh3cy40sEyMu?=
 =?us-ascii?Q?BNwKHfBptqGELLXADWwrOjX6EMpUMTHURAbhMJDUrIUYzw4Gji9LahvqDOmK?=
 =?us-ascii?Q?2vFmiyUgwcw58czu3bIuEgOfSkYX+rQ/hrstPfhSXAmQUZkQ7lwTgog6qcAv?=
 =?us-ascii?Q?WfkdJPkDhBbe4/jYENN06CQcI4bcSm/SVQJA0IhHlVbNw8hkKCycvBsHVAGi?=
 =?us-ascii?Q?ZIx2Lfapog6lDyfv5pKp5vwXgTA1FJ7P9dtba3Ttd3oRF9Wa5XQOlTHg3Nzd?=
 =?us-ascii?Q?YsQ8t1OCcw6qZS6CEk2v3LLELLtbkPBhgxe3wPRbHlAPKdPGlmFoIzsAV6ve?=
 =?us-ascii?Q?7JEAsi3lS6L6o6/ZLafRRDBf8/lVpoW2mTG1iFWwlbZZ7FI5mHJMMXbBBUyo?=
 =?us-ascii?Q?CQ1DiH5n2uk0ZsKA13WpIIXaENteYReVAZgxD8WDRDgP/vF+IAduTYeTqA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y0xDy/SBQyiXn1dCCZ5Fid4eLj/fBU2T5lxRA4whC8bmL45iCu8HS23D/HEs?=
 =?us-ascii?Q?hAp5s/kZ+U/roxhRxrdofukMSPa/wPAoDSv3hQB7bqHLIgKnfC//bJ8jzBEi?=
 =?us-ascii?Q?GplRlTB4n/QqQTG4HYyckJOd2ByKpESCPravHLnSn0zwyy+zqFeRhyRc86ly?=
 =?us-ascii?Q?fp7puzy1K2jNFk4033lzQ03dG/xmj6zPtb9abiAeJxGCbQrIa/t8LZgYbphg?=
 =?us-ascii?Q?YsTxQOnIQUffYfIhRaNA4UPQMHFkxJp99LpomfuxIdddqzVhoDLft11/tqWA?=
 =?us-ascii?Q?uPBzfuS1U4Z+A61CPqBCCDSrJYDvu8WLT/W9Ym+dwL1kNCOsoxDrcNObwAN7?=
 =?us-ascii?Q?BTi9pkHeOBrRoIluUlanoCAOGA0t5112dZwIZyToQ3JVKJZuea5sI3c4pTNN?=
 =?us-ascii?Q?aTaW4TTu1Q6MYZCeu4JNq6ly3jzW2Me0qc1fZrUTJjddngjtvh1RZ+GpcZfL?=
 =?us-ascii?Q?sDmqa54H0OFvCXtmgLcZ6cU8pdvr0CmlSHYahWl5j4OED37nKx/I5qK5k9PD?=
 =?us-ascii?Q?VJ1n0J+LjcToP3YaG22ZRSoxn/vyo8SB0MAB5arwyfklkhNGffSbq0g31MB1?=
 =?us-ascii?Q?0Cy+VnJNVMPI8itH/qz5BnTGBkFBtOJiwAVvOxySKR5wOX552CEyl+OAJTtJ?=
 =?us-ascii?Q?I+AxbIIjYM38Qu+MPH0cyQ/ID4bX+sJ8etq5EdLzVse0S8XlJ4gIuhPBGjPf?=
 =?us-ascii?Q?v5NF5fKce0iXCOHa793n+y170jnApZ8tab2CkT2JmXCXYnZiFd3q6E1/0Na+?=
 =?us-ascii?Q?KMgpfROZV30jKkSTt5HFABvgcJAdI98EKjkER8xwVF7N7waVh0h02S0JDHso?=
 =?us-ascii?Q?rQrKUKIxQcQQaAO/a4t5znEaAZl1CqmXTTKWUNQ+c62zXLIkXf8eSTarY/w7?=
 =?us-ascii?Q?55gUPCmUzaK7la3F0TxocPZEfAHANvfJ/FtK7U2AsPjDEzahCCr16SWgEJat?=
 =?us-ascii?Q?OyrMsoBg3ivRbUM79Y5aDKW4UBLTZbNCiHNHLreI0KQzcjAglSleoZp9cjQk?=
 =?us-ascii?Q?tOkUrhBSTN5zZRwB4yicBasl57MD891h5D9eHM/rpsXE3pyujohUZvRW0rXm?=
 =?us-ascii?Q?5dfR1k4DT9pjAqSbR1xqCvRpEAx04WVN5kjIScvyDBJ068tJjwi5SQzckj1r?=
 =?us-ascii?Q?2girQK8jVX6Ob6xpoho6Sc4L1D8btD8OBkRT402i9fxULjXLI28r+7EwFxHx?=
 =?us-ascii?Q?wR8uFwWMcQOCLEyZEwL6ImErfPms7PRVRyj4Y5UxEJQVHENzuXXexbf0UBgd?=
 =?us-ascii?Q?NeSJXso6gbb6AtGznZFB/hjwac1DTgo3gJ3fE3BXihN8f3QA2DG5Iz22JwfG?=
 =?us-ascii?Q?lMTbgyPGvi6T3khqnRI09E4AiF7YKajwG6IFD/4kLdTGXx4rBoRcVVuyPr2l?=
 =?us-ascii?Q?OPG5jx33yfsgiM8ZnJUGa9KYq9l4z7U6thErSadYz8J2047lYpLgoBMNbv1T?=
 =?us-ascii?Q?LO4YwadMgUNlwVP4EvaTKPPbSDSR7j3JD+1UcugbHTT9AdxQk1xEognXide/?=
 =?us-ascii?Q?vPNER9vzMM/E4vii5UFQoLxWcG5jjxnDZWqU85i4zWCVZQHkJPb5LiLGTZ7u?=
 =?us-ascii?Q?NPmOsCUdnXMre6ndpPbid8vzFaqHPjGcnUQpIiwkZ4FUq259aD/DIKBihxam?=
 =?us-ascii?Q?e0JG4jw5ZuoMdh7adQIcjJRluTUwONArBuf4QgBJFsysCo5A+fcezdRICcui?=
 =?us-ascii?Q?YaJw0R3JGb/vERbBFVLtdT+syYs63JAHeIdBgwJJ988ZKJfCGGGEavK9ibgw?=
 =?us-ascii?Q?WMU8HVAZAFCiUmRBF5jZbVXvxYPX8oY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb5e320-5073-4fa0-39d7-08de4e0f143f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:06:20.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8bW8czbDVraRpJkBj6xHsstQlIqMy1HQOWdQTyKVpfFjdUnQazIgxOuxaKrKHJJFUuEUWoRuwBp1UHdtNtL6OfwJNi86SZn9lUPD0gjfUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11074

Hi Cosmin,

Thanks for the patch.

> -----Original Message-----
> From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Sent: Wednesday, November 26, 2025 2:04 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>; Rafael J . Wysocki
> <rafael@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>; Zhang Ru=
i
> <rui.zhang@intel.com>; Lukasz Luba <lukasz.luba@arm.com>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Geert Uytterhoeven <geert+renesas@glider.be>;
> magnus.damm <magnus.damm@gmail.com>; Philipp Zabel
> <p.zabel@pengutronix.de>
> Cc: linux-pm@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Cosmin-Gabriel
> Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> Subject: [PATCH v3 2/9] thermal: renesas: rzg3e: make min and max
> temperature per-chip
>=20
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have different
> minimum and maximum temperatures compared to the already supported RZ/G3E=
.
>=20
> Prepare for them by moving these into a chip-specific struct.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
> V3:
>  * no changes
>=20
> V2:
>  * no changes
>=20
>  drivers/thermal/renesas/rzg3e_thermal.c | 35 ++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/thermal/renesas/rzg3e_thermal.c
> b/drivers/thermal/renesas/rzg3e_thermal.c
> index 86c10810e5bf..3c9ff5e43d7e 100644
> --- a/drivers/thermal/renesas/rzg3e_thermal.c
> +++ b/drivers/thermal/renesas/rzg3e_thermal.c
> @@ -62,8 +62,6 @@
>  #define TSU_SICR_CMPCLR	BIT(1)
>=20
>  /* Temperature calculation constants from datasheet */
> -#define TSU_TEMP_D		(-41)
> -#define TSU_TEMP_E		126
>  #define TSU_CODE_MAX		0xFFF
>=20
>  /* Timing specifications from datasheet */ @@ -72,6 +70,11 @@
>  #define TSU_POLL_DELAY_US	10	/* Polling interval */
>  #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
>=20
> +struct rzg3e_thermal_info {
> +	int temp_d_mc;
> +	int temp_e_mc;
> +};
> +
>  /**
>   * struct rzg3e_thermal_priv - RZ/G3E TSU private data
>   * @base: TSU register base
> @@ -79,6 +82,7 @@
>   * @syscon: regmap for calibration values
>   * @zone: thermal zone device
>   * @rstc: reset control
> + * @info: chip type specific information
>   * @trmval0: calibration value 0 (b)
>   * @trmval1: calibration value 1 (c)
>   * @trim_offset: offset for trim registers in syscon @@ -90,6 +94,7 @@
> struct rzg3e_thermal_priv {
>  	struct regmap *syscon;
>  	struct thermal_zone_device *zone;
>  	struct reset_control *rstc;
> +	const struct rzg3e_thermal_info *info;
>  	u16 trmval0;
>  	u16 trmval1;
>  	u32 trim_offset;
> @@ -161,17 +166,17 @@ static void rzg3e_thermal_power_off(struct
> rzg3e_thermal_priv *priv)
>   */
>  static int rzg3e_thermal_code_to_temp(struct rzg3e_thermal_priv *priv,
> u16 code)  {
> -	int temp_e_mc =3D TSU_TEMP_E * MILLIDEGREE_PER_DEGREE;
> -	int temp_d_mc =3D TSU_TEMP_D * MILLIDEGREE_PER_DEGREE;
> +	const struct rzg3e_thermal_info *info =3D priv->info;
>  	s64 numerator, denominator;
>  	int temp_mc;
>=20
> -	numerator =3D (temp_e_mc - temp_d_mc) * (s64)(code - priv->trmval0);
> +	numerator =3D (info->temp_e_mc - info->temp_d_mc) *
> +		    (s64)(code - priv->trmval0);
>  	denominator =3D priv->trmval1 - priv->trmval0;
>=20
> -	temp_mc =3D div64_s64(numerator, denominator) + temp_d_mc;
> +	temp_mc =3D div64_s64(numerator, denominator) + info->temp_d_mc;
>=20
> -	return clamp(temp_mc, temp_d_mc, temp_e_mc);
> +	return clamp(temp_mc, info->temp_d_mc, info->temp_e_mc);
>  }
>=20
>  /*
> @@ -180,13 +185,12 @@ static int rzg3e_thermal_code_to_temp(struct
> rzg3e_thermal_priv *priv, u16 code)
>   */
>  static u16 rzg3e_thermal_temp_to_code(struct rzg3e_thermal_priv *priv,
> int temp_mc)  {
> -	int temp_e_mc =3D TSU_TEMP_E * MILLIDEGREE_PER_DEGREE;
> -	int temp_d_mc =3D TSU_TEMP_D * MILLIDEGREE_PER_DEGREE;
> +	const struct rzg3e_thermal_info *info =3D priv->info;
>  	s64 numerator, denominator;
>  	s64 code;
>=20
> -	numerator =3D (temp_mc - temp_d_mc) * (priv->trmval1 - priv->trmval0);
> -	denominator =3D temp_e_mc - temp_d_mc;
> +	numerator =3D (temp_mc - info->temp_d_mc) * (priv->trmval1 - priv-
> >trmval0);
> +	denominator =3D info->temp_e_mc - info->temp_d_mc;
>=20
>  	code =3D div64_s64(numerator, denominator) + priv->trmval0;
>=20
> @@ -392,6 +396,8 @@ static int rzg3e_thermal_probe(struct platform_device
> *pdev)
>  		return ret;
>  	platform_set_drvdata(pdev, priv);
>=20
> +	priv->info =3D device_get_match_data(dev);
> +
>  	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> @@ -526,8 +532,13 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops =
=3D
> {
>  	SYSTEM_SLEEP_PM_OPS(rzg3e_thermal_suspend, rzg3e_thermal_resume)  };
>=20
> +static const struct rzg3e_thermal_info rzg3e_thermal_info =3D {
> +	.temp_d_mc =3D -41000,
> +	.temp_e_mc =3D 126000,
> +};
> +
>  static const struct of_device_id rzg3e_thermal_dt_ids[] =3D {
> -	{ .compatible =3D "renesas,r9a09g047-tsu" },
> +	{ .compatible =3D "renesas,r9a09g047-tsu", .data =3D &rzg3e_thermal_inf=
o
> +},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
> --
> 2.52.0

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>


