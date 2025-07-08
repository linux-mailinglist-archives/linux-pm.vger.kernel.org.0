Return-Path: <linux-pm+bounces-30346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78DAFC5E5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E793A7ECF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 08:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84692BE03F;
	Tue,  8 Jul 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="00q3Hjfj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101E2BE02C;
	Tue,  8 Jul 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963944; cv=fail; b=N978DRVZIevSeakEPfyClezjCtRNeMkUKIU0JXI1pNJY0slDP3d9aQJGiBk4Q/ychIpUE4XOP70qf/zSp436X4SwO4SU1eDMlwUKfaK7S9BOj9pSjTnvgkxEyv3b5x+9vkngKT9N4ZYqMylX4VwiaQLk9ourL9UUtC94OPhPPfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963944; c=relaxed/simple;
	bh=kH/75NK4LJhPTTHVhi4yPfGcMvoE5iforrphFc4wWfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a5jmpQGTEN2I+hDGhs1cr5HcnP/IKjF1VcQTivpyP0ibfVafORIZi7itgPBSMUqs7/d+4SDzdna9TztmnRlarfgsgcfVLH7XKJNjbcaolYswrEn+YgvIEH2WNSgOTMKOtBvzAVv18QPHl6GDnOnP09LUaglJ4lFFyzuaZzcz9nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=00q3Hjfj; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IktdNwovsPl2B0GTSCmw2QE22cQj6qhkzPN+OzuRLI7j0uTfDs18MZcwKorlyCCOwfYVQ41Y4hOh98X1ZFEK6YGHRzK1PSIgElPw9/yirQoYw+u+22msAtxC+7bgXHY/XvdmjXz87xdmm/mvNukuQaIfG9SrB4umsbCHh5I5eo0+9loGO0PmqI/M1sc76X8E0uzK+zWhHGP5NYFwb4Je52cpJhSRCnj5OhsN5DGbN7NcQxgNx7KRhoDGSF9pVTyqpWqB8B2DljIni1PdHlRolPl3vHNujaRVacM1Waqzo+i0Ls9719UXunYRj+PXHy3a2JMcxwlov8Mux9iCW29V+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AckkaChKarYiP5lGuxGh4hG1efLqb+mx45NZQ+CWTJc=;
 b=ORYSEMyooQZuWaJ8sfFF47qTUwK9QGac9wlnYK0Nse598VyQ4XKref06a5sX16XSMhVFDlgHR1t3acdYtseMqRn5czJBJEdCGgPmUXKpj1dG+HB3YnrAqWiVLJslmZgtV81WKChggGKSSWSaUZGQm1U6hI4Viwk1WWcmBgTYvFf/1p/G5tVcKccDHm+MZarz9YoAfsB1jnJ97LMAZiKRTmxscodHr4ceZ6yAAB3x9m8RjEtEXpK2RRbijIJTx6hT839LXUyNz48GyDut9u3YSpmN95qC/hEjrFnnDzeLjQxvlxcfA/mnCcfmGHULLS21HCkkZqX37xcYczrqhVpZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AckkaChKarYiP5lGuxGh4hG1efLqb+mx45NZQ+CWTJc=;
 b=00q3HjfjmpFBcAvcfObQE7gSUDl3cwSqrqAKivLpwLgdZtmMX/9hxRzaSxT81CpDYKcisIGXLUb+N2dH0TZ4hqA7YuwwuUoGeWjQhCZMzMGtMoRGXZrYcuo61cbkRTUYZQBRNF5gCQlp2CHm+XpZJClOnBzxonqL9isnITbO5ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 08:38:59 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 08:38:58 +0000
Message-ID: <f5562f2b-1055-4ce1-817a-d51a996a2418@amd.com>
Date: Tue, 8 Jul 2025 10:38:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/ttm: add new api
 ttm_device_prepare_hibernation()
