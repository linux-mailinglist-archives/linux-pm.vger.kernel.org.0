Return-Path: <linux-pm+bounces-33428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA4B3C2D4
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 21:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C6C189F25B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D22376EB;
	Fri, 29 Aug 2025 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kbJbyGSb";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kiU7kNE+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="X8ynM8uM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0442367D9;
	Fri, 29 Aug 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756494487; cv=fail; b=R0lV9SKGYFYlS7hyG8FihBQ0h0jdiUo6I8n3wzaKknFt2czzl0MaWzR1BwqdSkFR7ewoO7X5TmD9R2J+of1dqnZuO7Sb2WEyQJobQTwE+pxS9HlCeWpfy6WY/iWaXCJWctyHyHg3cPVU1X0VFkDMigejDbzTQ/76LGF3RefRj6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756494487; c=relaxed/simple;
	bh=xWXJKb+UJS+V2o4RWgEEk7MmqdaO5zbnU0KPvr7HFHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BSfGLyEUErzscBSpFNcSQq3gKGSNb5Sk17V/4dlwdgg16Df2AeCl6hlXdnqHFKYTqgYh3F/+v2TN+DiJ7d9QsZ/gP8B6mDBOt8Y8VhKwUNJz7Ge1BzV9n1bVs1ay+zv7CBOil+RQopG9IWsBKcDCSV4fP7EHuiyjPbATZ02npeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kbJbyGSb; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kiU7kNE+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=X8ynM8uM reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TEo211018226;
	Fri, 29 Aug 2025 12:07:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=xWXJKb+UJS+V2o4RWgEEk7MmqdaO5zbnU0KPvr7HFHo=; b=
	kbJbyGSbV0Y1AVm4fgR0/KFsB0WjXpnOWkbS42rGpFAibmxolG/CvRWJaSaebIvQ
	pdeTCyY/HMQCXNsGzpAu5chHV9qwC2eJnQmxjJ1Ff3HCEGM7370brNlRobFYiqD1
	jmCxU7E65oYXeHqjFJgoWJaGX3YsMsnjtwFQmTi37VIS6OL+df0PJXJ44TN7DJUp
	sRiQJU1DLM4RyUMD10ZObjuBadNu0VQX/jZRbrh1y2wnNErW+vcgxLMyt/9sAAxl
	BEuB3DyEdmAiP9PCXXB1u83Mr9Nan78fq+6wtQtDU97yGu9pYApExfl7rrzRxwKf
	4/Brd5978W3afGAjs34F/A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48shah3yvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1756494464; bh=xWXJKb+UJS+V2o4RWgEEk7MmqdaO5zbnU0KPvr7HFHo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kiU7kNE+bHBKOPOxChyvYktTfMTSX9QaJFiKg9b8q53WtS8L6IiHCMnDTTbg0fuQ8
	 WIEagOd5XzpitdoN+TnxQUA9ZbAwKYYTHpMKEqgv1cQ/fqZtXa8MWs8n3+Dok//bH1
	 QkTtCtt9kcf4k1qzO6GM4VQ+pY+LpWBNLZs+MzBLkCDfGsisgJ3G/XcEkLAr6xComn
	 pcmxqZkPPK/LNpU9QkL0T/u135OVwMI7LPFzRXZo3OtFvDomR9hZhzQ6Kz5DcYxVWl
	 tNdInS5O+UEbTlYwjDsXtCOXcnj6+wGB+l0Ab+C1Uat3V0ObZwc2MgkEpLNcxPysFM
	 6nPPn/hFB55oA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E60C40360;
	Fri, 29 Aug 2025 19:07:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 06399A0087;
	Fri, 29 Aug 2025 19:07:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=X8ynM8uM;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 59FE2405AF;
	Fri, 29 Aug 2025 19:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFsBNSd+ii6GGJHBw8KCuJENaVUIbcV3cY+l+Dc4qKuxWPl5UpFNEogZNYZ6O+GWHL5aQpwcIepgDaqxmLRKFbVTprUROV7+LsgKTVey9OJvagmztx//eguCxCFxXIfFSVipXDfucb4dIfOLa1p1vOIl3aKK06N5plSbx62EsjUP849iHqeaZ2KX8OZQhaFs5cO6o8YSoRHtm9L/JPqdDlBmEgPfDqZ4JtH9TXLEhkOSmGuzvIr3T2gtZGpV/t/CbZlDc8wAaPmGV9JQ5hMbDulWVYJ+mazvu21/kY9MTmhcE6Y+yX20/dNq3hLOAGZzIz/31oRyUw758TXeqwQ8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWXJKb+UJS+V2o4RWgEEk7MmqdaO5zbnU0KPvr7HFHo=;
 b=cPI+CqCtbmYsCWG8Yvh24rl27JWvlRO7iAKVn5686Ex2mePmdn8IQffTUdxMEQFrBx8c0gYlv+IUWrJ8n8FZfaeLatnTlofz8U4roZmz0ss8VfX3By35KTkk/WUqkWxrHmE54qedPBEzhTenAecP0BLU6+36EBoy5R0SbJ0ARhpaNnxpfsE1ChbgLel6ycSUAwaGxbi31bIIGB1BmgmpUHZeXKhQhkGQHEFrUa7ciFFmaETIiJ4zWXYubODOazqmrt1GG1BRCj9z1fLM/hRW3W8dD7AYlETcEQuttkK2iTvK8sbrjHM4VDXeSeuUcSUzZ6yN6YghNFdB5pW0qbWHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWXJKb+UJS+V2o4RWgEEk7MmqdaO5zbnU0KPvr7HFHo=;
 b=X8ynM8uMdywDYjipLBHSwivU9+90WL3WrzNl+pK5MWj8bQFqn3IuYShGvvyTHeawaSwGp/rbXrgcOUbfa2qY/xb41IkBACTDEjdzL1GrL8EQ5uz4Wk8G4egdgF3PxVgYRvjx/XL5oL5S8IaFQxp6QUlMvkucA+HAorU7nPcP9oU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Fri, 29 Aug
 2025 19:07:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 19:07:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, ryan zhou <ryanzhou54@gmail.com>,
        Roy Luo <royluo@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index:
 AQHcFpwLhCI1/x1c70ew6xjKTgeHrrR1Q/eAgAFHIgCAAAwMgIAARF6AgAHzEACAAAu5gIABKNKA
