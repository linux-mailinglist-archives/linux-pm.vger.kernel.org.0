Return-Path: <linux-pm+bounces-7738-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540AB8C2FF1
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91569B2283F
	for <lists+linux-pm@lfdr.de>; Sat, 11 May 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7363233;
	Sat, 11 May 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bQTxF4iL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3B1C01;
	Sat, 11 May 2024 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715410501; cv=fail; b=OvGNjR5JwLJ5VszTkGk573GtPB1D0yoMH/0q27ejvyDe0jpIzG2uBQShPAptmII/GiwK1k+b/PmumgN4AV2j4M+jM4PwmsUyCLy6Wy/AIQnnx+0Dsy5DqIT4Tmh0YzLYnQ+CnYBc+NUi/L1OjxoT2fZ8OwN1aUppVei1t64PM1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715410501; c=relaxed/simple;
	bh=LZ76HbBQlLed1Eowv4c5caj1975jomvs50XZH5OBbSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CU9r0lgyIdSEwTJxVzr1xTYA1h21vT7sMJ9/BKX2wWPPENIaWH1dkYyb+adMNLibUm8SxHlETFY/4U8a79kJMt7uixqS7nB8dzBNOceQxATlo/fLDCG1xS7AecdUcsiaM9t8zX7eS8Ddzpzhp6uTccLnkE3h8D2xJjwvRfLX/Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bQTxF4iL; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSRAR7VxrUJqh+MEGP58z4MSEp5JUGfuxotVvVDA7me1mtXFJvSNr8Cp2lpfoH+xwJCTL2ASXp63i9leV9wdtUDV2mLujfYgtY/OWuqxpTLHEsm4tOiMv4a1LL/2ntqh2w7wdjqk5dvH2pwXnxZu83ehqzipLTSqHOTPENaCBedDgKZYYzw+pbb6iujbkfu/Qg2titgdroYkCUDC8/7LYSZAM8uC14ud5C9hwNarRH7ydI6wrJlXzHTRAYyp6SewTWxLA7Bl04X16eQf3JdFJv/LmXz/IHMhUJx4MwXOGTs2198EMor/VJGir0eg2tLllv4TTIU3xIWSWAETEDkG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHTkIeXmPS06qKhr+PReLlhnsfta2Ps0Ga6s4ewcBd0=;
 b=OjQRRw7XXOlzYPr0tBM5liM4gciTMSegXpGsBNWpLvbJRDBCd4Ok6BJ2hary2M1WIqHJ5mt47r/acJ5S318o0eh5fF1BKc0CeJT969fIrhnXTQu7U/WnEbOZJUqsIbjxibDVaf9Piy4/uGzcYl3veBCEMj509xbJVydFSPwEgRE5E4vccgh27VGamK7dUVlM9/JLtXmABIM9iuKfy3Am/JERAQyaX7X2VgFbQrW0qjLO5X8OuAqg8jxqpscj/FHJ6nsX9nv4c6+CRcn/cJRGNYErMe6tOTcCDj2yoGk2o232svod6EqQWv+m+K4/kXu0T0zMUot8MIKl96L9gUtNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHTkIeXmPS06qKhr+PReLlhnsfta2Ps0Ga6s4ewcBd0=;
 b=bQTxF4iLMWEhk+YhPOzo0TzIeqi4dY9PMfaJhtRxlzi2cd1BYGtNy8LBpne+7ROsYsNgywl0aChJgNFfG469Ub0As/Y6hUHNQtLyzAAHLydbEhmoWQHMxM4IunoNTZHfhrvsxemiYPJMggg+dIPDdHMADFdlZ/5ZKY2xdwqcNzs=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 06:54:54 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.047; Sat, 11 May 2024
 06:54:54 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.sneddon@linux.intel.com"
	<daniel.sneddon@linux.intel.com>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "pawan.kumar.gupta@linux.intel.com"
	<pawan.kumar.gupta@linux.intel.com>, "Das1, Sandipan" <Sandipan.Das@amd.com>,
	"kai.huang@intel.com" <kai.huang@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition delay
 for some models
