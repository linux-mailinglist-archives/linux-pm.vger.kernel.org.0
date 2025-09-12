Return-Path: <linux-pm+bounces-34580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A609B55882
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 23:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3FF5C13F8
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7177274B58;
	Fri, 12 Sep 2025 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Il1oOAjX";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AbGCJHbg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Nxa8XUDU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21C21E097;
	Fri, 12 Sep 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713152; cv=fail; b=IM0dhr6MiORK4e8rbjRZAnIjvGu7422mKYta9ofhokMDuLYIl179FyxOw0XVWbpy1d8WYX22iaPXEt6WYe6dfNrQJzMK7mE3KqLT/dysZvQJjbUZgf+wvIdMbUpdcAby6bV6Rey8/NaAqa35OkyoLdhwMxKKvz6SCSmVYj1ovHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713152; c=relaxed/simple;
	bh=qJHIDgPxR3lv6+J70YecD31yUdmvi4mE1v7Vp3CSyq0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5NBbZ/hDg0Le3GTd0vKoQAqe2xTuQ4/6tUCwEmoY3XLBEiW8RlwGAPtXuDmDFCJYp9LHs9XHHgHCXrRHp7k8qCFR/HNshG44G1RdbAjMGd2IcC5dlN981d97TCQD1CshQ5vurnHiHo66NLu3J2uAwO8qO4e4CSncx9LCA/55vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=unknown smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Il1oOAjX; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AbGCJHbg; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Nxa8XUDU reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLIfTs009705;
	Fri, 12 Sep 2025 14:38:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qJHIDgPxR3lv6+J70YecD31yUdmvi4mE1v7Vp3CSyq0=; b=
	Il1oOAjXeXYcSV6vF+/zWBKDIh7krSy5BjspNHCxZaI0zXo2Fy2rhoEh+4GimZ13
	iRR8Ad7BNEBPjA52yjjAvb/PzN/O0x2Q52yHLfFjJ1npl1HpgbZ5MtXW3Fy1Tw1i
	cBS/iUszLKle7CgW5FTkGMxyRzsNK9pH9Uco5ERpxG7KsqpoXJbYnxJ/9b6K8MG6
	KYHNrTq82G4/geo65ZTGIS99LBSEb9EwmMHyi9zqqVOEeqgKhP5XqwtgBo6BnL3g
	xnvckrul1/VssLF2+YXODPh3P/pQKan5bwRiZwLwn8+jVTMlA8/Az6V7EbtZw5pZ
	4dFH0Sb2p/S0T9zV6fAgHg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 490kynbqas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1757713129; bh=qJHIDgPxR3lv6+J70YecD31yUdmvi4mE1v7Vp3CSyq0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AbGCJHbgLXiaKdYcR5VZAeY4KdDXigOHens5tcoZXDbB5G6A4gq2y48rtBtDLTCm/
	 G5XUDV2QyWLh5dR39bmV2bIyAursYCPLIJ9iXF5n8kal55rnze6N7xiXJ33oy8OT35
	 zlkjIhL3bcP6FBcER5KPFGzYTHUUM2/nuYfkVuqUGh7wejTJhNX+0GxJ9ze4LJ9vWz
	 JrUHsp/vfdaJ1JqSsz3jWfz56y/ZFjLu3UIvj4wb6MRktYgubUwTQFdQL3wAL6dkcJ
	 CAbKhlS8aJNtGW0kYrWHRMZ4qbymmAVUI76zexJMk5AEnUut7TKElKhIbReUimoHf/
	 Oj+Eqiz7jeRhg==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E163F4051A;
	Fri, 12 Sep 2025 21:38:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A0485A006F;
	Fri, 12 Sep 2025 21:38:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Nxa8XUDU;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F55440347;
	Fri, 12 Sep 2025 21:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqU7AXc58ZvpoJlxUz58EsIHUtgrNmKZA5wfecGGm0wMpUowZchpwbAiuBj2VpYDvnRlUtZqMuC3iqkupE0Pa9EaBfnnjlezuC2/okc5pic2/vlh8WbqTI4181VXkrna4lVdhcS3vxVNIl/CWGXj0nPRLBoZhOloMbplkaD8aZDoLKLzJ+aq6AavfWXPKX70Fan9vCSLXV+dKNYFOCcNh43cylp5B2S6ih8bZIAgvAx/ZJ76WIbRRJySSdK0TZ5+nB+mfnW8iB6AOmtwiMBJ15JnkbIh/VcDUNTO11dF2tr0mEJ4DKIXCWimxUtQKnHYm4Hre4iT3JEsp/dAB+2+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJHIDgPxR3lv6+J70YecD31yUdmvi4mE1v7Vp3CSyq0=;
 b=yTeyWVifX0WQsLULsQn4gtT9H7QwKrVzoXkusn/kqJmeiRnt19wRuqPgi4pIAmNHNaxTJK5ktL4JWYp9Rg3CEn8LBvT7jPSUKZW4nNRYPGPS01PFBwzqgBYz0dUrJhlyA1XEQlSG4nwzafSx/EpmB5zFZ10yf+DlSg/4cel7nGvxWegMnSUOdsQ2OjhIsmHzMfdSGayi19eZOo99f/lTe4JdR2tAJ5GJvfLAJDB1YzgdQaiMmELEGIq3ZwCFSFy+ZJojq9FP/Uhpmiy8j204M4I+hCmjUd2U4T0jboBGPhonmJqJQ1XekToFUQaNeWWG3ByikrNhEy4iLTwGh8J9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJHIDgPxR3lv6+J70YecD31yUdmvi4mE1v7Vp3CSyq0=;
 b=Nxa8XUDUcGMq+tc8/2Y0C5OASmbAbhiSDrKu876h7y0xOBuifNigXHb7JeCHjcA9j7uOTpgACKPu8xqbVWZjrfx67ufODe/1V8gxtOmgf2t9AEYKZj3cg/mx+B36McOwwGclTIsrwuyfAQcCf0prLwnse4QBltgZk0Wjx8LB6KU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 21:38:40 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 21:38:40 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Xu Yang <xu.yang_2@nxp.com>, Ryan Zhou <ryanzhou54@gmail.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>
