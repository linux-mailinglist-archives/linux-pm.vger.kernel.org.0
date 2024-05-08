Return-Path: <linux-pm+bounces-7647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490D8BFD27
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094A3284287
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E750A7E;
	Wed,  8 May 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="aEXmh0ks"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11011008.outbound.protection.outlook.com [52.101.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C447F5B;
	Wed,  8 May 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171475; cv=fail; b=iPA9FZvbniwx4LropUO3fpjqk53cBABhWjTOLP5N3ZFoGV17NGadySmfps67BEBxWeC1veFzI4kfYDmrEk8UcuIgLj2RHfg0g2KnEiwRDYgNnfMPHsqg6SLUCUjq6BDGLOtEMAyV1coDf8VgEqQSoXaOMWfTFqBSwHj3IAxUSxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171475; c=relaxed/simple;
	bh=dBZISrIal1wEF9z7cTRsMyxGyCpX5oyp1Ur7wcqxWy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JNVIUHW9z1jwzkIJ72rNDvjLh7Hi4I7Uc3JHE4KDPREgrGXjELVNG+Yyzld5uf6r7wZEzITnYUtftDUaDLqd1TUJuCirgoc6oSOfXUbf1/YsU6K4mYXcbNYzBG+Tm5iKozenZ+imUbO7Hbl6qgAm//7uG6LKtnye8avrWHX06Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=aEXmh0ks; arc=fail smtp.client-ip=52.101.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU3u1no6DFNxf91XqiLu1nWQ/9rn/rn2rtEIkz+5YhydGzP6pbSmmQgnJeTRciN8NHbKYaM97N4fodpvIpfVukR4cOWHa/pPoPvzTJ9FcrQWQn7fI5BdrHQkYICdV7vtKVjSfkuc7NkJM7WxovVQgRnobo2WZrduqPD3W11TPi5bw8uwVTejjcsxtvdujdHwHAca/XLJIgUsmEtZ7n0dNnTjacYv7ErFTpteLQByl+m6mjUvqdgieWHmeGdtOjqCsgaNwlm+fsvYZM1DjDXBZJN40z3C3/GPkzxx2jmnog3aBhJdGLh0IQ7775fm/NdVKM+YHrqfnGac/FzzrOMmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBZISrIal1wEF9z7cTRsMyxGyCpX5oyp1Ur7wcqxWy0=;
 b=gLMxLefjquf+r0yluvEuZcnRZq5RWJzGPwjAvXNabBZ/lOur5Aub6//OIxgbz6yf1uYFF0hE6PYOGq+akiuSLf95zDSG0f573Qe2G7mK13BMTXmf40mS/Wz9X/KU5tIwXGX57zLu4K1bCNaNA2MZJ/ljNqW4ZZxgnQoZZSxs+Y0viJts53Tqep5bGpDbrF1/nNPy/j5WlYiIfN9IkwWya8w6rPUQJ+tuevy0AdoWp7qkfdMEVUnoOvJPMBiu61+6lQNO4LPyaHKiOTovHZAtSWqGTXoJV3Fomdx2eLJ2xhsfBvVGedhIsJVzcXHgdqYHzmL450kLHz2StLYhSD8XCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBZISrIal1wEF9z7cTRsMyxGyCpX5oyp1Ur7wcqxWy0=;
 b=aEXmh0kspzj/PcY4GHze1n1Gs6QUJqCBPkFPtqP3Uy7Rsuor417ZhokQoVSWBswy6eiBKnhXaWylNOy90XAGszD1SjOh60sh2DBQUgOj7kwdyNiri4xtk4A95v+NYHI4E9fueujV/g1DC4tlpNJ5z73A2HgfVU3hH7AN9+Fqdbw=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB5590.jpnprd01.prod.outlook.com (2603:1096:604:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 12:31:09 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::500e:ab62:e02b:994e%4]) with mapi id 15.20.7544.036; Wed, 8 May 2024
 12:31:09 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?=
	<niklas.soderlund+renesas@ragnatech.se>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/2] thermal: renesas: Group drivers and update
 dependencies
