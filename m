Return-Path: <linux-pm+bounces-26985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B9AB23AC
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43DD4A2CD6
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC662566CB;
	Sat, 10 May 2025 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kC1NV0bz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7F2550C6;
	Sat, 10 May 2025 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877864; cv=fail; b=Jly2EM8ewNhWHhNWcnr+83SUf+nD9aD5FgkvM+JFzf/tebEmzkd+IFqdnO2tgr54hnyphJJOoYOvwmj1UDSs6LKOQaBMcBMR6/8mzOlyE62dhQSAUJE2v8rtfvKqkqIYL/dfe3u62uYmhLy6j6XAY4ZY5GsgFSGuVhaOBtArSZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877864; c=relaxed/simple;
	bh=DTj6lqQHsxCR5zv4wabv3uEbv0umre/eUW8kJmvNSKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oi9M9oVgkC8qp8z6Z2DxUyTsxxHSsAyRRAng811Q+B9yN7sf6DAIQLyTs+OE2cmA5KiPtsH0pqpshTCSXEZPlUH+BgHR97wM0iLNRzobifOcsFkCmLL97uztFkcjAORGqXKoE/OZYfkXiVM3q9kZo49I8c0WpbFJfJTo2uSN0JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kC1NV0bz; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpQyS5flCGSOoXFeL5i3bMeDyYAY5SfV6HePyzZxNLgY24CfC9BC1EqUr1FQNz5bgI4OQxLlUW2obQ290ULjUnSNwJtN8PeDaL/MA42TKNxKDLX5SD5Rwl4ib+EMeufhrYuaUgLxxYIUgleIJpns576RXtjtDA2d+Mw2CA0N7S+l/BwMDqlBjbsZgOEz2HdEE3xkDNrZ3pnVkGw1Q9sbCsC8dViMKeGkXOuIUXB2ePbRIW4hMlXZCuudOXcUKvGPglo7bQ9zJpSUYZOkJh02iKjfPyIDF6zRDwb5c6PUeokNPZjRtlakOWKwih1U/sB+WkCU4QzNcoGy0ISERCiyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eGLboNYAwQm+fYp95xuEbYj30FXvd5HlCYQ/t/riC8=;
 b=Tdz1Y95auYuxaPJDQF/2E9gJi6yBPzMArx2cYspIvgjzpqqxLG62ftz8c452eMffMifm9Smo4LYzGu3iRHyLsk5o+f13dEGIfmP1VCtlvhVkDRMV00yuSaC67OO1n76iOO9HPApABZxX46yF+0liz3Fr7/+caJAe4+2OqD616EAwjB/53rEPQtLMuCnXmaB7o6uogRiwb0ugyjih04fwh3eVr0RVNjERjwF4olv+qrc2ABa+c7IHJQZKWGTAqv/MCagE6uYyDs41wMZtGJHu3b230l6Ws/IQaJoP4bvMortMk/zNN+H8e29z+eDsuaGCxjjsNTxVK8hjzlmbnCC9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eGLboNYAwQm+fYp95xuEbYj30FXvd5HlCYQ/t/riC8=;
 b=kC1NV0bzun4AI7EpShk3U1nfF3axfeHkXK0ehM6FzShxZpnip4EtQF1cz+paUuQpBiGLz4OksWNjwxtWe1LhoFKkdQ/BAQp/Xm4aZOeZyXEjJ5hTVFWyx2EYS5fFd82Tv/KZaw6dczf4ZmIsUgw+NacRfJxxFWcmHQ0328Q1SWig6SXfYZLtwO1X7oUh8iAxE480JtLWugrJVrjwbEGzmX0j9hVnuPpTg6SZQTMjk9w4gjpM6C5yHTjgLLxgzVY4hsZgT8d9Fa/o2XT2WrkUG9KDIaIVGkw2YrR9b4Xq6ti7WpJsTlE02bIMIVJZJZKVAADqqaiZbWqSYwH3wJOV2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Sat, 10 May
 2025 11:50:58 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Sat, 10 May 2025
 11:50:58 +0000
