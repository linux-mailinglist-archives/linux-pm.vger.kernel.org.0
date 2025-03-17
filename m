Return-Path: <linux-pm+bounces-24151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AEA64C0F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5891B1882E3E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E36235C15;
	Mon, 17 Mar 2025 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="c1ONIauP"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011063.outbound.protection.outlook.com [40.107.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D938DD8;
	Mon, 17 Mar 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210073; cv=fail; b=kqQoVpHcQVNdE37swQvVaFsmdz9YbRLykchq8KjYrCJXh6gn2UXPwaSJezsif+UE8q9iMSYXn/RCZfeACxdL3W6aTUUwpT29sgtwouUIvDeH15+mEWo2RiFw7oxxk6l/zu5IDyaJchnK7W0hddWf50IMuMSJqundzXrY040xz/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210073; c=relaxed/simple;
	bh=whphxOWdeiMz7ptZg7XM5yxKMuhuzLQwG50GmXrz5UU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwk4H4gGDHNUWJAYbUJqCjvZ8viNhUzaj3tS7AnX2fBZhR/VdubF+9y28Y0/JCUX0qV9Uc2rOTD1xeMpeekfOYmY7uO5h65z0kUC8b0IJ+13SkH5EdMxgp3iJg/XKFf+Uz40YzvCK9y3z6DCDN3bvPK+7EIqA+5mSuAuZFQwFn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=c1ONIauP; arc=fail smtp.client-ip=40.107.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuM17N1h+WMRpMUPOndsIMLvFnMjVkYe0YrC2N5IjS7DxtSy6eQVF85AZac6mLIpItqFXfbnEVZJMCZ0hYLosylMJzyOarK9/q1poX62wpB5dw8bnl4Zr7Ruwfjw+h+O+mJYMWx3xaxHKalzA930PjlQPDpvbc4nnx3Vn1RxpGdELpR1m5BVQV1DV3okHV1C1gP+sxvNIcHfpPM6AFaJLE0QPAcmRpso5qXFdfkrzhpj+OfGCu8NtCQzLRptZH0xYxHgOEz+1qIu9cjjMJBw2Vq5KFOetO4ERHSLlIEQK6U7ZFHjfMWkRUEz0CoP+90ujFRylHGb/uaBpmirijbPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whphxOWdeiMz7ptZg7XM5yxKMuhuzLQwG50GmXrz5UU=;
 b=mM8BgXNB9oh/JBl9VZ1jooku/LzpFLK4k40LhD/J//NkLtB44Sc2neR0OEtkBxv8D4+3rMNV7vICQW0hd7/U4mieWHsDg3V04EZfhw90d2BcNbdt0CqMlRVVwvycbRfFVlD+q76Hj6uhBYDImledszX8W2cRt/v9RQVJQqzrECU1ce0ytcpZ2eqg/mcXsv3s3WLoS4OWzEaMmEnoElZKoHUapOMhpGJznH0Alhj58egkJjJ5pKULo13+5dOh1Y9f89TCWd+QFvSosxczh4r1KYdhOdfllRbMsN3MuG605EW5GF5tPXr9J/TTphEcz9pf2P6hJyAYetlLh2xHVEVetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whphxOWdeiMz7ptZg7XM5yxKMuhuzLQwG50GmXrz5UU=;
 b=c1ONIauPPaNYWT1R5ktbkR3t4y5yVx38omuhBuUvYqT8RCmdQMNS1wEZELU/hbvzZV0RYTjRGoHRsBqBZ3hFkybKLlk3y750l8xsw5e4Ocq+uFmwRh7jphOlUBKzahBmIKVwtdQM9MfbgwK11Qb9jkSci5GKdFZLtmQT9a3/634=
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com (2603:1096:604:13::17)
 by OSCPR01MB13599.jpnprd01.prod.outlook.com (2603:1096:604:380::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:14:28 +0000
Received: from OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b]) by OSBPR01MB2775.jpnprd01.prod.outlook.com
 ([fe80::54f7:9a51:ae47:185b%2]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 11:14:28 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "geert+renesas@glider.be" <geert+renesas@glider.be>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"magnus.damm@gmail.com" <magnus.damm@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"sboyd@kernel.org" <sboyd@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>
Subject: RE: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
Thread-Topic: [PATCH v3 6/6] arm64: defconfig: Enable RZ/G3E thermal
Thread-Index: AQHblYIVSDfEEIBQHUewX0DdQ4ozEbN3EyWAgAAYZdA=
Date: Mon, 17 Mar 2025 11:14:28 +0000
Message-ID:
 <OSBPR01MB2775B7252468BCE234BFF7D5FFDF2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
 <20250315081225.92118-7-john.madieu.xa@bp.renesas.com>
 <20250317-bipedal-inchworm-of-poetry-b60fc9@krzk-bin>
In-Reply-To: <20250317-bipedal-inchworm-of-poetry-b60fc9@krzk-bin>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB2775:EE_|OSCPR01MB13599:EE_
x-ms-office365-filtering-correlation-id: 7bc86ffa-896e-4dd9-307f-08dd6544e22b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUxwR0h6NG91SjhIaTRlTVVVZW9JWi8rK1FrS29qWkNDaFFGZEhSbXVTUndx?=
 =?utf-8?B?MVBFZG1LTG9neXlMbWg1b0Z3YWVUa0d0N2ZMdjRLKzJKdFlqMUNTbkxWeEx3?=
 =?utf-8?B?YUVwb2RtZS82eHNWM05OUXpXdms2RkwwSnYzd0d6a251dHpNMlh4VFVoZ3FE?=
 =?utf-8?B?ZUUxYW1UNHlMakJRb1liV3FPVUZqcy9ySkFNQ3hmY0lZQzR5NnFmbXpEMmF5?=
 =?utf-8?B?aExzZFNaTkhsZmZvT01PdlFrWGZLaTJJZTVvYzlmY1RieWlvRTNVVkZjMmtN?=
 =?utf-8?B?Snd3aFJSS3BUM3FFYUZqalhjOENhNC9FTit1UTJrdHVVamNLUGZHRzlOTU1S?=
 =?utf-8?B?SllSZjQwb3VmcFVhQmJJbGRlazcrRWlMNEd2ZHZLZTJqL3ozZDdYRy8yK3dn?=
 =?utf-8?B?TndCZlplTkIrSS9wdmQzWkVIMjNUMkUwRUlBbnY1Sk02ZUtxZTJuRWpsN1Zy?=
 =?utf-8?B?djMrTE1NZUVDVGsydDVtVW10WXhkeVc5djFRZm8wTUFjSk1qTXdLRDBleDhI?=
 =?utf-8?B?RERJM3cyVkdZTnV1ZmcyMWdSSG9rWnYzblJiV2YvNzhCWGpJdnhJV3FaSjVZ?=
 =?utf-8?B?RzljS1lXeHEwRmY5YU1PelhJSHRqeVV4amE3Y1FsMXI0ZHZlenF6VkFzK2o5?=
 =?utf-8?B?emlEVnBHNU9vTXdzWlljRUFFajNNNkdiK1N3cHNFSzZRVVp2d1ZtYWdCd1Fi?=
 =?utf-8?B?eUNtaWxDWTlCbHFnSTI4ZmVUdXpSL1FjcFhsZzcrc1RQR1pCME9IVjNTUldw?=
 =?utf-8?B?dVpteE5tYi9MdzR0L0trNDltYk1ySGpubGJZelBkRU1GajRLSHpDY1NyZnZ1?=
 =?utf-8?B?QmxtemJVVFE1Uml5WDQ2UmxZcS9JbDhLekk5UnlqTktXOVRpOUdNNzFYV0Fp?=
 =?utf-8?B?RStDR09jSFpjbmtiaGkwcnFlMWhuTXZ3ZHlSM3IraWo4TXB3dlA5SVJvY1hC?=
 =?utf-8?B?VFFaOTNJTWF5T0Z2NHl5YUtnTitqOHBEdDlTQ3hnMDVBOG00dXdQdEJTNUNy?=
 =?utf-8?B?TFZLeHVRS2k3cjNCL25sNldmUGdTMGFZUExoM3hvcWdiem10RWdMRHlZUXZs?=
 =?utf-8?B?bUNMVDJjK2p4elYwQVE2SDVEc3RYaUhTUmMwa2cxWGxMdkxRNVFIVnRQME5M?=
 =?utf-8?B?UUYxNnFhUE9QN2gvdmtGSEgrSXFEQWN2VVZOY2lyWXFrRzJIcnlweGFUemRs?=
 =?utf-8?B?UDRqcXI1VEhQZHIvZHh6VEkzOFM5cFNoVFY0ZmFqM0w3S1ZTejVqVksxT0xS?=
 =?utf-8?B?UEIzcVhUUFRDZ0FKNXA4SDRLRy81Q2RRWUZyUFJwVGptOUMwYXE5K3hkS09T?=
 =?utf-8?B?anFYYXh6SWFyR1hqMlBSTHgrYWx6T1NETWdDb24xSyt4OTFwbFNzQUhITENv?=
 =?utf-8?B?S0NyQVlyTWw0MDUvTkZHOTlKUTlpdUtqditGdFh3SVJTQnlieFEwZTQ1VWRW?=
 =?utf-8?B?dmpzQXRhbFhnSGtoeExGN0pUYW9qZ3ZnSUxENllJaHdlVGdiYmE5RmpMUEs5?=
 =?utf-8?B?TUV2NGg4Q1JUYmFQMWRNRkJpY1Vza0FHa0ZlelRodmhPaWo2QXlnSkpqUlBo?=
 =?utf-8?B?bkcvTXFmRkdVQ2c2MnJjbXl1b3FKSk1uRDg0M1h6ZGlBcGNCWFhXd1d0ckxw?=
 =?utf-8?B?NjZhWjUvTDM0TVd5dnY0UFNXRkwxa2d2Mi9IS3A3L0FRQzhtZWNQbDBFN2tQ?=
 =?utf-8?B?N010TFdreXV4VURDbk9KZGhSYjZsVHpNRjdPem9RYW1qanpnSW53RkpNT0pL?=
 =?utf-8?B?SmhNdUtMZHM2MDlxN24yRCtnaURIdWhQWWNiTHZqSGVMamRndzlJWUZubDcr?=
 =?utf-8?B?M0M0d0EveEhmUmVnNmVKbVN2ZVZBZXFnb25xMi9uaFY5bFIwTW55TXZ5S1VE?=
 =?utf-8?B?M21sZVhCVEFZeUgrVDVNYVYyYW5KRUJNSGl1SkFVYk5lYlJqQkJBUi9pQUdj?=
 =?utf-8?Q?5hvmUdOl7GcCdrJizbehzwLzAOroonld?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXBWRVljY0c2TVFzbUIvbTlnenhaV1NLczVJNXFxaUpDZHZQNjFpWXpha0dm?=
 =?utf-8?B?bHEzQ1RoRnVIbVo2QklEN1FSVlNmRnB3SjV3TFI0NnBkWVEvQnpYWlNBVlZ2?=
 =?utf-8?B?YWhxek9NWFNna0NnLy83b1dQSk9PeEhoZWNvSmFoU3RId1ExUlpPdWR4RXI0?=
 =?utf-8?B?VW5EaUd4QkNEc3ZHbEp4dFVWQTRIdUkvMmpaY2tnRkpOM0lHZWRiTG1LWGJW?=
 =?utf-8?B?QjNJa3lZNk0vOUgrVDJ4eVFjb2NSZG1BNXA4NEJVeHF5TlYyTForSjd5TmIw?=
 =?utf-8?B?ckNqdmtubngyVTZrRWZCNzJXY1l2V2Q4VUl6c3o5ZUwzNEozMzJCUmpZa3Ny?=
 =?utf-8?B?K2hJcE1ibzFWcC9OVzBRYWIyTmNSNWUrU0FHeEFtYzlLc0c0MnJMVFk2cFhX?=
 =?utf-8?B?aUpWbmVxQ3pIa1lnNXV0ckh0NlZ2Z1RZU3NDVFZWTjFuRS9VT2p3Z041bzF3?=
 =?utf-8?B?WXhLS0JrTzJzYktFQUdWdDJjdkg2WTloMDk3SUI5OTFtOEVkdDNxNTRHVDFk?=
 =?utf-8?B?UTJXTktXdCtSemlqWFovcUk5OXRKYVVSTytUTUlZRjNxLzlKYXNUL2tUeFhV?=
 =?utf-8?B?d1VRVkNVN08wUGM0RHVpcElBUys5SnQ1VGowL2NuTlpMaUZpa3NORHBvMFJL?=
 =?utf-8?B?R1lCM1dXWHFKVGdOUElGb0NYdXJHbTdGbmVpNHdoQlBwUU1zbEtaNmdmeUtI?=
 =?utf-8?B?RWgrbWlpOVcvMGhpYitXVWFza01VYlVEbFJ3NURTM1lpSVhINnNHWnE3K0Iz?=
 =?utf-8?B?QnVwNUljNFRMRWU4d3RRa2YzMWE4SWJqRGdjQnlBTit5MklSYU9EdXRCSTE3?=
 =?utf-8?B?cjNHRkdMWkxwTWFycDBZRzR0Sk50Y0lRdVhmaklOWVhOY0RibG5vekZ2UnFQ?=
 =?utf-8?B?UnNld05NQVN4NWVBUHkrUXdGUk9nQ3JqclhpSml0cisraitNV2pVeTJ3eXZF?=
 =?utf-8?B?Rlk2RWNrZlNhcUNFc1krRGcvd2I4MFY3OE5hb05WaG5zWVFrd2pOb1VnMkF3?=
 =?utf-8?B?NURUVEo2VWxxTThNOUFCZVl3RHFGcFNBNko5TEdJYTRRaGdUSUk2TWJVZEx2?=
 =?utf-8?B?MWh5T0dkbnVXSHVkQ09uM2VWMUl6RVFxMHBrVFNEaVdBaHZUUlVOcjVtMk8v?=
 =?utf-8?B?RnRhWnN0Vmg3TWtpdE5CV1VldnloQlFhdTFab1V0aEpaTTBjdyt4T1RqRFQ3?=
 =?utf-8?B?VmdQRlZzT3BzNkI2UXozNTdQaEpvRDk0VVZyRFVadlYxZEhVTG5aRS9JUUNp?=
 =?utf-8?B?VVRUM2NEL2Y0VmQ4MlE2MkVhck15eWpQNjArdVhmcVhSczRCcFVKVG5GZXds?=
 =?utf-8?B?S3RwaDdGZ3pGbURPUlFmblp3V08xL3VsTGZEQzVQeG04UnFHYnZWOFhKeEZm?=
 =?utf-8?B?OWtOMnRxME1VcFFYZXd0WVRUbVFGYUdOaEI5Tkh5UEgrVFdUTENQZXVMOHA1?=
 =?utf-8?B?ZnNzQ201YnhJNkxtSEo1SlVGNGpLNWd5UUw3eUs4TDlUMm1Vb0wzNDRXMnk3?=
 =?utf-8?B?WFZseUNuMnlkb05xR1BVdC9tdTVWQkp2eXpRalI1d3NBbURQWFBOTU5yc1RP?=
 =?utf-8?B?Z3lmWjN4dFFuNC9xMXRUVWtOejl4cXVoQUEzUHNiSFZ6eEZEdllWcUJMbk9z?=
 =?utf-8?B?aklTemZlVW51aFJHYXdrS3NITzJidUFFd2hiNkRvSzVpRFg2N2xoT1hvbUVJ?=
 =?utf-8?B?SWRmdFROc1pEOU1ucmRiZ1cwbHNGK2IxUTZpTWJmZ1JVdlF4NnAyLzZJNnNJ?=
 =?utf-8?B?RGFPWXRFVHU5amlPWU1iN2N0TWdSOGUvRlk0NW44TVI0dmNRRzhXSEs2SDJF?=
 =?utf-8?B?WlN2eTRsekIraFNsRnA2NG9BQjJlRExoUi9vSFRHUU01Q095dXdCaHVwMCtQ?=
 =?utf-8?B?dWduWkwyYkFOMWR1RFo1WjZtUWpCMlNaa21JWlBuZHJlSUNlM2JoMW5LWnQ5?=
 =?utf-8?B?TVQ3RkRpQU9oT3R2VTNEU1lJaTBYaFVaZzJiUVcxdXZLajh5eHlRMS9Zck5r?=
 =?utf-8?B?MjhKbUQ5TEZpR0lsMVVmMUdPM3hkVCtNbWYrcTlqNzBRMjF0ZC9pWlZpbyt4?=
 =?utf-8?B?S0pseHEwSEtXdVpKeTd3eDBhNmh6QkdBcGtLYmx2bHplbU9Qd2JCYWNkT3Vu?=
 =?utf-8?B?VEMyT0NENHhIcm5veDRKdlVtRlJZM0NrQlVTQmVvWitmT29rTDJmVC9UUE9J?=
 =?utf-8?B?dUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc86ffa-896e-4dd9-307f-08dd6544e22b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 11:14:28.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgybbByoaZ5D/rwlwHQCYP4PoS/QtUQS0ZEcctK1wmkvJ/lLF72JIgV9/zCLUb1NHlcB2r+tST9ZQ+vwParOWd43WECiOnC3mK6cem1Rbnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13599

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDE3LCAyMDI1IDEwOjI5IEFNDQo+IFRvOiBKb2hu
IE1hZGlldSA8am9obi5tYWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgNi82XSBhcm02NDogZGVmY29uZmlnOiBFbmFibGUgUlovRzNFIHRoZXJtYWwNCj4g
DQo+IE9uIFNhdCwgTWFyIDE1LCAyMDI1IGF0IDA5OjEyOjE2QU0gKzAxMDAsIEpvaG4gTWFkaWV1
IHdyb3RlOg0KPiA+IEVuYWJsZSB0aGUgQ09ORklHX1JaRzNFX1RIRVJNQUwgZmxhZyBmb3IgdGhl
IFJaL0czRSBTb0MuDQo+IA0KPiBzL1JaL1JlbmVzYXMgUlovIGFuZCB3aGljaCAqdXBzdHJlYW0q
IGJvYXJkIHVzZXMgaXQ/IFRoaXMgaXMgbm90IHlvdXINCj4gcGxhdGZvcm0gZGVmY29uZmlnLCBi
dXQgYWxsIHBsYXRmb3JtcyBhbmQgYWxsIHVzZXJzIGRlZmNvbmZpZy4NCj4gDQoNCk5vdGVkIGZv
ciB0aGUgZml4Lg0KDQpIb3dldmVyLCBtb3N0IHRoZXJtYWwgZHJpdmVycyB1c2UgU09DLXNwZWNp
ZmljIGNvbmZpZyBvcHRpb25zLA0KYXMgd2UgY2FuIHNlZSBpbiBhcm02NCBkZWZjb25maWc6DQoN
ClsuLi5dDQpDT05GSUdfSU1YOE1NX1RIRVJNQUw9bQ0KQ09ORklHX0szX1RIRVJNQUw9bQ0KQ09O
RklHX1FPUklRX1RIRVJNQUw9bQ0KQ09ORklHX1NVTjhJX1RIRVJNQUw9eQ0KQ09ORklHX1JPQ0tD
SElQX1RIRVJNQUw9bQ0KQ09ORklHX1JDQVJfVEhFUk1BTD15DQpDT05GSUdfUkNBUl9HRU4zX1RI
RVJNQUw9eQ0KQ09ORklHX1JaRzJMX1RIRVJNQUw9eQ0KQ09ORklHX0FSTUFEQV9USEVSTUFMPXkN
CkNPTkZJR19NVEtfVEhFUk1BTD1tDQpDT05GSUdfTVRLX0xWVFNfVEhFUk1BTD1tDQpDT05GSUdf
QkNNMjcxMV9USEVSTUFMPW0NCkNPTkZJR19CQ00yODM1X1RIRVJNQUw9bQ0KQ09ORklHX0JSQ01T
VEJfVEhFUk1BTD1tDQpbLi4uXQ0KDQpIZW5jZSBteSBjaG9pY2UgZm9yIFJaRzNFX1RIRVJNQUws
IG9yIGRpZCBJIG1pc3Mgc29tZXRoaW5nIGluIHlvdXIgY29tbWVudD8NCg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KDQpSZWdhcmRzLA0KSm9obg0K