To: Samuel Zhang <guoqing.zhang@amd.com>, alexander.deucher@amd.com,
 rafael@kernel.org, len.brown@intel.com, pavel@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, ray.huang@amd.com, matthew.auld@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: mario.limonciello@amd.com, lijo.lazar@amd.com, victor.zhao@amd.com,
 haijun.chang@amd.com, Qing.Ma@amd.com, Owen.Zhang2@amd.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20250708074248.1674924-1-guoqing.zhang@amd.com>
 <20250708074248.1674924-2-guoqing.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250708074248.1674924-2-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::9) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 2599b815-311a-4f81-e31e-08ddbdfae1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmdBdDN3bk5xdTd4QVVHdmRmNUNaSS95Y0wwbDl5YlpoQ1FOWk1td2daZ3JR?=
 =?utf-8?B?K3hKdUxsL3BsVy93NkUrUW1uN0kvWkpvV3ExSDNyL2c3cUpYempubno1UEYr?=
 =?utf-8?B?T0Y5Q2x0VkxwNmZiWlFaZDYxNG1JaGdSK1ZtSCsrL2NMQUEwRmFnZ3E1OUZP?=
 =?utf-8?B?RURRcjZmeUFPY0J3czI5TXBNUTdoK0ZXbFdpeUR1bG1OaFp2aE5DZVpQSDNk?=
 =?utf-8?B?Wll6cVlOWVdxckF6a0lkQks3OU82ZG04cHZ4UVB4RUN5K0tZa205YU9zUVNo?=
 =?utf-8?B?bVZERWFlNTJjUDVTMjM2aUtMMUZvUDUzN1FwTGpNTG1QdkZYbWxuYzhrWmJC?=
 =?utf-8?B?aFR6L1lKUlJQRHg5Y3hXckNHNjdWMmY5QU5zZGJQMnIzZ3NFa1dvN1FDaVcw?=
 =?utf-8?B?UjhuT09iR0lRNDRVTjd1Q0JBOTJmTmFmVmdDNXJTMWkyMUlFam5XeWpCTmJq?=
 =?utf-8?B?WmgzNmludzFlc1hUOXRMRUh6UkhqcHNZbFR4SUhQQWRpV3ZmNkFCc0I3Y2Ra?=
 =?utf-8?B?ZXBXbzJEYUhPMXI4QzE3ZFQrQk1ZaWgxaGd0dmpYMlZlTzh2T1JGZlpGMFJD?=
 =?utf-8?B?ZWlLa0RVVU13RjUvZldQRThwc0FYWmFPZXo1S2NMNlBpNE0yWitsTlB6ZUZj?=
 =?utf-8?B?S245dzV0cDRkTWxUZlgvQVVyZ3p2Tlg1d05CbjBMdnB2WGp5aEZoZnNpWTVI?=
 =?utf-8?B?dFFIM1NzQURDSlN3bFJXUEFjU3AyeVcwZXBpUktxb2xIMERiWjN2YXVDd294?=
 =?utf-8?B?YkEwNVg3OXVHRzFQNkNmdjY1R0VRbFVVMmhRV3BBdFhLTHQzV3F5dlcvMVdD?=
 =?utf-8?B?T1Fua1ZmbEdaVmlHd09xbm9ESUtZL0kzcGhTbWRyZzNaTG9INFZjWHgzOEk0?=
 =?utf-8?B?dE9mUnNhay90cFUvd2VrSW82cGdUdUQzKzZyQXJ2aFUvbXJPUUVTOW1HMTVH?=
 =?utf-8?B?YmlQV3RqT1d1bkM3a2RzU0p1WHJvT2lDdlhwN2xlL3o4RmJXREo2OUlIWGxH?=
 =?utf-8?B?THY5U0t0VkhhRmVoUkFqTS9SQ3JoV3BVQVIzcE9aQmI3aTZqU0p4RXJva1N6?=
 =?utf-8?B?bE9kOUtldVloMS9rSDIrRm84Q2IzcnN0VlpxcFRxKzR4RmVodGsrdDlqNHMx?=
 =?utf-8?B?NUxVbTlFaFlmVFZCUnl1eGdoMU94c3R5aWRQQVB0QW1GdjljTFh3V0c4cDFO?=
 =?utf-8?B?ZCtPYmxZVXI4QU92QTNzVTNaY0tyWkZaNG5SRVBnRHNMMkdkMWJjWVgzMUpa?=
 =?utf-8?B?dGNJMHVsdUJkZ0VlODB1QkxXSEJLMjdKbGxpcFpGRlRvNWYxVjdMcnR4UmJx?=
 =?utf-8?B?d3BMM3ZhaDFCYnhlNWpZTjg0d2xLRjZTdzZudmlyamRqc0YxNTdBck40N3N2?=
 =?utf-8?B?K055MzlwUGdxbmtMUkRZM3o4UnB5Z3U1QVdvUmI4c0IxWS9JNS9rYzJpY2hG?=
 =?utf-8?B?b2JOT004NkgrT1loT3hnUGhsTmc1ZEowbytmekFoT1NDWHFSM1JhZHVWQksv?=
 =?utf-8?B?Mit0NGg4ZVRnSlRxQmxKc0lod09zQ3RXNmZ3R2JuaWxpejFNcE84MUF5Rlg3?=
 =?utf-8?B?VHVPRVJsZmZPRTloemxOcnVPeGlpYk9aR05vWW9HRU1ESk5yRGYyUnBYcmtY?=
 =?utf-8?B?UU0wc1hTK0prQitYV2xiVWtCMEFJWktVeTl6U1dBNDJtcGlKWEFJNnZqUFhH?=
 =?utf-8?B?c1UwTThNWng4YU94a05NRXZ3dVpmNzh5NHViTm5aNVRhQXluR0FMUmJYaFVj?=
 =?utf-8?B?aWVYNkdXdE9LdTAxa0w5SGhySDVMY3Y1czdzTUNoTE8ybE1uQWlUd1BEOHBB?=
 =?utf-8?B?SFc3R3dwcXFDV2h0MmoyQ1c3NE9XRDZSRGhsbzVHS3lRbGhkVEZETEVXL1Mx?=
 =?utf-8?B?d0k3QkZmNCt6ZFJmWUhFM2lreHNTWTdobm1DdlltOWhtSXBBc3hBc0w4U3Jv?=
 =?utf-8?B?TmJJVHV5UGE1OHkyYzRFcEJvQndrNTJHNG5KWWFEWDdyQ3lBcFFEaTVTck84?=
 =?utf-8?B?TktNWUdHNDN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnppYjZXNzFYQjQxSEhYVmZaOGFRcExrSWlVeHJ4dWdvNG1KbjN0OHRXdGtT?=
 =?utf-8?B?OEM0RDByZkUvUjJYL1NNNVN4M2lwYnFKOWRic2xWVTVNQjdiWisyc1Q1QUk4?=
 =?utf-8?B?UnloZFRiRUExKzh0WEVqdUlKUXJud25PUzBrOUl5NFZIcVg4MWxBaTZQN0U3?=
 =?utf-8?B?YThMMlhLdmNUeWJJVC8yRGxXMmJMS0lTWkdEcWNObUl5blprVktLNTljZTJ6?=
 =?utf-8?B?ODI4Qmtqa1JZMjUwRFNBRk05NWtzRWVuZ3ZFNVdNcENrV2xrTVE4WjAwZ0R3?=
 =?utf-8?B?anhTcmFBWVUrN0s1VG1tYnRoQldsZ2hWeXQzcDJ1cGNoQ2VmcFZrM2tSTnhW?=
 =?utf-8?B?TXMySG5kbHNhUytzbkhPYWVaWVY3VXVRbStvYUtlWEZSQjFYOVppWXpOVld2?=
 =?utf-8?B?U3VnMlVQK244L0V5dGNabTBBL1dZWEExbk5SbUxaY3VsK1ByRXN3cFRkQWNL?=
 =?utf-8?B?UEMzUFFVcXd0M1lZYzVaQ0JiM1hmQVRUa0xSOFZTcVBIZVZrK05aQ3AvQmlB?=
 =?utf-8?B?YloxTlU5YVNrR2I2RUtJU0NlRXdDa3VUanhZVVN5ejZ4MUtEeTI5RXNxM2ZN?=
 =?utf-8?B?aHpVRS9HSlhMRVdoUzhTMlRRd08wSGFDakpndFptWlhZb2QyS1YxcG0wdzA3?=
 =?utf-8?B?V1lpM290dWYyaVZaUmpUZFpWS29wMDJjem9aVzgyOXU0OW0xd1psbjlGSzBi?=
 =?utf-8?B?K29wY3ZJZytjSFNibDNnZ0FXM3VQbEV5dGUzamgwMVBZSkxyUkViSUpTWE4w?=
 =?utf-8?B?VEhkUWxwSHVlUmZ2cURYa1RMTDhJRU9yMDVJRzlBWWdNSElMM1N5aG9lbWpD?=
 =?utf-8?B?dGpSWXIwQmovUTZqTmJ2ekZVUnNRNkVPblJyTFB3ZGx6bHd6UHZzQ2tOakJC?=
 =?utf-8?B?N0ZFbytDdDRwR3c0ZmZSaWlML3JoeTlsa0Jmczlpb3doMXl3cndLWFFUbGpS?=
 =?utf-8?B?UGp6VGRSVmg5Qnk2Z25hUG5SRHU3ODNYS0xRTWhJYXNMeVFiY003RVdreVNz?=
 =?utf-8?B?cThPWTJLRmxQdlkzeVk3SmhjY05Oc3YxaW5Va1NXMWptVDZsM29VMis2cEEv?=
 =?utf-8?B?NEJycko4OSt6dFVJaFV3Q0tXM0tzeGZYeWpmSlFleUk4UXREajhnZTdMQ1JJ?=
 =?utf-8?B?SDhEejlhQVNMWnFiQjN1Z2ZDQUhhREV6NVNCaUUrdHhtQks1WXQzNURRempx?=
 =?utf-8?B?c0hMOFBISnVlZVp6Q0hYd2xkalNlMnFHeHkzOUtLWHBNRWUzbGxEQkF5QWxP?=
 =?utf-8?B?OEVsTkJnK0ZwaStKTm81MjJkVFNCOXB3VjdHbWJZZnpkMlBzTkFWVElIaXJa?=
 =?utf-8?B?N0xzcHg3WWpPV0J4OTkvMGdqT21jdzB2bVRTc1hYVnpadWhFZXRPM1R6VGFk?=
 =?utf-8?B?OVJwOTBrbmhrZFZ4bUthcHdwVDJwajdqZUhaL2xCTENQMFlKdXAyMEhrNVhU?=
 =?utf-8?B?dkpnVlJieHpFSllQSHdWcWpUVm9sUHl4MHVRd0ZIL0Q0Um45cE5UdnliRTd2?=
 =?utf-8?B?b24zQVd5UkVGN0NuV24ya1JpbVhOQjltMmpWbFBjOWdxSEIvbXV4VjdHV2Ew?=
 =?utf-8?B?eXE5WXN5UWhzYXZlaUM5Z3dpRGdveUNId0QwUzRXbG5BMHVOK2diZVhDU3hW?=
 =?utf-8?B?YWhiQzBnK3ViajBONzVwbEJuSVdRWTM2S0NSQmRIOVNCbUJteWVHWUphbVVo?=
 =?utf-8?B?Y1F0WTNSVE5OZUJveEFHa0hFSm00UU10VUdIYTgzaTRzT1p2VGZyQXUwamJ1?=
 =?utf-8?B?Q3JEWHpGaHVnR01jbncxZ0ltNjFYMmZqRG55TmRnUE5lNlJ0UnhpVmVnWjVK?=
 =?utf-8?B?U1YxZUE4YWErTWxKaTRxTVNMZkFMWWNxUjl1Z3diVEVJeFVVeEc4MU5yYmcw?=
 =?utf-8?B?SkY3dEJCRjhJKzZSMFYvMUYwdGxhcjBkS2RWZEk1cnIxV3BnYTZTdUlDb1lN?=
 =?utf-8?B?bkNkRVlEeDE5cXJlUURiK1BJUEVRSXhQQUxBRjFMWXZmdzRpQ2s0T0dBUXFF?=
 =?utf-8?B?NGNLZ25MY1ZvS1R5Y1hFdmlmNS8yN3FRUnFjbm8wc0UzblNJcnZIUzVUaWZJ?=
 =?utf-8?B?aHN1ZTIzbnF0SmpvZ250dXgzekhnRlRrNjZIeldRRzJnQkVvYSszbXpPbVkw?=
 =?utf-8?Q?8gkCRQ0+VHY0zT1H0jO1S4kvb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2599b815-311a-4f81-e31e-08ddbdfae1da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:38:58.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SIXkTyl+WYRQHVsfHk0rrZJybxRReL8dmoOb0ublvyGK4EWp46Rz7YLbpvNMrHs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899



