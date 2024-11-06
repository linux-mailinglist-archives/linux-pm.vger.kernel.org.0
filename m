Return-Path: <linux-pm+bounces-17046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7ED9BDDF9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 05:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D328DB219EA
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 04:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912C176FA4;
	Wed,  6 Nov 2024 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G/kjhi89"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C276035;
	Wed,  6 Nov 2024 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867647; cv=fail; b=YNzNXACzri7hikMYZOljKQGZiV0bcVkP/2jJSRzt+ZXCJMaVk079mOnQr7nKKQBci6OHzH6OOYdVHLpB2b15rfH9jWQ310/mvxYcHjgLpdm6n1lHE5Dt9AN9gMG/lS08UDGeo3dLDeMWs0y3fkJHUrOTEtx0kHm33NAcqfF1CD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867647; c=relaxed/simple;
	bh=tMFZ0e8NUcK8gmlcf1E21ay+ozi7C640z59cymXuX88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsVRpABbQi1Z2dpIMjY4y0dw/QMBJL+usIJlENfbJeqyZXRdR8gaJtJMEw0lEC/KLRUO/nkc2l07tmIqNZ/28lfcJ6I+iZ+yDaXnasVrmYxG/QcpQtAmeJo3OA1OAszmaq5hoJIJytjiR8rYafNsl6APGo1vCFXEKiNIGv9f4+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G/kjhi89; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucazfGw59Rg8FcWpoUf0KQ8l+o8Ya442a5ffPRNEL+GyqAqW1f5pW7JW2HhE6QdT2XSXueTNVr7Pe4v79lQGIdYVUp/Tvo/wfKMNROpD4MXyv8Un5acawS0fHQw6XSHhxmnqSONmP4oC5SlucexJy5HtqSskLRD9oY3hIevhWNTicTh4ZtT3u4C/oB9S75G19TIhmmUScr5Bhak9Mp+/Q6usQUHjP7MPUIYK3J7cy27NYShVYLsQOoLqaWLbWAlJvGRBTiFVJfUrFDoRhCNaqAKbbUB536qQ1rcgHJy6m63Ep2WogZpDLI0DPRtF95d9UHhN3ctKc/SNUjebe7UnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STKmnU2um3xkrTKGLKLxfclKIKOyQ/FIzvmf3HYdLC0=;
 b=EzsAKe9PA0UFIzq2IUjTl/iOJuWPWd3qK414PVKRM7Oq0FVe+S93/kuX2xupRg7RV8m03wmJ+XRNwnpVKlu62IU3fXxUTtKkLxAlNeMr48GorqJOz50L85K85bGJLiEShYRDxnM4Okus/X+TjcgM+Z+5U7gib7pKCAwyLTuZHdSOsDESLhdXalzac3p+Nckvjue7fDMyHnMZsAcApHwYsBPmU3933YoXtH/sbRzFxFcjakrVG0CK11G0Vm51StSOoG7hrbIH0Ttc/uYkVqgpAaMCbrRaxsGTLUaSNHeYnUX+vJ5vaalJTk+inI6GSXzRFlNjLBddbA+e8IVhfICpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STKmnU2um3xkrTKGLKLxfclKIKOyQ/FIzvmf3HYdLC0=;
 b=G/kjhi895CwemRF6ZaTDBgpHjnMu9F4K0h492+SxKoBa1QTG/BjGc/lxFsFrjiBMM+TuREWlKzDrsuGp2IyyylKZQDft4MQ6uvI/i2q32ElL7oiA2FHcWJ0cKXvrztQmLHgelvxvof+osOJeQRP4Ojks1gCNkdCMhVqZtXtcUTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 04:34:02 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 04:34:02 +0000
