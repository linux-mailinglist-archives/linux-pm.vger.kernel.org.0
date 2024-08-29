Return-Path: <linux-pm+bounces-13096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B604963888
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38E2856F9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6522EF4;
	Thu, 29 Aug 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E/MrkNaA"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110904F20C;
	Thu, 29 Aug 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900577; cv=fail; b=qCC/vDWs+A6pHsw8qR/L7EAZfJuOzlgzgBSpPiEFuBq4CHL0MAKxfeANm0FF3yhikrv/nM0MDfkmKqwetaJpkO7o9d8BEAr8SS3c/fBLypjSSHYF2lHtiXfNuLVmB9Y64Nuu2j8smnifdTEvU0nZozP4vzrQC+lwg0XjmSR6Cww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900577; c=relaxed/simple;
	bh=6hB/7CMjgiKm6TqaROXSR6B2GFXH4xm//52zVrcLbxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euh3lOmUMpAK8th4onV2S5AnZbfTuTf19Du1yn7VFULaT0A/Gvok/jmS2LFJIoCjKzilxXFjpa8vz5sNkJlwHuGVcIYJD7JjdmHspYH2bK4a0YU7FzaJA+VWZjpXHkhN/TeppgR0n2fJaxH/+yT75b8h83RMej2DvxTVZLCY52M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E/MrkNaA; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqAazXh5v3aOg4mFhtOX03mZLNIbfVboLFldwnvj+hMFtwDUAB5wfpZ9hcq2aG2j5DiKrXggNq+Gw3CPSKcVTkR7zqCKcP2JeyoKonlxYzGFPCKNI7LuxYRCQDbLYWpFUEwXl3xmifz4VcXiY8xOIU6ArXp0L5faKlIHTT8gJc3GB0BTkcf8XQ8AHU9uVXc2eBgUy0PQTAYYNZ1GzuhE735DIGwTTb8PdyakkSdJM7PKEyRzoxRtW5wDDjseBJu6cHGRgljXUN2f+5yK6ONSf+IU4cz4C2l72tpdVV/G7tbFfge6TqmMPkQS1a9+AOaaaByarwCZFPFOtvUvKv26Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hB/7CMjgiKm6TqaROXSR6B2GFXH4xm//52zVrcLbxQ=;
 b=Ds1Egy75DZJgWF5mebqK1iMM+5b5YQzsJeQj+V+bgLPV0TlL05ZyuWw8EhHYWFe6heIYNpF5nDIEA5E09/ZG8YQ7+ek/vgmgfAeSqSooiNbc6YXDh2GQ8WIPut8swoEZZ6vbZYNIofiXTtkU4CK5RGhnYeROb8Pw4NGYX17x5Xy7lS4hslFWVchpLGi8oj8mHLBV9sW9VXFmqvJiJD/+ppHXV/UAFngCcy7deyzYfEz/COtXuURRbRD0sQH7FD1JAlzj0Kre/lR1UmtlgCSG2YUUE+Qe0txCXxjRKGEzXlusWFixF3J7v30qrgxjJaKk7tPP8MseLLyGDNXLGBsQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hB/7CMjgiKm6TqaROXSR6B2GFXH4xm//52zVrcLbxQ=;
 b=E/MrkNaAzQUInQbAtWKaVyWlDtvsu3GU4Ee1RsuwkovntouVEIxbWAT08q30UV+ZsiIBJBFwFACji+68XEkItw7mognQFymnryYpd40afHoMZOuuBPGyajkOepbbW8Gh/m2O+CzoncKPzO1cuyD9j66pdKhJzlERl2TzvV1GcY2F/09VNr1kak4o7j0H2rXpr8ns1ve6gX1Gm8kHxfI+DbUU+Ir6isiq3cez/rOGAvTLPVbCEzjiuNZbrBvi2i0MpVJvViaCE8TVk4w3nfxs2Ezu2ou+dG6Ql0u8sADLrY8mPc/7HIJFPT6j+BDalWOcOznCKfmCFyYNXeQ7UHl8QA==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6942.apcprd06.prod.outlook.com (2603:1096:820:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 03:02:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8c74:6703:81f7:9535%7]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 03:02:49 +0000
