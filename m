Return-Path: <linux-pm+bounces-34579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA4FB55878
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 23:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC035C1276
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0D273D6D;
	Fri, 12 Sep 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mINqDeTR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mbGnBm+k";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D3Y71ssM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC92BAF4;
	Fri, 12 Sep 2025 21:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713015; cv=fail; b=FoPHv7uReoZ99Ro0U00QU1uPGv9llHSXZYGTNjGKXFgBn0Tu4MdRfRKhJq6B2Gzlpv6dmaiKar/DKvTEDU9e55L7oHtAW9ODtjX+PGFuN81iipI631Tjqy+TESH/r4Vx2MUj77DnsM//rYxV8Id/FStiX6M2zXzKm8FjnTrWWmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713015; c=relaxed/simple;
	bh=Zvdk3cKcP3Jrpt/yRV8wpBcW1tGQ2w0Ox++zHDaaNfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5igOsncaXfnQKjQsL2ownV3duntOdZPiN//H51Iu6qqleGZ8qYyn6p/SmLos+haf0SIkEtwwAecvXbozHk+rXlTTupwhtpvcDCy6bu1rrpiWb4xWzdX8zaxN/cSPcJxfv09EKadd8bNqS3Ms3QtbockX1vbV7GqQbNHzIl9QoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mINqDeTR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mbGnBm+k; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D3Y71ssM reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLPIxs009686;
	Fri, 12 Sep 2025 14:36:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=Zvdk3cKcP3Jrpt/yRV8wpBcW1tGQ2w0Ox++zHDaaNfo=; b=
	mINqDeTRmr2OaO2Qxc6pre6/jQuNt9qp334rK3iMlqny2PiOxFy8cGOmAPwE7IsT
	uarleu3cHHKwgmio4U4NX7NJEUSyNeHV8mInTvAZD/dAb/4j89dH3AO7soyjSxw3
	f14RmRE/d3jeFQlReEaOmu6iYQNf2voRGllE1CLSKKRDkg5eD/1WnmzJMT1L/JBH
	JzJOLozHHqczhQUicV0CKlAVE/edu0UYnmkEYkLJ2lBK7M9ULf9UV7S38FNw12pX
	sqzkshi7zO57tVQO7RWE334AkWhglr8atTCOZPbT0hA56c9opEoRxTeOOtCYW22Y
	XxEA3XnaiayhikeUVwIixg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 490kynbq35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757712981; bh=Zvdk3cKcP3Jrpt/yRV8wpBcW1tGQ2w0Ox++zHDaaNfo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mbGnBm+kug2g4Nd6IkoFxHBFNpbAt+p9pVVnq3FsJ2nAAlAECtVVjG+A8WqcjwjOH
	 JW5/yrrA1YX8JVOfA6gzJHLGkI/c9ZxSw0zqw68vj2RpQir0Jah2+6hGwR0qqVDsKX
	 pcZ1iIgvlY2RfOZI08tst7oOAseEWOXGsying8CvpV8F5xSSUvnZp2qx+euc4dh4M6
	 1/bZ6iLlQ2EcfP6KobPWgZg12Njrw+uozJoJEZkthoFhEFZwSxV4W3LaWBrz1SswBt
	 1hLK6ip4hSJ4ub9JcWVbNAbxjdk/tff+BOnZYWBmphtFWN/jQ8LXlI/pnEHTsWdIeb
	 uvN4ldHLNtHUA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 666D840340;
	Fri, 12 Sep 2025 21:36:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 26E1FA0070;
	Fri, 12 Sep 2025 21:36:21 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=D3Y71ssM;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B58E4048E;
	Fri, 12 Sep 2025 21:36:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXG/RNybtedTqWD7jX6ISFtg/g2ekhWuzKGQzS74Wa23vMWNW2dP3NS1KGyehYHgfazxaqWNLJrS/1TLeIFg98yn/JacqrruSdr36XQixmyOxMZE89l50G2xM7ugox++o+kPJTpM+gXJjwGz36wWTn0QavDgKL5wOipLjl5jDteaOojEIhyIiy25WsoodEYHzvbdh+rRDpNoBxEhxgAek4PRwpYIM+aanxhMVn82LS0EEzkpoRAKtk5vgEzd9J0DWbjGmoe2GEpaQfQKTZxRqC5tTsDTcSfaDJO6LNbYxwe9OjSOOcNCDL+BwJA6CdwNQ2PfSJpxVBpgXLcBxO83Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvdk3cKcP3Jrpt/yRV8wpBcW1tGQ2w0Ox++zHDaaNfo=;
 b=E4kk7L2288IENUsQcWkT6dWaaI60mQSA4XVLd96EybDMQ+gmvr11JQk+6MWXl5+SZIWJba6KzyzjHW7Gbo7rv0bW2muCJDKb9LaP6mlflUvm5LvFs004tBMo48HAqyEo7JP8pRUDiydvxbdd2atuLO9ENm7p58Pu5heb/zBI5EGL4fE8EMPqKF1bW2jiL1WU/ra/kvcSrBuYgGFXT5m/CeQn7+AkMbKekg/ta18Yxv+aGmmzo0MRJkv1Pi1Y494zPHWJkDLnS8/GGD6GvqOmMHfJnU5ZdeZiyfDTTLLsf+hWNfTuSUxjTTB4iYH2rGvE4+3L2uLA+45wZp939bnIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvdk3cKcP3Jrpt/yRV8wpBcW1tGQ2w0Ox++zHDaaNfo=;
 b=D3Y71ssMzhHG6bp3r0ymMG5EpryomnH2ZO8TtwdyW/RELt+5o7QUkVaQCQG0frKdG7Ar2KRT+XaOFIr0Z/YW+NUoX4QjlfI1BOXzTNuFHTI+xxPC+tK7PLHeIeB20YU3Jm4K/N5RLuAmXRevKOCYd4rOlTL9NseS+aypS1bve0o=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH1PPF931B95D07.namprd12.prod.outlook.com (2603:10b6:61f:fc00::619) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 21:36:10 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 21:36:10 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: ryan zhou <ryanzhou54@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index: AQHcIaV6iqN+tbk/4EyT54IWmyl0IbSNNKMAgADLbgCAAhcfAA==
