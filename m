Return-Path: <linux-pm+bounces-40009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E4DCE6516
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0658A3005EA9
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1B28312D;
	Mon, 29 Dec 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b="RiFEKQ5z"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63C1ADFE4;
	Mon, 29 Dec 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001834; cv=fail; b=OKmPW9Dw57r00ZQXeQuzjbhUiOTMwkTUcE+hS+cJnDKcJmzSMPsw/NVWTN+fAWDVsfoeuAtUVKFJaEx/Dmwd36vYbziVFK/IK48AbJ/LjXBlcX0UHJsFITRVtdqq3CRnhlQdKFxajLiXVKQHt6Qg/e18mWbpmsO3wNZb2djIYWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001834; c=relaxed/simple;
	bh=Mgu9WSnl/9auBo/AAfNJs2Q3Pv+GLRDOfVsew3lkjJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KG+qGAkzSvNMWvqRXvkm4vPvF9kNDuD0ZOaElwRcfPqrtgkKlmzUeq9uzlIIYIEJKZ6Tw/ZKvGGz5nrCKgVDhVLP50u2qAvXXtWrG3X3rvoXQ56Cd/AOl8ebIFl5TCkW/QtgcP3Oqj9stMZBo3/wYzR1wlV02zeeCKGEY+ld0cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn; spf=fail smtp.mailfrom=leica-geosystems.com.cn; dkim=pass (1024-bit key) header.d=leica-geosystems.com.cn header.i=@leica-geosystems.com.cn header.b=RiFEKQ5z; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com.cn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF+z8SM/BU1MtOU6OLIhpb4u9tsUA9LiWh/1HTbXLnWSrypncBE4RvWqpJLjUxWj9sWGH97eyudEDh6gKqgoVb4yQ170cgXRI0/6FQMHlGaaOKrPMlR0pox9ykPGNaisx/qPOma0iIZSvXJ2d/p51ykus2p8AkEEHAA+qt+aq9IuYQvQmYcc1oQZftVOrUyXqxEuLg4eAsMUKMYYx6V//Rt/tD92uno2E57/Y6Urf2pPM2tTtVEy0se9nLMq/XkhU0SHXbrYgUV913smcryOuOGMmk3WVvOPD8NjerJLLPh2LUOM7wC9SqHIV+Akx/RIs5VwXg+jt+0rUswWONlyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgu9WSnl/9auBo/AAfNJs2Q3Pv+GLRDOfVsew3lkjJI=;
 b=hnenDQ5L1PH5gowBc/CT1bX+5IALzSBhWv1hUdZHcnEP3oMVwWgkOgR30zciojVnIn71korfC9qOu6vxms/tB2rutlJYJW85uBK2OOU7VY9Q+cVE/yUMY3Ep14kCABxiGxi+SOhrRmsRTskAhOjViW3pDlq6/jIhExk0CptoajOtHN0f0LEZOXNaYPahlPWi5HIXB9F/ljl+3hRIrz/mDdUoI0mZ5OkdKnJXM1xyLA7mjEvZKe5Is1zw+Qd1s4dMbGrBY7hfbanJMq1q1e0DoArTQnNErFIbooErnb+ex69E5X51wNGaz08m2DIzv4BIzQkbK520lD78yUNWWaHMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgu9WSnl/9auBo/AAfNJs2Q3Pv+GLRDOfVsew3lkjJI=;
 b=RiFEKQ5zidc21kFTNUC8QDjK6Bb4Tn7VDIG2iBPcrcQbLEyGV+EiPBi9B7/3sp6BA3B0PVfCzSn5g2rXt8UyeMysb0gBwj890L2UGCngHvSXjUmEg93tNPczDOs9McrziS/Pb/83YSVWz1DaVosT28Nr2xUBDzDXpHZpUboT96c=
