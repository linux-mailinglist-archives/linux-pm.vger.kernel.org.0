Return-Path: <linux-pm+bounces-9532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5B90E1F1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFABE2824B1
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE7850275;
	Wed, 19 Jun 2024 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jcF/bKOi"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDA262BD;
	Wed, 19 Jun 2024 03:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718767391; cv=fail; b=XnKGSp+1xWxU+lH97rE743mGgF4zFx/P4cJmAvDlNTMFpxLJQY8Mz6LQ5FVC5pJ3ykGGKEq+Wz2P3Ubj/OjgY2QpcY2Zp2sJb51E9NV3LcgwTk3wUhJVL7TbEewPTtvU2q/7NODJ84Kgt2UYSdL7Dtb2l+IaGQedA/wBgaoXQzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718767391; c=relaxed/simple;
	bh=ebZW7P6opXoTVOp5pAC6AmXJfDq9Lx4ta6+5r3Q5FpE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+JiaoLcuqp3Tz1ZPBx3sorFc/em6YZ6nKhqwrodcYvijTPIavme0aUUvtowOE0/0Bwo7rtsDCnJ1+PEUxJ/4ryotZJ4uUiDGn4wpcKFpBOAvK0m6toLXpGCbS+B3NZ2EE6q/csh+ocWFsO0WWTid/LBZBk+B6Fvn4MIau1utx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jcF/bKOi; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE3sLYG+L2sVVJB23N72BKsw5eEOSTxWpMB2zjcyW8DSdKs0GXzx3n8K+BrX0aTNwd/IP6rKVBbJsgcQp6noEdpNd4zRtdUs8ZwC9nso0/WX3F8Q0Ta9X8Td046ONTmwCwhJAK25xeJ+Bl8OB5nfqm5KgyUb4+v/7eFX6FBzaQaUEiMahpunvtchVPx5CH/UzmbBrHq2rVifq/UQpUpCIFKNcHIT6fFd2uhMdphg1T3A0EvIsqfrgoTCcVME2f4GdzrweUxINOXbTdbSF2SYl3e8ztkbrhR92C6TCqyV3OXSjGkLvAlr/mnffb+MPNi7sGoIcpBrizsqBSi4d8/M5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebZW7P6opXoTVOp5pAC6AmXJfDq9Lx4ta6+5r3Q5FpE=;
 b=hTMeE8OMvVsrWNPkHuOYvIkGZ2Dw6coXxG5ShQya7kjMbV95mUQSBJkadEFuUhS/AbIo88UxI4+RPmWxuD+CHN2KK+SRwLSGKYv1KUR9VlgNdb79VUaov4PLwEKYxSHd68S7DoRJ4fDIjQeuSWKI3qTGFgoPioVs67EhbVm7HdWZUSfa88SqRwrRjTBOgK/fmn0JBAAiLJhvY5IuZXanhUrl7K3r2+5MmeXJ9EuFfkfjKhMBH0Fi1jn+DcUomsDAa1lN/tddWBmlEujRUOsyyJ+7n2iCcCN5FH4CzGZ3e8wXEcnWOlAztGu6JukhC526kEL410IENVea/MVTQKokkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebZW7P6opXoTVOp5pAC6AmXJfDq9Lx4ta6+5r3Q5FpE=;
 b=jcF/bKOiS6/jxc8mv2TOn3J/7fxb3UtYs2mHqfXoQEeiAJwsJ5O0rhQO40X/FmXoCCcFQ/9BW4/Dd0LWVdcoAt6IOpAM9DAlQBuGhyWfs+7JP1hmUZEN+24XQE7eB8dAnXVNmNA4FQa0omzu3dhmAQbji3SCpBZ5lgrWm833qCA=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 03:23:07 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:23:07 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li
 (Jassmine)" <Li.Meng@amd.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Topic: [PATCH v4 09/11] cpufreq: amd-pstate: implement heterogeneous
 core topology for highest performance initialization
Thread-Index: AQHawIR56hTx+LxjYEu2/Dk/J06ieLHN6MAAgACCw/A=
Date: Wed, 19 Jun 2024 03:23:07 +0000
Message-ID:
 <CYYPR12MB8655649D1C306E8C95D5A1B09CCF2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718606975.git.perry.yuan@amd.com>
 <7aad57a98b37fa5893d4fe602d3dcef5c3f755d5.1718606975.git.perry.yuan@amd.com>
 <57793af3-6388-433e-90c1-40be0b07684b@amd.com>
