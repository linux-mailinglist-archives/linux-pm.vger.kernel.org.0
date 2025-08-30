Return-Path: <linux-pm+bounces-33441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA3B3C71D
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 03:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9652F5A3C19
	for <lists+linux-pm@lfdr.de>; Sat, 30 Aug 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DE4CB5B;
	Sat, 30 Aug 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UZ4yftZA";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fZmVFTwK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="THdoUcFR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3703D81;
	Sat, 30 Aug 2025 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517634; cv=fail; b=eo9g5nB6Uid5ecS+2xPpgcn4aYK1dHGS3Uw29qM8y0z4sr9ihVO33cIkVn6n+sgvJrHR8qBl7uHeOzeQ+TY1PGqJYUhVJMPFrdghEOhaagpyP7/BvKxmaMuP5dSNnfBmYSPd/CwfgzaZPgf8z9O0Og/y4CJLzIRQpnQ5vO4I3Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517634; c=relaxed/simple;
	bh=XRYIfRQahKhv6eU/giucxVAgQ+1PL2wNEdDWOO9kwO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TmiDVGPvdI0W342mvs0lQD3VaztalwIseatnXB3woLLBEhUF1Qy+V+oOnJAMbJNiKgMvbVfC2uvGuKqeIQhugXlCX6z6jFrjXhR8GVq1gSCBVbkaiCCOAQzHlXSxTLwCKmkYl0ycXZyZJBG45YyWSuO+5+eZa1o8uUjOBgvaToA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UZ4yftZA; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fZmVFTwK; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=THdoUcFR reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0UWJr006072;
	Fri, 29 Aug 2025 18:33:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XRYIfRQahKhv6eU/giucxVAgQ+1PL2wNEdDWOO9kwO4=; b=
	UZ4yftZA+pJ7gr1Qh08yWCENjCSgZgdGy3YjiKgYdHaD23UtKF1wIbGlV+/S/iot
	cgYNYeLr6gJdcknm0ut2LfpSM189WT1iWwZo47D2E5RyvWTs9e6Gt9lTAkrf/NBo
	6LLi0EGjcTc+gwNbf5QWX3mXf9CEHlDn2heO5PWa2GGC/mC95OS3/uGgH9QdLqd9
	JSi7cdJhMfckRD7LMTFn+KdJh5ETl/Ao5QrkL/22TNLuHp3WXgfW889gdqDPkklx
	ErKs7gQcG+hrKCjiyZRBfBYLUsS5pC2MFA+O08a8qpQm5qNGxnblCcBOugSSJG2F
	ILfam2zwo1omdx+3BpOrkg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48u2kywdf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756517611; bh=XRYIfRQahKhv6eU/giucxVAgQ+1PL2wNEdDWOO9kwO4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fZmVFTwK4X5IQqZSQ1Pmg0FAFOnTyHxwwzuyafW+FMUryqEaVC1Ko7ix47YzzoZRc
	 lMydOgXK5r79gRRORCDKsKKS3VrfZXIxVLiXzmzx/+OB+xih0rvfL7N93Z1Q72YpYz
	 5wjd4dh6KXtDOPF/NJIQusw+4alUyqivraVTH+RMN3LKqeKi8CNxHBymH/4vyEmRXP
	 b19rB/ueur2TMkgP2tkGnoAXO/ksqPl4Weqw4oMIQXIcM5oUTuJXNkPWUjkf295Oze
	 q9Aq+Y6IHEi+p7KjHpHar2QULmMmXto7L3cU6vlLcOZHyC5ldYSLJEvGgVeWaf4Ztp
	 u93Z/WH4HsIzQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B2D5340728;
	Sat, 30 Aug 2025 01:33:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6C57EA05DD;
	Sat, 30 Aug 2025 01:14:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=THdoUcFR;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B11A640347;
	Sat, 30 Aug 2025 01:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUoquK96X0x+LCwudUG2q7OX8gEyItstiuNWPjOmw679toqO5qubuu8/rWVwxquCmkQKdzqyFt2FmdoJAeRz2/XGj9BgjoA4iUZbtj27Fdg7KHfilYUbSlJvEKt808LpEtD6rsgrsTddFmszcT9wiEk2aX9ChCt+a6K7NAM0TQGBlZHJ9EPK0sqmZVEX+fIfdiKoayu0x/ZgGqluyWcAeGBEnx59oBCgAPcewYXahgL4nyc+iNbCvzMK2fLyODRVpOm8sT8hYq7cvPiOabNCe5vRDZBUCzoYVzQ8jU53ArpLtbfrLLnMPaolKEmO/d3yFmyqyuB4glBw54vTMeynMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRYIfRQahKhv6eU/giucxVAgQ+1PL2wNEdDWOO9kwO4=;
 b=xWqlzAscmHpZwipyHe3BaV9kF4jie0kSnIQa5VtzlagXwE6dQHeHkpSrYitDkbKg+IdQUGY+DVJkYqW+bqisKq1tk1VUYyHN/luVBkOd+XBIZ9kCdrCdA4Yn3dEMDpHenJ8rQY/Ygepx5EhABIHBtulvOPKFlTvLL26gxznaVBg9LjJH0JEKQ3jKxmCZuhmorYm6T6gp+BmmUp3XOS5XbikWjDpdMz16aDWmPeoUokz1EeyAD9sfh1GaxHmpW1MBIEvxokuq/DEQXIbKF0pvW5X9rG+SZrDQtxnsgArrcgH4A5HYGzfucD68Xz7+eku1JeEGY7TQ6aD/o4zzQBWe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRYIfRQahKhv6eU/giucxVAgQ+1PL2wNEdDWOO9kwO4=;
 b=THdoUcFRa74Pmc8B38+RvcklRfJyPNZx6C6JKPFuVggC0vpX12vZYm1bxNfpmQFQwaRnl5hZYkUo4Ms2vMYccr9X0+z3STRRm8ZBVUYd34y/VJhoWfBEE/HDcfYQ7djIgOeJK/QvwFoWmSNgVnMmG6dN2rXHTN/e+oDG7SYMH/c=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Sat, 30 Aug
 2025 01:14:38 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%4]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 01:14:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
 AQHcFpwLhCI1/x1c70ew6xjKTgeHrrR1Q/eAgAFHIgCAAAwMgIAARF6AgAHzEACAAAu5gIABKNKAgAAFRwCAAA0MAIAATFiAgAAH5oA=
