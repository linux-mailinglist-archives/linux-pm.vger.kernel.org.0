Return-Path: <linux-pm+bounces-15630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0EC99D7A2
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 21:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08221F2376B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8711C2DB0;
	Mon, 14 Oct 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b9ya3xi+"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A62140E34;
	Mon, 14 Oct 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935214; cv=fail; b=Xp3OKrQl2dwcKApj6NiyHYgdj5bQWf9pM7iFBw+OUwXj01liUXp1y0zEa9loVLAMPTuOuQktUlc/SJy9boEoF+2uSQfJEkGg4FtJAB4LxepAtoXNcoAQZL6RhsVNIHl+3OI9UZcTkYJYbe/TS8fMn9s+eUvciCyE6CUqmr8yWnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935214; c=relaxed/simple;
	bh=TIlb2BptVqHL5a1bs8CNBNwcgO9hQ+JY1Bog+IjXHq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=POAjVtsNWc+BER7v5zqcr4/PV7zsjsf4RTeoEVc8GFNMO4WkeDCfH5GnPIc41DEp1ESbv41UbXZy4xtMy9IXaIC712jCV3MJg3o2lLMKkC4hoPw6N1H4rJezUBZSmwwpVxsoTRGGGucLP7CinpNhOpzDj8+wiRr9l/GDkKKTP80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b9ya3xi+; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhnVGkElR3CSKTAZrq/qMggJ34xnxX6pCbwjmFrAzOzX9bMKWWC36SkCYHFwsQpaOGuMiPCmozmWQ+izHi95OTbGD281xYAcyBiNczVSKA4MCss3F79L03BN1FNeQNqB43JSG/3I5tw+nkPDk1rXb8fJlnRNkz+6x1PxGhQkyFem4jFtQ/cmBiellDo8Ab4LG9hDjF9/0lRW+lL1lbwqACD21xsYe47CWPFP+rRptTgCNU/4ee4r2FyKPPBRWPXJlTx1Cf1QZyJh+j2euZdspH5DZVCQ7sdXXhgJTo7xiZoQJV4y35dQCZhBPnQQYEbfaPT6G+hcM1wIBBcf8735Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzz+PY2W80D4PkTITg+SHKC2IIuBgaYZfvUNO1mJeqA=;
 b=SVix2jel/HHNnbL1bnWLmmOcbVMR8NzwBKCQKBVVvXMXmP1xABKHIDQxxLKEXbTGPhDDZlqJMQN1R5AFekt0w62xWLhRLT0OInG+fA8odkEiYvcC1P0MvC6Dx2/q7aPspr5lfXml1FezzfDjYxNmsqPkq+VT10V3FBOV5+5O8qO1arXM3AArk1EcZ1iKpWCP4oDph4jTJ/zAzPBhTozHOdM14ly653pRxMLMWfCptwv0URsslArBLw/piWa1NYGK3kKQnbhQf9kDp93uBwJ32uPlk7cP4lvWFCpsalmB8fGYqzev99zCcfY6yfhT22bQKPfGCzFtam6TsNMbK+C1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzz+PY2W80D4PkTITg+SHKC2IIuBgaYZfvUNO1mJeqA=;
 b=b9ya3xi+9Rge9av5x1agBG7u4cf/MTalKz43iqrVQ2PtLhe2tzGy2TlEpJMMI/hgqGQ2ugQKdPre11uzuIqDmUnrw7RnY8NVZOuP05t1g9D6oUTMi6LIxRPd5XTxxF8XlWQjQ55k11SjdcCYRj+D6bqtjub6rA44JAZHdTb0Myc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 19:46:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 19:46:49 +0000