In-Reply-To: <57793af3-6388-433e-90c1-40be0b07684b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=35f2dae8-093c-4101-980a-facb94673c71;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T03:10:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW4PR12MB7142:EE_
x-ms-office365-filtering-correlation-id: c3898935-d0b4-41e5-abf1-08dc900f2387
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|1800799021|366013|921017|38070700015;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2JaSVJsTkE5di9lOEJ2QWpqU3g3Vmx5V1kzSmJOVjdrenFURm5OV1VrMGhp?=
 =?utf-8?B?aVQ5K01ZcFc3TEpVdGtMSndNalp1ejBJWTJtaHFtQ3JuTFFKUTlFUGVzZWNP?=
 =?utf-8?B?SVdWeDAwbWhTOHNUbVFFSkRvN1FhZTRlWVpvQXpWb2ZQYUswc3NvS1krc0VM?=
 =?utf-8?B?bGl1NFlaS3ZETjlIOWQwUUs1WTk2U2lueC9FaVlwUFY1QVpSTmtxSGRCck1Q?=
 =?utf-8?B?VjRZODRtTzNEcXpoQjRVNDJGSm1haDcvS0k2SVFYeHhhQnhFdHR4b2lJQVYv?=
 =?utf-8?B?M2xORXJBV28vMmxjeDJwYUZ0d0NUSUVjMFN3VFNsbk5ucVc5UW9HVkc1MmQz?=
 =?utf-8?B?QUNxdndZQThUUURNWGI3emhvR25ORU5SYlR1c1Zvdm4xQ2d6SnRHMDJwekE4?=
 =?utf-8?B?RHJESHN2WjZVNU1zSkhKZG4vSWg4VFpHK0RESVc3MmFkZEZENmNqN3VJZzcr?=
 =?utf-8?B?RHE5ZXAwWmtUOEUzcUtIRHpubzdyemVTMHM0RDBOZ24zVFZFS2VTa2doT3JE?=
 =?utf-8?B?OFUwSjBNYnNIdWUvVnU2WkNmTzhwU3h4SDJlVXRxenhReEpzaG1PQ1VRekZs?=
 =?utf-8?B?amF5TUxuUzd1anQ1U1liOWNhOTM4OFZGRUFiSnNPTStzYVFiL0t1R3lKbnU5?=
 =?utf-8?B?aUNsKytucnlScmpyejQ2NGVjc3RyQmo5TTNDR2o0OU5VZ3Nkd2JKaXlZQ2lk?=
 =?utf-8?B?Q2IvVHlraC9xalJJWTVMZjJlbFVzM3kvQmpyWGtMSkhIaCt1Z1NIZzM3ODhu?=
 =?utf-8?B?Wi9JWjdKUXZpQ2Y1ajM0MzJMbEhySkFvdmNwMkFWQ2NEUmdpQjJRalF5TldS?=
 =?utf-8?B?ODZoL1RJNXpvcUJuT25RUzE4SmM5b1RwVjZqbUpvekVaRnR0c2ZaMUZjT1JS?=
 =?utf-8?B?NU1jVWVERG5mb3RvbXVWakFGVEw3cGJ4eDhVbVFyV25JWlVIaDU4MlFNWnph?=
 =?utf-8?B?Rm50SFpMWjZ5WjNZWXdmMzF3eTV3R0dua1kzSVRjV0kxZzVXUWhxcWJMS0Jq?=
 =?utf-8?B?OEQzWmxwdTJoWUU3UzFDZ01LSUJSa1dsU3Q0TzF0eDhUdFpDUDI0YXNvU2pB?=
 =?utf-8?B?YjA3SHFMUWsyRHYyYmRMaThSQkkwWlRCY1R6RC84ZFZqMlIybTk2WWVlaHZ0?=
 =?utf-8?B?YTFXbTJRNzFFRWttSjRmM09iL1dGZjMwcE1wVk5ZWG5HNzVsWThkYW1IVStG?=
 =?utf-8?B?NlV0a05LYThOdUJWdnE2VGJuZ3JHYTdrSDRZWjJHWWUzOFY2WjVycFBlaFZo?=
 =?utf-8?B?Y3F1cnlYSk9jdmhlSlgvRE0wMzVqeE4xN0d5N3R6a2VlNm8xUWNzQ09CT0R2?=
 =?utf-8?B?RHk0M2w0RjBqOVlDUUgvWnpCL0pma0p2eU13VGgxaFcxUnF1MVFsMEV5WExT?=
 =?utf-8?B?NWpWU2gvWGtCWXpZNGo5Ti9aZ1lHRXFLZDNhdGh2RjVkS29lM0RnTTBTay9B?=
 =?utf-8?B?aldoZXZMNzk5R1hUWDd2WkhWZ0VaNDdSLy9idHhWYzluRktJS0pseXI2UG0x?=
 =?utf-8?B?SU8xNVQyYmJqVEJBcE52RDdVSTRBZk5wenhRR2gxZFlOMUpZZ0R0Q3BONllq?=
 =?utf-8?B?aXdjT2FYT24yeVJBMnJnVWd1TTBwMGFlck1nVHJjT3VHRnNhRE5OU2lab2Ix?=
 =?utf-8?B?M1dndVJpb2tWQ2lwNG5RcnB3TDNBUEgrQjFnMk9McGREWWV1SGFQQk9OTWxU?=
 =?utf-8?B?WHlyNnVSbGswK2xCd3IzZ29LT0ZOUGxKN0Nhcm82d3V1NnFrdG5zRUpHelFZ?=
 =?utf-8?B?a0xZdjNYdzZ0NGtFbXdrRDdiOHZQVi9KZzdqbk1XNjJFNXR2NFZnMWZEREdG?=
 =?utf-8?B?R0xrczdtNHhqYldpWWtHRmRvU09EczkwYjNXTmNjdDNya09XRmpES0tqN1N1?=
 =?utf-8?Q?o6m9mDYJlWv/G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZytWUUNtRW5ram5SQXIvKzJpdmJ5SDBudWlUL0E0eDRnR01LbnNlY25Vek5h?=
 =?utf-8?B?ZFpvMkIrSmZXWDVpSlNWbVREdXZxWTVIeVE4WHM2cVEra2puVjdvSnNKTWpw?=
 =?utf-8?B?V1E1RkFQMVk2YUtSNXRKUmN4UUlFa1NoY3BoQVg0Q2RUMUhUbU5zMlNtckxX?=
 =?utf-8?B?VHZWWFYxQkRxc1EyNEQ5OUpTZHBvMnNMcHdIcUtoWnFYemtvWDhrM1NNWXdG?=
 =?utf-8?B?NGhMalRWY2F4M0hESUowazlKYkNrZHNpaGVDeGtxeVVTSG9XMDNaOWZGazl1?=
 =?utf-8?B?QkM4bVVYcjNqTVNqZDJvZTNkVUp2TGFaU3ZsVUxxcUZIMjUyRHhXa25wYllY?=
 =?utf-8?B?SFZPaHJ5TDhRbUc1THNUMWVpNWlVQmpUTXFja09XQkU1SDgrZnY3eEgweHNL?=
 =?utf-8?B?am91bWs5UlUyb1V2RWdGSXhlaEpLS1IwZVg2djA5MHdzZ0FvK25wT3pRS1A4?=
 =?utf-8?B?eHhjUURIM0RVZTRqSUxlekJTU2RxUkdUUXBzcnR6Wm9WUmNOeG1TVzdnRTFZ?=
 =?utf-8?B?TDdpUnpFeTVCMWNxMStYUEVGMTZVbnJoSlExY3FZMGxJelRyenhKUUFWaGRz?=
 =?utf-8?B?aUxIeWV3K3lGcGxtTlRXc3FKR3VWRHVmWFk1eU5zb3JpZWo5RFlhckZMNWl4?=
 =?utf-8?B?ZzdBSVg4bGZQUUpXcDFRZHFPZHZFVzdDaDEyL1Z4ZTZHN2o1bCtEc2pRQytG?=
 =?utf-8?B?ODRyM3V6TnRMQjlsZlkzaCtCWkFJaHdwNjl1aGhMRE5LY294WVV4U09SY0hC?=
 =?utf-8?B?b0UzZU5xSEg3WDF1bHJuYllIN25GWkJYc205RDEzTkdCbDJsNXNnMEwxSTFO?=
 =?utf-8?B?UEoyM0RneTVFSXZkTmd3YzZaL3lySHYxY292Z0hvbmVzVWlVM3hZenpZcURy?=
 =?utf-8?B?ZDYwWVpkNXRDRml0b2drL2JIT0xCMEg1K3ZiWTVQMVpmSThQTHFpeThidDZJ?=
 =?utf-8?B?alFKc3p5YjBHdVZ1RmJpc1FwaDhhdXJ5Zlg2SnFDZ3dremNaNVhsMDVHU1pN?=
 =?utf-8?B?QWRKdkJSMGZ1QkpKNmc2S1RrK0lIVndLak5teENvdzZ5Ukp1emc4YnowSHFq?=
 =?utf-8?B?UUszYVRwN2FRSE5pbUl0d1BZWW5xNFJJc21tMFBWSnBSdWoralNEOU42aHZJ?=
 =?utf-8?B?c09OUjhpK2RHSzhYMHd4MUpxQ1VkVWh5SnRyYTBpMGZMM1FNOGM4VVBhYlNU?=
 =?utf-8?B?amoyNnpmdTJhOXFuME9rcWdEME5ZKzJ2N3FYME9scHpDbnhDaC9uTEhONkVH?=
 =?utf-8?B?N1pDK1lpV3ROb3hPNFdNN0xMVExyNUZxSTFNd1A1MElNZEhXY1hJS3M4a3V5?=
 =?utf-8?B?bG1yY1N5cE5VNDdSTEpHeUQ5cjlXT1hOQUswY1JmeVdaY3dyd2t3KzRSWncx?=
 =?utf-8?B?MDhjb3VkZmJNUG1leUw4cWl5SGZ3cHUvTThqYjdGeUlQRnJOTy85TnNnVFo5?=
 =?utf-8?B?QXoxem5XMnhEWEtWS0ZvbW1CY2t3UGxnVUpzNzdKcVBEWm8yUEl3RWJXU1kz?=
 =?utf-8?B?b1NJM2hKRm8yUko5aTdQbERtdndBNnBSQjNPOHBYY21TcnFnZmJTMG80azlE?=
 =?utf-8?B?NGo4cldpUjZWZk5BWXlud2owdGV4RmpUbUhhMXRPRnp4QlAvWXNXUXRtTVdB?=
 =?utf-8?B?Tmk0eWY1QjMrWDNFaGx1c0FjVXpEcFk2L3hFaUtOeWk4QTVLSk1TWFprZmRn?=
 =?utf-8?B?bGdRcGhLY1dqTklVR012SXhFUzVmNXFjcmNDckJieFBORUU3cnBBYm5sNzBZ?=
 =?utf-8?B?amRqQXJaOVpFeFo0eHltOVc0UHJ2Z3Qwd2s2SEVUaTh5Zm9VK1M5MEErRVQz?=
 =?utf-8?B?d25sVUh2OTNFQ0dRMWRVQjZGZktBS2NpbHR4SVcvNGxBZEp0TDA5bzJocG9l?=
 =?utf-8?B?OFdvVlVKTXYycllBRkdSV3VnTG4vRFlPM2ZpdlBNY2ZQaEhzeVhENmNmaHlG?=
 =?utf-8?B?bHRkdG53WWJjb2l2SHhMRG5oL3NtTWNDYXAwWWtZSWVqS2NweUhTM29OU3VB?=
 =?utf-8?B?WnJ1WFNiSWdsbDhtRGJsSktvd0Z1NURJYjl5L0l6NGhNVkg5d3lvM2llQ2t0?=
 =?utf-8?B?U1U3WHluTGpaQXZRUURxMldmYjBsWmNjU3NvajAyTDNIeEM1elFsMGJMRkNY?=
 =?utf-8?Q?fSIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3898935-d0b4-41e5-abf1-08dc900f2387
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:23:07.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7IljbjQ1GrQ4bv7wCgkyWFS20VgPpKz8QBSLSPH0J5u+cT5CuGohSu8t+xfdt+72xEycnmrnuEt4weRQosZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAx
OSwgMjAyNCAzOjIzIEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsg
cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb207DQo+IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBI
dWFuZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IFNoZW5veSwNCj4gR2F1dGhhbSBSYW5qYWwg
PGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBQZXRrb3YsIEJvcmlzbGF2DQo+IDxCb3Jpc2xhdi5Q
ZXRrb3ZAYW1kLmNvbT4NCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBE
dSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUp
IDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBr
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDkvMTFdIGNw
dWZyZXE6IGFtZC1wc3RhdGU6IGltcGxlbWVudA0KPiBoZXRlcm9nZW5lb3VzIGNvcmUgdG9wb2xv
Z3kgZm9yIGhpZ2hlc3QgcGVyZm9ybWFuY2UgaW5pdGlhbGl6YXRpb24NCj4NCj4gT24gNi8xNy8y
MDI0IDAxOjU5LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEludHJvZHVjZXMgYW4gb3B0aW1pemF0
aW9uIHRvIHRoZSBBTUQtUHN0YXRlIGRyaXZlciBieSBpbXBsZW1lbnRpbmcgYQ0KPiA+IGhldGVy
b2dlbmVvdXMgY29yZSB0b3BvbG9neSBmb3IgdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBoaWdo
ZXN0DQo+ID4gcGVyZm9ybWFuY2UgdmFsdWUgd2hpbGUgZHJpdmVyIGxvYWRpbmcuDQo+ID4gVGhl
IHR3byBjb3JlIHR5cGVzIHN1cHBvcnRlZCBhcmUgInBlcmZvcm1hbmNlIiBhbmQgImVmZmljaWVu
Y3kiLg0KPiA+IEVhY2ggY29yZSB0eXBlIGhhcyBkaWZmZXJlbnQgaGlnaGVzdCBwZXJmb3JtYW5j
ZSBhbmQgZnJlcXVlbmN5IHZhbHVlcw0KPiA+IGNvbmZpZ3VyZWQgYnkgdGhlIHBsYXRmb3JtLiAg
VGhlIGBhbWRfcHN0YXRlYCBkcml2ZXIgbmVlZHMgdG8gaWRlbnRpZnkNCj4gPiB0aGUgdHlwZSBv
ZiBjb3JlIHRvIGNvcnJlY3RseSBzZXQgYW4gYXBwcm9wcmlhdGUgaGlnaGVzdCBwZXJmIHZhbHVl
Lg0KPiA+DQo+ID4gWDg2X0ZFQVRVUkVfSEVURVJPX0NPUkVfVE9QT0xPR1kgaXMgdXNlZCB0byBp
ZGVudGlmeSB3aGV0aGVyIHRoZQ0KPiA+IHByb2Nlc3NvciBzdXBwb3J0IGhldGVyb2dlbmVvdXMg
Y29yZSB0eXBlIGJ5IHJlYWRpbmcgQ1BVSUQgbGVhZg0KPiA+IEZuXzB4ODAwMDAwMjZfRUFYIGFu
ZCBiaXQgMzAuIGlmIHRoZSBiaXQgaXMgc2V0IGFzIG9uZSwgdGhlbg0KPiA+IGFtZF9wc3RhdGUg
ZHJpdmVyIHdpbGwgY2hlY2sgRUJYIDMwOjI4IGJpdHMgdG8gZ2V0IHRoZSBjb3JlIHR5cGUuDQo+
ID4NCj4gPiBSZWZlcmVuY2U6DQo+ID4gU2VlIHRoZSBwYWdlIDExOSBvZiBQUFIgZm9yIEFNRCBG
YW1pbHkgMTloIE1vZGVsIDYxaCBCMSwgZG9jSUQgNTY3MTMNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oIHwgIDIgKysNCj4gPiAgIGFyY2gveDg2L2tlcm5l
bC9jcHUvYW1kLmMgICAgICAgIHwgMTkgKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jICAgICB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4gLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nv
ci5oDQo+ID4gYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaA0KPiA+IGluZGV4IGNi
NGY2YzUxM2M0OC4uMjIzYWE1OGUyZDVjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcHJvY2Vz
c29yLmgNCj4gPiBAQCAtNjk0LDEwICs2OTQsMTIgQEAgc3RhdGljIGlubGluZSB1MzIgcGVyX2Nw
dV9sMmNfaWQodW5zaWduZWQgaW50DQo+IGNwdSkNCj4gPiAgIGV4dGVybiB1MzIgYW1kX2dldF9o
aWdoZXN0X3BlcmYodm9pZCk7DQo+ID4gICBleHRlcm4gdm9pZCBhbWRfY2xlYXJfZGl2aWRlcih2
b2lkKTsNCj4gPiAgIGV4dGVybiB2b2lkIGFtZF9jaGVja19taWNyb2NvZGUodm9pZCk7DQo+ID4g
K2V4dGVybiBpbnQgYW1kX2dldF90aGlzX2NvcmVfdHlwZSh2b2lkKTsNCj4gPiAgICNlbHNlDQo+
ID4gICBzdGF0aWMgaW5saW5lIHUzMiBhbWRfZ2V0X2hpZ2hlc3RfcGVyZih2b2lkKSAgICAgICAg
ICAgICAgeyByZXR1cm4gMDsgfQ0KPiA+ICAgc3RhdGljIGlubGluZSB2b2lkIGFtZF9jbGVhcl9k
aXZpZGVyKHZvaWQpICAgICAgICAgICAgICAgIHsgfQ0KPiA+ICAgc3RhdGljIGlubGluZSB2b2lk
IGFtZF9jaGVja19taWNyb2NvZGUodm9pZCkgICAgICAgICAgICAgIHsgfQ0KPiA+ICtzdGF0aWMg
aW5saW5lIGludCBhbWRfZ2V0X3RoaXNfY29yZV90eXBlKHZvaWQpICAgICAgICAgICAgIHsgcmV0
dXJuIC0xOyB9DQo+ID4gICAjZW5kaWYNCj4gPg0KPiA+ICAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcg
YXJjaF9hbGlnbl9zdGFjayh1bnNpZ25lZCBsb25nIHNwKTsgZGlmZiAtLWdpdA0KPiA+IGEvYXJj
aC94ODYva2VybmVsL2NwdS9hbWQuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYW1kLmMgaW5kZXgN
Cj4gPiA0NGRmM2YxMWU3MzEuLjYyYTRlZjIxZWY3OSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L2FtZC5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9hbWQuYw0K
PiA+IEBAIC0xMjMxLDMgKzEyMzEsMjIgQEAgdm9pZCBub2luc3RyIGFtZF9jbGVhcl9kaXZpZGVy
KHZvaWQpDQo+ID4gICAgICAgICAgICAgICAgICA6OiAiYSIgKDApLCAiZCIgKDApLCAiciIgKDEp
KTsNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKGFtZF9jbGVhcl9kaXZpZGVyKTsN
Cj4gPiArDQo+ID4gKyNkZWZpbmUgWDg2X0NQVV9UWVBFX0lEX1NISUZUICAgICAgMjgNCj4gPiAr
DQo+ID4gKy8qKg0KPiA+ICsgKiBhbWRfZ2V0X3RoaXNfY29yZV90eXBlIC0gR2V0IHRoZSB0eXBl
IG9mIHRoaXMgaGV0ZXJvZ2VuZW91cyBDUFUNCj4gPiArICoNCj4gPiArICogUmV0dXJucyB0aGUg
Q1BVIHR5cGUgWzMxOjI4XSAoaS5lLiwgcGVyZm9ybWFuY2Ugb3IgZWZmaWNpZW50KSBvZg0KPiA+
ICsgKiBhIENQVSBpbiB0aGUgcHJvY2Vzc29yLg0KPiA+ICsgKiBJZiB0aGUgcHJvY2Vzc29yIGhh
cyBubyBjb3JlIHR5cGUgc3VwcG9ydCwgcmV0dXJucyAtMS4NCj4gPiArICovDQo+ID4gKw0KPiA+
ICtpbnQgYW1kX2dldF90aGlzX2NvcmVfdHlwZSh2b2lkKQ0KPg0KPg0KPiBEaWQgeW91IG1pc3Mg
bXkgZmVlZGJhY2sgZnJvbSB2Mz8gIEkgZG9uJ3Qgc2VlIGNoYW5nZXMgZm9yIHRoZSByZXR1cm4g
dHlwZQ0KPiBvciBmb3IgcmV0dXJuaW5nIENQVV9DT1JFX1RZUEVfTk9fSEVURVJPX1NVUCBpbnN0
ZWFkIG9mIC0xLg0KDQpUaGlzIENQVV9DT1JFX1RZUEVfTk9fSEVURVJPX1NVUCBpcyBkZWZpbmVk
IGluIHRoZSBhbWRfcHN0YXRlLmMsIGlmIHdlIHdhbnQgdG8gdXNlIGl0LCBpdCB3aWxsIG5lZWQg
dG8gZGVmaW5lIHRoZW0gaW4gYW5vdGhlciBoZWFkZXIuDQpCb3JpcyBhbHNvIG1lbnRpb25lZCB0
aGF0IHRoZXJlIGlzIGFub3RoZXIgcGF0Y2hzZXQgd29ya2luZyB0byBleHBvcnQgY29yZSB0eXBl
cyBpbiBmdXR1cmUsIHdlIGNhbiB1c2UgIi0xIiBpbiBzaG9ydCB0ZXJtLg0KT25jZSB0aGUgY29y
ZSB0eXBlIHBhdGNoZXMgZmluYWxpemUgdGhlIHNvbHV0aW9uLCB3ZSBjYW4gcmV3b3JrIHRoZSBw
c3RhdGUgZHJpdmVyLg0KRmlyc3RseSwgbGV0YHMgcHJvdmlkZSBhIHdvcmthYmxlIHNvbHV0aW9u
LCB0aGVuIGltcHJvdmUgdGhlIGRyaXZlciB3aXRoIGNvbWluZyBwYXRjaGVzLg0KDQpQZXJyeS4N
Cg0KDQo+DQo+DQo+ID4gK3sNCj4gPiArICAgaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9G
RUFUVVJFX0hFVEVST19DT1JFX1RPUE9MT0dZKSkNCj4gPiArICAgICAgICAgICByZXR1cm4gLTE7
DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gY3B1aWRfZWJ4KDB4ODAwMDAwMjYpID4+IFg4Nl9DUFVf
VFlQRV9JRF9TSElGVDsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChhbWRfZ2V0X3Ro
aXNfY29yZV90eXBlKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuYyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBpbmRleCBjYjc1MGVmMzA1
ZmUuLmNmNjgzNDMyMTlkMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC01
Miw4ICs1MiwxMCBAQA0KPiA+ICAgI2RlZmluZSBBTURfUFNUQVRFX1RSQU5TSVRJT05fTEFURU5D
WSAgICAgMjAwMDANCj4gPiAgICNkZWZpbmUgQU1EX1BTVEFURV9UUkFOU0lUSU9OX0RFTEFZICAg
ICAgIDEwMDANCj4gPiAgICNkZWZpbmUgQU1EX1BTVEFURV9GQVNUX0NQUENfVFJBTlNJVElPTl9E
RUxBWSA2MDANCj4gPiAtI2RlZmluZSBDUFBDX0hJR0hFU1RfUEVSRl9QRVJGT1JNQU5DRSAgICAg
IDE5Ng0KPiA+IC0jZGVmaW5lIENQUENfSElHSEVTVF9QRVJGX0RFRkFVTFQgIDE2Ng0KPiA+ICsN
Cj4gPiArI2RlZmluZSBDUFBDX0hJR0hFU1RfUEVSRl9FRkZJQ0lFTlQgICAgICAgICAgICAgICAg
MTMyDQo+ID4gKyNkZWZpbmUgQ1BQQ19ISUdIRVNUX1BFUkZfUEVSRk9STUFOQ0UgICAgICAgICAg
ICAgIDE5Ng0KPiA+ICsjZGVmaW5lIENQUENfSElHSEVTVF9QRVJGX0RFRkFVTFQgICAgICAgICAg
MTY2DQo+ID4NCj4gPiAgICNkZWZpbmUgQU1EX0NQUENfRVBQX1BFUkZPUk1BTkNFICAgICAgICAg
IDB4MDANCj4gPiAgICNkZWZpbmUgQU1EX0NQUENfRVBQX0JBTEFOQ0VfUEVSRk9STUFOQ0UgIDB4
ODANCj4gPiBAQCAtODYsNiArODgsMTQgQEAgc3RydWN0IHF1aXJrX2VudHJ5IHsNCj4gPiAgICAg
dTMyIGxvd2VzdF9mcmVxOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICsvKiBkZWZpbmVkIGJ5IENQVUlE
X0ZuODAwMDAwMjZfRUJYIEJJVCBbMzE6MjhdICovDQo+ID4gK2VudW0gYW1kX2NvcmVfdHlwZSB7
DQo+ID4gKyAgIENQVV9DT1JFX1RZUEVfTk9fSEVURVJPX1NVUCA9IC0xLA0KPiA+ICsgICBDUFVf
Q09SRV9UWVBFX1BFUkZPUk1BTkNFID0gMCwNCj4gPiArICAgQ1BVX0NPUkVfVFlQRV9FRkZJQ0lF
TkNZID0gMSwNCj4gPiArICAgQ1BVX0NPUkVfVFlQRV9VTkRFRklORUQgPSAyLA0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiAgIC8qDQo+ID4gICAgKiBUT0RPOiBXZSBuZWVkIG1vcmUgdGltZSB0byBmaW5l
IHR1bmUgcHJvY2Vzc29ycyB3aXRoIHNoYXJlZCBtZW1vcnkNCj4gc29sdXRpb24NCj4gPiAgICAq
IHdpdGggY29tbXVuaXR5IHRvZ2V0aGVyLg0KPiA+IEBAIC0zNTgsOSArMzY4LDI3IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGFtZF9wc3RhdGVfZW5hYmxlKGJvb2wgZW5hYmxlKQ0KPiA+ICAgICByZXR1
cm4gc3RhdGljX2NhbGwoYW1kX3BzdGF0ZV9lbmFibGUpKGVuYWJsZSk7DQo+ID4gICB9DQo+ID4N
Cj4gPiArc3RhdGljIHZvaWQgZ2V0X3RoaXNfY29yZV90eXBlKHZvaWQgKmRhdGEpDQo+ID4gK3sN
Cj4gPiArICAgZW51bSBhbWRfY29yZV90eXBlICpjcHVfdHlwZSA9IGRhdGE7DQo+ID4gKw0KPiA+
ICsgICAqY3B1X3R5cGUgPSBhbWRfZ2V0X3RoaXNfY29yZV90eXBlKCk7DQo+ID4gK30NCj4gPiAr
DQo+ID4gK3N0YXRpYyBlbnVtIGFtZF9jb3JlX3R5cGUgIGFtZF9wc3RhdGVfZ2V0X2NwdV90eXBl
KGludCBjcHUpDQo+ID4gK3sNCj4gPiArICAgZW51bSBhbWRfY29yZV90eXBlIGNwdV90eXBlOw0K
PiA+ICsNCj4gPiArICAgc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlKGNwdSwgZ2V0X3RoaXNfY29y
ZV90eXBlLCAmY3B1X3R5cGUsIDEpOw0KPiA+ICsNCj4gPiArICAgcmV0dXJuIGNwdV90eXBlOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHUzMiBhbWRfcHN0YXRlX2hpZ2hlc3RfcGVyZl9z
ZXQoc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICBzdHJ1Y3Qg
Y3B1aW5mb194ODYgKmMgPSAmY3B1X2RhdGEoMCk7DQo+ID4gKyAgIHUzMiBoaWdoZXN0X3BlcmY7
DQo+ID4gKyAgIGVudW0gYW1kX2NvcmVfdHlwZSBjb3JlX3R5cGU7DQo+ID4NCj4gPiAgICAgLyoN
Cj4gPiAgICAgICogRm9yIEFNRCBDUFVzIHdpdGggRmFtaWx5IElEIDE5SCBhbmQgTW9kZWwgSUQg
cmFuZ2UgMHg3MCB0byAweDdmLA0KPiA+IEBAIC0zNzAsNyArMzk4LDI2IEBAIHN0YXRpYyB1MzIg
YW1kX3BzdGF0ZV9oaWdoZXN0X3BlcmZfc2V0KHN0cnVjdA0KPiBhbWRfY3B1ZGF0YSAqY3B1ZGF0
YSkNCj4gPiAgICAgaWYgKGMtPng4NiA9PSAweDE5ICYmIChjLT54ODZfbW9kZWwgPj0gMHg3MCAm
JiBjLT54ODZfbW9kZWwgPD0NCj4gMHg3ZikpDQo+ID4gICAgICAgICAgICAgcmV0dXJuIENQUENf
SElHSEVTVF9QRVJGX1BFUkZPUk1BTkNFOw0KPiA+DQo+ID4gLSAgIHJldHVybiBDUFBDX0hJR0hF
U1RfUEVSRl9ERUZBVUxUOw0KPiA+ICsgICBjb3JlX3R5cGUgPSBhbWRfcHN0YXRlX2dldF9jcHVf
dHlwZShjcHVkYXRhLT5jcHUpOw0KPiA+ICsgICBwcl9kZWJ1ZygiY29yZV90eXBlICVkIGZvdW5k
XG4iLCBjb3JlX3R5cGUpOw0KPiA+ICsNCj4gPiArICAgc3dpdGNoIChjb3JlX3R5cGUpIHsNCj4g
PiArICAgY2FzZSBDUFVfQ09SRV9UWVBFX05PX0hFVEVST19TVVA6DQo+ID4gKyAgICAgICAgICAg
aGlnaGVzdF9wZXJmID0gQ1BQQ19ISUdIRVNUX1BFUkZfREVGQVVMVDsNCj4gPiArICAgICAgICAg
ICBicmVhazsNCj4gPiArICAgY2FzZSBDUFVfQ09SRV9UWVBFX1BFUkZPUk1BTkNFOg0KPiA+ICsg
ICAgICAgICAgIGhpZ2hlc3RfcGVyZiA9IENQUENfSElHSEVTVF9QRVJGX1BFUkZPUk1BTkNFOw0K
PiA+ICsgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICBjYXNlIENQVV9DT1JFX1RZUEVfRUZGSUNJ
RU5DWToNCj4gPiArICAgICAgICAgICBoaWdoZXN0X3BlcmYgPSBDUFBDX0hJR0hFU1RfUEVSRl9F
RkZJQ0lFTlQ7DQo+ID4gKyAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgIGRlZmF1bHQ6DQo+ID4g
KyAgICAgICAgICAgaGlnaGVzdF9wZXJmID0gQ1BQQ19ISUdIRVNUX1BFUkZfREVGQVVMVDsNCj4g
PiArICAgICAgICAgICBXQVJOX09OQ0UodHJ1ZSwgIldBUk5JTkc6IFVuZGVmaW5lZCBjb3JlIHR5
cGUgZm91bmQiKTsNCj4gPiArICAgICAgICAgICBicmVhazsNCj4gPiArICAgfQ0KPiA+ICsNCj4g
PiArICAgIHJldHVybiBoaWdoZXN0X3BlcmY7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBp
bnQgcHN0YXRlX2luaXRfcGVyZihzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEpDQoNCg==

