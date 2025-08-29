Return-Path: <linux-pm+bounces-33438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A8B3C3AC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC89A049F4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 20:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A0B27603A;
	Fri, 29 Aug 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QkuRFKs8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="b+DfDcUt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CMU95nMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B832750ED;
	Fri, 29 Aug 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498406; cv=fail; b=PyF2msDm8nsVbtDsWP+sh4oYTmzGnh9BwmAuY3LBSPBPdxcOtO8vpnKYiNmgPEEqXXMTIq+IuqV4s+ICpGnRHugGEa+ehfZgMdnA2GOSzZ/OODLCpkE6VO1Vt83RH8JQwCoX5hXKROjnTPGVv3mWKye/6yXK+dTFfqoQQwLK21c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498406; c=relaxed/simple;
	bh=OHFS2mRltZkAMJ/gEkYIH5EHFnHR17wXp4KxkAijHuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5sbaghMXd3nF/wODb1l2OkY1HBLfE5i+xeGrgYpCVuGEyC9oKUkhfetzNog1MlyH+IjxHrJdIEE6Lv8SnDMnuUYWixQvdUBa0kS21AqOo/9nY9SYdTu3ER6Rc2dFCyydb6dsdg0eqv291VVWRAcz3Ig0W5ohs7j+ffJohWvgNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QkuRFKs8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=b+DfDcUt; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=CMU95nMc reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TF945h002837;
	Fri, 29 Aug 2025 13:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=OHFS2mRltZkAMJ/gEkYIH5EHFnHR17wXp4KxkAijHuM=; b=
	QkuRFKs8yWl2rhvZwouU3BujAT9PzPFTOz2ocwh1QkYK8FO8zto7FIetRuh4gnEQ
	BVJ293u0yYUwdiOOKCL+RPiebqOKX7wVhDzKMBkVDLz/DvzMjMmDyZUn8VQ6u6ZY
	dSuZUtSVBJINBdUthsj6vUY+WALREdK0YEdER4s0TJYxyqp5/2CP2ZfdcRqH0T+F
	FkzWn/jo1aKfl09YtWiUkH/7JdxvyjatHIjU69qYGz5z3EIemZSMj7cwSCPZMV5x
	CmzJmk87m2il/G1PfwvhlUQkagZCmtbsUhSLXx7i9UuVzUkjCfe70TSPpJlSvwjT
	PilM3ZztVmGWScGBE4zTEg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48u2kyvmpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756498393; bh=OHFS2mRltZkAMJ/gEkYIH5EHFnHR17wXp4KxkAijHuM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b+DfDcUtoGrrpxb7CimdXzUJtUGZWLMmtVjguwJ0EP5KFmzu9aoivlqjQ1p9e6BXt
	 Y7DQ0N3gsETlhh5H0XVkGx5DV0ldtfDRq6gcRcSDlePIpxw7IoGkM/BkYuXBhh/sc3
	 1vO0CX2V8rakfeujEic4010JJ7r9xkn9oXUPGfd5sYbUsdfSZgkWccDcNN9KLI4a6c
	 otjRqUnlGxATmelFll7N7bjaHwMJvylGCnYRO2PmzlDYp9m33Cj7ip3WpZJfqDPhfG
	 Pn5KjJXU7ipGLbhYhweCPcYzBrfERKc9nDd2XWIkx9V0vPapdRISef05MYlZLzwuJD
	 AD4QGLWGurTIw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8D40840727;
	Fri, 29 Aug 2025 20:13:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DCD3DA0083;
	Fri, 29 Aug 2025 20:13:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=CMU95nMc;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3013D40596;
	Fri, 29 Aug 2025 20:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+32JkmoiWesq2XIqit5SL/JNRDoc+HvyFGkSC1IHwud3DJ8RGTSZHD8G6cHb78tm4VKOU+eqgLi9upGAkHsvYHDEMAS5+SrIcyQnTKNJ/5ibD0RWKe6eZ2ppVyPgnt0dM8Mg6CWaKGTQ8dHTLnu6wEmuiUAGkqNCTnLsN8IjhGl1bdwRbAmANEwaJ+u7r89oHmP7HJtiAkEWozhKjw+vdvJarJf1SgQE+Ug0azjdqY6hrA4FFwW/FXhms8faCAuyzclSK77GMeeFp6QlG7/SfJGRgIziZC2GcBBH1ZmzRgB3nhpFGYWEG9Yv3eEW4iuwjynnjj6+Zyo80wj8N0wBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHFS2mRltZkAMJ/gEkYIH5EHFnHR17wXp4KxkAijHuM=;
 b=BzdLKzP7hVNyMBFMEhYppf3DScgrWnvtJ5ceCRTJ6ZnkBNwvyA2h74G7GJv4l53REA/+D4F9EQ6jswVKMlAOFFeO2dSadYqR54SMTp0AkrWfR49agKqqpzu0HwAbq0mDv13SrtYqHzBxUVD2ArndqeV5RbBQl6ixrtNKmeRWisuhyuofUUSrCIdyBAYK6pFEAprrGU0jlk81j64tsnWaaWCtOfbrO1CIBN6wgBwVKumQ6ysGiVYOVnof+eWob1jDtDjXRaji3BTu18layRgq5pnyMcxhK0w2SWlTFJ3i+SWMZ4dv8MUHsp8a1yn575MTgX39ViuQk01hlQZMpACYYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHFS2mRltZkAMJ/gEkYIH5EHFnHR17wXp4KxkAijHuM=;
 b=CMU95nMcwr18VT0DS/iGFPdeKsoqFT4KlVB+5xz1FLTDEB9Ds6wD0qiQOpBuzWS2HRs+zzY90Wgj2eyB4cRYTU24hakgUHszdpr982JPC5+Q7l4ToINStelfDdykMzCgOUc5dkJiWkQiz+pDrZYxpEz0PSE9pA8Nsx0VrRqqpFM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 20:13:07 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 20:13:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        ryan zhou <ryanzhou54@gmail.com>, Roy Luo <royluo@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index:
 AQHcFpwLhCI1/x1c70ew6xjKTgeHrrR1Q/eAgAFHIgCAAAwMgIAARF6AgAHzEACAAAu5gIABKNKAgAAFRwCAAA0MAA==
