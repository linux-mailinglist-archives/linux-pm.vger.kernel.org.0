Return-Path: <linux-pm+bounces-27187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD6AB7E31
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A8F07A6EC6
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB77297115;
	Thu, 15 May 2025 06:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elH0Hydm"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED1297107;
	Thu, 15 May 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747291326; cv=fail; b=bx7Qsy+TYyu9e6d5h1LRkZs0Kmzz8A0/E3qJS1WjEnOSAWUn9gVRlcBsCw+Hi9mIrrHuw1wI2TCYSMUzv3vIcRGrXz0XNB9PhzTfLffWBO1FNntx9gegC35+17qJciW40tp+0UF9h4U2ozuZxCc+IMu0Gr8Rw/OZkbcEz3mfZFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747291326; c=relaxed/simple;
	bh=LNOGqEkT2FjbuaAc4Zz/3zyfAWN6nYfDA3iPEatCxUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cPSbbknJXJfxAltDEdgtuSHX6CxzMKJkAHNT2c+dPOJjaMUqjZRt8J7zldjQdvGuxXcFgn7AtoWCr00XRLJdSij1SG2vPACoh1xZXlI7dYhsgRpDhVYBqgkzjzqZt9hj2cIjrvg7jKmNycs9/PUjADPVeIsHFBC/ho8gRpYoQdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elH0Hydm; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECVr4aHeISXa+dleqN7xIAjdKk2Hk4oC+GV6/HttiDAeSwRkTtHd4vsGUGulIcr9VlZ7+lmmmRXBMNsW3bmTcu+FUuA+RWDENQhfYLaAo2YGzHUUP5ayLb4wBdQk1s2XhHG7GcQ6H5y8DHUPbUP18xJmqA14LHknQLhHxAwNT3D12397ZsGi9WlEAa7I17ufHEjaMaGuc/sMfEWSTF5+/3eiDp+wB/N25Q7miccsQN2Vj/IM3ZaA8kw8WmqT8CeRApFAda9cSnJIp0D0zSDEjFk9LfR36WqRi0c1silQix4LyreXjqw4LN1e7zc9lwZRsirks1yvKjuGvvCyq4OkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+s1xVRC78udB7GULhLN3Aep8gzviczAWr8nbNFyDlg=;
 b=csHKfFNXuuiC2SwmBrKtg1BSrvLiRB290mRu29GmGG0167Wi2HyyK2MnIipP76Y6eNMm3vZlm8+HIDQIWqXOmsOF0ztKlyPCS5ghrbO8Wzp9xWgi6HZ0q60tXfwAn23F0dELFTnhmyZj6SecNdqBHTbpefcDzCaHgOD6lp3m53eT0pwLzhP5K9PXmtBlf4WnLhGd8kzEI1wcI83Umyq4HUm4kHa9cjKYuzGmNEPyByNf6sgVhNY4nKEsQkDWBD4JsB9JlKy5+IyMHHdFcbH3mSqWSObWZMTp8JGZxs9XpEzn8006byKhmGVJ2IYCQy4N3TYni0X2+NVFDWLkuWAldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+s1xVRC78udB7GULhLN3Aep8gzviczAWr8nbNFyDlg=;
 b=elH0HydmPBj0kqEuqw5jzGNrh3G7HgABSW6ZHiRIvIPGaq0OVmWP9zSkwZYZJlAFDA1UxqRGGHOByzGqO2W9IeguX41brvZUTdqyHajYxIJlAai7tNdxoPqqyTab6ZSg78wPgV4AI+AejU2UPN2ystrc4XeFLxyqUaAWATGduFiRn/V5L6bzmPu/drUZW7+4KxRQY9ZD8oEEOFgBtvnsn7ZRmFjBdoNMPcTU6pNbM0fSU/+fZX5e68ONCF3TBrtlTX1WrhE78tGLA6R64vjD1ShqSaZm6xCofHUOo2tJTR3ULsyMoGODETwzPTl74rzAAZA+Vx29wM7H4YDO3ECMZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 06:41:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:41:59 +0000
