Return-Path: <linux-pm+bounces-21420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AABA29815
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25C33AC0E3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D881FF5F4;
	Wed,  5 Feb 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnOHtXkG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3D1FF1AC;
	Wed,  5 Feb 2025 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777881; cv=fail; b=eEIvAhuvNyoelhqaINEq+049E8X7pj6vrY630eyD2OYufWVKJTpiGZUbNYxmGuCNLlih12hLwpzIVVo+P9GgUcZS4LPBT/W02aydkzHlitP/ahLtnIR2+63hYce/b3vvjKjfudHKPZ1b96cIUg6GkQhBm6wwHmM+aYCvi5vuYlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777881; c=relaxed/simple;
	bh=2DpfB9z5PHTXAHNopjlXMiFnevQQA3LMiscBJ+IUDpc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fvsTUJoBFTLLZemxtTwWPZo1Z3sFRAr/nXNmtGPs3cjdkGekdWtsS5xEPh+So2LxihbCLyMQ56YweRWP0rGzw1qG1QKLxPx9c8zXuhvIEjA+PZZEXS0Ljj+qBnDNjZ/S2O7mtMXVh7N/mAJz79jNBk2kx81oSlKfcUVbN3fM0Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnOHtXkG; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuKCikiHtuhrJDm6sVyi2LFl8dg1lPcmzQm5G5LXc66emEWkb19FKiP6bG4JWWIpLaO3hioeLK+ita66CMvT7j1kebh0Cwt2YffCVMEYqEL6Ky9amAuLKCg6eeFr9VbTcfxDDHhw2qGAo/FZTC+lBvPE8/91iXO5lt5Ar9wXBVxX/MP3SddtD+F6ewdh+n9lhK+vfTOS7kduH6RlXqUMsuLp3fxR4ZEPRFdS6Muab2NZVK8saOoxeRaZLeg1RHBQeayhSkRx6CgyxY2JQjMbT0+on7o45aGoGgaI3vP5IyDAUCQTLa9gsMV8JCdb6NyL9/Rhdy2olkm4Uviz2JBHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae9+46keA3mVEVLLNLZYwbnEprOJUuSWLVZZ8vxshic=;
 b=G9W1KaYd9gc/2Y671dvV4S6rGgPlZEf7HIsfARsbxh2Spd9M/CN0BB2MZB2UOd4wk8qubAWdP25NdZIgRbdSM/yedRvIPVUEYPr4SVc+tJrMNZbv9T8WQ0rPmLmhjK01Tuh22s6F1ESVfE/lP6mClMO7DnuJ40hffBvxIr3hfRWbGS/23VeKm+fH4NCm+8MeV4JE+TVmM2LKlyADtfqLDtxZWgFD26/I9qAZ5JNn39/y8botO7kzu4ATk0DRQxF61Ezv4k0ltFBuTUVlcOxfNN+k+rHqhp3BP9aEl+ny95XrsL7QJTxyDW2jS4PKlmi0LZkB296L/cIUY5NmgQx+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae9+46keA3mVEVLLNLZYwbnEprOJUuSWLVZZ8vxshic=;
 b=EnOHtXkGw4XCXshnYDynJnJ14SF1i1N9iZjK3XxSGpfawxk2nqsLICZ51yQn+aLhRSFuhmOcrm9wszKtyya5RxsNJrcQUH0AuMxRkgnQhqWphxkshjpokufIfCPkPJ6Nl1wafTnC6n04eS+MGWzlflGiml4SjbBXDgId5JKf2e8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 17:51:16 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 17:51:16 +0000
Message-ID: <ead2cddb-d7ef-4c75-8ec5-d93d910f5562@amd.com>
Date: Wed, 5 Feb 2025 11:46:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] cpufreq/amd-pstate: Remove the unnecessary
 cpufreq_update_policy call
