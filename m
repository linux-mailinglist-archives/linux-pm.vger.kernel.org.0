Return-Path: <linux-pm+bounces-9138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F09081AC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA2F1C215CB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 02:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB481822EB;
	Fri, 14 Jun 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZWgI1+cE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20870A954;
	Fri, 14 Jun 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332360; cv=fail; b=YkJVwM8INx4d7xBlRU9Dc+DMKucZ6j7pw6bp18RkIBo/q7+jiYJqoPouzxIq89BEDci0UI8bnOgSt5KjwO0PRZvZjcMIZ2DZ78U994B0lVf/xGz7tgZ1r0PtLWj+j/zAgtjCZ3FXhi+kqddsnaVWieERqGzUW2G5kkKi2is83Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332360; c=relaxed/simple;
	bh=12N9tQ0GGO+2xZRawzO1EWqvP8pZNsVVSSAB4RAshXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWoD3YhIRqOXEBBzr17C6yKNLc0FciScjgySnUtcFaF3ZjYqfcKwWZo8Rymx31dW/gi+ObV6iAhBh0X8yl9IUlmcfJL04QEpcahU/XwfORxhB0ipRu37S0dwrxOUNbMKlO0f8r/VGS+H81T0a00rllRvKa0ehkefJ3rxM/NUtYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZWgI1+cE; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxPcIj2S/BBZmHFB+i5aqYaQRBDIb/+APvPcBBbQ3XfUxemGYqHi2YeJ8jyu9YGyfXIxI6uQyDsRr7jhpEMKrz7IkwoI67zpIK2gTzJFo1hnf+HEuaTDPwZGuHM7db4t/jm3P0+lbyvPeKcowHcXshrSG/dGOknRHGk+VQ75ZoERiPfABDdQ0hCo9M7GJShW7e47k1zq+WwU+mEPME27yxM6wsxfmWto4m+ZMskt56LiAj9MYGdxWLr0AFIanjToGwiEmW+CEMcxC5umRr4sLlMmwQSLcyAF/hZP0E/gqWf9V2YhN96L7osk4/O4sS+oGOVQGtZYoAb5bxtqecXzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12N9tQ0GGO+2xZRawzO1EWqvP8pZNsVVSSAB4RAshXY=;
 b=M+RAcJrVuR9TOp/ivv7Zvf/w6TwUPcMTNeE3Fi0w6s5HolhAqIaj9RKJ2kHLpzbA55LBS/W0yN74hU01IJ6zz2RI5/ZN7ya/Yp1zUCJHVau4P4KAiwejhlmwoouYOtCn4DN7RPPBTfQn/nrWkTvjuRB1PpA9e1HVXlBQtkxCCr3WoUCXJuffHuoaE9uC/p+AFpVyi2uhN8s7IflMqzQ0l4Y5trvml7acB1tp6cT8CesWs+Jh54v4CVnPdYY2pFPrqk88FSPsnFTUERpwrkJ1FwHNmSFA6HyUvWk4wjQF4GTUMrr5VvIdGqJQ46hHf2mCTzG6CzEKeqJz/5aS0AiwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12N9tQ0GGO+2xZRawzO1EWqvP8pZNsVVSSAB4RAshXY=;
 b=ZWgI1+cEh35I4R17TNn6B5n2Me+Q/V6TU7jgULLI+CPIDQVc6JZ1NQ4MPzHz0To6mrvz2OiKi5YDiMj+TjwwLJVvWJ+nBTwQNNmF67foZTx5qOVv8+bXsujVgJWj17fUQ6WlU9MTVrBw3MaCcevKUAHiGJXZLWg++8Uh3pVmcMo=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 02:32:34 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:32:34 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>, "Petkov, Borislav" <Borislav.Petkov@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Topic: [PATCH v11 5/9] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Index: AQHavWMZER7VWRq7DkCqA4Hpli19fLHF+uWAgACQcmA=
Date: Fri, 14 Jun 2024 02:32:34 +0000
Message-ID:
 <CYYPR12MB865534CC49D3AB044FF373AF9CC22@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1718262992.git.perry.yuan@amd.com>
 <35464456ab468f389ff3816829647db77924a6b5.1718262992.git.perry.yuan@amd.com>
 <0a1cf7fb-5d2a-4737-bbda-cb866270a523@amd.com>