Thread-Topic: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition
 delay for some models
Thread-Index: AQHamgNtWe1ddAFBQ0WH2YyUktcGtLGRq5pw
Date: Sat, 11 May 2024 06:54:54 +0000
Message-ID:
 <CYYPR12MB8655660B0C221CF594A100769CE02@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240429070322.999500-1-Xiaojian.Du@amd.com>
 <20240429070322.999500-2-Xiaojian.Du@amd.com>
In-Reply-To: <20240429070322.999500-2-Xiaojian.Du@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f834a747-db91-4a5f-9610-fa2faf9be99a;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-11T06:52:39Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB7615:EE_
x-ms-office365-filtering-correlation-id: 8128357a-05e5-4309-54f1-08dc7187432f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?w144OdPqYudgu7BODt2fEBIMThlgPt42KFXutU7a1dWv01xlm7cjEoN5Eb8M?=
 =?us-ascii?Q?5zW05y9FtmUckd3n/7pmiHrL1W6vRR0Ah8HYdBoBobIQxDGKz0kxEVt6jy/f?=
 =?us-ascii?Q?589Kgj++iTI5RZ/3gXb2t7WfmECKDRkNIAZUP+zz1DRKQRBISQnDlEDFaAhC?=
 =?us-ascii?Q?0PcNQiCOkcRLRj4kBdMI2hI3dcUitzRjcnH57UIOO7+guTN5fmN5Bhd07SNR?=
 =?us-ascii?Q?/XRJdULMObUCtyeje8jQViw7GDRJ/O8ngURibzZnlig2zeWlXREbKHxPWCA9?=
 =?us-ascii?Q?JxxTGSHcjoZC/7fXPIej3ndqqSALPecgnnuw78myTpyz88O4qcb/Zzya63Mx?=
 =?us-ascii?Q?GN0JoP2zpYN+Qky2DTMpmMssBFEkY56QkbC+R/BliOgthAI3PN/D/ij24Wvi?=
 =?us-ascii?Q?PyYoqsHyg6sQSBsgTLRXGavK2hGApx2RV5ZVmCIs7edvqjciiWj40GwoGiBs?=
 =?us-ascii?Q?6jKQB1Mr+tY0LS9w0P9cNx2ETQqVb9w42H2AUeCkZdsBOVZqFDkvsufV6KJN?=
 =?us-ascii?Q?hbU3oea0BaT+dfWMpfsHDNN4Cs4IGb0fqA2VtHqa89zczSFf5Udb0+SxKfrQ?=
 =?us-ascii?Q?1Sje+byxOQpX4UaPmcipt4bEjvc4DYDNCWyrZnKQVoLsIQvwTFUp0YY+6TQv?=
 =?us-ascii?Q?0h8XMVpIKdOvdhpq7NikgFx7+lF9aZLlzH6WVLdPZitWsLai8fzQmt3LJ8IK?=
 =?us-ascii?Q?Z6pGE7F+1fCWnQC/XKN+q5+Xl1jozp1uINVCoe/NfBgPNZ/nyvrv22jNopnu?=
 =?us-ascii?Q?i8zND6h1dBY+M/oXxHLLv3ZTAIcgMS853RPvF+3LURdpbkqGv/Ln2p8gqiHR?=
 =?us-ascii?Q?X6fGn1Mgj/Nqc7AIc5K7qAwxjoFgp1hKh+K1OpykX8vq6jS+I9Q+4Jv+F4eu?=
 =?us-ascii?Q?kPbN2oins4jFNQsGK0khFyW5Y0vR1BfftOjXFuTBamZlYtd2tQ38FCzTVKwq?=
 =?us-ascii?Q?LZsJVCjZKoDYxvYTWDFw/B/JW9vnypEIsHN2JOF7BNV2XCrh/yL9stb7s8s8?=
 =?us-ascii?Q?8kRTSwE6rxXUeBQmLL0ihvyvZbnGyCNBe1rWK7vOd5I0//kt4dMIb2wTLcRQ?=
 =?us-ascii?Q?RyqzccR7x/3S9SVo03AW+wpB0/sR2e7LT0Di6r8MW8zeXxPFlOq0+ntXNter?=
 =?us-ascii?Q?a2+OOCNBZEUSu7YkoUHcBL42Z73D1xkeFBsR49J3LA7fbziHRwun6/J3kmD1?=
 =?us-ascii?Q?Z61EC3q9NhS6UpN6jvrL2xeDWrbqigDjnRV0VbgMo92xdpJX3XvY8QIYmf2K?=
 =?us-ascii?Q?HSh+o18Hw+9JBMOYUGaJOIHSJ6ga2n6zFl/wBlJ+sL+2P0GHhCN4NLKoqegh?=
 =?us-ascii?Q?ShagSyILMtWVv5D9rCx3O0q+nAw8wwl+esxuqjI4MUQbQA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LYxBclbzhC7gw+gCP7pdTMyOlF+zxkP1mzo3WnQ3dzed697bLMBZ013Sh+E/?=
 =?us-ascii?Q?/h6FrpI2VcuhTc6k4XYSLTxQhnOOHw57hV/zDZk+Alo3X21K2/z07HNOBcPw?=
 =?us-ascii?Q?k86BSoXtGwPba6Uj9jAjIzEF6SADUfN+lNCU8NPtCl+thUYQzLteRE2JPHzj?=
 =?us-ascii?Q?ih1g0Zn9pFODDnaU+t/L4iIxG8JaYcehyuuBlAmzwYYp3xcGsBEKvexXWOE2?=
 =?us-ascii?Q?UpCHFsBq/NeqwnTRpPC8I4czh+Mdu9Sc8rzdKRxNmhPgnzEcJeacqTK9t6BM?=
 =?us-ascii?Q?WlKDrzVOLw8pJen2WOWL+Sx4T6rvD+ge3yjNHyUTQGLssjVeS1IFPOiz87/8?=
 =?us-ascii?Q?ba5vElX3AtJwWJn0Fz4hmjMvM2vAtQ7YSpRrzi6yTbCcHjQbXZxk1UY0Rd1l?=
 =?us-ascii?Q?j5CCqRwpH0Zjqt1JwWojxnjkDoDZEVQDrT9szyEbeB7KDMu8FB8lEKan1oRJ?=
 =?us-ascii?Q?7jqwZz13iVr5CwRuw5xD6ICT+ZSsf/tx4m03NYlhoCG0izxdg1IE7+T8iUMr?=
 =?us-ascii?Q?O9lPCs8c44uJyMkLFXPm9sNA+dqxUsdn3jdCNaUQww9C7R8SEqWE0NZSWA1i?=
 =?us-ascii?Q?ySoVd1ezRl6CnbxkeAjC2xMtIMrHamhSNytDaxG6e4jF8icCk+62rNoeB0cP?=
 =?us-ascii?Q?1se6+HNqhaY6XNCUQrsrlwYnD1AaIfyEdtVl+fSZsOWnQLk/LGRYWaNVyI/g?=
 =?us-ascii?Q?Q7PoVrM3llb0zK/2N6lPeUFJ/73lHV+Cj4uD0Q2qQ71gOmENbZz8mby6/zRp?=
 =?us-ascii?Q?dcsOVlNHFP40u6PjI7uQ8xpcHx9IsAIphhByLpqG5+ZHWNuV4t8aUwGQDy7X?=
 =?us-ascii?Q?4Z5/BItwrBPrfMSOdbEy2ofoXViF+j9pyiDKdoBrVsxp9LPwkTgeo5zGo2a7?=
 =?us-ascii?Q?c6vTwrL/yTEDUYtVK0F4nqJEL+tWfWE+Xtz+L9OlktaBRAIMBILeKwcd9JMy?=
 =?us-ascii?Q?Sv4SWK6OY/V7IdxjKYrAXPlerOGu4Eo2gXNIihugm1vShMHwQaHDfUb7YeNF?=
 =?us-ascii?Q?fkzyibnx3LQL6lsTtNUCXKdvmpkrswll+C0+Iam6ap3jwh+C7SKyKeEZN58H?=
 =?us-ascii?Q?Ah8y1OXbP6x390k7DAoKMi5TKBos2cGs9uQ+BhnvhCKQeIGb2BYSIShR4vAo?=
 =?us-ascii?Q?2jPZ+CTu0GxuGugmCi0jXSiNSClkRAc0veHuDnT5Iz9LhbY84GuuiqN7gmq4?=
 =?us-ascii?Q?BfkqXk5weVhcxVsqxhKK9LUGWmGfsCCGT6/l4aKxt1CVCmTsekzy4gq4WDJs?=
 =?us-ascii?Q?Vc9OSy6ORjDzUjHyvLK1QIqEUeNEuruh8kff65Z76z85OBe80XJRqr153n6V?=
 =?us-ascii?Q?z7R4NEBgaqJIpnM5yR9JwnkkuJQhbuw4qMw1KbG9dqUZlp5EQv9Hp+1V6jCa?=
 =?us-ascii?Q?eDaa2l4RXp3zSjJzJ5p4JPUWQTIhuqJMAbiu5LQIskpGABIQfWmv/OHLojTY?=
 =?us-ascii?Q?ltF5xAiY584PXbz08H7P6uOPTNv/bK3C24hWk8CVD4ODlLKqe0NT00460AFT?=
 =?us-ascii?Q?rPUek4sqodcCESyKrY3SAFgQdy2RHVwDseObUkoUiYM3FQb4Ok8J51DeyYqt?=
 =?us-ascii?Q?Vf0g7UNkVTHrMTYuR6o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8128357a-05e5-4309-54f1-08dc7187432f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 06:54:54.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAE51TPd8nfl3T4c+pHecWEEXbHYJqzgSzB/yIxbFgPoTIPif7+lKCL2mlxOk7SSW9tmXCsG/+U0ikakmzgBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615