Message-ID: <8361ae12-60d1-42a1-ba90-c3b31c8a6e6f@amd.com>
Date: Wed, 6 Nov 2024 10:03:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/12] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241104175407.19546-1-mario.limonciello@amd.com>
 <20241104175407.19546-5-mario.limonciello@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241104175407.19546-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::15) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: ea982386-d95d-4186-0e32-08dcfe1c3d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djhhelc5ak5hNEQ1RTFrVWEwTWF1TzdqU2U0Z3JQUXdJeXowM0xHRUM4VU05?=
 =?utf-8?B?Mi9CVk5VbHVrcUNyWm5ndnF1S2VHNjZTVzkzUFRiWDk1TkFZZnQ0cUdYZWxD?=
 =?utf-8?B?QmpHeFRoMFBIVHJSVGRWT2JzSExUMkxNZ0Rxck1GQmx4QURZaHlTRGZibVMw?=
 =?utf-8?B?Qi92bUdMckJBOVVTOEZIcVA3Ump3VXhHMFcyQk8wVnBzOS9YdXk2QXBlQTlw?=
 =?utf-8?B?Y0diWkY5NHBiRys4UFRtcis0K2xwTVJ3VS85bmc1djE1UUF3enhhRzZTYW5L?=
 =?utf-8?B?UmUwTnBQZHpDRGJiVFhUelExT0p6Q3FibVZ0MkZGNzBIZmxBeHltSU5tODk0?=
 =?utf-8?B?RS8zTGZNZXk5Z0R1T0FyMk9URnBOOFFJZUloSm9QNXFwSVBnU0RwQytsbFZq?=
 =?utf-8?B?RVNBdWI1K0d3S3gzakVZaGMxaGJubWpTMGxnN0RkWVJQV3VTZmhJaFNBNlp3?=
 =?utf-8?B?WG5GK1g4MXBOVTZCcVExNXpIbEQvSzhrVGV1K2Jhb0dZdU9weitmQWZwRW9F?=
 =?utf-8?B?a3JpUkQ4alptbC91VEhzMUJZZVAxVDFVWk9XaGMvSEprQ3pIL0dRRUxUYzdG?=
 =?utf-8?B?ZnBqZTVJcVRFeHNuYm55WS9UMW5kQndlNjNHZkFrYUgraDF5YXlBUDdlS1dC?=
 =?utf-8?B?Z21TSWFNL0JPdHFnV2Z1bnZPS3ZsY3Rnak9aLzkyblEyQVd0VHExOGlSbTdR?=
 =?utf-8?B?MWVxUjdtbTgxSHJIdkNQNnFzTlFteDl0Mit6TXMxRHBMaU12VmFZdEZRK21C?=
 =?utf-8?B?M3NUT0dKaWllQ0hPelRWN0xKbm5lWndmTS94S3ZlYWtSYWVUcExna1cvSUNr?=
 =?utf-8?B?WVNZUk15YXc5a3VBbTJIOTMxQlFMY1haS0Jud1l5YzRrTEoxQkNuWGEyeW1U?=
 =?utf-8?B?Z1dHR295NDdoZTlReTMvdGVhSlNnMTVjNTRVTFBUYVR1WWVNcjN4d3EySjlY?=
 =?utf-8?B?QVl4dFJVTUI2dWdUUTVLUFByZ0tnRG44ek1nWEZPV2c4SnN1NGhPT2lzU0Fj?=
 =?utf-8?B?bXhJcXdFWGVWc1pGeCs0S3BrZTJtVFpvS1ZJdFZQdU40SkdRMVV5cnJrbVRI?=
 =?utf-8?B?M3ViS0ZDcWoxUHoxUTdybjRjblBRZW5kZ2R1cmVjc1NFTTNrTndibXBZVVli?=
 =?utf-8?B?eGxJQmIwaEdvQVNXOWkrWXhSYUxJWTRUZTdHWFc5Zm16MWZnTmhPS3JjdXhB?=
 =?utf-8?B?QUFPWGtSZjVvckZpSDU5UWhJclJSNkhZVldDZmY3UzVmeC9pOGpRY1k4UG9w?=
 =?utf-8?B?bGNLZ25MY0hyaXd6RHc1MHpXcFFsRGUwazcvdElrTytNSE9pQ0UxV0VaY3Fw?=
 =?utf-8?B?NytCcDgyNll4djJ2cjYyVndkVG1MZXgyRCswMWV3VElydWltV28zVlM0WDI2?=
 =?utf-8?B?TExsMVFSeHh5V2Q5bUc0OWhqNWJQd040MXBmU3hYcEtLOEpzeEpLM3NnZmNw?=
 =?utf-8?B?MEoreGJXZXZWUHpWWmxReVoyMzJLTFUzYW9ueUl1MStnRDYwZ0tIaGNmUkN5?=
 =?utf-8?B?d2Vic0tHVXkwaTFjTWtCamVBaFJKUDBtNkpPcGFyTzBYOVZWUUc2dEhwd2t6?=
 =?utf-8?B?YWoySEtYUzZkQ2pNQWFyQTlpeDdBNmQ1ZktmVzFvNzJybitOMUlWSitjTXll?=
 =?utf-8?B?bnZaU1NqZ1JJNUZqYmRmRjJhM3hOL1VHY2Eyc0NNbnh0R1JOZFR4VVoreTN4?=
 =?utf-8?B?UENacWxyYkhJeG5vTUU0RWhJRHBPUlZmbmVqQ0pnNDQ5OGpjODN6N2I4MURv?=
 =?utf-8?Q?Feph4LJTxOjP7jWCWI4d5lDAG6HPEwEr6cKOt45?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXF1NVowZVgrdkNSYWgwZ1ZSOHB3dzdkYjhXdTh2YWkvOFJTVzBIZ1dNYjBL?=
 =?utf-8?B?RVJRcVRwUnhWTW1vQnV3NWpiTkhjekVtS0EzdFc4WVJLdlNFTW55OC91aTF0?=
 =?utf-8?B?VlZDQ1JDamppaWhsSDAxMUtldmhXdmpCNVVXdlRXMGE2S0pweGVrS1hrNERL?=
 =?utf-8?B?NUZJVmxEbWdiaUJ4cnY5S1FCQ0pwZ1V6akdwZHFEbHNOenA1NXh6aVJWV2Rh?=
 =?utf-8?B?eWkxbXd6ZUdFZkh4Q3haQ0FEUHhCdS9haHR5WW1WTmlsZzluWk1iS1FlQUNN?=
 =?utf-8?B?aElWeWRvblRCdWJWOWJWWWwzY1Era0lzclI5V2FHVzNxNGlxSFRnZ2E0MHBj?=
 =?utf-8?B?NlliTjhtZlpUb1ZCalV5S0dhMmxUa280cGF1SlBwSEtaNTFMbitiV2IrN1Jh?=
 =?utf-8?B?TFoyblRZTHdzSnYwZUxzME9zR1ZPUk40Z3VaMWFMZFgrSy9UZ0pHQllQTXpt?=
 =?utf-8?B?UU0vUHZIRVV2SzRGQVR2d29lMS96b3VXcVZBTjdiOFhqSWhIUkY2ZUR6VGc2?=
 =?utf-8?B?RnZ0WUlZZEJqdWtTaXFTL1Z2V2RXMGdoUWhkdENtZEV0bE5qMFpIMHdiaXhy?=
 =?utf-8?B?ODRpR3B3MFZpQW11K3FGZ3hQSzk2OTB3cE5JVDU1dS9EWFZMNTRoRVFGSlNl?=
 =?utf-8?B?eGhyU3JBaFRmYy9SK2E4NGd6cSs2MGdlM3FwM1VHblZDbkpQWEh1QXVpUEVh?=
 =?utf-8?B?bXFPNGI0YWFmbUVjM045ZTRtOVNaSHdBaDJoYmZyclpBM29MazgzVjE3SVBL?=
 =?utf-8?B?ZHlyMDZ1VldPREVoREpJZllMbzdQNHRxRjlGUEpydFAzUzJMTno2VURORmty?=
 =?utf-8?B?K05pSjdtL2tralhNTElCdWJtMkZBYzlXMTdWcHBtR2dMdktGMVUvc256emlr?=
 =?utf-8?B?WHlTTm1kQlcrZTlDMFczVXdEaVJ2VEVDZmt4dUlGL3RLWmtNY3pra09GMEdO?=
 =?utf-8?B?NVRWVDVtUm1neWpxdk5qREg1YlBWcjJXbldUZFdDRDBTSm1TdDQvUnMvNzlj?=
 =?utf-8?B?dCtCNzRmdncwK1B2YlhXOEIrZ2RSeTZ0M3lZaDVjVDhYdVh6Y295bmZYWVdt?=
 =?utf-8?B?YzFVQ3Azb3JDQnVFNDlNeG9LdDM0MDMzRHh3MzhaT3NJelh4cE9iT1FqUTBR?=
 =?utf-8?B?Qlk3azRhdDgwa0M5ekZ3a3NmbVZxalpJZEdRTjFWUm0rUmV6MWdkOTRWeFZ1?=
 =?utf-8?B?N016NUdlNUdCRmhhMHFNZTg0N0xabDlKZENvYjhOYm5YeURTZG1DNEc1VUJt?=
 =?utf-8?B?YUlBT2lzS2J0aVBNZjlwQVM3YXp5YzNSK2RNOUhSNWN6cG5ZMTEwbG5jOTdi?=
 =?utf-8?B?czY0TTRXZUpueXhjcytYV2E5SDFNV0lrRThRM29HNVBTSHFRc2pYaGtXUHV0?=
 =?utf-8?B?MzNIK2FrcVdOdmNQV01sSGZ3aUI1bVBQUEJOTThtSkE2RU9JTXFJSnQ1bHhB?=
 =?utf-8?B?YU55cGdnaWR2NXgwcXN5azdpNWxKUGxHRVVSanE3ck4zVGRGbVlGZmJKTUZW?=
 =?utf-8?B?OE9wdVZBQnRZSVh5WEdNdWdkVjZuY3lXaE1LY0ZzZWljdHNtbnJSckJwY3pa?=
 =?utf-8?B?SXg4M1pka04wME5abStURDdEeUNJQzBOSVRCc2htNG4xaU5PZUYweUF3VjZu?=
 =?utf-8?B?dlNLdHowb210T09UYi9kcHF4cklEWDUvbWxscktwSTVsZ2JocGdRT2pqZmtw?=
 =?utf-8?B?RitDemROOEFIR0xiSkQxcFJXS2ZaMGlXZ2RKSlpVUmllV1JXMEJpV2REY3p2?=
 =?utf-8?B?WHA2eVk5VitxTTh5MzhFMnlYUEN4ZWVjTTJBQ2FpOVVxelJyV0J4UVBBVnRu?=
 =?utf-8?B?RTdJWmMra3diRWtMYmxiRkF3ZkV3eW5uaCs5SEJQS2tiTzFRRElJNTJFb2tt?=
 =?utf-8?B?bHhLRUFSQ0pRSG9pUVBHdlVKc3IvUDB3K2tiTWhVdGh1V3pjRTBveXpIUkdZ?=
 =?utf-8?B?cU1HaGpXNlBaL09KcGtrNWoxbWJZRFh4OCtTU3hVZHU0ekJHUjVxeVJSOFg2?=
 =?utf-8?B?S1ArV0dCa1g1OGRNRGFrUEk5VmswbkFwVFZPYVpvY3RDaVBINFdMRXJVRlJ3?=
 =?utf-8?B?bEtFbWJLdTBUb3NuQmVFYlpBbEd6UjVkNXliNnY0MS83bjNHbk00NWhseGxD?=
 =?utf-8?Q?YG2ejr5ZC4QBZ9mLPRTFA89or?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea982386-d95d-4186-0e32-08dcfe1c3d13
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 04:34:02.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJwLG6EAc6oPi9hHn/UM++mW68vNPRAzFz04lxosGiDRo6mfxGz6xRyg0xmt0TVtt8OCBrbyWJmUKX7aRXHxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273



