Return-Path: <linux-pm+bounces-13182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D73964AD0
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7781C2414B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348A1487F1;
	Thu, 29 Aug 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="DMaX7AdE"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7E1B3720;
	Thu, 29 Aug 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947136; cv=fail; b=ahjiAy14KQaTPD5G0sl3UDjTraFvtiN5Iy1oy0C+oxvaJCxpRrBkr83XQmMX9NBM+ps3B0A3jg4bTri1yEr9NoCp5MbTdE+J8K1sxrW/ebFYu+jTzS8RgxZ8WdZjYk+WOfBvpwddmltMyREMbW5a1+WgLqQi/gfRWA9jHaElzDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947136; c=relaxed/simple;
	bh=jVWc/YfvRiiH3Dg03dd9YX2oZ4m5qk5n2o6H15KBhPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WSq52Qtz4mxpVdshVgSCISc9VcFW26Q9KJDKQfX/7BbwO7AHtTs0KkH0H/vEOpcJ59PqbJOXInXkYDoL7OuHHxnp19ZRFQLtmshb3CmlN1xe26u+tDcDYRUJIxfihAjCcIVkZsBpstQDT2acX4u6bGTLBv3pqQ0A6GlyiHzN0iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=DMaX7AdE; arc=fail smtp.client-ip=52.101.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7NCWwWM05g345yY06PJnxNLF5vND+dcR9FxXfCFS6yvEKERmYi5HIzePlYYTrlwiYazi5cm0WGkTfwRkYlCk84dckN46TUXDDPpgcsio3u7jdtr8s8sBfPu1z9eAQfZckvcNvm0TDs1eNqv9ihFmn+wHSR7/svPaVAOaAfMD2Ii7qirA+OnRjyBnuNZzv6eIg1IawzZYgAwkpr+RbpW4xldfe32rhyT2vI7DQnOJx9KVEooTtUyFqtbWjRuDe32/fM8mZA6VEn9PCfcVzBwiTOLOvZoGIOYFy9w03mtqVRRSZJJThK2t790ZXfQvvbx8XALeMM1RC860b2jFdtDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVWc/YfvRiiH3Dg03dd9YX2oZ4m5qk5n2o6H15KBhPI=;
 b=eiRkR/VCw5UF9AFGbX73Xt8Z1l+qScZA0AXsdW+HhQyop9deZ4iZqDs0db9KLRMmfgUAMvs6st2RvknAEQ/QvWdWy9c7prMgnKeH+ohqOvaerpq6oqb5Il1Ny26pkurg63am493PnvEFj9n1Ab5se7ee24I5bWy6G4qkKqP2eFg6na8LiSWpeSxMcABqVbasBT7ygWLUh7d4gHKwZJ0WHm9fXU4TDHRKNJyLvKj3VVUTs2vhfURG+shiYO0WvHVPuqqStn85ogSc97SIwJt0lJsPgMSqqYVC5nud4wqVJf8fk2i/X/BbMmmeN/DRX8uv2MDExhBwvvkn4tyODMPRJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVWc/YfvRiiH3Dg03dd9YX2oZ4m5qk5n2o6H15KBhPI=;
 b=DMaX7AdEnF9q8I7E2KGfNvjHM3ujRHc048ZrgNSIf01WntGfj96PncxIAwX3pWhQVOFGdVH5UwLUCpaX1Ray2JFm28IYbkcbBLqtl1aQhR8A83Q0F2nIkONhzOzE7y8HRBCHsxeIzXeBDW0Yal+jh5v8Kz8/PaIK++Ab97neUqs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB8084.jpnprd01.prod.outlook.com (2603:1096:604:165::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 15:58:47 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:58:47 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v2 2/3] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
Thread-Topic: [PATCH v2 2/3] clk: renesas: r9a08g045: Mark the watchdog and
 always-on PM domains as IRQ safe
