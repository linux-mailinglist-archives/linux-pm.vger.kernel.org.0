Return-Path: <linux-pm+bounces-15786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78D9A0F48
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D40FB2146F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BC20F5A2;
	Wed, 16 Oct 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="waXJab25"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD1A1FDF81;
	Wed, 16 Oct 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094817; cv=fail; b=tc8PvS0vRHN+jKlLxx8jVW8aXuYC5sO15GIWcmdPJmCjNmudxycZ89X5KwyFU1hjB2VLQsVNuevfItmTLKleDo83wUqBkAwPi27AiMfdZp0K2zPQsA/NoZCCcmGXp6/gnHRymAdff7TuOpIOVLDAR8Fsla+YTEnqG2o1n0ynTvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094817; c=relaxed/simple;
	bh=MshmfaTH4EAknJvc46P08Y4y0SLNXqls75PVz1tkTXM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JA4nCW/7f0vb6bZVAY9GUMO9sOnzC1M8762cSsBTxedkd9u1Wf7HTZNTiblUVO1x+KcttUoIlhwkjmSfbVhxs1kaTiUowUFHdL9cYsfFLRmXD0DIP6IiBi/P471FV2IlAGcMdmYTJxUqruj4jCxVUrqFMm6gK+leuWwzMoYeLDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=waXJab25; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3FEhlYZ/y9LKL531q8aqghhKqMzO6XnXHle9sNfVqSQbzLr9BilTIVdAOK4EK4tZlvkTSPvWSCxbANG9vEYxrdza7Ra2IjkaxdDf0BYfc1ZDj+aRGOnx1UG3gT4xu3yQaLDn8Fpwjxk9QG7xSM5P6PrVfmjPW2JQ+PdcDhoPI1uOEIZptXRT3uOecix43JPz39IwnowL1fhtFA7D2cKa30p6wR38k/YbpOg/7C4FbgofZgu04mfdykzM8TVisXRcwycK2Jyah13a1GoR/ybSeLa/VAXjE1s40UFlqymslofUy4JHxVRiN4MOiRWgHDdu9M0BDkXXvJuQQ0KHVCcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XoX0GKES03F/Mv/DmmP40JP2Z2T+qyg2z8KONeg3fE=;
 b=Ch/gK5YSr1HZBHFxVgJkInTG+boOlFgyQ1rQzQ10UAHjkYBZgiBtGvUrGNiBQ/x9g1+7YUXBQT0HyyVcc3dlmnxyzlpSf709DQRjcdvkL8s/MaBCLMcWG6l6LIsurG+u9vGV+EyPdl8/LMSEFuScBj60ibV8+5dTLO61Dop2bfPgWWMLn1HlGHNgC1D2wxPKvzVFf2hPMnvvra1GvmVfNQEgvKPoKRUhDR7iaQDn7fDggSBqp90iiwZJP2e+64RSpnGNWUKbqCLNlQoOe19P4EjJctTtvH5fzGpXAvtKhuKlu4JuwygVALPgme+YcMhNZ9w5YwPNWkQGQ4AZJqJj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XoX0GKES03F/Mv/DmmP40JP2Z2T+qyg2z8KONeg3fE=;
 b=waXJab25o5EQ4CyZPouRyET3qrz7Qm3Set4V+557vbG2wLGHBH6wKjHiL+LDsEo5xgUJOtpeQkOX6RT+HP6VCBzTObVDrMmmR0mbzmbwt9O3E/fhB4GyTFI432qcwJrlhHWzZq5ZWVJzU+WYMvQf3qPQZH7PqW7a2Cr+G3hc6as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:06:52 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:06:52 +0000