In-Reply-To: <0a1cf7fb-5d2a-4737-bbda-cb866270a523@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a11601f5-af69-4164-ba4f-6c92a76fe36a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-14T02:32:10Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: cf4053f0-a27f-4762-2b5c-08dc8c1a3f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2t0c2RjdktPVmM2emduNnFXbXRwamVBNTFXczc0VkcrTThNNGhBdWlaQlZM?=
 =?utf-8?B?NWFBWTA2c0ppeFJpVGNmY0VZVWxFUXRXOWZjY2tnUnZoQkJKSjBFVHhYUWRI?=
 =?utf-8?B?b1NnNEErZ2d1UUxhUXFXRmpVZm5NMFFxcTFaandlRVJCcTNLMFdRY3hLOUcv?=
 =?utf-8?B?TVh0TTI2MFVpMXNNcjRLNzdOWDQwOEd5OWVSbURzMjk1OGpmTjRyWVQrTEZW?=
 =?utf-8?B?Yk52ZXZjaXU0bDJ6UUdpMlB1L2FST3NVV2xiRmhRY3BCNHpaTTlJek5aU2dt?=
 =?utf-8?B?TnVBdXdMMU9iNll1dndteFJUWFRIc3RJeEI3TjBKdWV4SXFONWRRQXJBa25x?=
 =?utf-8?B?bHdpazU4R3gxcFFvN05nSkxBV0xVTkNnMjc5Vm1UUFdzNGxHMGUxTlB6OVFi?=
 =?utf-8?B?bjh3c2hiNWNxeStPRzVMMDVKKzBBOUpVSG8xcXFaTlF5dnhjOGE0em1FT1Ew?=
 =?utf-8?B?WjR4dHVlak96S0g4QWlmdElmdmN6MTU5YmViK2ROOFpMeklvOHpxdkN0TVJs?=
 =?utf-8?B?QmZBaWczZG1iNk9kVVFqVnAvWnppMG9nRWQvbE9CNjNSRWlpb25ublFyNEJ0?=
 =?utf-8?B?ZFdqaVpGY2Jsa3dBWDRFSUROZW1Hd3JienVveGVYczhDeThGcGZ3ZGFPS0xp?=
 =?utf-8?B?SVVJeWNWM3pNYk9KM011NGdSZXdYNVdCR1ZUazVjeHFGanpDbGVmc05kZ2ZY?=
 =?utf-8?B?SU1FS0ovZXkvWTBybTQzeS9RNTFDb2ZhMlM3OG5NWWxFV3A3eE9ncG41U1Fk?=
 =?utf-8?B?VHNBNGxNUmdPei9GbWRVb2pXQ1U1VWg1RjBkaWVEYzZoK3hEZ2FDRzBxQ0pw?=
 =?utf-8?B?RHF3eGRyTndibzNra0F0SHFzMUdiUzZvVUxHZjBhZVB6ak9BeExwYWlBZXRV?=
 =?utf-8?B?Ri9COGpNWkFTMXpUM1pucUU4N0ZFOXplM3phQlI3R0dFYlJyV2w4T0VMNnh4?=
 =?utf-8?B?WDk3MkhFS1NvMFZENW1ETllUZXV6VFQ1STFZemFYZG1ZOEQ2Mjg0ZTY0Qmk5?=
 =?utf-8?B?cXUydS91em45YkJxTjEvZnYxYVRzcU4xalg3V1BHNmFpbkVjUUlibW9xOXRR?=
 =?utf-8?B?UW5YMnNNbkpCbE1WRzFKQlU0OWJtNHEyWmZjSHF1eUZIQmhuQTRPS2pzWmlk?=
 =?utf-8?B?U0NPU2hoTWJabHRaQWwwalJjZXJoWGMySEh4QjJJaUk4L1N1V0ljSXdtUXYv?=
 =?utf-8?B?WTBLRVBYeVVTMnRoK0p1OFd5NEF1Y2xSM0F4eW1ENU5jbFFPTHMzQldOTml5?=
 =?utf-8?B?SE51ZU5PV2JvVFhXVldwdzJaVVBZOGwyd3VRQXRCSVE2QkdYYzQ5SmtVZlJr?=
 =?utf-8?B?NSt2QkM4b3lvMURxdjdFcjdmSVZON2pqeWVPT1BSb1FOSC9ITmFVYVl3RHZu?=
 =?utf-8?B?NHlIYXoyL084TFdxOHlTS1ZZTTJqbU5XZUZJeUJoNlZaZjNSYzFVdEhGeENY?=
 =?utf-8?B?d05uR2N4bFFvb3EwSjdSQ2ZTaUkwVlZzbnFJcENFSm5laU5jVzJDMTE0Qm1Q?=
 =?utf-8?B?RlN3UFBTS1VUbGN1RWc0TUNzcUhvQXV0YTRVclIvWld5NEF4SFhhSzJQS0RR?=
 =?utf-8?B?a291eC9QekU5akw2ZSs1dWNGNDRVSUQ4aUpiMktvT3VhYmhBczZFVGdDdDBw?=
 =?utf-8?B?WFoybUQ3NE9wTDlxb3h0R1dBT3g5bWpOTEc0YUhtenZNcGNPc2NLOUdnOU03?=
 =?utf-8?B?SjFJWGJrT1VUTnlBZ0hqUHlBRlV1dHZKNWg4dUJna05WZEZSZXFicFMrUGJS?=
 =?utf-8?Q?ecysIAEq/HnNAjglHM1L6172PMwZyzUWmCulSq9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGdrQWtoVEZXdklUbnE2OXk3WjBvamhPbE81NzV2QVRiUHUrcVJ6TmNnQlBO?=
 =?utf-8?B?ekhoY29HbkNHV3VhUXJub0o3cUp2d3ZhN25XN3JQQnBXSENjK2xES05FL01B?=
 =?utf-8?B?b3k5ZUxHWTRmME02TFBxVTRZTUtEZDE2akhzUUs5dkNDSUNCT3dMOFJVcndD?=
 =?utf-8?B?YWp6cWNFbUpkNWg0cTJMTEdNWG1oSHZyV0NOenlLcEo1U0JpWDJUSlJyOEdv?=
 =?utf-8?B?ZzRhOFdieFNlbWxzcUF0SE9OUzVXSkpkUXlpdTNuaG1lRTQ5R1J5RkF5YzNV?=
 =?utf-8?B?dUpzanlSV0IwS2I4VDRTdGRDZVFSWVVldjRuNUs5a21QZC9KSGV1ZXRSciti?=
 =?utf-8?B?K014VUFoS3BnMkVVZ1BWYlZkNGdyNDdvditTN0VXSks5MlhId1ppUHE4YWNR?=
 =?utf-8?B?S0RIcmlDZnA3Y2FIUTJYbk9zWlczdjBtbVBRRFpCRW5qRU5RbGN6THZuYnlY?=
 =?utf-8?B?RXJRMEZtSHBtL25KakhmQnM2aTVON0NNYmFMNjhPUlZYNVp1V3pzQjFUT1hk?=
 =?utf-8?B?ajBDeEdRTkx6b2FxTkRMTURTMFdsdEY3Sm5uekxJQ1owRVI2cmFuTXBRSkNn?=
 =?utf-8?B?OHhNcEQ4Wis3cHYxWW9SV3pXeWQ3aGc1NUdwVTFCd3ZNYW9pSklHWkRzYWs3?=
 =?utf-8?B?NDZaRFFWd0czWFU3VnRxb1BmR25rR0pMMDQrZ0hhYmppWWJBcTRmYWRyYzdF?=
 =?utf-8?B?M3gxQjZzckdadXd0SFZWUUlRWFdQVWRmT3JwcjMyUllDQTVqcUo2Mm9JaGNC?=
 =?utf-8?B?MXRuSnJZajJUKzNUckFJaXo3em9IRTJtODF3NXhqRS92ZlhlTlUvRWs4N0Mw?=
 =?utf-8?B?dW5FRmNtRDFoUS9YNks5SlQ3ckZPZGo2TFFqaE15ckR5dWtYdGxxV1pTbTlV?=
 =?utf-8?B?bUc4NW5lUG43eENVUlVYZ2lJVzZtT2JwL0grM013MHE2RjdITDNPWlZqZDBR?=
 =?utf-8?B?NzNTblRBL2h3ZmZvb3JUOFN2d29KM1FacFJ0cU5UTS9ISDRTcDZibE5EQU85?=
 =?utf-8?B?YkZsOS93SjNwdzdUM0Jxd0R5RnlPNmxNVlFIUWZpaE1mSGo1engvQWZPN21t?=
 =?utf-8?B?TVNNaEQ4Z2xNejZLQmZvaU8xS3NIMHVQWHpuTWZYNzhTczd4cTJMQ0Y0anhT?=
 =?utf-8?B?Q2R3ZEJsWThDZWZNMUVBeXVITHRkVXoyYnEvZmcrREk0N0VycXAxb2szeWN3?=
 =?utf-8?B?MytxZUtwNjYzMFNaWkt6bHlMQ3hQd2xPZklvY2JFT3RJekMrL3YydGh1aEF3?=
 =?utf-8?B?TkFpaVcvNnlMN0ppQUU4MzZXb0dYR2FaUnB0WTJUU0xrQ1RaRHMvUHdvbkdm?=
 =?utf-8?B?MU4rVzRpNkpPM3B0anBha1htSnNvSGxPazFzeW5ncG52SGhYc1pJWThiV3RW?=
 =?utf-8?B?UWE2OGxlZWl4bEJtOFRSZGFJQnJJU2V2MnZGNFczZm9zQWlkbnFEcURHTjIw?=
 =?utf-8?B?RmVWRWtiUytLbUx2aDcwVm56ZUdGSGpuSlFSVWhYL0tKUzNFMGM4NSsxbkln?=
 =?utf-8?B?aXh2OEgybVJHYXo0V3JBWHVkNDMwRCtObWQ4TDd4VmxjbXdSWlpqaWlEWHUr?=
 =?utf-8?B?TG9KNnZXVzhIVnNIS0VhY0pack5vd2U3eENIUUxKM0xxdXRtcmdsR2pvbU01?=
 =?utf-8?B?cDZSN3BCMTFkVTc1UEY0ZWdVRU1DQVlmQmoya3lic29ITmx3SVVEVWZvNGFI?=
 =?utf-8?B?YWx3SXd1ZWNpcnorWkZwY0d1ZGpaVElmVjdkeUo5T1p6bzVQcEFSZG85eTk4?=
 =?utf-8?B?ZSt4N3ZOVUxTVjRFUURWVXlnQVcwbFB4UFQ1dEtDMkw2anhONkxDYjZoM21X?=
 =?utf-8?B?Z21uWHZjbERYWXhyVWU5bmoyV0xRa016QmFpeFhVdUZUYUowYWNrRFBoNUNw?=
 =?utf-8?B?OWNMU3NKRkE3UE9SUjhuL1RQQUttenE3N2YrQ3l0ZS9aNHVRcWRQLzFUcDJB?=
 =?utf-8?B?eXB3OVRjbTVYM3M5WDluaDdyamV3dDk1NmFyd1FyaTRoWDltVmJ0ckFYaTVT?=
 =?utf-8?B?N3Z0RTRtTmVaSFFsTEx4dDlWd0JEYjgyUE1kczc3QnZFbGVvay9nV0tuM2x4?=
 =?utf-8?B?MTM5NktlUTdGYlFib2FiN3Zzc3kzZEhDbGdScno0ZHF6dG1CV1ZvSEFVS0xq?=
 =?utf-8?Q?ygvQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4053f0-a27f-4762-2b5c-08dc8c1a3f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2024 02:32:34.0319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqauytC/3OAyNsHV6D5OpCIFVnzSd9dRiKSbElSzhROe01VMvZCFW8SNqSsL2se9sdsoJ1EHK9QYGE0jeB+ahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFy
