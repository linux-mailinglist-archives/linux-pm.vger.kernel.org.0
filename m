Return-Path: <linux-pm+bounces-14575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C897EE9B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33641C20CE6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD31B199EB4;
	Mon, 23 Sep 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oUjoHYFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A419C56B
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107027; cv=fail; b=NgarI30kmT+wbP5JrYQscXJC2L5GiwbENwbrVZGAvUiIDwRhgGPLGrE+myHJbySBWZ0TTCi2D+WV8IoIPUutNvrjbX8TAqbR9tyKa8yL3HChJTCEetMRAeXKBTYJSo+FIykbxeffVhNZySOBjKDbbzpAaahtsNGIpOtoe7SoTg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107027; c=relaxed/simple;
	bh=NfBj548wvqWZXGdfMdxfNP8PZh8adScPz31D+AjMHmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4lU7FrEhYGjRpkLN6TRvzJmmI3uDgtNoMiK4V8AE/SuJzBZXR8Scl586frDxfN7OQvpDUk9PC1MZXNvShvpAQ1tui+aTWCOcw3FCJjzZbI+pf2Tgkbu95o3KbXE+IsjVrsD9+2eTUTWZfhh/crd1i6WEVFKq1j69HLUyJIQZRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oUjoHYFr; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxt7s1FLtgQYWzt+NPPt/CLZKOYMFSYHJZWT6IVp81vvLIFyWMXF40yYveA3oBrLzeiVtFfE8jip4sgZcqywWvjD9xHIczxDegjOriaF3kZN2djyVXDVtFx9w1+6X7JW7haG4mUlYLMhtdrCsK0zwThVM9lNtC7snVAv6VqYtL8FSyGEg545HaDYhiUjOuwNgJVQyp7mYkKC+5JUTNVXLXSXkX+rHwXQMam/QrLkgNmMc17Wn74rB8vmoCBURGeGQw9F5sPDbzLqTAcRzWNQ1wob6AxoptuyucZ45HQsGyBc9XdWR74zQGB9npqfL7iGwS9PKR/qKv1/bDT7dLzOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNITzNA3e90m9HVk5pcvhUVyKe6TLP365m9VlUcxZwc=;
 b=Z8wpMYgxfRNBr/jdsaRrBXvkt4tWiLlD1Ub03PFIlPjL+FOhFLgamNHaQrzZ60/6kYE+3akqT67o8yxcGbgss5qa3E50E27cOxWIKiuitbCds2hj/g47ZZ9PVxNK/maockJpBhBMx4Q8Rs9QPV5hJiCw3eUoEr3EZmugujV3Ohl+d1ZZadBB5xK/pQFMY07mN3lTL5+WrlZf8bEdGrHmgtyHL6c9iJNhGXOjbHv3g6BhU89zOoEYhxxK9gosdje6RX9UKUyRbCmkaQSvsklIprq6NVzfqjMPTu3de7l9NMIS+TdylGWApFfy67hyMtK3UX7UjrG3CkLUeX/leVlnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNITzNA3e90m9HVk5pcvhUVyKe6TLP365m9VlUcxZwc=;
 b=oUjoHYFrUVQqiO6v7kHt+nb0UfQh+I3KsKVolhbjBLwaiCF/Ya6lk2fCLSYt2JiOFjo54PH4YetybzO8/UTsG2O+15+d8wPb3nmmWEfNmR5FZPs1wfpp4mXdFpemORtW7X8fI52b0kr2vuJrYG8Di+b7/1UKF8w42PHaoy3hlVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 15:57:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:57:01 +0000