Date: Fri, 12 Sep 2025 21:36:10 +0000
Message-ID: <20250912213604.eoftwe6j67e5o3z2@synopsys.com>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
 <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <CAPwe5RNddK2=bvrd6h_xyxH+SDDx7kx2tyDKRhyuDGvHYewGvg@mail.gmail.com>
In-Reply-To:
 <CAPwe5RNddK2=bvrd6h_xyxH+SDDx7kx2tyDKRhyuDGvHYewGvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH1PPF931B95D07:EE_
x-ms-office365-filtering-correlation-id: fc992588-86a7-417e-970e-08ddf24463e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVltM2NjK3hsQ0t1SllLZ2JlZ0h0eHhSajBQUk51T1FFWVl4K211SzIxekxa?=
 =?utf-8?B?eFpYNkxXMnlxSy9EWTgrZ3RYVlY0UXB6b3FSeDBNYVAvVlFwSFFZU1FIbDc4?=
 =?utf-8?B?Z1BaTHorenlDVjE3WDZhNzNjeVg3SXBBNmFYcDNlVGpqc1NJa0trd1VxT3or?=
 =?utf-8?B?ZFdrV2EwNXFmUEdoTzRaY1pSZklmcUZiUllZSGtUaTFCMWM2N2owb3B3cDU3?=
 =?utf-8?B?NW9BQktDYThMTTRucG4wYmw5alBqNGpWSWdlcXlianF4c2xIV2djdW9mb1hX?=
 =?utf-8?B?SC9BVURvOVYwd3JjQ0FYWTc4MXNmamN6eTRzbVUvQWZ5bjBpWkgybWR3TDYr?=
 =?utf-8?B?a0ZIeHdPUkVuNUtQWldkQWM5OVJENzA4QmFwN3BsaUdXbkhqQkcreGxicWow?=
 =?utf-8?B?WmNTbkFFanErT2VLbXJ5QUdVcFBNaVJTSENWbVB6U3VoT1psZGtSb3U2bGdK?=
 =?utf-8?B?d2tRUS8yN0haWTBYV1lOWmhCZEM0VmcvNlNsMkJybHNQNFlzQlkwczMvUEh3?=
 =?utf-8?B?dzNTYVo0MTVxUjhnbzIzcFlEcU9tZjlQMzJpYmZHK2pvcXNVWVlBTHo2MHlL?=
 =?utf-8?B?c2ZKUk1tWm9ZY09IY0ZQTHl1c05WazlRUDdKMHV4YlcveENBcFF6NjBVeTJM?=
 =?utf-8?B?ZE8wRHo5SGNvQzV3RUdXZmd5WENzeWw2U1BsNnhxSVZBY2lJOTljdFZPK2sx?=
 =?utf-8?B?RnhSUnlheE9MS083NU9Rdjk4M29XZDFKQm1oeitIb0Q3WWZvVVFNSE1HWjdK?=
 =?utf-8?B?allSK2VkelBteWZGWjJjZ1FtZXR0ZWw0U250azJvcG43NVptMnJPalA5Y01j?=
 =?utf-8?B?QldoSEIrUXBKNi9kaE43bmtkcWc3KzVEd3NTZ3hBQ2luUlRXSjh0Zlh6eVdq?=
 =?utf-8?B?d1F4elM3OTF2SExRNWlobmQxbTJIOEptL3gvOFB3b1JrVytiTHJqMFd6b0hU?=
 =?utf-8?B?c2doWndtL1RzZnM4eC9OM0Nyb2tMc3YxcFY4UkhjS2pIa2YyQ3AyVkJzMEFV?=
 =?utf-8?B?QnhDNUtMT0tqbnF1NlRqcnltS1NwUTB6c1dDK29ra1JYVTFSaUpkajJRU0Fv?=
 =?utf-8?B?Z3hsNlhkMlNHZDkyWG5RMG9CdkVVbElPcjl6RHZTRk0wUERWZ0lqRzVzeUtO?=
 =?utf-8?B?VFNvT2JkQWszeHpzeTZ5aUZmMXpDcWV3SU40UWNJaXJtS0JZUTVSSmw1NHpT?=
 =?utf-8?B?K0VOcmxZdklHQzBYTHFtc1Q2Z0l1TlN6cm52Uyt6M3dhdjZERzZWWXZBT011?=
 =?utf-8?B?ejQvbmY3WHJLMnNmVzZkQUFMaWVwc2VPR1k4cGoxalF3MUJsRjVJdkJHdDlQ?=
 =?utf-8?B?d0NoVzdwSnRTbVJqK3hJQ2Y5QXJWOU1PdDJqYW1hRVhYaVZwMVFncWFtZUdE?=
 =?utf-8?B?Z2o0UFFKSHJwVTdTNm5OZFk0enZNWkJnTDBWRlY4MkVLUzJvcmJKTUl4bFhJ?=
 =?utf-8?B?SGh4azVIaEF4VVV3NjdSbk5TRFZpbTRlZUtVR0hNMUcyREhXYWYrSjdlVzlL?=
 =?utf-8?B?OHByamRjQUx0R1JZbDViUjlmNW1TMm1XVFlhUUdDcmxrU2hkY2dwL2dyMnpp?=
 =?utf-8?B?VDFxa2JHMHo5T0pOWkJUU3pIZjYvT1J1Y1dib2RnQjMrc2tDN05Kald4M2dM?=
 =?utf-8?B?WEhOMnZ1V1NZWDNCOWhVOFFjeFdpdmd5OGVOTWVROXNFcUVoeVZzK3VyMS9l?=
 =?utf-8?B?YWdVTGJRK29PbzBuM1ZtdmRkdjRJOFhtRk9FM0Fydlk2R0dPeXFEYUg1Y1NM?=
 =?utf-8?B?bEk5dzgra2ZRdm1oc25ZTCtOYzBMK0NoYU4rK1ZCaWtBc0p4M0VOdlhzaGJD?=
 =?utf-8?B?Rm50dmJjQW5yS1ZScUVhWVRULzhweXJGcGt3WFdpZ0hZemFpSDU0Q3ZMR2ZZ?=
 =?utf-8?B?aFdjNFQ0b2E3Ly95MmpIbVhxbnBCZmZDczlFcE1zUVFrdm9HV3dsb1Q0SFhs?=
 =?utf-8?B?bzY4dlFUeitQN2hHeXR1NW9LMWk2WVZWRGpTd25XTjBaeEk4WkZmWFdqNkls?=
 =?utf-8?Q?RnFsYdjfiB+eEm3PM8/UhhvB1LpBQw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Um9aaDVwU1pCRnA3QnBEdytpTnNRS0k0b0xnL2h4RXppWi8zTURBNWd1R0Mw?=
 =?utf-8?B?ZEU2MnhGbms3aVdObEQraGRaUVU4OVdWYXQ4b2hJZzJRUU0xV0ZzNThoWlFV?=
 =?utf-8?B?Z0FkMGFKQUlBMHVaVjFqLy84ajQvdlNGQWV4bXdiekEzQUdBTW0vbThlSjJy?=
 =?utf-8?B?b2RNY0ZNOXB5M290eDEzSjRXdXA1b3VoeXhPMVVkb1UwVmRRNGJaSkcxb2ZU?=
 =?utf-8?B?MHl0dVBoRGlMNmJHdTBiSktVTVdob3JoZ1F1YVF3VjFoS3BobXNHVkNyWWFW?=
 =?utf-8?B?MGxCM0Z0bnp1bytwUXdCS0pWY0FBVmJwbURHc01MVWh1VHUxZWcvR1RNN014?=
 =?utf-8?B?WndSVVp1bDZGamVGT2lCY05ocHhubnV1a2ZEeUUzNEI0ZjdSamJOczZmLy9I?=
 =?utf-8?B?R3o2bjdjNHNETkxEYUFqa1dYdld1ZkgrNCtlSGprdlZwcmR2RUZscWVKeEF3?=
 =?utf-8?B?ckc3ZE5ZWXdWN2VHTExta1QzM0xFZURpdkRJT0htSW1nbnFRcTVWRENGUFF2?=
 =?utf-8?B?Ti8wNDJPL0VlV2FNSk9KVFlaL2lFb2FxMHBWU3p4SmNwOHU4a05kM0k5UUxn?=
 =?utf-8?B?TUpHSHVWQ1NFOFV4RzJUYkZQV0RXdkZxclRGWDNmcVQ2b2pKOHQ4Ky9xRmpj?=
 =?utf-8?B?b2FYelhvclJoRWxmTmZvTWlsNEZZVElBMTdVZ0VuTGljS2JCUTZaUTE2Z3VD?=
 =?utf-8?B?Yk5QQWxwdDF6TEwwWldVcVhhOUNKRytGU3FENUNjcVk2dStVZG13aUYvcFR5?=
 =?utf-8?B?TmtvR1dqSE1oWDh3SGx0dWN0OVFkWnl6N1VrN2lvU3o3cHRKdWlNanNIK0lj?=
 =?utf-8?B?ZXRndldHQ0RhSmp3cm1xajdQOTBtaUxpZnZLM0s2ZmNrNzJNNENudy9GQ0Uw?=
 =?utf-8?B?ck43dmxkVkVJS21ISDNjeEdTYmRwbFQ3dUJpNDdsbk4rVTRjeDdJQ1pzY2h5?=
 =?utf-8?B?ekd3OXZGYmxacFFqRm03NEVWYlVwbHhPNWozdFlWVm1UREw5RE5IY2h5bDB3?=
 =?utf-8?B?OTk4MzNKYWt1T2tuaUQ4MWZmNHdxQy9UQWVxb2pwTGdLS0w5WWZJTWM0eEJM?=
 =?utf-8?B?cExtZjQvMVJjNE9MK1FVUDI4VjlqWUptci9ucm9XZStiWTZtWEhrdEpVM05B?=
 =?utf-8?B?UWxUeXBTdHpITGRzb2VtMThTcjBHZGM0anpVY08xdmdvNk41MGtNakpMNFFh?=
 =?utf-8?B?MWVjU3lhZUowSGw4V1plVkFBbDJqUDU3MnRKU3l5RUZzcXBQRjMxaGpsV3RN?=
 =?utf-8?B?TlgxNWpSVnJrUmRkeHl1ZEN0elBVZEdBemQzYlhZY3pmYWRMc1BFc1ducW5j?=
 =?utf-8?B?RXhHUkJZVnF5YjJlcE9HV2xFZjdaWmJRWXk5b1ZJRG93TnFyNXM2UkNjcksw?=
 =?utf-8?B?djVYR0xhbnN5c0YzanEzc3dXSnpTa0ZHamJ4R3o3blU2OW40TDRJM0hWckM1?=
 =?utf-8?B?WFRqOUZ5K2NwMnhkL0d4UE5QRlV4UG5MNHh2bG9xME13VHl2SXhzOWFyM1Rl?=
 =?utf-8?B?Yy9xaFEraTYzaXNvaDNyQVlvc0tDNmd1cmRaUHpsWmpRZldFVmFta3QrNW1t?=
 =?utf-8?B?OEFYN210NjVFU0k4S3NRS3ZQeDlzSUgrUmk1K0g2OWZsdThFSXEyQ1J6aVFo?=
 =?utf-8?B?MXUrSDBtUlhOQkVLZTFvVUZLTnJZcFpRUEFLWG1MQkttL2Z1K2dqa1hrTWtT?=
 =?utf-8?B?TlYrZ3l1Z25zKy93YnltelJZdDFtOHJSZEc5M1B5eGsyUm5XeVVkbTRubUR4?=
 =?utf-8?B?STh0Q3UyRlJiNVJOSGcrQk5tM0RyRytHZHZXelE0UHZjSmRnckFFSzhVSDZH?=
 =?utf-8?B?U2Y4NlBZbWpNZm1JS1pzM0h0QUhkaUJhU2JCUkZ2NndXcG5jN1FUNEVwdSt4?=
 =?utf-8?B?YkloTHdTODRUNjZEK2RNWWxlN3dldDRscEZYTU11K3c0YStlZlV4UTZ6U0Mx?=
 =?utf-8?B?eVZhT3hwUlNFNEJTdllXYlZ1eTVRbXhjMXRTL3ptek03bVd2S0crZjRxdm93?=
 =?utf-8?B?eWFpVlVTWXdSU2NEZmhoNG04VmQwZFk0Rnk1dlF0NyszbFpOYURTVmIvZExJ?=
 =?utf-8?B?eEVwMVg1SlZDZ3orZ2VDdGYwaFVWY3lnVlBhdDBhSHhGN2tVelJwSUtXbVZ6?=
 =?utf-8?Q?xbt9dEIMXQMS72GR1654oOqqe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EBA435528DED246BAB58BD298EEBBE8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2H3qyCk2DdbDrRVWRcQrrA3eYS2mm41cPnm5cqcspPgYXtA2/0kiVLJhy56/YuFzd/TqLt0sAlYBsZt2+pahPu2cprlgwfc9taaZFXL+5wlbW3stV5wSaujYn7ZPYVYf0OiEobd99v/RzZv9e5ytbs88nWpq+OEJRbqkdmGkXPeBxXzZ33ShwnrCyyBw99rz+ngZhSzO9e/8ks1gMAvwWm0FqNDohgTkpijxxUaB76NrA/nwOcYA+63ApZx6VO39zAivyFuI8IzMwVfHBOfv3No9Ofb96s09OVzoVZFIlhgfgMOrqFgdImx0wlJ4rPNfiyxv1k+BefF04oU++Wa6zED0smfK1/cBtSZzmqui9SCpnz6ZW+8MMlPUlSBUeo8+VrdsztryKpbebqfdMpy6l86UQWeA0kK0mzwUTrxLUVHlR1biYOE/dIJ7IenHdQJyDJXjj0yX/iuD1qZAx3I/Ff2/zxTWSl5kwgSSIQmxBpzUnM6JfFd2Gpnc7jfHNtI3xqei9TGJRc38HsckjW7rv5ETUA39Rq/KOXwZrXnmctVuykSLoSo9twtuIUd1czD6OIhsGjEkQZDGvO1uwqsppl++TeEuV36dYROeLjgapnTiwEjpn8RdxfGKFSJIYIKPe9sMeMPDJCH6qmlURQ9Whw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc992588-86a7-417e-970e-08ddf24463e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 21:36:10.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsAbAfg0D+TZE9B760Is1uq0FdAq/TrhoU9N24XUMHFzxjhmOlr2oABfqEoUaXukIQ2VBvLdgCaNOGxDo0XkKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF931B95D07