Thread-Topic: [PATCH 0/2] thermal: renesas: Group drivers and update
 dependencies
Thread-Index: AQHan8vRpexXaPlV7UqiiRgpLmZlMbGLWEMggAHt/ICAAAExsA==
Date: Wed, 8 May 2024 12:31:09 +0000
Message-ID:
 <TY3PR01MB11346145965A645880C70F36686E52@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240506154011.344324-1-niklas.soderlund+renesas@ragnatech.se>
 <TY3PR01MB113465D9CD7906936C5AC6DD686E42@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <20240508122615.GF1385281@ragnatech.se>
In-Reply-To: <20240508122615.GF1385281@ragnatech.se>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB5590:EE_
x-ms-office365-filtering-correlation-id: d2b5d33e-3e97-4147-8d10-08dc6f5abd49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2V1aDBodm1valZ0YVNiS0p0R3NGaXN0V01qWnRFcHYrWFVyKzBGWkVqczJq?=
 =?utf-8?B?d2ptbEt4WHhKV2xWMERaR3RoR0NaL3AxN1NpV09uZ0U4RjJVNy9meFRNSFNS?=
 =?utf-8?B?VHNDR2JqQ2JHYURpWElxMHNLUWhXblVFalg2RmdQV3ZrR2NkZGhtVUZBbXdl?=
 =?utf-8?B?WHRqdXlNL3RHZWxjZTAzL1NWQVJFSEJucDdocGJhUjdQRXdya24yMTZzN0p4?=
 =?utf-8?B?V3k0OW9TRjU4VkU3cVdmYTNRcDdSRzlKYk9TNlRsNVdDbmJnYXZDWHF3cFZh?=
 =?utf-8?B?aFMzd2YxTE1ldlJMWkdhVXgxTGVwTGd0MTQrMzJ3YTJwVU9nZk9qWHllMnJC?=
 =?utf-8?B?YmI1MXYzSFZTVmRyZm52L0x3N1NVVVRYNVhodm12U3pZWjg5UVpEdzNwZkZL?=
 =?utf-8?B?NDl3bXFLTWtPaHE2dHFhWHRwSWxidnVzRmozcnpaN3BxRHRQQTk2Ykw0eGw4?=
 =?utf-8?B?ZlZ2V3RXUkpVSHFKc0laM0hxSVYyU1pScmJ5MVZQblBKcFl4RGtHMGpESFFu?=
 =?utf-8?B?L0p4YjNUcGx5eXVWSVpOajVSMUM1QnE5Rk1MQnVwTVY3OVgzbHFzc0F1ZTVk?=
 =?utf-8?B?QWVqQVV6cDg0cUtKcGlZaFAwOGkxeXZtak0xdURiU05hU1dLYk1va0dqVHJU?=
 =?utf-8?B?bFo3RUp1aGVnQWUxMGZjRlRtcjRFMmJ3WE1iaHJkeTFvOGFwSFFTTDlLSUcw?=
 =?utf-8?B?b29iQ0g1Z0lERDMxRlAvdFRkdnUrREVUV2IyV0VISzNMRG5ackIvUTdDNzNQ?=
 =?utf-8?B?ZTFPUGI2Tkw4cFB6VkF3Y2dMMlFMam1FUVViNXVVbVZSYlh2c0pkalZ5L2ly?=
 =?utf-8?B?TEpCdk5uN0pDN3BzeWtiZVFaUlRacit6VytIeEtsZHl0dmh4aHJoVTJwNnlu?=
 =?utf-8?B?ZEg5cW5ueDZBSDdqc091T3NHYnpnRGN0RjUwSURNM05KenZ4UmdqY1VNTy9D?=
 =?utf-8?B?b2NuMUpnd3RKSmdpNDk1YU1YSXZ4VlhTQWo3VVFZT0c2RDg3QjBFd1FVZUtS?=
 =?utf-8?B?SVpnNGV2ZWs0OHZ6QVVrWEIyVVl6MnEzQXprRWJCaU0xSDZJSkF0ZHF5YnNy?=
 =?utf-8?B?ZEVhRCtVcGUwbitSSkI2SGJGWDJMQmxRS245dmVhS2tTWC9HNzU5K3RtM3Zp?=
 =?utf-8?B?YXlvWkhxRW5vL3JwaHZDaHpjaDFlZm1WVG9oa0paZi8xQUR5VStTYUVUMG9s?=
 =?utf-8?B?bjIxL2ppWDdQT1AvY2F1bEtQOVpHSWliZk5MemtGUHRWVXlqL1gxWHg4T2gy?=
 =?utf-8?B?VHlpNk9WSFdGM1hOKzVXdUJVdSs0U0NjREs3M2xlWjZOM0F6MFpNdzZRSzdE?=
 =?utf-8?B?MXRCdEd5SGhKSnYvNE1NTG43SUllSVNtVTRjUjYyVWxMVXhkNWRWR0FrYXhG?=
 =?utf-8?B?VXlCejgrQXBzS1RiRThDc1MwekRJdGZ1dUZFbzNKTm1nbUV1dGFmZzFQVm4w?=
 =?utf-8?B?bzJ5WTZ0eDhKYVpzUXRONUo3ckhnSzJnTmc1ZnEzSUxzS1ZnSDJqblFzaGlw?=
 =?utf-8?B?QWN3bkxwMHNVVlBPblJJL2hrYkUraDdaMVltbjFkaS9ZU2huV0IyM3ord0pR?=
 =?utf-8?B?THJrV1VMUmtZdnNoc3RBRUM4S1lwT0ZodysvTkpRbUJsS0x6RHRxdnFnWlUv?=
 =?utf-8?B?Q1duU0xDVTlmVWtkT1paY2VYVmVJVjc3R3V1bDRhSnkzZTdWR0RnbjhHY0Q3?=
 =?utf-8?B?WW44dHhQaDg3SEZtSVV6a3REZVRDTFJvTURBMHI4am9DSmM0RVFsTzV0RnR3?=
 =?utf-8?B?MlN6cFpnTGF2b1VNQ0l0cEFnVHZmNWZwTEJpaVo2bUlTUVNUNjA5VHYwQ0hW?=
 =?utf-8?B?WkgraGhscmZkVnlRa2FIdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGNERnlKZnczQTYxVFJQY3RKakJiM1psdFJEY0xtMlpJcWNHT1lnTmxKMlcr?=
 =?utf-8?B?dTdMY1poQjVWSDhkbmM5TXZtY3V2MWhCL2puOG04Mk9GZ296ajlyTTBBNGVH?=
 =?utf-8?B?dFRUV0FiMWZnUCtVVE9iK00wZWo0V2tJM0c1blhnRHlrTkhLSFNJb3Q3d0pY?=
 =?utf-8?B?YU00TEJHZkpNMFM3RmFHYUMybHU2eXNkWHFsa1Z3eC9RVnlQbFBjVGdXYzFZ?=
 =?utf-8?B?RUh6QW56SnZGUHl2SFNrQkIvOENlSnFuYUoraTdoRStOTnlWQjRqWVdvNlpv?=
 =?utf-8?B?SlNUM3k4ckhjK3IxWU95WSs1TU03L2FlNnp3SHFZcXlkaVpPMFd3L0FJSnJ2?=
 =?utf-8?B?WDZqRWhtYzltUDYwQkJZdVBvYXA0WlMvOUhHRFA1OVMvbTJwYWV1dWJPcFVV?=
 =?utf-8?B?ZzhQaHR4WWk1WDJrcFk5QVJFbGxMNC9wK3ZBemRSTTNoeUNWbEJzVVh1QTk3?=
 =?utf-8?B?ckl2MllvcHdHeG1kYkl2M2ZUc0hWUXpzOTVpdGdjbTdtRTgrc3dWalJ5Vkd1?=
 =?utf-8?B?cVhWbEhkcllGTW5hWTdzZHlLcXRCclUxS1VVTjZadkN3dUhTYWNreXV4S0Rz?=
 =?utf-8?B?Ylp6UDVPWGwxeldLNWs3TXJzSnBNNi80NVlYTUkxaEZRRUo2UzNlcVlSK3pJ?=
 =?utf-8?B?Q2NPU3AzNThVUXBsaXN5M3hLM1dpMWV4OHBXbEYvV2JVYy85K0U2cWZ2YW9L?=
 =?utf-8?B?bjZWM3g2eWRxc1RyZTRUN0IzR1lxNFF1RmNEeFZaY1BiaGtrTTNGUG0wdlU5?=
 =?utf-8?B?ZXF2UkNhVFRrNCtYdStIM1drT1FwczJoUHFxNWdEcVdKK0gvcWU0emYwdDA2?=
 =?utf-8?B?Ri83N2pKY01pZ09nZmNkbE5oVlU1VklCV29pS1VVeGFQRjFLc0tSV2tQald2?=
 =?utf-8?B?TW5NUUNPSjRPTXAzZS9NbVJpbTRReGlvVW56OTdBY1J6cElCWkU2TUYrcDNB?=
 =?utf-8?B?dUMrUjhSN0l1TEFaWmVGZHBUQW8wU2tsYnFTZHpaL0d0MFVwdmlMZGJOaVhQ?=
 =?utf-8?B?U3RreXgzcS9pSXh5dkdUczZ6b01aY2IvSmRyajRrLzhrSExQTWtlWEg2SWdn?=
 =?utf-8?B?OGsrRjgvb2wvS0IranFmR3VwTkhVVmpTR0IvbVZSNFlBS0xhaDk5UzFIVU1E?=
 =?utf-8?B?NGV0dnIwZ0VUMGxJMzhhdjBQNzEySVB2VWNreGVtTklKU2VYanlocnFLbHZJ?=
 =?utf-8?B?WDhGYmRkYlpENkU2dEp6b0VCRzFLNVhuWWpwbmhEWUJkU01McFZSZTczd0dh?=
 =?utf-8?B?ZmFBMEdHUEx0dmxDVGE3UCt0dUVJMVhUWmJwZFdTbTR3dXkvbW8vdjNVR0Rt?=
 =?utf-8?B?RFFjMXZpNkNuU0hSNE5BZVN5UGFoU2t4bkNDZzZWMTBabHhYazBIOUpWZ0JY?=
 =?utf-8?B?YS9heXJnZng0RWdRUy9wTjlOTUJ2RGh0NjhZR2lKZEVFaXZrZkUycFlGV3E2?=
 =?utf-8?B?SHlmU3JwaVBsbzZNME1pVDJLZW1QNEwrdXZzSSsxUUNHWmhQOHIvcU9vSndO?=
 =?utf-8?B?WmRsRlBWS1lDejhTdlNEbjV3b0JucWptS0l3bzB5eENIS0htMi9neUcrNXRT?=
 =?utf-8?B?S3VkMnFrZ3Z2VWtDZWdHTTJqQVZ5NWM0dkVuVHY0TUdOMWw3UFQ1alRJaVVz?=
 =?utf-8?B?VHg1Tm5lWjVNdVFhQUlpRklGNGUyUmEwVEFFbmRNMGhna0kvRzE1bWgvdHBO?=
 =?utf-8?B?N09zaVVzcFBWNmI0TkxkaTYvMDRVc3FYMzdQRklybUYvZWFKUDArTzVxTWJU?=
 =?utf-8?B?ZWhLeUF3YUlWeXE5RFQyeFF0bFhTTnArekx4STNoekNEQUNqWFUwMVNjNER0?=
 =?utf-8?B?azM4NTB2WjlBTzE0Z3lsUGI5eWphSEJ6NHN5alNIYzBsTGVHV084T0NWMGpL?=
 =?utf-8?B?ZjN3c2JPekVVSzk4K0lQM0luWVl6Qjk1Q0JGRFdURFFlTDNlMURRSXFjZ2V4?=
 =?utf-8?B?K09TamVsdGtZVWVEKzlwWmJqKzM3MjVaUnIzZ2dkRHFQcFNhRm5xUXpTSEI5?=
 =?utf-8?B?VURwQzRIVWsrbS90UVk4OTNVaXQrRHhFRHd5cTJwYjlISks5TFNJZm5teE00?=
 =?utf-8?B?UHllV3NHSDdnREt1M0tlY1M1d3VINTdzQjF3UG1sUndtSTFVRGxuQUp4Nlk5?=
 =?utf-8?B?ZWNUZG4vV3dXOUFOZkw4U242YzNJVUVsWGVCZXY2L1NPbVpFZENvTzloUE9X?=
 =?utf-8?B?c2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b5d33e-3e97-4147-8d10-08dc6f5abd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 12:31:09.2945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bREajhDSC2hdzx/aASukLpZxCoo/U9ZpejtE9+Nv8VLJTHN69isfKBFifSHwEEVWMkETT3Fmufr+RHBUGY0bqJlP6XgX3UBGwnG3sqZXl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5590

SGkgTmlrbGFzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5pa2xh
cyBTw7ZkZXJsdW5kIDxuaWtsYXMuc29kZXJsdW5kK3JlbmVzYXNAcmFnbmF0ZWNoLnNlPg0KPiBT
ZW50OiBXZWRuZXNkYXksIE1heSA4LCAyMDI0IDE6MjYgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAwLzJdIHRoZXJtYWw6IHJlbmVzYXM6IEdyb3VwIGRyaXZlcnMgYW5kIHVwZGF0ZSBkZXBlbmRl
bmNpZXMNCj4gDQo+IEhlbGxvIEJpanUsDQo+IA0KPiBPbiAyMDI0LTA1LTA3IDA2OjU4OjU5ICsw
MDAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSBOaWtsYXMsDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlrbGFz
LnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVjaC5zZT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCAw
LzJdIHRoZXJtYWw6IHJlbmVzYXM6IEdyb3VwIGRyaXZlcnMgYW5kIHVwZGF0ZQ0KPiA+ID4gZGVw
ZW5kZW5jaWVzDQo+ID4gPg0KPiA+ID4gSGVsbG8sDQo+ID4gPg0KPiA+ID4gVGhpcyBzbWFsbCBz
ZXJpZXMgbW92ZXMgYW5kIGdyb3VwcyBhbGwgcmVuZXNhcyB0aGVybWFsIGRyaXZlcnMgaW4gYQ0K
PiA+ID4gdmVuZG9yIGRpcmVjdG9yeSBhcyBkb25lIGJ5IHNvbWUgb3RoZXIgdmVuZG9ycy4gVGhl
IGlkZWEgaXMgdG8gbWFrZQ0KPiA+ID4gaXQgZWFzaWVyIHRvIHNwb3QgaXNzdWVzIHRoZXkgYXJl
IHdvcmtlZCBvbiBieSB0aGUgc2FtZSBzZXQgb2YgcGVvcGxlLg0KPiA+ID4NCj4gPiA+IFBhdGNo
IDIvMiBmaXggc3VjaCBhbiBpc3N1ZSB3aGVyZSBvbmUgZGVwZW5kZW5jeSB3YXMgbWlzc2VkIGZv
ciBvbmUgdGhlIGRyaXZlcnMuDQo+ID4gPg0KPiA+ID4gQEJpanU6IFRoZXJlIGlzIG5vIGVudHJ5
IGZvciByemcybF90aGVybWFsIGluIE1BSU5UQUlORVJTLiBTaG91bGQgd2UNCj4gPiA+IHVwZGF0
ZSB0aGF0IHdpdGggYW4gZW50cnkgZm9yIHlvdT8NCj4gPg0KPiA+IFllcyBQbGVhc2UuDQo+IA0K
PiBTb3VuZHMgZ29vZCwgb25jZSB0aGlzIHNlcmllcyBpcyBtZXJnZWQgY291bGQgeW91IHNlbmQg
YSBwYXRjaCBhZGRpbmcgeW91cnNlbGY/DQoNClN1cmUsIHdpbGwgZG8uDQoNCkNoZWVycywNCkJp
anUNCg==

