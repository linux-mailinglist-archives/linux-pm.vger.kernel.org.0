Return-Path: <linux-pm+bounces-32774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577CB2EE58
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936E37BEC6A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B642E339C;
	Thu, 21 Aug 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VFr/ZWwz"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126B2C11E0;
	Thu, 21 Aug 2025 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758366; cv=fail; b=cPMNLkx5j9AqwOe3MuTl0O89ZOgiaGx2ym8U1C668xQyhWsB5GvV/dhZ+m06PDONqrdYUFVvsAeEwtWjbFp+kVWJHCEPe03nJBJwtLSUcJzY5BXqB8z5nSjAx5nfJIOM3p3KA2ZsXSEQMFVZjAOZPKeZoY1ZZDyWgBJnO15vc7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758366; c=relaxed/simple;
	bh=43uiNaZn4+JJ57HgIXf/4yS3rPVVMWk4C80HSh8UMS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5WMsQEp9G4Oqs3Vn96EaSvCTbqLDWfnxBTHlzqY1sMIkkUC3CISJc9UX/R15LgxKTJxj4if+55tUXsZzJpdJaV7fcx4Pe041jEUXz7Sv68dmfePtiKf35HJYbKb/0ooeNJif1lBAZnWUYHbjK4Lv78oObulLUZgd5rGZUgTp38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VFr/ZWwz; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnzOiHJayIHmw9gxSquGOk9X78MXEPAlQSQ/ZLypFEKAtjy2N5SKMBB9MY72xngmw0u+JDYGm6cpzgXiLu3slTtBVsRfr08V+kijjjM08R3jMo9dQs9XgkNR18ddtETnIhNH8oe/Ls7FVqKTL+d+4vlMCg4e6+FA1fJ6Y/prFZHWuSD4QIK4Jr63jdSjLUGiAmHyqc+2Y1aeidyYkPZGMJwlXtzFahJLW0JYiCPdrD0zr+D3Q0GfEsNt7Rp2dNlSEBJtO8kMPCF1Joh2ITicvllAZEwi1YsznzgPqpWdXPe5hRFpY2C4XRJXHvBmolDBfT/sel6iUEMpl4eSVL93lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYmiwfLRtIG6+vy0ZRgRZWOjcts31vXZc2/piF5Egrs=;
 b=tD8fMrR4SJX2jR2xTqLXxePiEPUnHjCWjW9o6XdDET2digyjr2Qowk1CzY9pVTh2tUv+mgb0HtUofoTnLIq0ctGBVs0V4VUV263NwNmN0UUV3tZMqhw1TNpoQunDMhAiVTx07CJmJ6KapczeYhhpVYvp4HJVlAAX4MtrbrijnRhQrDaBkghOBF4As3hRbmotHJOkysHYCo22NXN5w9nyH04Tw3/zpUOA7DV+v+pw0Me5QbieZGRJWAKIQMRdbhkFd5UkUhxGRhmPcv8UTehEMfpdfMuJZKxspH8fRSHbY+AoGputNVspMRQ5TkjeTtAN6NoC3oqPV8vgfC9o6tfxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYmiwfLRtIG6+vy0ZRgRZWOjcts31vXZc2/piF5Egrs=;
 b=VFr/ZWwzX4IOQW0CIVPtEBO3xbqddrm3TrQPrA385BYA159IT26gFK7twfkk1TL2YP6CZ7SfT9In3aI0t1M62jd8dH+wT1KURcalkyGXAl5EsyCxzTz6b9WKb7647fcoFjm2b1lf/dotI1HZn9Cy+NTt2fR8nM+v5S+yn0PCkmUvrtb05q4hyWsuYpVn4qwmxs05NeupBiJPAkXQMlwbcBJpkCm8HWV+qvN4HZ7RNl5ObySMStP2fvWjEKLOeE8BAsJlMIs3xmOGK/zSwY12/QDYPDFZvvby3cOHpV/uZ8n/luzQuTlt22Hl2QLBo2LpHksAepHJSqJX0V+S1/6dpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 21 Aug
 2025 06:39:18 +0000
Received: from IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6]) by IA1PR12MB6484.namprd12.prod.outlook.com
 ([fe80::fb8b:583b:154:76f6%7]) with mapi id 15.20.9009.017; Thu, 21 Aug 2025
 06:39:17 +0000
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
 Re: [PATCH v3 4/6] dt-bindings: thermal: tegra: add Tegra114 soctherm header