Message-ID: <bc0a4c75-df5b-4b4d-9c9e-a2c99d3f4f6e@nvidia.com>
Date: Thu, 15 May 2025 07:41:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cpufreq: tegra124: Allow building as a module
To: Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
 <20250508-tegra124-cpufreq-v4-2-d142bcbd0234@gmail.com>
 <cd801698-d7cf-4e9e-aa01-5525f8687ab0@nvidia.com>
 <CALHNRZ_9tMi5iihyTsEuU4T72=oTQM6-rVhqozzLf9DiB_TpcA@mail.gmail.com>
 <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CALHNRZ-pu9HUzVyR3-U=XZKFFZPnn5-DNLWPqPx6CSoW0dHMrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9259f7-6442-41af-1df0-08dd937b978f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lmQUM2a21pYS9MbnBGNnRtMkNOMGVTRGszNlltVWtQcUVBb2VTS0lTMGtn?=
 =?utf-8?B?djJaK0U5V0lDcmtPbDZ5Um8wNmgrc1JDbERoWmQvWG9zSy9qdTZwalYvcmpo?=
 =?utf-8?B?ckk4U0k1TGZEeEQ0UGZ5T3ZCa0lPdDVrOWt5N3lWdlVRVUFQeklzV2h4NE0v?=
 =?utf-8?B?WDMwc0p0aTZWYnpyamQzeG1zMzlYWThnVnYxRi9UVVd1QjRwT3BnUW5rWEtV?=
 =?utf-8?B?ZGs0T0lYQW4rVWlVa2p1K05UM2ZKaXhPU1FrQm95TVM0b2hnV3QyUldJWXhJ?=
 =?utf-8?B?eHBCNzBnQzVuUC9vSncwbHZOZlRXY0ZwcFFKczJXRFFueTl1UzRyczBJZjhH?=
 =?utf-8?B?K3VHUkxUcjNPSzFYMkZtSHZMRFJpNG51RGJtWHd6amhMalN0RGFNcHZRYm85?=
 =?utf-8?B?ZDk5SnJ2clBYa09SdUhPdDk4dTVCb0dFNE53QWxoZnd6dW16WFppVzVHWjBk?=
 =?utf-8?B?NCtSUVJ3YUV5K2tPZGUvWTJYRVI0SCtkazc1RldPYTRLQy9wTnpxVUFaaDg3?=
 =?utf-8?B?V0NhNUpMaWMwdWZnUGZtL0hkeitoOGxPQ0RuSXZVRWxGd1VzbSszWFVaNjZP?=
 =?utf-8?B?OEhlbk1VRTAyMjVXaTZOakpxYkw4TlVjNkluWDkvTmwzenplNG9ucExvWFdM?=
 =?utf-8?B?WHpKRmh1eTVkQnlQdWI0SnZaNjUzc3pUY0ZXN2pHNm55aVZxUEs0UzZXc3g1?=
 =?utf-8?B?Rkl4K282OFlhbFk0WmxzRm9xUS9pYjJMdG5TZ2M2ZVpLUnozQ0FySkxOdEho?=
 =?utf-8?B?RDltbExjVXZ6Nkl5N3Y1L083ZllTVTc4QzNkZDVnbnZpUi9wSWxIRSs1ZWJU?=
 =?utf-8?B?QjhTbTFvc1ZER3dIMVN1WmFJeGZVeVFMYUR0c2JMKzhIbXlyN2FDeGMwb2Fa?=
 =?utf-8?B?clh6SmlXZmhSb3Z2QStvWkdUWTcrcmEvT3ByelhJaElEQUhZaFZxTllrWFdJ?=
 =?utf-8?B?SzFQaS9aZ3hPcjEvelFPcGwzalJHUk92b215Yy94d0FXVWNMS0kyZi9FUXBi?=
 =?utf-8?B?L0srUm5VanpNN2ZIU0s5dTlyYjRyYjBLNVFhMW1MUXpUbHR2ZnFKaGdWTVpE?=
 =?utf-8?B?QmJ5dUx3MjREYWpDN1dZR3BkSStSWEVVcStNN2lPc0hUQ3I4dGR6QVZ0VHFS?=
 =?utf-8?B?SngyQkdyQ2RTNGVvR0prUDY0MzhnbVJmcmNzYVRxUkQrTmo3MUcrbDBBTTk0?=
 =?utf-8?B?ZmhXcWFUOXRLbUtHNW1HWlpNQkY2akxKWXZKNm5Tb1hCZmpmNStlQTJBMmFC?=
 =?utf-8?B?RllGUDh3K3g0Q1I3QkxzaENDcWxwWWQ4Uy9UeXJNYWJDTzUySXliQkpRcms1?=
 =?utf-8?B?SlZuOGZ6WjhoaHc1ZWxxT05FYnUyRVlhSWJxZWwyb0NCNkkrbEtNK0ZzeVFj?=
 =?utf-8?B?bHFkalJnWllMUHJ4OUliMUdydG54S29Fa2pITXh4b3laMFdtSlQrSGs1QlNm?=
 =?utf-8?B?bXNzOU85S1VIOU50Nmp2M21uaXhKNGVwMksvSzIwU1V0Ris2Yk83ZzZGTmth?=
 =?utf-8?B?L3hYS0g5WGRwdmt4V0dSUTdpaUFDTkF6MXVFL293d2dRb2Q2Q1VUTU9SZ3pt?=
 =?utf-8?B?KzZySGJSQSsrVTJmc202NjlmVjc4WnB5elJNbmN0OVVJNVFzeXBLM3I0a2pR?=
 =?utf-8?B?TXpWWjhzMjNzcXJKT1ZuM0hLTERjZzlSc3Q4ZkxudjFOUzhuRkV2R0kwZmI1?=
 =?utf-8?B?Q040ZXRJck05VFd0Ykx6S1Q4ejBIblNkN0JLTHZqZDFrTU5MUytpMjlaaHFT?=
 =?utf-8?B?QXpycEdlWnFSTEZOL25JUDlNTEF2R2ZCWGM2Qnh4bXo5MTJpMlI2K0k4aUtq?=
 =?utf-8?B?enBLUHB5M0pZNkxNQUxNbkhNS2h1dWZ4MHR5aWFQQjdnanF1VGduSU4vOWNO?=
 =?utf-8?B?cVJsSjBtWjJyem1tTDhsSGpUdHRldGZ1MDQyem1oaUI4M1JMU1hLM3NnY1Y5?=
 =?utf-8?Q?kO8vhcN5rIE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU5YSVhYVnUxbGF5U1RHYjgyV1pMZ3ZiZUQ3VG42NE5OdVdOdUhReUtzclk5?=
 =?utf-8?B?NnN1WVN5a3JIYUx2NVhDcVhXUkNDSXJwcTFzSkQxbmlGWkxSWW4vMlIyeW9O?=
 =?utf-8?B?U2wxOG0wb0dzNDNqeWRaZ3g3clJ3dWJoWWw3eFVjaW9rSjBOWVpKeW5sYmlQ?=
 =?utf-8?B?bkw4cUFLTCs0TmFUdVZEeEo0Q2ZLV3FBMTBTTTR4K3pzbCtZNTUyUDFwbHpO?=
 =?utf-8?B?TzB5cUNHN2J4d0xGTjcrUktmYkYzUXcvUWxQWUNyVG1LdHRLb2VFYWFySmhk?=
 =?utf-8?B?NlJLbHhHUnhkWEgyb2pKbnlyQnBLQnE2QWJPeWpxdjk0cjFYZ3hWaFdPR0dv?=
 =?utf-8?B?UGFpajJXOVl5b3k0VUZHa01SMCtSSmxuUWxpWE9yOVhQUDFoTW82RmhvVm01?=
 =?utf-8?B?QnRoM3ZheVhnd2JzTC8vRjlOcWNzeTlPNncxSEN3TnlySmtxbXNZbzJYZHk3?=
 =?utf-8?B?Q0h5NzdrK056T1lQRjM5Q3U5MStURml1eFNmckRxYUZ6eGtleUZZWVo5M05z?=
 =?utf-8?B?S1JZZzF1aFBVZDF0WExTOEo3RkdEbnQyUnFkSEl4cmU2UmdreUhWWDNVUmFC?=
 =?utf-8?B?ZEoxS0YzQWF5ZUpFYkxyaU1SYjgvZTBjVXFTWDFBREdtNHRaekZ5djVhbGti?=
 =?utf-8?B?T2ZNV3ByNmIvQ2FwWlJvOXIzbjZUa0Zha2NTM1pnTkNZZ2lRZmFWMkRtaU42?=
 =?utf-8?B?bHhpdVBtVDR2TzFCWk9ZZTVvMFdhdjlqY0lScStLQU5qZk5CY2ZqNFBVdWRH?=
 =?utf-8?B?WVl6VGhvekYxdEhjWjBmU0d3WlJodXFVS2FDdXlSU0ZsYjZycVZDU2xuMGVq?=
 =?utf-8?B?K0V6RWpOVXRzNCtPejV6U3hEY3kvOG51VHozb0JueUlzMGNkb1JlR0FHbUdU?=
 =?utf-8?B?NEY4amVxSEVCZkdvRFZ5YXpCTnpZVGViSFpUakV6VEp2YU1pRlZvWmV0clpT?=
 =?utf-8?B?MVEzYzNDNzFFUmo4ZmNORWdWSkFVRGhRckllRUxhaVdQQmdHeWszWkZPeSt5?=
 =?utf-8?B?QS9QOGc2UHJJYUVQOWx4Ukp0QnNmMllleFhPVXVVbFpBVDI0MnlZeis0bnBH?=
 =?utf-8?B?Y3FHU2g1UVlDWEk0QktUdWFvRFF6eFFaTHdjRXhOK3hpSmNRTkJQV1F2cEJr?=
 =?utf-8?B?OG9qRWRVWUMrVzZ5dVloSmw1UEhVTkVlS1ZmSFk4NXE3dGtZY25RTFhIOGFm?=
 =?utf-8?B?dVBWckg4a3R6K2ZsRWZveTk4MHZXNlgwZ0doc2hUR0VtR3JGNGRvNjcxa2RV?=
 =?utf-8?B?SmJ6cHNlZEk5Y2xMSk9kNHg5VW1BWmFicmxldTZRU1BoVCtnM3pNMEZjc2VJ?=
 =?utf-8?B?Z0ZhSlEyWTlTOHE2SkoxSmZJazM2Zmt2dlAzSmV1cHRiTFZ0eWlYUU9iSzda?=
 =?utf-8?B?aVpBKzI2V1ZiaHhlT3ZPR1JYSUFWM0JmVFJ0cHczT2JRWWEyM0RVZERjR3Zq?=
 =?utf-8?B?N0FuOWJEOTQyRkFQNkZTTTZEUFJuZWx5RXpGV2hubFIrQUVOenF6YUxpZ24x?=
 =?utf-8?B?VHAybytBUmZRbXMxaXdPOVg5V2tMODBhRnUvU29uUElGS21ZMG9kT2UyeEh4?=
 =?utf-8?B?YklPZ1ZBVHE0a1lVTUZTM3Q2YVRqS0p0VnlKcWFObFRmQWZ3YlltSG10WTRu?=
 =?utf-8?B?dHpQanpXRmE3UjM3dzVWNmw3U2NWUXYxL1NURE5GbzlzTGJuWEtqcXg2S1Vp?=
 =?utf-8?B?cjUxMERiZ3pQbGxHZ0theTNXekJOeWpJWnluVUxuOEkrN0tTRXN3R3FUZ2s3?=
 =?utf-8?B?ZUgvMm1WWXpCeDNPTGVFWHNTY2RRV21Iem9WeS9vSWpCS3E0SEl3NjFkcFRQ?=
 =?utf-8?B?bTdKWkc0eXdDL1l0WklJZWRBV1NRbVpqS3hJdWpIblRGbk02Y00xM0lxNU9a?=
 =?utf-8?B?NTc1Q3pTeGlZSGVKSDF4dFdWZWZJVFZoVlI0Nml4OWlxQTM0WE1YZ2hDNkNR?=
 =?utf-8?B?ZktsdHVHWHR6QWNOWjBSMlBjR1FnT0VxY1IrbG9XMlduMDdkcDlmdUE0eEY1?=
 =?utf-8?B?Qlk2MXBMamJibWxBbWlTU3FFbFliQ1BndU50SDcvMDA1bXlNY0l1NmN3RDdS?=
 =?utf-8?B?eEJYNmhydUg0NndRYnZnMWF3NmN5ejNtSWxSanNPWU9DeG5uZmU5RTVnSlFK?=
 =?utf-8?B?U1ptWDBmMDNuU0ExMURuTWZZTmtWZTdwWm05UmVtZ2lDWDM2d09aWWU1QWEy?=
 =?utf-8?B?SWtvRG13ajJqb3l1VWIraUh4amVPUlZ1bVF0NHg1V3lsd0V1em5pVTNlNE8x?=
 =?utf-8?B?LzlGZ3BiYW5EWWIwSHdRYTdQT013PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9259f7-6442-41af-1df0-08dd937b978f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:41:59.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WTK2cy/YaHRzsWe9gF5pDsAWstYfETQtDrjvStL7ztDi81Xv+jWGrS5sG4CichJqKWhBOrk9w1oKHOaKOc70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250


