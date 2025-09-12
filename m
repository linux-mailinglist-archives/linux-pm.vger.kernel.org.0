Return-Path: <linux-pm+bounces-34583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4EB5591A
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BDBAC6243
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 22:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F3257820;
	Fri, 12 Sep 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NJW9L2au";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c6tVoS4v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WXiXOwF9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A92220685;
	Fri, 12 Sep 2025 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715835; cv=fail; b=UY/V148P4KeQVkiO+6vgynYVvSc7o/DEHXGIiZev3fz4i07ZvqayGD4mKAkYYTvvZ1CV082bsHugCzrCg0x74g3t8vxkkx5j1NXZxxQ0r2vLrj83VBajWovtgv0udPeWtP7sqCvIWGemOjQ4tlO9V//+FkIvlaQHt+tCARLj9RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715835; c=relaxed/simple;
	bh=KQraVMhBIPk5XeQpnGxOdHivPMAsq3u/8OpW7umf9r4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIL70iBkspLTtgb68OnEKG7TOuou0XNOcd4pQkaKNzepeREfVtMopJZ4pNRPZYOnnAUM8cB9deULRCw1Kwb0/7qOq/aZvAdgPAeVu92vC4RdSU+swkBXNlaETz9U7bkoLWyYF0265LALkKL1JwS+tGDXSfSQsk8nz6+aodyTddE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NJW9L2au; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c6tVoS4v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WXiXOwF9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLIfXA009705;
	Fri, 12 Sep 2025 15:23:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=KQraVMhBIPk5XeQpnGxOdHivPMAsq3u/8OpW7umf9r4=; b=
	NJW9L2aus1kpiihrKwIe+TBlb8teNQYgw/Plm/6KjwtUHRokac2Yk/NFufDwdXhY
	stP0D2+u8TAn1ZaYWrssyUmIN0OewjfoTUrf6R7U4VD5rdqM+ap2/UtqPdUjE7B4
	H6Ykk8FpxaXx8HL8HgA2yfF6qKakFOFFMU0xqn5D7b1vcStWwMVh8CT2GAf3pvjy
	IC6TbX85h5BfdsZOJG7X3OHckOR+qZgGEovNtYt7G/WO7eRY2QpWI2Pyu/28QWEz
	kleqIVkE7kKUpcn713KIMKdlejF1QQsTK6ieJc4Ehl09IyLd988MW18U+BGnurVH
	M0N1wJ1jiMPSoV3uJ5I3zA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 490kynbud7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757715818; bh=KQraVMhBIPk5XeQpnGxOdHivPMAsq3u/8OpW7umf9r4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=c6tVoS4vRxr0L+A7mCZ8cSPE6eVgkCXqVccZPq0nLRx5MaU39fjI2fY3a4Yunwk9w
	 oasjybvD9rwQX6RZfrPPtB9rZVCry0Q15pjN3jW8asxcqb9uUJz5O5aiyZ7Eua4YAC
	 uUY3VOZJre2eOAog8obb1ejhdlk48lY1967Jslew0VCpBp4XJmEHyvL4OCuPDiSipE
	 JoQ7Dg3+y5hPWRe+EtcQyh5MnVkuZ5unitrjfWyEgA/S4suIk+i3QwNzrH2wEi8630
	 xGNTCTxzT7WwhRK7Uc07bZImmpNoDBLKH+QWFSxxuNPWbXijO3IzDLrkAfZOcO01sY
	 Wrg2e7H7fvWmg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1468A4035D;
	Fri, 12 Sep 2025 22:23:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D264FA0070;
	Fri, 12 Sep 2025 22:23:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WXiXOwF9;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 832B640347;
	Fri, 12 Sep 2025 22:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7hkzlw9wZRIiivGzmirWTvgeJdpBhH/NvqXFo6y8AhjEDcgqeiHwRT+mVLkmTDBKAP8D5KPeF5E1KDmQqnmUOUo7NsaT90o9xdZ+xaV3vmTUvhYAYO+vF8Vk5VY4olLg3tsKx91zsGCQOHiFztaZOdY4Em9l4cbHcHXe0eN1GOEAdBYmzqibDJaRQ33hHFwJT+ry/ovUmGutPVsS1cZjrqG63tU45faBtInlhTLOI0xMc+Cao1rahAX2aLGLjcDmj1IHwk11649HEEmTCfipauvWmDdafL9gcj1FfV8oBJ5kJ+ui5557Mvwm0+TOk3m3nYZycmadfmI4PmFdwoSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQraVMhBIPk5XeQpnGxOdHivPMAsq3u/8OpW7umf9r4=;
 b=CplV7HEO3IF49J1VMqRabP83FhtC+J7ojWGIQg9GpiQuTGGlTYGpMNwu+EtIoltpkPEYq4KDZJmCiz6s7fe5ydLfxRAzjt+1EUOHatipW4Lb4K3TJLO4SmJ8jc84n176HIK2ufLrkDZQ79DqdA+LdKbXilerz9b6cV5gSCrGhevBOmieTCbxvbRbY28vmapd3buQziq7CBhwksMkFnTtgJaNHRs8nN2+e4xFotij6JyxYt35R5hmdSiO7fbie3z07GVA9pmUuTkJm3ET5e0A2rjdEToOHWfaWnqV39qzvUDrFz6m4n/fsxi4dPBnX26KxptVszK4QB/4DcQeeNbxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQraVMhBIPk5XeQpnGxOdHivPMAsq3u/8OpW7umf9r4=;
 b=WXiXOwF993D1C7XTmXunKAWZMOrLQkGDMTy6vQJkT5BHeG7d9aSaTzk2tw080YE9cQG3qTkS6jIoSdwNDrt8oTuaxFnqkGiaEFaFpyY2laLlg7AGp18i+GGlCxjAZ80dExYLFl7yu+eJkN57XOjBpF02BULO7S22P1qAmQNXI9Q=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 22:23:29 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 22:23:29 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
 AQHcFpwLhCI1/x1c70ew6xjKTgeHrrR1Q/eAgAFHIgCAAAwMgIAARF6AgAHzEACAAAu5gIABLTQAgAAJ7oCABLIyAIAAEHGAgABk5QCAAqxQgIAAKBIAgAEQTICAAALrAIAANoUAgAAWWYCADM0MgA==