Date: Fri, 29 Aug 2025 19:07:31 +0000
Message-ID: <20250829190731.gx2xrgdz3tor5a2v@synopsys.com>
References: <20250826150826.11096-1-ryanzhou54@gmail.com>
 <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
 <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
 <5d692b81-6f58-4e86-9cb0-ede69a09d799@rowland.harvard.edu>
 <CAJZ5v0jQpQjfU5YCDbfdsJNV=6XWD=PyazGC3JykJVdEX3hQ2Q@mail.gmail.com>
 <20250829004312.5fw5jxj2gpft75nx@synopsys.com>
 <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
In-Reply-To: <e3b5a026-fe08-4b7e-acd1-e78a88c5f59c@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB6730:EE_
x-ms-office365-filtering-correlation-id: 5fa3d979-4f6c-4f38-0e1c-08dde72f4e6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clgwVDFDVDJhcW93TC9VaWUvKy9NbmN3dmtEdWZVUVBpSU9HMmpSRHJ2TWFs?=
 =?utf-8?B?TUpIWlNndDhjWU9mdDYvQ2loNmVCNktjNzFFMlFROGZrVyt4RFhWZU5ieUhU?=
 =?utf-8?B?NUtNTTNTQzdHT05YaFI5WjltcFdhcjFXZ284OE1kSlFTNm9RcXpXRE9kNkNB?=
 =?utf-8?B?UWVYOHRJcGFBUHpSUld0aUk2U0tjRTVDRldPNmRHTWZLK1NnbEs5QndtNlNk?=
 =?utf-8?B?VmVoRjd5MlZxRGlMbjJva2FlK2hlcXZTMmFUcDk1Q1JaRS9CcVV4TzZQYWlV?=
 =?utf-8?B?MXp5NFZ3ZTFCbEEvSW1zbG5CdnNzUVJuVFNMT0Y0cUt1OHlTWFVnOWFlQ2hh?=
 =?utf-8?B?TVREcEZQREpiSlVjeS9mTFNnMVd1bmJ6QXNXN2NBZlVPb0hnOEdEMHJZK0RC?=
 =?utf-8?B?ZFZzNWw5KzNQUzZCOVgxUndNRCtheC90dzF3dEhQc1RmUEErMnRBOHRXbzVr?=
 =?utf-8?B?cWNtY1pWTXk4K293ZWpZVzZEVW05dkh3ejBNOXY0SmRuOHpJZkVWUEJXSWUy?=
 =?utf-8?B?VXM0aVpleStPb044NDhRclhWM09yNUdPcXo5R2xISFlpNzhBLzhZZ2RTYUta?=
 =?utf-8?B?cmNlaktTbW5vYVRYbU1Lczlad25yNWcwUUxGanhLVy9iRjZCaTRKY1BDcTVj?=
 =?utf-8?B?cUNjK0MvOERBOHhRUFVWU0RxNzFIWmEzaStJZFNkbnFHdjFGa2M1MFVTYUpO?=
 =?utf-8?B?TWdmdFA1a2ljdWlsbDZVODNmMVNucWc3UHFvQlNCcWpwZHpVRmFjZ3hGVmxv?=
 =?utf-8?B?M051N1gzTVpyamk2TzlpQ3JNR3FYZ3VWZUttU0MwY3kyQXpucmxlS0dMT2Y1?=
 =?utf-8?B?UzBUS01odmFqWDJzRi9kbktnU0toQ1R2QjQ5T2IzRGpMMVorb1IvalZWSjFZ?=
 =?utf-8?B?aGdaaHVDNjlZdjdaM1JHSGh2VDZMUVJ2dTJ0VWhuTW9ZdzQzeVM1TnRGYzJz?=
 =?utf-8?B?emFQUjAwVHUxOHJSM1RxU3MvcGIrb3cvWFJxZklWR0tab01lc21BNFhwdVMz?=
 =?utf-8?B?RVJtMmphYlgzVm5ZbDhwdzVqWjgzZTZLYkljMXQ3cm50S3YzdjhMMlZZT0NG?=
 =?utf-8?B?NVBDRlN0a0QxTFBCSktpQUFnQjdGK21vc3dOUkdSaFY3bUN1MnMwMWVMaEhw?=
 =?utf-8?B?b0Y3RVlwcURIZUoreWdCc1E2MWdkU3JER1VSWm0vclVXUFJWRVBoZjY0LzlK?=
 =?utf-8?B?MXNFcUs0TmY3M0pQMVltY3NPM3FqSkRXeXc0ei90T0NYaHFpKzdTb3AxZEpD?=
 =?utf-8?B?ZURaQVRueXl4eDlxWEgyYWkzZ2F1aGFQb1NvRDZidDRualFKNndIODVzRXlv?=
 =?utf-8?B?T0pUVnkvNWJPUVBxTncwVEI1UUc1RHJnUEJMK1ZOWWJsQzNDZE13eUxVTnFn?=
 =?utf-8?B?a0VyT2dHSDI4dUs2YS81VUl1Y0tnRUplVTZyMVd6QjhKK2N3N29ORTFUb3dj?=
 =?utf-8?B?ckc4eG92bWMzMm8xUlRlbUw3Nm5oYUFOVGdZVGkrYVkzK3Q1aG5JV0V4M2Uy?=
 =?utf-8?B?SUNWRlRMeHBhdERjcmVqTmJSSjFwcVR5NmRJRGp1RkNpNENjWHMxTDU0S1J6?=
 =?utf-8?B?NW5CV2FlRWRHSjh6WG5uVkFQM3BtVy9VZ29wKzhnWXduaHVhSEpkMXNxbkJq?=
 =?utf-8?B?QnZJaTZ1emVFRDRhbnExRlppdGh3S004YW9ISDl2WEpmcWQ3NmhpR3dxcVhB?=
 =?utf-8?B?R2JiZDBnekVNcXcxNmtVM1NsVmlZV1dzb1ZPN3hkY2VIYnVpT2sxTWgwSzdm?=
 =?utf-8?B?QVN5MnRXWDJGQXBKbzZqVEVxRUUrVnNYT0NSYWFPMHJ3TlV6TWI2S1BNelVx?=
 =?utf-8?B?azkxcjlRS2tuTW80QUhJdUhiOVJkNlNZTCtObUlmVjhSbWZNc0gwdm9jYXV4?=
 =?utf-8?B?MGVhU0NGRjczWHRBWm5vRFVlRTRaOWZuZWoyTlpTRXFheHd2eW5ycHdjeXJ4?=
 =?utf-8?B?OUg3VzdjSHFqclVKaVRrZEJpUE9RK0oyMkpZUGhmTW5zOU5tYmJLcDhaZ0JL?=
 =?utf-8?B?alFsV2ZubUR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0t2c1ZkZVZYMlhGNTFTcDdNNEEvMTNTQTJnUkZmQ09VcGVxZ29KbVFwL2dQ?=
 =?utf-8?B?bWZ6YVdaaU11eEtGYUdjUVF1NXloR0hDR01rYkdpaGZHcFlWTENmVURURUZ5?=
 =?utf-8?B?ZFVLOTNsQ0ZPbXh5dEhZK2NNY2lxK3FaUnduR1VzTzZFb3ZwOFVyL2xBSHdS?=
 =?utf-8?B?YUUwcUtrbTN4eVpuVkVaSk1JU2FBSm95eDJzTFliR1JTT2N1TzVPSWs1WDhy?=
 =?utf-8?B?d3laWWxjbmZrWFJRTkNrV0NhS1Jlb3MwMi8walQ5RDNmWHJJd0x0Z1k4ZnBu?=
 =?utf-8?B?c08wcDJ6N1ZrQTFzU2JoZWZuRnBRZnY3VS9BT25oa3VqTklScjkvR0tvZU1x?=
 =?utf-8?B?SVNuNGNybW84SGVQM0FFQ2xXaXR2VWRUKzJKbTRMbWlXWmVUaHY3cTM4SjFl?=
 =?utf-8?B?QjBxdGU0ZTlaYjVjWUtiQUNMUy9iekIyR1ptaXFLZ2ZFL1FsTDNRUjM5Wi9R?=
 =?utf-8?B?SzIyRUc2cXAvVURZdW5Qc2w4OVdsc2dXV1hmTEFSd1ZMa2doZ3pXL21NS3ov?=
 =?utf-8?B?a2JRWVRST0RiVkJXWkJKa2x6V25ZQ0VJR05XS3A4dG1QcnB0aGowM1JuZU5P?=
 =?utf-8?B?SXZRcWpvalRiMmZSMzZjcVBvTDFKTEk2UElBMDVGM0JHSHF6VTU1WEt5Mlpi?=
 =?utf-8?B?Z3N2eTh0U0hTZlBRTEFQRFdJbXU4S2NnOXJrejRpZ2xveWl3THZ3emZ0RmVj?=
 =?utf-8?B?OEp3ZzVYeVB3OXdmcFZKbzY3R2RvMUlxMTRrRVBVVVhUZDFZaVhwbHRhb2VQ?=
 =?utf-8?B?VkhJVmNGbXJRYnd0R1NnZUpIS2FSMmdjdHJHampncDl4eHh4bVp6REJOOWpG?=
 =?utf-8?B?cWxHbVRSK1Q0Qys5ZDJJUXFPbXo3em8wemg1SW15OGdPQmdxRDZoL1ZadkpZ?=
 =?utf-8?B?WHhNNjVNKzM5RW9iNEZUMTlHZlhSdUhQZFRQL2NZL3FQYUtQZUhGUDVIMFl2?=
 =?utf-8?B?bGJOYU1IUmZXd1FRWTFuOUxCcCtaQTJ1c2NCODFjY2lQMEhFT0k2SWE0VGl4?=
 =?utf-8?B?alE4N1ROMmwwNHorKzNZT010SDlmcEdLYmp2bXJmTWdNQk5YdWxGNXVtM1Yv?=
 =?utf-8?B?OGxzNDFDSHVZWDExWUlUaW9iQXcxV0VtRFVaK09FdDFrb1dRMzVZT1lHSlNN?=
 =?utf-8?B?K3d6Y2JHZUNKbUgxWVlrV1BUNTlFMlEzM1c2TGJhZFQ1WkJET3kxYW14b0pz?=
 =?utf-8?B?aTNlMi9nZjRjdzFaQTdQTzE0RlV3V2xINVg2bjdJQzFTNGtJYlZ1WDNBQnl0?=
 =?utf-8?B?OEpjT3FCZFlDMHYreUVmRjNFc1RkM1gyV2UyTTJ1VDIwbGo1MkxzdUJhbzlL?=
 =?utf-8?B?NmxSdk9Zb0dGTEZLRTRDRS9uVWpIejUxOUlJOWF0d25DcnpnQzdlQzNpTHNo?=
 =?utf-8?B?S015WSs1SFJDdlZDRlh0RWVSUGFaVkJjSCtMK0g2QlJRZDMxRUNoeDJrSDcz?=
 =?utf-8?B?SmpkREZqcnlCcUVWSWhQUm8vNGNZUnEzazQ2M0FZS1pIVXpLSFI2cVRTOWJS?=
 =?utf-8?B?UWVXRDdaSWR5SldJbmNMYlhPLzI4OG5TTDVvbDhwVXRvNHZlVWt4QllZU3ZI?=
 =?utf-8?B?S3AxdHduVnQrV29TWkpZeFFCOUxlY3FHMkZhOTFjWVdGb0RMb1poWHhoaElS?=
 =?utf-8?B?ZGdFWlFDWlF6dFVBZDhra1lub2FtTURLZ0R5TEZoNlRMUkI2eUg0b2hHbW94?=
 =?utf-8?B?azRsMjRSTmVOakMyVjg4TlpiSVB1ekVDSFkyNjFFLzlqUW5ydU8zcU1vSnpN?=
 =?utf-8?B?ZWQxcklpN0txOHhqZ25IOCsvWUkvS0tvb1N0SDhnRjJQRFJTSmlXVmM3bkhJ?=
 =?utf-8?B?SjJWMEJTYkhyOUVEa1k0S3VYT2lmdEtRQkJXUlNpWS9KZHdueitueVNVTHJ5?=
 =?utf-8?B?RlN2OXdIQzRVZkRSalVXK2xEN1dZeWlJbTgvK3dqREgvNCttVWdGK1VvMDZ5?=
 =?utf-8?B?cGxHZG9NQ2UrZkRwS3JGOGdlU3hlL3RxanIwOUUzSnVjZTNKamFtaGNsUE1I?=
 =?utf-8?B?KzdJRUdtYzZ4bkZ6NVZvNG56L0hyd2grcmpVblpobHhNWitGMC90UmkvRVJV?=
 =?utf-8?B?cGZFS3RWVFpFVHh4YXF0cGFqYWJ0R0s5WURyS3BmYjJHTnZSbFVzYnBMbmxZ?=
 =?utf-8?B?d083Nmo5cWc5WmFNMG1saW1FNTV3UXlBMHdMUEhHVGlJVDlzTElyc3IyWE9P?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <235B242C674FDD4693D5F1E93D23CFF0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+goql8jvqeaLtRavQuXRpW6pgWio1mnhX67/XV7T4Njvi38RRU6/7OwYtTI6OeJwZMQ9gFDdd3BCfmTehegoR+nrGL9+Gp0bdOB2eFp0MahyXUYbyQItn8AQJlEFbe9cO6/hXVT+OGNSu2YrZSepueJWq4nzliO6LLSumnhF+BuuimC1vl7Do2eLFStRQG1cVneHIDMr8vueRKTKJZ4/HnkEuyKF7Li7AQ1qxlKE70wZJuSU6t18tZguB4pzSURf/Z6K52vF5vYWv8knAYgmQZw9kWUj64CEyNO9t9i/7L4wriBP8N5YkREA/3obzAmn+SbA+OfZwxDtTkp1fmALXZ/LBFlc7T40q/QoimKehk5MF35L3XiHfUfg8ER+HmGEX7xdqP3khJSLPsTTOJhrAUCxpvQZzZySPmz/rogKEahYNXIETSLy4XDmtaSyI2X3LHp+nHgjALLHiICqL4XKQX4pKsrNVunWBegnv/Fim8NqdnE5cVZ1q802ltg4iTjbwNAncbTtvPY8Mw2YY8x8K86IpEkQBb+K0zBHfN+rzEGbouB7eJcjAEwr6gOYskXH7HKvehQYoeANE5BxZTYSRILYpqF3CSJEq0U8H0QCuy8itveHuwXttj+vAZHE1Sd85MiLSm48oYBQ+JPLBLeaSA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa3d979-4f6c-4f38-0e1c-08dde72f4e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 19:07:32.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3N6U01JTPXiN7Nsr0N4zv4TPRrozXRnj8ln1Dnu5/NUKOWrkFBij01S1FX86+JY88X8ZxRMnlWiRFsjcFLkBog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