X-Proofpoint-GUID: 0q423nH73nWArb7NinBUZoBu0O77iPrK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwOCBTYWx0ZWRfX8H5nNYdLCjzQ
 xxYwTMn0VqFgiiRPEO2ikgo0OdvNjDarBL/kkuFuWM0X6rwqtLPPLg887F5L74Tb5bL8Cu4mCNb
 QVISeIjLvBBjsPzwph+aqeVrxAWN4WZ1C6qwUsBrA75+Q+uSbmH0o2/DEHFqHt6XTZg+PZLcG4s
 w8s+hQhSbx1tPKB7PiPobK5SwMAU9dy6xp569yDylOO0P/87ZMS8tpB2jkcMI8sywTM1TZecdt8
 AqPQJxOUrlLZA1BxGQHiD6G9C2ZAV0/iXndmw8lviaPTq6W6dhHxhkJv4AKyS9fJsWONYhkLF7B
 CwWQOL+2OpTg7gCM/2s1nxHmPiWq5+9duymSxO+b4rFmimJLrtzIEcKfc8wLzPhO50BNFfsbQxR
 cVcT8vM9
X-Authority-Analysis: v=2.4 cv=JvrxrN4C c=1 sm=1 tr=0 ts=68c49256 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=jIQo8A4GAAAA:8 a=pGLkceISAAAA:8 a=Eh9E7hVYVOD0Xz-rzgIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0q423nH73nWArb7NinBUZoBu0O77iPrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509060108