To: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, gautham.shenoy@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250205112523.201101-1-dhananjay.ugwekar@amd.com>
 <20250205112523.201101-9-dhananjay.ugwekar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250205112523.201101-9-dhananjay.ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ROAP284CA0223.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:73::7)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf81612-e9a6-4bfa-5644-08dd460db052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U09OakRxRHVEM2lYbm4wSU1EQTlybUNPSnhBNVdLcWQ4OTJualpiSy9EUjlC?=
 =?utf-8?B?amtoUmZMWFhnQjNqNE1JL3kybTRlZ002cnhLd1gzdHhpdHQ0bU8wanB5d3ls?=
 =?utf-8?B?VlRHTzZXSGxDM0x1RVJuOFZlTTV5T0ZyTUl6cjVmR3E4WjZmZHMxdGhObXNP?=
 =?utf-8?B?N0tiYTZVNjN2K2hxemp3dmxtbW1iSUFNTlh2aXNIY0d1a0x1UGhiLzFBODE0?=
 =?utf-8?B?Rzk1c3FLU2lpa3oyNHZaYUJTRC9sWDVCaEloSkwwYXlHdzlxdnBkT1FOVWJq?=
 =?utf-8?B?ZEdzY3NDRDA2Qi9WQkd0ZFJhUGV4c2RUTUg0YnhveVJIRFpNMXFmTmNNeG9P?=
 =?utf-8?B?bnN1M0h6NUpEZXhNdm1UUUN4OGZqREJUYXZpeW1vclMxY1dYVTI2UlpicmdO?=
 =?utf-8?B?aDZON0czZkovajM1ZDZGNlNUeDJob0ljUkxmSTNURklQcmkydkd6ZFBSem9L?=
 =?utf-8?B?RDNXL0kvQVlnYjlydkdtSFRDeTR1UmlrOUZWZEtraENWWXRoTmxDRldkQ051?=
 =?utf-8?B?L2xXNFp1SlFTeGxTT0FKVFh1b0t1THhad21vVi83WS9qWkV2VFUvWUU5dUw4?=
 =?utf-8?B?YUtldU5HRjdSa1FidDRiUVFDeEg0ZE9UNlRoZkpocTRRemtBM0tIS0V2T2J5?=
 =?utf-8?B?SXBOWnJySTk5dDVYZCszVlgyS3ZxWmpJczJxcXUrYkhHODlZaHRRanBCVmxO?=
 =?utf-8?B?TlVKbGJGY1pZQnppYXRiQWhiWko2OVdvMW1ocitEeWg2aEROWGNLTkQvK3VJ?=
 =?utf-8?B?MUxjRGJiL01zMEtzYUM0a2VoTVNTWlgrMHR0a2NxRVFLamxWZXhvYnh1cll2?=
 =?utf-8?B?ZUVvcW5jS29DZkVzdWVqTTBBTVZPZGc1MUJxelpUZG1nSnI0alQraXJWRXRX?=
 =?utf-8?B?bDQydUlrS1FSeXArNmRuZk1EMjMxYXlWbzJPVVFtc3l6Z3hHSk5kVW1FYU9a?=
 =?utf-8?B?UGNPM2ZIOU9Fejl6aHU0K1JBWVl0NGZmQWswaHBkZ25LZW02TlBWZTEvOGpw?=
 =?utf-8?B?eFFaRlJURFIxRDhTampXTVJYVlpVVTJVNGdYbXY5M0NEejJoWjh5ZzZWMUh0?=
 =?utf-8?B?eHREWXZkM25FZmlhNjc3Zk5BWDZUOG42K2NLSnc4ZlFXVENNWjhoUW1Dd3hW?=
 =?utf-8?B?N01tL2t3L0NmeVBkSzU2SXJjeHAzWUp1YkZTNmVHclE4U0krRFBTZHdIUnA4?=
 =?utf-8?B?VnQ4MVU3b3I3MjNzSzFxa0hFdkFUUVpkRGI3V0pSdU9Ec2pWN2FOb0h0emZ5?=
 =?utf-8?B?T1JqdHZxVEU1Z0FuSnhZWFNlc1plOXBXYzlyckhpSnNVR0pndjYwbVR5N2I0?=
 =?utf-8?B?Q01UNWZMNzFNcXIrUUJkQ3FsRFRjZFo2NzJ4TDF5WktsWVFyTytER2JnZkpJ?=
 =?utf-8?B?dnMvRnZadWk1blZVUWtiZU1OZFlnWTRXVGt2MFcvdCtYYm9OOGs0NVJ0UDVs?=
 =?utf-8?B?U28wQzZsbG1oSnN3MS9YSkk4Z05iTW1oRjhLVjNOU1ZXdkFITXdHMDhOa2Qx?=
 =?utf-8?B?NFVnZE1zVW10MkNYVmVKbGJLc3NxVVppcHBwN0hydFB3VW1iNTZOUktzbU5F?=
 =?utf-8?B?bWtzWkFBUGJtazlLRTU3VmRjeEtOa0RhQ2ZTbGl4MlBhZ0c0OExqYytFZ3FN?=
 =?utf-8?B?WEczSWhqdm9ydDYvWkxSbmkweFNiWHg0eU94bG5VSkFFN3pUSDdsb3c2Vy8v?=
 =?utf-8?B?Ri9yQXlrc1Bwekh1cHRjWnJqZkhsdkdqOVZZZ0ZDM0pRdVk1RldURTQ3TkZs?=
 =?utf-8?B?dnBUbG9PaUNJdkhpeUpKckRsek8zUDZhOG5zbm1DVTNaTXNkclRqdzYzTk1E?=
 =?utf-8?B?UUZ0Wjh5bG4xNnNGaG9oY1QvTWx6bVBEa0hWNXovclJpZ05Uc2luSUI2NERi?=
 =?utf-8?Q?KvKvEvL7u5W5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmUwMVRDQnhSQTNvM0tJd2g0T284V0ttVFJCR3RpYkd6UUExTFBTTUtxdFR6?=
 =?utf-8?B?b3BmeVlMZk5DRHlmS0MvSkZOMy9Lc3lqaS83U0lrbk1sWStWenlJRUhFaFNk?=
 =?utf-8?B?d041U1grbXVvSytBOWU2Ny9IS3N4OWpDTlROREprVVhHR3pBNm1tc2R2dzFq?=
 =?utf-8?B?S1VGWWE2VWoxMGNEWEtTNGhkNUpHSjh4eVFwaHhIT1hQMWxUZjZSR1I3MWtJ?=
 =?utf-8?B?WHdybGZzNnR2UHVLN2Yya2cwVnhOaG9iejNXU1J6T0R4Z1dIY3BRNDhvTmtu?=
 =?utf-8?B?WTc4cis5Skk1RkdFbHZORExHL214bEMyWGI3bm40d2lmeS9oaWFBcmM5ZlRB?=
 =?utf-8?B?U2tJNGtKNVVLYXpnZFVwYUJ1NW1MT2psU1FtaUNSUGpxcm50cFVLTndYQ25X?=
 =?utf-8?B?YWQ5bGFBbVlhQkt6dVFON0RwVVlsMVlvdDFkNUZpYjBtNGQ2VTRMTkxTNDU0?=
 =?utf-8?B?TjBsTXlNRCsxVW9xM3prMDZhS2l4YThua2FQY3RtNko0R1pyVy9OYjJuSkhQ?=
 =?utf-8?B?STc4K3czMWNLN1d6Q3JWQXoxRjdjb0o2RzAxS01JL2k4M3Bjelk1TmN6dUpW?=
 =?utf-8?B?cEJhSzI4VEdpcXdSZWxuV1M3Vk1vNDIyelB5VzNuSU02T0QzbG1xbWlIQnZp?=
 =?utf-8?B?M0g0WU1uZjdwK2ovbjNHQytSRkpHU210UVNrbEdndkN1ZHUyMm1FdlY1TFZX?=
 =?utf-8?B?RVVZdWxiWW9qWDdyUUJoQWpuWnJFeDdhZnRlcm0zRm45ZGp4UUhrVjhJVkpi?=
 =?utf-8?B?dzdiemJBMDh0aXUwWnNpblBtUm9wcmY4d0FXdkRHRGIvbElLRk92Yk1kNjJq?=
 =?utf-8?B?cEZ4ZTArdTQ4b20xSnpzcUhpek9qSGsrcWhQWHkxUnJRa1dRZXZhOWVMWFBi?=
 =?utf-8?B?cU1XdVNiSlZvc3NBdjl4NWVNeHlFSVFNbTA3djFqYjdVejVVbmE5QjdNVWFp?=
 =?utf-8?B?VFNYSW1naG5nRndaTTFkcXhIdzloaFpDdkhNZGdJZldSWHFRNFBFamIrWXR3?=
 =?utf-8?B?TzUzdDRDSkhiQktzN1lZN0ZLd0FwdG5xRFBqSGYzSVZCWFM1RXBDM0lEMkhn?=
 =?utf-8?B?L1g1Y0ZXL2lRbjRyd2VLOThYWXd0YXlSTHhYRjB2ZEt2QnFtVys3RG9JbHdE?=
 =?utf-8?B?U0xmSGp5V2JWQTNpa2RnWWZ1WlltRmFNKzlocFJKTGFwdllwWXZocnRUSkhR?=
 =?utf-8?B?VHk5UlNsaVlVb2RhRFFCaHc1d2ZsbVU1ZFVRRzNpZlhWN0N6TWU2ZmZ5Z21n?=
 =?utf-8?B?ZHgwc1ZmVTVTWGxFbi9pWGNhVkhNbXFBcnhmaGo2SC80eUkwY1JGVDhnK2Uw?=
 =?utf-8?B?UDhmMEhLMlVLYlhmTkNSZHRXYk1acUFrYVl3UDQ3cG1RWFAxVHBJYmFUT0I2?=
 =?utf-8?B?SWhMVTdvYjVKZFQ2RWFSb2JCbE5rWmtaNFlSaEs2V3lBTTllZmQrTlJya0NH?=
 =?utf-8?B?V3VWWTRrZUJIZDd4MlhqQlpoTlFiSVlxYjdwRGt1V0YxeS9oWTRKZ0RyTDBO?=
 =?utf-8?B?Y29sSlhISDg1VmMyWGVxTnF0QnRiTWROT0cvdkUrdkZxcC9CS0FncFVYQkNH?=
 =?utf-8?B?WVIyS0Jwc2xUa0N0N0dYUXI2KzF6cnl6QkJjWXVZb1g2S2doWnBoZy8yZTcy?=
 =?utf-8?B?K3A3OVF1Uk03MWpmTWdWZGt5N1g3dmpPVGZBRjZUWW9aS3YySVpKcXRzQkFv?=
 =?utf-8?B?dDlBY1V2TW90UUo4Y1pJYmtsR1l3YW15UEVDOVhHNzZkNmVySnpWMXh0QWYv?=
 =?utf-8?B?Q2ZIdFBqMVczTjliZWhTWk1VMGdvUG1US2lzNVJwMXdUQ0ExeHVnYm5zR1dn?=
 =?utf-8?B?K0c1cFVHdFdLR2t6R0Rwc2VLckV3dW9JR3BrUktnTDIyeVhkdklwSUc3WmhW?=
 =?utf-8?B?VUFhOXdTVllORXBTakdwUWhHWlMyZllQOE5kMjhyN3dYdjNMdDRQYjVTMWpu?=
 =?utf-8?B?NVFqUXlXblpHbmYweDFjT05VaEpMRGhZSVBOeFNReUFHYzdPd0VIaWtpRmR3?=
 =?utf-8?B?blJjRWxueHZhdDFCSzFpYmcvamJCODNyT0JsK1dpNjVxSTZrMzNMNHRPcEwv?=
 =?utf-8?B?NWNqNjlQZ01IcHpGeEc1S3N1dStPTm5TaFB1Vm1wRS9mVGdJRTFRZXg5QlpQ?=
 =?utf-8?Q?Oa9KTxyOPHVJqdJoj3jqTrxHz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf81612-e9a6-4bfa-5644-08dd460db052
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 17:51:16.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzYbzTHyXQU7bcHVLn/ZML4yoPeiV0xnGBoFfnQKf05YiSiqD65UCZv52ZexnLvrB62jrmDGODhlltF8tX2FOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

On 2/5/2025 05:25, Dhananjay Ugwekar wrote:
> The update_limits callback is only called in two conditions.
> 
> * When the preferred core rankings change. In which case, we just need to
> change the prefcore ranking in the cpudata struct. As there are no changes
> to any of the perf values, there is no need to call cpufreq_update_policy()
> 
> * When the _PPC ACPI object changes, i.e. the highest allowed Pstate
> changes. The _PPC object is only used for a table based cpufreq driver
> like acpi-cpufreq, hence is irrelevant for CPPC based amd-pstate.
> 
> Hence, the cpufreq_update_policy() call becomes unnecessary and can be
> removed.
> 
> Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

I'll queue this for 6.15.

> ---
>   drivers/cpufreq/amd-pstate.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 346fac646eba..107ad953ce43 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -852,10 +852,6 @@ static void amd_pstate_update_limits(unsigned int cpu)
>   			sched_set_itmt_core_prio((int)cur_high, cpu);
>   	}
>   	cpufreq_cpu_put(policy);
> -
> -	if (!highest_perf_changed)
> -		cpufreq_update_policy(cpu);
> -
>   }
>   
>   /*