X-Proofpoint-GUID: kujpO5l3aij8kutney07qoRduHCjAKxU
X-Proofpoint-ORIG-GUID: kujpO5l3aij8kutney07qoRduHCjAKxU
X-Authority-Analysis: v=2.4 cv=ebk9f6EH c=1 sm=1 tr=0 ts=68b1fa81 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=z5AHLW2Tu3_1Cyt6T-MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX8T7fdHrAyp0h
 0DMj/55uZ5igLoIONg8oK50iiVJvUAoO2BxYRD3Qw1LfiM/iMkcvyhLSS+bKdY33UeTDpZSWkms
 ooPMwghyBySAnBgOLF6cej9ldyyIn96m3/Aa6PQ4hZWjhyYdCZRC34wPxthlae7BMAmv/QGukCo
 Bl1wJNHt5bdxKgjCMkvQCglboPwYy5EkVRi0ziAA0CIl1om/AHJ6PYscW9wwz/NO7Bkc05UhyQA
 JlhTZIKnChzEYUAqgA2QQ9QJ9RO4iV2bSh4sbr2zWz9a/ZzcxgqDmiy574pIxEAg00OK8sP7nV+
 X8zo7sXkDggZswR0XvNmN9hYEbRPIazTcRf8EHcrS6mvd+oOgpVohmjLgzhS6SfZX++HMN89+PR
 sXH/VhWL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508260153

T24gVGh1LCBBdWcgMjgsIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIEZyaSwgQXVnIDI5
LCAyMDI1IGF0IDEyOjQzOjE3QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBX
ZWQsIEF1ZyAyNywgMjAyNSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+ID4gPiBPbiBXZWQs
IEF1ZyAyNywgMjAyNSBhdCA0OjUy4oCvUE0gQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IFJ5YW46DQo+ID4gPiA+DQo+ID4gPiA+
IFlvdSBzaG91bGQgcHJlc2VudCB5b3VyIHF1ZXN0aW9ucyB0byB0aGUgbWFpbnRhaW5lciBvZiB0
aGUga2VybmVsJ3MNCj4gPiA+ID4gUG93ZXIgTWFuYWdlbWVudCBzdWJzeXN0ZW0sIFJhZmFlbCBX
eXNvY2tpIChhZGRlZCB0byB0aGUgVG86IGxpc3QgZm9yDQo+ID4gPiA+IHRoaXMgZW1haWwpLg0K
PiA+ID4gDQo+ID4gPiBUaGFua3MgQWxhbiENCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+IE9uIFdl
ZCwgQXVnIDI3LCAyMDI1IGF0IDEwOjA5OjEwUE0gKzA4MDAsIHJ5YW4gemhvdSB3cm90ZToNCj4g
PiA+ID4gPiBIaSBSb3ksDQo+ID4gPiA+ID4gVGhhbmsgeW91IGZvciByZXZpZXdpbmcgbXkgcGF0
Y2guDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gV291bGRuJ3QgdGhlIHBhcmVudCBnbHVlIGRl
diBhbHJlYWR5IHJlc3VtZSBiZWZvcmUgcmVzdW1pbmcgdGhlIGNoaWxkIGR3YzM/DQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+IE5vLCBpbiB0aGUgZm9sbG93aW5nIGNhc2UsIHRoZSBwYXJlbnQgZGV2
aWNlIHdpbGwgbm90IGJlIHJldmlld2VkDQo+ID4gPiA+ID4gYmVmb3JlIHJlc3VtaW5nIHRoZSBj
aGlsZCBkZXZpY2UuDQo+ID4gPiA+ID4gVGFraW5nIHRoZSAnaW14OG1wLWR3YzMnIGRyaXZlciBh
cyBhbiBleGFtcGxlLg0KPiA+ID4gPiA+IFN0ZXAgMS51c2IgZGlzY29ubmVjdCB0cmlnZ2VyOiB0
aGUgY2hpbGQgZGV2aWNlIGR3YzMgZW50ZXIgcnVudGltZQ0KPiA+ID4gPiA+IHN1c3BlbmQgc3Rh
dGUgZmlyc3RseSwgZm9sbG93ZWQgYnkNCj4gPiA+ID4gPiB0aGUgcGFyZW50IGRldmljZSBpbXg4
bXAtZHdjMyBlbnRlcnMgcnVudGltZSBzdXNwZW5kDQo+ID4gPiA+ID4gZmxvdzpkd2MzX3J1bnRp
bWVfc3VzcGVuZC0+ZHdjM19pbXg4bXBfcnVudGltZV9zdXNwZW5kDQo+ID4gPiA+ID4gU3RlcDIu
c3lzdGVtIGRlZXAgdHJpZ2dlcjpjb25zaXN0ZW50IHdpdGggdGhlIHJ1bnRpbWUgc3VzcGVuZCBm
bG93LA0KPiA+ID4gPiA+IGNoaWxkIGVudGVycyBwbSBzdXNwZW5kIGFuZCBmb2xsb3dlZA0KPiA+
ID4gPiA+IGJ5IHBhcmVudA0KPiA+ID4gPiA+IGZsb3c6IGR3YzNfcG1fc3VzcGVuZC0+ZHdjM19p
bXg4bXBfcG1fc3VzcGVuZA0KPiA+ID4gPiA+IFN0ZXAzOiBBZnRlciBkd2MzX3BtX3N1c3BlbmQs
IGFuZCBiZWZvcmUgZHdjM19pbXg4bXBfcG1fc3VzcGVuZCwgYQ0KPiA+ID4gPiA+IHRhc2sgdGVy
bWluYXRlZCB0aGUgc3lzdGVtIHN1c3BlbmQgcHJvY2Vzcw0KPiA+ID4gPiA+IC4gVGhlIHN5c3Rl
bSB3aWxsIHJlc3VtZSBmcm9tIHRoZSBjaGVja3BvaW50LCBhbmQgcmVzdW1lIGRldmljZXMgaW4N
Cj4gPiA+ID4gPiB0aGUgc3VzcGVuZGVkIHN0YXRlIGluIHRoZSByZXZlcnNlDQo+ID4gPiA+ID4g
b2YgcG0gc3VzcGVuZCwgYnV0IGV4Y2x1ZGluZyB0aGUgcGFyZW50IGRldmljZSBpbXg4bXAtZHdj
MyBzaW5jZSBpdA0KPiA+ID4gPiA+IGRpZCBub3QgZXhlY3V0ZSB0aGUgc3VzcGVuZCBwcm9jZXNz
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID5XaHkgd291bGQgJ3J1bnRpbWUg
UE0gdHJ5aW5nIHRvIGFjdGl2YXRlIGNoaWxkIGRldmljZSB4eHguZHdjMyBidXQgcGFyZW50IGlz
IG5vdCBhY3RpdmUnIGhhcHBlbiBpbiB0aGUgZmlyc3QgcGxhY2U/DQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+IEZvbGxvd2luZyB0aGUgYWJvdmUgYW5hbHlzaXMsIGR3YzNfcmVzdW1lIGNhbGxzDQo+
ID4gPiANCj4gPiA+IEkgYXNzdW1lIHRoYXQgZHdjM19wbV9yZXN1bWUoKSBpcyBtZWFudCBoZXJl
Lg0KPiA+ID4gDQo+ID4gPiA+ID4gcG1fcnVudGltZV9zZXRfYWN0aXZlKGRldiksIGl0IGNoZWNr
cyB0aGUNCj4gPiA+ID4gPiBwYXJlbnQucG93ZXItPnJ1bnRpbWVfc3RhdHVzIGlzIG5vdCBSUE1f
QUNUSVZFIGFuZCBvdXRwdXRzIHRoZSBlcnJvciBsb2cuDQo+ID4gPiANCj4gPiA+IEFuZCBpdCBk
b2VzIHNvIGJlY2F1c2UgZW5hYmxpbmcgcnVudGltZSBQTSBmb3IgdGhlIGNoaWxkIHdpdGgNCj4g
PiA+IHJ1bnRpbWVfc3RhdHVzID09IFJQTV9BQ1RJVkUgZG9lcyBub3QgbWFrZSBzZW5zZSB3aGVu
IHRoZSBwYXJlbnQgaGFzDQo+ID4gPiBydW50aW1lIFBNIGVuYWJsZWQgYW5kIGl0cyBzdGF0dXMg
aXMgbm90IFJQTV9BQ1RJVkUuDQo+ID4gPiANCj4gPiA+IEl0IGxvb2tzIGxpa2UgdGhlIHJ1bnRp
bWUgUE0gc3RhdHVzIG9mIHRoZSBwYXJlbnQgaXMgbm90IGFzIGV4cGVjdGVkLA0KPiA+IA0KPiA+
IFNvIGlzIHRoZSBzY2VuYXJpbyBSeWFuIGJyb3VnaHQgdXAgdW5leHBlY3RlZD8gV2hhdCBhcmUg
d2UgbWlzc2luZyBoZXJlDQo+ID4gYW5kIHdoZXJlIHNob3VsZCB0aGUgZml4IGJlIGluPw0KPiA+
IA0KPiA+ID4gYnV0IHF1aXRlIGZyYW5rbHkgSSBkb24ndCBxdWl0ZSBmb2xsb3cgdGhlIGxvZ2lj
IGluIGR3YzNfcG1fcmVzdW1lKCkuDQo+ID4gPiANCj4gPiA+IFdoeSBkb2VzIGl0IGRpc2FibGUg
cnVudGltZSBQTSBqdXN0IGZvciB0aGUgZHVyYXRpb24gb2YNCj4gPiA+IGR3YzNfcmVzdW1lX2Nv
bW1vbigpPyAgSWYgcnVudGltZSBQTSBpcyBmdW5jdGlvbmFsIGJlZm9yZSB0aGUNCj4gPiA+IHBt
X3J1bnRpbWVfZGlzYWJsZSgpIGNhbGwgaW4gZHdjM19wbV9yZXN1bWUoKSwgdGhlIGRldmljZSBt
YXkgYXMgd2VsbA0KPiA+ID4gYmUgcmVzdW1lZCBieSBjYWxsaW5nIHBtX3J1bnRpbWVfcmVzdW1l
KCkgb24gaXQgd2l0aG91dCBkaXNhYmxpbmcNCj4gPiA+IHJ1bnRpbWUgUE0uICBJbiB0dXJuLCBp
ZiBydW50aW1lIFBNIGlzIG5vdCBmdW5jdGlvbmFsIGF0IHRoYXQgcG9pbnQsDQo+ID4gPiBpdCBz
aG91bGQgbm90IGJlIGVuYWJsZWQuDQo+ID4gDQo+ID4gQmFzZSBvbiBnaXQtYmxhbWUsIEkgaG9w
ZSB0aGlzIHdpbGwgYW5zd2VyIHlvdXIgcXVlc3Rpb246DQo+ID4gDQo+ID4gICAgIDY4YzI2ZmU1
ODE4MiAoInVzYjogZHdjMzogc2V0IHBtIHJ1bnRpbWUgYWN0aXZlIGJlZm9yZSByZXN1bWUgY29t
bW9uIikNCj4gPiANCj4gPiAgICAgRm9yIGRldmljZSBtb2RlLCBpZiBQTSBydW50aW1lIGF1dG9z
dXNwZW5kIGZlYXR1cmUgZW5hYmxlZCwgdGhlDQo+ID4gICAgIHJ1bnRpbWUgcG93ZXIgc3RhdHVz
IG9mIGR3YzMgbWF5IGJlIHN1c3BlbmRlZCB3aGVuIHJ1biBkd2MzX3Jlc3VtZSgpLA0KPiA+ICAg
ICBhbmQgZHdjMyBnYWRnZXQgd291bGQgbm90IGJlIGNvbmZpZ3VyZWQgaW4gZHdjM19nYWRnZXRf
cnVuX3N0b3AoKS4NCj4gPiAgICAgSXQgd291bGQgY2F1c2UgZ2FkZ2V0IGNvbm5lY3RlZCBmYWls
ZWQgaWYgVVNCIGNhYmxlIGhhcyBiZWVuIHBsdWdnZWQNCj4gPiAgICAgYmVmb3JlIFBNIHJlc3Vt
ZS4gU28gbW92ZSBmb3J3YXJkIHBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgpIHRvIGZpeCBpdC4NCj4g
PiANCj4gPiANCj4gPiBJbiBjZXJ0YWluIHBsYXRmb3JtcywgdGhleSBwcm9iYWJseSBuZWVkIHRo
ZSBwaHkgdG8gYmUgYWN0aXZlIHRvIHBlcmZvcm0NCj4gPiBkd2MzX3Jlc3VtZV9jb21tb24oKS4N
Cj4gDQo+IEl0IHNvdW5kcyBsaWtlIHRoZSByZWFsIHF1ZXN0aW9uIGlzIGhvdyB3ZSBzaG91bGQg
ZGVhbCB3aXRoIGFuIA0KPiBpbnRlcnJ1cHRlZCBzeXN0ZW0gc3VzcGVuZC4gIFN1cHBvc2UgcGFy
ZW50IGRldmljZSBBIGFuZCBjaGlsZCBkZXZpY2UgQiANCj4gYXJlIGJvdGggaW4gcnVudGltZSBz
dXNwZW5kIHdoZW4gYSBzeXN0ZW0gc2xlZXAgdHJhbnNpdGlvbiBiZWdpbnMuICBUaGUgDQo+IFBN
IGNvcmUgaW52b2tlcyB0aGUgLT5zdXNwZW5kIGNhbGxiYWNrIG9mIEIgKGFuZCBsZXQncyBzYXkg
dGhlIGNhbGxiYWNrIA0KPiBkb2Vzbid0IG5lZWQgdG8gZG8gYW55dGhpbmcgYmVjYXVzZSBCIGlz
IGFscmVhZHkgc3VzcGVuZGVkIHdpdGggdGhlIA0KPiBhcHByb3ByaWF0ZSB3YWtldXAgc2V0dGlu
ZykuDQo+IA0KPiBCdXQgdGhlbiBiZWZvcmUgdGhlIFBNIGNvcmUgaW52b2tlcyB0aGUgLT5zdXNw
ZW5kIGNhbGxiYWNrIG9mIEEsIHRoZSANCj4gc3lzdGVtIHNsZWVwIHRyYW5zaXRpb24gaXMgY2Fu
Y2VsbGVkLiAgU28gdGhlIFBNIGNvcmUgZ29lcyB0aHJvdWdoIHRoZSANCj4gZGV2aWNlIHRyZWUg
ZnJvbSBwYXJlbnRzIHRvIGNoaWxkcmVuLCBpbnZva2luZyB0aGUgLT5yZXN1bWUgY2FsbGJhY2sg
Zm9yIA0KPiBhbGwgdGhlIGRldmljZXMgd2hvc2UgLT5zdXNwZW5kIGNhbGxiYWNrIHdhcyBjYWxs
ZWQgZWFybGllci4gIFRodXMsIEEncyANCj4gLT5yZXN1bWUgaXMgc2tpcHBlZCBiZWNhdXNlIEEn
cyAtPnN1c3BlbmQgd2Fzbid0IGNhbGxlZCwgYnV0IEIncyANCj4gLT5yZXN1bWUgY2FsbGJhY2sg
X2lzXyBpbnZva2VkLiAgVGhpcyBjYWxsYmFjayBmYWlscywgYmVjYXVzZSBpdCBjYW4ndCANCj4g
cmVzdW1lIEIgd2hpbGUgQSBpcyBzdGlsbCBpbiBydW50aW1lIHN1c3BlbmQuDQo+IA0KPiBUaGUg
c2FtZSBwcm9ibGVtIGFyaXNlcyBpZiBBIGlzbid0IGEgcGFyZW50IG9mIEIgYnV0IHRoZXJlIGlz
IGEgUE0gDQo+IGRlcGVuZGVuY3kgZnJvbSBCIHRvIEEuDQo+IA0KPiBJdCdzIGJlZW4gc28gbG9u
ZyBzaW5jZSBJIHdvcmtlZCBvbiB0aGUgc3lzdGVtIHN1c3BlbmQgY29kZSB0aGF0IEkgZG9uJ3Qg
DQo+IHJlbWVtYmVyIGhvdyB3ZSBkZWNpZGVkIHRvIGhhbmRsZSB0aGlzIHNjZW5hcmlvLg0KPiAN
Cg0KQWxhbiwgUmFmYWVsLA0KDQpXaGF0IGFyZSB5b3VyIHRob3VnaHRzIG9uIGhvdyB3ZSBzaG91
bGQgaGFuZGxlIHRoaXMuIFNob3VsZCB0aGUgZml4IGJlDQphdCB0aGUgUE0gY29yZT8gU291bmRz
IGxpa2UgdGhlIFBNIGNvcmUgbmVlZHMgdG8gY2hlY2sgbW9yZSB0aGFuIHdoZXRoZXINCnRoZSAt
PnN1c3BlbmQgY2FsbGJhY2sgd2FzIGNhbGxlZCBlYXJsaWVyIHRvIGRldGVybWluZSB3aGV0aGVy
IHRvIHNraXANCi0+cmVzdW1lLg0KDQpUaGFua3MsDQpUaGluaA==