Message-ID: <fa1cb9c1-8b56-4fbf-89aa-86ffc6dc837b@amd.com>
Date: Mon, 23 Sep 2024 10:56:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Antheas Kapenekakis <lkml@antheas.dev>, Luke Jones <luke@ljones.dev>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
References: <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
 <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: b75c366d-31a5-44b7-aaa2-08dcdbe85ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGR4OHBURW8rWk1pNDByalFzSzF1V005MTBUanc2cVMxTnRFNk5JY25XMjBr?=
 =?utf-8?B?K3M0TnRMZkV2Zmp4Z2xSTEVrWVRIZE5kOHE0azYyek1ONUpiOURhc3lQSit5?=
 =?utf-8?B?MnQ4SXhtL1JDUE9IY1V0bjdLYkRVY3l3Z3MvSm95aTg1Y3FPdk5xcjlYMDMy?=
 =?utf-8?B?VUhGeEtRdVdKbDk4ZUVmV29wa1doNC9Dci9nS1BObDNFckc5QXZwdys2T2h1?=
 =?utf-8?B?Z3hNVlUwK3lqcjZIcjZwVGxlZHhYUE9kY3huNHdhU1FsWnBlTGFHODlrc1M1?=
 =?utf-8?B?S2xxYmF3UnZpVUVuOFVONzJ1ck5vMkM0WUhDUTY5dm5ndnUvajVwMlJnZ1Vx?=
 =?utf-8?B?MjdKZDRjTHpnRkk1SGV5ajdwS3M1Z0NvTHFZWGNvazhXWitCMGZDdFpsZ1FZ?=
 =?utf-8?B?U1FreVdxQnpKOGRuVUxGMStCVTM3b1FtMjljQ3hEWjhvbWhtbXVVU2paVkNk?=
 =?utf-8?B?TXk1dUVCZzBPTU1zZjUxZGVzbmNMOElTZlFjTnp6V1NYaTRrRlBzc0NEdmU1?=
 =?utf-8?B?RnFwVjdyaktKOWFtenpLODVYSmxzTzJUek1pRDFwaFJ5MWZ5bXJ0TllHV2ZM?=
 =?utf-8?B?RjRMd21BZmJPWENXMmswSmMxREtqb1NHekQ5N0J1ejVYdW5hZnBqa2k4T0Vj?=
 =?utf-8?B?VWxzMFNmYk1La1Z5KzJUbDEyM2xYRkJOcytkRW5rVGNzNEUrd1FUUEkrckFV?=
 =?utf-8?B?S2Vxano4VmxiYjdseU9td05ualB3MHBJblpjNUpyUnpIRlV4bmlqN1d2bCtC?=
 =?utf-8?B?U0R2WkZhQ3ZSd0hyeU9tMklBZllTbzVHR2lFY3RsVjNwalFiV1Yrc0gyR2Jx?=
 =?utf-8?B?NXl5T2lqdVIvSEo1bThQd2dXcUFYenJ3T3Zaa0VCcjZIRDhrUGRwUEwzWXZr?=
 =?utf-8?B?OGc4eEhCTSs4ajlsc05oeEREL0I0SGhHU3o1N0NBQ0RZUWhITW0rcWdKU09T?=
 =?utf-8?B?SlpnMU5OSmpuMXpQcEVKczA0dTVyaXdiaEU0U1JVcGdrbVBVWGlBUmZucWxJ?=
 =?utf-8?B?S05Qald5ZGJGSjVHNFNrT2xBbXpCQ2JRMzRtRnZ1QW1IM2IzZUQ0cU1PTmwy?=
 =?utf-8?B?MkgzVmFhSUVMengrcXg4WlVBeXZIaXJtNFZhYWd5Z05BdlhYcm1sZ2I1VCtm?=
 =?utf-8?B?MmEzYU5pWFBDSkM5MjF0bC9majJESUswTklJcHNJQXRwNERobWVuYXROZy9K?=
 =?utf-8?B?eW1UTE9haGd3dzVwTjd5TzM4eGxLUU5LTnphcTMxM2FHMzRaRlo2QkF5RUE5?=
 =?utf-8?B?SnJZYVZQUnp5SFIraHBLTm41Qlg2TmpORXluekdmTmx2Z1hYUDVXRWZnRktq?=
 =?utf-8?B?NUJJQzU3aWFLcFRsNHUxZGJCYmhyUmgwQzhMallvTjRaaXBJcXUzTUdrWTEz?=
 =?utf-8?B?U05xcE5KVjJObEVUUGpmcTVSYnRPUk02WGIxRkxZMU5mT0Rlb1VYN1c5K0tI?=
 =?utf-8?B?WWg0Z0J4MGtJUmhnTGhkTFVLMFZDb1BSQ2ZWeGVJWmpSQXArSDNqNUdKdFhJ?=
 =?utf-8?B?R1FSYW13cVZwNWpkVHcvTzJMNXZzWjFSbzhsSkNEM1hwVFB2eGIyTUYvT3RH?=
 =?utf-8?B?VnhhVWNCL3hKeis5UHdCa0JtYkZ1d3k2NklXeDRDbnlvdWd4ZHhsY2liZlda?=
 =?utf-8?B?VEJBN0dqL3N2VDlINHNsVzRCSDNIWkNwR3ZRdTAvNXNBdHNRTVlleGFPNHo4?=
 =?utf-8?B?VE1ET1NxU1h3eEErSzdSTjFybktWdGxVN1gzRko1UUVlaXZZcWFFT0dwTnM2?=
 =?utf-8?B?dVJVQVEvZTFYTXZNdEV4YkZZNm56MEhoeCtaVGpSZW5kWXJVWjlheUxwK29z?=
 =?utf-8?Q?UU+mmeUf93x3uyD8kEfSgeoMBmbxrK8webfX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1BsS2ZVZkNMeWhXUkZmOGwzdW52aWphcFo3ZXczTU1CRG9VYmJBbjJEL0gr?=
 =?utf-8?B?ekRCY1VmMC9ETmZPV1pVQmRNQzdDU1pUQXF3NlN1TUVSWTdidE9tWk1OY1Zp?=
 =?utf-8?B?UnB2aTdCK1pITVp3WHFvNXZkOWYySHpTZEpESW9CeTNCdWFya3RpbTAxU3Jx?=
 =?utf-8?B?NGM1TzI1TEpCSzdmdUFsa2hRVUkwcDBEWDZGRnJhS2JpS1R3VVc2WnNRNG8y?=
 =?utf-8?B?c0s1a2lOZlV6SXN1cS9IUkRUUVpZc055VUdGUGVFRDY3SFd0YnAzRGxLTjRu?=
 =?utf-8?B?Y3hqUWY4R1BKamZwWFlvelZmeHQ0c2cveFV4V2t0RWp4Uk1lQkVIc21WRUwy?=
 =?utf-8?B?NzR2cFlQTnE4b0J0OEpaTzZUNnpoNlhoNjFJdmdGcXZzd2czWCtjdFE5dTQ1?=
 =?utf-8?B?RTNwTXNPUC9XNk9xcFErR0luOWRBd1BRd0haS01RcDRjMDk3WVpmZ2hWa2FP?=
 =?utf-8?B?VjRNRXdpc2IvTWVObnc4VXl2T0hYcFBzNkt1ZTlPYzFoK09iSFA5cGJzclh1?=
 =?utf-8?B?WFpDWFFzNE1MQ0FsYXZ5a1pKVXNXVWdndkczTmxWeTI3aDI0eUhjVnF3R1h3?=
 =?utf-8?B?SHBVL3Z5aWxRY3ZyNFVWckd2UWg4VGRrNXNOYUNyRnF6b01QS3BPVE00MVZZ?=
 =?utf-8?B?V3IxRDE4TlMvTkt0Zmh0RG9nZkc1eW5EVUh1YjNuc0ljY3ozbVlpREpDL1hp?=
 =?utf-8?B?ZmsvZnV4YmloUDk5U3BLYTdmbUZRSDVxRUxYMElkNTljOVZmdkhsSy83bktV?=
 =?utf-8?B?MW94K2k0ejVXbmEvTVEvNTVKanVJUjhpZm9vZmhjTUUzYlhMY1dpZXRSS0lt?=
 =?utf-8?B?RkMrNlFESlV4UU5tSEp5TExKVHZZVU8wMjJyT0JZeVErN1ZodnY5SVpqZXZF?=
 =?utf-8?B?OVJLSnlmNE5oekk0ZDVQTnNsQ3p6RUFrcm94bFU5QTlianRGempES24rQ3Vq?=
 =?utf-8?B?L3ZPcHZEY1FpUlN1OTZaQ1NGam9xSXdKMzlMMUFjUDVJcC84RjBLcDR1aVZq?=
 =?utf-8?B?WWRCZlQvaGtXUDAyUm9wcUQ2UThYNHZjOEY0MlhqSXZBRFczNFV1OVQ5NFVY?=
 =?utf-8?B?eHh0eXU4ZW5odUp6ZU8xQmlpQXlYRC9ReXhyOHI2M2c5MDQvNXd5TUhCTnQ2?=
 =?utf-8?B?Ym5KNm9PZDI3YkJIKy90S0ZKZld0YjNpbm9MZU41OTYxNStaNUZBenViNUd1?=
 =?utf-8?B?YXZIc1J5Z25DeDZ4L2lETk5MVWQzV1AzckQrZXllanI0NkdBWGZrZ0NFT01s?=
 =?utf-8?B?UHcrY0JHcGsvWkc1bUFNQTBTcDFFTEc4RHpOY3RzeTF0TEFQMzFnQWFyMjJs?=
 =?utf-8?B?MEd2SlVGMUg3a0FaTDVMM2ZSMkU3MXN5WitucnRMalc2WXJZVXhBOWFwS3R2?=
 =?utf-8?B?WnFwOUtQL25YRTJqU2Z2eFptUnprR3VpdjJNMUs3UW50NHBUNk0zNVpyRFAz?=
 =?utf-8?B?UnRIanJRcUQyeHQ2NTZNWDRHVnNoZWQwNnZYQll5bW5jdTNCL1ZweGh1ZXZ1?=
 =?utf-8?B?NGxFUW9JVVM0dWhMelJHNTZtWDNuZVVQZk1Xc2NOa0hoK040OGpHVWlndlBi?=
 =?utf-8?B?cG43SVdrWmR0dGtDY2NsUGZwWFFLaEdLaDVDZUtBc0JveEVvMU9YUHZENWxO?=
 =?utf-8?B?WGx2UGNreDJpMHNCQ2QyeFNCWGQwelhscXZSNmkybng1cXNQL3liWXdhaWRI?=
 =?utf-8?B?Vlp6cE9nM09Ham83VmdZOTgzSHB5cVl6ZW1YYTMzdVhudzBFeWV6Z1djeHBD?=
 =?utf-8?B?eWJnTmpaeVdyNW05T2pCR3RPTmg0RW1sU0xaR0NDZnR2TTJlY3BMZWZOV3c0?=
 =?utf-8?B?eXVWS000TVF3ZDJIZGFncys2Yk9NY1hLMHZ6UnRHVWgwcmZTL3FVbkdpeUM3?=
 =?utf-8?B?c1pCM2VYbDU5V3pPMGM2SGxtM2dZaDBPUzdHVkFIMVFpZ05DNFFlWHpjZGUr?=
 =?utf-8?B?WEU5eDUyMjdpempJMXFVRy9ZV081eS83MkNKSkwvSlpUYmFScTZhWVUrWXEw?=
 =?utf-8?B?NWVvOVMvbFhkaC9FQU40M3VJM2Jpc1UwOGFSNitUUk9mYlJVLzBCaGFGclFr?=
 =?utf-8?B?bWFodUkwczVjbHJxN0owaS9sQUNuUzN4a3NrRm10VE1oSExlamdSMXJsQjRs?=
 =?utf-8?Q?1sG7stqWIAZliyc3dvM5gVL4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c366d-31a5-44b7-aaa2-08dcdbe85ca6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:57:01.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph0bY1XozXcETilwhgsj7MQYxOnI2poSYv//kvXCDoEIyZTpnriD1Zuw08I/fzxt6ijXKMV1s+8gHuuTBgjKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239


