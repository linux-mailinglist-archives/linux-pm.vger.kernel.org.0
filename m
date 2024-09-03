Return-Path: <linux-pm+bounces-13423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375F969EB7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485FD1C236F6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFD1A42CB;
	Tue,  3 Sep 2024 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ZpzxxRps"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010033.outbound.protection.outlook.com [52.101.229.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE01CA6BD;
	Tue,  3 Sep 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368949; cv=fail; b=u9K+4dl/qqxnKILaOPwcrj6cXqEi4GzbaCuUZwNLUETAACmJ4opRGfI0Wpy6qzm0pU0nsjiue6uTworkf6q9E9PfejSq3IFO0dfJYsPqMPbb64HgTDYEOMWW/zQhtREmiesGrp79VQK9fce0CN9x7RJHL40IO98C7p6HkjR2suU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368949; c=relaxed/simple;
	bh=842DEPKmP5kIG5T94tqj9WGAimjQGxHQ3AcJcNBkX0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HsjORMpzHeNKB7a2M5zPJiduoG+dq5lgYv+UYwqRZsT7sKZ2scHL8toxCPt8jtAttRE6oYIw9quKu20YT1JdsPq69foZ9ogSYobFAc1857sUdEr3i/ad5YCpLxoT84QRJclDLh4IWotUB0jTMpOVULn2W1b/Rx1k+ISCGL+Li6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ZpzxxRps; arc=fail smtp.client-ip=52.101.229.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCbnXwGvM3okxs162iV6y3zHzV+iLESgIpD6j2mPDOZiWPbgs2h5F2AtZmP6Hn8vqTebCTyXJsVO+RpuhN9gIQvwzf5/Cy7iAtMYmzcTFNLf4tz+4edFS23e5Og+jCAdSkcCrFXJqhTVzfzi8TEjQlfesWgQLYX2DgZ/GAUkzc7k5Jjwc0BF3/bEDLc1y474iuPKVlN7pmeiCpO3aabaLtm1rHbdnjnPFOGdKi3L7fNV+iTtjawcS5vGkWsabC2UxXWwBov5gOTH46sGrdg3bPy+gpb7NxhdRrmBAPOGRRo3Mtt7u1qUSeY9E2tOKMKwi3+XR6uNjDC7lZmJ9ljoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=842DEPKmP5kIG5T94tqj9WGAimjQGxHQ3AcJcNBkX0w=;
 b=U6j67RtqWez3+xQ/v3DV8u6eGhMbTRpGvynHsis3Ig3fu1OQuDzdibI6sjCyKWIZ1CGJL4HULb9NNRDM7F57Lm0b0DqzfO7LKY9GMqs+Y39aRRE4ou8ifFQ8CIVBGkW+BQNq+MW5nVXnj3hW5TtQIjGEnVbLGCaBEtWmdiItO19APVNnUaaBZJYVvrzBYGzQu0QzYBk+fBy6X2t6fpaBnwNlXdOtFzd+kXTGCAzJLZqWsBzdOpMDR+LvKiJ+00Y3EzNnxhTQISQoIfz+X8K1rbAH8P45zEHGWmt7dFy3rV4UNAqULEoq8/8urvm6KlRVsa3hRTdMr5N5utJJAT9n/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=842DEPKmP5kIG5T94tqj9WGAimjQGxHQ3AcJcNBkX0w=;
 b=ZpzxxRpsCpTGLDsq/H3L6RQSvp99PFv01ALprtHo1xiOueaKmTn5BDOInaSLV72ITDnDJNmQcbxVD3CZCq/4vGQZDAtEWe6OWDkyxac17eWiotaFckFN1PL8dAR1NHphWsS+amA9bK9FS+/ddNongFmzJgk19rCgQe2r1UxF8nE=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS0PR01MB5892.jpnprd01.prod.outlook.com (2603:1096:604:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 13:09:01 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 13:09:01 +0000
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
 AQHa9KfrLpE8CCuWg0uaPyaAgZR3ArI+ZjUAgAEcCoCAAVgqEIADVdkwgAAP5ACAAACycIAABtQAgAAAhkCAABeagIAAAFcwgAFU0LCAADjlgIAAAKQQgAAJGICAAAE9UIAADyWwgAAHkoCAAADSkIAAB+2AgAABx5A=
Date: Tue, 3 Sep 2024 13:09:01 +0000
Message-ID:
 <TY3PR01MB11346FAC6022C81ED8B9B2DC386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS0PR01MB5892:EE_
x-ms-office365-filtering-correlation-id: c9bfb451-7a66-47d2-ecc4-08dccc199413
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVA4Mkh6WUVmaUhlWXQraTVIcVR6RFgwSFVmS2ZuQnE1Qm5VUXBZNUZ6aUNJ?=
 =?utf-8?B?TXAzSGtxd3Y1c3VEb2tBdGhtN3VZMWRsY0EzNzVGeE80ZmNLb3diQXVzTW12?=
 =?utf-8?B?Qi9YYXhkZEtYbnA2UlEwai9iY0hTTzZsOGZKQllUc1BhL3QzUHZzUThvektL?=
 =?utf-8?B?dklJeWFmRU1WL3lWd1pEeVE1QjlrTFFVWUVTOWpaVVo0c2JqdFZ5MVpUa05J?=
 =?utf-8?B?SmFUV3BnWU1XWDdZSkcwL3dVTk13YUl0UU5wRjdXbWZtcjcvVlpLSkZONmxG?=
 =?utf-8?B?OVhRUEZXdXM1bVRDT1QrZEtRelJYWUM4VkFOQ3hYeHVkaFdHOHgxSzVvNm9j?=
 =?utf-8?B?ejlRa0l0aGMxSGZpa3g5WXExV1UyY0lNU2krdjJ6MDlpZXY2Ny9QN0c5TTkr?=
 =?utf-8?B?WE5Va1plOS9xd2Z1UmdYREsybjV4c2JDU284VFFrLzBkaUZBSk4vY2R3YUhC?=
 =?utf-8?B?UXBuRlR2Q2dKVjB0ODM2eE81NzEra0xCL1IrMU53WWcxUVplbjVQeXNmd0t4?=
 =?utf-8?B?czh4V2Z5aFptalJldUtmZEVFWmhoZzd2eEtUcXBrc2dMaEdaKzBKdTd3VWZ1?=
 =?utf-8?B?OXIzN2RQZ3NpVlRJcDc0MFhYZ25FT3ViQXJrSzB3bjFieXJ2SWI2SDRyTXRt?=
 =?utf-8?B?aDUrZUNLMEkycGh4eUJPQmpwZUw1c09BNFpyKytoVWJTVWlhU3RTOVFydE54?=
 =?utf-8?B?Y01xZUFqN1grd0pnNU15Mk1jVDFLZVZNNGcraDFDc1prVFRmMnk0UHVacTFa?=
 =?utf-8?B?ZVRKcFJmVEFwZlFRNWJsbW9YZmg0ZEFsMDRGL3NiOHE0TmRLT0VPN0tsUE44?=
 =?utf-8?B?clBIenBLY3pLNExrbkgvTXVaOVRwRUlhdEdOU0xBYk9Dc1lQSEVibSsveGxs?=
 =?utf-8?B?d3NNdGhrQ0srMkhwVjhRRDdlVlkyOUlDY2NtdjIwTjZMUUlRTSs4aHFPZnBx?=
 =?utf-8?B?MjRpc1REdzlnaEdnOURoL25KWlk3WnR0cGE1SDBzbFhveFQ1VEpGL0lJVTBL?=
 =?utf-8?B?ODVZVE92VVlIWStMWE04aGlCei80aCtGL2huRnNVWkdOd3pzK29RZXFMdCtp?=
 =?utf-8?B?cEs5aVlHd24rZ0hmZXcwZ0tMSHFsY2FQUFJYUGQxNWpEVUV5dTExeW84dTZ5?=
 =?utf-8?B?bUREemZBT2RrUGppRmhHNzlQNUdjMHUwOGRvdnBZZXg0eE1uS2ZYRkNrd3Fq?=
 =?utf-8?B?SitQZFhaTHpqL1diWjhKRXk1WlBoMGFsOXV3M1dWc1JWbVJDaTVwQVdBVjEv?=
 =?utf-8?B?SHprNTUwUmVqQVc5emhlVGdNWm04RUpMMm85UHFQWTdTUnVaWlo0cUd6L3BO?=
 =?utf-8?B?ekJ1NU5OVW4zMzNqejJWdkMwcDZVQzlpcUM0Mi9xSGNiTWRTQzhpeEEwcEh1?=
 =?utf-8?B?RExwNEVOSWlrdkNuZ1M4VVhEb3p5OENCMEtzZk9Dd1NhMVZERHZrTDRMWVcv?=
 =?utf-8?B?ajRtdE1jcko0S2FRYmtrT1hLM0lHenI5QzIvMkI0aGZlVmh6bXJKdFVpRWpt?=
 =?utf-8?B?VWFWL2FlRG4yeVFIYS96dk14L0luYXhzSGk1TEtuLzFDcG5FWTcvU2ZTaktj?=
 =?utf-8?B?NjNqZXgrd1Nyd1EzR2h2alYxQjdmbEJtamFpbTJQK3JqTXh4ZlczMW0rOVBR?=
 =?utf-8?B?OGcrTU5qRlRVeExlblUwMFFreXFvS2dMUHhqemZvNUxkR01KWVk0RUMvaUwx?=
 =?utf-8?B?eVRYZ2ZYNmRocUwwdmNhTGN2eVZYSW1RM05wMGxBSytCZFRSUE9wS2RrL3ND?=
 =?utf-8?B?aXd3dmp1d3FxcFZpTHZaTHpCZk53RlpxUlJNV2RZeEFvdkhadVdSck1OSytr?=
 =?utf-8?B?OUlQSzQ3UGRjMTl1NC9HMmMxZUVhUWJDYkNaaFlLaXFpWlFWSHYzSXlGZm5k?=
 =?utf-8?B?YXIvek92QWpaeVJESWZkYWhzYWVsMU5xUDVkVHE5eDZnWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0JrellyWlJnQkFydXM1N2tMZGVjN3NSalNCV0dMVXZvS1U0aWp0UlpnUyt1?=
 =?utf-8?B?NGtERDRoNHFaampUaUU0VWY2b0xoK2FaSEt2SEUwOGxJOXhoV2NEakluQWZt?=
 =?utf-8?B?VDF3RVdxU2tiUVFGcUpPU1A5ck1yNUkvR2xhRlVGOTQ5eUpiMWVtaFJpWkxD?=
 =?utf-8?B?cHRxNzVKL3hOdkdwc3ZRdzBCL0VJd1hzR3N5UzFiZWcwRHJOcXdKY3BaMUFY?=
 =?utf-8?B?MUM0K0lUekkxbVl2dlNwdy9TVEVqYnAxcm9neTl3RnczMm8yTTRGY05oNWZs?=
 =?utf-8?B?NU5wQ2hyV2dyUFBMNmtVY1kyMWFvZ09oOCtKMmtKZzFDMDU0M29wSlBHQ1or?=
 =?utf-8?B?TlZoQ2Jkb3l3azNkZUE4ZExEWktYSjBsNEdkaVFoZ1dPM2lSUlNzWnIzTGpB?=
 =?utf-8?B?RHl4TUJhMk9GYWpLQWQvYzR3TWlETndQTzBBTTBYOTU1bFcvSHB5ZjB6UlBw?=
 =?utf-8?B?T3dGSjR6aTE0OXJ4b2hYUnp1UWtkaVlYSmdqcGYzTlZ4TW5hR2tMcVlHL0dE?=
 =?utf-8?B?d3ZJQVQxaWtESlRQa0hUV0hUWCsrUms2WldyYVFyOXF3WmphcGdtMmppV0hZ?=
 =?utf-8?B?aDJQK3JZT2t3WFFla2pwamxsVzlMblUzTytLejNVRXVqVFY1WkswMFpnRDJG?=
 =?utf-8?B?eGhEWFV5dERBd1lMWi9Kd3Y1YVlkblpCTzlIZVdERXl5ODdZK0daM04zR3Yy?=
 =?utf-8?B?S0N1c1BIVjBSM0FmRnhoaVhaRmFqdVBtSHpWbnh2RkMvUEZhT1pxNGd3WkY0?=
 =?utf-8?B?VFl3UlN4TktJazZuNmFLMVFVZ3dkczJwUmt2WnQvQWg3aUgvNlU5RlhVY0RV?=
 =?utf-8?B?emVybm9FM2RQSFdmR3J1OFpGQXZxZlJDTXgwa0tqdlFVOCtnSWVoZk1DUHlL?=
 =?utf-8?B?ZWNBT1pCK3N5cWVQRHh1aU1lSzYvak9uL1luU2pJVXZXMk02R0hXcDlDbzk1?=
 =?utf-8?B?ekxoeC9nZGltb1VXS0VrclJGZHVWdHBjL3ZXc1F6aGpaOVpKL2txY1JSSHp4?=
 =?utf-8?B?Wi94aHpnM3gxVVF0SVV1S1hCZnNxNjR6aW91YXFKWUc0UTdNNHFrQ2hYOVd5?=
 =?utf-8?B?OUV4YTI0VnhONThIS1FUSEJQczRGR1FDd2d2ZzhPVVdHSGx4NlUxRkZzK1Nj?=
 =?utf-8?B?bHJ1Q2ltdTJHTnArQ2xKNjIyYjZPUTNYYXQyOFhYWUg5VzZnNWdHd0JjZW9Z?=
 =?utf-8?B?QXd1WGxjMzVFb21TOWF6bWJ2V1pjL0JHNW1sTUt5d3NITFRBM1B1VlhCc0Yw?=
 =?utf-8?B?UHVUc09BWFF5MWFndG9DNEFUblUrNmwwWFdhQWtWOWZmRkVvQWNZS3VNRytw?=
 =?utf-8?B?M1Y5aDZ0RFU0Rms2VmFoYkhYd3FHUGpVK1NOMXBtOS85OGxFMytmclJZOTRt?=
 =?utf-8?B?NE53QURrY0cxUnoyVFVIaldOZ0lSRzFYZDllOVUwSEVNK1BoMHpJV2lEd1Fx?=
 =?utf-8?B?MjdHL1ZsSkMra1NlMWxRbzFpd3RkdytXOTZuMkY3bXpWbVd6SHMzbkhSbVVH?=
 =?utf-8?B?M1doUlBxZHR2bWk4VytPdHlpdXhXcnBuM3p3eHRmNWwzang2bmpkbjNVUnpl?=
 =?utf-8?B?bXhrKys5VDg2bXdtNS9QU1EzY2s0NnQyM0RPZmc5dTJvT2d5bUxPdmp5Umcw?=
 =?utf-8?B?SWkycjM4SlZsSEFaa1RwTjRQMDlyQk5La0E3Um11RHlkNzY2SUtUTDlOQjUy?=
 =?utf-8?B?N2o0NjdncXZxa0U1RExHdEIwdHdKbVhSM2ttQkY0Z0FyYjdNNGd1RVFWZ0xv?=
 =?utf-8?B?R3FseFpNYkY2RXNRNWkyNWhvelZaamdJcm5jNUhOczJTNndnd3BTdDNyaEIx?=
 =?utf-8?B?YnNEWVhDYkxDV0FqRmcrbndkVmU5NWErMzhRejFGbWlUT3A3cFNjQzQ0ZWZF?=
 =?utf-8?B?UmVlY29yNGl4YmpWb2JjT0EzSW5tNU9iQ01OV2xRcFpKMTZObzY1QVRNVVVk?=
 =?utf-8?B?TlB5cUxkVXM4L0VZM0F1YWp5ZXRWREpxZ2NTK29CRlF1MkRBYkgwNldMSlJk?=
 =?utf-8?B?dXZwQXAvQVJ4MFhNK0FBNHYveGJiYndiamNGdmRnWEtjdGFuWkdhUFpCcjFZ?=
 =?utf-8?B?WVpJUU5uaEcvNzZaZC9CVExOYVI1WHlWeG16UTVWdWtXQUpPMHlCckt1L05h?=
 =?utf-8?B?VElHeFlEU3pHSFN5Z2ptOXhPZGZ5MTVoODhDNE1za3FZaEUzRXhxSGI3QmNu?=
 =?utf-8?B?TlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bfb451-7a66-47d2-ecc4-08dccc199413
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 13:09:01.0307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g07xhPNGLA3m4oHfPEvg2v5ojOuIXeuZhAalN0eBcQ6V48S76M1xYOC2NEoTYZvpWKXV7FhCqSApQOycaZt7KcBIl/c3XG3ROb1y5YSIFTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5892

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBUdWVzZGF5LCBT
ZXB0ZW1iZXIgMywgMjAyNCAxOjU3IFBNDQotDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBtQHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJw
LnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBBZGQgaW5pdGlhbCBV
U0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlovRzNTIFNvQw0KPiANCj4gDQo+IA0KPiBPbiAw
My4wOS4yMDI0IDE1OjM3LCBCaWp1IERhcyB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IGNsYXVkaXUgYmV6bmVhIDxjbGF1ZGl1LmJl
em5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAzLCAyMDI0IDE6
MjYgUE0NCj4gPj4gVG86IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFVs
ZiBIYW5zc29uDQo+ID4+IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+PiBDYzogdmtvdWxA
a2VybmVsLm9yZzsga2lzaG9uQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4ga3J6
aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4
LmRlOw0KPiA+PiBnZWVydCtyZW5lc2FzQGdsaWRlci5iZTsgbWFnbnVzLmRhbW1AZ21haWwuY29t
Ow0KPiA+PiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b207DQo+ID4+IHNib3lkQGtlcm5lbC5vcmc7IFlvc2hpaGlybyBTaGltb2RhDQo+ID4+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT47DQo+ID4+IGxpbnV4LXBoeUBsaXN0cy5pbmZy
YWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtIHJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4g
Pj4gbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiA+PiBsaW51eC0gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtcG1Admdl
ci5rZXJuZWwub3JnOyBDbGF1ZGl1IEJlem5lYQ0KPiA+PiA8Y2xhdWRpdS5iZXpuZWEudWpAYnAu
cmVuZXNhcy5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDAvMTZdIEFkZCBpbml0aWFs
IFVTQiBzdXBwb3J0IGZvciB0aGUgUmVuZXNhcw0KPiA+PiBSWi9HM1MgU29DDQo+ID4+DQo+ID4+
DQo+ID4+DQo+ID4+IE9uIDAzLjA5LjIwMjQgMTU6MDAsIEJpanUgRGFzIHdyb3RlOg0KPiA+Pj4N
Cj4gPj4+DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4gU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDMsIDIwMjQgMTI6MDcgUE0NCj4gPj4+PiBUbzogQ2xhdWRpdS5CZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj47IFVsZiBIYW5zc29uDQo+ID4+Pj4gPHVsZi5oYW5z
c29uQGxpbmFyby5vcmc+DQo+ID4+Pj4gQ2M6IHZrb3VsQGtlcm5lbC5vcmc7IGtpc2hvbkBrZXJu
ZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4+Pj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+Pj4+IGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlOyBtYWdudXMuZGFtbUBnbWFpbC5jb207DQo+ID4+Pj4gZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc7IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiA+Pj4+IHNib3lk
QGtlcm5lbC5vcmc7IFlvc2hpaGlybyBTaGltb2RhDQo+ID4+Pj4gPHlvc2hpaGlyby5zaGltb2Rh
LnVoQHJlbmVzYXMuY29tPjsNCj4gPj4+PiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4gbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtIHJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+PiBsaW51
eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+ID4+Pj4gbGludXgtIGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgQ2xhdWRpdQ0KPiA+Pj4+IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVu
ZXNhcy5jb20+DQo+ID4+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCAwMC8xNl0gQWRkIGluaXRpYWwg
VVNCIHN1cHBvcnQgZm9yIHRoZSBSZW5lc2FzDQo+ID4+Pj4gUlovRzNTIFNvQw0KPiA+Pj4+DQo+
ID4+Pj4gSGkgQ2xhdWRpdSwNCj4gPj4+Pg0KPiA+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+Pj4+PiBGcm9tOiBjbGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24u
ZGV2Pg0KPiA+Pj4+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMywgMjAyNCAxMjowMCBQTQ0K
PiA+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzE2XSBBZGQgaW5pdGlhbCBVU0Igc3VwcG9y
dCBmb3IgdGhlIFJlbmVzYXMNCj4gPj4+Pj4gUlovRzNTIFNvQw0KPiA+Pj4+Pg0KPiA+Pj4+Pg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBPbiAwMy4wOS4yMDI0IDEzOjMxLCBCaWp1IERhcyB3cm90ZToNCj4g
Pj4+Pj4+Pj4gRHVyaW5nIGJvb3QgY2xyIFVTQiBQV1IgUkVBRFkgc2lnbmFsIGluIFRGLUEuDQo+
ID4+Pj4+Pj4+IFNUUiBjYXNlLCBzdXNwZW5kIHNldCBVU0IgUFdSIFJFQURZIHNpZ25hbCBpbiBU
Ri1BLg0KPiA+Pj4+Pj4+PiBTVFIgY2FzZSwgcmVzdW1lIGNsciBVU0IgUFdSIFJFQURZIHNpZ25h
bCBpbiBURi1BLg0KPiA+Pj4+Pj4+IEFzIEkgc2FpZCBwcmV2aW91c2x5LCBpdCBjYW4gYmUgZG9u
ZSBpbiBkaWZmZXJlbnQgd2F5cy4gTXkgcG9pbnQNCj4gPj4+Pj4+PiB3YXMgdG8gbGV0IExpbnV4
IHNldCB3aGF0IGl0IG5lZWRzIGZvciBhbGwgaXQncyBkZXZpY2VzIHRvIHdvcmsuDQo+ID4+Pj4+
Pj4gSSB0aGluayB0aGUgd2F5IHRvIGdvIGZvcndhcmQgaXMgYQ0KPiA+Pj4+PiBtYWludGFpbmVy
IGRlY2lzaW9uLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkgYWdyZWUsIHRoZXJlIGNhbiBiZSBuIG51
bWJlciBvZiBzb2x1dGlvbiBmb3IgYSBwcm9ibGVtLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpbmNl
IHlvdSBtb2RlbGxlZCBzeXN0ZW0gc3RhdGUgc2lnbmFsIChVU0IgUFdSUkRZKSBhcyByZXNldA0K
PiA+Pj4+Pj4gY29udHJvbCBzaWduYWwsIGl0IGlzIHJlc2V0L0RUIG1haW50YWluZXIncyBkZWNp
c2lvbiB0byBzYXkgdGhlDQo+ID4+Pj4+PiBmaW5hbCB3b3JkIHdoZXRoZXIgdGhpcyBzaWduYWwg
Zml0cyBpbiByZXNldA0KPiA+Pj4+PiBzeXN0ZW0gZnJhbWV3b3JrIG9yIG5vdD8NCj4gPj4+Pj4N
Cj4gPj4+Pj4gSSB3YXMgdGhpbmtpbmc6DQo+ID4+Pj4+IDEvIEdlZXJ0IHdvdWxkIGJlIHRoZSBi
ZXN0IHRvIHNheSBpZiBoZSBjb25zaWRlcnMgaXQgT0sgdG8gaGFuZGxlIHRoaXMNCj4gPj4+Pj4g
ICAgaW4gTGludXgNCj4gPj4+Pg0KPiA+Pj4+IEkgYWdyZWUgR2VlcnQgaXMgdGhlIHJpZ2h0IHBl
cnNvbiBmb3IgdGFraW5nIFNZU1RFTSBkZWNpc2lvbnMsDQo+ID4+Pj4gc2luY2UgdGhlIHNpZ25h
bCBpcyB1c2VkIG9ubHkgZHVyaW5nIHN0YXRlIHRyYW5zaXRpb25zIChUYWJsZQ0KPiA+Pj4+IDQx
LjYuNCBBV08gdG8gQUxMX09OIGFuZCA0MS42LjMgQUxMX09OIHRvIEFXTykNCj4gPj4+DQo+ID4+
PiBPbmUgbW9yZSBpbmZvLCBhcyBwZXIgWzFdLCB0aGlzIFVTQiBQV1JSRFkgc2lnbmFsIHNldHRp
bmcgdG8gYmUgYmVmb3JlIExpbnV4IGtlcm5lbCBib290cy4NCj4gPj4NCj4gPj4gVGhlICJjb250
cm9sbGVkIGJ5IiBjb2x1bW4gbWVudGlvbnMgQ0EtNTUgb24gUFdSUkRZIHNpZ25hbCBjb250cm9s
DQo+ID4+IGxpbmUgYW5kIGl0IGlzIGIvdyBzdGVwcyAiRERSIGV4aXRzIGZyb20gcmV0ZW50aW9u
IG1vZGUiIGFuZCAgImNsb2NrDQo+ID4+IHN0YXJ0IHNldHRpbmdzIGZvciBzeXN0ZW0gYnVzIGFu
ZCBwZXJpcGhlcmFsIG1vZHVsZXMiLiBBRkFJQ1QsIGFmdGVyIEREUiBleGlzdHMgcmV0ZW50aW9u
IG1vZGUNCj4gTGludXggaXMgcmVhZHkgdG8gcnVuLg0KPiA+DQo+ID4gRERSIHJldGVudGlvbiBl
eGl0IGhhcHBlbnMgaW4gVEYtQSBhbmQgaXQganVtcHMgaW50byByZXNldCBjb2RlIHdoZXJlIGl0
IGV4ZWN1dGVzIEJMMiBpbiBURl9BLiBCbDINCj4gY2hlY2tzIGZvciB3YXJtIG9yIGNvbGQgcmVz
ZXQuDQo+ID4gSWYgaXQgaXMgd2FybSByZXNldCwgaXQgc2V0cyByZXF1aXJlZCBtaW5pbWFsIGNs
b2Nrcy9yZXNldHMgYW5kIHBhc3MNCj4gPiB0aGUgY29udHJvbCB0byBsaW51eCBieSBjYWxsaW5n
IHRoZSBTTUMgY2FsbGJhY2sgaGFuZGxlci4gV2hpY2ggaW4gdHVybiBjYWxscyByZXN1bWUoc3Rl
cCAxMS0tPjE0KQ0KPiBwYXRoLg0KPiANCj4gSXMgdGhpcyBmcm9tIEhXIG1hbnVhbCBvciBzb21l
IHNwZWNpZmljIGRvY3VtZW50YXRpb24/IEknbSByZWZlcnJpbmcgYXQgInJlc3VtZSIgPT0gInN0
ZXBzIDExLS0+MTQiDQo+IA0KPiA+DQo+ID4gU3RlcCA4LCBDb3J0ZXgtQTU1IEV4aXQgZnJvbSBE
RFIgcmV0ZW50aW9uIG1vZGUgKHdoZW4gdXNpbmcpIFNldHRpbmcNCj4gPiBmb3IgZXhpdGluZyBm
b3JtIEREUiByZXRlbnRpb24gbW9kZSBTdGVwIDksIENvcnRleC1BNTUgVVNCIFBIWSBQV1JSRFkN
Cj4gPiBzaWduYWwgY29udHJvbCAoaWYgdXNlIFVTQikgU1lTX1VTQl9QV1JSRFkgU3RlcCAxMCwg
Q29ydGV4LUE1NSBQQ0llDQo+ID4gUlNUX1JTTV9CIHNpZ25hbCBjb250cm9sIChpZiB1c2UgUENJ
ZSkgU1lTX1BDSUVfUlNUX1JTTV9CDQo+IA0KPiBOb3RlICppZiB1c2UqOiBob3cgZG9lcyB0aGUg
VEYtQSBrbm93IGlmIFVTQi9QQ0llIGlzIHVzZWQgYnkgTGludXg/IFRoZSBkb2N1bWVudGF0aW9u
IG1lbnRpb24gdG8gc2V0DQo+IGl0ICppZiB1c2UqLiBTYW1lIG5vdGUgaXMgb24gQUxMX09OIHRv
IFZCQVRUIHRyYW5zaXRpb24gZG9jdW1lbnRhdGlvbiAobmFtZWx5ICJpZiB1c2luZyBVU0IiLCAi
aWYNCj4gdXNpbmcgUENJZSIpLiBJZiBURi1BIHdpbGwgZG8gdGhpcyBpdCBzaG91bGQgc2V0IHRo
aXMgc2lnbmFscyB1bmNvbmRpdGlvbmFsbHkuIEl0IHdpbGwgbm90IGJlDQo+IHNvbWV0aGluZyB3
cm9uZyB0aG91Z2guIFdlIGRvbid0IGtub3cgYXQgdGhlIG1vbWVudCB3aGF0IHRoaXMgaW52b2x2
ZXMgaW4gdGVybXMgb2YgcG93ZXIgY29uc3VtcHRpb24sDQo+IGlmIGl0IG1lYW5zIHNvbWV0aGlu
Zy4uLg0KDQpZb3UgbWVhbiwgeW91IG1vZGVsbGVkIHRoaXMgYXMgcmVzZXQgc2lnbmFsIGp1c3Qg
dG8gcmVkdWNlIHBvd2VyIGNvbnN1bXB0aW9uIGJ5IGNhbGxpbmcgcnVudGltZSBQTQ0KY2FsbHMg
dG8gdHVybiBvbi9vZmYgdGhpcyBzaWduYWw/Pw0KDQpEb2VzIHdpbGwgaXQgaGF2ZSBhbnkgc3lz
dGVtIHN0YWJpbGl0eSBpc3N1ZSBhcyBoYXJkd2FyZSBtYW51YWwgc2F5cyB0byBkbyBpdCBhdCB2
ZXJ5IGVhcmx5IHN0YWdlDQpiZWZvcmUgc3RhcnRpbmcgYW55IGNsb2Nrcy9yZXNldHM/PyBIYXZl
IHlvdSBjaGVja2VkIHdpdGggaGFyZHdhcmUgdGVhbT8NCg0KQ2hlZXJzLA0KQmlqdQ0K