Message-ID: <3aaa5dae-48d7-4562-8735-a96abda92df4@amd.com>
Date: Mon, 14 Oct 2024 14:46:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
 <f655d71c-7995-bf6b-7ef6-7939f1d609a4@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f655d71c-7995-bf6b-7ef6-7939f1d609a4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:806:6e::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 1201d031-3dcb-4dc0-cceb-08dcec88f19d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODI4YnV6RGNNOUc0YWhGelRDUWtKS3pFWHN6eFdia0tWSktxQk1hMUtyT1hu?=
 =?utf-8?B?U1pxY1VUSDh5VVRTRERBSUNsTTF5NkhTZzJhdFc3bjhFcjE0MG4rVDFHdmtN?=
 =?utf-8?B?ckNiTTZaeGtTbzYvQWtUcWV3dTl2SHczZDFielZQZDc3VHhYS0J0SGNkMDdt?=
 =?utf-8?B?dUVScjZVRmFGNFd2SUV5SzNGUWNlR2lTWG5GSjc0SDRlL01WWjA5N1c5WjVh?=
 =?utf-8?B?dHJNOUkwNHVHeW5vc1p2bVFjRTNBczdBSkVBOU1LNVBLNjFQSDIvMFdzNDR5?=
 =?utf-8?B?eG1SdTF3NmNpeGpYOFpPVUJtOTV0M3FuaUVGUlBBVFNjbDhXTTM0Q0ZQdGFR?=
 =?utf-8?B?T1hYRnBGeDBMZlhYdWZpWWFzSEFCUjRYTWFGWmJQeVBCa2w2V3U0UnB1a3RD?=
 =?utf-8?B?bk91YVRFSHhTVTF3Tm9MZk40TnNvelpyWFdKbEdZcEFib241bjB5bDhhbi9w?=
 =?utf-8?B?ZVUyc3FRaHZvSWoxSEY2Ti8vcmRWaVNBVUdsc29FcjVUenZuZDI3ZkJScU9a?=
 =?utf-8?B?SzB4MzNta3Y1ZThYdUhZRVlETzNWWEZQUlZUYUpIZVE1dlRyWitHSXBIaXhT?=
 =?utf-8?B?QlRkZDFockthdmxaNkdiLytjeGRRZ1VTRzc5OEhCQW1PYmwrK0VMelhvdHZn?=
 =?utf-8?B?WGNQbW1JZENUMlA4YlJZNmduaExhT0dwRjg3R1BtQ1dHSHlnemFQN0ZGZURK?=
 =?utf-8?B?M2tHT3F1c2RhYWs5MlI4ZWtHR3MvUU9HakJZc0JmSzZJeWdkUVIwbzV3bFp4?=
 =?utf-8?B?V295QXRtUG9tZjdvbVkvOCt6c1EyY2tTMk96VnpSVEh3NEJ6OGthQklYMUpx?=
 =?utf-8?B?UUZ2UkpTQ1dxMmFjWnQrWTk5M2RqY2xSVmhGaDJaZlRQTkJYN1ZUcGVOWkVN?=
 =?utf-8?B?bUJ2UGt6bWp3MUhQZVhRQy95YkNpcjFkVlJqT2x3S0cxaXlwUWtqaGdrY3pw?=
 =?utf-8?B?STlXWTk0a2RYN2N1YU9zTWVWRVM1UEkvTEVqV0wrcVpCbUxrWUZrcFFXWmU5?=
 =?utf-8?B?VlNaaC8rd28vVkp2YTc5SnlIamFzdzdlTUlpVzIxNHlQOEkyM1l0ZlZnTmow?=
 =?utf-8?B?N1RKQUVrOFBLOVVMWXdaejFyTlkxb0ZkZkhEdG9CaVVwVDdLK09CdE9yZzM5?=
 =?utf-8?B?QkM2MmZPVVk4ck9xMlJBeW9jSm1PN1RHdGZzMVdZUDV4NHd4Rzg3SWs3aEpz?=
 =?utf-8?B?WTExN0R4ZTY3YmVYaXQ5THBzalNDQTkzYUtWNTIzcUtIZXloZHNmdmhoZm5X?=
 =?utf-8?B?RjBBWEVSQ3lTTXJtWFY4N0RZOTZQdnpXTFNScFdiQ0c5OEc3eUJmZW5QTjQ4?=
 =?utf-8?B?RGloU2I5cFdqSENWVDNPRVE0bUhvM2RvZnVJWFF2K3lzRXpmTllYQnhjTm5i?=
 =?utf-8?B?NXU1WTFVWUpGa3R1cUhLVGFPZlN5WkEwelR3VCtQbjNaOXNIUUs4LzJuWGYy?=
 =?utf-8?B?RjZTK0NYS21WOWdONENxOXRSUnlySGNxaktjeGVKdCt0MXpUYzEvTlFFdFk5?=
 =?utf-8?B?ZUlHVzZvYVppUUw1OTNRNDc0WjI5UlRaRndrWFJqN2ljeklIZlQrRDFmOXBt?=
 =?utf-8?B?dktvdHVDQXVwS0c0TUk2Q1g0RHo2Rmx3eFZvRnB4a3RZNzlJbzlnYTFoU2xB?=
 =?utf-8?B?NUN1d0RJci9DM3dUbEhUUHBhNGZEajVSZXBkMWhoMXZZMzg3NmxDSndPTnEw?=
 =?utf-8?B?VGxvYmFCTWVONHgyRXZqVkkwRWtTRmVlc09vNGFDaTI4enJkb3pKeU5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBWT3dkQUQrMnp1SnpScVVVZk5GeWRiakhSbGdEelRkN3hweXhNYVV1MCt0?=
 =?utf-8?B?d2lRaUpQVWJlVnpEMytnRE5hUEdiRHh1WW5obGEwVjJGVXhJaTNiZEQ2a2Fh?=
 =?utf-8?B?WUt3aUtINUZLOCtubjBzTlNnT2ttRVdmVU12c2dTSDlJZXNEK3luelg0bktt?=
 =?utf-8?B?cS9FMHcvM3NBcktHOUtGd2Evc3hNbEdCN2o0UkpHcjIzWU92ckhDRFRWQzNw?=
 =?utf-8?B?cjIrc1VmVFh6bzNvUE1FY2dKWnBleWVuMjVjeWtPQXpNalpCcWtmMW9Sd0R2?=
 =?utf-8?B?dHdVSE91a2hJa29NTHRyS21tSm1RSU5OMVdQM2NUMzJMYnBRbm1DcUpaOFl3?=
 =?utf-8?B?WGpOVzVkM2ZZMVRrc3ZNaEZ1Mm1ZT3dpM2FGaEZJWlA3U1VlM3greFhDVllO?=
 =?utf-8?B?b3V0ZlVqcjJNOE1oSVZnMkxPU1VsNlYxbHNFVmp3ZHUzVkV3RWhsTUNFSDRO?=
 =?utf-8?B?cjhjSUk0N2xoZndyaHFwOHhpTGJRMUxnWlhxWW1RY1Q5V2QyWEZsMmw2TDZD?=
 =?utf-8?B?K3pSZzNlYjJ4aHR6eGVmbDJiU0FPdUVwUU1xWnZpbG05bWZEU25wYVArVWlV?=
 =?utf-8?B?b3FRTHhVc2IrQUhsK1JaV3V4d3VCRURJUTUxYXdNSjVPVHpTQUdpV010SFBW?=
 =?utf-8?B?WUo4cFY5VjNUQkY2ZmJFRzlLVlg1TlNoeG1Rb3p6Zm1xS3FIamFKSXBSb29t?=
 =?utf-8?B?VUF5NktJNERRVFl2UXBwTFRIUkNFRXZTK1lVQzZIcUM5bVhDUW1HVXkvbkE2?=
 =?utf-8?B?M3VZcTZUTE0yUUdKMkpIWHVYT3hsNm5kekJmVlZKK1M1S21nRlVmZGl1R2g3?=
 =?utf-8?B?NHpia3lnekdjTng4T3ZKTTFVOFZDaHlRbi9NVkFzK0I5cEFHUVZaRGNvd3Rw?=
 =?utf-8?B?b0hxYlJ2N05nZnV0amFGalhHeERvZFdPb3hjSUNqTDVHZFpWK1FwNHhHQk1n?=
 =?utf-8?B?aTNhbDFHZXZPTm43TGZMVTdaRVAwbzVLSDVoUzNNemlSZVI0Q0hXeU5BdVpr?=
 =?utf-8?B?SXZoclpROU9KM0hBVVJlb3psTnVVV0QzemZZVmUycEZ1R3FxVzA1Tldwa082?=
 =?utf-8?B?ekFITVNVaTZGT2JhMDUwZzNDdVZGQStaQzltZ1hQbkRBcVUyTHlkMXhEY0V6?=
 =?utf-8?B?K1NSQnFydjRTOGFPWmtTUGNIN2ZBK2RrKzFzUXRjTGlGN2dDOFhxMUFOQkNm?=
 =?utf-8?B?Tzg2SElWUU9wbFZCbXBQNmZMaUJJSXZiOGJ3OUxkcUFISUgvNTRqNGRqNUpM?=
 =?utf-8?B?SEdFcmNIcFRUMHoyYjE3NlBIVUtJMjk5UWZpVlAwZ0lXRXZwWjdPY2ZUUXZU?=
 =?utf-8?B?RTJCNWcyd2Q4eGxEYWYwZVpXY3dIVzlzMzRsKytML0diNCt0dzJuU1YrTUsz?=
 =?utf-8?B?elVUVlgySk5zVDRDdlpTQmdjRG9uS0o0U1A2Z3VmK3ArQmV0R2NIa1BBZkhv?=
 =?utf-8?B?YTh3cWM3ZGRIcEVvSFNHTE4vOWwyNzZRMG51SzMzc2lTWlYzSGFHYmRJcXVk?=
 =?utf-8?B?ME9tUzhzcHNaNlJKU0JnakRWUmJ2d01xWlhTeUtLa0JTZjdxTGVadUdQaGVF?=
 =?utf-8?B?OHFhbm5KbjQ3ZzhocDJONi9jaktQWnhmck1EZEkzQ1Y5enc4Ymk3OEYwNndQ?=
 =?utf-8?B?bXRNRTNRTXVETnBheitqK0RvRmtYR3daQUxCbFZHWHR5RHZPQVBPQnp5bXo4?=
 =?utf-8?B?OU5vNHVQWFV3eXlsUmJWQUpWZWdSQ0dzMkZUWHlXdVV0SG0rMmgvMVowK3hC?=
 =?utf-8?B?aXJVV3U2RGxidkJWbXJUQXVzekprMGgrUVdVYTU0T1Q1WEhTWExKTzNmNkpo?=
 =?utf-8?B?Q0FVN0NVVXIvdVVLR3BjT1ZpKzV4M2IydmpRdExHMkxSb1F4aE9ESUFJc0Rv?=
 =?utf-8?B?ODZMK0U1NVU3WDZ3bEdIQ2puQS81MDZEQTVHUklIMFVwUjFiWGtFTkNjU0ND?=
 =?utf-8?B?T3VyS0NTYThwOGpsRkRaTzdFZHFNOGc0RXZZUUJQNDhLTnBPYkNVUGhIbzVi?=
 =?utf-8?B?ZERPcjh3WXZtaEVmTDZualJxNThWK3BsdzhDNEFaMDdmUnBCekc3cTVCcHhn?=
 =?utf-8?B?bkdhZGtoQzdJTjJEM01laDBNMWdtK0tHSzRuZWxxdUFTbmtOTDA5bUZDTVg2?=
 =?utf-8?Q?xJYdCqaw09kan5uK4N+UFXlnC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1201d031-3dcb-4dc0-cceb-08dcec88f19d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 19:46:49.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2bIHkRkC4ZU5m8XW2JG1XYdnsNVdI2iOFaNXBzh/hMcUzZ/L9MbIKYhiNqSU/x5NkwJN5UHsgFSN8yKoNLN1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522