Date: Fri, 29 Aug 2025 20:13:07 +0000
Message-ID: <20250829201306.rchlatbdxqy3xiki@synopsys.com>
References: <20250826150826.11096-1-ryanzhou54@gmail.com>
 <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
 <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <20250829190731.gx2xrgdz3tor5a2v@synopsys.com>
 <CAJZ5v0gY=w1G-R1EdpJi+Hm5+YmDWY2yJDHgVVVeOvQAkO1ffQ@mail.gmail.com>
In-Reply-To:
 <CAJZ5v0gY=w1G-R1EdpJi+Hm5+YmDWY2yJDHgVVVeOvQAkO1ffQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB7011:EE_
x-ms-office365-filtering-correlation-id: 6b8f39ca-abb9-4684-c58d-08dde7387818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0pienZ4b0xPUCtESDE0Z2F0U2t0cTgyWEJNSHBzZzcxNHZIWk9vQUhpSUVa?=
 =?utf-8?B?NW1IYUV0M3MwbUFEQ2JHSzFKWUVrRXFVMHBvZGxpWkVnYnhyN1dKVVNtbjZJ?=
 =?utf-8?B?eSsvNjdWaHFLSXFwcmMxQUlxWit6VmtGMEFKR1Q4Q1EzajE2MWdRdWN1N2ZG?=
 =?utf-8?B?WVFhbU9TTUtqL2xhMW9rZXJmZnhEbTNjTVFGNGVmTW5QTFpZTTZhaldJL3Zr?=
 =?utf-8?B?eW1pZmI1K0NwUWNRVTFwc2twSGkwWkJpVlZMbFlWcEVrOS9BQnlVeEtqdUwr?=
 =?utf-8?B?dUVQOU0reVp4V2gyMFRuNHQ0SFJibk93OWIrRHVSVzNJVFIwNmtGOWdpV0hX?=
 =?utf-8?B?ckk4SEJlcUQzUEoyNlNwWld0MHhvb3g2SHp5UTFKL1VVUWFlamt5MFNPTjF2?=
 =?utf-8?B?Zm4xOXhTZU5zdkxhRUZFQmtkZVRnLzRDSGs2MmNsMjFEdkVTWk1QSWRlUGhs?=
 =?utf-8?B?NXlxclZFN0IrU1NubWNsdU0vVXRHYWh1YXJtazF4Q2VIUWpKT1RSQnRRb05M?=
 =?utf-8?B?Z2ZHT05PTXNiazBZRnErVStTTkJHNEtJb3ZjeEQrWWxKbjVaR3B4TEczMXl5?=
 =?utf-8?B?b0dMNlhoY2haUTg0WVpodmhucFc3U244bCtEMUQxSXNjc3ZFTHh3b0JXY3lz?=
 =?utf-8?B?bjRnbWswMUdMNzJrdWZjUlBuT3ZYYzdJbTlITWJiQ1l6c3ZKTFYycTNzUUZV?=
 =?utf-8?B?WFJmb1RVcTY4dFpZZ0JrTDJ5dit1WFN2RXB3Yzk0UUtpN2RaemRrcDRrVDRy?=
 =?utf-8?B?cHc3a0EwQ292M0dOdEg0cGx4QU1QNHBOUEpwSlZla3FVMy94NHUzOERhZWRa?=
 =?utf-8?B?bVVMUHhabVRtUzZuc2gxdDJFVjVpYUZaUnl4Zi9XbElwWFREdzlQWmYydXVt?=
 =?utf-8?B?OTNNb2NJZVE5NHJNc1YwUmlFNCtuSGZjcW11WUxpTm1GZnI1ZkRWTmN5SzdP?=
 =?utf-8?B?NkVBRzUzamp0K2lOSHA4MXg5L011Vkg3dlBmMk9ET0E5RjE4Qk9TWjMyT3Zq?=
 =?utf-8?B?VHlDZzBiSmZzTlowbHpxNFFIUHFOWjN4YjZhWDg5NEk0R1ZYOEZNY25ObUNM?=
 =?utf-8?B?VWlYdU5Vem1GR0k3V2dIcVpaRk10MHhML29mWlBMNVhyUmdILzRVUXptcmRx?=
 =?utf-8?B?RExQQnBSUzR3M29KZDVyK01wK0pUNkhrWStndUthSU9qeTdEalh5Sis5Q3RG?=
 =?utf-8?B?MUdYTGUxZXV5Sk1aM0VvbUM0WU53ZktreDdSaEJISUFRSHZSWHZDSmNhamVY?=
 =?utf-8?B?b3NtMUVpSDZOZWdYRkRrQWduWndLYm5oMXgrd1NpWXR6ME45UUd3ZUdQRXhO?=
 =?utf-8?B?RjVxMEczWkpvZGJWN2hOTXgvUmVNeURleHJxWURpSW1MSU1NaHI1R2xqd1Vk?=
 =?utf-8?B?MEt2aGJCUmVsZC9CcStUSWZTL1kyYjZKVnBKZmgzTFdYU2Q1c0p1QU5BRHFk?=
 =?utf-8?B?Z0VUTUZlQkR5amd2ZzJhdkFTS3RtZ2Fhb2Z0MDNleUphREsyU0xhZGNwZmkx?=
 =?utf-8?B?SEdaMTZTY0pTbmpoRk5UTll4TzgzVE51UUxIYnBCVzBqRTA2STRyQkUzOHdo?=
 =?utf-8?B?YlQyUVl3R1RkZWg1UllhcU40QnZlQ1ZWQVJFb1diRlN1YjZycy9pbEJTY3hM?=
 =?utf-8?B?cUxvNVlacE1WbUZubjhjc3A2aTVBbEp0d1NabVU3Qld4NHRLMzRpQWk2RFpp?=
 =?utf-8?B?WGRrKzFyamlsRUtUS3JEL1p4ck5MZ3RQMWsxK2lwTml6aUIzMjBydjVjai90?=
 =?utf-8?B?OHFmRjVxaFNZZHhwZTFMTVB6ZVlicmxGZUNXeHFHQTRydm1DN2ZEcllxRHZp?=
 =?utf-8?B?WHRzaWRRdDhVU0o5aG85N3lHMGV4VzBNbktYbXgrekRBYTc5a2tXbWljdnh6?=
 =?utf-8?B?Z2RKSThKdDJUbEIxSC8xSmNUS202R1V5NmZURDYwbEtsTGF2blRUQ1I4RWdP?=
 =?utf-8?B?L3RBYmYzdWNTMmlBY09wUi9hSUdreVlRbVhGVk9FSWl2M3o2bXE3TTZvaGlh?=
 =?utf-8?B?aGhFZGRLMkNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0dJaDB6elk1VDlaZERLKzBGRVBzSDErNFhYa1RjM0ZqNzJ5YUMvZHdLUFpB?=
 =?utf-8?B?VXJmcTNpQlcvVzB6UklPblJ6UjhGKy9UcXh6NzlRdVU2T2VvWkRGaE1hNDV3?=
 =?utf-8?B?OVV5c2FwVWl3RE1mRFc2VFNmYXBDd0RqVGlWYklxR1g1VHI4ZldGM2JkbG52?=
 =?utf-8?B?U2Q2V0RBRHE2cnFGSFVnRmdFOCszMVZ6STdWdVZtais4RkVTSUExVlFxL0lK?=
 =?utf-8?B?YU5TRUFIdDVHVDVMNlRWKytibjRnQURZUEZMNlJaUHA0Wm8zajdxRXZnU3RS?=
 =?utf-8?B?REM1NlJ1YW9NcXdUNGljRDBGL2NPWDY5M2hXTnBVVUNMek9tT0NUUGxyZ21r?=
 =?utf-8?B?RkFSSUU2WTdCVkcvaTZvRjYyUktJdlU5SVd0UGpKWTEzRUNTazl1MWpMb0Jj?=
 =?utf-8?B?SFdIVXRwSXZiYXAwK3Zxb0JPRlBIU1Q3dU5oUmJlOHhYSURwUUl6K25uOFpJ?=
 =?utf-8?B?L3kvRTM3ZnRvaHJ4blNWZXpXSWdKK3g0U0hZa3hlRVdlZ0hEREt3bVpuVy82?=
 =?utf-8?B?bFExME5FRFExeXVyVkZpL3crMWhzL1kvS1RuTFZJeGN0MW1qd3N0MU9xMlND?=
 =?utf-8?B?MmJlUkM4b2xKTTlFcnRvSzlGTkNZTUJPc09va2RVM0hlbXNuM25TaHJaQWZE?=
 =?utf-8?B?eTdpRVNKZ1ZxQkd6bVlvMTVpYy9oYmZvL1BPeFdJRmF2Nmd6SnJUSm1Ua0tR?=
 =?utf-8?B?T2FyM3JaWUI3bVBuckw4VzloY2FieVlTbWtWTTB6YnFMUEhxL3E3d1pUbXhp?=
 =?utf-8?B?cVJnVWwvQ1BScnRkVzgvRWhWTTkrQlkvOEoveG5pTlZEdUlTSWphWitBdWI1?=
 =?utf-8?B?K08zd25nc1lZd1RPbmhjZHU3SHdKNHRHalpKRjVDU3daL1I1bkJ4dFBnUUNz?=
 =?utf-8?B?Kzg0UFlkbmpJd0VYNEQ1MXB4RlcxeVVjOHVqOVU3SDd0K2d1OTNZN1cwdkor?=
 =?utf-8?B?WkVYQXlTdk5XZ0JlN2ZpTThkL1pVbUx1b3A0czB1Rko4eGR1YXhlTTZHdmRX?=
 =?utf-8?B?cmRIYkc1UlIydXcwN24wdFpmUElKenRmT1YwNkh1ZFFjejJ4N04yVTlsYi9j?=
 =?utf-8?B?R1RRUkEySHg1Z2t3VFRXYkw0N1VuM3REUm1DdFdzYUNJbzZ5U1RuKzlDbDVz?=
 =?utf-8?B?M0YzcEtyYXpvN3hXK2s1aDFZR0kzbnlabW5ZQzlBWTNqL09uWE4xWGFJQ1pO?=
 =?utf-8?B?OXVTWTlzeURENi9EbVJoMW5LdVMxbkZpd0lYNTlSckJ2OWIxUCsybGlNTzVI?=
 =?utf-8?B?Q3lhWEVFTTd4L3dCRkpEVkxJcXg3cHllbnRjVVlTRGdGL3FBMGZMeFd4eUth?=
 =?utf-8?B?MnRYeUMxYTVOeFZqTkVkWGwzTndqZVlpenJaR1A1djRVRHR1OW14cWhHUU9l?=
 =?utf-8?B?aThSd0RWeWh3ZGJJOE94VDF4NFJjRjdJc1E5Y09WczI1OXBGTDRZWmNUdTN1?=
 =?utf-8?B?bTAvenE4bUZzUmh2NDdQVmJyeGZsZGl5VmlWcUp3L3NuVFZ5aUVkd1NqWDJw?=
 =?utf-8?B?ZDQwdzlaZktmRTJ2RENxcVZGZkR2SzJpcmxzZzkydUpvbitkQ09WbWExUXM3?=
 =?utf-8?B?cUxTRVh2bGtNWjhIcGY5M1hORzk0M0FwczF0NGp2SUU2VDZUckk3ckF6ZWtv?=
 =?utf-8?B?ejJGOEwvTjl4bTR3REJPNEtEdFRDbkR1RDFLajNuZHB2MGdMdHpuM2tmcFkz?=
 =?utf-8?B?d3dQT2NYd1VoMTFoWXdXc2JSUG96K2NYQVh0U0hOUjNqdlh6ZkdBbjlPV25B?=
 =?utf-8?B?T2orZjQvTjhPMVFuWUt2MkhORWIwVEhzak81d0ZnZ0owYmhic0lrNnpRc2J5?=
 =?utf-8?B?SmprQW92ZE9yL3RaQVN0aG5LRTVuS1BYMSs3ek55V1c4Mm1PZzZtY3pwTlBu?=
 =?utf-8?B?Si9EeHpXejhYT0hId09PZGJTZFhCc2c1bEtnV2FndlZCTDg1ZWg4VThvTGxx?=
 =?utf-8?B?UTA0bU4vdW9tWGszclh5TVltQ281SVQzV2dER2hEQU9NSU0zL09DVFZOVXl1?=
 =?utf-8?B?TGNRN2JpaXFIeDUveEMrWHlIcVY3VzlGV3V1NmliSk5xTG93RHJGU0piNGdR?=
 =?utf-8?B?anYwaERXdmhUVnNZMEx3S2NOV0twQVROUXRSNDc3Mk1OMzBBOHlRK1NOUXRm?=
 =?utf-8?B?RWtucTlZT1E2b21mN0ZiSkQ2L1N0bnlCOGNJdENuZFZtNjVwTTZ2STZOSFo1?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74BC3305D2E95542B96350F7959C6B7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s8T0IeDXE/Ylsu15b7E440ImyRak77xGc+8YwibanQs04LIwHfh+NdW8X3o1gTJlbaUI6PrOpcUNfRxX9gI+1o2PMkvkhIC/sTSC/2jFxc2JFdiHVDHwFYuUqTB8y1T1txfFoyKTcjB2n2fp/HmDzhSQY9gCw0yvw3/Az4PRQduTavvbU13t6QdgK7uA8RnbqLoLV8Z8EL3U5X96HG8wNbPRbWyBdFqm4pU/ThX3k1Eo5nSa289G4jUYfyxN+IW4+3GdQBowl3cKBKHZ7fNaGrz6kRBaSW6uydH1S7Kz+D0BptWtpouNGzOWNvAk/fPluot2W6eT1Dt7jQQIP3VXcMlvJHZKhDA3jpvvRv7nvHtpw/LlZF1Q84WuxdiBzzFQq0RC0zrwiqX/7/A7swa+TomCiYzVNlgxwZurBnHgWSmsIEzOCTrRj7QSG15cAUHzYU7SVE0R8VOj7hdD1Qdis5mAHQ524TYtsrsLk+hLxnIl2CdVwBs6GvphEU35r6VblbD2NW3PV1Ep0IcdJbzsTU6eFYKqPUmh4bJCECzGGXHZb6HizUz+8Lzp3Kr2p9AHxqnmuJny1+/Ek6rb5jMiYmFAhhhYbWBfAczivzRcovSDiCV30ntt1kywFnkSgbo0fiwqKuN6Gasc5db3PSHTeQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f39ca-abb9-4684-c58d-08dde7387818
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 20:13:07.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +tHe+PhZ0ojFXTn0vRkRDNVD6YoVfz/bjq97E2LBUnT+LzRjsjbozgk9Raqsp42qbxXddzhJh2YR8P/sRchlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
X-Proofpoint-GUID: fowmVKMeDknUbNMv44v8oooKdKZqaGiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAxMSBTYWx0ZWRfX8fRoiKVpYCtr
 fpa34kl306RyiuLz2WE5X2aIAjCFXVGbf30mKZyzcye7gMYogi5TrrSGpA2apZkM2nePYoc7pQg
 qfih79MCWLFzbqX568YI4zcTi5CAg3+GceiKpZgnYiNebduLpA4Bv0RtrkX+5EiPCTplBttuPw2
 I9lm0EZZrIVA04OorVBdeY3+WlZRxt0OxadtX+2WcG/S0FktCgIIev00vZ18TTZrmpfjV5OG4QV
 JxB25n5ekQ3pao9hWyCTFewcmlG6NciP1erCt0tnK9X2xBpJg3568iU3sgpVWvDxPMdkJpekd4e
 VrVAJSMovBdnAB1QrSlszswVHHVdT5QcOERbYOM3RFhdSiGVLD9gDmVrgA7E7n7NlPgzzuMw0Cx
 Ae8KTkVA