On 11/4/2024 23:23, Mario Limonciello wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the PMFW via a shared memory ranking
> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5->v6:
>  * Whitespace (Shyam)
>  * Use managed mutex (Shyam)
>  * Remove needless include (Shyam)
>  * Commit message text (Shyam)
>  * Use cpu_feature_enabled (Boris)
>  * Remove EOF newline (Boris)
> ---
>  drivers/platform/x86/amd/Kconfig      |   1 +
>  drivers/platform/x86/amd/Makefile     |   1 +
>  drivers/platform/x86/amd/hfi/Kconfig  |  18 +++
>  drivers/platform/x86/amd/hfi/Makefile |   7 ++
>  drivers/platform/x86/amd/hfi/hfi.c    | 161 ++++++++++++++++++++++++++
>  5 files changed, 188 insertions(+)
>  create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>  create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>  create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index f88682d36447c..c3f69dbe3037d 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -5,6 +5,7 @@
>  
>  source "drivers/platform/x86/amd/pmf/Kconfig"
>  source "drivers/platform/x86/amd/pmc/Kconfig"
> +source "drivers/platform/x86/amd/hfi/Kconfig"
>  
>  config AMD_HSMP
>  	tristate "AMD HSMP Driver"
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index dcec0a46f8af1..2676fc81fee54 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>  obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>  obj-$(CONFIG_AMD_PMF)		+= pmf/
>  obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_HFI)		+= hfi/
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 0000000000000..79e3b0073275c
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
> +	 selected, hardware provides runtime thread classification guidance to the operating system
> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
> +	 These capabilities may vary due to the inherent differences in the core types and can
> +	 also change as a result of variations in the operating conditions of the system such
> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
> +	 resource allocation, leveraging the diverse set of cores available.
> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
> new file mode 100644
> index 0000000000000..672c6ac106e95
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
> +amd_hfi-objs := hfi.o
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> new file mode 100644
> index 0000000000000..2cd71d79a22c9
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Authors: Perry Yuan <Perry.Yuan@amd.com>
> + *          Mario Limonciello <mario.limonciello@amd.com>
> + */
> +
> +#define pr_fmt(fmt)  "amd-hfi: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +
> +#define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HETERO_CPUID_27	0x80000027
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;
> +};
> +
> +struct amd_hfi_classes {
> +	u32	perf;
> +	u32	eff;
> +};
> +
> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
> + * @class_index:	workload class ID index
> + * @nr_class:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;
> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_err(dev, "failed to get number of supported classes: %d\n",
> +			nr_class_id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_present_cpu(idx) {
> +		struct amd_hfi_classes *classes;
> +
> +		classes = devm_kzalloc(dev,
> +				       nr_class_id * sizeof(struct amd_hfi_classes),
> +				       GFP_KERNEL);
> +		if (!classes)
> +			return -ENOMEM;
> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> +		hfi_cpuinfo->amd_hfi_classes = classes;
> +		hfi_cpuinfo->nr_class = nr_class_id;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id amd_hfi_platform_match[] = {
> +	{"AMDI0104", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> +
> +static int amd_hfi_probe(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *amd_hfi_data;
> +	int ret;
> +
> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
> +		return -ENODEV;
> +
> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
> +	if (!amd_hfi_data)
> +		return -ENOMEM;
> +
> +	amd_hfi_data->dev = &pdev->dev;
> +	ret = devm_mutex_init(&pdev->dev, &amd_hfi_data->lock);
> +	if (ret)
> +		return ret;
> +	platform_set_drvdata(pdev, amd_hfi_data);
> +
> +	ret = amd_hfi_alloc_class_data(pdev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +};
> +
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled ||
> +	    !cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
> +	    !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
> +		return -ENODEV;
> +
> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
> +	if (IS_ERR(device)) {
> +		pr_err("unable to register HFI platform device\n");
> +		return PTR_ERR(device);
> +	}
> +
> +	ret = platform_driver_register(&amd_hfi_driver);
> +	if (ret)
> +		pr_err("failed to register HFI driver\n");
> +
> +	return ret;
> +}
> +
> +static __exit void amd_hfi_exit(void)
> +{
> +	platform_device_unregister(device);
> +	platform_driver_unregister(&amd_hfi_driver);
> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");