T24gVGh1LCBTZXAgMTEsIDIwMjUsIHJ5YW4gemhvdSB3cm90ZToNCj4gVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiDkuo4yMDI15bm0OeaciDEx5pel5ZGo5ZubIDA5OjMy
5YaZ6YGT77yaDQo+ID4NCj4gPiBPbiBXZWQsIFNlcCAxMCwgMjAyNSwgUnlhbiBaaG91IHdyb3Rl
Og0KPiA+ID4gSXNzdWUgZGVzY3JpcHRpb246RHVyaW5nIHRoZSB3YWtlLXVwIHNlcXVlbmNlLCBp
ZiB0aGUgc3lzdGVtIGludm9rZXMNCj4gPiA+ICBkd2MzLT5yZXN1bWUgYW5kIGRldGVjdHMgdGhh
dCB0aGUgcGFyZW50IGRldmljZSBvZiBkd2MzIGlzIGluIGENCj4gPiA+IHJ1bnRpbWUgc3VzcGVu
ZCBzdGF0ZSwgdGhlIHN5c3RlbSB3aWxsIGdlbmVyYXRlIGFuIGVycm9yOiBydW50aW1lIFBNDQo+
ID4gPiB0cnlpbmcgdG8gYWN0aXZhdGUgY2hpbGQgZGV2aWNlIHh4eC5kd2MzIGJ1dCBwYXJlbnQg
aXMgbm90IGFjdGl2ZS4NCj4gPiA+DQo+ID4gPiBTb2x1dGlvbjpBdCB0aGUgZHdjMy0+cmVzdW1l
IGVudHJ5IHBvaW50LCBpZiB0aGUgZHdjMyBjb250cm9sbGVyDQo+ID4gPiBpcyBkZXRlY3RlZCBp
biBhIHN1c3BlbmRlZCBzdGF0ZSwgdGhlIGZ1bmN0aW9uIHNoYWxsIHJldHVybg0KPiA+ID4gaW1t
ZWRpYXRlbHkgd2l0aG91dCBleGVjdXRpbmcgYW55IGZ1cnRoZXIgb3BlcmF0aW9ucy4NCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIFpob3UgPHJ5YW56aG91NTRAZ21haWwuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAzICsrKw0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gaW5kZXggMzcwZmM1MjRhNDY4Li4wNmE2ZjhhNjcxMjkgMTAwNjQ0DQo+ID4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPiA+IEBAIC0yNjg3LDYgKzI2ODcsOSBAQCBpbnQgZHdjM19wbV9yZXN1bWUoc3RydWN0
IGR3YzMgKmR3YykNCj4gPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGR3Yy0+ZGV2Ow0K
PiA+ID4gICAgICAgaW50ICAgICAgICAgICAgIHJldCA9IDA7DQo+ID4gPg0KPiA+ID4gKyAgICAg
aWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGRldikpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ID4gPiArDQo+ID4NCj4gPiBJcyB0aGlzIGEgZG9jdW1lbnRlZCBiZWhhdmlvciB3
aGVyZSB0aGUgZGV2aWNlIHNob3VsZCByZW1haW4gcnVudGltZQ0KPiA+IHN1c3BlbmQgb24gc3lz
dGVtIHJlc3VtZT8gSSBmZWVsIHRoYXQgdGhhdCB0aGlzIHNob3VsZCBiZSBjb25maWd1cmFibGUN
Cj4gPiBieSB0aGUgdXNlciBvciBkZWZpbmVkIHRoZSBQTSBjb3JlLiBJIGRvbid0IHRoaW5rIHdl
IHNob3VsZCBjaGFuZ2UNCj4gPiBkZWZhdWx0IGJlaGF2aW9yIGhlcmUganVzdCB0byB3b3JrYXJv
dW5kIHRoZSBpc3N1ZSB0aGF0IHdlJ3JlIGZhY2luZy4NCj4gDQo+IE5vIGRvY3VtZW50YXRpb24g
d2FzIGZvdW5kLCBidXQgbW9kaWZ5aW5nIHRoZSBydW50aW1lIHN1c3BlbmQgc3RhdGUNCj4gYWZ0
ZXIgd2FrZXVwIGZyb20gc2xlZXAgc2VlbXMgdW5uZWNlc3NhcnkgaWYgdGhlIGRldmljZSB3YXMg
YWxyZWFkeQ0KPiBpbiBydW50aW1lIHN1c3BlbmQgYmVmb3JlIHNsZWVwLg0KPiANCj4gPiBXaGF0
IGlmIHRoZSB1c2VyIHdhbnRzIHRvIGtlZXAgdGhlIG9sZCBiZWhhdmlvciBhbmQgcmVzdW1lIHVw
IHRoZSBkZXZpY2UNCj4gPiBvbiBzeXN0ZW0gcmVzdW1lPw0KDQo+IEZvciBVU0IgZGV2aWNlcywg
UlBNIHJlc3VtZSBzaG91bGQgYmUgaW5pdGlhdGVkIGJ5IHBsdWcvdW5wbHVnIGV2ZW50cywNCj4g
bm90IFBNIHJlc3VtZSB3aGVuIHRoZSBkZXZpY2UgaXMgcGh5c2ljYWxseSBkaXNjb25uZWN0ZWQu
DQo+IA0KDQpXaHkgbm90PyBUaGlzIHJlc3VtZSB3aWxsIGFsc28gYXBwbHkgZm9yIGhvc3Qgcmln
aHQ/IFRoZSBob3N0IGNhbiBiZQ0Kd29rZW4gdXAgYnkgYSByZW1vdGUtd2FrZSBzaWduYWwgdGhh
dCB0cmlnZ2VycyBhIHBtX3Jlc3VtZS4gVGhlIHVzZXIgbWF5DQpleHBlY3QgdGhlIGhvc3QgdG8g
cmVzdW1lIG9uIHBtX3Jlc3VtZS4NCg0KV2UgbWF5IGltcGxlbWVudCBkZXZpY2UgaGliZXJuYXRp
b24gaW4gdGhlIGZ1dHVyZSB3aGVyZSBSUE0gcmVzdW1lIGlzDQpyZWxldmFudCBtb3JlIHRoYW4g
anVzdCBwbHVnL3VucGx1ZyBldmVudHMuDQoNCkJSLA0KVGhpbmg=