From: =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li
	<tiny.windzz@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit
 Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Thomas Gleixner <tglx@linutronix.de>, Krzysztof
 Kozlowski <krzk@kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjUgMDIvMjJdIHRoZXJtYWwvZHJpdmVycy9zdW44?=
 =?utf-8?B?aTogY29udmVydCB0byB1c2UgZGV2bV9yZXF1ZXN0Kl9pcnFfcHJvYmUoKQ==?=
Thread-Topic: [PATCH v5 02/22] thermal/drivers/sun8i: convert to use
 devm_request*_irq_probe()
Thread-Index: AQHZu7hKsZcuya/pGU6QxQ2g5PTaDa/ECWiAgnv99oA=
Date: Thu, 29 Aug 2024 03:02:49 +0000
Message-ID:
 <SEZPR06MB52693162580323BC8052723CE8962@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230721094641.77189-1-frank.li@vivo.com>
 <20230721094641.77189-2-frank.li@vivo.com>
 <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0iB5arngPxxduafyZ+hbxqTRLXm_5iwNoEcQcqVyCdCYw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|KL1PR06MB6942:EE_
x-ms-office365-filtering-correlation-id: c6feb0a5-974c-49ec-d93d-08dcc7d710cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3BtQW5vSE9XUVc2RUttUzh0ZXd1c1RhQkgyQkZLSVNFVzlhdjVKakczUHFp?=
 =?utf-8?B?VWJBbmJ6SXlDRTB2TUVyTFlDS0t2R2hZaFpvTG56RUI2TGtjM1U4SnVFbUE3?=
 =?utf-8?B?RW9HZDVIbTNzMm95SUkwa3pub1U5Mm8vSG11WUs1QWdlMzNxb2RMRXh5WHpn?=
 =?utf-8?B?Q1pMTmZGenNXMlBTTnVlRmZiMGhwN2llOFBiSHBMS3AwdWNzTjR6b2d0aFJ5?=
 =?utf-8?B?QkFSQVlyM1A5ekNPU24vV29lazdDYkdJU1h4OUhwdUk4aUZianpuRE81RFFO?=
 =?utf-8?B?QTBicVJmUWFMVVJMcEo4NXFMc1F1b29sc1ptbll3dnpRWEtPYWxKV2lyUGZa?=
 =?utf-8?B?T0tYUkFVcnFCVlUraTNiRkd5WGdDbHdENzU1cGw2eUlWRkpzcDU5cWV2MlRm?=
 =?utf-8?B?dkxpa2ZHUFFIOXBISytoamtKY1NsamVTQTZsU01OVWJDUnNCRVY0dXB2WE43?=
 =?utf-8?B?alVuWUZEYkRyRzdvOHp5QTF4dzY5WENWWjI3MFdpRytYR0dkRkFTWEorTjRK?=
 =?utf-8?B?RWRVaUp5YXNjM1RCdk9PUERLc1BkWDdqNU1UQ2lRRVZZeCsrTUdWTzVuQ0cz?=
 =?utf-8?B?UlVUTDBTSHg5OWtvcklwbDJCM09aYkV5MCtBeVdYSmJ1a3hFdUxHR1lVVXgr?=
 =?utf-8?B?YnNGMGNpVmNLTDFOUVhVUFRidFcxdnFkSTZJN0dDVmtUUWkvdU41ZVcxa0tK?=
 =?utf-8?B?bHVqTVpWYWhRNklQbmExWnlweDI5TW9xMEVjSHA2L0dtL2RBcmZQQXlwTW00?=
 =?utf-8?B?SkNUMVd6U2I5bG5mRFU2ZEs5ZUQ0dENPQ0JJenpFK1Y4Z0lnOGQ2MU1hdVVP?=
 =?utf-8?B?Qmd0Y0c4OXAyZk96MXZPL3hWT3N1MnRVSFlMV2VCL1kvY1dVekhxYTlDRFI4?=
 =?utf-8?B?Yng5Nklkczd6Qmwza3BuR211VnFYcjVDeW4wR21pbnNweFpNWHZGaHdDSmpm?=
 =?utf-8?B?Y2YrWGNMOE10aHY3Qkt6SVpUaUxEdXNUWG8zUzFpSG9TaWZ4SVp1aWlSSVYr?=
 =?utf-8?B?SkQzMXpEK0lMYmpVM2xIR1FxWTRRZGdLQUR5RG1JYmNrMWUxZnN1WWVFayt4?=
 =?utf-8?B?aG01MnJBMW9ENUdPOGp6RG9ualFKUGNRR0NuZEx6MU5nT0hraFcrbERYcG5T?=
 =?utf-8?B?K3F2azJmekx2dUNUNFQyRDZzd1dnUzZ3V2RDZlEvODBNWnZTbUdLamdWb1Z4?=
 =?utf-8?B?dTRPYUZwWDhXaWN5d0pYWHI2WFRPdm16L242dVMyUkhxcnV2Z29scE9EUjNZ?=
 =?utf-8?B?ZTVyelpURDdLWkRWQVpwWlBhRHhyMjBmeER2ZlR5TGplQWNLWkxkcTJXRCt4?=
 =?utf-8?B?UFYrR3MxSDcrbUF1aUhpUlRYSjQvSW5OSTdZTVZybkloOHNPQ2JIczQxdVBS?=
 =?utf-8?B?MmViWDNMWVYyYjZFQ1RUMzY2cm5mVkxuWnQrWEFHdjZLYWoxTlF4VjJKOFBt?=
 =?utf-8?B?b2RBeE84MFExY1Z2V2drT1FUUzQweEpobldVZ215cjB3UVBiSXM5ZTU4OUh2?=
 =?utf-8?B?QkVNc29WSzdwSWJkRnp1Rys2TytUVDd2MDVhbGpVYlJlcU9WNCtSd29iOTZD?=
 =?utf-8?B?a3NpRTFDcExjeEMxZzl5bTMveHBjNEdObjdENjM5RG5ISWdxZFl6SFEwWmli?=
 =?utf-8?B?TmhmTmc1MXJSbUUyUU9vYWpTVkRqb1c4RFU0cy81NU1VOGtRVnhvNENJVGNC?=
 =?utf-8?B?S1N0OGZscnA2d0w3UDkzbktBYmRvMVhrUGIzdlBYU2xld0xxTTZ6OXRBVlRV?=
 =?utf-8?B?RGFueDdyWVlDbG1ESjNaeTA4WHRmR2hWZjVJMW1vR2w3cDdqUTJSU0ttb3lH?=
 =?utf-8?B?U2xkUE12RkN4dzFpQmM1WU1FK1lyR1dSRXFQYm0wUXprQzFOellSU21nV1Fy?=
 =?utf-8?B?N2pLRzZlb01Uak9kR2dWQ3MwWThMLzlJRnJhTFk3eDZ3eHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TysrRVBhdXdLNHYzanBkSXduZGJUaDVEVjZWOGMyVTVaZUZzWUZGdUl3U2dW?=
 =?utf-8?B?VTRlUmU4RnkxTnJGQzhhNk5nTUpIZE42NE1EYjBIR21LK3NGakdmL0lxMzVt?=
 =?utf-8?B?Rmtvcm4xam1KbGZwNS8rQVZpZTRWOXpyU0pMN0t2MGRSanNsMGNUeEV2bTc2?=
 =?utf-8?B?eW5ZNXFOWVRVcXkxOGJibmhqblFJc0N1emhXZWNlUTZrVTY5eUFlQ2ZSdVpz?=
 =?utf-8?B?NmRPWnVmcFJFaFFaUnNNbDdGd0NXUzZRUTZIdkI5dmlsZ0ZKMkFML0w0WkZr?=
 =?utf-8?B?UUZpcEdXQWtKQmg4Z3lhdzlnTVFpaEpNbmllcW5DMEI2NHNJRENOaXdLNHpy?=
 =?utf-8?B?NmRheDV1MVhxMkdyT0NTR0EyeHJCT2VIWXlCcTRLRzgwMU5pMStDek9NbEQy?=
 =?utf-8?B?aFpUbFl0bVJZdjEyZWU1UlltOW9jdU4wNnJiVyszZkI4cE1EZXNFV1NyRUZi?=
 =?utf-8?B?dmQzVmM5VzhvMGtqc0ZkZnVLZEpiWGhBRXdWYTcrbm1uc3VHUVhpY2xXbjBS?=
 =?utf-8?B?OWtNeHFNeHhVT2RPYlhDVjh0MU1KcmtUNkhBWkhjTkFJVmc0R3h5NG5Ja1pk?=
 =?utf-8?B?a0dMVlFFTDZuUk1vWTJheEZaRy9IV24xUDQvNyt4VGREZ0MvSjl5ZG1ObCtn?=
 =?utf-8?B?MEY1K2lpc2hvN1VuUEZhNHNsN095QWtKV0J4RDZMdkZnRkJsNHNxN2pJREsr?=
 =?utf-8?B?VVcyZXEzM0tnMkFwWFBwOExwbXB3ODN1aElYNmV1ajJEMTVLUVQxZGFwZHVY?=
 =?utf-8?B?UFNqaTNLQUxXc21iaHRPb0U3enp4UjFCaEVBWjBsVVhlMXpZTWNDcWJpU3Bm?=
 =?utf-8?B?YzErNkt2azE3TEZOb3p1V3VNRTU5TUpBZnBlZnNEdjhidXE2UG9lL3NwUEZv?=
 =?utf-8?B?YURpMnp3aHR4VWd0aWdrUzl2MmhBRkErWHd5OHNzNysvUXhGSXhOUEs0aFl2?=
 =?utf-8?B?cDQxMDZ3V0FUR1ZVUzJDMnArV3FqZWZqOWs4My9mMmRwRGd1cFhMMzV2c0JQ?=
 =?utf-8?B?c0twVDlJc0RKTk82cGpzenNXcm12c3RIcDM2UThVOWV5V29KUi96bXBsbGY1?=
 =?utf-8?B?UjZPR2hyNVI3d1FnQ2dQb3Q5VnhiU1k1c2hFVzlST01YV1o3bWlFSWkramtG?=
 =?utf-8?B?WElHdk0wN1MzN1BrM3ZXOWw2UmkvWFFxSWlLUnZlZFByYmhPTytsbmh3Vmtt?=
 =?utf-8?B?T0t0ZEY3a2l1d3RteFRpMCs4RENCcUxNbnlWNFNrMUpMYTdVSzNETW1BanFu?=
 =?utf-8?B?K25ZNXAraURlQWlIRWRDVlpNanlURHFoTkxJTkg2Smp0NXBPNW1zaDJBaCt3?=
 =?utf-8?B?YVRKVmhkS2VyakJpVnNkYlJXaGdrK1phYjFhcVhJQU40RlQvUnBwNmJuV21K?=
 =?utf-8?B?NGhPbzlmbHlrTG1qRnplTXdtdmc0anhKUHR4cDlaOUN6dVV6YTBQRjVaMHJl?=
 =?utf-8?B?QnRFakhuRjhzQUg0cDVDL25WY2xsWktMQ0FhN2hjVytQSWx5VjB1RnMwS2k0?=
 =?utf-8?B?Q29aWkMzdEJUYTRsdzNURXQ5RnorM0JPUitxcFJVcis2NkF0RWRweW5sNEFn?=
 =?utf-8?B?UEN6QzNZQWlYUkYrVGFrYnNIbjI1SW5zSnBuSXFBVjJzNU51Y1NOVjZkc29K?=
 =?utf-8?B?SE1wWm9RL2xhaTErbk5LcU5KTWFRcGVSOTVuOU8rSzIvZ05GUTNDZGl2SzJ0?=
 =?utf-8?B?SHo0L09pVmNZdXlFL2ZYSFNjczdDbkJqVmY4Sk8ralYzSjM2OVlDeXRhT3d6?=
 =?utf-8?B?ZU9kclBVajBsY0cvZDZUL1AzV0p4L0VzcFJxYzZsSFRKQVRQZll3dnVxcWpH?=
 =?utf-8?B?RjlKMGVTb1FXVS95R3J2Q2V4bk56L3pzMzNuZk9iSmg5QkRQU3p3SVF5RW54?=
 =?utf-8?B?THU0QmtKTGNqVVplRFE5NXE5RE1RWnJDVENCOG8yZk5aakk2cjdvSjl2cXVX?=
 =?utf-8?B?cndqd0ZWT2NnWGJ4VzdiWUFON3AyZFFheWpQN1E2bzk3dmFYeU4yOHhUQisr?=
 =?utf-8?B?bUFQVVVXWGhXb3YvMUY2U2oyL3dHbVkzQ2VpTHZSU09wSk15dE9wNmZMb1V0?=
 =?utf-8?B?OTA5dmVKTllPdVB2YzhlSEkxaWhDOWc2aU11d21LTStvQ2prR0daamdiQjlq?=
 =?utf-8?Q?k5Po=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6feb0a5-974c-49ec-d93d-08dcc7d710cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 03:02:49.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDIx37bR2e0PInGToWqAXrJFldlYPMohbK11FiiyodNZNER7CPuR52AlZuS8D1JsrbMQBOHiapeOUw3Rhr5Zkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6942