aW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAxNCwg
MjAyNCAxOjU1IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgU2hl
bm95LCBHYXV0aGFtIFJhbmphbA0KPiA8Z2F1dGhhbS5zaGVub3lAYW1kLmNvbT47IFBldGtvdiwg
Qm9yaXNsYXYgPEJvcmlzbGF2LlBldGtvdkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2Nr
aUBpbnRlbC5jb207IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1l
ci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVu
ZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxMSA1LzldIGNwdWZyZXE6IGFtZC1wc3RhdGU6IGltcGxlbWVudCBjcGJfYm9vc3QN
Cj4gc3lzZnMgZW50cnkgZm9yIGJvb3N0IGNvbnRyb2wNCj4NCj4gT24gNi8xMy8yMDI0IDAyOjI1
LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IEZyb206IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1k
LmNvbT4NCj4gPg0KPiA+IFdpdGggdGhpcyBuZXcgc3lzZnMgZW50cnkgYGNwYl9ib29zdGBjcmVh
dGVkLCB1c2VyIGNhbiBjaGFuZ2UgQ1BVDQo+ID4gYm9vc3Qgc3RhdGUgZHluYW1pY2FsbHkgdW5k
ZXIgYGFjdGl2ZWAsIGBndWlkZWRgIGFuZCBgcGFzc2l2ZWAgbW9kZXMuDQo+ID4gQW5kIHRoZSBo
aWdoZXN0IHBlcmYgYW5kIGZyZXF1ZW5jeSB3aWxsIGFsc28gYmUgdXBkYXRlZCBhcyB0aGUgYm9v
c3QNCj4gPiBzdGF0ZSBjaGFuZ2luZy4NCj4gPg0KPiA+IDApOiBjaGVjayBjdXJyZW50IGJvb3N0
IHN0YXRlDQo+ID4gY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jv
b3N0DQo+ID4NCj4gPiAxKTogZGlzYWJsZSBDUFUgYm9vc3QNCj4gPiBzdWRvIGJhc2ggLWMgImVj
aG8gMCA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+
DQo+ID4gMik6IGVuYWJsZSBDUFUgYm9vc3QNCj4gPiBzdWRvIGJhc2ggLWMgImVjaG8gMSA+IC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZF9wc3RhdGUvY3BiX2Jvb3N0Ig0KPiA+DQo+ID4gTGlu
azogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc5MzENCj4g
PiBMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNzYx
OA0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLXV0LmMgfCAgIDIgKy0NCj4g
PiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgICAgfCAxMTcNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmgg
ICAgfCAgIDEgKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS11dC5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS11dC5jIGluZGV4IGZj
Mjc1ZDQxZDUxZS4uYjUyOGYxOThmNGMzDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUtdXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLXV0LmMNCj4gPiBAQCAtMjI3LDcgKzIyNyw3IEBAIHN0YXRpYyB2b2lkIGFtZF9wc3RhdGVf
dXRfY2hlY2tfZnJlcSh1MzIgaW5kZXgpDQo+ID4gICAgICAgICAgICAgICAgICAgICBnb3RvIHNr
aXBfdGVzdDsNCj4gPiAgICAgICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgICAgICBpZiAoY3B1
ZGF0YS0+Ym9vc3Rfc3VwcG9ydGVkKSB7DQo+ID4gKyAgICAgICAgICAgaWYgKGFtZF9wc3RhdGVf
Z2xvYmFsX3BhcmFtcy5jcGJfYm9vc3QpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgIGlmICgo
cG9saWN5LT5tYXggPT0gY3B1ZGF0YS0+bWF4X2ZyZXEpIHx8DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHBvbGljeS0+bWF4ID09IGNwdWRhdGEtDQo+ID5ub21pbmFs
X2ZyZXEpKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRfcHN0YXRlX3V0X2Nh
c2VzW2luZGV4XS5yZXN1bHQgPQ0KPiBBTURfUFNUQVRFX1VUX1JFU1VMVF9QQVNTOw0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2Nw
dWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IDlmNDI1MjQwNzRhOS4uZmU3YzlkMzU2MmM1IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2
ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTEwNCw2ICsxMDQsNyBAQCBzdGF0aWMg
Ym9vbCBhbWRfcHN0YXRlX3ByZWZjb3JlID0gdHJ1ZTsNCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgcXVp
cmtfZW50cnkgKnF1aXJrczsNCj4gPiAgIHN0cnVjdCBhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXMg
YW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zOw0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwoYW1kX3Bz
dGF0ZV9nbG9iYWxfcGFyYW1zKTsNCj4gPiArc3RhdGljIGludCBhbWRfcHN0YXRlX2NwdV9ib29z
dChpbnQgY3B1LCBib29sIHN0YXRlKTsNCj4gPg0KPiA+ICAgLyoNCj4gPiAgICAqIEFNRCBFbmVy
Z3kgUHJlZmVyZW5jZSBQZXJmb3JtYW5jZSAoRVBQKSBAQCAtNzM4LDYgKzczOSw3IEBADQo+ID4g
c3RhdGljIGludCBhbWRfcHN0YXRlX2Jvb3N0X3NldChzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRh
dGEpDQo+ID4gICAgIGlmIChhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXMuY3BiX3N1cHBvcnRlZCkg
ew0KPiA+ICAgICAgICAgICAgIGN1cnJlbnRfcHN0YXRlX2RyaXZlci0+Ym9vc3RfZW5hYmxlZCA9
IHRydWU7DQo+ID4gICAgICAgICAgICAgV1JJVEVfT05DRShjcHVkYXRhLT5ib29zdF9zdXBwb3J0
ZWQsIHRydWUpOw0KPiA+ICsgICAgICAgICAgIFdSSVRFX09OQ0UoY3B1ZGF0YS0+Ym9vc3Rfc3Rh
dGUsIHRydWUpOw0KPiA+ICAgICB9DQo+ID4NCj4gPiAgICAgYW1kX3BzdGF0ZV9nbG9iYWxfcGFy
YW1zLmNwYl9ib29zdCA9DQo+ID4gYW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zLmNwYl9zdXBwb3J0
ZWQ7DQo+ID4gQEAgLTc0NSw2ICs3NDcsNyBAQCBzdGF0aWMgaW50IGFtZF9wc3RhdGVfYm9vc3Rf
c2V0KHN0cnVjdA0KPiBhbWRfY3B1ZGF0YQ0KPiA+ICpjcHVkYXRhKQ0KPiA+DQo+ID4gICBleGl0
X2VycjoNCj4gPiAgICAgV1JJVEVfT05DRShjcHVkYXRhLT5ib29zdF9zdXBwb3J0ZWQsIGZhbHNl
KTsNCj4gPiArICAgV1JJVEVfT05DRShjcHVkYXRhLT5ib29zdF9zdGF0ZSwgZmFsc2UpOw0KPiA+
ICAgICBjdXJyZW50X3BzdGF0ZV9kcml2ZXItPmJvb3N0X2VuYWJsZWQgPSBmYWxzZTsNCj4gPiAg
ICAgYW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zLmNwYl9ib29zdCA9IGZhbHNlOw0KPiA+ICAgICBy
ZXR1cm4gcmV0Ow0KPiA+IEBAIC0xMzQ4LDYgKzEzNTEsMTE2IEBAIHN0YXRpYyBzc2l6ZV90IHBy
ZWZjb3JlX3Nob3coc3RydWN0IGRldmljZQ0KPiAqZGV2LA0KPiA+ICAgICByZXR1cm4gc3lzZnNf
ZW1pdChidWYsICIlc1xuIiwNCj4gc3RyX2VuYWJsZWRfZGlzYWJsZWQoYW1kX3BzdGF0ZV9wcmVm
Y29yZSkpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgYW1kX3BzdGF0ZV9jcHVfYm9v
c3RfdXBkYXRlKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LA0KPiA+ICtib29sIG9uKSB7
DQo+ID4gKyAgIHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSA9IHBvbGljeS0+ZHJpdmVyX2Rh
dGE7DQo+ID4gKyAgIHN0cnVjdCBjcHBjX3BlcmZfY3RybHMgcGVyZl9jdHJsczsNCj4gPiArICAg
dTMyIGhpZ2hlc3RfcGVyZiwgbm9taW5hbF9wZXJmLCBub21pbmFsX2ZyZXEsIG1heF9mcmVxOw0K
PiA+ICsgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgaWYgKCFwb2xpY3kpIHsNCj4gPiArICAg
ICAgICAgICBwcl9lcnIoInBvbGljeSBpcyBudWxsXG4iKTsNCj4gPiArICAgICAgICAgICByZXR1
cm4gLUVOT0RBVEE7DQo+ID4gKyAgIH0NCj4NCj4gVGhpcyBpcyBkZWFkIGNvZGUgdGhhdCBjYW4n
dCBwb3NzaWJseSBiZSBoaXQsIGJlY2F1c2UgdGhlcmUgd291bGQgYmUgYSBOVUxMDQo+IHBvaW50
ZXIgZGVyZWZlcmVuY2UgYWJvdmUgZm9yIHRoaXMgbGluZToNCj4NCj4gICAgICAgc3RydWN0IGFt
ZF9jcHVkYXRhICpjcHVkYXRhID0gcG9saWN5LT5kcml2ZXJfZGF0YTsNCj4NCj4gRnVydGhlcm1v
cmUsIHRoZSBjYWxsZXIgZm9yIHRoaXMgZnVuY3Rpb24sIGFtZF9wc3RhdGVfY3B1X2Jvb3N0KCkg
aGFzIHRoZQ0KPiBzYW1lIGNoZWNrIGFscmVhZHkuDQo+DQo+IFNvIGRyb3AgdGhlIGNoZWNrIGhl
cmUuDQoNCldpbGwgaW1wcm92ZSB0aGUgY2hlY2tpbmcgY29kZSBpbiB2MTIuDQpUaGFua3MgZm9y
IHRoZSBmZWVkYmFjay4NCg0KPg0KPiA+ICsNCj4gPiArICAgaGlnaGVzdF9wZXJmID0gUkVBRF9P
TkNFKGNwdWRhdGEtPmhpZ2hlc3RfcGVyZik7DQo+ID4gKyAgIG5vbWluYWxfcGVyZiA9IFJFQURf
T05DRShjcHVkYXRhLT5ub21pbmFsX3BlcmYpOw0KPiA+ICsgICBub21pbmFsX2ZyZXEgPSBSRUFE
X09OQ0UoY3B1ZGF0YS0+bm9taW5hbF9mcmVxKTsNCj4gPiArICAgbWF4X2ZyZXEgPSBSRUFEX09O
Q0UoY3B1ZGF0YS0+bWF4X2ZyZXEpOw0KPiA+ICsNCj4gPiArICAgaWYgKGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9DUFBDKSkgew0KPiA+ICsgICAgICAgICAgIHU2NCB2YWx1ZSA9IFJFQURfT05D
RShjcHVkYXRhLT5jcHBjX3JlcV9jYWNoZWQpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICB2YWx1
ZSAmPSB+R0VOTUFTS19VTEwoNywgMCk7DQo+ID4gKyAgICAgICAgICAgdmFsdWUgfD0gb24gPyBo
aWdoZXN0X3BlcmYgOiBub21pbmFsX3BlcmY7DQo+ID4gKyAgICAgICAgICAgV1JJVEVfT05DRShj
cHVkYXRhLT5jcHBjX3JlcV9jYWNoZWQsIHZhbHVlKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
d3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19SRVEsIHZhbHVlKTsNCj4g
PiArICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICBwZXJmX2N0cmxzLm1heF9wZXJmID0gb24g
PyBoaWdoZXN0X3BlcmYgOiBub21pbmFsX3BlcmY7DQo+ID4gKyAgICAgICAgICAgcmV0ID0gY3Bw
Y19zZXRfZXBwX3BlcmYoY3B1ZGF0YS0+Y3B1LCAmcGVyZl9jdHJscywgMSk7DQo+ID4gKyAgICAg
ICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgY3B1ZnJlcV9jcHVfcmVs
ZWFzZShwb2xpY3kpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoImZhaWxlZCB0
byBzZXQgZW5lcmd5IHBlcmYgdmFsdWUgKCVkKVxuIiwNCj4gcmV0KTsNCj4gPiArICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgICAgfQ0KPiA+ICsgICB9DQo+ID4g
Kw0KPiA+ICsgICBpZiAob24pDQo+ID4gKyAgICAgICAgICAgcG9saWN5LT5jcHVpbmZvLm1heF9m
cmVxID0gbWF4X2ZyZXE7DQo+ID4gKyAgIGVsc2UNCj4gPiArICAgICAgICAgICBwb2xpY3ktPmNw
dWluZm8ubWF4X2ZyZXEgPSBub21pbmFsX2ZyZXEgKiAxMDAwOw0KPiA+ICsNCj4gPiArICAgcG9s
aWN5LT5tYXggPSBwb2xpY3ktPmNwdWluZm8ubWF4X2ZyZXE7DQo+ID4gKw0KPiA+ICsgICBpZiAo
Y3BwY19zdGF0ZSA9PSBBTURfUFNUQVRFX1BBU1NJVkUpIHsNCj4gPiArICAgICAgICAgICByZXQg
PSBmcmVxX3Fvc191cGRhdGVfcmVxdWVzdCgmY3B1ZGF0YS0+cmVxWzFdLCBwb2xpY3ktDQo+ID5j
cHVpbmZvLm1heF9mcmVxKTsNCj4gPiArICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gPiArICAg
ICAgICAgICAgICAgICAgIHByX2RlYnVnKCJGYWlsZWQgdG8gdXBkYXRlIGZyZXEgY29uc3RyYWlu
dDoNCj4gQ1BVJWRcbiIsIGNwdWRhdGEtPmNwdSk7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAg
IHJldHVybiByZXQgPCAwID8gcmV0IDogMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBhbWRfcHN0YXRlX2NwdV9ib29zdChpbnQgY3B1LCBib29sIHN0YXRlKSB7DQo+ID4gKyAgIGlu
dCByZXQ7DQo+ID4gKyAgIHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5ID0gY3B1ZnJlcV9j
cHVfZ2V0KGNwdSk7DQo+ID4gKyAgIHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSA9IHBvbGlj
eS0+ZHJpdmVyX2RhdGE7DQo+ID4gKw0KPiA+ICsgICBpZiAoIXBvbGljeSkgew0KPiA+ICsgICAg
ICAgICAgIHByX2VycigicG9saWN5IGlzIE5VTExcbiIpOw0KPiA+ICsgICAgICAgICAgIHJldCA9
IC1FTk9EQVRBOw0KPiA+ICsgICAgICAgICAgIGdvdG8gZXJyX2V4aXQ7DQo+ID4gKyAgIH0NCj4g
PiArDQo+ID4gKyAgIHJldCA9IGFtZF9wc3RhdGVfY3B1X2Jvb3N0X3VwZGF0ZShwb2xpY3ksIHN0
YXRlKTsNCj4gPiArICAgcmVmcmVzaF9mcmVxdWVuY3lfbGltaXRzKHBvbGljeSk7DQo+ID4gKyAg
IFdSSVRFX09OQ0UoY3B1ZGF0YS0+Ym9vc3Rfc3RhdGUsIHN0YXRlKTsNCj4gPiArICAgcG9saWN5
LT5ib29zdF9lbmFibGVkID0gc3RhdGU7DQo+ID4gKw0KPiA+ICtlcnJfZXhpdDoNCj4gPiArICAg
Y3B1ZnJlcV9jcHVfcHV0KHBvbGljeSk7DQo+ID4gKyAgIHJldHVybiByZXQgPCAwID8gcmV0IDog
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHNzaXplX3QgY3BiX2Jvb3N0X3Nob3coc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1Zikgew0KPiA+ICsgICByZXR1cm4gc3lzZnNfZW1p
dChidWYsICIldVxuIiwNCj4gYW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zLmNwYl9ib29zdCk7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IGNwYl9ib29zdF9zdG9yZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlDQo+ICpiLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KSB7DQo+ID4gKyAg
IGJvb2wgbmV3X3N0YXRlOw0KPiA+ICsgICBzc2l6ZV90IHJldDsNCj4gPiArICAgaW50IGNwdTsN
Cj4gPiArDQo+ID4gKyAgIGlmICghYW1kX3BzdGF0ZV9nbG9iYWxfcGFyYW1zLmNwYl9zdXBwb3J0
ZWQpIHsNCj4gPiArICAgICAgICAgICBwcl9lcnIoIkJvb3N0IG1vZGUgaXMgbm90IHN1cHBvcnRl
ZCBieSB0aGlzIHByb2Nlc3NvciBvcg0KPiBTQklPU1xuIik7DQo+ID4gKyAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+ID4gKyAgIH0NCj4gPiArDQo+ID4gKyAgIHJldCA9IGtzdHJ0b2Jvb2wo
YnVmLCAmbmV3X3N0YXRlKTsNCj4gPiArICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArICAgbXV0ZXhfbG9jaygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9j
ayk7DQo+ID4gKyAgIGZvcl9lYWNoX3ByZXNlbnRfY3B1KGNwdSkgew0KPiA+ICsgICAgICAgICAg
IHJldCA9IGFtZF9wc3RhdGVfY3B1X2Jvb3N0KGNwdSwgbmV3X3N0YXRlKTsNCj4gPiArICAgICAg
ICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgcHJfd2FybigiZmFp
bGVkIHRvIHVwZGF0ZSBjcHUgYm9vc3QgZm9yIENQVSVkDQo+ICglemQpXG4iLCBjcHUsIHJldCk7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9leGl0Ow0KPiA+ICsgICAgICAgICAg
IH0NCj4gPiArICAgfQ0KPiA+ICsgICBhbWRfcHN0YXRlX2dsb2JhbF9wYXJhbXMuY3BiX2Jvb3N0
ID0gISFuZXdfc3RhdGU7DQo+ID4gKw0KPiA+ICtlcnJfZXhpdDoNCj4gPiArICAgbXV0ZXhfdW5s
b2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArICAgcmV0dXJuIHJldCA8IDAgPyBy
ZXQgOiBjb3VudDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFt
ZF9wc3RhdGVfbWF4X2ZyZXEpOw0KPiA+ICAgY3B1ZnJlcV9mcmVxX2F0dHJfcm8oYW1kX3BzdGF0
ZV9sb3dlc3Rfbm9ubGluZWFyX2ZyZXEpOw0KPiA+DQo+ID4gQEAgLTEzNTgsNiArMTQ3MSw3IEBA
DQo+IGNwdWZyZXFfZnJlcV9hdHRyX3J3KGVuZXJneV9wZXJmb3JtYW5jZV9wcmVmZXJlbmNlKTsN
Cj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGVuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVf
cHJlZmVyZW5jZXMpOw0KPiA+ICAgc3RhdGljIERFVklDRV9BVFRSX1JXKHN0YXR1cyk7DQo+ID4g
ICBzdGF0aWMgREVWSUNFX0FUVFJfUk8ocHJlZmNvcmUpOw0KPiA+ICtzdGF0aWMgREVWSUNFX0FU
VFJfUlcoY3BiX2Jvb3N0KTsNCj4gPg0KPiA+ICAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFt
ZF9wc3RhdGVfYXR0cltdID0gew0KPiA+ICAgICAmYW1kX3BzdGF0ZV9tYXhfZnJlcSwNCj4gPiBA
QCAtMTM4Miw2ICsxNDk2LDcgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3RhdGVf
ZXBwX2F0dHJbXSA9IHsNCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwc3RhdGVfZ2xv
YmFsX2F0dHJpYnV0ZXNbXSA9IHsNCj4gPiAgICAgJmRldl9hdHRyX3N0YXR1cy5hdHRyLA0KPiA+
ICAgICAmZGV2X2F0dHJfcHJlZmNvcmUuYXR0ciwNCj4gPiArICAgJmRldl9hdHRyX2NwYl9ib29z
dC5hdHRyLA0KPiA+ICAgICBOVUxMDQo+ID4gICB9Ow0KPiA+DQo+ID4gQEAgLTE0MjAsNyArMTUz
NSw3IEBAIHN0YXRpYyBpbnQgYW1kX3BzdGF0ZV9pbml0X2Jvb3N0KHN0cnVjdA0KPiBjcHVmcmVx
X3BvbGljeSAqcG9saWN5KQ0KPiA+ICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ID4NCj4gPiAtICAgcG9saWN5LT5ib29zdF9lbmFibGVkID0gUkVBRF9PTkNFKGNw
dWRhdGEtPmJvb3N0X3N1cHBvcnRlZCk7DQo+ID4gKyAgIHBvbGljeS0+Ym9vc3RfZW5hYmxlZCA9
IFJFQURfT05DRShjcHVkYXRhLT5ib29zdF9zdGF0ZSk7DQo+ID4NCj4gPiAgICAgcmV0dXJuIDA7
DQo+ID4gICB9DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmgN
Cj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmggaW5kZXggMGI3NWE2MjY3ZmNhLi45
ZWJhODU0YWI3ZDMNCj4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3Rh
dGUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmgNCj4gPiBAQCAtOTks
NiArOTksNyBAQCBzdHJ1Y3QgYW1kX2NwdWRhdGEgew0KPiA+ICAgICB1MzIgICAgIHBvbGljeTsN
Cj4gPiAgICAgdTY0ICAgICBjcHBjX2NhcDFfY2FjaGVkOw0KPiA+ICAgICBib29sICAgIHN1c3Bl
bmRlZDsNCj4gPiArICAgYm9vbCAgICBib29zdF9zdGF0ZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAg
IC8qKg0KDQo=