Date: Thu, 21 Aug 2025 15:39:14 +0900
Message-ID: <4683661.LvFx2qVVIh@senjougahara>
In-Reply-To: <20250820114231.150441-5-clamor95@gmail.com>
References:
 <20250820114231.150441-1-clamor95@gmail.com>
 <20250820114231.150441-5-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0188.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::17) To IA1PR12MB6484.namprd12.prod.outlook.com
 (2603:10b6:208:3a7::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f418bbc-4709-4456-d6a0-08dde07d73f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFpnYUJqUnJZeUdodjJWdDRnS3dwczNOWVR3UDA4Z3ZGSzIvTkpjWERnbGpY?=
 =?utf-8?B?M25OZVEzbkEvQldmbytIaTdpVFBLSjl4MlJRb2gzUW41QVJTbk9NSTBDVDZj?=
 =?utf-8?B?c0pJdkkxZjV2U21jYVNBZGk2OElQU1VQeEhxWGV3RjV2V3c4WitON09Cb1Q5?=
 =?utf-8?B?a09lYVdIVkhaRXlWbHZOV29Vb0YyQlZoK0E5MXNpQktvaFBkMTFPVjlHTFFK?=
 =?utf-8?B?Ly8yVE8yYmU3c3pxS0RNQTh0cE8wOU1YeEEwTktyTkpDRURIR0QwbWtHeFYr?=
 =?utf-8?B?amJLZ0VSTVhPb0ZIZjlOblpTV2RmK0VwdDVSam14b1hNNVVOd21telhVTElY?=
 =?utf-8?B?bklwZDV3enhxMlhPb0tsRU9QMENLM2oxaXNPYUhFN1VUTEpQNEdSL3ZDSFNp?=
 =?utf-8?B?akV2bFAwcE9NbG9La0VJY0pJRXZKUEthVkRQbWtVV0pKVGRXdTFqU1BYL3ZQ?=
 =?utf-8?B?L2FXeGVXWHM5R3JaRU5icDhWQlZIZVlUWEJMdklweGRYN25qcWVYUUJxUS96?=
 =?utf-8?B?VnBGaUNkUmZwSmJtTExNVUxKSVluTy9zR0ZCeVlHK1dDc050cjl5TERuaVpp?=
 =?utf-8?B?Y1k0VDdhR3ZKLyt4RmN5bUtmbk1NVUdwSkE2cnlVTG5oN3JUb3gzTHNxQ2lv?=
 =?utf-8?B?MTk4bzN4YXZYOGdvNCt2czdjb3JGMmRDbGJkbWJCV25HZFliU0tkYmZzeE9u?=
 =?utf-8?B?WDlWeExXOW5VZ1F5VG9SNDJqd2Z5MEEyelhiQVRCcGxqTW9Kbi8zTUtWOSs3?=
 =?utf-8?B?R3dsZjRqMnREdXJLV0lUUnVWWW95am80MWF4LzFsWnZwaER1T2dub3p4UHpx?=
 =?utf-8?B?R09ubFBNNkx1U3lzSEtDQmN1TDEyNVJhUXFhTXpzeTFqNUY3Rm94SXNzKzlF?=
 =?utf-8?B?cEVFZjZRakhxOHBpN05hdXV2RS9RcGp1NTdEbk5zNEVvYmhod3VPRTdlWmo4?=
 =?utf-8?B?cFpiT1I3Y0Rvd2dqQXZYcTVodU9mNjdlNnFwWGpRVlp6YlVvK3RjOTFINmtw?=
 =?utf-8?B?WWlSbHlEZmI2RmNzUEx5cWFITmtTVUVVQk8xWjR2ZllXSXA4R0RtYmxTWnZr?=
 =?utf-8?B?ZS9PK0hlTlEvU2cvWkRWRTIrNWJtbXhUaUZuZHpiRlUxb0NBOE5DczVYWU5l?=
 =?utf-8?B?SFNDMkttbWhXSml2aG9KMkp2ZlhmVGZuNTN3QkZoMVo3RWVhM2pqYmQ3M0cy?=
 =?utf-8?B?U25IaFcxL2lXSHJ0aXZwVGZqdVhkVlN3emVRa0dQOHcvZGpHRHdRald1UE9G?=
 =?utf-8?B?UGxtTEJqWjhaQUZETkxsTUNMNEFCOXJDZ3QzSlVhRkpJUWRJMXNTTVoxdEhm?=
 =?utf-8?B?akgrZXYreENRL3ZUUERSa2ppalFSUEsxUE5oVXBBL3JaOThFN0kzTFBkQmQw?=
 =?utf-8?B?clE5VEFVU0xZTElLK1hXakFrUmtlb0ozcFhEa3AvMUNlWlVESFowVitEd0FR?=
 =?utf-8?B?MzVsZDFmSk41MFVmZSt3OU5IaXo2RW5yN25iOXcrY1piMEFqQUZEL0QvMWxS?=
 =?utf-8?B?TzFETExlanpObWVTZW0wQkI3Yk9WY2Q2aytiSXd4RTJrd2pib2dtdUt5cEpy?=
 =?utf-8?B?S0ExR3hYSzZhc29HaU1Gemcwck9QdE1rTkpCbTBkd0I5VTZ5d2RrU0IrbjZI?=
 =?utf-8?B?MmFJOFp1NXo1T2RZRjBBNHJvclJBRG5DRUcxc3dHOThLVXM4TVlTc0pWYnhH?=
 =?utf-8?B?SnpocWZQSFZFZlVvU0Nqd2VYdytLODVjMTR4MC95Q08vWHEyNWtHWW1yOGt5?=
 =?utf-8?B?aDkxSUxzQXI5N1ZwQSt6dzVJajV0ZzhhYzZ5aGcvcjlac3k5eXJjQzVvbnl3?=
 =?utf-8?B?SFFEcFgxaUJIRVI5VU44UkJURWR4ZjNDeHV1Z0plSHZQanRIY0lHVTBMbXoy?=
 =?utf-8?B?bTZqbkwydno2eGdFalJaQVFrQmJaQTc4VUUrVkZLa1QraHVEbk4wSnZlUyt3?=
 =?utf-8?B?Vm41M0hBZkxpeE9FWnZZa09NdnBSQzhpQ2owSzQ3TktuNUlncGk4MEErRjYy?=
 =?utf-8?B?TXJidHc0UmNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6484.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bStLcmI0eEJlNWVzVEhobTZyYW1XQzk5YzBUcVdtbytGUzJ2UFhlcTdCbzhK?=
 =?utf-8?B?UTF5TlFIK3V6Q3VUMEhZVGhrUkhWWmZFUjh1TzhXUC80MnMyNFBuUVRKeTF2?=
 =?utf-8?B?SVdGTWtTL2duaHk0b2o3dUFPVm9wQkFvRU5kMEFNU2p5RnFuQVZCUEZXOGt5?=
 =?utf-8?B?UmdxeWN6LzhqV3g0VkNqUmgzMEE0QlR1SGJGNElubDh0c0xYVDlySUgyR2E0?=
 =?utf-8?B?WFMvem8rSDJNci84SDBtMWw2VnhvR09HemhHN2hmZUNLZFNCZGhmVSs4V1pY?=
 =?utf-8?B?TzFaakhIT21OQS8vQWRkRkxnVFpUdjZhdjRPWEJRSnVWV3pZR3FZbCtIUUhN?=
 =?utf-8?B?Yll5Q0lzdW5ETTNIRmdZZEpzaFg4amdiWUtJUytoVGJndjhCbUdqRmFubG1B?=
 =?utf-8?B?T1UrYXF0QXgvM29MNkpUVm00cUhidVRiWnhjOFgvOEJ3eW9EaUxtdEZBQ1lq?=
 =?utf-8?B?VHRlN3hsN0xpcEE2SnM1YWMxaDZEaWcxTk5ubzNGcWJETTM4TW1XRmJXSEd2?=
 =?utf-8?B?UnRnUURkL1o4Z3J0Y0VKSWdPdlBkOVZaTUsrenFjQ20vRHpTZ0tKWWhobmZx?=
 =?utf-8?B?SVNqVmJDQzg2V2dDa1pBRlBUS2Z6UEtuL1pOZU1SQUFlZzc1eFprUmNjQURV?=
 =?utf-8?B?emVoZTQvOWR4bzRSc0RWelNRc3pVRTZoVzFVeGZWRkFvQk9GaFUrTENQWHNn?=
 =?utf-8?B?N1Q2OVZFUHdPM3RBRGpIOExtcURVRlRlSWJwVjROZzZJTGVYNVdETGlqRXRT?=
 =?utf-8?B?YnovUGM2cHFiNE1LcDM5dlR5NnFXVVdVZDdvWnJUeCtDN2o3dkwxaWMzblY2?=
 =?utf-8?B?M2hhYXhsaUtJZlJKSzg3QmNCb1dDb1cyZUpISHJGNVM0WjBVTHF0dVRiZTBD?=
 =?utf-8?B?WW9KQTd4K3NQenNYTWMvTmppcFhDWjBwSWNaZnI1UGIvRmJxK2pvTmZTaWtE?=
 =?utf-8?B?dFJndWc5cTd4RUtBdXlWZTE0N0cyVTNZRTZPREFBaW9kRXVLZVFLSGtuWkdZ?=
 =?utf-8?B?RGJCWWN5M3JPTkMvLzNjZUMxNk1vVWpFMGMwMmdlakFRUUE3c2pmMnJTdjJ4?=
 =?utf-8?B?d2xVNm5DTjYrTDZIRHlTSXZobnlmUGxJcUo3T0NjNUphQXNRV0tWOWlkUVNu?=
 =?utf-8?B?d1hrV1RTWUZnVDE5bU5CR29kQ3NUYmJ4RHg5MG0xekZtU0I1ZVE5S3haejRm?=
 =?utf-8?B?UENadU5RdlVDV2VyVUNkS3VBR240VHJDWjNvd3V0MG1FRnpxV3RsNGQ0VWZJ?=
 =?utf-8?B?U1FaQklxcnc0M085V3cydXdRQml6VERGNlliNDVjbkI4ZlVaaElDUUVEL1E4?=
 =?utf-8?B?elQyeC9IMTljUUlKV2lLRFA3NTUrZEE0Q3ZERlVSSU9TcUI0MW8xbThzTFlB?=
 =?utf-8?B?SGVLOHh1NCsveE9lOXV2OHUyajE0Yy81L3Y4MTVoUk93R2JOczFNdHRRQTVp?=
 =?utf-8?B?UnN2UG1sMmxMbFRjN3dUQ25kZjMyeWFhMW56ZG9kYmVVMm9CNkI1anNyV0VD?=
 =?utf-8?B?em9vTVhZL2NTaFV6UFhHdVNrRWJLZC9Cb0d6ODNJRHJGcTlLalViTkNvK0Zz?=
 =?utf-8?B?TUYrSDREWVlpVXFYbXRETnZ1VTNCRDZXdi9QQWF5MWx2eXFPcjFuZUNZV29z?=
 =?utf-8?B?ekJ5Ty9kS1VNNXhiNklpYW9jcGg5NWt4TDUrMnhRZDVwNlUwdENlVTRwVFF1?=
 =?utf-8?B?ejlzajhYb2I2VHBPbHJOY1crTDhOc0h2WUdTV1d4MTRITzZtN1c0R3NobTB3?=
 =?utf-8?B?SjlEMXEyZE9FUGlvZEVwVFI4NHp3RzFFeW1waG91eEgzMUkzeGI5VFkxL0VC?=
 =?utf-8?B?Y3MxVk5vQTNPZEpWWk5BTDRQOXhnQlllRDEyNFF5SWNqNmJDWEdDWWFIekY1?=
 =?utf-8?B?R3MvRkpHeERONUNOV0JVUzNMOWRNUzB3NTdzS0NiQzJMK25HbUdmWlBRSjV6?=
 =?utf-8?B?VWIvV2s4Nk4vWDdMWkVxbDBMa3JmZSt4dnh5ODFQTm5KeGFYVER0WnBDeUJh?=
 =?utf-8?B?enVhYnVDendIN2ZDbnByZWFIbE9JcVhvd0gxdGxhN2x5dzhKRDFxd0pZMDVB?=
 =?utf-8?B?SkRUMStsb1hhd3c0d3pTbUt5a3ZjMGo5ZFBQbTljM3JlcEQvcUZ3enlqRENR?=
 =?utf-8?B?SGdKQnMvYWxDOTVEOWdSYkN2TDUwL05YN2tMWlBjdHI0RS80cER0YjE5a0ps?=
 =?utf-8?B?OGRCUk4rano2Y0ZzVEllVHhMZjRpYUpCay9xWURHV21KUmx4UE1ycldwTW1a?=
 =?utf-8?B?OUhTMkN3dDdHbVU3N2VJdmRQeDhRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f418bbc-4709-4456-d6a0-08dde07d73f5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6484.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:39:17.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaMJLeEhV/6pBJkxfopfer3S2UvLKy5gTfjhjyjXhJQzVHRbqT+XdRNvreiwB6iPF2ZEy4QqaNv0K2+WT0uDvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589

On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> This adds header for the Tegra114 SOCTHERM device tree node.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../dt-bindings/thermal/tegra114-soctherm.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
>=20
> diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h
> b/include/dt-bindings/thermal/tegra114-soctherm.h new file mode 100644
> index 000000000000..b605e53284fe
> --- /dev/null
> +++ b/include/dt-bindings/thermal/tegra114-soctherm.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * This header provides constants for binding nvidia,tegra114-soctherm.
> + */
> +
> +#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> +
> +#define TEGRA114_SOCTHERM_SENSOR_CPU 0
> +#define TEGRA114_SOCTHERM_SENSOR_MEM 1
> +#define TEGRA114_SOCTHERM_SENSOR_GPU 2
> +#define TEGRA114_SOCTHERM_SENSOR_PLLX 3
> +#define TEGRA114_SOCTHERM_SENSOR_NUM 4
> +
> +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
> +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
> +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
> +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3

Please use the TEGRA114 prefix for these as well. I see that it's missing i=
n=20
the Tegra124 header, which is unfortunate.

> +
> +#endif