Thread-Index: AQHa+VN+VAarWIT5GkaeuagNwroQfLI+L94AgAA1iOA=
Date: Thu, 29 Aug 2024 15:58:47 +0000
Message-ID:
 <TY3PR01MB11346BBAEB9DBB9C6A969DEC386962@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240828140602.1006438-1-claudiu.beznea.uj@bp.renesas.com>
 <20240828140602.1006438-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdUcstyRDfaQ0Y=1NHgBYuRWjC0vuJj2j8USCTsEE1qKVA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB8084:EE_
x-ms-office365-filtering-correlation-id: 6b745eba-d763-460f-e977-08dcc84377c3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0xUd0xYR3RTcDFOeHZLbTBiOUpxTnd1dDYxUEJUSFBwMVhrOGVpMXlvZngy?=
 =?utf-8?B?akRKV2FrTkg4QXBFMVEwQVJaNmxTcUZDODJYelpHc0taMC9OOU1XcFF6YlZK?=
 =?utf-8?B?MjZORzNVN3pvcDFuV2Q4a09HaC9CVzRTcmpkdHBVV1d1SlhZSW82UW0xVmV0?=
 =?utf-8?B?WFV3eDZMdWZCTFEwQ0dSd2lHV0YrM2ZsZGJpeCtTZi9YamRKYklGbWExY2xx?=
 =?utf-8?B?eXJUY0svYWtxOVN0QmYxVnN1S0ExQWppc01nVTJZY00yYk41UW1yZEYyaFR3?=
 =?utf-8?B?cnJtRkliUVN5MkdELzM3K25lVENyQ2xYVnU5SnROU2s5ZTlEcEQ2R0oxL2RM?=
 =?utf-8?B?d1NreTI5MTlKZ1ExMFo1KzNPa3RWZVhENXZOaTArMlJ5MmNxSVdtUERCT1JT?=
 =?utf-8?B?Q2I0Qmc4andwTXJPSXpTalRxUzFwTGxGL2hEemtHTjIxNDFMREFpbi9PMEF0?=
 =?utf-8?B?VGxaalNGM0pENUlYVTVrZms4Y3RkdkZZMVl5TllPWno5NXBJUmNIYjNIWVdZ?=
 =?utf-8?B?b292dVBXWjFmMmFnWmVDWU9TNy84UGhyemk5WllLaGQ3UUw1RzE4YnFlVDUx?=
 =?utf-8?B?Z0ZtQ3EzM3pVYzlSclUzUzFYZGp2MUs1OHEyaFNUYzRrbFJJZGpTR3p6UmV4?=
 =?utf-8?B?Vmc0dS9KeVBmdDIxd3BxWEpYSEREdEFqTDV0bWRtWGZFV0xhVkxXandqcTZv?=
 =?utf-8?B?blkyMi9ORzJqclZxZk1UMnpINnRvY0ljMUV5VmgxeVZ6aWpBVVZ0YVFpR1cx?=
 =?utf-8?B?YThuNlFGLzhEc3E0aW44czNXM3dha25CNTBtaEtqdWFWdlpGYWdBaTZiaTJr?=
 =?utf-8?B?bldHZzJRZThyWHRnQURMTjZud1V3MXhleG9YdDBWcGpSSGhIUWx5dk56U0h4?=
 =?utf-8?B?ZkZqUGFqU3dldWpJN3NWMTd0UTNsdHo4SW9COTkrSTlRMlJhWVJBdkp5WGh1?=
 =?utf-8?B?RnFHaExZWlVCTUdhdG9tY0VVclE3NnR2bS9LcXJWZ04xb1NueVJlYS9INHBO?=
 =?utf-8?B?Z1FGVGpTNmEwNVB4SFBvbzUxeDVQMk1mRjJlTTIrQ2NLYkE5RjluNWhaNTlG?=
 =?utf-8?B?YlQwMkVXYzAyS0RWdFI1YlhIS2FDOTZoejIrMlQ2SFhIN3RZSFl0ME5VUWE4?=
 =?utf-8?B?bnlPS3pkN003MXBGWU0yVTBlLzE1cm1XK3IzRkdOVTd0SWdHcnpKaGFGUkp5?=
 =?utf-8?B?L1c1b3pkMFlOUWQ0cTFIdlVNcEkxVGo5SXVXQkZSVnNrR1BlYmU2YVpwSlNp?=
 =?utf-8?B?VE1BcVFKU3ZneHBpSVVxcCs0TXl3bkFOR211TzFSZGJxZFZkbzNjRmlhTy82?=
 =?utf-8?B?azNQTDJDWTNVRFFmRE5JTEY4MkNSMkVoVWVnUDNNeXE1NlExek5lckM3ejlG?=
 =?utf-8?B?VURSd2MvY0NXT1JKRkROa3Jza2ZDU0tWQ2NObFk0V09YcFBJazRaV2IxZldY?=
 =?utf-8?B?MnBlRDBJSkdkUHFqT3BEaWxRTkFDbHBFSjZtQlJRb2wrWGI3QWxhalg0bHpv?=
 =?utf-8?B?MXFYQXllRmovVEJXOE5QRzhEOXhoRk1TL05lSHBjWEpiTVQ0ekZYK0Zxajhw?=
 =?utf-8?B?T1ZrQjF1QXMvMFNBSmljZ3BvU0xOSWtsOC9DWEJNaEhPdHZmN2JKRThPTnNZ?=
 =?utf-8?B?SnEzYVdmWWp4VnhEZCtmdEJXalRIaVlUK0dLcWNrK2FVR1gxSCtlYkhjaVFz?=
 =?utf-8?B?dlV0UWxxNGQwUnV0ZDE0Zml0OE14MWc4Vnd1R0lmcnBxWU5ITHFXa2lIcUxZ?=
 =?utf-8?B?QVpLL1R3SGlGcWdTb0ZNUVpEU3Z3UkV3a3BRbWQrcVF3Umxlb1VlZ1NNZkNR?=
 =?utf-8?B?bjNJRGM1a0EwTjVsMEhaTkVQNWVMMTNaVm1xeTBsd3MxalI0VUFzekRQb1JF?=
 =?utf-8?B?WTJ2bVhLVDFVZllTTHhmNm5jbkFWT0k3VzlPeHdDWU1rVkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejRUUE13SWp5NVFuWEtScCtkdzhBRitYSDY3WnBmUnYxNmx1R3p5cjdjbXZt?=
 =?utf-8?B?VnVBbUp0eGdEbDVycUpjU05DbTRidkhYRmgrVm92QzIxQlMxYkdIN0pia1hQ?=
 =?utf-8?B?WXB3WEE3QjBJWWtvK2lQRmw4Nzc0dml5Ny9NTjlGeVJtOUhMWGovMmt5T1FC?=
 =?utf-8?B?SUxYNlFxSXJ0Nk55MGp4dXh4aWlKOTZKS2FMREFKazdzWVJTdG5SdnRqK0tr?=
 =?utf-8?B?WTNLVy9sdHQ2amFkVVZXZ0VJU2MrZ1NSY0xlTFFLNHM4WWQvWTZMRmt2K1lm?=
 =?utf-8?B?ZU1FVlVwZUxBd0lrYjJ5ZmNFNWRiM1B1TnppejROZ1B5a0tFRnNHTEE3dVJx?=
 =?utf-8?B?dXJtVnNVbFhydHV2eXRkdHlZcnNHQ2J4V21UUjN1RTB6NlUvdENTbzhCYkEy?=
 =?utf-8?B?KzR6UzE4ci9DZFJ1WGNSYXJkdnRlWmcrVWQ1Y1YwUnNld29zQi92NC90dEM1?=
 =?utf-8?B?TkgzOUlXNWpyMkdzWkVpb0I5ZzhrZ0xlRG9uUE1kUFF2VFBKTFMyNGczM054?=
 =?utf-8?B?cTBrbHR0R3orN2hlRkhWMlBOaGh3cXk1MkZhWGgweG95TkVNU2RaY0FmeWJL?=
 =?utf-8?B?UnJjeEZROXA2TlZMenk0Y0Q1T28xNno2V2RNM1FGeUNoak9KR1BBdzVDOTcv?=
 =?utf-8?B?NUliMGlPc2pLSUFEYUVjby9Ha3NrL2NicTZ0WHhFY25GUm1pb3h3a1pIVk52?=
 =?utf-8?B?dkpHMkVJRkJ1anJWRjhIRWFmeHUwV0Y3RjVONWFyTTluSU5uWUN0c3ZmYjhC?=
 =?utf-8?B?NHhQSGRMcjJRRjJxNmI3TzNiWG4vT3RnSnQ3U2RLZEdyN1drZkpmbXRzTnc5?=
 =?utf-8?B?MHl4UkJoSHRZNVVSa3AwNWFoanU2bjVIRHZOS2FZREcybThSMUhBUit1S1Zz?=
 =?utf-8?B?eWEwN016aUlnVE5xY2xDNUdZZEV5cWhwNEFMUDVCbHBKYWhubFhIZVJFMlZh?=
 =?utf-8?B?eWhKN2NrMHp4TWxzQWxZenkzTmRyd3VvVk9lc3dtWkVMTEJtalV5TUxlNmo3?=
 =?utf-8?B?TlZHY29KRUZGcy9veTladHpmczBqVjRhNklmallzaTFtOC9VYlZ6MHJ5bUFv?=
 =?utf-8?B?bmZ6S3ZHVmFPUDhYQUEwcG5IY1RtVUpIT2Q3WDBkazhCdVdMMHNKTVdWK2hu?=
 =?utf-8?B?OTkxZFFnU3AxUHRDSFRxV2s3Y3dXT1plUkJhQS8vWUo0S3NoSE1wZHZzQkVI?=
 =?utf-8?B?bXU3UDdjMm0xY3Rjb2o1Q3ZOalJuT1I2ajhkVncrREtsaHA2QVF0Syt5cWow?=
 =?utf-8?B?Vng4VGxJOGUzUTR0QjZMci9BUGpDcGRzWWVHSmI4M2ZoT0dXdTIyQWxpNENo?=
 =?utf-8?B?ZXVja1d4UTYxTzZQdnB6elpVQ0V4YmxjamRyYlN2R1F0Tm5kbDRJS09mcGg3?=
 =?utf-8?B?K2FVOVpGaXE5VUU3eEZMUzRhUXpzcXlGdEF2MlRaSWpDNU92YUszK3RrRjlF?=
 =?utf-8?B?QUpyWEpUNHh0K3BnNWRJZDF5dEpLWWpPbWV3ZEtGK0V2Z3lMWVgwRjcvbFVZ?=
 =?utf-8?B?RTFxQTZRdEx3UElvYUMxSmM3MU53TjBkTEJjRENENDlZVWlYS0EwUzd0L3gw?=
 =?utf-8?B?djcyTmRaWGs4V0wwdFMzTWFERG9oRzZnTVZaWE1JSWpLTkFHVXE1TzdNMVVi?=
 =?utf-8?B?T2FqYkZzNzVscTdFd0p3OW11RXNMMHRTSlVGQjc5QnNUcHZNeURlSXhWdXhL?=
 =?utf-8?B?Q2dUUHoxd0s2QlZEMjFzTVZVOGprSy9xR2FXaHN2Sk9vMC9oODdFaWxsa1VI?=
 =?utf-8?B?K0ZaNFROMnpxMjhKRDhoVHJBN1VBRitGSzJOVlh2QUo1MVZFOFdGMjk0Yjdk?=
 =?utf-8?B?V3BuOUYyU2lzYVYwWDR4ZkxPRkhvTjZvcXE0Z3Y4bXBuOXZjK3EyNzN0cElv?=
 =?utf-8?B?eHV5V2VMUUhQVGJSbGkzc2RMOHF6T0JoZFVlWjB6MHM2bk1kMTE0WWV5TEhT?=
 =?utf-8?B?YnlERWVieENWazlkQnJHU2YrVVFBMzBDM0tWMTc1bmdpS2ltZGl5M0hhTVFo?=
 =?utf-8?B?MGhiUDZ4aFNmK2ZCaUJkMzdGSWpJRTRTZ2pLVkM2eHVoUVI0NFQzelJOeEh4?=
 =?utf-8?B?TmhoNXlLZEZCUVk5S09mVFhadEtydzlxNDEzc0djSjFTaENuTGpyc082T3B4?=
 =?utf-8?B?TWp4NWRsdGNtK0hZWEhLems4SzVqZVE1Y0RLRG9oYkxicURqVU5VYlkyT2Fl?=
 =?utf-8?B?dmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b745eba-d763-460f-e977-08dcc84377c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 15:58:47.7284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ4AOn2+gUaSZG0uefDIJB3pWvr6dUVTn4ulKobjqKxzKjI8JXn96ZB+igJFUNBAIsKF2Q8yCCdkSXrCEKxFrwrm5LuXw5mvxY/RIyZqRRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8084

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEF1
Z3VzdCAyOSwgMjAyNCAxOjQ1IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBjbGs6
IHJlbmVzYXM6IHI5YTA4ZzA0NTogTWFyayB0aGUgd2F0Y2hkb2cgYW5kIGFsd2F5cy1vbiBQTSBk
b21haW5zIGFzIElSUQ0KPiBzYWZlDQo+IA0KPiBIaSBDbGF1ZGl1LA0KPiANCj4gT24gV2VkLCBB
dWcgMjgsIDIwMjQgYXQgNDowNuKAr1BNIENsYXVkaXUgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRl
dj4gd3JvdGU6DQo+ID4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhLnVqQGJw
LnJlbmVzYXMuY29tPg0KPiA+DQo+ID4gSWYgdGhlIHdhdGNoZG9nIGlzIHBhcnQgb2YgYSBkZWRp
Y2F0ZWQgcG93ZXIgZG9tYWluIChhcyBpdCBtYXkgYmUgb24NCj4gPiBSWi9HM1MpIHRoZSB3YXRj
aGRvZyBQTSBkb21haW4gbmVlZCB0byBiZSBwb3dlcmVkIG9uIGluIHRoZSB3YXRjaGRvZw0KPiA+
IHJlc3RhcnQgaGFuZGxlci4gQ3VycmVudGx5LCBvbmx5IHRoZSBjbG9ja3MgYXJlIGVuYWJsZWQg
aW4gdGhlDQo+ID4gd2F0Y2hkb2cgcmVzdGFydCBoYW5kbGVyLiBUbyBiZSBhYmxlIHRvIGFsc28g
cG93ZXIgb24gdGhlIFBNIGRvbWFpbiB3ZQ0KPiA+IG5lZWQgdG8gY2FsbCBwbV9ydW50aW1lX3Jl
c3VtZV9hbmRfZ2V0KCkgb24gdGhlIHdhdGNoZG9nIHJlc3RhcnQNCj4gPiBoYW5kbGVyLCBtYXJr
IHRoZSB3YXRjaGRvZyBkZXZpY2UgYXMgSVJRIHNhZmUgYW5kIHJlZ2lzdGVyIHRoZQ0KPiA+IHdh
dGNoZG9nIFBNIGRvbWFpbiB3aXRoIEdFTlBEX0ZMQUdfSVJRX1NBRkUuDQo+ID4NCj4gPiBSZWdp
c3RlciB3YXRjaGRvZyBQTSBkb21haW4gYXMgSVJRIHNhZmUuIEFsb25nIHdpdGggaXQgdGhlIGFs
d2F5cy1vbg0KPiA+IFBNIGRvbWFpbiAocGFyZW50IG9mIHRoZSB3YXRjaGRvZyBkb21haW4pIHdh
cyBtYXJrZWQgYXMgSVJRIHNhZmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4NCj4g
PiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gY2hhbmdlZCBwYXRjaCB0aXRsZTsgaXQgd2FzICJjbGs6
IHJlbmVzYXM6IHJ6ZzJsLWNwZzogTWFyaw0KPiA+ICAgd2F0Y2hkb2cgYW5kIGFsd2F5cy1vbiBQ
TSBkb21haW5zIGFzIElSUSBzYWZlIg0KPiANCj4gVGhhbmtzIGZvciB0aGUgdXBkYXRlIQ0KPiAN
Cj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9yZW5lc2FzL3I5YTA4ZzA0NS1jcGcuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDhnMDQ1LWNwZy5jDQo+ID4gQEAgLTI1OSw3ICsyNTks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJ6ZzJsX2NwZ19wbV9kb21haW5faW5pdF9kYXRhIHI5
YTA4ZzA0NV9wbV9kb21haW5zW10gPSB7DQo+ID4gICAgICAgICAvKiBLZWVwIGFsd2F5cy1vbiBk
b21haW4gb24gdGhlIGZpcnN0IHBvc2l0aW9uIGZvciBwcm9wZXIgZG9tYWlucyByZWdpc3RyYXRp
b24uICovDQo+ID4gICAgICAgICBERUZfUEQoImFsd2F5cy1vbiIsICAgICBSOUEwOEcwNDVfUERf
QUxXQVlTX09OLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgREVGX1JFR19D
T05GKDAsIDApLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VOUERfRkxB
R19BTFdBWVNfT04pLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VOUERf
RkxBR19BTFdBWVNfT04gfA0KPiA+ICsgR0VOUERfRkxBR19JUlFfU0FGRSksDQo+ID4gICAgICAg
ICBERUZfUEQoImdpYyIsICAgICAgICAgICBSOUEwOEcwNDVfUERfR0lDLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgREVGX1JFR19DT05GKENQR19CVVNfQUNQVV9NU1RPUCwg
QklUKDMpKSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFTlBEX0ZMQUdf
QUxXQVlTX09OKSwgQEAgLTI3MCw3DQo+ID4gKzI3MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cnpnMmxfY3BnX3BtX2RvbWFpbl9pbml0X2RhdGEgcjlhMDhnMDQ1X3BtX2RvbWFpbnNbXSA9IHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERFRl9SRUdfQ09ORihDUEdfQlVT
X1JFRzFfTVNUT1AsIEdFTk1BU0soMywgMCkpLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgR0VOUERfRkxBR19BTFdBWVNfT04pLA0KPiA+ICAgICAgICAgREVGX1BEKCJ3ZHQw
IiwgICAgICAgICAgUjlBMDhHMDQ1X1BEX1dEVDAsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBERUZfUkVHX0NPTkYoQ1BHX0JVU19SRUcwX01TVE9QLCBCSVQoMCkpLCAwKSwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERFRl9SRUdfQ09ORihDUEdfQlVT
X1JFRzBfTVNUT1AsIEJJVCgwKSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBHRU5QRF9GTEFHX0lSUV9TQUZFKSwNCj4gPiAgICAgICAgIERFRl9QRCgic2RoaTAiLCAgICAg
ICAgIFI5QTA4RzA0NV9QRF9TREhJMCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERFRl9SRUdfQ09ORihDUEdfQlVTX1BFUklfQ09NX01TVE9QLCBCSVQoMCkpLCAwKSwNCj4g
PiAgICAgICAgIERFRl9QRCgic2RoaTEiLCAgICAgICAgIFI5QTA4RzA0NV9QRF9TREhJMSwNCj4g
DQo+IENhbid0IHlvdSBqdXN0IGRvIHRoaXMgZm9yIGFsbCBkb21haW5zIChlLmcuIGluIHJ6ZzJs
X2NwZ19wZF9zZXR1cCgpKSwgaW5zdGVhZCBvZiBsaW1pdGluZyB0aGlzIHRvIHRoZQ0KPiB3ZHQw
IGFuZCBhbHdheXMtb24gZG9tYWlucz8NCg0KTm90IHN1cmUsIHRoYXQgd2lsbCBtYWtlIGFsbCBQ
TSBjYWxscyBmb3IgYWxsIGRvbWFpbnMgd2l0aCBpbnRlcnJ1cHQgZGlzYWJsZWQ/Pw0KDQpDaGVl
cnMsDQpCaWp1DQo=