SGkgUmFmYWVsLA0KDQo+IEl0IGlzIG5vdCBjbGVhciB0byBtZSB3aGF0IHRoZSBwdXJwb3NlIG9m
IHNlbmRpbmcgdGhlc2UgcGF0Y2hlcyBpcy4NCj4gDQo+IEJlY2F1c2UgdGhlIGRldm1fcmVxdWVz
dF90aHJlYWRlZF9pcnFfcHJvYmUoKSBkZWZpbml0aW9uIGlzIG5vdCB0aGVyZQ0KPiBpbiB0aGUg
Y3VycmVudCAtcmMga2VybmVscyBBRkFJQ1MsIGl0IGxvb2tzIGxpa2UgdGhleSBhcmUgc2VudCBp
bg0KPiBvcmRlciB0byBjb2xsZWN0IHRhZ3MgZnJvbSBwZW9wbGUuICBJZiBzbywgdGhlcmUgc2hv
dWxkIGJlIGEgY292ZXINCj4gbGV0dGVyIG1ha2luZyB0aGF0IGNsZWFyLg0KPiANCj4gQXMgaXQg
c3RhbmRzLCBpdCBpcyBhbHNvIHVuY2xlYXIgaG93IHlvdSB3YW50IHRoZW0gdG8gYmUgbWVyZ2Vk
Lg0KPiANCj4gTW9yZW92ZXIsIHNlbmRpbmcgdGhlIHNlcmllcyB3aXRob3V0IHBhdGNoIFswMS8y
Ml0gdG8gbGludXgtcG0gaGFzIG5vdA0KPiBiZWVuIGhlbHBmdWwuDQoNCkNvdWxkIHlvdSBwbGVh
c2UgbWVyZ2UgdGhlIGVudGlyZSBzZXJpZXMgaW50byB0aGUgcG0gYnJhbmNoPyANCkFsc28sIGRv
IEkgbmVlZCB0byBzZW5kIGEgbmV3IHZlcnNpb24/DQoNCk1CUiwNCllhbmd0YW8NCg==