Date: Sat, 30 Aug 2025 01:14:37 +0000
Message-ID: <20250830011437.g4m7jqvymfg7tm6x@synopsys.com>
References:
 <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
 <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
 <20250829190731.gx2xrgdz3tor5a2v@synopsys.com>
 <CAJZ5v0gY=w1G-R1EdpJi+Hm5+YmDWY2yJDHgVVVeOvQAkO1ffQ@mail.gmail.com>
 <20250829201306.rchlatbdxqy3xiki@synopsys.com>
 <056bd3b8-7d62-42e5-8b5d-4113a9ef769b@rowland.harvard.edu>
In-Reply-To: <056bd3b8-7d62-42e5-8b5d-4113a9ef769b@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|LV3PR12MB9258:EE_
x-ms-office365-filtering-correlation-id: 44bb542b-05fd-472a-5a72-08dde76296e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?emkrMDMxMVFqcW9oTUlkMVl1RkNpNVV6WUhITURDOEVTNHVEUFRQdWRWQ2g3?=
 =?utf-8?B?aGtidG90M3FRWG9Fai9QNFAxZFlLaUY3VmtZZ3JRVjZUeVloM21TMjBocFV6?=
 =?utf-8?B?S2NINmdpUFpkNEU5L25XaVBKQ2pvS3BIQld1MUQ1Wk9yMHhwdDk0VEtlbERN?=
 =?utf-8?B?UHVIZmR1SkxrMGtwZk5HWEpVdGFwcWVXVW1DSHc2UkZMUURlbU1XSit0WlUz?=
 =?utf-8?B?Ym9xZnVpc0M4SnRqQ21sclZTNmlLSjVRaUZFWTE5NlVSeDZ4TGMrWnovNUwv?=
 =?utf-8?B?NGkzcmlNM3ZOSG51c3FrUkE2aGNxS0M5emtaTFVCS1JxNFZtNUxKQm1wT3Rx?=
 =?utf-8?B?eWZYOGs1YWswdldkV3MwbVNyYU1oOU1IN1ZTYVZSVFBLU0J4anBrMXE3UlBp?=
 =?utf-8?B?ZHd4ZW56aWR5THJwRkoySjU3cFJrdmxMelJhOUJxaFhwU0sxVUZkQmNabS9Q?=
 =?utf-8?B?V1cvM1VpRnB1OURvUk9DQXAyb1o5c0tmb2t0RkNkN0pOTnpMT2FGRE9iV0ZQ?=
 =?utf-8?B?U2M0QzNDSUxrNmZiZHEvaTJNVDlTcTZuSW9RTFhLSkFvc1R1aUlaQ3pFZlBh?=
 =?utf-8?B?MUczMWRuQkl3eGh4U2pGRkUxeWpacEJRNVViYy9vaUkvMjdZOGhCWlozcmx6?=
 =?utf-8?B?WC8zcTg3TmQ5SXlwNlIwNmtrb2lDekp3MHNPOEdUcElGd1huL3ZTMkp3ckFl?=
 =?utf-8?B?TW1TNWc1Nm1lUUlsaVdFOTlkUXNxOGVCK3VZdkUyMVF4cnI5RGFpdnFDd2Jx?=
 =?utf-8?B?d0p2MDBJYUFNSGs0S0Z1bXpiV2Y0bVNUL25Hb1ZqclN1NERyTkdiWDI4YVhq?=
 =?utf-8?B?VzdMVHlvWFpPTmo2V2N5N3dwZTRQTys3b3o0Uy9IdC84UDgydkJnNnBJZVcw?=
 =?utf-8?B?NEdnS1pwQU1qS00xNkk1ODdobTlIRU9HNVRqRFE3VkhKV3hLRDFZNklNcnJ0?=
 =?utf-8?B?bG9UVmFuaGJLREMwNTVSMGVRTTFJSGp4QXYraWd0OTFKOUQ3ZTdqcGNxSmo0?=
 =?utf-8?B?dWVUTFVraVZxOHYvRFlpclNLQi80bG05ZFFtWVBaem5kUDdZQkRQaDhaeFYx?=
 =?utf-8?B?dGpmRHA2R0NSdHpVUU1EdmdYNU9id3N5cFJrU2I2Nnc1U3h6YTBWT0lVWUY3?=
 =?utf-8?B?MGxURHF0SDFDVGl3eG94b0tjVjFWQlEvcFhyeitCRzlpSGQ0QnNaRHUxd281?=
 =?utf-8?B?R3oxb2pNbEU1UFRlV1FtMnJsUU9SYUYxOXNZTlpqM3Fkd21Kbnd1ZTkveXJB?=
 =?utf-8?B?dGYzY0pGNForaWloNTNuT1UxZjFvT1N4cURiRDZFL0JML2w5UE96TFRENlVH?=
 =?utf-8?B?aVg1RHVZL3Q5dmFpdnBqOGc4MTR5Q0pQT3dqRGN0U1BLTjVpT2R5NHVUWmEz?=
 =?utf-8?B?MmV3ZWFDOENHNlpjT3dmd3dVUjdFL2hkb3hrWWJIS0orcDNFeTRRWnk0ZTY5?=
 =?utf-8?B?ejVLVzJ6T2M1Q2ZHYk5OclpkVEh6OGhMNXB2V0lMVm85bUoxaGFyVHRhcThT?=
 =?utf-8?B?cDdTSVBWbmZ3ZUhXZUx5c2V0aUcyUnhQRTlPK0E0U2hZQmV2ZldqTUgwamVI?=
 =?utf-8?B?TDJRS25zZG9BR1BPY1lLWjRWZVp0VTZRVlFpK0d0WTA4ZUZCRlJ4S3padWZK?=
 =?utf-8?B?TEJHUU1SOWpLSXg2Y0tQYmJzeU50TXRUYUsxY3Y3ZjAyakNzYy96R2lRbXNX?=
 =?utf-8?B?S0JNVlgreVZ4UXhVY1g1WU9NUHpiWlQwRFlmQ0RrcVdtTDY1Qk1PY2t3Z1M5?=
 =?utf-8?B?L3VPckI5UnZ1WGNjR1dOZzZ1LytsMzBhSnlnQmJBYnFhcXk2cmRROE45SklC?=
 =?utf-8?B?Sk5BOWNzYVBoY0JUVmNna09HTmhQaWJmdVdUYW9tMDdQekEzbXlvaDdqWDQ3?=
 =?utf-8?B?UlhmckhqYldwU1RoK2M0OGdNbStvMlFyMDFTTjlhQXo0ektSVVpxWExMWFAy?=
 =?utf-8?B?d3hKVEhtV0ZiS3k2RDVDUFg5d3NYc21XZHFxNkEzTmR4YTlCd0psTFRQVDVY?=
 =?utf-8?B?aHN1d3pjalVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1FDRXlCZEpjT1d1WElPdmdjdHNpTzhYOTZtS3VxWDhmTi9ITVZ3VC9OaGh3?=
 =?utf-8?B?anh5L2ZoZW5iejNlL3dseXB2cUQ0dHNyeXI2WGY5b2FnQmorOHptMk9Wa2Rv?=
 =?utf-8?B?VGxabXR4a05RY1J2dGhKa2N6cHYrZDV1SDdOdlN5Tm5iUUhVTlBObzNSNi84?=
 =?utf-8?B?RDZ1bXJiU0NuU2dEVFI5QWw3dEt1R1RIQVIyaE4xL0JqVm01akFZY2VYN1cz?=
 =?utf-8?B?OStzY2NveDFNUkI4ZUZXeU9RWHJtOGVPMFJ0QUx2ekV0SmNCQWZnZzltR3BE?=
 =?utf-8?B?MktwSHI1clptdkM2OEl5TEVycmdHVk1DVjJlaFdMNXY0dWpoL2RUNUd5NFlY?=
 =?utf-8?B?ZzluS0krREpGMzJ3Skd4OWtEZjA2OFBlajZ0ZXVUMzcrQVJwVE82Y2ZYUDV2?=
 =?utf-8?B?RzllelI0TmpaU243bWlDd2xOV3JENmRvZWwvUnFiWlB4YzROS0c3Y2tPSU5O?=
 =?utf-8?B?Ryt2bnVnTEovYll6WkQ4WVc3Nno3ME1CQjlaZHR5aGU1RXYxVmMyd3FYN3pm?=
 =?utf-8?B?SUk5QVBwdDJQRmMvbzh4SlJwM3R1amcyRXJJV1JmdmFnakYyUDdVaXZneFU5?=
 =?utf-8?B?ZmN6Skk5UU9XYWFta3ozb2NHaWRKNGI3S0ZJM1ZHMld0cllHdW1kc1hvaEt1?=
 =?utf-8?B?aHFWSm1VTE9qc2lOb2UwRnVUaE5jOHArU1RYU2lHYTZsaGtKQzhvTmV6VEVT?=
 =?utf-8?B?QWV3Tko2cENMdUdqNm1KOVFiKysxMWJUNFQxc2VVQmcvcUdRNlJiZEtlaTQ5?=
 =?utf-8?B?Q1ZMdm9TNS9pSWFnVUxIL2xtSkE0RklKVllOOHdkUTZBR1NTTThJREw5RXBu?=
 =?utf-8?B?bERzUnJMSGtWRmIxSGx4YnpObU43VnR2N3haU2JyRmVyQjF3aXpzb21ETkhF?=
 =?utf-8?B?TTY3K0JNZE9Ia3Jva29kOFkyWGkvYXRhV3lDaTRtQUpvRks5aU1wckJ2S0F2?=
 =?utf-8?B?Q2R3WitxRWdIWnFGUEc3bXVGYU41UnB4bVFDRk5QSmtzZlNtb2FtN2Z1TnVq?=
 =?utf-8?B?cHUrOFhXRDFSeHpubWZNMDVIbHBxYmc0SkNMejkzY1A4M2dRLzNabDJjRUZs?=
 =?utf-8?B?RnhWQVlSOC9vaE1hODhEYXF4d2ZjVmJUTWdsWEdHN1dDNFhMV2NsaE9EZnhr?=
 =?utf-8?B?ZWJFMFZDdWRNQWdOTlhjSnBrOTFsZG91MHpqUkE0Y0ZxUTZuQVN5d0pOVXY0?=
 =?utf-8?B?dkRLUnc1OFY4WCt0WmRLUHV0YXdCQVpiU1UzUzFNZFBhWEhIVGFOU0pURlp3?=
 =?utf-8?B?NytOT21CM3BGejVZZU1sVXVBUU9YcWhUUS9hQnFNNkdtWi9oajV0UU1FZnlO?=
 =?utf-8?B?aGY1VGoxQlk2eGZ1SEdrb3l1Z2VNU1lWR2ZuekRHb1VldVZMRTFDS0YxNlpj?=
 =?utf-8?B?a251d2FYbkl3MHBwWDhvVDBlUW5xYWN1SzVrSUhTQWVKd3pRdk5vQWU2amlX?=
 =?utf-8?B?UGwvRjZGa0Q3WnJ6VUJENjBJN2MzQkJGTXFKMS9IbzRYRC9vZlZ3QzRGQ0Uy?=
 =?utf-8?B?NFA1VmZLd21xb1daVGlOcUx4dFRzQkdFNEJNL3d1bFlZSkZZSU92dHkxZlFa?=
 =?utf-8?B?NC8xUXFncHZEQTBxVWxiYWdLbStsTlRFNVVyZzVGRExQWTkyNWRtanNoK3Z0?=
 =?utf-8?B?YXBhY2pHZmQ3RFloTGMvUTRzZVMxQTM2NkVrYytHbTh3M2tlZXRWZVVZM29W?=
 =?utf-8?B?KzVJZ1kxWHlSc0R2Y1lydVJ6U2x4SkR3NXJnTFp2U0RxRlJCMGdwb1FVYjl0?=
 =?utf-8?B?YmtuYXkxTWtFbi9ic29uOXplZXFzVmRnV2NLc1FDV0FGSVpHYUhPd1FGdVJp?=
 =?utf-8?B?dy85VjVhbjl3RVBXNDZWOTlhcXFUVGIzQmdHZ0dUWE1BeUE3eWtYRVNzSlBq?=
 =?utf-8?B?R3dITnRvVTBtcDdjSFBwUXZkSEFiNGg0T2FwZUFWMm9YTjBzUUd1SmVSQUdT?=
 =?utf-8?B?UTdzZVJIMnNKQ1Q3WDZUV1FRUG9vUG5MbDlzZ3pOVFBHT3N3bDdBVDJuT1B0?=
 =?utf-8?B?OEF4MkZwNUd3NGlhUWFpU1EvaTBKOXk3ZjhqNVI4dkxTM2JMb2NuWFRFcTE2?=
 =?utf-8?B?aldrT3MyNWVIcGFsb2pQSEJ5ZEZLTVpqa2xmOTZlc1c3L3hobVd1MmZrWWQv?=
 =?utf-8?Q?Jf97wz1UxToq5BRkeBBDUiRKO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3849998C743D774698911F09DD830A71@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tZQI2fPq5J/v3oPiXPimc3tlc7vw7TGBaDJDjkslx5w0egIP1b1UHdvBVMtRA0OVAn3G8U4YkXKoQEw+4KrgqHeryO3Oe6XqLMSyj/CHS4KiseFIz0poN5cQ2OtHokDuk9PgK4WmPDwjjMaQzx8UdAZ3PG6Ri2LauI4oGxP+oBLvA7ok4iPRHqVREqG/IkNqL+9QSr0G0LEw67V7RXjO9f0qpDscKBbnAGC9XojkYOmT6+dAP8EX/S3jq2tzhdsr5tJPsrcmlEUHcpUEyq6/F66+GXo0M7jLOA8iWLhZD7sIAmoTiCD9eXJfsIMiFxo3L6vDI2zu3gqY73HCx/JsSlh4S8+CHswTXvh0qzt/kAyw+jZdJeoX2SB8Ja7fZiXKUcv+KcqkyW7tHhBqfjCWOfG2urUi0pJebVG23qgGWNM2PxD1SYacQdcAfp2n4SsS1QtbB/agC62zXFqpTdoIRcqlZ/BlWcpmAjgUEe46eAalJCCR84dxHzWQrTaEN2lyfPwTCVdFUBn1Upv6bunTsZqKRNtVDIDqcoo9hHCgqYVn7zMrzQmUOdAVG+Af89U0zNKV3sYdBlG0DhJVZZTQxlrtF1lXfLTCt9yJNYU5lw2P2e6SlFNyAxAUe5XiG65Md54x8pEozaTcNORhcz3lOw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bb542b-05fd-472a-5a72-08dde76296e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2025 01:14:38.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNx/v5FaIb7lP+7NahhIs3P+kjstyT72YuzLisGeOx2XK2LHLvUg9V+JJpC5cWAidCL4PaaSvKZbZLjqNxBqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258