Subject: Re: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Topic: [PATCH v2] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
Thread-Index: AQHcIaV6iqN+tbk/4EyT54IWmyl0IbSNNKMAgACcfYCAAAwSgIABU6yAgADnCQA=
Date: Fri, 12 Sep 2025 21:38:40 +0000
Message-ID: <20250912213838.4fwymkoc3om4zfg3@synopsys.com>
References: <385dccf3-234a-4f83-9610-81ac30bf1466@rowland.harvard.edu>
 <20250909161901.10733-1-ryanzhou54@gmail.com>
 <20250911013242.oxm2kwfaqvmybbhk@synopsys.com>
 <xbfvykzfi26pyaycd7efbqvmraxcu6zzgqjfxtk33wcsjsnnal@5e3g4pq5qcj3>
 <CAJZ5v0gT26VK-sHmgK_S4RjjO3Uc-ZmoAYos43S5yWh0zWc9DA@mail.gmail.com>
 <lzkd5h7gwjojo7rio5z7jrdymkluoue4z6aozn3xmrdqnhlvak@3rflncbxe5ko>
In-Reply-To: <lzkd5h7gwjojo7rio5z7jrdymkluoue4z6aozn3xmrdqnhlvak@3rflncbxe5ko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4369:EE_
x-ms-office365-filtering-correlation-id: 31475fdb-1937-40de-b891-08ddf244bd18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGM2Nm0xdGsyczVjUHF3Tnk3WTVLMkd1SU1DaGxHakNoRTVBQWE0cXBpdHVB?=
 =?utf-8?B?Vk5KYkIvSytQZ1p4NklGdTgzYjlYcjZxTkhTRC9oSys0VWM5WERGN3V1ckpw?=
 =?utf-8?B?OGpzdCs3elNtOXRuQm1peEFSYll0YjRZWGFVSGJHRTU2V0NuLytHRFZ1RklB?=
 =?utf-8?B?WEhuZ21RbWdPYVRaZXJ6SVhXY3d0eXVCdTZSTUtyRm9LQjV5akVKNGRmZmkv?=
 =?utf-8?B?blZOQmJqcHZSaWMrb01JVjl1NHFldlk1YjBPdEwwNE1xRlJrYVU2TG8wQ0x5?=
 =?utf-8?B?OUVybjR2dkQ3eXBYQXVJaXIxelB1YldsaDhhWCtTZzQySTJ4OWRUS2x1dVpt?=
 =?utf-8?B?Q1VTSFVzOTd0QXdZeFNCVm03UDlOYWUva2w5QjlPYlRyWkVYV3BFNDExZGNv?=
 =?utf-8?B?dlVLbU5HRkIvbVI5bXNaaHdQeFZPR0s0a0hyVVUvYWN1UGs1MlExaGR0MVYr?=
 =?utf-8?B?M2lKcDRya29YcUJXVFZIVjNOY0ozOVRETnUzZVNSUENFMnRMNVdCN0poSi9x?=
 =?utf-8?B?TllXVTBSLytZOWxoTldkcDlJMmI2OFJsLzBuMVZpZ0FKUEVhcXJNNXVlTzgy?=
 =?utf-8?B?Sk1xSlFOMExLTXNKQ0M1cmQ1MHFVcXJxcHFtbzBRVThuY3k3Z3hxM3BhOWJp?=
 =?utf-8?B?b0lURGUzVG9MZTVhYlBXU3MraXo0clNBTDgrbjQ0U1pEY0RPMTR4MVZjdjB4?=
 =?utf-8?B?dFZtT0d6d1RCdDZ5aXhrZTYrZXBpK0NtMHlXQTBCekxyZjVPT0YvaDBsQkQr?=
 =?utf-8?B?a1cvMHJpeVU4T1JHc0dFdlVCSW5CY2NXSnlXVWpDbllId3BqRVFKSWFFUWRG?=
 =?utf-8?B?Q0J6cTdEVmJHRldzV25WL0ZMZThqc1EzdEJHUVF5VmRIbmxuTVpOaWtPUjJT?=
 =?utf-8?B?RGJrV05uajBvbmRaVUdEazZQclhxNExxckVlb3F4WFlidlFDVTlIMzdpb1Bm?=
 =?utf-8?B?Qk1hVG1haVl0Tmx3cWc3WlBKRGRCWTV4UGZabTZSTGJkVVlRTlZtOTNTWUFZ?=
 =?utf-8?B?NGZHQitJZjU1anlEempWQ09OZENOc3JoenVDOE5uRjVDK1VpODRMeGgyd1Ex?=
 =?utf-8?B?bGJ2ZUpraTZiMlYvL3pkcWl4WWpBWGYzcm5pNTJ2bHZoZUJxZ0t0NkpqcG9h?=
 =?utf-8?B?Nk15d0NybkUzZFJvYlh6d3lHY1dsenlQWUtBWGNyUFRTdnIyYXVHVGlKMHdG?=
 =?utf-8?B?S2ZpRXVVRzRKd1A2T1NMemtxcEdTMC9kT0NxK3hVNkhoTmxiRExxUDQxTDRN?=
 =?utf-8?B?Y1RVeXhhbURNZGZyTS81KzcrTTRvZDdVK0RjVjVKNmJ3WDZPY0cyUUIyclJn?=
 =?utf-8?B?c3BXOFRiRU9VN0NDdmhhL1p0VzVlOXRhVmdKWlNBYzBxWHFxS2dpMW5oQkJz?=
 =?utf-8?B?UWJzUDMvUTZiQ1BEaTdwM2h1VHIwWXlxaGJHODBuU09OSlhTb2xIQ3puV3NF?=
 =?utf-8?B?ZkRhaFlqMVAzeFNyVmQyQSs3bWRFQktjeEEvUFpuUzNjeUFIUHpxYU5LcFR4?=
 =?utf-8?B?M3V1RE1zZmVQOUs3a3JjOWNVYmxlaS8vcFEyMldnemc1RHBVa1hFbjJjUzFP?=
 =?utf-8?B?NDBhajRpa1VaWXgzaGxTbHV6bldrd25sUENiajhtKzFieEdYb204QlRqT1FY?=
 =?utf-8?B?eWRhRCtMc0FEUkhETFRaaEpKM2xjZWU5eEZ6Zmc4VmxKT1V2Uk1zSGxBV3Bz?=
 =?utf-8?B?d0JrYWNQSVY2QjhDWlVsdnRjaHgxdkFnTTEvOUpPM1R6andjNzJabVJ1aWRq?=
 =?utf-8?B?eGtjRURhd21kWVUxTDZkYUVQcmJ5MW05N1ZQSEdjU056c0lud0V2R01ucDNW?=
 =?utf-8?B?dEpLWmEvLzJ6WEVURUNuUU5LOTlST0taM1NOMnNpcFUvekRwSEMybCttZHdj?=
 =?utf-8?B?eXo1TGxEaDV1YTB3QTFkNExkSnBIbXh3SDN1ZzVuVDdScDdMVlZtVlpKRmR2?=
 =?utf-8?B?NmZRWUtHazlCYTJoenVScVhUekcwRCtLbnFoM2Foa2ViNjdnQmJoNnoyRC8r?=
 =?utf-8?Q?JOoRwmu/FxjkNNdYyUhMHOk2m+08Bc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWNmd0dzY3E0MGtXZVpLa0k2YnhKc2c5ODM1WW8wZktuZ2ZRUmlCWHFMRkEr?=
 =?utf-8?B?eFdGYWorZG9sQThZNTg3a3J5WnRWWXN0WHVwdFpSZ1IxN3ZGTnErak5ZeG9N?=
 =?utf-8?B?Nm9KdkxzY1NwdkRmQ2xYSWdhRGp6SjZxUjhGYTZJSXpoSW42Qy90QnIxL1ZG?=
 =?utf-8?B?NTlTZC81aTBVVmdxWk8ydVo2akgzbzFZL2ExNzJPQ1ppeFMwRHpZRkpmelJD?=
 =?utf-8?B?SzNVOFVJVnNtNGlHNll0OFVKSGQ5UVZKTTg0YzFoUVNPVWZhY0tqK3QrTVZF?=
 =?utf-8?B?K055cWU1V3lyYzFTOUxxQ2dydWcxMUNlenpUZUZFS001UHFDemRFVlVUTC9R?=
 =?utf-8?B?RGNoaUE5QzY0WDZmZ2diSjFLNDMvajk1OUpQbXVZbkYvWVg1b2d1OVpIcGg1?=
 =?utf-8?B?eEVQOVVHQWpORzg0djJrSjJtanJNeUFEYzlVWnlSVzR4Y1E0S3JjOGJ1eFJV?=
 =?utf-8?B?Y3B1d243RC9PelNhZzRGcUFITEF1S1N0bVY4c2k1NXh6dTZ2U0c4aTFWaFUx?=
 =?utf-8?B?UTJZQnBqcUIyUllXbE1UdzFNamdTWjIrUEpnNmZ1eDZ3N2lRcHZqNjhNdUEz?=
 =?utf-8?B?TUtTMjBvYzhPeS8zSjFPRHdBbXJ3UVNIVnUzbWVNVmRzdjBPM0s0Yi9mbUZx?=
 =?utf-8?B?NnhrbzJRWVRQNm5lZ1ZoR3dJeG51dFhjUFVickFrZm5BZGJpdlZKQk91U0th?=
 =?utf-8?B?NTJVdWsxUTdmZjArdzZ5R1hDRkZnaEd5bWJ0eDJEaEwyWXlNYjVLTCtVODVN?=
 =?utf-8?B?enhBdDlvTm1QUGpWRFZMK3QrYWRVK0locE05Ky8wRXhxeWR3eDZMNGVpd2dN?=
 =?utf-8?B?Y1ZTK1dkWkoxdmVBZHRvdFRJZTAzSlNqenNVamNXNVlWVHBoNXUyRmtqZHhE?=
 =?utf-8?B?M0N4cVB6cm5kZkdjRlhUaWtudjRSNmxFN0FGQnFnSHJBbjdJaDBWK3NaYlpF?=
 =?utf-8?B?VVErVWRZQVRjalVGeWdNbk1laFp1OXVYYXBPVVpERFFYZ0J4L3BLZUowbEd3?=
 =?utf-8?B?QndFemJWa05tV2NPMUIyU0owLzQzbjZYTjBnc2JDcWJsRndzb3ZaL29lMVF1?=
 =?utf-8?B?N2YzeTR4eFdSMVVtQVdSZ0VESGdXcWhFQUJMcFBIbFVYcG1Cb3FCYVdaM0xy?=
 =?utf-8?B?R3YxMnRMQlpYOEpzMXJPSEVVWkYvaXlwV3g0RXJaajFaRS8yZ01PMUhxbW14?=
 =?utf-8?B?djg3WTJucXBYT252S0FRV3dBdjBOOFdKVGtwbFY2ZkVKN25FUnFudVpibjBj?=
 =?utf-8?B?dm4zcGQ3U3JieDRVV1RWbk56RHppUW5VOUdlV2NxMWZObHRhYW9JMHo0ZVdH?=
 =?utf-8?B?dHJKcXZlWXc4UDZIOGFKd3Q0TEJqeFBqdzJqanpMSVFRN2NCVlU1c0JqYVNC?=
 =?utf-8?B?L2cvRTR0VExvUVJXUFBzdWJzN3NDaHc4TEZGVnpmck92VzhBS3ErTHo5YUtt?=
 =?utf-8?B?V0dSdnNTQS9kem8zdjFUaDE3MDRVNnhIcEh1VDVFandNTXhlaXZiTDBTcUlT?=
 =?utf-8?B?TUxuTzFYVUIrcVhNenBHa2lscVY0ckQ1Z1IvNjB2L1pLVnI5TTdlMHRQeGZ1?=
 =?utf-8?B?b0Y3UEdMbUk4TXd1cVRNK2srUVlodGNnaFc5dDR1NVc4S1NCem9meHFoT1Fr?=
 =?utf-8?B?SW9ISGJqeDYwN1ozdm40V0ZxeTZ2R1N0UlFpQUtjb3dTTVVmOUR5aTFPZk4z?=
 =?utf-8?B?R0MzRGFqSXd0UmFyU3c1aVZ3bnFTQ2hzZUNUaUlUNFRPNUZNZE1IN2xOK203?=
 =?utf-8?B?NjFLaUNBakpCVmVNVzF4NXVRQWJUWWMwZ1d1TXFsbGtNczRzd0pNQ2VCQWJE?=
 =?utf-8?B?VFhrUVlseSthMjdIOEdUMUdPVlZmeFFOY0pxMGduUjh3Uy9YcTE1N0ZnTGNB?=
 =?utf-8?B?a2xOM0FlZHQxb2k1OTZKOHAwemNFVmtmTDRPV21YQ0JuSzB1bGpEN2U5elpu?=
 =?utf-8?B?N3NibjllaVMyeXZSWXJvSUh0ZkhCY2FOZzRML3RHdXNoZUMvWnhhb2hheFoz?=
 =?utf-8?B?VTluMG1zV3FVYndjT1c2eWN3eG50eHFkeUpzbVF6bysyamtMV0xzR0pRcFkx?=
 =?utf-8?B?YnpuODQxeTZaOXhOa2ZSUGhPQS80RGkzQVBKVTY5VWNUY0RaOGdDN1ZLSkND?=
 =?utf-8?Q?Un0/xW/jpTSYoyJPcz628adKb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91C5790FEF26E42906D8E79B0F13AA7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJE6XpiXFXoa4ZuGIsDta3aphAPZiogOtk/wm/whJ1AUqEgF4x5HQh+ZfRvfr8vMcyDhCEXSKHvasNw8+mXrTrVZ7ICK0e7aPjA899OHzpNVH5v55nk1p1v/sz2vBp2uxEtF2bBcCIatpoe8DJIl0bwr1LV603tjhJ+FHwzOkx1+wasvXgiRYZ/PyuhU+5qeVUQS6zFnnNVO6yEVhvyK+t1Ks9vVTmSdEcsqgFi4fnKYlQt3ZEHGernTjCKFdBCafQ3imQTV6b5P9TLnTJM0CtJrWL8dhA2sxkyBr1KCAgraHZYwhcs8nVO/k5MphyiKYgR2iJtKPyHdvkTtpaWJSheXlG9zlZWtMwjyKKvENAUE9R82roN/Z8aT4gBNvLD9fxFr/6TtHypAuSwDCR+N7n36uqEFdQIj/UVlFCxEI65xqyvFxbzTTtbLpgdoq37pbxNbEj3LoiEyqfV/qGzDbiQMr52S1i+PTsfOGzusHLlPtnihkJaaYKGkmBA+cB7KH63Q3nF5JbPFwgO1orN7W3GGL8yYvZi8EW513BpdMhg6y0Z5lgjlzNjFD6RLX+2FiY39w1RzxfjCW089OAM5br1Dsu0n0Q0i2JE+YQl3qTNTswrBgfD+VqoHUV3azn7CYNtWaXwG1s3Mo2ElDXKO+A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31475fdb-1937-40de-b891-08ddf244bd18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 21:38:40.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anX4s/236woaKa99Fb+OsKBOj4OVr6wNxthua8AZWoPKOEyz4jTx9hVt+wgeaNc5RkJLUXquGZk9ehGRHT+byg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
