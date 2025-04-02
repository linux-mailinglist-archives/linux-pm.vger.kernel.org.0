Return-Path: <linux-pm+bounces-24731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CAAA795CF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1354C188B0CF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482E1E5B81;
	Wed,  2 Apr 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eALvsArq"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010040.outbound.protection.outlook.com [52.101.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04217C21C;
	Wed,  2 Apr 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621775; cv=fail; b=CskA2AWJVGHT3G3RAT7+QlhwznPpHEc9ZXIYaYsuMOvGO7Ez+tNe8dDI9sTccCjAl72zWX+0ynJ5Ign0pgQNB4pRIpLhHrOzfRNGKFFNU4Gv2T3Ha2D9T1E5Sv/hcrOuoI1FjeYA9kJtxBpkvy68zTQrk/PHBipuUoxr0eSgTPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621775; c=relaxed/simple;
	bh=xR8Q4Iv26XmaZn+OxWzOp9w8mygiZLlwRzEhcyoJlzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6O+imluUtilc8uRBqa//Z+ONEZou3cz3UaDfIlIbW0pBrVszeMMGhnj+mJqiR8zE2+cISYGGdJsb8P9QVS85GAYgNBxP+T0PvuQehO2Q80WP7/2XTomVw4LHkBgz5xa4ejeEZKPVQvwwPkbf8aZVnIGWYl+ZaC7VsxDxLMQPm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eALvsArq; arc=fail smtp.client-ip=52.101.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3+24nPRwOpLiulla5DTF7wlXUGb3qBLhCa85e1X58BtZIpf/2XBnxZvyDqx+AEXqLjg3y2q89nIXf2B11mf4BX3dDQ8AaqmK5ymrmjB8yTYaS4jZkupdOqw4G9+UxMZb3fZQuyMl/YIFyXzL1C9tQ/MGZZcvikfB/+wybpEsIY2TLInPvvbjZHk4Y5tsygYRpw4ItWwGL/jvRxlkjmk39Ewi38iwWw+tzEtqd9dpWJIzMGpC4x8PPpIsJprOo1PM4K9tCwwsG2nb/760j7zS0YXR53Hi7mUdzlusdPQmJ+Z3PjUU5mo1iuRRUxcLirYThoZVxJWCbcL5g7jG3c58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR8Q4Iv26XmaZn+OxWzOp9w8mygiZLlwRzEhcyoJlzQ=;
 b=CjWNikwNYDsQMWlBnV9ySo6le9NCRjxSwuujkdmc0nAzG6zPNrIL5g8nf4kGIV7DZhblAY5Ee8saqo6wVpyBjm0DdoZASWXQ7CaBdWt1kx7ihxOqaHHNtKHwYH0CYxuEIEReoM45Zdbc9bbYT83pqWCwqplo6/JM1tN1H24iqqkxXMi1FnXrVRtomqulWl/5GwI4lcu1d5K3CHoR09Oe3Jw/ho2RRbP2OT05pZVFWMnuWrKwzXpK2m+fIrXZmB2OsVoJSNbsf1xugfNrtcogsnhZFr/ZFpteRprjsD7C8MJZYo/21gcNTO3D58l7UOxrkNEjZtuqjv/YGKEaPOm6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR8Q4Iv26XmaZn+OxWzOp9w8mygiZLlwRzEhcyoJlzQ=;
 b=eALvsArqC9b9eEocn3Y4zzeTPmjS8Lk5rQ33Xr/9Ahiney0d05TbRO5f3cmaDxVN9hCPNBqiyaCYSTS939S0ZuHtmCdRuKCiMrx8Eg9uSPWSzcWbq71MNlFJez2TvSCyZspwX3sToRlPWKHpLhdiYsSsi+IWRbDoQ6tXWy1Hn6Q=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by TYCPR01MB8158.jpnprd01.prod.outlook.com (2603:1096:400:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Wed, 2 Apr
 2025 19:22:45 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 19:22:44 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>, "rui.zhang@intel.com"
	<rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>
Subject: RE: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
 for the Renesas RZ/G3E SoC
Thread-Topic: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
 for the Renesas RZ/G3E SoC
Thread-Index: AQHbocDWUfVJmPBUmE+eeQdqml1bUrONjOOAgAEnCxCAAG8EgIABfE/A
Date: Wed, 2 Apr 2025 19:22:44 +0000
Message-ID:
 <OSBPR01MB2775B41C98F595C162E8924BFFAF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
 <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
 <OSBPR01MB277527932C5570EBC3D877C7FFAC2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
 <ca50f9b4-feb5-4365-927d-a2c931e268ed@oracle.com>
In-Reply-To: <ca50f9b4-feb5-4365-927d-a2c931e268ed@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|TYCPR01MB8158:EE_
x-ms-office365-filtering-correlation-id: afb4614e-d6bd-4e4c-ad78-08dd721bbea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFNCV2NKaXNSL0kwdC91OTNuL29TaHhmY1F2STl3MCtaZm5ObW01ZE5SQjlR?=
 =?utf-8?B?VHVZQ1pWTlg1dXd5a2w1RnBPRXRzNjhpa2N6enlrc2ltemFOV09sS0ZIMURV?=
 =?utf-8?B?M0hWUEhVZDJNcDFWT2VBUE9Hd2ZiUHFqQW14V1ZtTW15WTkvNDBjeS9sOXlN?=
 =?utf-8?B?T3BGbFVCdzZoT0NIRDVQNlhzeGwxTzNDazZDd29CVjc3eDFTUXQ0SFllMjZW?=
 =?utf-8?B?TW5hMVhBNTJRUVViUk83NUw4cUQreDI4SU0xTzJEODIvelBUQXo5c3NnWmlN?=
 =?utf-8?B?U0E4RE5TOVJnVDNVcXBXU2tXSjZoQzFWa3EzSzFTL29TOVpkWHdPSXdmN1Ay?=
 =?utf-8?B?a2NqNHNHb0x1a3dKdjJNNTM2MGIxbTRpbWd0b1U0Y1c3T2VrVHlMUGozSzd6?=
 =?utf-8?B?RCs0WGU4TnoyY3kzRHlLZk1JUWpScXVSZ3JCZkw4c0tvWVF1eFoxajRaak1H?=
 =?utf-8?B?cFVKdHJXYjYxRzRTNE0wV0dTNjllZXJhdUh5dWJiR2ZkMVBSSG5ZaEZwTjdI?=
 =?utf-8?B?VEs5a2V6N3hhK2JKcmJZQ3E1Q25lRVJkVFlUeUNzVXAwQ1lBbkxEZjR4NUxB?=
 =?utf-8?B?TjFGbVA3czd5UUtjUldFV0t6ZWp5bks3cTViVC90OTkrbEp1dlRjSWs5bFdM?=
 =?utf-8?B?Y3phdVdyTkc0NGNNUThWL0l4ZTFiN1Y5cnFKZ1ZSWktMVmR5Q0haN1hwMGwy?=
 =?utf-8?B?Y1hhdUloRmNXUnNZOHJkTmhxKzcxbVl1MS92Zjh1eXpMWUpIRmVxQmhtRnNS?=
 =?utf-8?B?RFAvTUZHdytEcFBnUnpYVXlnZnNFZ3BwUi9kVGk4Vkc1UlVnZWJCc1dpUURB?=
 =?utf-8?B?a2ZwejZhYzZiM3c5cFhrb0hsODdsT1M4NWZDZWc5bDB3cG5Falp4ZEtKT2gw?=
 =?utf-8?B?cGE2amdQVmg5eFFHRGh1Y2lHSVZZc1ZWeTdVM29zSGRreVcwQ2dWQ3dwUEpI?=
 =?utf-8?B?V0ZXdnBZRjl2aVNXeEZ5SWV0Z3dYKy9qQkh1OVFvb3VPNkQ2aFdLNnlkUkcw?=
 =?utf-8?B?TVRiWmNDYVFDMkUwUlQ4SnlJSmp0WDlBZnhIMERRNFQxSG5tNkZvOFN5aWlI?=
 =?utf-8?B?aERGZ3Jsako0NGllbWUvZ3kvMk81NTdRd3NtMXQwYUllUHd0RzZReGdXOEJP?=
 =?utf-8?B?djRzL0NRSXdJNmx6bGFwUWlXWGhIL3dRZEdkTFByS1Z1TE5Tci8weWJQN1d2?=
 =?utf-8?B?Vng4VzF2bVFsQ2lKVXhHYVVUYVUrRDNreHBDRHdkUnVzS21DMzFla01VdmJZ?=
 =?utf-8?B?Q2ZGV2VpRnRzMDdNSGZKL1pMWnkzUWZlUTgwUHQvSmt2MlkxYk5zUVRpK2p4?=
 =?utf-8?B?NEF2L2cxSlpkOSswQkx0TlM4ZktQc2dCbkVYT3Z5dFpaQThoSWd3RldhOGRN?=
 =?utf-8?B?UkFoVnVlbTlXQy93cXdsdDlZQXBWb2ZVSzFCdkJvUWx5dDZ5ZVMwZnd5NFZO?=
 =?utf-8?B?NitLTG5aSmNPR2luc1RQVlpvQUZ0REZEdDcyZXo2VVFUd09vdnlpSEdiVnpI?=
 =?utf-8?B?bmdwYWQwMW1wOVZKY0hsb21pdmZHMVZFSEx3RGhEOXFFY2hnanAxTzZNVlNy?=
 =?utf-8?B?YTFSQVZPS3VISnRsLzRPQXl1Q20vZE1STHo2eDdPcnVkeVFjQUdHUjFGUTVM?=
 =?utf-8?B?NkxtYTJTQ3NoY3hBMHRJT0tuRTY4L3A0dGYwRDNyWnBxRlNSSDdoV2c5a2RM?=
 =?utf-8?B?OHNpUTNQZmY2YWJzem1FY3RtVm5FdGc1Q2I5QlMzVXN2V2Yrb1NRVG4xR1R6?=
 =?utf-8?B?WGtOaVZqckVsQXlKZXBodWlUWnNpUnZ2NXdTSkJWRGFpbnd6bWNUSFRvQnBI?=
 =?utf-8?B?bEtrQk0zczlkVURiNUJ2N2FJSkFBTUozK1Q3RWx1QWZUWEZQZ1pndDdxQTNt?=
 =?utf-8?B?T3dZM3QwWUFUak9VOEsyTUw2YUJ1a0NlK3FSUkluQ1RkVFpudUR5dFFFOGlq?=
 =?utf-8?Q?aXMSTQ/Ewe1aT67bqLY4VWbB3t075xrz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blc0d2F0N3JDbG91OEd1eTQzampWWUtMM2o2S1VXZnk0RnU3L0xFZXdXUkFm?=
 =?utf-8?B?blVSeXZRZHRzUVB1QUZhYUxHcXFEbzAwRytlM3Fhenk0MVpQUll6VEViaWlN?=
 =?utf-8?B?VGtIV1V3K0dHNmxKVE5hZkRBeXpua3B0Nm5VbXc3bUlXZCtOTVVody91MmRU?=
 =?utf-8?B?Z3FVb3ZacVJjcDBFU2ozZ0RYSXJXMTdhSXp3cVJTekVqK09mUUV3dDNJMnhG?=
 =?utf-8?B?Z0tjeFFrbTdpWGFJRWE4aEFzd3lkQTRZU2hBL1VaamkyUytEc21yYU5md2FW?=
 =?utf-8?B?b1RlVWo1MkdOMjVuVFZOb1NZbjFFcXBwQkFQandLSW95N25XNHBvMStoNVhl?=
 =?utf-8?B?TTBUeGtLSFNSQzU0OVk3c1Z0VlBDeHJhdTRvd092NHFCaXFPV0J5RGJ3SGw1?=
 =?utf-8?B?SlU0VUpiTGEzR3FXVHJEMEduZW4rRUFsUHJ1bjNRdldtcE4vYVRpTDNLalJV?=
 =?utf-8?B?VDltRlhmSHpwV1ZTRnhPTkVtWEdTeWVVUEhEai9DanE5STZmUS95UDNQanIy?=
 =?utf-8?B?SkV4VkxqYVNXUzNhWU1MbkdpRHR1b0xJaGRyQ0twbEdEY2I5OThuVG05ckpN?=
 =?utf-8?B?RVI4b2ZxNGdjVEVuRDU0K3h6dkVHSjVkek5XSE9WQWU1TjBXUEZkTHRIOFlB?=
 =?utf-8?B?L09EaFB5bVhPcDdhL0N2bVpscWR3eG5NT09pNGRmQXpRWmpUYXVoUnBWV2sy?=
 =?utf-8?B?YmlJclRsN3JIYm83M1ZFMXhwa0xhd29jM3dxYk5iTjROcFBhbEM3L0JJbGdn?=
 =?utf-8?B?aUxIbEhwRlNmaGtCWXR2M1MwYlQ3UlZmbGhTTkJsblNXdlBNOTZYT0RMbjAv?=
 =?utf-8?B?QkxuRSs2dVUvV1gyR1FWV2xybG5wVG0zeXJqcHdEbHBZd2twUnB0blNIQU10?=
 =?utf-8?B?OGFiMmxZTjBBcWtvM0d4UDJXeWxEMTAxUm9yTHlEWWd0UFR6QzhxL2pKb013?=
 =?utf-8?B?L2ZLSjZxUk1mMlpTTWlYU005ejZsTENxWW5md1J2NHQ4enJpMVZVUHN4ZXVR?=
 =?utf-8?B?TUVnc2cyOFZ3UXVaV1BJK1Q5ZHJoc2gxanVicTF5K21TZTVWZTZkMEhlK1RZ?=
 =?utf-8?B?eFAyQ3pINllWenBxTTdvNjJCUkkwNG1maldYRXZOb045L051Wk0vbnZnSURT?=
 =?utf-8?B?VGZwNFhGWHc5WDRuUEFSWUtHRXlnTCtPSDVsZzEvVmdCRWpsWjJwYkZuekJY?=
 =?utf-8?B?cHpmbEoyNFBKS0diMjFlNmFXcDhYWGUyRDdnSE4zbnM1UnlVc0htYXZrSHZK?=
 =?utf-8?B?dzVqS0VLblpLY2VGMlFneUI3aCs0THNZYTM5d3pxYjJUemV2dzJRcjhHWUlo?=
 =?utf-8?B?d09RakRlb1g5N09OZ2pFcGsyMy9ZRlF1UTNuMHdYWm0yK0VPVHgvMDVUTHFI?=
 =?utf-8?B?S1NXa05CWUtUWXhIQTRhMGlZd1lWVm54cjRJWnplWTdGQU5yRnhKdy9FbkZi?=
 =?utf-8?B?VG1CMUY1K1NPbGV0TTVIN0lNWWJvVG0vcnpPb2ptSFM0RmxNSVFhZWc3SGEx?=
 =?utf-8?B?MThFcE0xMjF1ZCtNQU1JZ0pqWEtOUGU3cC9SeURRemtQcFJOckFRSWgyMUU0?=
 =?utf-8?B?cFQ0WGxJcm1VVjJ2UUpZMHRlY01Fem9kZHFuWmVodnljTW1XOU5wVWVJNjNq?=
 =?utf-8?B?NGVlakZJM2FjcVhJMnVQZFoyR3ZST0FiM1RkL3F6M292cW16QjdKeExRMVI2?=
 =?utf-8?B?ZXN1TVd4YTRid0o3UE9tS3JlUWlZajc5N2lmQUhqbFViQzhKd01INm1DN3RM?=
 =?utf-8?B?SklBV0hJS24yUFA1SEJSUkhlSGRWcExaUGt3SGRoUU42RTMxS0R2YUJOWkZB?=
 =?utf-8?B?UXpnMEhRMUQxLysxeWRvQ0JHamlGL202TzRXMG9pejRrQml2Q0p0QjJLcjB6?=
 =?utf-8?B?RW5LZERtUmd6dUZPSDdSYmthL0szOWQxNU9aa2w3YzR5YnZGUkg4bjFQN0Fy?=
 =?utf-8?B?ZlhvaVFyWlRjMUljS1IxSFBFVW1wWWJrTjZLTGkzQ0FOQkk4RTQxSkNXekI5?=
 =?utf-8?B?WXp5NUF5bmE1dllyUWNRMzRKMGhUWitJaWwxSWZocGo5UGxpRjhOQ0U3WEx4?=
 =?utf-8?B?UTRoRFNMbTVKV3ZMUzJPMW5rQ1ZQVDF2clYxOW9HZnF6RlQvc2RpcjlZL3RH?=
 =?utf-8?B?OTZURDFNNGJwSy9KZmgvYU15MGR4VWtycDFVWDh2bWZoRXA3WmIrN1M5SVlK?=
 =?utf-8?B?ZGc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb4614e-d6bd-4e4c-ad78-08dd721bbea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 19:22:44.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eQqBJN31yawcA8cI7cr/y9a+eOksLLiTakuSULBgLY6q74iSX29IOYM1zOqVweIHEflftX/d1JlWzILCVpkYjqD3gDz12Z8X1zug+gUyNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8158

SGkgQWxvaywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBTE9LIFRJ
V0FSSSA8YWxvay5hLnRpd2FyaUBvcmFjbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAx
LCAyMDI1IDg6MjQgUE0NCj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5l
c2FzLmNvbT47IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBrcnprK2R0QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gcmFmYWVsQGtlcm5lbC5v
cmc7IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmUgOiBbUEFUQ0ggdjUg
My81XSB0aGVybWFsOiByZW5lc2FzOiByemczZTogQWRkIHRoZXJtYWwgZHJpdmVyDQo+IGZvciB0
aGUgUmVuZXNhcyBSWi9HM0UgU29DDQo+IA0KPiBIaSBKb2huLA0KPiANCj4gVGhhbmtzIGZvciB5
b3VyIHJlcGx5Lg0KPiANCj4gT24gMDEtMDQtMjAyNSAxNzozNSwgSm9obiBNYWRpZXUgd3JvdGU6
DQo+ID4gSGkgQWxvaywNCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4NCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBBTE9LIFRJV0FSSSA8
YWxvay5hLnRpd2FyaUBvcmFjbGUuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIE1hcmNoIDMxLCAy
MDI1IDg6MTEgUE0NCj4gPj4gVG86IEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5l
c2FzLmNvbT47DQo+ID4+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOw0KPiA+PiBjb25vcitkdEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4gPj4gcmFm
YWVsQGtlcm5lbC5vcmc7IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmcNCj4gPj4gU3ViamVjdDog
UmUgOiBbUEFUQ0ggdjUgMy81XSB0aGVybWFsOiByZW5lc2FzOiByemczZTogQWRkIHRoZXJtYWwN
Cj4gPj4gZHJpdmVyIGZvciB0aGUgUmVuZXNhcyBSWi9HM0UgU29DDQo+ID4+DQo+ID4+DQo+ID4+
DQo+ID4+IE9uIDMxLTAzLTIwMjUgMDM6MTksIEpvaG4gTWFkaWV1IHdyb3RlOg0KPiA+Pj4gVGhl
IFJaL0czRSBTb0MgaW50ZWdyYXRlcyBhIFRlbXBlcmF0dXJlIFNlbnNvciBVbml0IChUU1UpIGJs
b2NrDQo+IA0KPiA+Pj4gK3N0YXRpYyBpbnQgcnpnM2VfdGhlcm1hbF9jaGFuZ2VfbW9kZShzdHJ1
Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosDQo+ID4+PiArCQkJCSAgICAgZW51bSB0aGVybWFs
X2RldmljZV9tb2RlIG1vZGUpIHsNCj4gPj4+ICsJc3RydWN0IHJ6ZzNlX3RoZXJtYWxfcHJpdiAq
cHJpdiA9IHRoZXJtYWxfem9uZV9kZXZpY2VfcHJpdih0eik7DQo+ID4+PiArDQo+ID4+PiArCWlm
IChtb2RlID09IFRIRVJNQUxfREVWSUNFX0RJU0FCTEVEKQ0KPiA+Pj4gKwkJcnpnM2VfdGhlcm1h
bF9od19kaXNhYmxlKHByaXYpOw0KPiA+Pj4gKwllbHNlDQo+ID4+PiArCQlyemczZV90aGVybWFs
X2h3X2VuYWJsZShwcml2KTsNCj4gPj4+ICsNCj4gPj4+ICsJcHJpdi0+bW9kZSA9IG1vZGU7DQo+
ID4+PiArCXJldHVybiAwOw0KPiA+Pj4gK30NCj4gPj4+ICsNCj4gPj4gYWx3YXlzIHJldHVybiAw
IGhlcmUgPyB3aGF0LCBpZiAoIXByaXYpIHJldHVybiAtRUlOVkFMOyA/DQo+ID4NCj4gPiBwcml2
IGNhbm5vdCBiZSBOVUxMIGhlcmUsIGd1YXJhbnRlZWQgZnJvbSBwcm9iZSgpLg0KPiA+IFJldHVy
bmluZyAwIGhlcmUgaXMgZXhwZWN0ZWQgYnkgdGhlIHRoZXJtYWwgZnJhbWV3b3JrIHRvIG5vdGlm
eSBvcHMNCj4gPiBzdWNjZXNzLg0KPiA+DQo+IA0KPiBJIGFncmVlZC4gcHJpdiBjYW5ub3QgYmUg
TlVMTC4NCj4gSXQgYXBwZWFycyB0aGF0IHJldHVybiAwIGlzIGRlbGliZXJhdGUgaW4gdGhpcyBj
YXNlLiBjYW4gd2UgYWRkIE1lYW5pbmdmdWwNCj4gY29tbWVudCB3aGljaCBoZWxwIHRvIGNvZGUg
cmVhZGFiaWxpdHkuDQo+IA0KDQpUaGlzIGlzIGEgc3RhbmRhcmQgdHpkIG9wcywgd2hpY2ggZXhw
ZWN0cyAwIHRvIGJlIHJldHVybmVkDQpmb3IgZGlzYWJsaW5nL2VuYWJsaW5nIHN1Y2Nlc3MuIFRo
aXMgaXMgaG93IGl0J3MgaW1wbGVtZW50ZWQNCmluIGV2ZXJ5IFRoZXJtYWwgZHJpdmVyIEkndmUg
Z29uZSB0aHJvdWdoIGluIHRoZSAtbmV4dCB0cmVlLg0KDQo+IG5vdCBzdXJlIGlmIHVzZXIgY2Fs
bCBpb2N0bChmZCwgVEhFUk1BTF9JT0NfU0VUX01PREUsIDIpIGFuZCBpdCByZXR1cm5zDQo+IDAg
d2l0aCB0aGVybWFsIGVuYWJsZS4NCj4gdGhhdCBjcmVhdGUgcG9zc2liaWxpdHkgdG8gdGhlcm1h
bF9jb3JlIGNhbGwgdGhlcm1hbF9ub3RpZnlfdHpfZGlzYWJsZSBpZg0KPiBhbnkgY2FzZQ0KPiAN
CkFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KDQo+ID4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCB0
aGVybWFsX3pvbmVfZGV2aWNlX29wcyByemczZV90el9vcHMgPSB7DQo+ID4+PiArCS5nZXRfdGVt
cCA9IHJ6ZzNlX3RoZXJtYWxfZ2V0X3RlbXAsDQo+ID4+PiArCS5zZXRfdHJpcHMgPSByemczZV90
aGVybWFsX3NldF90cmlwcywNCj4gPj4+ICsJLmNoYW5nZV9tb2RlID0gcnpnM2VfdGhlcm1hbF9j
aGFuZ2VfbW9kZSwgfTsNCj4gPj4gb3RoZXIgcmVuZXNhcyBkcml2ZXIgZGVmaW5lZCBhcyByemcy
bF90el9vZl9vcHMsIGNhbiBiZSB1c2VkIHNpbWlsYXINCj4gPj4gb25lIHJ6ZzNlX3R6X29mX29w
cyBmb3IgY29uc2lzdGVuY3khDQo+ID4NCj4gPiBUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4g
TWFrZXMgc2Vuc2UuIFdpbGwgZG91YmxlIGNoZWNrIGFuZCB1cGRhdGUNCj4gPiBhY2NvcmRpbmds
eS4NCj4gPg0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbnQgcnpnM2VfdGhlcm1hbF9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4+PiArCXN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZGV2LT5kZXY7DQo+ID4+PiArCXN0cnVjdCByemczZV90aGVybWFsX3ByaXYgKnByaXY7
DQo+ID4+PiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3RjOw0KPiA+Pg0KUmVnYXJkcywNCkpv
aG4NCg==