X-Proofpoint-GUID: rRCwvQCZBRxHUAaYcqQdmG1qk1iKcDOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDAxMSBTYWx0ZWRfX+lv9b8KpvNnH
 ruc0bTDBUgEpVyAOU2FBQLuXkHEiAtGRKNTmxlOHAndD+cR4N2PW2Wg6nx18kGdhZlb29WzEAL0
 ANntigNFVdCT/q+eS552ToOvNbaof7FsZle6rC8a78g+gtb1T1nVrpM9Yk7IELr51yPOXUJKMyw
 pO9AUpB8RtUPDq0g7Uakt/bz7h3n299gRGDrxpLufbiXK+pEamkwPiD3z/rk+F6rf1eDtEjCUZO
 xWinvP4G2J39mHVpnaDE0byaArSfPmnX/4E9M9DV3hT2faQmQz8Uxx76TXWni2fkWUs8UoZB8ln
 9n5r3FMFFGpYJ9Sakq/fGqjXOaNG8Y797LJKkjIn8QG0hk9/tQvZzGoY9FBC6KupIrbjY7TAnyW
 lqssKRZp
X-Proofpoint-ORIG-GUID: rRCwvQCZBRxHUAaYcqQdmG1qk1iKcDOE
X-Authority-Analysis: v=2.4 cv=DpVW+H/+ c=1 sm=1 tr=0 ts=68b254ec cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=kuZwRuSrUBaKYMlPJg8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290011

T24gRnJpLCBBdWcgMjksIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDI5
LCAyMDI1IGF0IDA4OjEzOjA3UE0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiAuLnNo
b3VsZG4ndCB0aGUgUE0gY29yZSBrbm93IHRoYXQgQSB3YXMgcnVudGltZSBzdXNwZW5kZWQgdG8g
bm90IHNraXANCj4gPiAtPnJlc3VtZT8gKHNvcnJ5IEknbSBub3QgYW4gZXhwZXJ0IGluIHRoZSBQ
TSBjb3JlLCBnZW51aW5lIHF1ZXN0aW9uDQo+ID4gaGVyZSkuDQo+IA0KPiBUaGlzIGRvZXNuJ3Qg
YW5zd2VyIHlvdXIgcXVlc3Rpb24gZGlyZWN0bHksIGJ1dCBJIHdvdWxkIGxpa2UgdG8gYWRkIHNv
bWUgDQo+IGJhY2tncm91bmQuDQo+IA0KPiBUaGVyZSBhcmUgc3Vic3lzdGVtcy9kcml2ZXJzIHRo
YXQgZG8gd2FudCB0byByZXN1bWUgdGhlaXIgZGV2aWNlcyBkdXJpbmcgDQo+IHN5c3RlbSByZXN1
bWUsIGV2ZW4gaWYgdGhlIGRldmljZXMgd2VyZSBpbiBydW50aW1lIHN1c3BlbmQgb3JpZ2luYWxs
eS4gIA0KPiBBdCBhIG1pbmltdW0sIHRoZSBQTSBjb3JlIGRvZXNuJ3Qgd2FudCB0byB0YWtlIHRo
aXMgY2hvaWNlIGF3YXkgZnJvbSANCj4gdGhlbS4NCj4gDQo+IEluIGZhY3QsIHRoZSBVU0Igc3Vi
c3lzdGVtIHdhcyBkZXNpZ25lZCB0byBydW4gdGhhdCB3YXkgYmFjayB3aGVuIA0KPiBzdXBwb3J0
IGZvciBydW50aW1lIFBNIHdhcyBmaXJzdCBhZGRlZCwgYW5kIGl0IGhhc24ndCBiZWVuIGNoYW5n
ZWQgc2luY2UgDQo+IC0tIGFsdGhvdWdoIG1heWJlIGl0IHNob3VsZCBiZS4gIFRoZXJlIGFyZSBl
eHBsaWNpdCBtZWNoYW5pc21zIGZvciANCj4gdGVsbGluZyB0aGUgUE0gY29yZSB0aGF0IGEgZGV2
aWNlIHNob3VsZCBiZSBza2lwcGVkIGR1cmluZyBzeXN0ZW0gDQo+IHJlc3VtZTsgd2UgY291bGQg
dXNlIHRoZW0uDQo+IA0KPiBSZWdhcmRsZXNzLCBJIGRvbid0IHJlY2FsbCBhbnkgZGlzY3Vzc2lv
bnMgb2YgdGhlIHBhcnRpY3VsYXIgc2l0dWF0aW9uIA0KPiBpbiB0aGlzIHRocmVhZCBldmVyIHRh
a2luZyBwbGFjZS4NCj4gDQoNClRoYW5rIHlvdSBmb3IgdGhlIGJhY2tncm91bmQgQWxhbi4NCg0K
SSdtIGdsYWQgdGhhdCB3ZSdyZSBoYXZpbmcgdGhpcyBkaXNjdXNzaW9uIG5vdy4gSSdsbCBjb250
aW51ZSB0byBtb25pdG9yDQp0aGlzIHRocmVhZC4gRG8gbGV0IG1lIGtub3cgaG93IHdlIHNob3Vs
ZCBoYW5kbGUgdGhpcyBjYXNlLg0KDQpUaGFua3MsDQpUaGluaA==