[AMD Official Use Only - General]

> -----Original Message-----
> From: Du, Xiaojian <Xiaojian.Du@amd.com>
> Sent: Monday, April 29, 2024 3:03 PM
> To: linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com;
> daniel.sneddon@linux.intel.com; jpoimboe@kernel.org;
> pawan.kumar.gupta@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; kai.huang@intel.com; Yuan, Perry
> <Perry.Yuan@amd.com>; x86@kernel.org; Huang, Ray
> <Ray.Huang@amd.com>; rafael@kernel.org; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH 2/2] cpufreq: amd-pstate: change cpu freq transition dela=
y
> for some models
>
> Some of AMD ZEN4 APU/CPU have support for adjusting the CPU core clock
> more quickly and presicely according to CPU work loading.
> This is advertised by the Fast CPPC x86 feature.
> This change will only be effective in the *passive mode* of AMD pstate
> driver. From the test results of different transition delay values, 600us=
 is
> chosen to make a balance between performance and power consumption.
>
> Some test results on AMD Ryzen 7840HS(Phoenix) APU:
>
> 1. Tbench
> (Energy less is better, Throughput more is better, PPW--Performance per
> Watt more is better) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Trans Delay   Tbench              governor:schedutil, 3-iterations avera=
ge
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  1000us        Clients             1              2               4      =
        8              12             16