Message-ID: <e6a0a70a-e4e3-47f8-ab0a-111697e0822d@amd.com>
Date: Wed, 16 Oct 2024 11:06:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Borislav Petkov <bp@alien8.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <4gcjfysohl7qxdfgmxm6j4yd5ps67qpnnwgt776xondsfdwnri@7mde6vfyfiah>
 <e385eea0-694d-47d7-9eab-0c2dcda9b0f4@redhat.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e385eea0-694d-47d7-9eab-0c2dcda9b0f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:806:122::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd1b06b-b4ae-47f4-7964-08dcedfc8c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1Z5YTg1aWFYY2tWMlM3bDBCODZ4cHZ4cFB3cWNpUVR5cEo0Wi9rVWxJL0JX?=
 =?utf-8?B?MHh5M2FkUE1FSDRFUFJOWURKaG1xRFgyZW5kZ0hJNWdEOVE5dGlpY09iQ0h2?=
 =?utf-8?B?OUY3VTAvMlROZXRJcGM0eUxVMHl0YjVHVlJsRXJRMnpNRE5PakpTQkptbjZL?=
 =?utf-8?B?aHF6YmYybFo5RUJXSk5JVENxN2d5Q1FJaG1sZCs0S2w2WjZ5eGRzRHZIUFlX?=
 =?utf-8?B?K2xMUUYxTTlxNkFCQVB2MHIyKys3OHJJbGJLd29CdVZFRlJrNWNqbVhHOU13?=
 =?utf-8?B?c1htc0Vnb1psS1NaQlRxTU9lYzNsNmZMY1BtYWx1UU1OWmhHNXRINVozTGkx?=
 =?utf-8?B?eHJ4RFNiVnUwc1ZHS0RTNitXNzByOTB4Qkc3dXEwZ1lHQ1RUSk5BekNxQ0VE?=
 =?utf-8?B?ZEs3eUNkVTBQM2NvVUZrNk0wL0czdENubStHdlQyMzNzY1FJYXRScWxLa3ps?=
 =?utf-8?B?WXhTMzhOdmhDbTVqc0VrRGVUd0JkVFdXMlpMbWRQcDl4UTV4WUQxWk1ibXU4?=
 =?utf-8?B?eFlTVUtqb3JhSjBzS2NBY054SUw1R2tiNUdacGdOMm5oTzRCV3pCaHJNaHNu?=
 =?utf-8?B?QkRKaE9EbnRrYml2aTFNdWNoQkZJcm9BVm8vQTZHUUd5NzBsT0I1a2Y2NXZI?=
 =?utf-8?B?cmFLU3gzWi9sZUpYdkhjVm9xOUFYTTNpa1FHamN6ZmNpTUdybEZVQmp1ZmhS?=
 =?utf-8?B?Z2dDRW5DYU8xblRpNEI2OGpCQ3lIY0JMNUQ2VHlmRU0rTDMxZmEwdy9MUEFk?=
 =?utf-8?B?eVloYkN2Qkl1Mkc4WmptTnhtcjdaOExZdUpjcWt0UFZEUFVkakJaL3FyNXd3?=
 =?utf-8?B?VDg0Y1hpL2VCSmJNR056a1B0S21pbGl0SWIwcEx0Q013am1CaTEyR2VYdHZZ?=
 =?utf-8?B?enlVNkk4Y3lXTHNwWERvWmNNMkVqSVhsSDhaaDQ5dXAwUmtZejVwalRXR2N3?=
 =?utf-8?B?LzNpejFkUHRnNDVoS1d1TEcvdjNxSzdQM2xzU1lYbExvaHUrcFhsaTQwNkNX?=
 =?utf-8?B?TmY1QWxOTHZaNmphNFQ1UUpJUWxxdzFTR1ZWdXQwQTR1RkZjZmhNbS93a055?=
 =?utf-8?B?U1p6UnNPK3hsam9NcmhZYk1IMEJ0MGtIbDVHS0MxelhPdUhSMVM2R0Y3Wmc3?=
 =?utf-8?B?THg2cFJ4TzZLSWJ0ZzBJNGxVRndEQ1FnakdrVi9QMlNkdXhWcDVlKy81dHNv?=
 =?utf-8?B?MldDRGtuYVVwWWhSbDlCcjdDS1ZOWFp3SWVhQVcwNkgzeGs4SjZhWk9pWjBY?=
 =?utf-8?B?bzRMZFJmeHZncWtoQ1lXcDFnc0k0M1J6d091bFVNbW80VThKWUVJWUp6dURr?=
 =?utf-8?B?WDFXOHorTWc1Sm9yQW05RVU1OUFmdEN6bGNKbW5HZGpzUUU2VFlQbE5GREly?=
 =?utf-8?B?cnZObjV3U1g4WnJvRG5qbUtneEI1amk5M2t6N09melJibmZia2oxUkplcmpp?=
 =?utf-8?B?enNDWlVhajgvYktNQWdkVElxTXJ4dE1DZGRzdFY5eUpqVXpwTlRpZ2Vicldh?=
 =?utf-8?B?aFlXUGVCd1orU1hVMVNXMUhlQUFsTGF0YU9NZFZNMnZqdXI4RVkvNk9NYW9w?=
 =?utf-8?B?R21QRStCaHpZb2VHU2FLMk11c2hGYThnU2hSOWNteUp1VUVQZUdiZVRwVkhq?=
 =?utf-8?B?WlBzcms1LzM4ck9VRWdRc3FhSGZLalhqbTdzd0Zjb1Vnd29tMWl2WkxVdW5t?=
 =?utf-8?B?azlDbDIzYUtDMldRYnJBajQ0N09aTjNrWitmc3lMcEVza0k3d05FVmFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVpnQ3JmQmxlZCtZWEpvVHdWOERPNzBndHV2U1Y0bjRLZFVQSisxekdVL3hW?=
 =?utf-8?B?NGlySUxlbzZGcWppeTExRGxKNzdxaHpweFU2TjJhVTlYZ20zQTVZOTE2R0l5?=
 =?utf-8?B?SlIvakV4VGV1NnZXbS9vQXdqV2pDanR1eHlNam03UkkyR2o4RThLYm5xZC9z?=
 =?utf-8?B?ZlBUN0NlbVFWRXBkQy9jdzB2bkJOWXJQNnJQWXdYZ0JMcjVaTmN6ZlVIYTFh?=
 =?utf-8?B?bWtRUlZyL2R0WXFmdHp0MElUZVlORmdTSmRONWI1dkJwRnR5bnVkM2xCTXh3?=
 =?utf-8?B?UksvdXdVdktiQ0Nxb3J2Vy9uam5tZ1hmc2s2UzBrUGpaSzdPSjlhNGQ5VUFB?=
 =?utf-8?B?QURFQjY4Mjd6SnpnR0Y4VGR4bGRhRE1PbHRMSzZQbGdNeVpiZC9CL3lJNjJa?=
 =?utf-8?B?STFhQVB5ZjNWTjZMZHRnWG82dmpEZXdDN2Evd1NZMzArQUVLbyswUS9xSHNG?=
 =?utf-8?B?d05ubVprb2F6akRsRjBxYndsOTh1WUtMWVJKdk12c3UvR3UrYXhjOG8rTjdk?=
 =?utf-8?B?ZUdwL2drOGlvMUFKZWJoNXZtbExGd0hraDJmbmtLV3JpVk5IeEJ5L0M3eGM0?=
 =?utf-8?B?VmNZRVZlUnl6Yi92YktmVkdkbmZENFg0M2Q5WHJMU3dUeGhCZDNpalp4dmNm?=
 =?utf-8?B?SkdLeXl1NmtJNFZjbk5WS25rWmNXazQ4S0M4RzNBdkRlem9xTkdUS0J3bFl6?=
 =?utf-8?B?YkVZenVJbjZEUEt4TUJER1RuSzlyZkprQUhCRlFCbTJaall5ano5Q1BYYmRv?=
 =?utf-8?B?VGt5eG9TOGFMbHM0VDVyelZCR3lOOVFPbVF2cGNXWnRDUnpMbncyQ0JFaFA5?=
 =?utf-8?B?a0RNZkdtSnFBWFJuOHllV3N6d3RrdVNPN2VJNUgvSzhSSkVhekVKV1Q3UEY4?=
 =?utf-8?B?REhRNWhyOHoxajc4V3lOMXRTUFRlUmppdFphYXgxS25UZWp4b21YeURrbVV2?=
 =?utf-8?B?YlZnc3VJRDl2ZjYreXVuRlpvdmwxdnZoTmV2UVFKZWRyZGF6L1czRTRyNzI4?=
 =?utf-8?B?SG9mZFZ5Y05qVitKU2tZNFZFaytnNFl4WEliVlVkQ0Z1SkNsNEpUUEUvUmps?=
 =?utf-8?B?aDhVQWJuVmZYVjVvaktyYnhsV0oyR0RpWlRpUXhJWUpGdTRPdDRnUXg5L2dn?=
 =?utf-8?B?T0IySm9ySm9KbnpxWTcyTlVxZWZjTE9zRkVrSXd4VVFwaDZLVWZLSkhBaTZ3?=
 =?utf-8?B?MlU5bEFEb1c1bHVpODhCbUIyYm5aejY1cUdYeTRCclJJYkZRZjdLTXRISjlw?=
 =?utf-8?B?MU9xdklNSytja0FwcjdxWnFtQ3dGU0V6cnFkK1Z3bjJzenZwcVdPYlpteXd3?=
 =?utf-8?B?VGVuY3ZJaFVEMS9nT0pWWlJscjhYTzB0dXl5WEowMjVMeUgrWk1LZTcyKzhG?=
 =?utf-8?B?VXhqbm8vODZiWHpXUUpqLzJ3dlVhcEU5eTRCRUR4Zis5MEI4ZFBNaUZCS0FM?=
 =?utf-8?B?QXIzSGFXK2NhMmdtbWhDTm1pSG55cU1VaVlYUGNXdUd6UDNWc3JlVUlKZTcv?=
 =?utf-8?B?czFTRnp4RDhad0dRN2pJaUh5YTFDZHJkc0d2ellNMG84WmExQ1ZOME44K1Iv?=
 =?utf-8?B?UDBqdmI2d0xCS2thdkhobE55TSs3WTBiaVBma3RQcDNaa1BNV3laNm05cm1i?=
 =?utf-8?B?Mjc1OFI4MG5yZWVad2hjZzhiQXQzemovMnJZY2VXYkN4U3hQcWZrRGlIeGxP?=
 =?utf-8?B?b2pmUytyVWV2WTdIaEhYWVVRc3lUUjNnVHAzMFhmS0ZvaHY4MENwSHNFVTNs?=
 =?utf-8?B?dUhESDQzaUd1VVJIenF3SlQ4Vm5LYkZkMnVISndYM0dMNG9hTGVVZmhHbVJZ?=
 =?utf-8?B?TFdLK2kvbVoyVVBlYUphalFab2hzQktzM1RRTnFDSENJL0tiOUFiRURyN25J?=
 =?utf-8?B?dDFFZE1IdC9qNUkyeXkzKzVvd0xlUkpFRHZkNUwvZGdtMElzMFZWTTRBQnZ3?=
 =?utf-8?B?SjNDWXZXQjllamczR3h4RXVDVjJYL2pDT1UrWll6YmU4anpJaDd2WmM2NUhS?=
 =?utf-8?B?eUNJU1lGNDJzYWdabHRUMEwrVkM0M01KaFlkZ0l0ZnhpcW1Fa0xYNHNCSi9y?=
 =?utf-8?B?ajBqUk4wNDRUNFI4cjFJVzUxajgrTGpnY2xrOHJFMXdrU1lmNDF6RzBqTjdW?=
 =?utf-8?Q?SWVY4KlVVhNnH34BP0iigI4sR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd1b06b-b4ae-47f4-7964-08dcedfc8c3c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:06:52.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxvl0MEP6Y3X4CPct3apneTFV5AkE0e2/kMd+odV73dTZX30a24Y264JNlNVzBo4K43ikriEBiR5cryfP5/zLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

On 10/16/2024 04:59, Hans de Goede wrote:
> Hi,
> 
> On 16-Oct-24 11:36 AM, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Thu, Oct 10, 2024 at 02:36:57PM -0500, Mario Limonciello wrote:
>>> +static struct platform_driver amd_hfi_driver = {
>>> +	.driver = {
>>> +		.name = AMD_HFI_DRIVER,
>>> +		.owner = THIS_MODULE,
>>> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>>> +	},
>>> +	.probe = amd_hfi_probe,
>>> +	.remove_new = amd_hfi_remove,
>>> +};
>>
>> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
>> return void") .remove() is (again) the right callback to implement for
>> platform drivers. Please just drop "_new".
> 
> Note there is a "[v3,05/14] platform/x86: hfi: Introduce AMD Hardware
> Feedback Interface Driver" patch superseding this one now; and that one
> has the same issue.
> 
> Regards,
> 
> Hans
> 

Thanks!  I'll gather more review feedback this week and fix this in a v4 
next week.