Date: Fri, 12 Sep 2025 22:23:29 +0000
Message-ID: <20250912222321.ct5ezgvsgyvos2ah@synopsys.com>
References: <f8965cfe-de9a-439c-84e3-63da066aa74f@rowland.harvard.edu>
 <CAJZ5v0g9nip2KUs2hoa7yMMAow-WsS-4EYX6FvEbpRFw10C2wQ@mail.gmail.com>
 <CAJZ5v0gzFWW6roYTjUFeL2Tt8kKJ_g5Q=tp2=s87dy05x-Hvww@mail.gmail.com>
 <38b706cc-5966-4766-9165-51935fdcd790@rowland.harvard.edu>
 <CAJZ5v0h=i9XF_SQMOhz3P+4SAH3Qy-r1oUiiw7Bp=PcRnJjVbQ@mail.gmail.com>
 <59951c2d-60e8-47a8-a43c-00b92e095043@rowland.harvard.edu>
 <CAJZ5v0i6aFarDU8OTZ_3VS9dp4SaqKJ0SuiN4gFSxrRoAAV5CQ@mail.gmail.com>
 <24a69e4d-2f10-43fb-81d4-f7eea44a6b8d@rowland.harvard.edu>
 <CAJZ5v0gUjgY45WFye5STJ7kv30O4rQ=23qkOsHEMSxfwg8jO4g@mail.gmail.com>
 <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
