Return-Path: <linux-pm+bounces-15040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63598CB6B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 05:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1391C2145D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2024 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8966DF60;
	Wed,  2 Oct 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Z7se9mL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EF179A8;
	Wed,  2 Oct 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838708; cv=fail; b=Jrr3XsPc0OSPsL30f/NlcuTFaT5ut/0g3luL6YDO1XJb6u5VYgNXYq2wo4vgZ785XIwfxYEB/5NU5NsKobms0K0F+EdNL12AT5JWnBvFLDv1RMDi0YPA39CO3VAUghjHAwvuLvtR5GnonY0u+RE/4OKc+JYI40kYCeMmQBiK144=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838708; c=relaxed/simple;
	bh=nzCDSOj52F7JzHzp2u7GtSP+oumkwXTU+I3lC3OtI5E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SkS/1rwAA6PSLhDPieJk/3LAOSYuYw7XX4BLadOricFiL3jq71VyAA6BIWoJQRCQz0r3jFANgzLpfIWdYsnuPwDZWGHnBxSx9UyXDU0y4K93P6xIxKnLxVXOO1tURZu6OykJNP4CXCNn4eeWOwvNx9gWe3BT8MPaZPHCcf+pdmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Z7se9mL; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhn0IQoOXJPsSpumDDeezXr/Aaa9jEB2br2+mXu53FAATWvTX9jUCkfuxNzoqvoQudwN6JpIQx8+FFxsEvfhDJVCmaxH6cMEvJc8WFfvQuFJ75KTXX4qBszDH1D51QsrW2qrqMVXoTr7Qc9YMXcW4NWKMK4ExUOM/1x+fDr9rut68xXdZ7KvftRZ1EcIKVKecwz4mg6i1abTaVNG69XUCdRfURKGtNPn/qc94VRxIf6vfOV5fSCTuJg75fEgrqVQmgsIXNfKdglGLWvty9GrUa8qngf0NuHlpg0S/9YfvBrv+ycPq5F39UrMbrzV8k7agOu9T334L1x4KT/F1f+zFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nrxyi6fBh5k3RecvLXoayW388BuhXINSiMCHpM02wSk=;
 b=bvf5AewEN48X/hJ6QaT9W1F4woV59BceRpDCBw3JArQiri/TzC8AmQgJEehbUuhsDTdTPEBX0zdnVv0pCjY7xuu/RI5SKIz3QH/2wm6c8wuv/fYnQP8U4cTXBUns0G7aOfunyegeeKu259zKlXLvtb+w/fkLpqIbyat52qeGcYAmwXBlLm8mBvx3sVEA/5wROVikKluj6rIrtv6LK5QX6MCNWVh6ld346C3MRFVLQLwmCoSWvPlYa2TcyCEPn0vBQNCEmWcQuSI2H6vtoXyJWgWWmdBWFXKS61LdsZVIPIoYNOG1pwPfjoezQFGUt+h/zB7OgCFV49MaePMS1jf9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nrxyi6fBh5k3RecvLXoayW388BuhXINSiMCHpM02wSk=;
 b=3Z7se9mLEApsJPLbdWNocg//9Q9+xTwOjBKpPZBx/L2ZhhzCOoepKYHiVyC1PIe44Nt7anT3HqFpld/wttYzOc0v2nPher+j3MTqQJpdyb5nVdAz34XN1COsmEmvrUQG88lBa/WetnVdIteEzpNfgXuSIxRVenL+m+BM+FKDbXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 03:11:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 03:11:43 +0000
Message-ID: <996d51a3-80c5-4a56-8e17-baa87efed5ac@amd.com>
Date: Tue, 1 Oct 2024 22:11:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/pmc: Disable C1 auto-demotion during
 suspend
