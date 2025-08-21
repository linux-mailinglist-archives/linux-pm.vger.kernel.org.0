Return-Path: <linux-pm+bounces-32780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80090B2F023
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD585C3EA7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B672E92C6;
	Thu, 21 Aug 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzsxKisk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8192E92B6;
	Thu, 21 Aug 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762765; cv=fail; b=eCFeVFK4nGPEkDzsGuVPIifNWCAL/rvE/Fehk435EnE07q3GlCNgaacWqqu6N8S3Z3UWNXxMkV6aKakJtbTMzVm8k2K8YMHOusJr9uVljHlPZ0aiAyonBwLsCZmDdn9VL0K2YbvpbnFqqOEkwgwCI4YPtNw7WKhzn8CJtFnBOa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762765; c=relaxed/simple;
	bh=JNjTa6Q2w+7jg3FSH4AoZ3rvtY2tP/6TBEArfAN+4jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAkyYHSIWuT35texgV3n37hrFo/vUnvUfSatLFmnvD37noBARyt44i1p4erb+CPbn43QCuLRy7q8dJxJ/3unTBhZjNebej3ptqWwM/+TUpzZUUJIZRwKE1eQyTvYJwk4GKagMk6F996Tb0vSUSknzRrCb9a+o6bcRd4Nme3wypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzsxKisk; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcX+mU94rwwP8tT/QGp46EEJHT99v2u9AjU7Ys/xPRXpaNiHnSxOBskXPIEntvmqjExY4buJcTHXoL17jqxFx3bN38ZJJUUbggfjbG2hhiXw5Lg/jpxvt7miJvOmAZ+waqyVzQNTN9e8+/iesxb7ar2cIMc5IABYVMxzM/PxLTj5eufZV+4VDLy0XXYNeMMRerAR5oTJzs3eQ2C64kQYlyT1p94GKJT6ISmP++nPqdwzVw2F1hTxOMk/0LRSRTrlPa4F5aVciLEhdyD5/JuZwnMQRZtGAEIXl8WfeErtZYlxVyjuUcgaqR4fhvKSpcr9SYifM8XUkUS7wA8t607tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNjTa6Q2w+7jg3FSH4AoZ3rvtY2tP/6TBEArfAN+4jc=;
 b=amp8eXzO61v1BMkbaghj+AH2cIEsluAbUE9wFLpYjHCbuHdJBnHTm+hQlJbWY99WnHQS6wNxVB8ZmHU1KRiFzlejhHTEVOnSi/ILvCVTJVDq6bxqBOuzurb8UBD0Bgz5iYXsh5VDxH2XyYVrg7MNbk7RYNCHrnM7LY/bbpmF3WWJvz5NgUs5632VbdC1vjFs0KMHiCaa7fx7urKMElg02wJPEjpkYwujlLFwqEV21roAiA0FuTPvI/s2oPMLIsK1U/7ye09b3dwYEkCTo7L1ayVZoR+2NJ8edAlzKvI3prcQgQTdPwuDsJ/Fg+EsLbTJoRcE1FvedrBK8ZSn7dJyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNjTa6Q2w+7jg3FSH4AoZ3rvtY2tP/6TBEArfAN+4jc=;
 b=nzsxKisknYhV9usWPVSCmdwye5R2Lh5cBG5HSUQO2pOJOThHZamQEwtGMjZSFsMsWv9ZeryWBcdcOlecdVfDmFrDipeIk18gDjNwvkySitOtZfdnkdxIrNRrPOTySRNKDGHxI+ZC5C8cmmPaojx4UiVOEuWHQMSzMhcSSGpmhx8BToHtrBvQulEkU20LZZNUNq3nldBUiKNz+HMnBSbo+vWMh2kNggg7zoLke6AzbRBjrq2CW3BmSMPUPOcy0+gw3f7gSTcUSAWEjSgZGUhkJlsYGntOBEcT9Kcn6G+3OlUPTAhexdVVIDypLNu5WVwEx2lfsTGYrKQ8Iqm8yR0dug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 07:52:40 +0000
Received: from IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6]) by IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6%7]) with mapi id 15.20.9009.017; Thu, 21 Aug 2025
 07:52:40 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thierry Reding <treding@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 1/6] soc: tegra: fuse: add Tegra114 nvmem cells and fuse
 lookups