Received: from GV2PR06MB10809.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::21) by AM0PR06MB10379.eurprd06.prod.outlook.com
 (2603:10a6:20b:701::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 09:50:27 +0000
Received: from GV2PR06MB10809.eurprd06.prod.outlook.com
 ([fe80::f29e:9a49:43b4:80fb]) by GV2PR06MB10809.eurprd06.prod.outlook.com
 ([fe80::f29e:9a49:43b4:80fb%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 09:50:27 +0000
From: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: RE: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property
Thread-Topic: [PATCH V1 2/3] dt-bindings: power: sbs-battery: add polling
 interval property
Thread-Index: AQHceKEMCnPg0huO8Eyf8LHjCnZylrU4VlOAgAAIeaA=
Date: Mon, 29 Dec 2025 09:50:27 +0000
Message-ID:
 <GV2PR06MB108094811EF351CEA446A1ACBD7BFA@GV2PR06MB10809.eurprd06.prod.outlook.com>
References: <20251229085636.4082852-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20251229085636.4082852-2-Qing-wu.Li@leica-geosystems.com.cn>
 <63f1fd11-6628-4a83-b376-1e4efad6fd63@kernel.org>
In-Reply-To: <63f1fd11-6628-4a83-b376-1e4efad6fd63@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10809:EE_|AM0PR06MB10379:EE_
x-ms-office365-filtering-correlation-id: a0132986-af82-46bf-e7ed-08de46bfb21c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEJ4NlRnTEhzZ0V1QytxcHowL2FNbjliWUZyUkVFVTBFc3RTeHZJejJEdXhy?=
 =?utf-8?B?YW9GTUhsZEg4bW1GdTh3YzV6c2tkbzFma2krbnFmbnBvWjZoYjhTc3dhUEI5?=
 =?utf-8?B?WjFsUDR5NE9RendnK1NRUlNxVlladFJWN2hxT1NTTFlQYmlGS1RZRXhiazRj?=
 =?utf-8?B?T2VDRU5rTlJZSVdlWTVKZjdrZ3pHcmJDV1hmRmdtUjZ4L0w5KzQ3MEtsaVFy?=
 =?utf-8?B?Sm1SdmZRd0drTXR5dDFBNkRFUW1Xc1RDNklHNDUrTGxhNnpYZEV3cE9aT09t?=
 =?utf-8?B?djJiWmZaVnpnb1V1VWV3dlppZytoVWJDbllVaEN1cUwrUy9QWlVSd1pXN2I0?=
 =?utf-8?B?SkpocDVEYkFTV3k0Sk40V0pKYzZma2pvWHFDUHVDNC80ZlRlMEw2S0dwa2lB?=
 =?utf-8?B?U0RINHp3WEo2cWlyWkpuQ2w2a1BUeDkzK1RQNHJpTGxhWFhaRkgvUGd2TmFR?=
 =?utf-8?B?OGZZenE2dHpmeGtVRThJa3lob3hFd0hSYjZGWEJWK29vdGZ5QkgrMTJOMWE3?=
 =?utf-8?B?U3R3ekp3OFNCWDJNdGR4Zk9tNDEvSkM2Vi9pWllOaklDT0VaZWtyOFRBdjNK?=
 =?utf-8?B?LzB0bE1hcEpna3ZuRW40V1lTMnFlUytXU3oxL21EZTVkZEkwbEhDdHR4RHRo?=
 =?utf-8?B?dTFZN2JNWGJWd09aa3NweHZuUUJPdzVvTzU5RkZDdi9MMVFGZi8xR2xQUnhl?=
 =?utf-8?B?YWFmMGhXU1RNN0FBaEtHeTdXTm1WSVFFRW1qNGpVUk5SdjJWckhsVUtqbWJ0?=
 =?utf-8?B?djA3cWd0RWZoa1VScXZ6VVJZTGxrSnlJYk5td2tnNnJIRlk4ZElRVCtWeW9K?=
 =?utf-8?B?YU4weGtObkd3QWpzUGoxa1B0VCtjTnFJKzFmSjJTclJRRU16RjZVckZRcEtQ?=
 =?utf-8?B?b1NyamppZlJaSCtWalhuZ0k2QkE2SjF6aGl6eHdtdlp4ZVJKL1RuSy93OVlI?=
 =?utf-8?B?eDVxbUptdHM1cUd6V1dXZDdRaDlKeTBMZjUrSWlISFU1TXBhSlhpUUZBcDVS?=
 =?utf-8?B?SkptMUxTRENCZEFVYmY4TGx5RmhCZFN2ekJMQkNhZ082ZGVHdTZmajdNR1lt?=
 =?utf-8?B?YmRVa2MxTHBodTFWbkRpTVdCZ1ZJQ1ZMTms3L0kxTTlsRHlXQWUzbmgzSFN4?=
 =?utf-8?B?Ky9NZ1BPZEN3aUI2UVc4ZHNIZ3Z0SFl4UHRjVkpEUnhiQlZNejZlUGFuMjBN?=
 =?utf-8?B?TUxQSXo4VzUxZG1uTUg3UDNBdW44eUtCZFlYTzZ5bWs0MVp4T3ljNkVQMldW?=
 =?utf-8?B?MlA2Y0Q0czg2b2NQeE5zS2tqSXRPZUNiZTlxa0ozUjZKRkxrSy9XL244M0hN?=
 =?utf-8?B?R1RvZXhrMElER3N2blREMnRub0lrL2dpa3lJaDVBSmsxU09na1pLeElRcW5h?=
 =?utf-8?B?L2gzR014Q0E5SlczMnpXOHNsbkFIa0VuQ3NOWFFZRTRQSzZLeGJFd0k4Ly9Z?=
 =?utf-8?B?RVNza3krS1E5c2hDcFFxZmt3MzhDdVQ1UE5iWktWK3MrVTBQbWowaDc0ZU9S?=
 =?utf-8?B?SFRBb0hkMFZlRC9PZE1TbUgvTndjclIwd0dTSFVYekV2Zittc2d0NlQzc2ZJ?=
 =?utf-8?B?bmR0YXhKYXh3Tm41Nk9rNzREN1Bvb250cTg0eUg1MUo0a1hNTFREdGxiaGxI?=
 =?utf-8?B?RHhDRXZnN25oSzJuVFhrQXI1dHBCZFVaSTdnckFPNVNtWTUwbnFpd1ozN1hk?=
 =?utf-8?B?cjhVUWdrYTlYWXJKRWRpcUlsK1p3MENvVEVzMTQwSGZMOU4zRnZmSloyWEtT?=
 =?utf-8?B?S2lJNlF5MVNuNlY1cG1yZWZNWVc0QWhFbmticzVSbXZxZ3VzdGpQSFlwd2Zw?=
 =?utf-8?B?TFZmSmxnU0U1RmNxZzExYlh1eE1FK3lGcGFJNkVkZGVQaEJjSHdubFY1OXRa?=
 =?utf-8?B?VlZjdThNWHdnY0l6TXJOYkNqRkhqSXluRkJSUkZCYVQrZUYwZ3NKOUwyS0I3?=
 =?utf-8?B?cENiUUFLRlJsdXFzdE1takdOV1JuWG5HY21DWHhHd1Vxc1NqeExINEF6NnFH?=
 =?utf-8?B?SWNFN2NLQ3lKdzJRRmdCRjIzKysvWTNraktPWDRKOE1aUldIclpEVjVVeHQ3?=
 =?utf-8?Q?NwTtqs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10809.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXBtQ0k0YjFsbHRaT29vSnZoTGJCYWxlUDVsN29GZkVYMVNDdXFGcjM4TWI1?=
 =?utf-8?B?aGJsenpoQ3FQbytwN29rWHlBQW5YTUVwa1I4TjBDMWpZaG1MVjBsNGhzL0xt?=
 =?utf-8?B?bU92S0J5VWRKN2wzb0dQaW9makNRaEpFR3hFWXFSOW5FRFZrNzNqYm95b3Yx?=
 =?utf-8?B?WjJtWTBIcDB6TzVQbzBwMzUyTDZ4RlRtYUFESTJlUWJoWnhlWUF0ZnBVbzB3?=
 =?utf-8?B?endNc1FacWp0Njd5TnAydFJEY3ZFeXU4SVJxTHUyRWlUTFlKZEJUcndrRDFk?=
 =?utf-8?B?ZitxUjBEZ1Y2WVRnT2Izai96KzZHRWxoWHJGdC9GYVNieDFWSlh4SUliVTd2?=
 =?utf-8?B?cllYa3hYamZqT3FlYmRpdXpFdFhCdUg3M3F3Mm5mU092SFhXcjUrS3pNblhQ?=
 =?utf-8?B?clZBNVJMSHE3R3JSNXU4MTg2WVh3N0kwdlNmWUxWdEl0RFAyWVJUZlI5ZUdE?=
 =?utf-8?B?U284OFVEQ3VGK2pwUGpLSS9TWTJYblNMRnVvQmJWMi9rSVJtZ0NFNjBoSFJl?=
 =?utf-8?B?bm5jc0ZlcU8veEJKY1RPVGVXVm1vWTIrYi93UmlMQzYwNlFPYlJOc1ZPVkF4?=
 =?utf-8?B?TDBISVNoaG1SWVVBM2Q4aHIwczdrY1pUYW16MmpGLzJKUDVZTjhaY0JmTHQv?=
 =?utf-8?B?bFhuUzd4emc1NVo1TFFaVVpPQkIxSTFvKzNzNWM3Y0sxL1I0ekVzVXViM2xU?=
 =?utf-8?B?QnVwZGNmQTNtaUFkOEpaMVV2TXM1cXU3SVhSeUdXU3QzS3EwclROS3hJcnBu?=
 =?utf-8?B?d1FPdFlQQndwOCt2NTFsdC9UTnlNWlhVZk50MnpPZHFqMnY3NUdHOU9FMGo3?=
 =?utf-8?B?d1ZWWW1oemNuR0FKckdmQ3dpc2JkSVRQMUR2QW14ZWRXbUo3OTlwTVFZaVBu?=
 =?utf-8?B?cDh2cVZVZWJEcnpPbFlXUzVIbnpvcy83UU1yNTlpMkZETkZib20rT1VoSjdn?=
 =?utf-8?B?UWFNOC9LdTV4VDJZaHhWbWxycXJDNVEwZDB2bFJ6c2VsWitSODF4R3ZQZUxH?=
 =?utf-8?B?Z1k4UjlxTkZoNC9qc0M5cGQ3RGtpYkVnaWxjL3FIYkowLzB3VGNqeWZXdmRR?=
 =?utf-8?B?dWxyVWQva1ZCb0RTMDBMTkVWSER0TmpFUG1HZFRCaVFHMlhjNjRuaXBxSVFC?=
 =?utf-8?B?M1N0NzhIUTFPLzBqY1EwV05hVGp6a1NtM1R3TW1tUXdTRGhPNmliZE5Na2pJ?=
 =?utf-8?B?MjA4ckd0Mnd5L0JxOGJBL0dsSTByVkoxaG5sS3F1QVROanBISFVyeGtDTXln?=
 =?utf-8?B?V0hQTUpSU0JDQmNrLzhuSTBEeFI2MERPcHhzL213dnI2dkJUNXhKaVdPQWxm?=
 =?utf-8?B?YjFadjZHdTB0MVppdHd1dUdDVVdqS3A1TDB4MG5naUIrcnV2Yyt2M3YxelEv?=
 =?utf-8?B?emZzOEpVdU0xbVJTaTZITXpxUEJNWjl0N28zaDNyTXQ3c3l4R3VnMnhoMWc5?=
 =?utf-8?B?N2hkVE9Fa1RTUE1WclQxT0JUUkk0ODNuNklKV1lQa242VGl3NDU1cHJQdDRn?=
 =?utf-8?B?aVJDUWQ1YmdPdVMxenpPQWdoSFNJTWlGeUl0SW5vSk9jSksrT3V0MU1yZlJo?=
 =?utf-8?B?ZzV5NDhKOXV6T05XWTVkeE02QkZhRVhKS29IUzdyNU5XclVJOGIvRnk3S2dZ?=
 =?utf-8?B?SkZuUjV2ZWVVdkFHajRjdk11a1hVRk94V2Jxa05ZY2llYlZjZURzZ1BmTlJJ?=
 =?utf-8?B?WXJuQ085SEJ0czhGNWpnWEVReDdnSVh5cjNBZCtMZ1RmcC9qZVo1M1Fqek12?=
 =?utf-8?B?OWIzRW9XQWdCZXlNZzkrYm1HS1FCSTlmVVNCTkRpclArbENUdWRESG1PR1RW?=
 =?utf-8?B?ckN4UG11T0tjQzlOYmpwTWlnZEZVN2p4bk5DR1hXWUdQNnFMQU9YZVlJRHlG?=
 =?utf-8?B?SkVJOVFIbEVFaVZaazBhRmFCODFYNEozTEtPQWNKWi93VC95UDNtNHc5RC9q?=
 =?utf-8?B?TWQ3UlV3dW1BTnoyZ2EwOFRuQkhZVDdrUFk5ZnZyeUtFaFZSVTIyazRVeHR6?=
 =?utf-8?B?YlcrcGc2c0dsY0ZWTzNsMzV0WXEvbGtOSi81OGJKa08xWENIRC9uTCsxMVNK?=
 =?utf-8?B?WkJQVmdKaHdnNlJWSlZkQURzemFOL0tIK3JZZmJiajI5RDZCYkE2SFMyS1FV?=
 =?utf-8?B?dHg0dC84cDFoUXpKSEhtMndnUW1qaDI5ZkRxVTJmMFV1NytjbHA5b1U4cXdM?=
 =?utf-8?B?eHJSOFVwdTlCcWZ6M2xnOTc0bWZVZnVBMUdTaVdzUXRIeDNjdUw3R3FQelV5?=
 =?utf-8?B?T2ltcEdCUWZ4cGIvZFpYem9jdTdzbkpMR3BlRFk0VVRKMmJEWFh3eGNEM2tN?=
 =?utf-8?B?QnpPdzdyVnI3c1gyMnZGdlMvbnh6anQ2ZnZHTmIxTFRMeVJKQ3RGVnJ4TmZB?=
 =?utf-8?Q?CjNveE84aaM9iinE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10809.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0132986-af82-46bf-e7ed-08de46bfb21c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 09:50:27.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuXd/+LhPZOwlRMcQ0Yf9P1DuYIz6JT85PR91r23WOFkCI9iGtdhTScK+WG6n3+WY+xeQ6QYSUKAomNwoPc2woGQ7fii+7ZucOdSle8PnfKrElv+JVQLWj0RZq33WPmI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB10379

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDI5LCAyMDI1
IDU6MTYgUE0NCj4gVG86IExJIFFpbmd3dSA8UWluZy13dS5MaUBsZWljYS1nZW9zeXN0ZW1zLmNv
bS5jbj47IHNyZUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVs
Lm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogR0VPLUNISEVSLWJzcC1kZXZlbG9wbWVudA0KPiA8YnNwLWRldmVsb3BtZW50Lmdl
b0BsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMSAyLzNdIGR0
LWJpbmRpbmdzOiBwb3dlcjogc2JzLWJhdHRlcnk6IGFkZCBwb2xsaW5nIGludGVydmFsDQo+IHBy
b3BlcnR5DQo+IA0KPiBUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAz
NjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlDQo+IGNsaWNraW5nIGxpbmtzLCBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+
IE9uIDI5LzEyLzIwMjUgMDk6NTYsIExJIFFpbmd3dSB3cm90ZToNCj4gPiBBZGQgdGhlIG9wdGlv
bmFsIHNicyxtb25pdG9yaW5nLWludGVydmFsLW1zIHByb3BlcnR5IGZvciBTQlMtY29tcGxpYW50
DQo+ID4gYmF0dGVyaWVzIHRvIGNvbmZpZ3VyZSBhIHBlcmlvZGljIHBvbGxpbmcgaW50ZXJ2YWwg
b24gc3lzdGVtcyB3aXRob3V0DQo+ID4gaW50ZXJydXB0IHN1cHBvcnQuIFRoZSBkcml2ZXIgcGVy
aW9kaWNhbGx5IGNoZWNrcyB0aGUgYmF0dGVyeSBzdGF0dXMNCj4gPiBhbmQgbm90aWZpZXMgdXNl
cnNwYWNlIG9mIGNoYW5nZXMgd2hlbiB0aGlzIHByb3BlcnR5IGlzIHNldCwgYW5kDQo+ID4gaWdu
b3JlcyBpdCB3aGVuIGEgR1BJTyBpbnRlcnJ1cHQgaXMgYXZhaWxhYmxlLg0KPiA+DQo+ID4gVGhl
IHByb3BlcnR5IGRlZmF1bHRzIHRvIDAgdG8gcHJlc2VydmUgZXhpc3RpbmcgYmVoYXZpb3VyLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTEkgUWluZ3d1IDxRaW5nLXd1LkxpQGxlaWNhLWdlb3N5
c3RlbXMuY29tLmNuPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcG93ZXIvc3VwcGx5L3Ni
cyxzYnMtYmF0dGVyeS55YW1sICAgICAgICAgICB8IDkgKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvc2JzLHNicy1iYXR0ZXJ5
LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBw
bHkvc2JzLHNicy1iYXR0ZXJ5LnlhbWwNCj4gPiBpbmRleCA5MGI5ZDNkODgyYTQuLmZiZGQ1ZGQ1
ZGRhOCAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wb3dlci9zdXBwbHkvc2JzLHNicy1iYXR0ZXJ5LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3NicyxzYnMtYmF0dGVyeS55
DQo+ID4gKysrIGFtbA0KPiA+IEBAIC01OSw2ICs1OSwxNSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAg
ICAgICBtYXN0ZXIgaW1wbGVtZW50YXRpb24uDQo+ID4gICAgICB0eXBlOiBib29sZWFuDQo+ID4N
Cj4gPiArICBzYnMsbW9uaXRvcmluZy1pbnRlcnZhbC1tczoNCj4gPiArICAgIGRlc2NyaXB0aW9u
Og0KPiA+ICsgICAgICBQb2xsaW5nIGludGVydmFsIGluIG1pbGxpc2Vjb25kcyBmb3IgYmF0dGVy
eSBzdGF0dXMgbW9uaXRvcmluZyBvbg0KPiA+ICsgICAgICBzeXN0ZW1zIHdpdGhvdXQgaW50ZXJy
dXB0IHN1cHBvcnQuIFRoZSBkcml2ZXIgcGVyaW9kaWNhbGx5IGNoZWNrcw0KPiA+ICsgICAgICB0
aGUgYmF0dGVyeSBzdGF0dXMgYW5kIG5vdGlmaWVzIHVzZXJzcGFjZSBvZiBjaGFuZ2VzLiBJZ25v
cmVkIHdoZW4NCj4gPiArICAgICAgR1BJTyBpbnRlcnJ1cHQgaXMgYXZhaWxhYmxlLg0KPiANCj4g
DQo+IFlvdSBkZXNjcmliZWQgdGhlIGRlc2lyZWQgTGludXggZmVhdHVyZSBvciBiZWhhdmlvciwg
bm90IHRoZSBhY3R1YWwgaGFyZHdhcmUuDQo+IFRoZSBiaW5kaW5ncyBhcmUgYWJvdXQgdGhlIGxh
dHRlciwgc28gaW5zdGVhZCB5b3UgbmVlZCB0byByZXBocmFzZSB0aGUgcHJvcGVydHkNCj4gYW5k
IGl0cyBkZXNjcmlwdGlvbiB0byBtYXRjaCBhY3R1YWwgaGFyZHdhcmUNCj4gY2FwYWJpbGl0aWVz
L2ZlYXR1cmVzL2NvbmZpZ3VyYXRpb24gZXRjLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgcXVpY2sg
ZmVlZGJhY2shDQpIb3cgYWJvdXQgdGhpcz8NCg0KICBzYnMsbW9uaXRvcmluZy1pbnRlcnZhbC1t
czoNCiAgICBkZXNjcmlwdGlvbjoNCiAgICAgIFBvbGxpbmcgaW50ZXJ2YWwgaW4gbWlsbGlzZWNv
bmRzIGZvciBiYXR0ZXJ5IHN0YXR1cyBtb25pdG9yaW5nLg0KICAgICAgSW50ZW5kZWQgZm9yIGhh
cmR3YXJlIGRlc2lnbnMgd2hlcmUgdGhlIGJhdHRlcnkncyBpbnRlcnJ1cHQgc2lnbmFsDQogICAg
ICBpcyBub3QgY29ubmVjdGVkLCBuZWNlc3NpdGF0aW5nIHBlcmlvZGljIHN0YXR1cyBjaGVja3Mg
dG8gZGV0ZWN0DQogICAgICBjaGFuZ2VzLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0K