To: "David E. Box" <david.e.box@linux.intel.com>, david.e.box@intel.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, rjw@rjwysocki.net
References: <20241001225901.135564-1-david.e.box@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241001225901.135564-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1f7e36-df26-48e6-e0b2-08dce28ff16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXAwQ2dxTUlsMHg2VUo1cTE1Ri9LaFpZZElRaHg5MVZaSitrckdnOFBtaE0r?=
 =?utf-8?B?VzBBdEZyZDErbXZYK0hhN0xzK3lWc2VSN0kwUDgxMjNWNitWZmliNUFWdkY2?=
 =?utf-8?B?QWdabUhiWFNVTFByYUUwd3lqbmlWNFhQMllaOFIrZmpGYkppcDdxdlN3a2tT?=
 =?utf-8?B?YXNxbXVHSFVCUkxnR0xuKzNsd0cwS1ZVQ0UxYkhUZ0RtcWdBTFZtUzFoZExM?=
 =?utf-8?B?NU5PMXNrd3FmYWZBT0dGUGhhR1A0OHhGQjZ6ck50ZHBicmU3emlucXB2ZllU?=
 =?utf-8?B?cm1oQlRrb3FVSW02UkVodGVMN1NpcDNjRzBsTGhMY3JoS0tTMmdXNmZYNzhy?=
 =?utf-8?B?V2lmVWZhTU1HNEZhdFBOWnJoOFZDTHhDS3RObEVUeWExQ0ptRURObFliMTdi?=
 =?utf-8?B?VXJKS2hPOXhNQVFkT0FCTVhkT2xTZ0NrQmhkS3pkTk1NdkdsUjZ0MGJEWE1R?=
 =?utf-8?B?UkNrZjAwRGpvT0piM2IyRk9WWHdNRjNTekZLZmdONHFNbi9yK3E4WWwwWGVr?=
 =?utf-8?B?bFBQMnp1c1dOa2gxWEg0SW1nMmZ6NGVidW5RMzhBNVJJdDJ6L0I5K1JyZWlV?=
 =?utf-8?B?VHZMNUxGNHpScCsvbmQ3S0RUT1MzOGtCU2xlM2VTUjR0TjZzTzJVMlREM2JC?=
 =?utf-8?B?WnJhbWtDc3VEMExsK0t4bGhBYjFkaFNjR0FVVzk1Z2l3RWU0RldSUGFOTmdl?=
 =?utf-8?B?SWpaWUhqTk1pSjdzeGxad3QrSk9hQ3ZiT1lFUVJyWUpZZkM0S01jNlZPU3Jh?=
 =?utf-8?B?WjQwbnJXNkJteG8wUXVxT3hJRGlLYW1lSHc2bWxtOFVMdWNTUlozWUtWL2ZU?=
 =?utf-8?B?aTUzQ01HQ0M0UHptUU4wNjdneFc0TENzamI2OHR2QTBuQkp1d3NzTTZTdWhW?=
 =?utf-8?B?b2MwQjBFMDdkcHRyZVVaa2FWZ2tVYUlLcGtJTFppelJlYkVLVGhJd2VJOXJF?=
 =?utf-8?B?dEd6UVRwR3ZsYnViWmJnMG9CSzBIUkZNUld6SUhqWG5zanVxNkZENHIySjMv?=
 =?utf-8?B?eTBWci9mNG00N2V5d2kwZk9PVzlkUnJyei9OVjZpUW9QVW5PTmRnT0hYcXM4?=
 =?utf-8?B?V25VaUV1djNEcmFzeG5Eb2lnM0dmRE1sRk1SZHd4MlREK2NjRVVyTzcrZHNN?=
 =?utf-8?B?WnBGMTQ1bnJNOHFnQzYxcUFzK3ZaWFRNZnBMbFl3OUdMMitPZkpUWGtZVS83?=
 =?utf-8?B?a2tZT0g1aENXNS9nZlo3YWpGcnF0eDRCanlGSlJtWDVocE9mMTZnaWQxUUtQ?=
 =?utf-8?B?WGNPRzB5ZDVxN0JnVDBmV3FQNTEwQ3hCUURkOGU3QlZ3QmhqSkZZNHA4VVBh?=
 =?utf-8?B?bmdma0JWNWZXRHhCcjB6RG5seGF5RHlHQzRpam1jbjBsOGg0NWhod0RZQlRD?=
 =?utf-8?B?V3hWaXpvTVdzdmNqZnduRDBlSHFyakY0Mmlta0lEQkRUM1A1ZXk2eS94VHVj?=
 =?utf-8?B?MGdUSGhSN25rVnJKaDNWMVl2ZDRObnhPaVlZczBTZ21tRTNJMENTYjZvWDZl?=
 =?utf-8?B?elVUaVNZOWxnQ3NiSHY0RTBZaW9QelVxRDEzOWFidjRLOHV5UDNBNExjVFVk?=
 =?utf-8?B?TnJxbG1qV0FORVg4TlFLeXVScDdCclgyZkpIU2s2TkRsSFE2MkViVXJ1dlZE?=
 =?utf-8?B?MElKV2FZd1YzVk9lOWdLSmZRTG9hTnpraW9sOUpUWjM5MjYydGM0OEZueTNx?=
 =?utf-8?B?ZkRFRjlqVXhPd0JvN2NyWkd0UTVCdGtiaVc4aUU3NTQ4MzJUOHNwb1VscGNx?=
 =?utf-8?B?YTdzSW1waG0xdzQ4Ulc3cncvVXAycXpWdlRRc2xwaFgyeGtMNVhock1iVXYw?=
 =?utf-8?B?N1AvQWxkNERwOXpqSEhDUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWk0QlQrejdKOW5BaGtMaFRZcCtpcURmVlFhckdkV0hDZHlFYU00cGo4ejZD?=
 =?utf-8?B?SjREU0U5bVZwa1FtaXExd2RRR2xhSXJVRU1QV1V5WVgyQlJLSHB3THY4Q3RV?=
 =?utf-8?B?eVJVbUZQRjhLc1p5N0NuYkpvV2RIMzVoUnhoc0R2UDBMc1haRHBRTzNFUHEx?=
 =?utf-8?B?eEJNU0FwUklpeS9mMkNVNmNtUUwvM0FVMWR6eFJtN2lsOUo3ZGhpU1Q1SGJB?=
 =?utf-8?B?QVFIb3duR1JKUE9idzVpTDZPU2dqbTFtZndzblRUMFNvVFNaVXc3a0NnSmRF?=
 =?utf-8?B?ZVQzY3dMTnBLUjM3NXFXRHpaRGlYZklSZkZaKzZOdEEySzFtNVdjVnU4RHRR?=
 =?utf-8?B?NEhnUGZiYk9Ibk5pYTg0cXZNVmg4azVOZTNtdHNTRHFtWkU2aTFsVHRNOFFD?=
 =?utf-8?B?bWF3SHpqekJmRG9mOUxOMEphL2tzMFZzNit4YmVWcVJFdDNCWmpzd1hyOEo0?=
 =?utf-8?B?T2ZoWkxvSlFRbmRiaFYyZUw0ZGduSThrQk9yS0t1Y0Rvc1RmTUluRlR5T2pD?=
 =?utf-8?B?QlU1cTdLZFdPdDZyMjJteDJQT2E5QXJrZGEvZnhkS2xDN0FyTk9KZDEzMHEz?=
 =?utf-8?B?WjVVdkJ5NXRUdmRPS1pEUmtBK3JGZTVreWpKeTV0TUZwRVUvNmRHQ3hXbEdW?=
 =?utf-8?B?Nm5jRWdnTnFnRnZtdkQydUoxc3NOV2lVU241Nld1ZEwvSkVZbHU1cHhDenRU?=
 =?utf-8?B?S2psWERwMko1d2FZZlJjSXljRDUxOW5iOTBVZTdKa21TVWt3U1I5c050NEEr?=
 =?utf-8?B?OThFaksrbjRzdGdlNUFJWlIyTFBWbFdZTDZyc3JBc0hENHJUNDFpSVNNM3Zv?=
 =?utf-8?B?cnBIVmV4MHBwOHRiY0p2YUJNeDhSN0dmdlpudms5MlRndnJjSE5jbm1pQVoz?=
 =?utf-8?B?WGhHcFAwczkrNHdpK296UkRnS2k3YkE4YzNYaTBMRStLeGxiUHovak9lQ2xs?=
 =?utf-8?B?ZEVhNVpPbUJtSXlCMHdiNFFHUWdrV05EdnVKc1dXenZHK3JHMmhDbUJWZFdP?=
 =?utf-8?B?OHVNVEJJOWN4WUZoTG1CNW41R0R0NjZIb0FWZEZWLytoNFNDRWRra2xRUDNU?=
 =?utf-8?B?KzVKVklpQ2pkSWRLajU4aXZIMFEyeGh1cytudXNFVE5HTzFzOEY4Tmt3VnpC?=
 =?utf-8?B?MXp0NmsyYlFKOEFqZVcvSlJUcmNBWHNkTXZKWW44UGRhNlMzMjM0RVNCM2U0?=
 =?utf-8?B?aUJRSFZDZ3A0dVh2WEFYZlhQYWxMV0xIZzAvOHEyZUlCSlM3UkVSUFhPRktJ?=
 =?utf-8?B?SU9hSFpoaG9IKzF5YXJ2cmRRVnZrY0U1d2taTVBJTVloYW5vcjVoLzNTYUpy?=
 =?utf-8?B?NEE2K1dGWjJVYXh2dHZqZTZxVG5xVHF2VDFSaytwOUhrZ1Z6QU0vcnRnSUt2?=
 =?utf-8?B?YzQrVDh1WmJnWHEwakNSWjExa2Q4cElxdFNlSDl0em1tWTlBYkxDT0Y4THBM?=
 =?utf-8?B?RlhsSWRCekNHenpMbC9qa2k0Z1BDLzBkVkdzOUZOcTVaaHJKOGoyRk9WZGRx?=
 =?utf-8?B?bG52WmNBU0ZuM2Jia3JmUGVhanJUOFIvMCtZUzhIRVU3d29saDh2WXJGcXFM?=
 =?utf-8?B?amYxamJ6bVY2RjVJRGRiUG56WmhneWFjQnAwUWxNUC9QRGFYN2hMQjdTZ0tq?=
 =?utf-8?B?ZjRSYTZoMkhscThTdTRGdi9qaXlIMUJiS1EvS3E3ZVFJOGR6aHFpb3FNKytY?=
 =?utf-8?B?aCs2Zlo2Sm1BVGNrbkJPbDhoNit6aG1wVFNpRnIvRXhmeXFOcHovYXVKaTNm?=
 =?utf-8?B?V3VOaFpkbmRwbGpQb2I5ckZtdkkvRytYdFA4Ym5rL0ZBTkJOeXFXeXhhYlV6?=
 =?utf-8?B?OTBXWDgzRzJocGZFbGM5VTJaR1UrYlpJL3dBSzRiZXg4Q3IzSE5FSkk0ZXNt?=
 =?utf-8?B?NHdkYnFTQ25CYjJqQTMzNWZuY2Y5OUppdXE0MlowS1pyenZmYTB4bEtNeVJH?=
 =?utf-8?B?dFphb2t3VW02dUJHeDhQZldaRDlncldPSlFiU2dLZzNRMjlFQmdTS250ZW1M?=
 =?utf-8?B?MVp0a2xsWkFOTDFqL3k3Si9FSVc0VGZzUlZkTmFXR3cxczAxNEtZUTBaakp1?=
 =?utf-8?B?cnY1TEFpaUpjeklmYTF5NnpHbnZPY2lndlY2bGcyb2RpNHJnSEh1blc2dzN1?=
 =?utf-8?Q?23TqR/F7/DsYyJ+kUl+d1+ES/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f7e36-df26-48e6-e0b2-08dce28ff16e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 03:11:43.9630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/rnp+p9hwwLtp+ScSGTF37QTBIVLpRt56dWtIOsRftDcV9mSVBqTH0csOwkO+0gN7f1pDyEMq3pdIncvSesPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