On 10/14/2024 04:10, Ilpo Järvinen wrote:
> On Thu, 10 Oct 2024, Mario Limonciello wrote:
> 
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
>> provide behavioral classification and a dynamically updated ranking table
>> for the scheduler to use when choosing cores for tasks.
>>
>> There are two CPU core types defined: `Classic Core` and `Dense Core`.
>> "Classic" cores are the standard performance cores, while "Dense" cores
>> are optimized for area and efficiency.
>>
>> Heterogeneous compute refers to CPU implementations that are comprised
>> of more than one architectural class, each with two capabilities. This
>> means each CPU reports two separate capabilities: "perf" and "eff".
>>
>> Each capability lists all core ranking numbers between 0 and 255, where
>> a higher number represents a higher capability.
>>
>> Heterogeneous systems can also extend to more than two architectural
>> classes.
>>
>> The purpose of the scheduling feedback mechanism is to provide information
>> to the operating system scheduler in real time, allowing the scheduler to
>> direct threads to the optimal core during task scheduling.
>>
>> All core ranking data are provided by the BIOS via a shared memory ranking
>> table, which the driver reads and uses to update core capabilities to the
>> scheduler. When the hardware updates the table, it generates a platform
>> interrupt to notify the OS to read the new ranking table.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Drop unnecessary select
>>   * Make tristate instead of bool
>>   * Drop error messages
>>   * Drop unnecessary function declarations for init
>>   * Fix cleanup for amd_hfi_exit()
>>   * Drop unnecessary variables for upcoming features
>> ---
>>   drivers/platform/x86/amd/Kconfig      |   1 +
>>   drivers/platform/x86/amd/Makefile     |   1 +
>>   drivers/platform/x86/amd/hfi/Kconfig  |  20 +++
>>   drivers/platform/x86/amd/hfi/Makefile |   7 ++
>>   drivers/platform/x86/amd/hfi/hfi.c    | 169 ++++++++++++++++++++++++++
>>   5 files changed, 198 insertions(+)
>>   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>>   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>>   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
>>
>> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
>> index f88682d36447..c3f69dbe3037 100644
>> --- a/drivers/platform/x86/amd/Kconfig
>> +++ b/drivers/platform/x86/amd/Kconfig
>> @@ -5,6 +5,7 @@
>>   
>>   source "drivers/platform/x86/amd/pmf/Kconfig"
>>   source "drivers/platform/x86/amd/pmc/Kconfig"
>> +source "drivers/platform/x86/amd/hfi/Kconfig"
>>   
>>   config AMD_HSMP
>>   	tristate "AMD HSMP Driver"
>> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
>> index dcec0a46f8af..2676fc81fee5 100644
>> --- a/drivers/platform/x86/amd/Makefile
>> +++ b/drivers/platform/x86/amd/Makefile
>> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>>   obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>>   obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
>> +obj-$(CONFIG_AMD_HFI)		+= hfi/
>> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
>> new file mode 100644
>> index 000000000000..08051cd4f74d
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Kconfig
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +config AMD_HFI
>> +	bool "AMD Hetero Core Hardware Feedback Driver"
>> +	depends on ACPI
>> +	depends on CPU_SUP_AMD
>> +	help
>> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
>> +	 selected, hardware provides runtime thread classification guidance to the operating system
>> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
>> +	 These capabilities may vary due to the inherent differences in the core types and can
>> +	 also change as a result of variations in the operating conditions of the system such
>> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
>> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
>> +	 resource allocation, leveraging the diverse set of cores available.
>> +
>> +
>> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
>> new file mode 100644
>> index 000000000000..672c6ac106e9
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# AMD Hardware Feedback Interface Driver
>> +#
>> +
>> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
>> +amd_hfi-objs := hfi.o
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> new file mode 100644
>> index 000000000000..da2e667107e8
>> --- /dev/null
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Hardware Feedback Interface Driver
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
>> + *
>> + * Author: Perry Yuan <Perry.Yuan@amd.com>
>> + *
> 
> Extra line.
> 
>> + */
>> +
>> +#define pr_fmt(fmt)  "amd-hfi: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cpu.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/gfp.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/printk.h>
>> +#include <linux/smp.h>
>> +#include <linux/string.h>
>> +
>> +#define AMD_HFI_DRIVER		"amd_hfi"
>> +#define AMD_HETERO_CPUID_27	0x80000027
>> +static struct platform_device *device;
>> +
>> +struct amd_hfi_data {
>> +	const char	*name;
>> +	struct device	*dev;
>> +	struct mutex	lock;
>> +};
>> +
>> +struct amd_hfi_classes {
>> +	u32	perf;
>> +	u32	eff;
>> +} __packed;
> 
> Unnecessary packed.
> 
>> +
>> +/**
>> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
>> + * @cpu:		cpu index
>> + * @cpus:		mask of cpus associated with amd_hfi_cpuinfo
>> + * @class_index:	workload class ID index
>> + * @nr_class:		max number of workload class supported
>> + * @amd_hfi_classes:	current cpu workload class ranking data
>> + *
>> + * Parameters of a logical processor linked with hardware feedback class
>> + */
>> +struct amd_hfi_cpuinfo {
>> +	int		cpu;
>> +	cpumask_var_t	cpus;
>> +	s16		class_index;
>> +	u8		nr_class;
>> +	struct amd_hfi_classes	*amd_hfi_classes;
>> +};
>> +
>> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>> +
>> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
>> +	struct device *dev = &pdev->dev;
>> +	int idx;
>> +	int nr_class_id;
>> +
>> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
>> +	if (nr_class_id < 0 || nr_class_id > 255) {
>> +		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
>> +				AMD_HETERO_CPUID_27);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_possible_cpu(idx) {
>> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
>> +		hfi_cpuinfo->amd_hfi_classes = devm_kmalloc(dev, nr_class_id *
>> +				sizeof(struct amd_hfi_classes), GFP_KERNEL);
> 
> I recommend splitting this line differently.
> 
> Why it's not using kzalloc?
> 
>> +		if (!hfi_cpuinfo->amd_hfi_classes)
>> +			return -ENOMEM;
>> +
>> +		hfi_cpuinfo->nr_class = nr_class_id;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void amd_hfi_remove(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
>> +
>> +	mutex_destroy(&dev->lock);
>> +}
>> +
>> +static const struct acpi_device_id amd_hfi_platform_match[] = {
>> +	{ "AMDI0104", 0},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
>> +
>> +static int amd_hfi_probe(struct platform_device *pdev)
>> +{
>> +	struct amd_hfi_data *amd_hfi_data;
>> +	int ret;
>> +
>> +	if (!acpi_match_device(amd_hfi_platform_match, &pdev->dev))
>> +		return -ENODEV;
>> +
>> +	amd_hfi_data = devm_kzalloc(&pdev->dev, sizeof(*amd_hfi_data), GFP_KERNEL);
>> +	if (!amd_hfi_data)
>> +		return -ENOMEM;
>> +
>> +	amd_hfi_data->dev = &pdev->dev;
>> +
>> +	mutex_init(&amd_hfi_data->lock);
> 
> No idea why the empty line is put between these initializations of the
> data structure fields.
> 
>> +	platform_set_drvdata(pdev, amd_hfi_data);
>> +
>> +	/* alloc data array for hardware feedback class data */
> 
> Unnecessary comment? Isn't the function name enough to tell it?
> 
>> +	ret = amd_hfi_alloc_class_data(pdev);
>> +	if (ret)
>> +		goto out;
>> +
>> +out:
> 
> I'm guessing this might be to reduce churn in some patch after this,
> if not, this is enough:

Thanks for all the feedback.

This was intended to avoid churn, but some of that change isn't part of 
this series and will be a future follow up that can adjust at that time.

I'll adjust to churn for "this series alone".

> 
> 	return amd_hfi_alloc_class_data(pdev);
> 
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver amd_hfi_driver = {
>> +	.driver = {
>> +		.name = AMD_HFI_DRIVER,
>> +		.owner = THIS_MODULE,
>> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>> +	},
>> +	.probe = amd_hfi_probe,
>> +	.remove_new = amd_hfi_remove,
>> +};
>> +
>> +static int __init amd_hfi_init(void)
>> +{
>> +	int ret;
>> +
>> +	if (acpi_disabled ||
>> +	    !boot_cpu_has(X86_FEATURE_HETERO_CORE_TOPOLOGY) ||
>> +	    !boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS))
>> +		return -ENODEV;
>> +
>> +	device = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
>> +	if (IS_ERR(device)) {
>> +		pr_err("unable to register hfi platform device\n");
> 
> I assume HFI is the correct capitalization given I see some comments with
> that. Please correct any user visible print outs to use the capitalized
> form.
> 
>> +		return PTR_ERR(device);
>> +	}
>> +
>> +	ret = platform_driver_register(&amd_hfi_driver);
>> +	if (ret)
>> +		pr_err("Failed to register hfi driver\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static __exit void amd_hfi_exit(void)
>> +{
>> +	platform_device_unregister(device);
>> +	platform_driver_unregister(&amd_hfi_driver);
>> +}
>> +module_init(amd_hfi_init);
>> +module_exit(amd_hfi_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");
>>
> 


