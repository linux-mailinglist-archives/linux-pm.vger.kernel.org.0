Return-Path: <linux-pm+bounces-24259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E03A67CC5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861371891C3C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Mar 2025 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992921481D;
	Tue, 18 Mar 2025 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CKn50lrZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4B21325A;
	Tue, 18 Mar 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324834; cv=fail; b=qvL7ItlRFZ0aUySTTvuuOgHyREN1TYTcubrwfXTucVuzslK4S8WkVvwUI3HPyzASVKRJ23olgJUxRrG4qhbImv/fUnJcNSmAD5wowm7fgaYLrJefqaOU1mfrJAMYP/vJdh4eSxlSs7CibZ6n4H0jPJsVjfQjfdGSYRAQP2/43oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324834; c=relaxed/simple;
	bh=sIxIBNQ+CdjN6smwGou3iAdMvFC/ihQ0vLCdWWL4J6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LimdLn1Fd5WRcdPk5D+WldMVTnvxzNwKMSAJmSvK+YLeDikQDBvQi5jCweGrxngAIEWDdzBSe4v5o/gBW3jkfwK0P8b21ro+jjKO11x/Hi7s7+aN4FVbihta4K7bnJbW3qPcVV9FMY3fPPcc/0CD+LHOltPGqRHTXIMOAaopEsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CKn50lrZ; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeirt4M91OLdLZGUuXrzduwf7MWuxv8mxvUg+bK1A0RZuJmI07+RGi+npA3BJGNuJAwX21AZ7YTA+6X+05rqqliqQPZfyMqH8sD06xC22V4IG/nh5eHlsoaS0qXutnR1nf+D2leVmoJA2MymTor81ZOUtYJb4ZWAhpzEB1PEdhi56Upq3N42XWo6w3ameZB5Fmg/p5vuw1/9sZd72U9sCJlPEc864Bl5UQ+tLd92HofVPt4+W4QCEPs/WFQnf8FyR6Y0MsQ0Obh4lNJQ9RGzmEhy0n+rJi1tD9rzMQrwZzLmS8Y/yquJaoNVvNYRk0pKzbOf633mknSZBhoGVZe2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWXQCY2Dunl8z+UNNMoTYb9/M6PzgpYVtPUPyMQ1jLE=;
 b=mvcJPz+mCqafrxJQ9Xc5+5dv82pieI/e+qf6gM7y2QSqHzEij/20nnv0XAnoDEZKU6sBCQO2KRwQ2+ANVJOOqfI4ez3ya4PcxBi+Im3/6d2RCS+6SFwnq/celZKUk0v92IN30hPKXQMvK/F59oohQyt4lk/MEpOgIsE2sNvdnE4MsH3iZN2BmFzAlNZ6z/f2pUDrqDGKX2Wy9GbquPqdV8qEstK/YwYoebossC9PatoClqJFBWmNbLaMtFjgh/8RdIegGsLI5mzeAG3n3MsomIK67DScFAbFaJ741Dkjbprtmhgb0ziL1AkjpNI/36R2JQhnbGC3gOr9m1mkpwR3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWXQCY2Dunl8z+UNNMoTYb9/M6PzgpYVtPUPyMQ1jLE=;
 b=CKn50lrZuLK50vS9Vh4UxJ01OgkvRY3PbJqKacFvusb1Rbo5SW8iiYakcHHBqGE4bHIh4hfjCyVHrXt++YPuQ283r9exskXGcNDNglusFgPcvmX4g3/yqZJyry82ZX+vJVKGU1rUdg5XRx80cXNtZUr0VayHVbbeHRyBLQm4OCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 19:07:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 19:07:03 +0000