>> It is perhaps best if I refer to what Denis and Derek told you about modern standby: focus on background downloads and proceed in that direction - the firmware really does fix the suspend/resume/reboot issues. You can also drop the asus-wmi patch (in submissions) as that will get dealt with soon enough.
> 
> I personally do not have a problem with making the next variant of
> this patch an RFC. But currently I think it has a good scope, so I
> would like to ask what other kernel maintainers think.

I don't think it's possible to have it both ways that the ordering is 
wrong AND the timing is wrong.

To me; this series is looking like a lot of bandaids to work around what 
behave as race conditions.   I'll leave some comments on the particular 
patches, but in the cover letter I want to see particularly patch 3 
tells me that this series isn't doing it right and you're getting lucky 
on the timing.

IoW if the call has been moved earlier but then you need to delay it to 
later was it really right to move it earlier?

Rather than littering the kernel with quirks for a buggy firmware
that the manufacturer is fixing I personally think it's a LOT better to 
invest the effort into getting the MCU updater ported to Linux and 
encourage users to update.

I started to add some code to fwupd [1] to at least parse the MCU 
version for Ally and Ally-X.  As this eventually lands higher level 
software could potentially communicate with the fwupd daemon over dbus 
to get this information and notify users that they need to update.

If we manage to get the whole update flow ported it could even work with 
the daemon to do the update.

https://github.com/fwupd/fwupd/tree/superm1/asus-hid

