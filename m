Return-Path: <linux-pm+bounces-19084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F859EDEFF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8BF18893AA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1BD16BE17;
	Thu, 12 Dec 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b+rjZFU9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D6748A;
	Thu, 12 Dec 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982033; cv=fail; b=cvbbERzUGAxY6zFuW33NN6EG19X/tZ8Z447HRBcgpH4VhKuOasmhcIYaA+xVHq/cljZdQ0MUTg/qqT+91gRkMV594mfhEysJ2evDHUgoIbhlPZvmAN6ii+WOlIuVxwxZ7r6MAQyh/k2UDHgyq2sP7jUQwY4cfNMZviMAoaH7r0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982033; c=relaxed/simple;
	bh=J/hLIlHMMR3rdrj0BJCyuaXtkqIguv7j98Sx9Ft7a50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlkyMWvrqi80TuehR9aGDoifWYhXfnPzIH7S/NhVwThHtYDvgWaFH5lOvUg8kFyXhNT3Zr98a42zcnC7V2Ts+6SNnMe+cQ4I/51Wbki7s6Q6JGutb87XPNJdVeILigKj/1O54WuTR01jAxaw01+p8jKHKE6z8+8w87YdjxcsJ88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b+rjZFU9; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC2dvd0009382;
	Thu, 12 Dec 2024 00:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J/hLI
	lHMMR3rdrj0BJCyuaXtkqIguv7j98Sx9Ft7a50=; b=b+rjZFU9Rfr1JO49gbi6P
	kFinGtGcfka7fzKGMGncIFKXVvCrd0ZVTid3eU+AWFky/VHUj1DLJdrj+Axv+WeD
	880BFD8wP2TH0+DplQSXngAoYeztS8a8G/qGbk5iB6PHM2wD44cTcdWCMXVOqVl9
	rs020Ucitx05JsQdRUE0+QF7p/OH2Dd3Ax4ukoGk/1AOnI+nbgbtjKli1SoJoIVs
	iYqLC+vqMiQmgsSH7zWjM4Hic6A7Dl9ycEfcim+6XnFaXDEWhaxBMRJke1LajuY0
	Xe4MODd9ARC1KD/RYmqnIvSJPbEbExs0Cn1IoAjQDVAsx6CPHxiL9LyGHBejTMA4
	g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43fq8drkem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 00:40:12 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv2sEHBYhRvE5KxVBcFHQs+eqg9LBe5/WAFtLNpUWJuVvyWPPd5yERKcoPv76OqkOedXUWZfdkTKNTnoq/G73mGQa7uY+fxV6d72FQb2d+jNon+94jJj2LkG6lej4X+lWAWYOZjGDOYxFAxaOa8mjAz7KBwr3Y+p5rblx9KH0JWFhIzz3+rIuFd2b91NBGpiMGhRcDnOxZnhKEJKxqH+v7HmrOYhKUVrqhhOXLgRycEGjXZpvA5hfB5NKbSBVM6cavUmmUMg1T7AkQHJ5aLTioAG937RqHQaMAfo7fDjOt27p/HzV3LMTXM0+C4pTdPPDjrv+l0MXMjtPiX4tBDutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/hLIlHMMR3rdrj0BJCyuaXtkqIguv7j98Sx9Ft7a50=;
 b=dBWswAQCqhJGhlqE3Pu6NvHJwUkRonRSzZAw4DKJDWSebB563/VUj/SnpLWDmHoRu6I4sIdauL8uY6LfSanIhQ4VNQmMtKjxeEHbFXsDQz/kji2lQRNDNwaIw6QNOmh2HtCvZoa2A0GLvKD5bVWMBaGShRbQgENkx0Ukcx3JmryK0SiDhaMNs/WWUu02OOCVTT0OFxzxlMtrthL8dSsJhErpL5luRuYJXvA5HUKHefgcW7UDdxFRd3c9u0kG2pP7lRxf7ovYEObkmhBv40Gxw4Eeo8zhk4eWWjNFvNLr5b07oLCnqwoVngEAcHCSEFApeGM5GPLLudf/60vhhBv2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by IA3PR03MB7644.namprd03.prod.outlook.com (2603:10b6:208:515::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 05:40:10 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 05:40:10 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
Thread-Topic: [PATCH v5 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
Thread-Index: AQHbSsmKRbbDlj4LjkmgfBpQchiHJLLgRRCAgAHSETA=
Date: Thu, 12 Dec 2024 05:40:10 +0000
Message-ID:
 <PH0PR03MB7141A6861E912A2C3773A674F93F2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20241210060506.10295-1-kimseer.paller@analog.com>
 <20241210060506.10295-2-kimseer.paller@analog.com>
 <b5mhivpuhyfj3knw3w5wmi2kxyyej7cdnh3kd6wyenumfy7qpr@vnfvfj5gsmtx>
In-Reply-To: <b5mhivpuhyfj3knw3w5wmi2kxyyej7cdnh3kd6wyenumfy7qpr@vnfvfj5gsmtx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYTNCaGJHeGxjakpjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTA0WW1NMFlUWmxOUzFpT0RSaUxURXhaV1l0WVdJeE1TMW1PR1Uw?=
 =?utf-8?B?TTJJek0yUTJObVZjWVcxbExYUmxjM1JjT0dKak5HRTJaVGN0WWpnMFlpMHhN?=
 =?utf-8?B?V1ZtTFdGaU1URXRaamhsTkROaU16TmtOalpsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STFNek0wSWlCMFBTSXhNek0zT0RRMU5UWXdPRGc0TnpFMk1Ua2lJR2c5SW5K?=
 =?utf-8?B?dk5IWkRjRXR6YW1FclExZHJWSHBJZEhwWlRVcEZUMlJET0QwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVVnZRMEZCUkVSVGFIaFBWMFY2WWtGbU16RlVkWEZSUjNOTUt5?=
 =?utf-8?B?OW1WazgyY0VGaGQzWTBSRUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVSaFFWRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQlpuQjVZMWRuUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZCUFQwaUx6NDhMMjFs?=
 =?utf-8?Q?dGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|IA3PR03MB7644:EE_
x-ms-office365-filtering-correlation-id: 472b1461-2d8d-4ae7-783d-08dd1a6f71be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bEt3UGZlb2dJMXpwRGVqOWpQcFh2N2VxcmpJUmxTRGQ4ZTM1VmJ6aS9MQ29R?=
 =?utf-8?B?YWk5V0p6MHZDRndSdEhEcWhJOVMzSnNtSm1CTTl5RXdkZ2N2QWFIcnlyNllM?=
 =?utf-8?B?c1Y3RW5xU3V1TlVTMktqYlRlbUE5RlB4SytVWHRsdVB0dlExVEtqVld6WmpD?=
 =?utf-8?B?VFZaM1hyditsVDNocFV2NFlhRGlEenN4YnZ3Q01UQWYyTUx6Ti9SNWtUSTNa?=
 =?utf-8?B?ZjZlVGJraHo3aUtsWE02WGhKeS93WXNteXdrSlUwNE9ya0dmcXlJeXcvSHdO?=
 =?utf-8?B?Q0VJMlhCNm04TGkxWFZYNEFCY2RXU1NZZS9nSURCTC9xQzg3VkY2WHhmeVFS?=
 =?utf-8?B?OXB2R2o0L3A2T20wY3JYUFV5alFvTGp4VUNXS3RFeHY4bDNVVlRxeG9yZWY1?=
 =?utf-8?B?REpaR2VhY3BBczJENXBrcHQxMDk4SnNjWDQxMFQyV0RhQnVNR281ZWd1cmY1?=
 =?utf-8?B?bEhWMEM2NEJOdXEwU2pmSEpvbnRkNGpIUHBXZ0hWQXBSMFJhR2c4elpzNytG?=
 =?utf-8?B?WUlIelR6dGdIa25oVHB6eGN4Rnh6VndQdUdWSG1zS3liMDdta3FkKzd4N2JC?=
 =?utf-8?B?b2Fma2QyRHlUMnk0azUvbm56b2JnclpnblJHZEtFV0RqU01iMHlOYlRGYjNP?=
 =?utf-8?B?K3hqYXVQb3pKektkZ2pXeWpxVjZMeFlyMmtDbk9ZOXgvayt5UGFlYVN3M2I1?=
 =?utf-8?B?Z3l1YWpXdFhTcU1NSzFFYnpWYTFONzBGWGx6UEJmVE0rMXhaMW1YUnpWT2s4?=
 =?utf-8?B?QUZmRy8wVStwTjlwdFlTR3ptVUc3VU5lcG16a1BlcXZ6dEpLeGQzRldRdDRo?=
 =?utf-8?B?aVJzd0xMZzUzYmNNQ2RLRVByRE03UTFEc3FPSkVLbkhRQTRabDUyY3kydHEz?=
 =?utf-8?B?ZENBclZvS2FoZ2gvRW1KT2x5K1hVVmxKSTBrK2h5VE8zNUp6cHNzakJqQnNu?=
 =?utf-8?B?UGdTNzJzZXBqSmNoZ3laRWdlQ081R2tqMHJpbFZpMmxreUFkTzVCaTc5dWR0?=
 =?utf-8?B?ZkV2OXU1ME9yYXE4dDlIYTRaWmF1SkovS2VMdHZaTUlRQ2lsL1RKTjc0ZnM1?=
 =?utf-8?B?T0pwOVRKSW1GK1JhcVFxUWpnenZiK2xGTzRNUkhOYXFXMDhPTUo0d0RRem1K?=
 =?utf-8?B?TmpmV2RMNW9uZm9SdzRVTktvUHllUWh2SURxWFFoSFVFbzhSWjRsSGdCSVBP?=
 =?utf-8?B?VmxvRWZFVWN6bHBZZDVvSHo2NmNxR1c5dDRreGFzY1Q2b1pJNG9IMlFSNmZm?=
 =?utf-8?B?eU9LT2hOazljdWpFeUt0RnJQK1FwVk5SMDhjNlNpUkRJc2FsUkY3Q0srRDVn?=
 =?utf-8?B?U0dVTi9DMHVJeTE5RTJyQjZWLzYxUWNpdzJvYStWaUlVU3ZtZXVlcWZLSGJk?=
 =?utf-8?B?Z284dEJTQ0dWdkp6NWpESTVKbFJxWnZCbEIveFNTc1hWL2Y4aWprc1FiMWdH?=
 =?utf-8?B?U3lnY2RmeWpwK2tTcHh1YllIUm05SXFMa0dRbTJGQnYvQXdUVlc0UVN1NE82?=
 =?utf-8?B?cWQxTmM2SUUyL0Z6WGMzQTZZVVcrK2ZUMHNhbWVHRFVOOFB3aUN2d0FWZFI1?=
 =?utf-8?B?aXFwbzQ0TWp0cmRMcjg0bnB5eWM3RnJJa01teHZteWxycksrc1BRNmJ1TE56?=
 =?utf-8?B?azU2bVgydlcyeW9TajNGTHlHdlhWSTNBQTBBNVQ3NXI3NUpoTzZ2ZGdlYjBL?=
 =?utf-8?B?SXljbnpDM1BMazlEY1E5cGkwQUcvdjZ1c3RrSlFwYlg2L3k3TjEyQkl3aEN2?=
 =?utf-8?B?ZXVCWEFaSWdFdHhFeURmVmdaYld5RnB5TVVNZDZzQmw5bEFhVzg2empOTGxN?=
 =?utf-8?B?ZUpMWU0yOFp2MEZndXlaSk9VRFdjeTB3alR6Q3o4SzNPaUlVUXM1WGhGS1Vq?=
 =?utf-8?B?bm9zQ1BFRzFvTlBDR1F4OXJhVndjKy9td2tZejdaWDZQM3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3VPMkVCbWdqNnFkS1J1RU5iRldwK2xNcUlscHU4cEtkY1JLTGNCODdCTjND?=
 =?utf-8?B?UldLVlIzVEh6RUZMYnZNdit1K3lwaWR0aVpYVUZ1SjNnd2FLZVd5UmlBSURF?=
 =?utf-8?B?U0JsVnoyQTVDQlRxb2FwL0YxOHduMXMvWnNiYVVNYzN3SElHUk9ObUZuT2Ri?=
 =?utf-8?B?T2FVbWUxSXZNZFRvR2RMaWhtajc4NEhTbzdBMzE0QW1tc1dobW44a2JDeXdB?=
 =?utf-8?B?VDFLLzRSSDRGQ2prbEttWGZjN05WUERjODFYQjFmQmd5MTBnTUhwSUVmS08x?=
 =?utf-8?B?dmRmblI3a0JtaGJyelVjMlJKUGxrdVUvczNvbDF5cjhxQWJkM25tUzJNUVFi?=
 =?utf-8?B?Z2puK2RvNW5nUFZvNnNYYUJsU1BVY01wU1dlMG9OaXBBdkNEMTNKK0hoNjRU?=
 =?utf-8?B?SHZqNUFtSExvc2RIYk9DbXcwQm5vTG9DTEtEK2l4WnIxeDdUQm5MeW04UEg0?=
 =?utf-8?B?clhYUnBqMERXRmhQekpXYjllOHQvUGI0dDVGN2hqbXBtZUh0cG9pcFUrT2V1?=
 =?utf-8?B?Rys1YlNUSGwxd3F4TmZXay9DT0ZENzBFcGYzaHZIeU82b3IxaDBzcFgrVWhl?=
 =?utf-8?B?SW1Wdi9qRDdOM2hzMnB0VXRNd0x6YkltTVRHY29UREQwc3dNOE11M3NoUk1z?=
 =?utf-8?B?akpNdytGazdtWTNoOTgxUmhmVnlIQUVFZnVMVXdsc0Z5S09iOEZwQlVoWStU?=
 =?utf-8?B?dlNIZFpvclEyMExMZjlpd1IwNEg5REJldk1kdG5DRzV4SzdrWWN6cjBkREpl?=
 =?utf-8?B?NHo3d0JXN0xKNnQvcTRDdUZhZkhJOFYrMlNTYWNTcFJkL3FwQ05NNWJOK3JU?=
 =?utf-8?B?RUhEMW12dHFKVGpPLzdDKzBLUW9BVk5wLzVPa3hZNGtFNU01ZW9waGZ0TW9x?=
 =?utf-8?B?UWlLY2JGd3FVWFN4K0N2VnJwZEdJTkc4b0hJL1BzMHNOZjBlWmlacnlkVnZr?=
 =?utf-8?B?aXkzaHJJTjg3RkI2VE5rVi9DUWZ3OGNtQlZVeEFsSGZqVGdYV1dnbkhjdHhD?=
 =?utf-8?B?Y3Qrcm1qU3hXRzNSUUdaKzlmY2lzSUwvZ25FZXNBN1BGd1l6Y0dUMGp3M2tw?=
 =?utf-8?B?NU0zWmY3Zkh6UXQ3UFpPVmVEeWFiOElPMzJrNDBlRTEycFhkaHVoa21nWnRH?=
 =?utf-8?B?bmprTkxjOW04VkJKditWRUIva1ZNcUl1SXgwcDhBU2VZWXdjS3BDUlJ4TGVB?=
 =?utf-8?B?ZmtDaitSaXNNK1FwVy9aOStVeitNVGY1YVRKL1QyOG1Qa0VDUkE3bnVzRkZN?=
 =?utf-8?B?cmNTTzZsY1NoRGlMOWNTVHJoUFpnR0o4M1pQOU5TbUxnOUpkL1JSQ2JRMkdh?=
 =?utf-8?B?NFRLY1hScytwQUx6NkVuTUJteU1lK0lRM1lsU2haV2xUbSt4UjJHcWxrTDhL?=
 =?utf-8?B?TERhSmIya2VTNzE1S2hmK21wYisxRVhOR0xkTDNHNlF4V3RJcVVwMWNYT2hk?=
 =?utf-8?B?UlNpR1JWQUVQdXRURVRNaG1OTHFZU3JWckErbUpsMllBQkRNdWlUbzhkbUF6?=
 =?utf-8?B?VUk2S0sxby8rQXRVT3ZWUTg1VHk0dktKdkdvdHlPNzA4cG14RS9FOXlNQ2FZ?=
 =?utf-8?B?V3UrcTJrN1ladEVqRUxzbURWWm1jNmhNZG9JTXdDUVdOUmN4K0V1VW5pRW0r?=
 =?utf-8?B?SGdZZXo3dXIwaktYQUxDRnA0UFVqQ205S3lqVE0rWkxQOXFzbkg1T25PWkFW?=
 =?utf-8?B?QWJWTi92YUcramxrcHBYNWVyNGtqZFZzbUpCTDhCQitZZVVsZ1ZkMFEvYVRT?=
 =?utf-8?B?STlXZVljSzlMWnVJeWh5dzB6Rnc1ck9DcFJlemVuRjYxakVpakQ1TE92Vndn?=
 =?utf-8?B?azZ0ZS9sdm1yeTZUZHlvdUhDK3BVb2VHKytjeW5KM2M1V1FIM0hUdi9KSnFE?=
 =?utf-8?B?aGFPNzU1NTViRFpkYUxJb3hSYjZwdHk5QlVsNjRGLzVFVTZFNG1CSlJWTlpr?=
 =?utf-8?B?U3Ard1F0dFBaQklNTHMrVndHeVhHYlNEZXcrMEk0VkdYb3ZqS3cyQVB6VFRh?=
 =?utf-8?B?MmIwMG1USVJYYVR5Zmk5OXhwTG1KZHZ4QkdPdUlMNVdDdG9McklDdGo2ZW5w?=
 =?utf-8?B?VGpLOFpyb1ZRRVhmS1Mrcmg0UnBrbUxKZkxUamdLYmJONHhWdzRkb1pWMm81?=
 =?utf-8?Q?3CB0nCTFplydFuY0OmS0+xFyn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b1461-2d8d-4ae7-783d-08dd1a6f71be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 05:40:10.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atR23uivKl9kUx2EwiTRYOs76YJMd2SdwKbW+UDBy7zfAODjq/tAiaiRYmoEHrqUmdZ7vEjiGI4z7MEnZYt/wAxFGUuzlPBNWRu4NA2kGEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7644
X-Proofpoint-ORIG-GUID: kQHVw5iNkDTu7oJY1hNj-IOOFeYSHmzP
X-Proofpoint-GUID: kQHVw5iNkDTu7oJY1hNj-IOOFeYSHmzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120037

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNlYmFzdGlhbiBSZWljaGVs
IDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERl
Y2VtYmVyIDExLCAyMDI0IDk6MzggQU0NCj4gVG86IFBhbGxlciwgS2ltIFNlZXIgPEtpbVNlZXIu
UGFsbGVyQGFuYWxvZy5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsNCj4gQ29ub3IgRG9vbGV5
IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWlrZSBMb29pam1hbnMNCj4gPG1pa2UubG9vaWptYW5z
QHRvcGljLm5sPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IDIvMl0gcG93ZXIvc3VwcGx5OiBBZGQgc3VwcG9ydCBmb3IgbHRjNDE2Mi1mL3Mg
YW5kDQo+IGx0YzQwMTUNCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IEhpLA0KPiANCj4gT24gVHVl
LCBEZWMgMTAsIDIwMjQgYXQgMDI6MDU6MDZQTSArMDgwMCwgS2ltIFNlZXIgUGFsbGVyIHdyb3Rl
Og0KPiA+ICBzdGF0aWMgaW50IGx0YzQxNjJsX2dldF9pYmF0KHN0cnVjdCBsdGM0MTYybF9pbmZv
ICppbmZvLA0KPiA+ICAJCQkgICAgIHVuaW9uIHBvd2VyX3N1cHBseV9wcm9wdmFsICp2YWwpDQo+
ID4gIHsNCj4gPiArCWNvbnN0IHN0cnVjdCBsdGM0MTYybF9jaGlwX2luZm8gKmNoaXBfaW5mbyA9
IGluZm8tPmNoaXBfaW5mbzsNCj4gPiAgCXVuc2lnbmVkIGludCByZWd2YWw7DQo+ID4gIAlpbnQg
cmV0Ow0KPiA+DQo+ID4gQEAgLTI0OSw5ICszNTYsOCBAQCBzdGF0aWMgaW50IGx0YzQxNjJsX2dl
dF9pYmF0KHN0cnVjdCBsdGM0MTYybF9pbmZvDQo+ICppbmZvLA0KPiA+ICAJaWYgKHJldCkNCj4g
PiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gLQkvKiBTaWduZWQgMTYtYml0IG51bWJlciwgMS40
NjbOvFYgLyBSU05TQiBhbXBlcmVzL0xTQi4gKi8NCj4gPiAgCXJldCA9IChzMTYpKHJlZ3ZhbCAm
IDB4RkZGRik7DQo+ID4gLQl2YWwtPmludHZhbCA9IDEwMCAqIG11bHRfZnJhYyhyZXQsIDE0NjYw
LCAoaW50KWluZm8tPnJzbnNiKTsNCj4gPiArCXZhbC0+aW50dmFsID0gbXVsdF9mcmFjKHJldCwg
Y2hpcF9pbmZvLT5pYmF0X3Jlc29sdXRpb25fdXYsIGluZm8tPnJzbnNiKTsNCj4gDQo+IGliYXRf
cmVzb2x1dGlvbl91diBpcyBpbiBwaWNvdm9sdCBhcyBmYXIgYXMgSSBjYW4gc2VlOg0KPiANCj4g
MS40NjYgdVYgLyBSU05TQiA9IDE0NjYgblYgLyBSU05TQiA9IDE0NjYwMDAgcFYgLyBSU05TQg0K
PiANCj4gUlNOU0IgaXMgcHJvdmlkZWQgaW4gbWljcm9PaG0gYW5kIHBpY29Wb2x0IC8gbWljcm9P
aG0gZXF1YWxzDQo+IG1pY3JvQW1wLCB3aGljaCBpcyB0aGUgdW5pdCBleHBlY3RlZCBieSB0aGUg
cG93ZXItc3VwcGx5DQo+IHN1YnN5c3RlbS4NCj4gDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0K
PiA+IEBAIC0yNjAsNiArMzY2LDcgQEAgc3RhdGljIGludCBsdGM0MTYybF9nZXRfaWJhdChzdHJ1
Y3QgbHRjNDE2MmxfaW5mbw0KPiAqaW5mbywNCj4gPiAgc3RhdGljIGludCBsdGM0MTYybF9nZXRf
aW5wdXRfdm9sdGFnZShzdHJ1Y3QgbHRjNDE2MmxfaW5mbyAqaW5mbywNCj4gPiAgCQkJCSAgICAg
IHVuaW9uIHBvd2VyX3N1cHBseV9wcm9wdmFsICp2YWwpDQo+ID4gIHsNCj4gPiArCWNvbnN0IHN0
cnVjdCBsdGM0MTYybF9jaGlwX2luZm8gKmNoaXBfaW5mbyA9IGluZm8tPmNoaXBfaW5mbzsNCj4g
PiAgCXVuc2lnbmVkIGludCByZWd2YWw7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gQEAgLTI2
Nyw4ICszNzQsNyBAQCBzdGF0aWMgaW50IGx0YzQxNjJsX2dldF9pbnB1dF92b2x0YWdlKHN0cnVj
dA0KPiBsdGM0MTYybF9pbmZvICppbmZvLA0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4g
cmV0Ow0KPiA+DQo+ID4gLQkvKiAxLjY0OW1WL0xTQiAqLw0KPiA+IC0JdmFsLT5pbnR2YWwgPSAg
cmVndmFsICogMTY5NDsNCj4gPiArCXZhbC0+aW50dmFsID0gIHJlZ3ZhbCAqIGNoaXBfaW5mby0+
dmluX3Jlc29sdXRpb25fbXY7DQo+IA0KPiBJIGJlbGlldmUgaXQgc2hvdWxkIGJlIHZpbl9yZXNv
bHV0aW9uX3V2LiBNaWNyb3ZvbHQgaXMgd2hhdCB0aGUNCj4gcG93ZXItc3VwcGx5IHN1YnN5c3Rl
bSB3YW50cyBhbmQgMS42NDkgbVYgKGZyb20gdGhlIGNvbW1lbnQgYWJvdmUpIGlzDQo+IDE2NDkg
dVYgKGZyb20gdGhlIGNoaXBfaW5mby0+dmluX3Jlc29sdXRpb25fbXYgdmFsdWUpIDopDQoNClll
cywgdGhhdCBtYWtlcyBzZW5zZS4gSSBqdXN0IHVzZWQgdGhlIGFjdHVhbCB1bml0cyBzZWVuIGlu
IHRoZSBkYXRhc2hlZXQgaW4gdGhpcyBjYXNlLCANCmJ1dCBJ4oCZbGwgY2hhbmdlIGl0IGFjY29y
ZGluZ2x5LiBUaGFua3MgZm9yIHRoZSBjb3JyZWN0aW9uLg0KDQo+DQo+ID4NCj4gPiAgCXJldHVy
biAwOw0KPiA+ICB9DQo+IA0KPiBPdGhlcndpc2UgTEdUTS4NCj4gDQo+IC0tIFNlYmFzdGlhbg0K

