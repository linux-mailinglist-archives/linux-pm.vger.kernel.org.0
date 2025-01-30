Return-Path: <linux-pm+bounces-21122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E057A22BA4
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E86E3A864A
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC91B87ED;
	Thu, 30 Jan 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="UfMVHZ8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010053.outbound.protection.outlook.com [52.101.228.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078C2CAB;
	Thu, 30 Jan 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233213; cv=fail; b=spUVYoFzMtOqOlNlE+Xkk7Co6MGrsJxehqRSGpPw+c+12X5kAq9JhEday8CfZPOgPcQ+/RtPVHfYvx0r/Nz1eslpERSXbtb8QOCktjXhUJfly0IRn9ggvNPN/+WNT7tLYN4LLFwgSKxC/4m5Hmqxx+2qmb3CXmnBzlaiRZQ9tLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233213; c=relaxed/simple;
	bh=AdbcdzOVn7eC+C2nEV9p1NohUWSD4+Mp4XDnb7v7VUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fvaUWDkTR1U6e5SX+dXPhW4mrG47hGHRdjCqw8xrO9v35UPBLz8wsDaPExWOq6Gl+ErMnmN0GvLDuD5+UB9n9UBRjy10rvdNcNSzNVCuLpPKbyBRGUvYUqQOAjTnUCHVrG80a6RvZe4HnbpauyiDVZc6d4c2Ssz1/gjHsNijUiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=UfMVHZ8S; arc=fail smtp.client-ip=52.101.228.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf26skFOpMKhwYwXOugCB7WdWzU9Du2ASRuT4XBCwobiSroumeytrs6CwNl2enLiyuFcNs8EiyFV8Q4JdLM7Ed4FgebisppZk/0Wh/SypbveG1URy6IAzCaxd+X3ui/VDalc9rI24pY+NhXdEyXySyijyzLr9ZAIozDjo7ptaBpQ493pXpyOsRfxhK3nvyFkjbz29pZx2067mC1C6vVDQ2RNIezIQFDle+TWLkcQQX5Ztvov3JPMMfdp90DQ/iMF5lvEcXU0TPpZp/NHM4bPM9QNfCn3Yi8WmiiENwenB4BrcAfJKSSbLQQx3/j2OtY08EDOtJgkZEc3m/mGS7xvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdbcdzOVn7eC+C2nEV9p1NohUWSD4+Mp4XDnb7v7VUE=;
 b=tLw6oCjWateXb0F4tNcLMdvH7lJU3veMu8yhTEXCUTZ3wMgBmBio0MhlMcWCTKFeVjQvvBnXHxl2L88OVNaYPzjXZEKWTa8mjanoF/dIlBqhagzj0mzyQWqbmNdzea6+hCjQfn5ZLQ5TJVr9NdFhGB4KbrEhnrQZsE136h5pY60bYmJXt8ooC/lx055YbsAyIaUVG6taN6xaeZZXb8/QPq7BUF8tIKbToYBCx/mlhUMzQOmtHfKm+Zo3nw/CVzuD8g8Rx039zNQaDZb0rWs39teZfF+qF5GZROBuWOzOHo+p5rrN8SFeRbW3kVTbd/OjDL42CbkBSf21hhi5KJIn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdbcdzOVn7eC+C2nEV9p1NohUWSD4+Mp4XDnb7v7VUE=;
 b=UfMVHZ8S+V1o4khcLpAsy/CdtHq+WFWpUUWnd98AYGB3JJi9xy4S7v9sqTILftovUAgn6lNXdSolLQnAEACkgc/NGBuMl59whUPslsfLqHrgATDfgk1nr6hzGe0EIIlu4KLkexl7+YdEjRnyn5j32fOx2SIUlqeOx2h5oLlppNo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSZPR01MB9442.jpnprd01.prod.outlook.com (2603:1096:604:1d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 10:33:23 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 10:33:23 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>
CC: "rafael@kernel.org" <rafael@kernel.org>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
Thread-Topic: [PATCH 2/6] thermal: of: Export non-devres helper to
 register/unregister thermal zone
Thread-Index: AQHbcnKoO9zjk0UpA0OhU3WRTzMdGLMvCAmAgAAQfICAAAW5sA==
Date: Thu, 30 Jan 2025 10:33:23 +0000
Message-ID:
 <TY3PR01MB11346E087A4DFCC5BDCCB10B486E92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-3-claudiu.beznea.uj@bp.renesas.com>
 <Z5pkUNNvsWPjRQvy@mai.linaro.org>
 <65a16c3f-456e-40ec-91b0-afb57269ed46@tuxon.dev>
 <Z5tPR_tv7vWDkUI7@mai.linaro.org>
In-Reply-To: <Z5tPR_tv7vWDkUI7@mai.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSZPR01MB9442:EE_
x-ms-office365-filtering-correlation-id: e41c92f2-42cf-485f-d84d-08dd4119860d
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDUvTGxRMW9mTHAySjJPcGsyWnpNenRubmptTmt6RDJDSDkwdTMybkpZSEZZ?=
 =?utf-8?B?Nml4bHJ4Ty9ZMWhYTTd5R1M0aHVkNVNGcUVXL0FoeHpKTXlkVUQ1ZEY4bmlk?=
 =?utf-8?B?VVFDeWk5b2Y1YzhsNUNtSzNxaGRVSy9ZL2tNRDhieXdObUo3OTNMT0p4Y1Ji?=
 =?utf-8?B?RDZueDFMSGFQUnY1UGJjU3dxVTROYWcxc0VsNWUzWjJha1JIVUdEalFIVWpl?=
 =?utf-8?B?YUwwdXlwb2hhM25VSzR1ZVowTEFiUC9CQmdRYVhIKytFWGtzQlNnMDJUMFdO?=
 =?utf-8?B?UElteldPKzlPRDVJaW9ETXpNTEFpVEhkOS9IL01rTDJjV1hQNFZ5S2hnR2Er?=
 =?utf-8?B?UUdMZXFTa294TEVXcjEyblRaRFZVdDV2MmRuZmQwbHBhaXVPM1FZSnlmVlpX?=
 =?utf-8?B?TGJhenhzcXhtL2xoVWpxblBBZWZOelM0M1pLdGptbG43ZWUzZFp0Y0lNZ09l?=
 =?utf-8?B?eDJDYnMvQi91WDlZYXYyNTNsdTBnS2ZOUW13d2UrQlMwZkNWR25VR1ZuelUw?=
 =?utf-8?B?emFvbmN1TVlNaDMwbzBybjVqamx0cHBDWTA4RTdsYzBHMWNhZ3ZhMDVhY1JZ?=
 =?utf-8?B?YzZwbUhLa0dvc0RyY3VRSE55QlZQeWdKb3lBYXQxN3pYOVlHQUxMbThKd28r?=
 =?utf-8?B?VFd2U3JPWFRodHBxTGd6akpRRWRwWHRXZGRSOFVCbEwrblY2WXdUVy9iRVVP?=
 =?utf-8?B?Zy9HYzJua1N2ZGc1Zk92QktybmJiSG8vN2ZKK1dXelRpMjg2TXkrd0JYWmNz?=
 =?utf-8?B?anVqd2NrNjhhNDFnaWRwaEp3bWdsb0tLd0NYUWwwbFNWRWNPMXNPYTBEeWNP?=
 =?utf-8?B?eTVEdW9Ec043QUt6TTNJQm9sNGcwQWNPQXVnNUtWTFhmcHc1cWVkdUJKczlm?=
 =?utf-8?B?bjZTMEZ2Sm5JMDNTcGN3RlU4NTYyVGh0R3A2Nm1ORTZFOC96S0ZGTFhoM2d2?=
 =?utf-8?B?RkhWY0xBdTRYVnNvU1djc29xZnpQZlg1cEN5Z242VFJjazFtNVBoM3JtWitU?=
 =?utf-8?B?b29MS3J5V1F2NDhkSUpZL01RZUkzZ1hyTHNxZHpPUTNSQ21DeHRaeVhlc0xj?=
 =?utf-8?B?L1RIRkUzNEEvbUFkZis3ekRuc3VSMklWTVI0cjkrcXlzMU4wSjRXNE95MHRx?=
 =?utf-8?B?MjhKUHg1VlNhQkpIUHptMllSOVNiM1plTm03MytrSHFnM1p1Wnc2cjgvQ1VW?=
 =?utf-8?B?a3V1WjI0T3E3TDNWTDVsdHRNQnM4bnZaTElYcm53c2xuNlE5MjRKc0h5OU13?=
 =?utf-8?B?elRBOHZGTXBpSlN1M1p5bDRvbmZaOUVuSGNkOG5FMXFUczdYWnhNM3pxRy9t?=
 =?utf-8?B?a3hhSWt4NDJhVGYvREw0RS9xNm5QTloyM3ZYMGdLRE4rR1YzL202azBJOHhF?=
 =?utf-8?B?NjNidWVaNnJKNjdWYTMxdWU1M0RYNTFzQU41ajk5VUdiS25LWFRZYklrbUVn?=
 =?utf-8?B?WC95SUpBazJHYWZUWmJTV05vZlFDMXRDSEIvSGI2R2YzNkNiU3QxeHMrU1dM?=
 =?utf-8?B?c0xldUFXZVlNSjVKWWtBTHoxYi96N3Mvd25nZUR0WkVyOS9vR20xR1h3MnNM?=
 =?utf-8?B?TEI3b3Vpb3BocWoxY1c5Q0hReXc1M0hWZ080d0lOM1dGbnR4ME15V0plL2FB?=
 =?utf-8?B?V3RoTEM3bklQaHdDcldqR0lSNm9MSnpKc2Nmd3BXMDllZi91STZNTXhSR1M3?=
 =?utf-8?B?NFppcC9JZkw1czJsQzB5UnFGMHJXUHk0VXFPTXFyaE5CM0ZmbkxhQ250Qnlq?=
 =?utf-8?B?cFQwYTVTSW9KeEdpUEJ4eE1mYVZVYmh4bndyYnZ0SWNVRWQ4dDU0Vmh6QkpE?=
 =?utf-8?B?RVA0LzdXQTJPaDRQdFRqWnV0ZTlaNGxYeHozdG04T3k2eWs5K3YxbkxkTDBz?=
 =?utf-8?B?UysxUXE1VUVQVDdSdHZXclBPWXQ0Vm1QNEhUZnh6ekRPdmh0bjIva2VZR1gz?=
 =?utf-8?Q?GDObc3mhVEp1PQ0YzQCGZcubu9baqUh6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTU4NHprYXVvVUNWa1NsQVUwazI0VWpPWXNETlZ6dVVod0puUDMyVXZDaHpn?=
 =?utf-8?B?OXFCODQvcmtRRjgvQ0RiMXV6dG9ZamNoNWUyMXVrMFdWTnBsMEdBZEgwSWVp?=
 =?utf-8?B?RXdoYlROV1lYWFA4d3N4SzhWckRLa2VBN3Z6YkU0aHp3eDdyRHBUdXBCMGpK?=
 =?utf-8?B?OHZtdUV1c1RGUnFjeGJOTFJsMTFqY3JhTGlvcXltOStsNnNKeEtCK3JYdjQx?=
 =?utf-8?B?dVplS2lIcS9ETVBWbndqNFpCbC8yWUNhbllSUjFzZUhNOE1tQnBvSmtkTzFK?=
 =?utf-8?B?TVh6aTNueUhuaVlHWGcvUUd3aVBjcmNHTWkxUlpnb3J1eG41U2M5cUg5SE1q?=
 =?utf-8?B?MDQyZjdKMEF2K3lJeU50SlFvbDdyV25XendTK3l4cFFaenJmUmwxbGZGcUQ1?=
 =?utf-8?B?K3pNb0FrUDdCQjY2eGo3TVIyNnUxcHJMSzMvTGtDS2VBUStqMnlVVkhBUHcv?=
 =?utf-8?B?dllUZThMcGZKTm41cVFtbWRrWUNXTUx2YkI1Vm1QTmJNMU5lbmJsNXZVTGNE?=
 =?utf-8?B?eFBkSjh3cjlaNHlsaGZvWmVqZGN4MVU4TTFianRUU3VpWFNyTU1XbzluUHd6?=
 =?utf-8?B?OUszRzg5Y1l6c0R2LzZ4MXVSbTVFTlZURjBrK0RqS0M0cnhaWUU5Z0RpL0pz?=
 =?utf-8?B?NGVBaHlBUzg1SHlyaEZiZ1pzM2FEaXpRYlQrRFpubUdpR3BSL212R01sWnVD?=
 =?utf-8?B?TUY0VHVTUEo1SkEzWXhzYStlSW1YaDlOV2R5QUZoaDhGNFJJRERGZnJSeEc5?=
 =?utf-8?B?UXgzZ1VUcEFCUUJYejNaQ2xWMHJVQWxLdDdtL2pzSXdDQVFlMk15SjJRaGo3?=
 =?utf-8?B?a2d0cGRUVzkvVlVsUjZnR0w2SnBSci9MVzZmMGZvSWJhNlBuMjhPM0xMOWZN?=
 =?utf-8?B?bHJTUEdYeXhKS1lKdmtPaFJkODZ0WTZJc25zcVZHRm1sbldmam5VRHBTTjdz?=
 =?utf-8?B?NGVVOVMxVUk0USswWG5sKzhRcnBBZWlyaFZLalExZmVwWExRTk4zYlRodFl3?=
 =?utf-8?B?dmxmRVU5YStwbW12RDZxbVFJQ2ttVUpZR08yaVF1OURuMjh4M2NKLzZxZjk5?=
 =?utf-8?B?MDRCdkEzNVoxbWZjdkRwTmx6cUFwVTVTcGg3SnM2bUFMSkhjS0oveGpqaGhm?=
 =?utf-8?B?WFRyUGhiQUZuSVhLSXEzbW0xZWtybTVmd3RIdkxDOVNGQ0pXcWhUZUJndDl5?=
 =?utf-8?B?L2RoeU80NWRuaGNJaStOY1dsT1hhUUk0TTUrUW5oMkYxckZuV1JybGZIekFF?=
 =?utf-8?B?cGhiN1RvR2t4cytsZitRanBCTnVFblZJaVdYbm9NSnNBRVZLcTI0aGZVKzVl?=
 =?utf-8?B?cnAzK1ppUVA5M1E1VjNySndkbFlRcDZIOHJuVW9SMjBIRVh0QlBaVXEvbmRO?=
 =?utf-8?B?M3hsSXkweFJoc2pNZWVLZnU5bXBWcXVFOGVYU1lyV1o2R1F1SzJSTG9jbnBX?=
 =?utf-8?B?bXZHdzVWZUs3NEVhMG9JdlZra1ErRmo3M1pZazBsS20zWGlEOEZNVUp5V3pn?=
 =?utf-8?B?QSt6Qkx0RlRxRXh6cDFsSGJzVStpMDA2aytwTktFVytmSjUyb2E4UGV1emhN?=
 =?utf-8?B?YTNzcXZJOHZpRnRRTS9hcS9aQWJIb2Z6MjNnTzRqYW5jbDFqZ0ptSE1OdUtB?=
 =?utf-8?B?SnhUdVg5b3hSdUxrWnRPVW05ZEs1L3hhSHVCb29GUWpRT2JQVWNnTzJTTzNu?=
 =?utf-8?B?RGdPQWlzT3FBd0xEc091NWJQS1h2K1d5QU0xeXhZcWhzblhELzc5MHZRdkV0?=
 =?utf-8?B?ZDZob3R2cHFnelZDYjJyNmNBWGVZd1hNelNvK1J4VWFxb0ZXV3hIYUhmbGIx?=
 =?utf-8?B?d1FwNm9NZGdOZmFhWXVxQVYzM29GOTh2QjNlQWZ1SHFqalBwd2FPZXEzby96?=
 =?utf-8?B?S1JVMy9KL3pRWXp6aEFLN2J6STFFVjExRFZwMCtIOFdQbkxZQ0h5bTYvMGlJ?=
 =?utf-8?B?Z2Y1bmJ6RjhIMitIZXlLcHRmUUZ0ZGhETDRzOHQwbWpOSmlmUzMwL1d4Qjlm?=
 =?utf-8?B?bnBSSzNoUWJaMmRnNm9wSmNubGRNcFBoS0w0bWJoK200eVlCdG5uY25mNXFD?=
 =?utf-8?B?NFBjSWh3Vkw3dnNxNmR1cFM2OVh2eUIzNTJiYTlEb2l5bjh2V2RxRjNST1Nv?=
 =?utf-8?B?SzUxT1NlMEhZamFrZ3d3UDcvdVRmZktZRDgwcmZNYmNFZHVXVXgybGJNTzNj?=
 =?utf-8?B?L2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e41c92f2-42cf-485f-d84d-08dd4119860d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 10:33:23.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbDi9ykJAz0FRRL50Za4NUicw3EdDBenHaix7JSNV/wzC1cywctTaTJU9x8tCIe1wGdasgSBSv9XZUR6XD3cXkXNAPlwWqN1u9ycqcanE4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9442

SGkgRGFuaWVsIExlemNhbm8sIA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiAz
MCBKYW51YXJ5IDIwMjUgMTA6MDcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzZdIHRoZXJtYWw6
IG9mOiBFeHBvcnQgbm9uLWRldnJlcyBoZWxwZXIgdG8gcmVnaXN0ZXIvdW5yZWdpc3RlciB0aGVy
bWFsIHpvbmUNCj4gDQo+IE9uIFRodSwgSmFuIDMwLCAyMDI1IGF0IDExOjA4OjAzQU0gKzAyMDAs
IENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPiA+IEhpLCBEYW5pZWwsDQo+ID4NCj4gPiBPbiAyOS4w
MS4yMDI1IDE5OjI0LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4gPiA+IEhpIENsYXVkaXUsDQo+
ID4gPg0KPiA+ID4gT24gRnJpLCBKYW4gMDMsIDIwMjUgYXQgMDY6Mzg6MDFQTSArMDIwMCwgQ2xh
dWRpdSB3cm90ZToNCj4gPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEu
dWpAYnAucmVuZXNhcy5jb20+DQo+ID4gPj4NCj4gPiA+PiBPbiB0aGUgUmVuZXNhcyBSWi9HM1Mg
KGFuZCBvdGhlciBSZW5lc2FzIFNvQ3MsIGUuZy4sIFJaL0cye0wsIExDLA0KPiA+ID4+IFVMfSks
IGNsb2NrcyBhcmUgbWFuYWdlZCB0aHJvdWdoIFBNIGRvbWFpbnMuIFRoZXNlIFBNIGRvbWFpbnMs
DQo+ID4gPj4gcmVnaXN0ZXJlZCBvbiBiZWhhbGYgb2YgdGhlIGNsb2NrIGNvbnRyb2xsZXIgZHJp
dmVyLCBhcmUgY29uZmlndXJlZA0KPiA+ID4+IHdpdGggR0VOUERfRkxBR19QTV9DTEsuIEluIG1v
c3Qgb2YgdGhlIFJlbmVzYXMgZHJpdmVycyB1c2VkIGJ5IFJaDQo+ID4gPj4gU29DcywgdGhlIGNs
b2NrcyBhcmUgZW5hYmxlZC9kaXNhYmxlZCB1c2luZyBydW50aW1lIFBNIEFQSXMuDQo+ID4gPj4N
Cj4gPiA+PiBEdXJpbmcgcHJvYmUsIGRldmljZXMgYXJlIGF0dGFjaGVkIHRvIHRoZSBQTSBkb21h
aW4gY29udHJvbGxpbmcNCj4gPiA+PiB0aGVpciBjbG9ja3MuIFNpbWlsYXJseSwgZHVyaW5nIHJl
bW92YWwsIGRldmljZXMgYXJlIGRldGFjaGVkIGZyb20gdGhlIFBNIGRvbWFpbi4NCj4gPiA+Pg0K
PiA+ID4+IFRoZSBkZXRhY2htZW50IGNhbGwgc3RhY2sgaXMgYXMgZm9sbG93czoNCj4gPiA+Pg0K
PiA+ID4+IGRldmljZV9kcml2ZXJfZGV0YWNoKCkgLT4NCj4gPiA+PiAgIGRldmljZV9yZWxlYXNl
X2RyaXZlcl9pbnRlcm5hbCgpIC0+DQo+ID4gPj4gICAgIF9fZGV2aWNlX3JlbGVhc2VfZHJpdmVy
KCkgLT4NCj4gPiA+PiAgICAgICBkZXZpY2VfcmVtb3ZlKCkgLT4NCj4gPiA+PiAgICAgICAgIHBs
YXRmb3JtX3JlbW92ZSgpIC0+DQo+ID4gPj4gCSAgZGV2X3BtX2RvbWFpbl9kZXRhY2goKQ0KPiA+
ID4+DQo+ID4gPj4gSW4gdGhlIHVwY29taW5nIFJlbmVzYXMgUlovRzNTIHRoZXJtYWwgZHJpdmVy
LCB0aGUgc3RydWN0DQo+ID4gPj4gdGhlcm1hbF96b25lX2RldmljZV9vcHM6OmNoYW5nZV9tb2Rl
IEFQSSBpcyBpbXBsZW1lbnRlZCB0bw0KPiA+ID4+IHN0YXJ0L3N0b3AgdGhlIHRoZXJtYWwgc2Vu
c29yIHVuaXQuIFJlZ2lzdGVyIHNldHRpbmdzIGFyZSB1cGRhdGVkDQo+ID4gPj4gd2l0aGluIHRo
ZSBjaGFuZ2VfbW9kZSBBUEkuDQo+ID4gPj4NCj4gPiA+PiBJbiBjYXNlIGRldnJlcyBoZWxwZXJz
IGFyZSB1c2VkIGZvciB0aGVybWFsIHpvbmUNCj4gPiA+PiByZWdpc3Rlci91bnJlZ2lzdGVyIHRo
ZSBzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZV9vcHM6OmNoYW5nZV9tb2RlDQo+ID4gPj4gQVBJ
IGlzIGludm9rZWQgd2hlbiB0aGUgZHJpdmVyIGlzIHVuYm91bmQuIFRoZSBpZGVudGlmaWVkIGNh
bGwgc3RhY2sgaXMgYXMgZm9sbG93czoNCj4gPiA+Pg0KPiA+ID4+IGRldmljZV9kcml2ZXJfZGV0
YWNoKCkgLT4NCj4gPiA+PiAgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCgpIC0+DQo+
ID4gPj4gICAgIGRldmljZV91bmJpbmRfY2xlYW51cCgpIC0+DQo+ID4gPj4gICAgICAgZGV2cmVz
X3JlbGVhc2VfYWxsKCkgLT4NCj4gPiA+PiAgICAgICAgIGRldm1fdGhlcm1hbF9vZl96b25lX3Jl
bGVhc2UoKSAtPg0KPiA+ID4+IAkgIHRoZXJtYWxfem9uZV9kZXZpY2VfZGlzYWJsZSgpIC0+DQo+
ID4gPj4gCSAgICB0aGVybWFsX3pvbmVfZGV2aWNlX3NldF9tb2RlKCkgLT4NCj4gPiA+PiAJICAg
ICAgcnpnM3NfdGhlcm1hbF9jaGFuZ2VfbW9kZSgpDQo+ID4gPj4NCj4gPiA+PiBUaGUgZGV2aWNl
X3VuYmluZF9jbGVhbnVwKCkgZnVuY3Rpb24gaXMgY2FsbGVkIGFmdGVyIHRoZSB0aGVybWFsDQo+
ID4gPj4gZGV2aWNlIGlzIGRldGFjaGVkIGZyb20gdGhlIFBNIGRvbWFpbiAodmlhIGRldl9wbV9k
b21haW5fZGV0YWNoKCkpLg0KPiA+ID4+DQo+ID4gPj4gVGhlIHJ6ZzNzX3RoZXJtYWxfY2hhbmdl
X21vZGUoKSBpbXBsZW1lbnRhdGlvbiBjYWxscw0KPiA+ID4+IHBtX3J1bnRpbWVfcmVzdW1lX2Fu
ZF9nZXQoKS9wbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVuZCgpDQo+ID4gPj4gYmVmb3JlL2FmdGVy
IGFjY2Vzc2luZyB0aGUgcmVnaXN0ZXJzLiBIb3dldmVyLCBkdXJpbmcgdGhlIHVuYmluZA0KPiA+
ID4+IHNjZW5hcmlvLCB0aGUNCj4gPiA+PiBkZXZtX3RoZXJtYWxfb2Zfem9uZV9yZWxlYXNlKCkg
aXMgaW52b2tlZCBhZnRlciBkZXZfcG1fZG9tYWluX2RldGFjaCgpLg0KPiA+ID4+IENvbnNlcXVl
bnRseSwgdGhlIGNsb2NrcyBhcmUgbm90IGVuYWJsZWQsIGFzIHRoZSBkZXZpY2UgaXMgcmVtb3Zl
ZA0KPiA+ID4+IGZyb20gdGhlIFBNIGRvbWFpbiBhdCB0aGlzIHRpbWUsIGxlYWRpbmcgdG8gYW4g
QXN5bmNocm9ub3VzIFNFcnJvciBJbnRlcnJ1cHQuDQo+ID4gPj4gVGhlIHN5c3RlbSBjYW5ub3Qg
YmUgdXNlZCBhZnRlciB0aGlzLg0KPiA+ID4NCj4gPiA+IEkndmUgYmVlbiB0aHJvdWdoIHRoZSBk
cml2ZXIgYmVmb3JlIHJlc3BvbmRpbmcgdG8gdGhpcyBjaGFuZ2UuIFdoYXQNCj4gPiA+IGlzIHRo
ZSBiZW5lZml0IG9mIHBvd2VyaW5nIGRvd24gLyB1cCAob3IgY2xvY2sgb2ZmIC8gb24pIHRoZSB0
aGVybWFsDQo+ID4gPiBzZW5zb3Igd2hlbiByZWFkaW5nIHRoZSB0ZW1wZXJhdHVyZSA/DQo+ID4g
Pg0KPiA+ID4gSSBjYW4gdW5kZXJzdGFuZCBmb3IgZGlzYWJsZSAvIGVuYWJsZSBidXQgSSBkb24n
dCBnZXQgZm9yIHRoZQ0KPiA+ID4gY2xhc3NpYyB1c2FnZSB3aGVyZSBhIGdvdmVybm9yIHdpbGwg
YmUgcmVhZGluZyB0aGUgdGVtcGVyYXR1cmUgcmVndWxhcmx5Lg0KPiA+DQo+ID4gSSB0cmllZCB0
byBiZSBhcyBwb3dlciBzYXZpbmcgYXMgcG9zc2libGUgYm90aCBhdCBydW50aW1lIGFuZCBhZnRl
cg0KPiA+IHRoZSBJUCBpcyBub3QgdXNlZCBhbnltb3JlIGFzIHRoZSBIVyBtYW51YWwgZG9lc24n
dCBtZW50aW9uZWQgYW55dGhpbmcNCj4gPiBhYm91dCBhY2N1cmFjeSBvciBpbXBsaWNhdGlvbnMg
b2YgZGlzYWJsaW5nIHRoZSBJUCBjbG9jayBhdCBydW50aW1lLg0KPiA+IFdlIHVzZSBzaW1pbGFy
IGFwcHJvYWNoIChvZiBkaXNhYmxpbmcgY2xvY2tzIGF0IHJ1bnRpbWUpIGZvciBvdGhlciBJUHMN
Cj4gPiBpbiB0aGUgUlovRzNTIFNvQyBhcyB3ZWxsLg0KPiA+DQo+ID4gPg0KPiA+ID4gV291bGQg
dGhlIElQIG5lZWQgc29tZSBjeWNsZXMgdG8gY2FwdHVyZSB0aGUgdGVtcGVyYXR1cmUgYWNjdXJh
dGVseQ0KPiA+ID4gYWZ0ZXIgdGhlIGNsb2NrIGlzIGVuYWJsZWQgPw0KPiA+DQo+ID4gVGhlcmUg
aXMgbm90aGluZyBhYm91dCB0aGlzIG1lbnRpb25lZCBhYm91dCB0aGlzIGluIHRoZSBIVyBtYW51
YWwgb2YNCj4gPiB0aGUgUlovRzNTIFNvQy4gVGhlIG9ubHkgcG9pbnRzIG1lbnRpb25lZCBhcmUg
YXMgZGVzY3JpYmVkIGluIHRoZSBkcml2ZXIgY29kZToNCj4gPiAtIHdhaXQgYXQgbGVhc3QgM3Vz
IGFmdGVyIGVhY2ggSUlPIGNoYW5uZWwgcmVhZA0KPiA+IC0gd2FpdCBhdCBsZWFzdCAzMHVzIGFm
dGVyIGVuYWJsaW5nIHRoZSBzZW5zb3INCj4gPiAtIHdhaXQgYXQgbGVhc3QgNTB1cyBhZnRlciBz
ZXR0aW5nIE9FIGJpdCBpbiBUU1VfU00NCj4gPg0KPiA+IEZvciB0aGlzIEkgY2hvc2UgdG8gaGF2
ZSBpdCBpbXBsZW1lbnRlZCBhcyBwcm9wb3NlZC4NCj4gDQo+IElNTywgZGlzYWJsaW5nL2VuYWJs
aW5nIHRoZSBjbG9jayBiZXR3ZWVuIHR3byByZWFkcyB0aHJvdWdoIHRoZSBwbSBydW50aW1lIG1h
eSBub3QgYmUgYSBnb29kIHRoaW5nLA0KPiBlc3BlY2lhbGx5IGlmIHRoZSBzeXN0ZW0gZW50ZXJz
IGEgdGhlcm1hbCBzaXR1YXRpb24gd2hlcmUgaXQgaGFzIHRvIG1pdGlnYXRlLg0KDQpKdXN0IGEg
cXVlc3Rpb24sIFlvdSBtZWFuIHRvIGF2b2lkIGRldmljZSBkZXN0cnVjdGlvbiBkdWUgdG8gaGln
aCB0ZW1wZXJhdHVyZT8/IEFzc3VtaW5nIGRpc2FibGluZyB0aGUgY2xrIGhhcHBlbnMNCndoZW4g
dGhlIHRlbXAgcmVhY2hlcyB0aGUgYm91bmRhcnkgYW5kIHJlLWVuYWJsaW5nIG9mIHRoZSBjbGsg
YWZ0ZXIgYSB0aW1lKHdoaWNoIGludm9sdmVzIG1vbml0b3JpbmcgdGhlIENMSyBPTg0KYml0IGFm
dGVyIGVuYWJsaW5nIGl0LCBvciBhIHJ1biB0aW1lIGVuYWJsZSBmYWlsdXJlIGhhcHBlbnMpLCB3
aGVyZSBpdCBleGNlZWRzIHRoZSB0aHJlc2hvbGQ/Pw0KDQpDaGVlcnMsDQpCaWp1DQoNCg==