X-Proofpoint-GUID: d6ehIiKIhfNMVkz0COmek-jlduDSpkyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDEwOCBTYWx0ZWRfX1xOpYeh52aou
 nCXol8xgMVXEo3RQLb0Q7BqN/6Pel9ppl1syD7lObQrwdZ2MgZtTpHHYtmJSeB7iGtGq9MTIqhB
 oojRQkNy2iH7Yd5UFlyhgdXhfdKic8eilnbC4o3rzCXe4eKoyvF58cahkI1GtBAv74PKlKjioE8
 tPqvAmPxot0PEdcBCSTwukE/LHOwDxKzWQVNEIcj6TKOOt+GBz7NbnzrL1HJ73UY6JnZX7K+MD3
 dO/gv51PsKR4E4lrvadcYboj7ULtnnUXulEBPTkZjdEpuy7iPKpKXcDJtl0qCy7srJYeiMbUo1t
 LY6wFrp+lZoxfocCWsYropuh2m3RRoIjjybjoJggFhoXo8RoNrviTFQsAdjg8g0lmGk7K0ILoFk
 744I7pdp
X-Authority-Analysis: v=2.4 cv=JvrxrN4C c=1 sm=1 tr=0 ts=68c492ea cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=qPHU084jO2kA:10
 a=8AirrxEcAAAA:8 a=HfyUkPfWpSV5PR4Vg70A:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: d6ehIiKIhfNMVkz0COmek-jlduDSpkyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509060108