On 08.07.25 09:42, Samuel Zhang wrote:
> This new api is used for hibernation to move GTT BOs to shmem after
> VRAM eviction. shmem will be flushed to swap disk later to reduce
> the system memory usage for hibernation.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_device.c | 22 ++++++++++++++++++++++
>  include/drm/ttm/ttm_device.h     |  1 +
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
> index 02e797fd1891..f14437ea0cce 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -123,6 +123,28 @@ static int ttm_global_init(void)
>  	return ret;
>  }
>  
> +/**
> + * move GTT BOs to shmem for hibernation.

That is not the correct kerneldoc style.

Please make sure that for example make htmldocs doesn't throw any new warning.

> + *
> + * returns 0 on success, negative on failure.
> + */
> +int ttm_device_prepare_hibernation(struct ttm_device *bdev)
> +{
> +	struct ttm_operation_ctx ctx = {
> +		.interruptible = false,
> +		.no_wait_gpu = false,
> +		.force_alloc = true
> +	};
> +	int ret;
> +

> +	guard(mutex)(&ttm_global_mutex);

That is unnecessary now, the function doesn't touch the device list any more.

Regards,
Christian.

> +	do {
> +		ret = ttm_device_swapout(bdev, &ctx, GFP_KERNEL);
> +	} while (ret > 0);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ttm_device_prepare_hibernation);
> +
>  /*
>   * A buffer object shrink method that tries to swap out the first
>   * buffer object on the global::swap_lru list.
> diff --git a/include/drm/ttm/ttm_device.h b/include/drm/ttm/ttm_device.h
> index 39b8636b1845..592b5f802859 100644
> --- a/include/drm/ttm/ttm_device.h
> +++ b/include/drm/ttm/ttm_device.h
> @@ -272,6 +272,7 @@ struct ttm_device {
>  int ttm_global_swapout(struct ttm_operation_ctx *ctx, gfp_t gfp_flags);
>  int ttm_device_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
>  		       gfp_t gfp_flags);
> +int ttm_device_prepare_hibernation(struct ttm_device *bdev);
>  
>  static inline struct ttm_resource_manager *
>  ttm_manager_type(struct ttm_device *bdev, int mem_type)