> 32
>                Energy/Joules       2010           2804            8768   =
        17171          16170
> 15132           15027
>                Throughput/(MB/s)   114            259             1041   =
        3010           3135
> 4851            4605
>                PPW                 0.0567         0.0923          0.1187 =
        0.1752         0.1938
> 0.3205          0.3064
>  600us         Clients             1              2               4      =
        8              12             16              32
>                Energy/Joules       2115  (5.22%)  2388  (-14.84%) 10700(2=
2.03%)  16716
> (-2.65%) 15939 (-1.43%) 15053 (-0.52%)  15083 (0.37% )
>                Throughput/(MB/s)   122   (7.02%)  234   (-9.65% ) 1188 (1=
4.12%)  3003
> (-0.23%) 3143  (0.26% ) 4842  (-0.19%)  4603  (-0.04%)
>                PPW                 0.0576(1.59%)  0.0979(6.07%  ) 0.111(-=
6.49%)
> 0.1796(2.51% ) 0.1971(1.70% ) 0.3216(0.34% )  0.3051(-0.42%)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 2.Dbench
> (Energy less is better, Throughput more is better, PPW--Performance per
> Watt more is better) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Trans Delay   Dbench              governor:schedutil, 3-iterations avera=
ge
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  1000us        Clients             1             2               4       =
       8               12             16