On 10/1/2024 17:58, David E. Box wrote:
> On some platforms, aggressive C1 auto-demotion may lead to failure to enter
> the deepest C-state during suspend-to-idle, causing high power consumption.
> To prevent this, disable C1 auto-demotion during suspend and re-enable on
> resume.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>   drivers/platform/x86/intel/pmc/arl.c |  3 +--
>   drivers/platform/x86/intel/pmc/cnp.c | 28 +++++++++++++++++++++++++++-
>   drivers/platform/x86/intel/pmc/lnl.c |  3 +--
>   drivers/platform/x86/intel/pmc/mtl.c |  3 +--
>   4 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index e10527c4e3e0..05dec4f5019f 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -687,9 +687,8 @@ static void arl_d3_fixup(void)
>   static int arl_resume(struct pmc_dev *pmcdev)
>   {
>   	arl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>   
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>   }
>   
>   int arl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
> index 513c02670c5a..5b8b3ac7f061 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -7,7 +7,8 @@
>    * All Rights Reserved.
>    *
>    */
> -
> +#define DEBUG

Did you mean to pull this out before submitting?

> +#include <linux/suspend.h>
>   #include "core.h"
>   
>   /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> @@ -206,8 +207,24 @@ const struct pmc_reg_map cnp_reg_map = {
>   	.etr3_offset = ETR3_OFFSET,
>   };
>   
> +
> +static DEFINE_PER_CPU(u64, pkg_cst_config);
> +
>   void cnl_suspend(struct pmc_dev *pmcdev)
>   {
> +	if (!pm_suspend_via_firmware()) {
> +		u64 val;
> +		int cpunum;
> +
> +		for_each_online_cpu(cpunum) {
> +			rdmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, &val);
> +			per_cpu(pkg_cst_config, cpunum) = val;
> +			val &= ~NHM_C1_AUTO_DEMOTE;
> +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, val);
> +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, val);
> +		}
> +	}
> +
>   	/*
>   	 * Due to a hardware limitation, the GBE LTR blocks PC10
>   	 * when a cable is attached. To unblock PC10 during suspend,
> @@ -220,6 +237,15 @@ int cnl_resume(struct pmc_dev *pmcdev)
>   {
>   	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>   
> +	if (!pm_suspend_via_firmware()) {
> +		int cpunum;
> +
> +		for_each_online_cpu(cpunum) {
> +			pr_debug("%s: cpu:%d cst %llx\n", __func__, cpunum, per_cpu(pkg_cst_config, cpunum));
> +			wrmsrl_on_cpu(cpunum, MSR_PKG_CST_CONFIG_CONTROL, per_cpu(pkg_cst_config, cpunum));
> +		}
> +	}
> +
>   	return pmc_core_resume_common(pmcdev);
>   }
>   
> diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
> index e7a8077d1a3e..be029f12cdf4 100644
> --- a/drivers/platform/x86/intel/pmc/lnl.c
> +++ b/drivers/platform/x86/intel/pmc/lnl.c
> @@ -546,9 +546,8 @@ static void lnl_d3_fixup(void)
>   static int lnl_resume(struct pmc_dev *pmcdev)
>   {
>   	lnl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>   
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>   }
>   
>   int lnl_core_init(struct pmc_dev *pmcdev)
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 91f2fa728f5c..fc6a89b8979f 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -988,9 +988,8 @@ static void mtl_d3_fixup(void)
>   static int mtl_resume(struct pmc_dev *pmcdev)
>   {
>   	mtl_d3_fixup();
> -	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
>   
> -	return pmc_core_resume_common(pmcdev);
> +	return cnl_resume(pmcdev);
>   }
>   
>   int mtl_core_init(struct pmc_dev *pmcdev)