In-Reply-To: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8049:EE_
x-ms-office365-filtering-correlation-id: 8d38a0e8-5e2a-4aa0-7081-08ddf24b001d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEIvS2pWQS9Ua0UvV21LcU9sTDBIS3F3L1o0MVNUOTZ0aUFHa2VTdFcrK2Rx?=
 =?utf-8?B?OTg3S0xUWWVYNDI2Vktsa3ZNUDlWZjVOUG9YUXBzY0Q1UlEvVjJMMFNDYWJU?=
 =?utf-8?B?T2ptRTZKUEN2b0NDcGFENFVvRlE3anlZNkl6SjVzYWFLRFBhT3NjcENzTEdT?=
 =?utf-8?B?ODk4QVRmNU5PaFN1SUh5cXI4Mml0MHQ1NmRXK21GVUZxeU9WLzlSNEpBbjFX?=
 =?utf-8?B?dVMvRTZPWWQ4UHVPL0lnOEtvRzIyS29sUDVUWVpObXpFZ2lBTHRuQ2hGek0v?=
 =?utf-8?B?aEVCd3hlMU52RlBRNEV6VVFiS1Y5UEJZVksvV3AvU1h3RzhXOGhFelAwcTNZ?=
 =?utf-8?B?M2t4a2dycWQ3VHZxNkJEQXhNOVZ1YjhSZWRCNW9HREwxdDMzb09IVGdaU2l5?=
 =?utf-8?B?M05Ea1M4a3daS0wvNXB0Nkw2N29YTXQvTXlnMk1JZlZ4V3hHT21SQjNkYWIz?=
 =?utf-8?B?M2kvMzJvdnByNkIyNW1BNWVUOFQxTUZvbUsxQk8zYTFCUS8rb1lYVERkMlMy?=
 =?utf-8?B?N3NVM3ErKzN5emt1WVphMHZmTHZRZEU5NFJ5SlcrNGQ0dUJ1Ty9qUkhTNkh4?=
 =?utf-8?B?Y1Q2WkZxV09OeUZrWVcvZlVmR0JYeWFDWlZhK2dNb3V2QWY1K1JnSUZ0TzEr?=
 =?utf-8?B?cXJKNHlOaFVIeEZhRWlUdm10SWN5ZHNrbzFxU1huc2prYU1tcW9sNzJMVjk1?=
 =?utf-8?B?OGtvUG12UzJtTHFYVE1YNHBjVEdCTFZBU010QmwwNkhyU1dFNVlhbHY3Z0I0?=
 =?utf-8?B?ZEhsSzVQd0ZZOTVwRzQ1SElxM1Axc2p3UGRCR2FnWER2VFd2bGhpdVNJbmZY?=
 =?utf-8?B?ZEhMOHNPTTgrbkRjejJUVUhGWXcxUzhiQnVTL1N1SjYwQXA4VjljQ3JDWlk1?=
 =?utf-8?B?OG8zb3VZTHlRODJKdktYK3U4Vno3VGd3WmIvaWcyWDFYckg4NXdSd2JENDFU?=
 =?utf-8?B?VWJESWowQWZURXFmc2t3SURvZWl1SnBxYmwzdmkyQ21RRFFCT3I0WmpVZUVu?=
 =?utf-8?B?N1QzQmVSVkZqTlhKSkV2eW9iVktrNWVqcDc5bUhrQXVsUnU0bEw1M3Y5YlNL?=
 =?utf-8?B?T1VWZkREYzdUMkxhenZIbGFkRXNBZnN1TVdINDFvSno3VzJTUkJ5Zkt2OUFk?=
 =?utf-8?B?eTBROWJYWGtaV2Z6dkN2eW1weWs5K2MzR0JtaGdLM2gwVUppVmVaOHZLZnEz?=
 =?utf-8?B?WDRLSndCWEE3eDdFWnVJeHlYWDBMZGZJakp6a2Z5NFpIRGNqc0ZoVk9zandB?=
 =?utf-8?B?eXg0alV5ajVzYUVpalliVlEwSFRDdG5pbm5IR0ljOTBZNFBzQXNXN0c1T09G?=
 =?utf-8?B?cytaU0trd2NtQmRLcW1tZlJ1c3NtaXJ1UTEyekZCcm1oY2RRdEJlNTN5S0Ux?=
 =?utf-8?B?M25jSm1QbUdmMzBMcm8wTW90Q1ZvOUJDVGxXelJpZHloRlQ0Qkg3WUxoYVBp?=
 =?utf-8?B?Z0FHSU93QXV1cityWFNIdStoWG9VblNWaXFMWHFCeUlPUHFwT2xUNzBOWFo1?=
 =?utf-8?B?UWxqNjlQMUxRR2x1S0hMa1pMTTU1L1hrbWNHWDVCTTNyNUQwc1h0eGIzTmM0?=
 =?utf-8?B?VzFzVDFJYTkzT0g0elBqY3RmWXd3MllDMkVRUTk0REY1Z3NFdHZYN1VEQ1dQ?=
 =?utf-8?B?VS9yOVRKMk44NnY3bWM0VlpmZThtbnpGSm1VWkpTZkxTQVlXZWtCWDR6S1Zs?=
 =?utf-8?B?NmxaTFAxL1dNcWhqc0U1Zko5dG0zeVFVa2FZdG1rc2tnOXJOZk02THJod1dW?=
 =?utf-8?B?Qy96dm0yYS8xcitIUyt0V1p1RE1GQjlDK2h6ZndiVXRUNWpuR0VXNzdyRHpQ?=
 =?utf-8?B?UC9JMlRYUHFEWVk2UlJlQkVkM0RkWnlrSXg3RVFuY3JYYWtzbVJWeEF0YlQ2?=
 =?utf-8?B?andLdjZlMW5nRlJDaFBldUtIdVo0dVhrR3J0bnpMR3NhUmNxZS95bEs1VDNv?=
 =?utf-8?B?SmJ2ODgxdWpmbGh6RmJTZ1FKZDAveFJoTVRhdVdpNlZlNlF5WVVGOE5pM0JY?=
 =?utf-8?Q?eY7+bjWtnew0GMFEzLllTlmcegmB/I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTBVSkhnSm5ZUWY2OXF4d0lWQkh6cHpIUVZ3cVdNYmpuVWRCOTN4RVRKYVVU?=
 =?utf-8?B?RWZmdWZXVjN1U2YzZ0Q0aldrNnh3MC9OZE1VZnV0S1pVKzVwWG9RWjRQVEtn?=
 =?utf-8?B?MEZDM2pxZnZ3K0Jid2VUR2VwQW02ZzZueVU4WnZEV1ZJZU9RaE15OFRWUWxD?=
 =?utf-8?B?MFAwUjloYkh6T0FzdVBja3IzUnE5OE9PQ3AyKzdrOWQyL1JZcjh0d2YxYUVO?=
 =?utf-8?B?UlM3TFVsQktSMnF4Q3ZhaXlvOCtYaE5zeUNiR212dHRzUXl6RDNtUzExb2Rl?=
 =?utf-8?B?aDhrWmFvb0d5RmpsOWRBU211VFZvWlBKdHNONlJMMUhtdW1IeWJjUllsdUlj?=
 =?utf-8?B?S2VSQ0Z4cGd1YUxzakYrS1N6R0VaeXdhV0Z1NXh5TUNoZ0tteGYweGdGUWQx?=
 =?utf-8?B?bEJyU0ZNemZLai90Uk1aOUNlNDA5WnNkRkFpZlg5WkxGQnRGcFBaQ0owaURE?=
 =?utf-8?B?UVIwQ20wZWtTVENTRVF3b3JKNEJvNmgxZVNxODBGdHc1WldTTE14WEpUN2d2?=
 =?utf-8?B?S2FNcHFGM1BqTUY5RXhybkdja3JKaVhrRHBqaWhZb05SV2JrYjc1T0pGRy82?=
 =?utf-8?B?dmMzRVRNeWRIdU5WWDZvWU1aejhBTUZUSmlQY3l4TGRGTkx4a0pIczRoWE11?=
 =?utf-8?B?REpJZ3JrT3lvZTBKZzgybW0zVmxYVmsydUoraiswLytNQ0VvN0V5SkFNYi90?=
 =?utf-8?B?aWM0b2R4SzRhT1lESEY3UjJ3NkZXbnBZRStrRHQ2MEQvaUtLblkzYTBHTXZP?=
 =?utf-8?B?SUxaRHpzWTVEdHM1NnJ3M0wyeElQZ1NYa3JoWFpSbU5mTEpRVHJiZ3FuSStD?=
 =?utf-8?B?TXN2RmxOalE5U2t6T1JRZkxYMkY1b1c3aHJYenlWQmp0TUR6Q0tIOFYrTWty?=
 =?utf-8?B?NTZCQ1h3bWJJYXBobXg0RDFWdldhWmllYkRiOHpvaDZIblRIU2pjd0N3QlJm?=
 =?utf-8?B?K3o1WkRzM21Gd1BOWFRjU2NWVWQvT1ZJSTRNTmVrQytXUkFlU0lSU2ZEOE9C?=
 =?utf-8?B?NE1qK1BDK202bkR2OE45anZZbkxjUFdkVHZEYThqRHVrNVZ4V25lVnphOERt?=
 =?utf-8?B?K0hDRWJMdG1sUG8zT2JSa3RMTmVyejZDRGdtVFFwNUFZZUJxQmtCb0h2RmxN?=
 =?utf-8?B?Zm1rTjJubWNGWDcvdHpGSjJ5T3NSUHUyTitoL1JremQwL1V2Q3c4RURpM3lv?=
 =?utf-8?B?SnZKVXUxaExGbUtCMkJyMlVmQ2ZTRkM1K2tXQ3piRnJZWFNJeTFPYmVCMEJi?=
 =?utf-8?B?Z2FLYmtrdHUzVVp5aVpBcHVXMVB0OUlncmZ2VlRTcHRLSlRzYTFpT2xEOFhV?=
 =?utf-8?B?Q0REZURCQ3V3RkE3T2ZKMVByRlVZdSsrUXNnUmZPY2Q1YTczRTlXQ2NhSE5Z?=
 =?utf-8?B?aWpCWWpwWXBjWFdoajZkem4vdWl3aGtKTXNEeFllWDUxbmhEUUY1WHM1YXpK?=
 =?utf-8?B?M0Q2VUU3aWJvQWRIWVQ2ODkwZUVlaU90RTdIa0dDcjh2MkxySzE3SUhENDFa?=
 =?utf-8?B?enUrcGN1c2RyUjRpMWlJYlRrMFNleS81Ym1pblgvWEtFN1JjNVNNeFhkM0pF?=
 =?utf-8?B?U3R3eVBPb08rRW9YaVVGZVVwNDk2SFExa0x3MERkdlBUM2xqRzRUcGl3dzhz?=
 =?utf-8?B?RjJ0Zmw3WjdnZHZwd1JKVXNiVjExMXVScG80anZYb05SWlVKUmQyUHMrbkpl?=
 =?utf-8?B?Rk9TdlQxNGpiMEpNbzI0RW55ZTV4eGhHemdudzE1cXRlU0thTXg1aUd2NjRl?=
 =?utf-8?B?MFJrRVk4eGw3STVjT21MTjdFSGZxMHZxUjlZOVdCaVRjVTJFMjJ4eThCd2dK?=
 =?utf-8?B?NWUyVlA5LzZnOXZTVVVRUzV6WW1jS2dpYVNET0JJOGJQbXRuazlKRkJEaGFj?=
 =?utf-8?B?NXI2SmVMZytwNU5OUTE5Mm1lcksyaFNvRlRLeTFWUHRyK3RaaDlGMFo3T09C?=
 =?utf-8?B?SjUxMmJlVG5PcU4wRkphUGJCbnBJR1JqTFVyMlRaOWJKeFJCVmg0cjVVMFk2?=
 =?utf-8?B?eWtCbWo2emwySTAzcnBwcXNlS0orVUk0OEtESUFQUHJ0UDM1eGlEM1NBVDZY?=
 =?utf-8?B?SXNmMTNjakFNL3ZqYSsyRldqL283MC84VTZPU2ZhTDgvNFhQSURZNFFoVEk1?=
 =?utf-8?Q?6e3jheCiv+GFJ7PoYjvgkivAq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57C1A6F1610EE948AF8C7E8A3C00F4F4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LkblD32MMSK9W0Ia1bgPKeOn6wFDwqAaEJ+lUyfQ5KisWPqpzTQrhzB+a+qW00Jlymf+l+4Lo10fYN4JE8VpK5qz0kwdcoZ/aIpLzmv1K/leyYg6smzCBDjJAz0ccGvskPhLqnCsAN8uizg/g+/oOxLqM9mw/AsgpBP+1Mh6Pv0tQsbp27nLN5C4nBdDMys28o3bBPyX8DWCGN+X3b16FHOVEjMSCKR+BLOKyIjJX2Qy1EDh+lWaz/g1FdxW/uOq8PwE+qWZ0t6/qXyfg4k8FsFSlujQEYIG1SYHj5z2r487x3+yWUZtvFI0muwSwL2mk48QOL1yu2LUjwhSulusUOF0SG1fz/zukwRbw0CbzG/DQZuNwYmTd6sPBSd+VPVrIQxS0c47oVT3zBVNQ3YwhHn9bD9qCctK6s4CTaIsIxcnMCxuVf5nJ/QyBHgHhbkNXO/3v6qNTJqXDN76RpJ3P8kwnz4glDZEFX123qAXzUv/t7bRhgMNm8OIZTH4D8/vSCs108OYjaUvEv8cg/P1ZPwOMSniYfX/gBaHbviRZvXzz8Lp8SVXGMPKi8MvfAcAkGHJ1aLVGJUOsJYZDVpBd+lOzWXy5KxcXEceHuM8GbBQGbhDWI1kXhWzY7CqHQOs5DrvP6Ctr02ECvKWfylGcg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d38a0e8-5e2a-4aa0-7081-08ddf24b001d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 22:23:29.4710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrV7Iy8zVRPUs4k3nHGUEO/VWAZznblCjq9DZYL0mgYDjdOlygMfGiTcLjMjLjZ9cQKyolrRuRmNbRZnlBG8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