Date: Thu, 21 Aug 2025 16:52:36 +0900
Message-ID: <3308204.5fSG56mABF@senjougahara>
In-Reply-To: <20250820114231.150441-2-clamor95@gmail.com>
References:
 <20250820114231.150441-1-clamor95@gmail.com>
 <20250820114231.150441-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e3f64c-817c-4beb-8da7-08dde087b41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjhBODN0N05Ecm4xak5SWFh1cDk4UkhCQWhXMktDZGpBVnpMaW14RU8yRVpl?=
 =?utf-8?B?Skx4UW5YTXdqNWQ4bEUweGF4Nm9ya2NLRjROOHhYU1FscEVYcHFuSldLa0ZQ?=
 =?utf-8?B?a0cwRmpUdnRYSG0vd1FzeHI1aW0wV05KMDBHZnRheHR4YzJZWXoyekNkcjdU?=
 =?utf-8?B?bjFLVWpQamlDVkdWQ3IzampjS0hRMzI4TFlFNDlMMVNZOENYdURhLzl1QXNn?=
 =?utf-8?B?bldiVit6NGY1cStNNmdSaGVUemVyTXdZeDRCR2R2N0U1UklNVCs3WXA0TXA3?=
 =?utf-8?B?dFRjZkNpTmRDSWMvb1FVMzF0T1J5L0VSZGxxT1lGdllESnhvOGFUay9GQTFs?=
 =?utf-8?B?bXRybDkrb3hlcGhLZnpnRG1NTzFVamtRT1BpWjhObXJDTitaS21GYVJqbjhD?=
 =?utf-8?B?Q0l5dWNPM1VMY3ExZXRnUU0wR0tVKzJBNyttQnlLeVhsQWU4OTRzTUJRc0ti?=
 =?utf-8?B?MWRGekg0MXQ4UEZVR2IxRDhvcWp2NDdWbnFMRmZORklXV3hScytDbUFvemxv?=
 =?utf-8?B?QzA5T1p1T29jMExqajlBTm1vMmdhSmJhaGVOMzJyU0lUVkJienlxNVNwbWF0?=
 =?utf-8?B?SUFuQVlCcUlVUmg5S0ExZHpGU1ZWT2RaYmtRS3ZmdUxhaDFQblZHMjY0SjdB?=
 =?utf-8?B?MnJVT0xMWitYMlhPRDFhUENkR2N3TkhDcmxDaUcySGRBRVM0ZmxrS1Ruc3Iz?=
 =?utf-8?B?Y0NzVC8ySmlEbUM0am5xNENkVXJrcG0zVlh5dUk1WkVNaThMOFZud2FaSGhM?=
 =?utf-8?B?UEE3NldqYktqSFRyeXlhV0hlVDNmYjkyclRxVU1tdEdyNDErNUxiYk8zTTVQ?=
 =?utf-8?B?bGdNSG8yQS9lRE9KaE02MHJvUkhlaDEyN3l0dXJPc0llL1hEd0YyM3FJMGFB?=
 =?utf-8?B?am56VUJrblZBSEFQNGhEWUVFTDQ4Z1RGK3pmazNWS2xJMUN3OC96b3JNd25Z?=
 =?utf-8?B?TGg2WkptVDB3Z1FQS2g0cDUwUkdpSmFrRThweHJsZHFWbStaMDZmck5UK2wy?=
 =?utf-8?B?cEYwNEFhT1Z6Wi9tU094alE1UzhJSzh5VGpBSlVTM3V4c0oyQmVnMHNBRHcy?=
 =?utf-8?B?MFhMb2MxUnFXbmlTNW00cU1xRGdpV0c0TDNGSjdBelVHczB1bC9rYytObEls?=
 =?utf-8?B?bEkyNHQ2TkdtQUdIR0tSUHNGNCtnNy9DK21aRVVPYmg0REJ0YXJRSDAxQm11?=
 =?utf-8?B?TUd0L1JlL3p3QXVqSTJFNHVNcEhaWElUM1FrVWZQWEV0aVBJamxLN0laMGxp?=
 =?utf-8?B?aXlHT29OL2JDODNCTEVNYkFXZFIwMUJDOFlxa1VhS3hRNTFQNjNoRkNEdWZI?=
 =?utf-8?B?WVZMbURvTGtEUWJUVjdXeGkyVFNEOUVjY1plR0hLZFFMQitMQjk5RThKZWxR?=
 =?utf-8?B?OEJUUVd2MVlVVDRlT1lwaWpxYXJzZ3dsRmE5Ym1udGhUOVJDNkkxUWFVSDNi?=
 =?utf-8?B?L0dHcHZBeW5wNCtwU2w2SlpLbHE0QjNSc0hQL3NVczlEL2JVeUREa2FpOXlI?=
 =?utf-8?B?VTFRYXgrUWJ1ZlFRUFROTlNzRm5PV1JEQ1ptY083ckhRWWVPdERNZEQ1eUtS?=
 =?utf-8?B?UFI2ekxFV2lpdzEzb2tSTE9JaEw4Qi9YU3FSLzR6WnFpblV0bFIxNGNEdmhw?=
 =?utf-8?B?RWx6aEp4QlhKeDZXVFlleWNpT0NyRVpQb0c4azU0Y2RDN2JBZHpsNmhsNlEx?=
 =?utf-8?B?d1dTdnVMMlJ2Z2dOQ1p2U2RJWlk2d1dHRGY3eHdQUytZVFJYMFE1MEFyM1RZ?=
 =?utf-8?B?aGt0elR4blI1Y25qbWZNMG0vZGFsS2VIcnUyOFlhQkVEdFFJdXZlTkxHRVZi?=
 =?utf-8?B?aEE1d3FnNXM1RHVxKzhtRGhPWnlvVzY0Qk9IQzlFaGM3WmJkd0pHOWdkRUtY?=
 =?utf-8?B?L0ZRMWdJcG5JWnZ5QVVhSTJmMzgwYUxDZ0phNDY1U2JwWnd2dUp0cU13cHAy?=
 =?utf-8?B?RGpxa0J0clcvZnk0KzBLSXVtNWM5RzhmdEtSOXdyMFdOaXJXMzFTNU8zbHh5?=
 =?utf-8?B?L1gyMTV5TjF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3RDaHRoUUNnREt5NnpOZC9iRTZIb2Zrb0dZbUJDMWF5NmNSK2tCMHo2SmJi?=
 =?utf-8?B?K3Z4SzQ2TzlQdXlzQ0JCUGt6dTl2OFMrS1NRMDdKUERXV1dVSGVRdExCVFpG?=
 =?utf-8?B?b1VNblZEWmRDV2dONWRTNFZrdG9kanI3aENnejliSWkvMk85Mlh0ek5jOHpP?=
 =?utf-8?B?Nk8wK1NCbVZqdlNkejU4eURxcHc5dzdNMGlkM0JJU1czT3F1Rk9JN3BKOUVx?=
 =?utf-8?B?cm00am9Oa1A5ejdyaEErUEZseUlybmdWTU1jYXdQS1h2TlRNZ3R3cVZSZWFq?=
 =?utf-8?B?Y3lVRGpYUkptelVBNG1oOGJqM2ZxNHJmb0lNMzJrTlFXNVBXcG1uM05ZTksy?=
 =?utf-8?B?YXNTSFhDRGJ5RG9CT216MmtlZ3V1ejdvNGNPR0I2UGN0c0d5UVJTYXpwcUI2?=
 =?utf-8?B?cGptWE5qOXhGdDNudDY2eTZUNXZyT1NuUHJOZ0IyMG5yY0JjcE8yYjVXMVlH?=
 =?utf-8?B?TUdvY1RUbXJKbWp1TzljaCtFTE5ZY1MwbHdIUCtic3pWTHJUVEZ3dWZEUXBU?=
 =?utf-8?B?djJ2elJUejhGZkl0cFJPaDJXL0JSQ3pFREI5R1N1U2Z0cktlTW8rVmw0YVRu?=
 =?utf-8?B?Zk1IeUVuSklyTXk5RUpVZlViUGhPaGdQdGpocEc2bWdYYUhlL3JCWlRtUVF5?=
 =?utf-8?B?Yk9Ic1VEMy9MY0VqbUZjSEViK2F4M3lGdlMyY3ljdXA2b1JRSU1RTWovTVk5?=
 =?utf-8?B?ZlkxRHB5UzFHemw2MFlVRVEvOHR2elp3UVRsaS9EQXRaTHo3Ump3TFdlQ0xa?=
 =?utf-8?B?WEZuWjJaSW1kT3NERTNMeEVwT1hLdklPTTQxeG9yY1hhc0pVWTh3OEN6RW03?=
 =?utf-8?B?VFhYVVM1a211cG0yN253Y0ltVjVJcVByNEtTMGNNMlZ5cU5QcXRlVFkzNWNI?=
 =?utf-8?B?TFBHMjZsQUI1Tm1YbnpKb2pVSklhVkRvZFpkTGZxMzZXOE5UdmMxRG5aTFQ4?=
 =?utf-8?B?eGxJK2JKQzhVM3lDMWFWc2FYTEo5K3VvdDdSMjZWWEJXU3NuWmp0d0JFNktt?=
 =?utf-8?B?aUt0QlZLbUFoRVhvK3JCU0VLZXE3OFBuQWowYmZGbzBQd0EzTzd4OXA0WWUr?=
 =?utf-8?B?ZENSdVNEaDdPM2VoNFZmZTN0NEVvcGZwSWdvVWhndWM1VVpqZkhXZjZabWdm?=
 =?utf-8?B?T1FuWnVySG5UbHNXbXpFaGYwMmJVVmRIM2ZLbG1FbkI4cHVmbFV3eUo2b2VY?=
 =?utf-8?B?YlN2YkN2NjM2ZXFYTHpRbHFZbjB3ajN3cmkyZDVpZzVxN3czdFExSm01SjJp?=
 =?utf-8?B?V1crM0dJdFFLRFR6MlJUZXIyTVNqZXpRVGF5RWI2aVBTdjRka2NSSEZWSVFS?=
 =?utf-8?B?eVVWcktBa3ZYRnRUSzgyNU9yT1VRNXBta3RDbFVGTEs1NSsvUjEzMTRLRDQ5?=
 =?utf-8?B?T1VOOUNUb3l1c2lkVzZRZDZiTHprYk5Lb1U0S3o4OFdCanJiaXd5dVFCMlRE?=
 =?utf-8?B?Zkdva3lGTWRndlJiaE1Ybk53WVpXQ25HcXlqL3RBNDBGWXQvNnBQd2dWWTU4?=
 =?utf-8?B?cXlKVVF0eEZIeGd2cWpSMGVTQmVaUFpUN2RFV0UvVDd1Y2krRWNzTlY2WFJB?=
 =?utf-8?B?ZDVWUzBUWVZhVnVnK0pmaHg2YW5jcCtSYXovUjVQV2MwdWxuMTRPK2ZITkZK?=
 =?utf-8?B?Yi9mR2RMcHk1dEl0Z29IWEkrclFVUE4rS3RUY3ZUdDBhazdQU08zeERyM0I0?=
 =?utf-8?B?c1JBWmd4eWUwUXh2YmhaY2dNRjhQelo4ZG5rYis3N05YQTV3ZTdvQ2Q0NWxZ?=
 =?utf-8?B?UERWR3RjSW94U0ZvN3F0ai8xZXRZNXgxS2dRa3RLMjZIczdLZkJqTGJWaHBS?=
 =?utf-8?B?akN1ZjZma0s2b3Nud3h4UldvU2xlODdZOGxRUzJSZ01wRUZwRmd3dU5xd1hV?=
 =?utf-8?B?eHZvc2IwT21waXhIZnpuUlVQR3VWcnorSVBkU1NWWmxIK2xqUGwva3VONW50?=
 =?utf-8?B?K0JTcWpXUS9GRjhCU0tVeTV3UEtaQXNWUm9GU0VUWmx0MXRMRFBoUGoycFBJ?=
 =?utf-8?B?TjROM2NoWS9kWVl1UVlFbXdxZlJSNjRPc3lxM0VKaWx6WW8wdlZ4RlpDVzhl?=
 =?utf-8?B?bU5TOXNubSs5OHBNMVdhTzFFWEptRW40cXAvZXhjR1JFRkMzVkNHS2xsU2p4?=
 =?utf-8?B?blVObUQ0WGl1ckxRcDVNb25IeGlUM1FpOWh4NW1QVjdzSUVTTTJHblhVSnZF?=
 =?utf-8?B?SG1GUnh3Z2RES29DSTlSS05BeTd0dDFiZlg2bHlaNFM5YjdwdzRKcWVMeEZP?=
 =?utf-8?B?Q1Y4SWtaNjEzdTZuZnJZc0J6WG93PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e3f64c-817c-4beb-8da7-08dde087b41f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:52:40.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJgFgbPjY9/BqMqIjDqEztF3/rBSRuxIBOKMpnIoo40m1WIOSkxY+9pBuFMPM3hM2EcIbvSz33N4WCnpvdWewQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> Add missing Tegra114 nvmem cells and fuse lookups which were added for
> Tegra124+ but omitted for Tegra114.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ...

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>