> 32
>                Energy/Joules       4890          3779            3567    =
       5157            5611
> 6500            8163
>                Throughput/(MB/s)   327           167             220     =
       577             775
> 938             1397
>                PPW                 0.0668        0.0441          0.0616  =
       0.1118          0.1381
> 0.1443          0.1711
>  600us         Clients             1             2               4       =
       8               12             16              32
>                Energy/Joules       4915  (0.51%) 4912  (29.98%)  3506  (-=
1.71%) 4907  (-
> 4.85% ) 5011 (-10.69%) 5672  (-12.74%) 8141  (-0.27%)
>                Throughput/(MB/s)   348   (6.42%) 284   (70.06%)  220   (0=
.00% ) 518   (-
> 10.23%) 712  (-8.13% ) 854   (-8.96% ) 1475  (5.58% )
>                PPW                 0.0708(5.99%) 0.0578(31.07%)  0.0627(1=
.79% ) 0.1055(-
> 5.64% ) 0.142(2.82%  ) 0.1505(4.30%  ) 0.1811(5.84% )
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 3.Hackbench(less time is better)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>   hackbench     governor:schedutil
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>   Trans Delay   Process Mode Ave time(s)  Thread Mode Ave time(s)
>   1000us        14.484                      14.484
>   600us         14.418(-0.46%)              15.41(+6.39%)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> 4.Perf_sched_bench(less time is better)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>  Trans Delay  perf_sched_bench    governor:schedutil
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>   1000us        Groups             1             2              4        =
      8               12              24
>                 AveTime(s)        1.64          2.851          5.878     =
     11.636          16.093
> 26.395
>   600us         Groups             1             2              4        =
      8               12              24
>                 AveTime(s)        1.69(3.05%)   2.845(-0.21%)  5.843(-0.6=
0%)  11.576(-
> 0.52%)  16.092(-0.01%)  26.32(-0.28%)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> 5.Sysbench(higher is better)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>   Sysbench    governor:schedutil
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>   1000us      Thread             1               2                4      =
        8                12               24
>               Ave events         6020.98         12273.39         24119.8=
2       46171.57
> 47074.37         47831.72
>   600us       Thread             1               2                4      =
        8                12               24
>               Ave events         6154.82(2.22%)  12271.63(-0.01%) 24392.5=
(1.13%)
> 46117.64(-0.12%) 46852.19(-0.47%) 47678.92(-0.32%)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> In conclusion, a shorter transition delay of cpu clock will make a quite =
positive
> effect to improve PPW on Dbench test, in the meanwhile , keep stable
> performance on Tbench, Hackbench, Perf_sched_bench and Sysbench.
>
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..8c8594f67af6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -50,6 +50,7 @@
>
>  #define AMD_PSTATE_TRANSITION_LATENCY        20000
>  #define AMD_PSTATE_TRANSITION_DELAY  1000
> +#define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY        600
>  #define AMD_PSTATE_PREFCORE_THRESHOLD        166
>
>  /*
> @@ -868,7 +869,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy
> *policy)
>       }
>
>       policy->cpuinfo.transition_latency =3D
> AMD_PSTATE_TRANSITION_LATENCY;
> -     policy->transition_delay_us =3D AMD_PSTATE_TRANSITION_DELAY;
> +
> +     if (cpu_feature_enabled(X86_FEATURE_FAST_CPPC))
> +             policy->transition_delay_us =3D
> AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
> +     else
> +             policy->transition_delay_us =3D
> AMD_PSTATE_TRANSITION_DELAY;
>
>       policy->min =3D min_freq;
>       policy->max =3D max_freq;
> --
> 2.34.1

LGTM

Reviewed-by: Perry Yuan <perry.yuan@amd.com>