X-Proofpoint-GUID: -u7HzDs4caTIYer4Ak4V9_UPLPCoMhVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwOCBTYWx0ZWRfX/y8ikfInYIee
 4Ac6E1E4xCm9br7MQWy/0TSUye+uj7ua/mcpnDC4j6Qf+uVWBuF9bUfBMI+JtcYUNx3OHlBSFLV
 sUcwfcQyu9bzDinSnwXGGMCRWkJf4luMu9rwQ1EQuHqZqa2Qije+DrkXxClL12aAPXIFm5OljN1
 jOOQ0hinEbWiaCyzgLF2Dh/DGZbvSpO1hfKLMFkIMsswWmfEt6W4N4VLn3wnbC03wLaseWBUuSJ
 p7r8QivBQaWlNKDym6/emjzcYOG+A27Xa5UOz4ahA59tRwi5anD5Nx6YnDm7qLJJYRbrmHh52Kq
 E87YHL1sSXhDEpDWB3yUVAnOQUslaGG4wSwV+5OwzztNJwujXOIM7rEfb/cnO5FGjXvWQVP1jje
 VtH1yYBY
X-Authority-Analysis: v=2.4 cv=JvrxrN4C c=1 sm=1 tr=0 ts=68c49d6a cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=ctB_U5TL86bATVxhhREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -u7HzDs4caTIYer4Ak4V9_UPLPCoMhVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509060108

T24gVGh1LCBTZXAgMDQsIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFRodSwgU2VwIDA0
LCAyMDI1IGF0IDA3OjM0OjIyUE0gKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+
IE9uIFRodSwgU2VwIDQsIDIwMjUgYXQgNDoxOeKAr1BNIEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xh
bmQuaGFydmFyZC5lZHU+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgU2VwIDA0LCAyMDI1
IGF0IDA0OjA4OjQ3UE0gKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiANCj4gPiA+
ID4gU2F5IHRoaXMgaXMgbm90IHRoZSBjYXNlIGFuZCBzYXkgdGhhdCB0aGUgZGV2aWNlIGlzIHJ1
bnRpbWUtc3VzcGVuZGVkDQo+ID4gPiA+IHRvIHN0YXJ0IHdpdGguICBUaGVuIHRoZSAic3VzcGVu
ZCIgY2FsbGJhY2sgaGFzIHR3byBjaG9pY2VzOiBlaXRoZXINCj4gPiA+ID4gKDEpIGl0IGNhbiBy
dW50aW1lLXJlc3VtZSB0aGUgZGV2aWNlIGJlZm9yZSBkb2luZyBhbnl0aGluZyB0byBpdCwNCj4g
PiA+ID4gd2hpY2ggd2lsbCBhbHNvIGNhdXNlIHRoZSBkZXZpY2UncyBwYXJlbnQgYW5kIHN1cHBs
aWVycyB0bw0KPiA+ID4gPiBydW50aW1lLXJlc3VtZSwgb3IgKDIpIGl0IGNhbiB1cGRhdGUgdGhl
IGRldmljZSdzIHN0YXRlIHdpdGhvdXQNCj4gPiA+ID4gcmVzdW1pbmcgaXQuDQo+ID4gPiA+DQo+
ID4gPiA+IElmIGl0IGNob29zZXMgKDEpLCB0aGVuICJyZXN1bWUiIGlzIHN0cmFpZ2h0Zm9yd2Fy
ZC4gIElmIGl0IGNob29zZXMNCj4gPiA+ID4gKDIpLCAicmVzdW1lIiBtYXkganVzdCByZXZlcnNl
IHRoZSBjaGFuZ2VzIG1hZGUgYnkgInN1c3BlbmQiIGFuZA0KPiA+ID4gPiBkZWNsYXJlIHRoYXQg
dGhlIGRldmljZSBpcyBydW50aW1lLXN1c3BlbmRlZC4gIEFuZCBpZiBpdCByZWFsbHkgcmVhbGx5
DQo+ID4gPiA+IHdhbnRzIHRvIHJlc3VtZSB0aGUgZGV2aWNlIHRoZW4sIHdoeSBub3QgY2FsbCBy
dW50aW1lX3Jlc3VtZSgpIG9uIGl0Pw0KPiA+ID4NCj4gPiA+IFRoYXQncyB3aGF0IEkgbWVhbnQg
YnkgbmVlZGluZyAiY29vcGVyYXRpb24gZnJvbSB0aGUgZHJpdmVyIi4gIFRoZQ0KPiA+ID4gZHJp
dmVyJ3MgLT5yZXN1bWUgY2FsbGJhY2sgbmVlZHMgdG8gZG8gdGhpcyBjaGVjayB0byBzZWUgd2hp
Y2ggcGF0aHdheQ0KPiA+ID4gdG8gZm9sbG93OiAoMSkgb3IgKDIpLg0KPiA+IA0KPiA+IFVubGVz
cyAic3VzcGVuZCIgYWx3YXlzIGRvZXMgdGhlIHNhbWUgdGhpbmcsIHNvIGl0IGFsd2F5cyBkb2Vz
ICgxKSBvcg0KPiA+IGl0IGFsd2F5cyBkb2VzICgyKS4NCj4gPiANCj4gPiBJbiB0aGF0IGNhc2Us
ICJyZXN1bWUiIHdpbGwga25vdyB3aGF0IHRvIGRvIHdpdGhvdXQgY2hlY2tpbmcuDQo+IA0KPiBJ
dCBzdGlsbCBoYXMgdG8gY2hlY2sgd2hldGhlciB0aGUgZGV2aWNlIGlzIHJ1bnRpbWUgc3VzcGVu
ZGVkLg0KPiANCj4gPiBJJ2QgbGlrZSB0byBtZW50aW9uIHRoYXQgaWYgInN1c3BlbmQiIGNob29z
ZXMgKDIpLCBpdCBtYXkgbmVlZCB0bw0KPiA+IHJlc3VtZSB0aGUgc3VzcGVuZGVkIHBhcmVudCBv
ciBzdXBwbGllcnMgdG8gYmUgYWJsZSB0byBhY2Nlc3MgdGhlDQo+ID4gZGV2aWNlIGV2ZW4gdGhv
dWdoIHRoZSBkZXZpY2UgaXRzZWxmIHdvbid0IGJlIHJlc3VtZWQuICBJJ20gbm90IHN1cmUNCj4g
PiBpZiAoMikgaXMgcmVhbGx5IGF0dHJhY3RpdmUgdGhlbiwgdGhvdWdoLg0KPiANCj4gVHJ1ZS4N
Cj4gDQo+ID4gQWxzbywgaW4gdGhlIGV4YW1wbGUgd2UndmUgYmVlbiBjb25zaWRlcmluZyBzbyBm
YXIsIHRoZSBhc3N1bXB0aW9uIGlzDQo+ID4gdGhhdCBCIGNhbiBqdXN0IHN0YXkgaW4gcnVudGlt
ZSBzdXNwZW5kLCBzbyB3aHkgd291bGQgaXQgbmVlZCB0byBiZQ0KPiA+IHJlc3VtZWQgYnkgInJl
c3VtZSI/ICBBbmQgaWYgdGhlcmUgaXMgYSBzcGVjaWZpYyByZWFzb24gZm9yIHJlc3VtaW5nDQo+
ID4gaXQsICJyZXN1bWUiIGNhbiBqdXN0IGNhbGwgcnVudGltZV9yZXN1bWUoKSBvbiBpdCBBRkFJ
Q1MuDQo+IA0KPiBTbyBpdCBhcHBlYXJzIHRvIGJvaWwgZG93biB0byB0aGlzLCBhcyBmYXIgYXMg
LT5yZXN1bWUgaXMgY29uY2VybmVkOiBBdCANCj4gdGhlIHN0YXJ0IG9mIHRoZSBjYWxsYmFjayBy
b3V0aW5lLCB0aGVyZSBzaG91bGQgYmUgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJaWYgKHBtX3J1
bnRpbWVfc3VzcGVuZGVkKGRldikpIHsNCj4gCQlpZiAodGhlIGRldmljZSBuZWVkcyB0byBiZSB3
b2tlbiB1cCkgew0KPiAJCQlwbV9ydW50aW1lX3Jlc3VtZShkZXYpOw0KPiAJCQkuLi4gd2hhdGV2
ZXIgZWxzZSBpcyBuZWVkZWQgLi4uDQo+IAkJfQ0KPiAJCXJldHVybiAwOw0KPiAJfQ0KPiANCj4g
SWYgLT5zdXNwZW5kIGlzIGNsZXZlciwgaXQgY2FuIGNsZWFyIG9yIHNldCB0aGUgU01BUlRfU1VT
UEVORCBmbGFnIA0KPiBhY2NvcmRpbmcgdG8gd2hldGhlciB0aGUgZGV2aWNlIHdpbGwgbmVlZCB0
byBiZSB3b2tlbiB1cC4gIFRoZW4gdGhlIA0KPiBzZWNvbmQgY29uZGl0aW9uYWwgYWJvdmUgd2ls
bCBhbHdheXMgYmUgdHJ1ZSB3aGVuZXZlciB0aGUgY2FsbGJhY2sgcnVucywgDQo+IHNvIHRoZSB0
ZXN0IGNhbiBiZSBza2lwcGVkLg0KPiANCg0KU28sIGNhbiB0aGlzIHNvbHV0aW9uIGJlIHRoZSBk
ZWZhdWx0IGJlaGF2aW9yIGluIHRoZSBQTSBjb3JlPyBUaGF0IGl0DQp3b3VsZCBpbml0aWF0ZSBw
bV9ydW50aW1lX3Jlc3VtZSBieSBkZWZhdWx0Pw0KDQpTZWVtcyB5b3Ugd2FudCB0aGlzIHRvIGJl
IGhhbmRsZWQgaW4gdGhlIGRldmljZSBkcml2ZXIgYW5kIG5vdCBQTSBjb3JlDQpyaWdodD8gaWUu
IHRoZSBjb25kaXRpb24gInRoZSBkZXZpY2UgbmVlZHMgdG8gYmUgd29rZW4gdXAiIHdpbGwgbm90
IGJlIGENClBNIHVzZXIgZmxhZy9jb25maWcgYnV0IHRoZSBkZXZpY2UgZHJpdmVyIG5lZWRzIHRv
IGNoZWNrIHRoYXQgaXRzZWxmLg0KDQpCUiwNClRoaW5o