Message-ID: <f9953826-1324-4df2-9252-b10d0c9e5679@amd.com>
Date: Tue, 18 Mar 2025 14:07:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] cpufreq/amd-pstate: Add support for platform
 profile class
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20250304152327.1561017-1-superm1@kernel.org>
 <20250304152327.1561017-4-superm1@kernel.org>
 <Z8sdREywSKVb4xx7@BLRRASHENOY1.amd.com>
 <969ca809-c630-46e3-9bc2-6cf340bc66e3@kernel.org>
 <f3849033-e883-4296-abb7-eb04e8c2a03c@amd.com>
 <Z85z8MN8ncr2ye4r@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z85z8MN8ncr2ye4r@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:806:22::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 76687a79-beff-4613-2349-08dd66501163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFVOYkVkTUJuMkNUT21oLzJKVk05eS9hMUdlc1I3b2V2NjYwSGsrR2dQTXJo?=
 =?utf-8?B?VlloOWtSSHhYT3h6bG5OZjJFZitDbXlzYWhSNjZnWlAyWGxxUVJqQWFlNkQ3?=
 =?utf-8?B?R090WnoxR2h5Z3VxNWFSRjVpaDZtZWh5eU5JWDRNTmZ4RVB0YXQrZlJDSEk2?=
 =?utf-8?B?cHRRNWpNZnZMTzlEdFgzdmowT3NWUEthU0NtTWZRTStONTNweFFkUGg4NldI?=
 =?utf-8?B?MXU3WkhWY1MwdXBXcW4vSGJvMDdIUTkxUmdHYVJhdkFFaTdBdTNPT0g1Uml4?=
 =?utf-8?B?Z05hanNkNm1jTVpYNXBFMUlPQmlRK05abzQvci9QWmVWR1FkbTBrb00rTFg5?=
 =?utf-8?B?a1ZQVFkwZGd4bFMvYXRxeVZZak1UZUE0RmJIVmhCOGJMTFhSWjY3RHkrSmxM?=
 =?utf-8?B?Mk5hVytwdHhCYWRHaXQ5Z0dOaU5wL0FNVW1BemNsai85amhvbElFOE9NaEJv?=
 =?utf-8?B?VjMvVEhUSDQ2YkkxTXB2QjJxUFptYk1nQXpXSm5oMnRQV1FHYWh5TVVYRjZw?=
 =?utf-8?B?d0dRSGY1MCtvN0hJdC82akRUUFBTd0FJTlNkZDN4RVMrQVhVd1pRaTlhUjRk?=
 =?utf-8?B?ZFovaU9DczYwZWJxd0ZJY2xHTTJKMFk3ejhnM2h6NXBheGdGU1RhNmk4Snds?=
 =?utf-8?B?dDRnU2JPOEFVRitrMmlCWVBtcldDZkFSOXFEUzN2ZkdESEQ4cVhKRFVKNU41?=
 =?utf-8?B?c3EyYWlucDlLeUlTUThyd25VeENsKzFlemZzMXZPSzNyMkZ3bXRleGdJZE9P?=
 =?utf-8?B?eVJpRGFBNzZkRTdrTVErazl0NElWMVhpMzhxNDVjR1hRUlFnSjlpN3pDbVcx?=
 =?utf-8?B?UHdiZ2tLKzBYZWJ4OFpha0hPdXlEUUZBTVg2NFI0eTVuUHFJekpkWTN6KzJt?=
 =?utf-8?B?U1AzMlpyTlRNcklwK25hdmJiZG9OU05OUElkcVJRRm9KeFB1RjYwM2EvZUY0?=
 =?utf-8?B?LzFxTzJSRlBPQ1ZzS3ZHWkdyUDljU2NiWUp0K0ZWWlR2NDhzbStFcUttT1dz?=
 =?utf-8?B?TVNsYVMybjg1ak5UYno5dkdRdy9hdndCczJBT21oTzBqMG13eGNJem5LVHN1?=
 =?utf-8?B?Y3RhV2d2d1F2K1h1NTB6QUViNnRkaldaS1NBNm1GckJkeldGWjVFZkptbTIz?=
 =?utf-8?B?enhhZnVOYWZvRmtiNzN6eHdaZytWUmcrb3l4WHNHcUJSNDl3QlFpT1dPa0dk?=
 =?utf-8?B?YVlNUWlaUkVPcVhMMHVKMERhVnlpcHMyYW9wWVpYQitpZ1hoM2d2YkR2R3NO?=
 =?utf-8?B?WWRIWXRZb01oMFNTc25tVnRQZ1pFS2pNSGNCSHpHNnFycTJadklSN1JqVWhi?=
 =?utf-8?B?WEIrUkVzOFppdlFXcDRDdXNFT1lKejBXQjdiaUZnNi9aRXNCejR5VzlJVzdx?=
 =?utf-8?B?a3dqU2Z4TnJjSTlYNTVvNXoyaTVUQkhTNzZXd2JkSXF0RFcrY0V3cnVVdjAv?=
 =?utf-8?B?dzU0SWhBSThtZ1VWTVhJZ0RyT1FzWEZxL0VJTjAvM21md1JGTzZINC9iMk1n?=
 =?utf-8?B?YjVDQm5rQ21oYUFBYSt1dEVQQlVWdHRic1Q5Slh4UXN6dm5hYVJsOEIzT1dJ?=
 =?utf-8?B?VTV5bFpQREpCZmQ5aFNiNWNEanNqZEQyRXZqNDFDcDRkKzlWa094MVVEekht?=
 =?utf-8?B?VkpFdHc2cXk3WEZudVRieFQyUVZldENLT3pvZklTamR3OWFsSm1xWFpmRGVI?=
 =?utf-8?B?WU13TWJEemtJSnZQMVFXM0VxaXd5elArVklxOFZNSW9jeTZxbG92dDVRUENP?=
 =?utf-8?B?dndmdCt1clgzTDFGS1E2aTM3d0VsaU1RNkxvTTEvNWIyOHI0Q3Q5clJNUVk4?=
 =?utf-8?B?UVJuZ1ZVcXRCMHZ3Z1hSS09QaTlnNFdWajdITkJHc3BYNlBXKzRhVnR2d05Z?=
 =?utf-8?Q?pp0YbyvKit0z0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpRQy8wR2F1VzJLa1NLOVdBV1pMN1NMLzU4VGYwT0V0Nng4NkwvaEFEcGlq?=
 =?utf-8?B?aTRDcnRsM2pZdDY3eHFCTld4N1c2UXdEVjJFSS9kaUJ3SXF5UkZmYWN1YndH?=
 =?utf-8?B?TEVQQ25IS0hsa21VazBjSjY4aHUwYkx5d0NNT0RUUlM5RFh5QlRmVVBhbnMy?=
 =?utf-8?B?S1UyeDRheWhSUnB1MFRNeC96WGZrTHZ3QjZpcHFCT2x0SXBScnExbGdYU0cw?=
 =?utf-8?B?M2xsRmhFOSs5WHV2akxsY0JrSEd3VUIydTlkQnY3MTI0Y1Fjd1prSitlUlNo?=
 =?utf-8?B?ZGZHOUdwMWlCb0dHV0Q4TkM0YXBOS0M5QVRRb2xnUTRwckxtVkFkRE93Ly9L?=
 =?utf-8?B?VklxK3RGczc4eGZHcFFjNmRaeFIrOEtGOTFWdHZQaWhGYjFHUmpOSjRMeCth?=
 =?utf-8?B?MmhHcFpXSzZ1TnJWTGs2U21pNE9tTjZZQ1ppUHp3aEVhWER0aWU2NVlvdDRQ?=
 =?utf-8?B?QUFvOURvS3piaERQTFU5dndYM3UyS2hlQ002dW5EaW5yK2hBaWE0MElFSnZt?=
 =?utf-8?B?eDczLzI4Q2dHKzFBcXZ5TmVRT3ZqNndqc2FybmpTWTMzQ3dOZkJLMzQ0Q21x?=
 =?utf-8?B?MjlxVXhlWHM0cU1WeitGQitlSTVmK1dLWEpvbFovZDkwandSWVVlMjVNelU2?=
 =?utf-8?B?d0JMTFlsL2ZxMVlyOS9MUmgrWkl0SlkrQ0JOTTJaQmc0WmN0VHBlTzUvUEhs?=
 =?utf-8?B?UHNHeC9od0M3a3hKY003UXlWQTZhQytIUGlheThXTi8ydFo0ajBTcUNWdmdG?=
 =?utf-8?B?K1RvMjh0THhjeHdNTFVzUnpxeUU4ZlpkbXlTTHY4M2l1c3lEVk11cUJaUmc2?=
 =?utf-8?B?OUIxNHFqTTBLR0RXYXdmZkEwT05wazZxLzBkRE01aGpjbmFoRzl2VW9KMUMw?=
 =?utf-8?B?STVTK0RSNXNUbjk5bUtieUtHUkc4OVFvQUNqVlFEU2d3VHBWQ1lrdm44eFMx?=
 =?utf-8?B?WmtSM2xDTDBwMDlJQ3pUVlpHZVZhZk5mRUpHRy9VWjBsNlFaTHRFYUJFc2Ux?=
 =?utf-8?B?UVZCMlhDMkNzMGtuSmNtbWpkUEo2dXRqTDgyeWxwVndBU2hCSkRsM1NEellH?=
 =?utf-8?B?N2JjL3FoaGY3ZDh0Mzc4ZklTUEhSQytQeXVraEZPVG54WVU0b2ZFTVZoNS9F?=
 =?utf-8?B?eWN3VGo3alJIV2NVYzAzUkdGM0ZlODBtK2JxbE03d1lSSzdoZC9ldkt1TDVp?=
 =?utf-8?B?MXVBVU0zcmRXRHFES2l1c1JuSUFBZkxIVHEzdHNKdkVTc05BcnNiOWFuSWhi?=
 =?utf-8?B?dk5BdzhCK0dyTm9EYzJDenhjZHN0cndvUU0rK1BRZHRTK1habys0WHdLQjFR?=
 =?utf-8?B?TUJnMVlkYmZaN3VQT0NxRDJHQUg3dmlXaTd3dmtlY0ZVY3lOVkhFVjdORm41?=
 =?utf-8?B?UEhiN2h6Sno2WGJPZTZtYW1yU2lYcGxjejVHWVJZTzVLaUcrVVBTbE8rZ2F2?=
 =?utf-8?B?ajIyK1kzZ25XTUd4QkMzU1B2VGFwelJkSnNWbVljcjNMZVdDVEV6MDdjeWNN?=
 =?utf-8?B?bkJ0SkM0Z3NsVDR2MGFOL2NHK05DZ1NqMkdBL3A2cjcrODdZUm9pam9SUXc3?=
 =?utf-8?B?Wk8rRldGeWdZOUhUMGJta1diZCtGM1d2eTUyL1JlUmRxWUxNWlZJT1NtV05H?=
 =?utf-8?B?VS81RlNUK1dBbmgwOHZrYWZrNHNXVTRORHBrK01uZWs2UEt3NEZjaFNmOU0w?=
 =?utf-8?B?NEZqZnZyTko4NExnUjhESFNzMHVOejNGMU0vVFMrZ2dQdkphR2RwS2h0QVlp?=
 =?utf-8?B?V3dycU1ueG1veW9SRHVNa3RaWGk0TXBzTlMzU2VGZHdacXFHNGJTZEFGRWsy?=
 =?utf-8?B?UG91NFZCZVZIRnAvQi9ZNXBEOUpRTTZVR2Zxa0YwMTJ0NzQzRk1GMWYvU2JX?=
 =?utf-8?B?Yk1oTG9vTTJXakErRm41WUFsT2xDL3ZhaUkxRzI0cXc0WkllLzRzRS9xWDdn?=
 =?utf-8?B?a1pWQmRVeWlaY1BYYit3dlNwS2xQTnMxbFp2T0tXOTFFWVVSWWVnWXZQaGNB?=
 =?utf-8?B?N0tSWUR4UGdtR1ViVmtKVFZPRGZlRVZsNFlIL1B4NjlzYXMwYVp1V00wMTFK?=
 =?utf-8?B?YUxrU2FMV0JHYXJYdnNWTWxvUmM0SldCdnpQRlJuTUZZN3ozWXVZODl1Qk91?=
 =?utf-8?Q?5SUYdHelZtoT45usJHZF5u5Pe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76687a79-beff-4613-2349-08dd66501163
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:07:03.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KS9eMHaHMk7l3fnAskNdduRfDJAiL2d1CHMGdvuZUvxXBDeFHhLsLWmFI9tU2gXtnvCWSvUJLKb2Ok3RQqYnoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF

On 3/10/2025 00:09, Gautham R. Shenoy wrote:
> [...snip...]
> 
> On Fri, Mar 07, 2025 at 10:30:25PM -0600, Mario Limonciello wrote:
>> On 3/7/2025 10:55, Mario Limonciello wrote:
>>> On 3/7/2025 10:22, Gautham R. Shenoy wrote:
>>>>> +static int amd_pstate_profile_set(struct device *dev,
>>>>> +                  enum platform_profile_option profile)
>>>>> +{
>>>>> +    struct amd_cpudata *cpudata = dev_get_drvdata(dev);
>>>>> +    struct cpufreq_policy *policy __free(put_cpufreq_policy) =
>>>>> cpufreq_cpu_get(cpudata->cpu);
>>>>> +    int ret;
>>>>> +
>>>>> +    switch (profile) {
>>>>> +    case PLATFORM_PROFILE_LOW_POWER:
>>>>> +        if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
>>>>> +            cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
>>>>
>>>> So prior to the patch, cpudata->policy is supposed to mirror
>>>> policy->policy.  With this patch, this assumption is no longer
>>>> true. So it is possible for the user to again override the choice of
>>>> EPP set via platform profile by changing the cpufreq governor ?
>>>>
>>>> Is this the expected behaviour?
>>>>
>>>> The bigger concern is, if the governor was previously "performance"
>>>> and then the platform profile requested "low power", "cat
>>>> /sys/devices/system/cpu/cpuX/cpufreq/scaling_governor" would still
>>>> show "performance", which is inconsistent with the behaviour.
>>>>
>>>>
>>>
>>> This ties back to the previous patches for dynamic EPP.  My expectation
>>> was that when dynamic EPP is enabled that users can't manually set the
>>> EPP anymore (it will return -EBUSY) and likewise turning on dynamic EPP
>>> should keep the governor as powersave.
>>>
>>> I'll double check all those are properly enforced; but that's at least
>>> the intent.
>>
>> FWIW - I double checked and confirmed that this is working as intended.
>> * I couldn't change from powersave to performance when dynamic_epp was
>> enabled (-EBUSY)
>> * I couldn't change energy_performance_preference when dynamic_epp was
>> enabled (-EBUSY)
> 
> Thanks for double checking this.

The other option is to create a "3rd" cpufreq driver for amd-pstate when 
dynamic epp is in use.

The upside is this one could then exclude 
"energy_performance_preference" and 
"energy_performance_available_preferences" so no need to report -EBUSY 
for that case since you can't manually change EPP.

The downside is that you couldn't discover what the kernel was doing 
with EPP without ftrace.

> 
> 
>>
>>>
>>> IMO this "should" all work because turning on Dynamic EPP sysfs file
>>> forces the driver to go through a state transition that it will tear
>>> everything down and back up.  The policy will come back up in
>>> "powersave" even if it was previously in "performance" when the dynamic
>>> EPP sysfs file was turned on.
>>>
>>> Longer term; I also envision the scheduler influencing EPP values when
>>> dynamic_epp is turned on.  The "platform profile" would be an "input" to
>>> that decision making process (maybe giving a weighting?), not the only
>>> lever.
> 
> Yes, the scheduler influencing the EPP values is something that I have
> been wanting to explore as well. My idea was to use the nature of the
> task + the load on the rq to determine the EPP value.
> 
>>>
>>> I haven't given any serious look at how to do this with the scheduler, I
>>> wanted to lay the foundation first being dynamic EPP and raw EPP.
>>>
>>> So even if dynamic_epp isn't interesting "right now" for server because
>>> the focus is around behavior for AC/DC, don't write it off just yet.
>>
> 
> Fair enough.
> 
> 


