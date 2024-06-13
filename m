Return-Path: <linux-pm+bounces-9047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CFF90643F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED061F25481
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0B13776C;
	Thu, 13 Jun 2024 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qyMj4Nuy"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8B13698D;
	Thu, 13 Jun 2024 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260807; cv=fail; b=BNANpCmwhlE8JtGq/C900hQdZxDpIWrkDqRG7Wh+66or5oDC1GpV6ABRyaLylBwlQwqK7XqGdeTMSFpBlhM2A3PZuEWNeudsB9Ol6e1AJoNXoyavXjIXMI2UUaNow/3V3SAEB3faLGR5zgUnCd8F8jF9qXGvaw4hYwIwTfypWEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260807; c=relaxed/simple;
	bh=HhURp30FXA8tHyoSw+u2GmJrLNUS3WH7OfBieXxyrOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PhnHPRBlnwai7Q/ada3Ny53q6HYmKOfhbM9QqnPznQg6o2NA7iMER1cjk390PKZSOoXRgCvz5e9qNb6InQCL5+uTrMi1CLBT455PSCEWN7y9JhwWyB4TjmAPPCTQr550OVgDHNmQ/bxLnL0fZZ0q02z+ViwXrWjQc9djz37m/Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qyMj4Nuy; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nimQl0XoxVFekDNXhEAxX5jT803SyQdrlQ1S4X3ntkKPJKm6KnHAMNoIOs2MtTF1hqZM9ARf0adf4C6vxZ6FShu1l8V/VvYjy7PZo29CZHUoqSdkheIexIUMHm25o46bVB1kZyIrMXPHz3dajX8tBpPxqXozICxoxjV6Uu9Fmzlypdhsv8VD2F4aKHlH0zWedMzlHahrBcKmUFbI701v62pVEKOWvCFDEHa/yC23wu4/kJ+0OUOgPw4twZqP+4wtrR0RwsNb+EAZzzQe6WFFm0ztAzQ5s0bOqtjWC8LTMnsZtIFo2gZZ8VeSCP2LvvjJMqSQBL7x+E8OppGedN/w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+8V938IAtMeNqTq1/iIHSmATccvzkRqewCBReLfqYE=;
 b=MK5YvEQNcfw7GP5tOksezSDIQWFKrc3fVUEXWznlfjwJkGHQafwSXNZmLi0lNLymSLJiz55PD5QyqGFdPVViv11gsd2WxK7ftJ/IMOyC0LL9vBjXop67rtbCRRXmY+NuUURj1QRYFwlb1/wuCeGeWxpI+iBELdpanji+InfVTCHGWzoTkF1vincbhiTBs1mBeU+zXbWHZn6B2pQ1j/uJ+GEoriEWKvQFNZnapaUBMYQ5i9GNK0H88UMeN/CXWSIU08eOdR8SgE9nHgZeDGc6nVIckNouA8oQ1VWuLcKmQFrWGVSIEUdXirkYKpF8QKDWyfmKsgKjq1oN5sGxBqJi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+8V938IAtMeNqTq1/iIHSmATccvzkRqewCBReLfqYE=;
 b=qyMj4Nuy8RcK4+bGMIphKenC8UY1agy78yLUL+oKjPmarxfTVWq/tvFSW4b4swCaQAAkk9r67qvgdoVXsxUhLnX1EFRh8FpbBCaGQL+TJxs+ExeaUbzvO4s+w2iDqnm/rR963l6P51Is03utTu/INxTGZ82U11fSUL47U55rqKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by BY5PR12MB4131.namprd12.prod.outlook.com (2603:10b6:a03:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 06:40:02 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%6]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 06:40:01 +0000
Message-ID: <f98c662d-9270-4974-a12b-60ea995d0aa6@amd.com>
Date: Thu, 13 Jun 2024 12:09:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] perf/x86/rapl: Add per-core energy counter support
 for AMD CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "kees@kernel.org" <kees@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20240610100751.4855-1-Dhananjay.Ugwekar@amd.com>
 <20240610100751.4855-7-Dhananjay.Ugwekar@amd.com>
 <d7f1d65c7e8872dee2a97ee47be191496d048d1d.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <d7f1d65c7e8872dee2a97ee47be191496d048d1d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::8)
 To LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|BY5PR12MB4131:EE_