T24gRnJpLCBTZXAgMTIsIDIwMjUsIFh1IFlhbmcgd3JvdGU6DQo+IE9uIFRodSwgU2VwIDExLCAy
MDI1IGF0IDAxOjM1OjU5UE0gKzAyMDAsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiA+IE9u
IFRodSwgU2VwIDExLCAyMDI1IGF0IDEyOjU44oCvUE0gWHUgWWFuZyA8eHUueWFuZ18yQG54cC5j
b20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEhpIFJ5YW4sDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBT
ZXAgMTEsIDIwMjUgYXQgMDE6MzI6NDdBTSArMDAwMCwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+
ID4gPiBPbiBXZWQsIFNlcCAxMCwgMjAyNSwgUnlhbiBaaG91IHdyb3RlOg0KPiA+ID4gPiA+IElz
c3VlIGRlc2NyaXB0aW9uOkR1cmluZyB0aGUgd2FrZS11cCBzZXF1ZW5jZSwgaWYgdGhlIHN5c3Rl
bSBpbnZva2VzDQo+ID4gPiA+ID4gIGR3YzMtPnJlc3VtZSBhbmQgZGV0ZWN0cyB0aGF0IHRoZSBw
YXJlbnQgZGV2aWNlIG9mIGR3YzMgaXMgaW4gYQ0KPiA+ID4gPiA+IHJ1bnRpbWUgc3VzcGVuZCBz
dGF0ZSwgdGhlIHN5c3RlbSB3aWxsIGdlbmVyYXRlIGFuIGVycm9yOiBydW50aW1lIFBNDQo+ID4g
PiA+ID4gdHJ5aW5nIHRvIGFjdGl2YXRlIGNoaWxkIGRldmljZSB4eHguZHdjMyBidXQgcGFyZW50
IGlzIG5vdCBhY3RpdmUuDQo+ID4gPiA+ID4NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gQEAgLTI2
NzIsNiArMjY3Miw5IEBAIGludCBkd2MzX3BtX3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4g
PiA+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gZHdjLT5kZXY7DQo+ID4gPiAgICAgICAg
IGludCAgICAgICAgICAgICByZXQ7DQo+ID4gPg0KPiA+ID4gKyAgICAgICBpZiAocG1fcnVudGlt
ZV9zdXNwZW5kZWQoZGV2KSkNCj4gPiA+ICsgICAgICAgICAgICAgICBwbV9ydW50aW1lX3Jlc3Vt
ZShkZXYpOw0KPiA+IA0KPiA+IFlvdSBjYW4ganVzdCBjYWxsIHBtX3J1bnRpbWVfcmVzdW1lKCkg
aGVyZSB3aXRob3V0IHRoZSBwcmVsaW1pbmFyeSBjaGVjay4NCj4gDQo+IFRydWUuDQoNCkkgbGlr
ZSB0aGlzIHNvbHV0aW9uLg0KDQpIaSBSeWFuLCBjYW4gd2UgdHJ5IHRoaXM/DQoNClRoYW5rcywN
ClRoaW5o