X-Proofpoint-ORIG-GUID: fowmVKMeDknUbNMv44v8oooKdKZqaGiU
X-Authority-Analysis: v=2.4 cv=DpVW+H/+ c=1 sm=1 tr=0 ts=68b209da cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=jIQo8A4GAAAA:8 a=lu5gchr_8zuDi0pqmgIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290011

T24gRnJpLCBBdWcgMjksIDIwMjUsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBPbiBGcmks
IEF1ZyAyOSwgMjAyNSBhdCA5OjA34oCvUE0gVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lu
b3BzeXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgQXVnIDI4LCAyMDI1LCBBbGFuIFN0
ZXJuIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBBdWcgMjksIDIwMjUgYXQgMTI6NDM6MTdBTSArMDAw
MCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIEF1ZyAyNywgMjAyNSwgUmFm
YWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiA+ID4gT24gV2VkLCBBdWcgMjcsIDIwMjUgYXQg
NDo1MuKAr1BNIEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+IHdyb3RlOg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJ5YW46DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
WW91IHNob3VsZCBwcmVzZW50IHlvdXIgcXVlc3Rpb25zIHRvIHRoZSBtYWludGFpbmVyIG9mIHRo
ZSBrZXJuZWwncw0KPiA+ID4gPiA+ID4gUG93ZXIgTWFuYWdlbWVudCBzdWJzeXN0ZW0sIFJhZmFl
bCBXeXNvY2tpIChhZGRlZCB0byB0aGUgVG86IGxpc3QgZm9yDQo+ID4gPiA+ID4gPiB0aGlzIGVt
YWlsKS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoYW5rcyBBbGFuIQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IE9uIFdlZCwgQXVnIDI3LCAyMDI1IGF0IDEwOjA5OjEwUE0gKzA4
MDAsIHJ5YW4gemhvdSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSGkgUm95LA0KPiA+ID4gPiA+ID4g
PiBUaGFuayB5b3UgZm9yIHJldmlld2luZyBteSBwYXRjaC4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiA+IFdvdWxkbid0IHRoZSBwYXJlbnQgZ2x1ZSBkZXYgYWxyZWFkeSByZXN1bWUg
YmVmb3JlIHJlc3VtaW5nIHRoZSBjaGlsZCBkd2MzPw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+IE5vLCBpbiB0aGUgZm9sbG93aW5nIGNhc2UsIHRoZSBwYXJlbnQgZGV2aWNlIHdpbGwg
bm90IGJlIHJldmlld2VkDQo+ID4gPiA+ID4gPiA+IGJlZm9yZSByZXN1bWluZyB0aGUgY2hpbGQg
ZGV2aWNlLg0KPiA+ID4gPiA+ID4gPiBUYWtpbmcgdGhlICdpbXg4bXAtZHdjMycgZHJpdmVyIGFz
IGFuIGV4YW1wbGUuDQo+ID4gPiA+ID4gPiA+IFN0ZXAgMS51c2IgZGlzY29ubmVjdCB0cmlnZ2Vy
OiB0aGUgY2hpbGQgZGV2aWNlIGR3YzMgZW50ZXIgcnVudGltZQ0KPiA+ID4gPiA+ID4gPiBzdXNw
ZW5kIHN0YXRlIGZpcnN0bHksIGZvbGxvd2VkIGJ5DQo+ID4gPiA+ID4gPiA+IHRoZSBwYXJlbnQg
ZGV2aWNlIGlteDhtcC1kd2MzIGVudGVycyBydW50aW1lIHN1c3BlbmQNCj4gPiA+ID4gPiA+ID4g
Zmxvdzpkd2MzX3J1bnRpbWVfc3VzcGVuZC0+ZHdjM19pbXg4bXBfcnVudGltZV9zdXNwZW5kDQo+
ID4gPiA+ID4gPiA+IFN0ZXAyLnN5c3RlbSBkZWVwIHRyaWdnZXI6Y29uc2lzdGVudCB3aXRoIHRo
ZSBydW50aW1lIHN1c3BlbmQgZmxvdywNCj4gPiA+ID4gPiA+ID4gY2hpbGQgZW50ZXJzIHBtIHN1
c3BlbmQgYW5kIGZvbGxvd2VkDQo+ID4gPiA+ID4gPiA+IGJ5IHBhcmVudA0KPiA+ID4gPiA+ID4g
PiBmbG93OiBkd2MzX3BtX3N1c3BlbmQtPmR3YzNfaW14OG1wX3BtX3N1c3BlbmQNCj4gPiA+ID4g
PiA+ID4gU3RlcDM6IEFmdGVyIGR3YzNfcG1fc3VzcGVuZCwgYW5kIGJlZm9yZSBkd2MzX2lteDht
cF9wbV9zdXNwZW5kLCBhDQo+ID4gPiA+ID4gPiA+IHRhc2sgdGVybWluYXRlZCB0aGUgc3lzdGVt
IHN1c3BlbmQgcHJvY2Vzcw0KPiA+ID4gPiA+ID4gPiAuIFRoZSBzeXN0ZW0gd2lsbCByZXN1bWUg
ZnJvbSB0aGUgY2hlY2twb2ludCwgYW5kIHJlc3VtZSBkZXZpY2VzIGluDQo+ID4gPiA+ID4gPiA+
IHRoZSBzdXNwZW5kZWQgc3RhdGUgaW4gdGhlIHJldmVyc2UNCj4gPiA+ID4gPiA+ID4gb2YgcG0g
c3VzcGVuZCwgYnV0IGV4Y2x1ZGluZyB0aGUgcGFyZW50IGRldmljZSBpbXg4bXAtZHdjMyBzaW5j
ZSBpdA0KPiA+ID4gPiA+ID4gPiBkaWQgbm90IGV4ZWN1dGUgdGhlIHN1c3BlbmQgcHJvY2Vzcy4N
Cj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+V2h5IHdvdWxk
ICdydW50aW1lIFBNIHRyeWluZyB0byBhY3RpdmF0ZSBjaGlsZCBkZXZpY2UgeHh4LmR3YzMgYnV0
IHBhcmVudCBpcyBub3QgYWN0aXZlJyBoYXBwZW4gaW4gdGhlIGZpcnN0IHBsYWNlPw0KPiA+ID4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEZvbGxvd2luZyB0aGUgYWJvdmUgYW5hbHlzaXMsIGR3
YzNfcmVzdW1lIGNhbGxzDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGFzc3VtZSB0aGF0IGR3YzNf
cG1fcmVzdW1lKCkgaXMgbWVhbnQgaGVyZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBwbV9y
dW50aW1lX3NldF9hY3RpdmUoZGV2KSwgaXQgY2hlY2tzIHRoZQ0KPiA+ID4gPiA+ID4gPiBwYXJl
bnQucG93ZXItPnJ1bnRpbWVfc3RhdHVzIGlzIG5vdCBSUE1fQUNUSVZFIGFuZCBvdXRwdXRzIHRo
ZSBlcnJvciBsb2cuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbmQgaXQgZG9lcyBzbyBiZWNhdXNl
IGVuYWJsaW5nIHJ1bnRpbWUgUE0gZm9yIHRoZSBjaGlsZCB3aXRoDQo+ID4gPiA+ID4gcnVudGlt
ZV9zdGF0dXMgPT0gUlBNX0FDVElWRSBkb2VzIG5vdCBtYWtlIHNlbnNlIHdoZW4gdGhlIHBhcmVu
dCBoYXMNCj4gPiA+ID4gPiBydW50aW1lIFBNIGVuYWJsZWQgYW5kIGl0cyBzdGF0dXMgaXMgbm90
IFJQTV9BQ1RJVkUuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJdCBsb29rcyBsaWtlIHRoZSBydW50
aW1lIFBNIHN0YXR1cyBvZiB0aGUgcGFyZW50IGlzIG5vdCBhcyBleHBlY3RlZCwNCj4gPiA+ID4N
Cj4gPiA+ID4gU28gaXMgdGhlIHNjZW5hcmlvIFJ5YW4gYnJvdWdodCB1cCB1bmV4cGVjdGVkPyBX
aGF0IGFyZSB3ZSBtaXNzaW5nIGhlcmUNCj4gPiA+ID4gYW5kIHdoZXJlIHNob3VsZCB0aGUgZml4
IGJlIGluPw0KPiA+ID4gPg0KPiA+ID4gPiA+IGJ1dCBxdWl0ZSBmcmFua2x5IEkgZG9uJ3QgcXVp
dGUgZm9sbG93IHRoZSBsb2dpYyBpbiBkd2MzX3BtX3Jlc3VtZSgpLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gV2h5IGRvZXMgaXQgZGlzYWJsZSBydW50aW1lIFBNIGp1c3QgZm9yIHRoZSBkdXJhdGlv
biBvZg0KPiA+ID4gPiA+IGR3YzNfcmVzdW1lX2NvbW1vbigpPyAgSWYgcnVudGltZSBQTSBpcyBm
dW5jdGlvbmFsIGJlZm9yZSB0aGUNCj4gPiA+ID4gPiBwbV9ydW50aW1lX2Rpc2FibGUoKSBjYWxs
IGluIGR3YzNfcG1fcmVzdW1lKCksIHRoZSBkZXZpY2UgbWF5IGFzIHdlbGwNCj4gPiA+ID4gPiBi
ZSByZXN1bWVkIGJ5IGNhbGxpbmcgcG1fcnVudGltZV9yZXN1bWUoKSBvbiBpdCB3aXRob3V0IGRp
c2FibGluZw0KPiA+ID4gPiA+IHJ1bnRpbWUgUE0uICBJbiB0dXJuLCBpZiBydW50aW1lIFBNIGlz
IG5vdCBmdW5jdGlvbmFsIGF0IHRoYXQgcG9pbnQsDQo+ID4gPiA+ID4gaXQgc2hvdWxkIG5vdCBi
ZSBlbmFibGVkLg0KPiA+ID4gPg0KPiA+ID4gPiBCYXNlIG9uIGdpdC1ibGFtZSwgSSBob3BlIHRo
aXMgd2lsbCBhbnN3ZXIgeW91ciBxdWVzdGlvbjoNCj4gPiA+ID4NCj4gPiA+ID4gICAgIDY4YzI2
ZmU1ODE4MiAoInVzYjogZHdjMzogc2V0IHBtIHJ1bnRpbWUgYWN0aXZlIGJlZm9yZSByZXN1bWUg
Y29tbW9uIikNCj4gPiA+ID4NCj4gPiA+ID4gICAgIEZvciBkZXZpY2UgbW9kZSwgaWYgUE0gcnVu
dGltZSBhdXRvc3VzcGVuZCBmZWF0dXJlIGVuYWJsZWQsIHRoZQ0KPiA+ID4gPiAgICAgcnVudGlt
ZSBwb3dlciBzdGF0dXMgb2YgZHdjMyBtYXkgYmUgc3VzcGVuZGVkIHdoZW4gcnVuIGR3YzNfcmVz
dW1lKCksDQo+ID4gPiA+ICAgICBhbmQgZHdjMyBnYWRnZXQgd291bGQgbm90IGJlIGNvbmZpZ3Vy
ZWQgaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKS4NCj4gPiA+ID4gICAgIEl0IHdvdWxkIGNhdXNl
IGdhZGdldCBjb25uZWN0ZWQgZmFpbGVkIGlmIFVTQiBjYWJsZSBoYXMgYmVlbiBwbHVnZ2VkDQo+
ID4gPiA+ICAgICBiZWZvcmUgUE0gcmVzdW1lLiBTbyBtb3ZlIGZvcndhcmQgcG1fcnVudGltZV9z
ZXRfYWN0aXZlKCkgdG8gZml4IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBjZXJ0
YWluIHBsYXRmb3JtcywgdGhleSBwcm9iYWJseSBuZWVkIHRoZSBwaHkgdG8gYmUgYWN0aXZlIHRv
IHBlcmZvcm0NCj4gPiA+ID4gZHdjM19yZXN1bWVfY29tbW9uKCkuDQo+ID4gPg0KPiA+ID4gSXQg
c291bmRzIGxpa2UgdGhlIHJlYWwgcXVlc3Rpb24gaXMgaG93IHdlIHNob3VsZCBkZWFsIHdpdGgg
YW4NCj4gPiA+IGludGVycnVwdGVkIHN5c3RlbSBzdXNwZW5kLiAgU3VwcG9zZSBwYXJlbnQgZGV2
aWNlIEEgYW5kIGNoaWxkIGRldmljZSBCDQo+ID4gPiBhcmUgYm90aCBpbiBydW50aW1lIHN1c3Bl
bmQgd2hlbiBhIHN5c3RlbSBzbGVlcCB0cmFuc2l0aW9uIGJlZ2lucy4gIFRoZQ0KPiA+ID4gUE0g
Y29yZSBpbnZva2VzIHRoZSAtPnN1c3BlbmQgY2FsbGJhY2sgb2YgQiAoYW5kIGxldCdzIHNheSB0
aGUgY2FsbGJhY2sNCj4gPiA+IGRvZXNuJ3QgbmVlZCB0byBkbyBhbnl0aGluZyBiZWNhdXNlIEIg
aXMgYWxyZWFkeSBzdXNwZW5kZWQgd2l0aCB0aGUNCj4gPiA+IGFwcHJvcHJpYXRlIHdha2V1cCBz
ZXR0aW5nKS4NCj4gPiA+DQo+ID4gPiBCdXQgdGhlbiBiZWZvcmUgdGhlIFBNIGNvcmUgaW52b2tl
cyB0aGUgLT5zdXNwZW5kIGNhbGxiYWNrIG9mIEEsIHRoZQ0KPiA+ID4gc3lzdGVtIHNsZWVwIHRy
YW5zaXRpb24gaXMgY2FuY2VsbGVkLiAgU28gdGhlIFBNIGNvcmUgZ29lcyB0aHJvdWdoIHRoZQ0K
PiA+ID4gZGV2aWNlIHRyZWUgZnJvbSBwYXJlbnRzIHRvIGNoaWxkcmVuLCBpbnZva2luZyB0aGUg
LT5yZXN1bWUgY2FsbGJhY2sgZm9yDQo+ID4gPiBhbGwgdGhlIGRldmljZXMgd2hvc2UgLT5zdXNw
ZW5kIGNhbGxiYWNrIHdhcyBjYWxsZWQgZWFybGllci4gIFRodXMsIEEncw0KPiA+ID4gLT5yZXN1
bWUgaXMgc2tpcHBlZCBiZWNhdXNlIEEncyAtPnN1c3BlbmQgd2Fzbid0IGNhbGxlZCwgYnV0IEIn
cw0KPiA+ID4gLT5yZXN1bWUgY2FsbGJhY2sgX2lzXyBpbnZva2VkLiAgVGhpcyBjYWxsYmFjayBm
YWlscywgYmVjYXVzZSBpdCBjYW4ndA0KPiA+ID4gcmVzdW1lIEIgd2hpbGUgQSBpcyBzdGlsbCBp
biBydW50aW1lIHN1c3BlbmQuDQo+ID4gPg0KPiA+ID4gVGhlIHNhbWUgcHJvYmxlbSBhcmlzZXMg
aWYgQSBpc24ndCBhIHBhcmVudCBvZiBCIGJ1dCB0aGVyZSBpcyBhIFBNDQo+ID4gPiBkZXBlbmRl
bmN5IGZyb20gQiB0byBBLg0KPiA+ID4NCj4gPiA+IEl0J3MgYmVlbiBzbyBsb25nIHNpbmNlIEkg
d29ya2VkIG9uIHRoZSBzeXN0ZW0gc3VzcGVuZCBjb2RlIHRoYXQgSSBkb24ndA0KPiA+ID4gcmVt
ZW1iZXIgaG93IHdlIGRlY2lkZWQgdG8gaGFuZGxlIHRoaXMgc2NlbmFyaW8uDQo+ID4gPg0KPiA+
DQo+ID4gQWxhbiwgUmFmYWVsLA0KPiA+DQo+ID4gV2hhdCBhcmUgeW91ciB0aG91Z2h0cyBvbiBo
b3cgd2Ugc2hvdWxkIGhhbmRsZSB0aGlzLg0KPiANCj4gSSdtIG5vdCByZWFsbHkgc3VyZSB3aGF0
IHlvdSBtZWFuIGJ5ICJ0aGlzIjogdGhlIHNjZW5hcmlvIGRlc2NyaWJlZCBieQ0KPiBBbGFuIG9y
IHNvbWV0aGluZyBlbHNlPw0KPiANCj4gSSB3YXMgcHVsbGVkIGludG8gdGhlIHRocmVhZCBpbiB0
aGUgbWlkZGxlIG9mIGl0IGFuZCBJIGRvbid0IGtub3cgdGhlDQo+IGZ1bGwgY29udGV4dC4NCg0K
VGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcy4gVGhlIGlzc3VlIFJ5YW4gcmVwb3J0ZWQgaXMg
d2hhdCBBbGFuDQpkZXNjcmliZWQ6IEEgc3lzdGVtIHN1c3BlbmQgd2FzIGludGVycnVwdGVkIGZv
ciBkZXZpY2UgQSBhbmQgQiB0aGF0IGFyZQ0KYWxyZWFkeSBpbiBydW50aW1lIHN1c3BlbmQuIFRo
ZSByb2xsIGJhY2sgdHJhbnNpdGlvbiBza2lwcGVkIEEgLT5yZXN1bWUuDQpCJ3MgLT5yZXN1bWUg
d2FzIGNhbGxlZCBhbmQgcmVjZWl2ZWQgYW4gZXJyb3IgbWVzc2FnZSBiZWNhdXNlIEEgd2FzDQpz
dGlsbCBpbiBydW50aW1lIHN1c3BlbmQuDQoNCkZvciBkd2MzIGhvd2V2ZXIsIGl0IHJlc3VtZXMg
QiBhbnl3YXkgcmVnYXJkbGVzcyBvZiB0aGUgZXJyb3IuIEJlY2F1c2UNCm9mIHRoZSBkZXBlbmRl
bmN5IG9mIEEsIGl0IHJ1bnMgaW50byBwcm9ibGVtcyBsYXRlci4gVGhpcyBjYW4gYmUgZml4ZWQN
CmluIGR3YzMgdG8gY2hlY2sgZm9yIHRoZSBlcnJvciwgYnV0Li4NCg0KPiANCj4gPiBTaG91bGQg
dGhlIGZpeCBiZSBhdCB0aGUgUE0gY29yZT8gU291bmRzIGxpa2UgdGhlIFBNIGNvcmUgbmVlZHMg
dG8gY2hlY2sNCj4gPiBtb3JlIHRoYW4gd2hldGhlciB0aGUgLT5zdXNwZW5kIGNhbGxiYWNrIHdh
cyBjYWxsZWQgZWFybGllciB0byBkZXRlcm1pbmUNCj4gPiB3aGV0aGVyIHRvIHNraXAgLT5yZXN1
bWUuDQo+IA0KPiBCdXQgdGhlIGNvcmUgZG9lc24ndCBrbm93IHdoYXQgaGFwcGVuZWQgaW4gdGhl
IC0+c3VzcGVuZCBjYWxsYmFjayBpbg0KPiB0aGUgZmlyc3QgcGxhY2UsIHNvIGhvdyBjYW4gaXQg
a25vdyB3aGF0J3MgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvPw0KDQouLnNob3VsZG4ndCB0aGUgUE0g
Y29yZSBrbm93IHRoYXQgQSB3YXMgcnVudGltZSBzdXNwZW5kZWQgdG8gbm90IHNraXANCi0+cmVz
dW1lPyAoc29ycnkgSSdtIG5vdCBhbiBleHBlcnQgaW4gdGhlIFBNIGNvcmUsIGdlbnVpbmUgcXVl
c3Rpb24NCmhlcmUpLg0KDQpUaGFua3MsDQpUaGluaA==