X-MS-Office365-Filtering-Correlation-Id: 585d2030-eed6-440f-0132-08dc8b73a694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|366010|7416008|921014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzAzcGU5ZDJ5V2FML085K2l0WlZRV3RSMklRblEwVm53NTF1ejhkeDZKejQ3?=
 =?utf-8?B?RFpmN2NzOTV2WWx4alUwZlBSVTNVVTlMYmdqYk1LV1lzcGdyUXVsalZTbFJP?=
 =?utf-8?B?RkhYSWxScm1GQSthYjZGZ1JLeWhKZGpOT0EyNTl1cUlic25RQm9jS0lMNGha?=
 =?utf-8?B?ZWM4dm9XZjZxQWdrK3dRQXYwMCtwak5meC9vQ1Vmb1RTY1JEdU9MeDh4d0Mw?=
 =?utf-8?B?STltN2w0VjZBOUt3N2x6aW1Mc043amZlRWdJZVpQMXNGaWkra1d4MjJtU3I0?=
 =?utf-8?B?WWFIVGxnY2htOXNGdWZDTmNyZHNHTmhTWXZySWZlODJERTAybS9zWElSbDB4?=
 =?utf-8?B?TnB1NEU2Z3NtWXlOSXlZUElaVzZaQ1ZEZUZKZm9vY3NBeUpRS1ZHSzRwcGJ5?=
 =?utf-8?B?QVIvUE9WR3FmMXhERURFMDlyQklxZ0hoUUVIKzNzbVlqcmJ3UE9wcTRJaDNH?=
 =?utf-8?B?SjljVG1OeE5zUkRwV0xJVWJVQ2RObVNLby9kMFZIa3k0R1IvUmZiWDBuNStM?=
 =?utf-8?B?UXZtOGlXK1dZK2JpL2pSbHJ3TVJXTFJPVllqb2pVWitBczZOTWRia3YybmdY?=
 =?utf-8?B?bUljTTNOWDhmYUcvNjB4MW0zdVdsQmdFWEtUSUVxeVdzTGo3MDkvNVh2bGVo?=
 =?utf-8?B?ai9ZTWZubW1XVG1RUGhoSWE3S3cvQWxiRFpwZU00SnNGeThIVmY2WTdnTXNo?=
 =?utf-8?B?alRDbFNuUkxhT1BodHJxamFJdG85Nk1YRE1zTzg4VkkyZnVZZ2FvSGp3Rmpv?=
 =?utf-8?B?Y3daQXY5V0ZkQVZEbngvTmlUcmdXREhtZnFtcE5xMVN5SUVhb3lKNTZtVHR3?=
 =?utf-8?B?Mk5Na21PN1I4Q1ViYU5NNXNtTWoxbjFLSnNLMlU5U3QwMXlBTjJTd2p2eXRa?=
 =?utf-8?B?WVJKa1diQjVOdW9Md2Y0V3hyTVRLR3V3YjI4Zitqa0t3blhtNCs5ZXUvT0ZQ?=
 =?utf-8?B?VDhXZ1c4TXI2U0NvYk9MVUhXNU1ZdTNIL2tJRHZsTUdSeEVid2FpWS9QRkdv?=
 =?utf-8?B?b0Z1SHZJZXBIRUNTZXIzUmhZUURybXNxSjRHZUxHK3pHdmJqY0tLVXZsSmFk?=
 =?utf-8?B?MG9Ic015aVlMR3hzeTlLVkxCZUpSU01xZ1FXbjlVNnJLYUNHVlNUd0txdzlY?=
 =?utf-8?B?Q0NtdjFReVZlUXp6amdoZ2o5M1pFTXJqc0doSTh3dTYwMzVuS04xdXl4WFk2?=
 =?utf-8?B?RTN0RHdtdVd2YXp5cG5sQThGSitQWXNzWEdUNXV6YTRqbGV1Z2drWEM0VDFF?=
 =?utf-8?B?Z1pYN2dLQXdzMXhjbHRPV05vOGQ5ZVB1akYwaHVrZk82d0lZMWxPZG01cWtp?=
 =?utf-8?B?M0FzajFLSVBQam9NaFloajFMdUkvZDg5K2hBemJTcEQ4cjdKUm9hRWlkaEF4?=
 =?utf-8?B?QnV5OTY2MDNNbnV4aFhuZHpOWlE2ekIzMXNHMmlNSk1IYW5vZGMrLzRWc3Bz?=
 =?utf-8?B?eVNSWHU3R3M2K2FQTmUxMVRDeVpaY28rYWxtd2xTRmdSTjc1WFdWWW1ZRHYz?=
 =?utf-8?B?dHpaYjFyMFhQMHNVdDhrVlRFd01MYko2OERodTdQZHQ2cUdNQkY4V0x4UHp6?=
 =?utf-8?B?L2hEQUVkcndRUlU4SDVFVkhYUjlZK2tBbHdhK3BBdkJJT09IM3J0MnE2d2x2?=
 =?utf-8?B?eVlqOWxyc05iYzkyLzdpYjhrVzU2Z0FJU3d1dE00Y0RZL3grNDlkM1k1R2k1?=
 =?utf-8?B?UVBMaWFjT3UvTVpJcHVrdEZudkI3MVlKQ1QrRFBrdG1yUll1d05QcVRUZXUx?=
 =?utf-8?B?aGlVeXo5USt2OW1MYUxGTlltMWxKV3JuZ1Q3QU1zUzZEMjF3R29RWitYb2N5?=
 =?utf-8?Q?dG5qI69jFUQy6nm7F93CUY+2vN6M92UOYmYt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(921014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VqZVZ1UzB5MmxqNGNmbTFpMSs0cU5DU1JJcEliRGZwNDd5LzBIdm1NeDg5?=
 =?utf-8?B?MmNVNjBoRHNTSDA3Y3hYSERVS0w0UHBvcDBnYnZOQldLZlRCWmxNajdVQ1Z2?=
 =?utf-8?B?K0FLczdlb0FTRTdlWno2bDR1Sk55dFlTV0ZLS0VKd0lKS2tFWmtybUdaUXhI?=
 =?utf-8?B?RmF5OXd5ejJrZ3NZMzZlMEdGbTJCaDFBM2l1ZzZRNEF2cUtNMkFJN2VjVGEr?=
 =?utf-8?B?ZlB4QUVzbHlhelByVWplTWJqNkJmU2tmRi80eGJRaXlkMFd4eDN6ZDJGQlRy?=
 =?utf-8?B?MXNGbzBqRkpWcVM0TGlQWGJRVnRQT0pVWUFRYzVRc0d4bDZ2cFZkblJibFRO?=
 =?utf-8?B?WFQybC8xOFNHTnRINUJ1SXpIaGwreUU2M0VXM0FGcGFNaXVUVjY1VjlseERO?=
 =?utf-8?B?MjRxUHduRERsWHpqQ3RDZ2xsUzJML0FVR0taOGwvcjNTR1puSkZSVUtGK2M2?=
 =?utf-8?B?Y1VzUHJaZ0F2V0haR1hKc0VRWm9RQzBzaFM5bEgzL1VOcUppVGdmZ1BoalZ2?=
 =?utf-8?B?SVZMd29UTnRQbGVkL2pjWjd5djZPYmVHVmVNRDVjRDJONlNxYklmajRLOFND?=
 =?utf-8?B?akNLVTRpRWFBRDB6MU5uSmhQVWdBNE05YVRPVDB5TmJtT1JyZ0lNM1h5ZXhI?=
 =?utf-8?B?NjhrV1NrQjdXWDVvYm52ME1yRzZWdkVxczMxeWhPTWdWQ3FtK3VuWjVJRDk2?=
 =?utf-8?B?VEVhRjU4WUw3Wi8yWFBjSjRiT2s4dVVJSEJFaXpXWnFHK0VjRjdCT1pnWW5Z?=
 =?utf-8?B?dURHNlRyR2pEVVMvY2Y0ZVJWM3ZkdE1CK1Q2M0I4MzA5cXM1cEJBdGNIbWJy?=
 =?utf-8?B?OTMySFZaZkJzNXVZNVg3bEI0M3dFaStKQmxoRkNxQ2JIMlV5cVd0ZGZIZlcy?=
 =?utf-8?B?TUJ6Z2FGOUVIOEZ1Y1VmZGFDck9qSXVVMkZvRXpuZ3hyZU10QmhtRVNZbnhu?=
 =?utf-8?B?cWw0RHArY2hiajhUdnRnVkNQaHRUTGp1RXNEQlBSWEpFRHZyNW5jMnJEcHFm?=
 =?utf-8?B?OGcvVHBCZkwzZmVDdFdGMGY4VXEwcld0eXNydjZKNGpFbkl3eVI0a0JKVDRR?=
 =?utf-8?B?eUoyeXdJRDUwT1BWUE80RkVVNDBvdWVtQXZlMmQxeGlFYTBBZDNsR0R5QlVP?=
 =?utf-8?B?OUVXTncxdXhlMDJJYXZkaWlUeklxbDFkK1J5M0p5cEJhZXp2Rk5LTlJ1Z2lu?=
 =?utf-8?B?N3M0T0JPMVBZN1JQUk9oNzNWa0NBN1VDM2NWcWFXTERIOVlyRnpvRGoveVRZ?=
 =?utf-8?B?SDZNU25waGpENUNMTE84SWtQNElXdE51MnFRUks3STZVdnR6Y2JGa292Uzht?=
 =?utf-8?B?SUsvd1F3NVUzMkhZeGM5dkZ6bEtxZG1oTEhmOS9Qblp0MGFmbC9rSFVEWWpU?=
 =?utf-8?B?YitYSEszUi9kWE5GMzBQbUJqN1JTc1NWZFRMcXFiZWxyWC83Z0tEYkNIQ3Ra?=
 =?utf-8?B?VE5OemFVbkNrNmpYVWM3c1MyNjdsNVQrZ01oSlNiSTNRbmhsVmFTTzV1cEJX?=
 =?utf-8?B?cEI5Y0wrRm1lOXZqQThxazFrVXpHd2lMN1NXMTBlMmNiclhzVkR0L2ZnNGYv?=
 =?utf-8?B?V2tIQmpiVk8ySCtRa3I2V1lMVmxBWlJxVE9YUWliMTZLTjRhRitnSW80dlVJ?=
 =?utf-8?B?VDR1UVJBNkVLbm5SK21oN0s1UkJZUm1CMmRZSG1qb3J4Y3RBbmY1S1B5NVhK?=
 =?utf-8?B?YmM4Yll2RkpUU0trVTEyTUpHK3Q3bVRsNnRQNlJ3Q1FwYXVCMURhZDV6YW9N?=
 =?utf-8?B?SWV2MytrT1l4NCtrMktJd0lha1B3dFQyNnZFSzhiKzVKUzJQcGlOamJucWhn?=
 =?utf-8?B?em1KTVluRHJYZkNFUTB5MU05ZEtiaUpqYTlGcEFGNGFIR1VWRDVhTXpaN2JX?=
 =?utf-8?B?V09KaTd3RXV0T3FCaytMSGV1TWE3Z3pjK2QrTHVEUnR1ZWd1TjFRcE5mT2ls?=
 =?utf-8?B?VDdmdGszRGN1TW8rd0ppa3krQzJINWpicXBVcmhaU3VIcFlQNW1WRTJyd2xR?=
 =?utf-8?B?L3JJdkNTSUt3ZlBqNXlFdnJ1Nm52V2toZUlXZmRIeHZTMGIyTVdYbmFRUW1k?=
 =?utf-8?B?M1k1V1RFMzFRYnFKdm5rcWtlQldDSVp3OC9QcEFqRDdPSlNwVEJhWjA4eTBN?=
 =?utf-8?Q?YsdjfX9QBTPsFBkG5Ng2d+Rgy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585d2030-eed6-440f-0132-08dc8b73a694
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 06:40:01.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oQgPxNVtQHnXxd2OR5qRD1d2gIOCVXjow9mz4VGct8crLM3lXsynulvQfMzWtGSOw3Jh091a+nlNOVHCuaIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4131

Hi Rui,

On 6/11/2024 2:00 PM, Zhang, Rui wrote:
>> @@ -345,9 +353,14 @@ static int rapl_pmu_event_init(struct perf_event
>> *event)
>>         u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>         int bit, ret = 0;
>>         struct rapl_pmu *rapl_pmu;
>> +       struct rapl_pmus *curr_rapl_pmus;
>>  
>>         /* only look at RAPL events */
>> -       if (event->attr.type != rapl_pmus->pmu.type)
>> +       if (event->attr.type == rapl_pmus->pmu.type)
>> +               curr_rapl_pmus = rapl_pmus;
>> +       else if (rapl_pmus_per_core && event->attr.type ==
>> rapl_pmus_per_core->pmu.type)
>> +               curr_rapl_pmus = rapl_pmus_per_core;
>> +       else
>>                 return -ENOENT;
> 
> can we use container_of(event->pmu, struct rapl_pmus, pmu)?

Yes! that would be cleaner, will add it in next version.

> 
>>  
>>         /* check only supported bits are set */
>> @@ -374,9 +387,14 @@ static int rapl_pmu_event_init(struct perf_event
>> *event)
>>                 return -EINVAL;
>>  
>>         /* must be done before validate_group */
>> -       rapl_pmu = cpu_to_rapl_pmu(event->cpu);
>> +       if (curr_rapl_pmus == rapl_pmus_per_core)
>> +               rapl_pmu = curr_rapl_pmus-
>>> rapl_pmu[topology_core_id(event->cpu)];
>> +       else
>> +               rapl_pmu = curr_rapl_pmus-
>>> rapl_pmu[get_rapl_pmu_idx(event->cpu)];
>> +
>>         if (!rapl_pmu)
>>                 return -EINVAL;
> 
> Current code has PERF_EV_CAP_READ_ACTIVE_PKG flag set.
> Can you help me understand why it does not affect the new per-core pmu?

Good question, I went back and looked thru the code, it turns out that we 
are not going thru the code path that checks this flag and decides whether 
to run on the local cpu(cpu on which perf is running) or the event->cpu.

So, having or not having this flag doesnt make a difference here, I did a 
small experiment for this. 

On a single package system, any core should be able to read the energy-pkg 
RAPL MSR and return the value, so there would be no need for a smp call to 
the event->cpu, but if we look thru the ftrace below we can see that only 
core 0 executes the pmu event even though we launched the perf stat for 
core 1.

--------------------------------------------------------------------------

root@shatadru:/sys/kernel/tracing# perf stat -C 1 -e power/energy-pkg/ -- dd if=/dev/zero of=/dev/null bs=1M count=100000
100000+0 records in
100000+0 records out
104857600000 bytes (105 GB, 98 GiB) copied, 2.03295 s, 51.6 GB/s

 Performance counter stats for 'CPU(s) 1':

            231.59 Joules power/energy-pkg/

       2.033916467 seconds time elapsed

root@shatadru:/sys/kernel/tracing# echo 0 > tracing_on
root@shatadru:/sys/kernel/tracing# cat trace
# tracer: function
#
# entries-in-buffer/entries-written: 12/12   #P:192
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            perf-3309    [096] ...1.  3422.558183: rapl_get_attr_cpumask <-dev_attr_show
            perf-3309    [001] ...1.  3422.559436: rapl_pmu_event_init <-perf_try_init_event
            perf-3309    [001] ...1.  3422.559441: rapl_pmu_event_init <-perf_try_init_event
            perf-3309    [001] ...1.  3422.559449: rapl_pmu_event_init <-perf_try_init_event
            perf-3309    [001] ...1.  3422.559537: smp_call_function_single <-event_function_call	<-- smp call to the event owner cpu(i.e. CPU0)
          <idle>-0       [000] d.h3.  3422.559544: rapl_pmu_event_add <-event_sched_in			<-- CPU# column changed to 0
          <idle>-0       [000] d.h4.  3422.559545: __rapl_pmu_event_start <-rapl_pmu_event_add
            perf-3309    [001] ...1.  3424.593398: smp_call_function_single <-event_function_call	<-- smp call to the event owner cpu(i.e. CPU0)
          <idle>-0       [000] d.h3.  3424.593403: rapl_pmu_event_del <-event_sched_out			<-- CPU# column changed to 0
          <idle>-0       [000] d.h3.  3424.593403: rapl_pmu_event_stop <-rapl_pmu_event_del
          <idle>-0       [000] d.h4.  3424.593404: rapl_event_update.isra.0 <-rapl_pmu_event_stop
            perf-3309    [001] ...1.  3424.593514: smp_call_function_single <-event_function_call

--------------------------------------------------------------------------

So, as we always use the event->cpu to run the event, the per-core PMU
is not being affected by this flag.

Anyway in next version, I will only selectively enable this flag for 
package scope events. But we will need to look into fixing this 
ineffective flag. 

> 
>> +
>>         event->cpu = rapl_pmu->cpu;
>>         event->pmu_private = rapl_pmu;
>>         event->hw.event_base = rapl_msrs[bit].msr;
>> @@ -408,17 +426,38 @@ static struct attribute_group
>> rapl_pmu_attr_group = {
>>         .attrs = rapl_pmu_attrs,
>>  };
>>  
>> +static ssize_t rapl_get_attr_per_core_cpumask(struct device *dev,
>> +                                            struct device_attribute
>> *attr, char *buf)
>> +{
>> +       return cpumap_print_to_pagebuf(true, buf,
>> &rapl_pmus_per_core->cpumask);
>> +}
>> +
>> +static struct device_attribute dev_attr_per_core_cpumask =
>> __ATTR(cpumask, 0444,
>> +                                                               
>> rapl_get_attr_per_core_cpumask,
>> +                                                               
>> NULL);
> 
> DEVICE_ATTR

I was not able to use DEVICE_ATTR, because there is already a "device_attribute dev_attr_cpumask_name" 
created for package PMU cpumask using DEVICE_ATTR(). 
So I had to create a "device_attribute dev_attr_per_core_cpumask" manually 
to avoid variable name clash.

> 
>> +
>> +static struct attribute *rapl_pmu_per_core_attrs[] = {
>> +       &dev_attr_per_core_cpumask.attr,
>> +       NULL,
>> +};
>> +
>> +static struct attribute_group rapl_pmu_per_core_attr_group = {
>> +       .attrs = rapl_pmu_per_core_attrs,
>> +};
>> +
>>  RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
>>  RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>>  RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
>>  RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
>>  RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
>> +RAPL_EVENT_ATTR_STR(energy-per-core,   rapl_per_core, "event=0x06");
> 
> energy-per-core is for a separate pmu, so the event id does not need to
> be 6. The same applies to PERF_RAPL_PERCORE.

Correct, will fix in next version.

> 
>>  
>>  static struct rapl_model model_amd_hygon = {
>> -       .events         = BIT(PERF_RAPL_PKG),
>> +       .events         = BIT(PERF_RAPL_PKG) |
>> +                         BIT(PERF_RAPL_PERCORE),
>>         .msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>>         .rapl_msrs      = amd_rapl_msrs,
>> +       .per_core = true,
>>  };
> 
> can we use bit PERF_RAPL_PERCORE to check per_core pmu suppot?

Makes sense, will modify.

> 
> Just FYI, arch/x86/events/intel/cstate.c handles package/module/core
> scope cstate pmus. It uses a different approach in the probing part,
> which IMO is clearer.

Yes, I went thru it, I see that separate variables are being used to 
mark the valid events for package and core scope and a wrapper fn around 
perf_msr_probe is created, will see if that will make sense here as well.

Thanks for the review,
Dhananjay

> 
> thanks,
> rui
> 