Message-ID: <54795a0e-e4ae-48e0-bcc8-7ec62f0ddabe@nvidia.com>
Date: Sat, 10 May 2025 12:50:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <22630663.EfDdHjke4D@rjwysocki.net>
 <c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com>
 <CAJZ5v0jWTtaQEcx0p+onU3eujgAJpF_V57wzZCuYv2NVnEb7VQ@mail.gmail.com>
 <7c970b02-7b58-4d15-b5f6-18bbfd883ccd@nvidia.com>
 <CAJZ5v0jcWQ3QKx=2nzDpnYPyGuYfT4TModwdAreWZu4d0hXmoA@mail.gmail.com>
 <CAJZ5v0jG+54uKiY-uSc6B+8JuA6eU1j8tGM5d=XsrT0EmabMeQ@mail.gmail.com>
 <563657c5-5529-45fd-96fa-bab68ca992a9@nvidia.com>
 <CAJZ5v0jVOG_u=F36aOVh=qu4Ef-5QFAmC+5-fmF_mU8NSr_LnA@mail.gmail.com>
 <b17469ee-0d8c-49ff-8fc8-a3c3cc9964dd@nvidia.com>
 <CAJZ5v0iv-+5Spz8hBn6dNTdmij6XULp+M=oc0kLM96aX+bSwBw@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0iv-+5Spz8hBn6dNTdmij6XULp+M=oc0kLM96aX+bSwBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: fc299e17-00bd-46ed-bd7d-08dd8fb8ed96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdFdG1OcHFaV3BJRUtuVVZnSGxFMFJ4MEdlK1dCM3Q4ZmZHK1kvN3d3R2xF?=
 =?utf-8?B?ZkFOOVBHdUZPRkdRdXJSeXRGUVhxSXgrVllCRVlOa21lQklaaUlKV2VaSENH?=
 =?utf-8?B?MFFDSm92WnJmMU9YYWt3ZXJHeTBucmpZL0JlUi9rbGo2amg4V2hRNjVtcE1I?=
 =?utf-8?B?N2Z4V0EvTnFlZldya1RhdG1OQjRYeHJmbU9WSTZ5TU5WQ3hGU0ljeDFyODhX?=
 =?utf-8?B?c0dmU2dSN05VVmNDVitlcTdMb0o5cUI0MkRDb0ZZQkY1VGxseWg4dE00NytC?=
 =?utf-8?B?eHFiNG1oNU0vQWcyVjdETC83c1NWeTQ2Z1l6QVpKQmNWYzNlWUVITnk0WFU0?=
 =?utf-8?B?eDNVOU5zUUJVOHlOOVJ4c2hhQ0NUSk10U2hkNGdxNWNac2JjaitzMEpVNjFT?=
 =?utf-8?B?ZnRCcXh3byswbEZtYXZhb2czUFV2T2dRWjl3djRRY09SVUtITTJ1SWVPNmxz?=
 =?utf-8?B?b1NpTnJBQ0MybitLWlFMVWE0c1BwVmYrWHJLcFpyeUMrRnBVRlpOR2I4Rnk4?=
 =?utf-8?B?bk9WM0F2QUorbFd4dlBTS0JtRnp5TDc1Q3dzQkgzSUl5aVNIN0ZxTlMrck1u?=
 =?utf-8?B?K3BVMDhQTU1UUDJZNkRZQmhyYnRCQkFURm1JU0lvQjgzdDczdm4vYlhRbTJY?=
 =?utf-8?B?dnJzaldNVC9rVFNlTG1PbGpJTmxVOTlDREUzcGNDRmJYbUVZallKb21DNENI?=
 =?utf-8?B?YkpRYnRjN2l3SmlQNUV3T3lSbWxPUUMrZWZnbGNzQURaWTNnRmE3WkIzbmNl?=
 =?utf-8?B?U0xYbEw1aTNUWk5Mb1hueEZoRHNVSkpPYURTR2JNRlhYZW9sVTd2Z3d1R3hM?=
 =?utf-8?B?ZnREeWtrYk4yOWVxVnJSeVlXOXg1OVN3enUrWStNS3ppQmJXK3BtVTA2VHlk?=
 =?utf-8?B?dnlzajh4VFQ5NWJ5UnVMakw2VytmVENzSnp3aUo1aEc1RGEwYU5USnVFUVlG?=
 =?utf-8?B?NVRtNml2S0czdzVXRi9PUUY4S2c4T2lOYTZiT094ZnJYSWRZZklRQmZML0U3?=
 =?utf-8?B?NUxpcVphUm5wdFFGcCs4T1g5TE9RMlZvaEtjUDh0bG1uVnlPOEY2RmU5WXJk?=
 =?utf-8?B?NnA1YWxkS3RvSG5jaUtSZ01rUjl6NDJmRXFVdFl0TEZWYWVXVVY4b0YvTDhp?=
 =?utf-8?B?b0xYekE5WFlva0lhaitDZHBrdjA2bnY1N0NGd3pXMUY0UzBKRisrTVZjcHZH?=
 =?utf-8?B?clJtUTNNSWJHMkk1b0U4WXdWaEhYSVNLbWdKZ1BOa2ZEY0g5T0hvck1LYUJz?=
 =?utf-8?B?RXk0TVpyWm1WaWEyTEx2WGFmNUE0aEcyVVNUKy9yZHdoUEcxaGVrVkx4Vmh6?=
 =?utf-8?B?cFdzY2lvS0dUY0lUV0Ivc0tRV01ZODZveFJvbjZTd0NaMHVmTmhOc0pock5V?=
 =?utf-8?B?S2EzeHBJb2pQNWw2NEMwSjNsUTBVLzExamc2WW5HVml6Z2M2NmMvbTc2TmhK?=
 =?utf-8?B?bjhTRkZMTzZmRkdLekswMmg0cWg0a1VOem5ZcXJoZ24vZ1ZPZi90ZysyR2NO?=
 =?utf-8?B?bVA0ellmRm4xYkh4d0ROZ3B2cTBBWVRNM09tbGlCWW5nd3RCcDZzK2pnQ3Nm?=
 =?utf-8?B?UEx2dXN5OGhnbjIrVHNUSFBqK3hPalBOVFZ2MnV0cHRmUHJiNnhXd04yMFNO?=
 =?utf-8?B?eWdiaEVOWjlLbDFlME1aRlBtVy90RjFGQlBQamZFR0dVSWtTaVVFOVZXaE85?=
 =?utf-8?B?M3hPdmdUcTBHZVVBK0NKalQrQVZaM0xnV2FPdGF4VFZYYjZoVEdsMk1Gd00z?=
 =?utf-8?B?VjFBbm1PVzVIM3hsRm4zV2huOWNUMkFKT0oyY1Qyckx2NlMyNnZ4QUgvNDFB?=
 =?utf-8?B?NHFMQkFrSGF4Y3RZWm5mbVRBeml0M3J5anpJMU1Udk54TFgzZzJkaXQxVzc1?=
 =?utf-8?B?bW5GekE2UTBUZnE5b0J6YThqSy92cTBJb09PeXpBYzIwZTcwbWU3bzRWYXc1?=
 =?utf-8?Q?hu0aCkbHJe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWFXelRKNWFVeC9rb2FXRlVHZEhQUXJXRnFZNWNXMEZHbEkzWmJYZXp0b3g5?=
 =?utf-8?B?U1ovR3VuZ2ozK00rajZOMGd4UWtrczdqaGhHWnQ4UXV4UldLRlFkaU8zRTdF?=
 =?utf-8?B?WXZvSklveTVvNmJYUkxsQmF2OGVqRDBwa1h6eWltb1k3UW5WbjhzVDlvMGFE?=
 =?utf-8?B?T2lEMzJ0VzZKWDFiSUNobTRlU2lsSzdqaStkMUN3MFJ0N2ozaXBORVl2dkxh?=
 =?utf-8?B?Vjlsc0tvTHBwYmZGRkFneFYyYm81NkRVU3diaTN3bXVRWit5REoxTlNWeTIx?=
 =?utf-8?B?cVVNbnNia0ZtdDcvdCtVc0R1cHFQeWxoSDcwN0ZCalVWWGxpTjBOQjRjR2tE?=
 =?utf-8?B?dk5uMkovSUFQN25aUHdUanV6WDE0bmNMc0dqMGZLY2E1UzBuZGZkQ0t4M0ZC?=
 =?utf-8?B?eW45bU5DMklDVjRua3Y5NW9zcE95SHJVNWx1UmR3N1BNL2xvWFVIZ2JhbEgv?=
 =?utf-8?B?bTBvMURqS2loTWNQejErcXM1aElONEo1ZlNQaXBkSUgxZVg0NXNSSkM2czgx?=
 =?utf-8?B?TUNhenFPSC9xcEJSaHFKUDJvekpDS0J2WVJxdDVPemZSbWVPUVZOK2xDL0pU?=
 =?utf-8?B?VjdZUFpzU1NaV1V5YU8wSWRSeUVyQ0dTSFhkU0JIYnB3RzV4YkV1MkJjTk9i?=
 =?utf-8?B?ejZ1ODN2cjA3ODdBN2VIb2xpTkpLbkxlY2NrWDdnaHcvQ3UybGZULzk4Qzgr?=
 =?utf-8?B?KzJtbUw0ZHM5NEU2Ym9aWlNjZVNHOWZkZHoyYzVhTEIwTCs3cmwxYVFJQ2ls?=
 =?utf-8?B?bitPMW5rR1BYWXFmWEFLYi9QVWZZSk11MVlhNFgwcHBrckE3dWJxd2I2UEZi?=
 =?utf-8?B?R1E2eVFUZXhDYlN5QXl6UU5lVjZyc3RzSlNsZjJUeHlQNmJETVQ3MXhjQW1j?=
 =?utf-8?B?TWhwaGR0TWl6QXF3b29ZZWxTOS9sOXE2Nkg0SEpRcDhLZXlvYkR5VXNtVUhm?=
 =?utf-8?B?OVhJUDdMaGtUTVNoTjdkdndWc2srQ3NSR2NjRHVxNWF1bEdodFFGeEE4TmtI?=
 =?utf-8?B?bFA4dUJuQzNSZGFEamtkaW5yUXliRnlwdWhMclU4cWQyZkwzQmt1OEczSVd3?=
 =?utf-8?B?cFU4ZGNmK2hvSFJiUmFySG1QRXFnWHpHcDR6eFVwVEdhS1hIR0ZTUjdDREZC?=
 =?utf-8?B?d0ZYcmgxL0hRYWI2SW5SVUd1aWtwbVA2WGtNYWlWQlNhazdoa1E1ZGpGYmdJ?=
 =?utf-8?B?RjdwUnh6UjY2TXBRcmQ4dHplZ2VUNTF6M1JRTE4vUmlPSnd3RFl6Wi9JUU9P?=
 =?utf-8?B?NEUwSlRJdjl3dWVUejdTSlRQbjQyVXVyb2lqV3QwTVEyNkFWdklsWkZYNUVW?=
 =?utf-8?B?bFhTc3dmUzRrYTc2QzJKalNpU2hSZXJrT3duZVEwQmczaEtFcmNMb1ovZmpP?=
 =?utf-8?B?RHJ3YlNiNEd3Zlk4RWt6ZWpFemVGWE9YUXUwOWg0OWwxTENvRUxRVnBUenBK?=
 =?utf-8?B?NjUzZTVtL0V3OUUwNlVVOWlQOThXVXFkWUk4cHZCNkxMZFpobGxPZjhzTDBB?=
 =?utf-8?B?MXRlRzI1WEdURldWRThPNjMreitrdkJsQjZ0S3ordTFMUXBLbUlob0NscFla?=
 =?utf-8?B?RGFydGRTS2hMUEUxSGFGVGdtM3g4a3E4U3pKR1N3Wk9VaHBQbkk3YjZUZ0pX?=
 =?utf-8?B?aExMN1RBNDFqSllKcGVPWWFTSEZKUm41cjRlS09VUFBVMi83Q1lIcVJUdy95?=
 =?utf-8?B?b3RJRkowZWk1SW1PRE9NUGhrV0JydllnN3c4MzBOeHZUWllCWFlpeDRmQUl0?=
 =?utf-8?B?VFBZejRabCtwOStJVFlETE85akNtYVkzbnFOeFNrY0gwWm5kUVNBSGx6VEVR?=
 =?utf-8?B?a2dlNHlBSCs2TnQvOUtZREZKd0JWMlJIWlhLWlJTczgyQkJIOXhiWDVQVkFP?=
 =?utf-8?B?OHlscnNZbk9sbm81TmM3R2VWKzNwdGZqR1gzampNTmFndEFkSzlIR2Y5QzVR?=
 =?utf-8?B?dXJUK2FYRm5GamxheUc5UlVjYURPbHpzZG1mNjEzcVM2RjBqeWM1T3ZydjJJ?=
 =?utf-8?B?eExzcDdoenVRTzdHd1J3Wi9iblIzVGhyUFFqVHNsWi9IalJ2Z1orKzZHK0J5?=
 =?utf-8?B?L1k0MVVKZWxBeVZ4ZlE3cFRIWlgrZ2tGaTZyTzd4anIrQkNsQ3l6TFJQWlpJ?=
 =?utf-8?B?QW5UOTRiTnBVOFF0dGhuOE42Yzk3WnFvbU1SNSs1V0NGZWJJVnFEbCs2ZU1K?=
 =?utf-8?Q?LLPfnctpJTthmzAuEJQtGh5doJsQq/7myUsRuZWPgWhD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc299e17-00bd-46ed-bd7d-08dd8fb8ed96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 11:50:58.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQQ1ogkQJgz/FR05hYoCjIr5PJ4DtfJSl7Ogg+evop1E+foz+u0BNYVDZyshc5miM01wf243/rAQZtHbWyizkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709


On 10/05/2025 12:39, Rafael J. Wysocki wrote:

...

>> If I make the following change then this does fix it ...
>>
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c
>> b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> index f01e4ef6619d..e9a9df1431af 100644
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
>> @@ -1483,6 +1483,8 @@ static int ucsi_ccg_probe(struct i2c_client *client)
>>
>>           i2c_set_clientdata(client, uc);
>>
>> +       device_disable_async_suspend(uc->dev);
>> +
>>           pm_runtime_set_active(uc->dev);
>>           pm_runtime_enable(uc->dev);
>>           pm_runtime_use_autosuspend(uc->dev);
>>
> 
> I'm going to pick up this patch for 6.16 and add a changelog to it, so
> please consider providing a Signed-off-by: tag for this change.

OK thanks! Yes, please add my ...

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