On 14/05/2025 17:43, Aaron Kling wrote:
> On Mon, May 12, 2025 at 11:26 PM Aaron Kling <webgeek1234@gmail.com> wrote:
>>
>> On Fri, May 9, 2025 at 8:38 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>>
>>>
>>> On 09/05/2025 01:04, Aaron Kling via B4 Relay wrote:
>>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>>
>>>> This requires three changes:
>>>> * A soft dependency on cpufreq-dt as this driver only handles power
>>>>     management and cpufreq-dt does the real operations
>>>
>>> Hmmm .. how is this handled for other drivers using the cpufreq-dt
>>> driver? I see the imx driver has a dependency on this.
>>
>> A hard dependency would likely make more sense here. I can update this
>> in a new revision. When I first set the soft dependency, I wasn't
>> certain how the driver worked, so I was trying to be less intrusive.
> 
> I remember why I added this soft dep now. The kconfig already has a
> dependency on cpufreq_dt. However, this driver doesn't call any
> functions directly in that driver. It just builds a platform device
> struct for it, then registers it. This results in depmod not requiring
> cpufreq_dt for tegra124_cpufreq. So I added the softdep to work around
> that, so modprobing tegra124_cpufreq by itself functions properly. Is
> there a better way to make depmod map this as needed?

Yes and that is understood. I see a few drivers calling ...

  platform_device_register_simple("cpufreq-dt", -1, NULL, 0);

One option, and I don't know if this would be acceptable, would be to 
add a new wrapper function in the cpufreq-dt driver for the above that 
other drivers could call and that would create the dependency you need.

Jon

-- 
nvpublic


