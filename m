Return-Path: <linux-pm+bounces-33989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F4B4593B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C680583484
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034242D1936;
	Fri,  5 Sep 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIMqyhzs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5021A94F;
	Fri,  5 Sep 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079438; cv=fail; b=gVkdrq0hiZyYGk1CXJew/oDYLhY4/ZlBAlFL3BOG+DiwVN7CR1OMplRhVXmM6ERQ0+FndOoP4qWvcNm14U47gF+klZgPaby7+3rdcaChajvoHfsZ8xbeVHs0/ENn98BFKX68gTtd+KbR/BC84QzgKslMgbeWa1a/9/gsBlVNSt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079438; c=relaxed/simple;
	bh=RNs/NC/AlRXHeXd+DhKEDeX8CY/1bjAYnFoadlOEDXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PmlSNfyi0RWbl4xQIJfxy3U45KY77wAd8jyaP+FEDD9YJl7KgThHDVoygF1U3bjABWVT1oOmFs2z1zQFiN/4oy42APoyhnuxADIRM+x0P4pAgtMS2sWUS9KY2asYqC8Dd09Y2M8JL+XSV8he+HrGtN3hafkHTXvS34SupjEo/ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIMqyhzs; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDNiBK2toVE6Vmz3NueSqpjiNFC6QaoiEC2G7r5MILLAKw1KF8A5Q6lqovLOzFrpVlGH84Ab5+rjoPpD+HUXRQ0vU2590wn6oWClv60RHV9fi/Ssi0iWYhj67LtnFeOwq+XdrBLwSs4YhiC/PV1h9BjPPdqevbos/sYhkii95o33Q9SfYs2SIGW0Nc/ugru98O+bGRFsZ1X+cvleeSgnni3Up03mMLou953qLBUBRFEuAkPBa0Sg33Qmd/jRU2r/oeeiPkKt3X+6i6owaibTO8NQRFqWFqjoB9f6wcr+30RRTc3pmmn+Fvu8YaoA9n6DrmfPZlavAD6Dj8Qd8Yraig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNs/NC/AlRXHeXd+DhKEDeX8CY/1bjAYnFoadlOEDXQ=;
 b=LKEA/QVSrAOpniQtmBfa9Q413iUpJKbUthjtJL16/FDrD8ZHvt/2LURGYUNH74mYHKUjC5vk972HBRcq8eCDJaelLSB5VZ4Idimk6g80Vnu8So1dhQCdHudaAWRlUFfv/6QG/dKpU+S25QcPKvHGpNYeUduS/MWwpm7yQBVXKnlghM9eyb1qrYKIsGl4yT2sYS4Il6ZiJW0T5ANob+T6N/Sn7Pvmcf03juRY7/+x075xTQZnj2uOtyCFj6B+s/ESXsWniFtgZYS+KTGSU1frhegtTJmktfBlSM8Ju3W9QufwB+QFOEOEk/hBiDuzkx73XolFbvtGUu0R+8vnqovpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNs/NC/AlRXHeXd+DhKEDeX8CY/1bjAYnFoadlOEDXQ=;
 b=WIMqyhzsr5bQM+A89Rgxmohi2tTLEhy/fWPB3uOIM4gARlQbiz0jinMKA9Mz0DoeN64C4EBgraNaMj3YJ+ADfC7j0qKW9emnbiXe4/1+nVbiAtkBcNpV4nE55Qilb1OEV0fLwSlnpz1Ow2kgCgVB0ldSpCQFhbaxlIZ3Y9nYohFsU4WuNMadChCDnqdUi2k8OXLg0CAJApnY5UUsb8MMOYmtfGgwGOJpXQZdQSyQQDBLF3YIynlCs1NydW4r1DKUfNCsKO6722uT2aL7La7vGYqE7A0TG4FcgxHaYY3zHb0FnB5AzxDMqhNwfjAPV1cWNliS9yEh3Re0I4AglzTvhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 13:37:10 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 13:37:10 +0000
Message-ID: <55e28e33-5a9d-4528-a44b-87cdf66bc289@nvidia.com>
Date: Fri, 5 Sep 2025 19:07:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on
 Tegra186/Tegra194
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, bbasu@nvidia.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, sumitg@nvidia.com
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <cfffcabd-c33b-46f9-9b16-b6063ceee4c1@nvidia.com>
 <CALHNRZ_-V+tQCy8k-fh7g1Q5QF6rWKtTBMK9F4Ah6M5KjaZf3g@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CALHNRZ_-V+tQCy8k-fh7g1Q5QF6rWKtTBMK9F4Ah6M5KjaZf3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: bfff412b-0b94-4ed5-0c1d-08ddec815098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YllDcndiMWpNcnF5ZzlDWCtKV1c5MktEOFE2Z21HVjBRN2UrZ1pXTXJ3eXlE?=
 =?utf-8?B?N3BPUTBkL1RUZUN5OXRWNUkxZXM4TlIxdUV2alJSTU1tbWJ0WlhtNGtvbUlh?=
 =?utf-8?B?RXRyWWloemxSVjZNZnhzaHJ3N1ViOEZCbVR0S3FxNVBzeEg1VXF2MkpQSlI2?=
 =?utf-8?B?ajBJSkhJZS83WUpXaDkyZ0lHOURXWWxYWCtkT0RKNmJUK2NRK2RBK0kxbWMz?=
 =?utf-8?B?K29NdmkwbDl1OGwyM0xkNC9MbVkyeXp1cm8wSW9iUDA1THZFSXQrcjdueUlQ?=
 =?utf-8?B?V2JhclVXYXRwbWc1aVNRMnoyUStlYzlpQXNWdzBMSkJXcnhMTUo2d0g1Y1Va?=
 =?utf-8?B?UnVFb0VlK0Z4YmNCY3NXdncwaFdkUUpFMms4VDY4Q0ZhZ1dHRk4yN3NKUUl1?=
 =?utf-8?B?VUtrOGdHU1NoNlRxZWMzd2VCLzVNNmFlbDRncVF2TWxTcEg4T0dieUtGK1Vj?=
 =?utf-8?B?ZFg2UVlzOURic3FPOXNkbUU2MFRSRHE5NFBjSVh6RnJOK3pYbXNhNHFJaUll?=
 =?utf-8?B?MzRlelpDQ1BjMlVGaUoyVE9wb25BVC85V0lBMmZhSXByRWtmSE1wMkg1WFFa?=
 =?utf-8?B?UXdpMEY5eGpiUDFmQitCN3pNL043VGdnYUZzM0htZXRkckJmS0gwZmJGby82?=
 =?utf-8?B?d3QveDV6V3VqSWNabk5MSktZb1BuZmlLZVVJN0NFd1hNZWwwTVZndWN1eUR5?=
 =?utf-8?B?ak9MWGNVRW9KbmdyZWJQU0ErVngzSlpDVjBXNEV6Y3ZURFZnOXJ2Q3FtK29M?=
 =?utf-8?B?eWVsRnhzdDk0Qi9ZaXUvaEVvL2gvaXlXSmo5WXVOandJejdveVhNUlc3UWtC?=
 =?utf-8?B?aDBMR3ltUzl5cmJZZ2hzZENCVlFzUStmbjJYMnliR0cwcU9rZ2Nua3E3aHBX?=
 =?utf-8?B?VUdWR1c1ekt6NXdHN2RKUTJvTGIxTm4rekkvSlpZdXdBVTZKYTArUCs3QjJn?=
 =?utf-8?B?aTFLK0VQMUpSRVd1Wk02bFU4K1lZdW1NWjQwWDlsMEhmWWx2OUxaMm5DUU5v?=
 =?utf-8?B?eEd1UzN4cTd4Z1Y2cEM3ejZ5eEdzZnZ6STEveHYzL0Q3UXR1WmFpbklINmU3?=
 =?utf-8?B?dHpEaVBKQVlHMWFjUFJGS09JdU5pU3FaaFROZ29FTTBIcW5uK3JmVkl2Z2Y4?=
 =?utf-8?B?UENSVktZM3pZdjB1MzFkQTNiSEhNZnhHVVA4a2dOc3RlK3ZlZkFkYmVPUW1E?=
 =?utf-8?B?M1VoQ1pKSHAyMEFGOFZVaUpzQlpxdFJZTVAzRXNKcmhUeHdYTmV5RGtUV1Rh?=
 =?utf-8?B?VG1ZMmVtM3hQYW9XdnhtMVVTT2pJSmt4bkdPNXZUMzdKME1nZ2ZZRTNSOHNH?=
 =?utf-8?B?cWY2ckNocDRpMk5kclh4d3ZCWVAxRWxCNFJ5MGRzUmttT05VNXVJbktCVUQ2?=
 =?utf-8?B?cTNhdk5TbnBiYnFZQU1jQ0Y4TWNXUTZ1ZWk1VThZdko1M212cVNuRXY0Q0VJ?=
 =?utf-8?B?QlJkbUIrcWVxNGRLS2tlcXB5MUVZbXlyQVh2TnB6YnI4SUlOK0M2TUdNV09w?=
 =?utf-8?B?Yk8rNkxVaFRyclQ2NXdCSXZkTXZ1Z1VmYWpKRlNISHdmMDZLMGx1M051Q2Zy?=
 =?utf-8?B?UXRreGxSMVdlRmlVU0hRQmUvRmFtTzFlQ3JteWhQd1VzT25jMGtoSE1SV2ow?=
 =?utf-8?B?Q205VUNMTEdTc2ZnVXlNMy92MEpXQVRHZnFEanZsRW9ad0RsZWdWblVhRkpF?=
 =?utf-8?B?SEhTQ29vMVZodXR6QUtxcDZIMVZBMHFwUjVQT0ROdC9WUFd0OWNmdG9pQzB6?=
 =?utf-8?B?ZlFJTitDZVZNeks3ZCtmclB4TWhHRjI5R2cvdUQxdlk4ZlFRV0hXSUk5QUhS?=
 =?utf-8?B?ZzIxcXNLbkxDc0hFeE02d1hDV1RBTHliVVMzMjluS3dteUdLS2tWM3RxRVdM?=
 =?utf-8?B?MG1jZGdDUUJ4OGFzTjgzOUZHK0ZNalEyZXJBVmRQV05hWFJUdW80Ni9xd2FS?=
 =?utf-8?Q?+zGKyZU9Kgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Slgyb1VFcTRwZi9KdXJqTS9qaTk2anBPTDF6N0dMTGVCSVQ5VHBQY01TbTY4?=
 =?utf-8?B?NnJKVHF2ajBVcG8yNFFyMGJkZkRpOE9JRjNpMGRzdHhwdHFMN3hhYldPOW1D?=
 =?utf-8?B?SVAveXhSMFdMNVpRVUFpTFljeFB4S0ZscHIrZ0hRUE5TcHRTVWRkNmZZWmg0?=
 =?utf-8?B?V1VIQkw5MzkvOGNpZWh0NHJuQUVWZ1gzWTVjZlNyTlV0NkIxQUZqVWNQYndm?=
 =?utf-8?B?SFdaVUFqWWhWeCtJK3FBZWhxODVjT2k2Q2xtbTlYSzRkdE9OclFHUHhES2pK?=
 =?utf-8?B?ajlLcUtCWkw3Nmh3VldDM0huemtPWUJZUk12aWJQdmxhTzNpSnk0MlQ3WTVn?=
 =?utf-8?B?RS8yOGU4TDN3cUgzZVRCS1c3TG5IenVnRW5VQnJhK1ZJQkFDekU3MzVWdmFM?=
 =?utf-8?B?UnpmTGVmUzlOZUY4a0xSV0N5VndONXNSNUxFZS9LZHZ0N3ZadS92QUpKbnYz?=
 =?utf-8?B?aFhHUFFITU50a0JXa0VheDlaRG1WLzZXZ296QmlMdjhLb21oZVF5Q1Y0QXZM?=
 =?utf-8?B?Njc1MFVGSlVkNkR2RS9rT1BOcFJvUHpHcWdHT3FhbVkwL2RWQ2ZuMGFDZVpm?=
 =?utf-8?B?S3dKN1VNdThWMmlpQitWaWZKNWFzTW1QaXZWYStlckNZbHB3TFVRV0p6S256?=
 =?utf-8?B?anh4NWlTOUZuQ3g1NjhobWIzS2ovRnJ3WnNaVzlMS0IxOXJKbGR4SFphR0ov?=
 =?utf-8?B?OU5IeXpXTU80SWtzcmwwRmpNOVpjSjJMb1JQT1RqRVFxc21SYzRTdk83eHlV?=
 =?utf-8?B?QTNUbUtrZTNWRm4vUUFONERyNEdoMDg5MHBSbU56bldva2pwVE4rWEFyOUtJ?=
 =?utf-8?B?ZXh2NFp0Y09UdkRCTkJOc0theEFnNzgza2dNdUNLVGFZOEp6NmxqK25icnFI?=
 =?utf-8?B?SGFCdmVHc0VVZDJoT0Z4dGpSTlNDUDl3Yy9XR1IrcStKbkVJWEF1OGpFYmFo?=
 =?utf-8?B?MnVYdU9USjBTbUIxMEtSV294bWJWMkdtRFZDbW90Y1pPdE9aNzUrbGVhZGw2?=
 =?utf-8?B?ZGZFdEViOHRhV0E1dk5nTUxFMCt6Y3FYTEtuZUcwWlRUbWVWdHY1NmZ1WkNv?=
 =?utf-8?B?ZTE2bUpHMW5uaCtic1pjbVNReW5CMi9rTHVQTGtaNVk5VnBXczNoUWl0aHZM?=
 =?utf-8?B?SDU3aG1wZjQ3TnBaZW9obUxqQU44RHovdmRJUERhYkFGTnFBRXZ0OG42d2lJ?=
 =?utf-8?B?bmZZa2JqU3RXMEhUVmpQeUdUN3QyaWh2Z2lQODIzOGJIM09RMk9lb2M0RGRC?=
 =?utf-8?B?dGFiUUJwUXYrRnhTcDVwMTJEanFXdmUxZE5DdmxTS3hSK1hZSmJqUVVWL0FM?=
 =?utf-8?B?SG1NcG9mMVY0cFU2THZrTSs1OGJVSXdra0hhc1JGUWIvVm13U2ZrN0IxUHhi?=
 =?utf-8?B?UTRFMWhlWTRDY0tRbUJOZDZjQmpVZHBnNEhKUVdpYTErcGVDdUxoeEEzZGFh?=
 =?utf-8?B?RVZuditXZVM2V29hbkVzN0gxdTF4S2tSaTNrT2gvMDVNVVNaQ2d2ZzFkMk4w?=
 =?utf-8?B?OHVueURMZlFaTzdiRm5qOGFQQUo2V0hVcTFuMlptM2dJSy9Ra0VwUG9JZDlE?=
 =?utf-8?B?YlpyanlTNFppYWN0TzdwNTRETDJ4dVp3KzczcURPVTRHNEdYK3BXajlqM25Q?=
 =?utf-8?B?OFRyQzJUQkpSTktsU3hRc2psckpveHZwYTUzbzlXWUdtOGwrdG5HdkZoM3N3?=
 =?utf-8?B?UGU4UndjZDlxZ3lKK0pUUjh6cDFJcHowU2lGRy84aFNtemM2U2d5bFA5RjRy?=
 =?utf-8?B?d0d0K1RYeGlpQlFURkpsbkNQY0gyZzdLOVJTcXNBNTd3SytqUXhZN0xRVkVx?=
 =?utf-8?B?RWNiSXV0TzBzNHZjNzREZ3FQV01RZDZmaFpvK2lDaFc3QmIxT01nVFB0Z2pN?=
 =?utf-8?B?TDNZYVUyZ2NQN1JHNVFqM25weXV6TnFZUW16WXNMYTFlTWtyVTA0ckx2WTFM?=
 =?utf-8?B?dyt4bDlOS3VmTU1WQUoxOFIwbGpPMnNEY3NLMzRJajFsWWdaVE9IbFUvbGk5?=
 =?utf-8?B?NHM4MU9JeVd0MzB1djZDT0ZGRW12cEJNOFIxOUtyTE1uM3JqcmJneTAyT2Z6?=
 =?utf-8?B?bXBQNFJ3RDRhU1NBczMvbDIwdVlFVTVoaGMwMno2SkY3QktGVTRiblVWcVZS?=
 =?utf-8?Q?pEcE6xcc2rtX+YTqXVhPE1/Mo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff412b-0b94-4ed5-0c1d-08ddec815098
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 13:37:10.7570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aW9zzSt9J1Z1DFLbEoQNLLXlMFz7XTNvKBAd3eoG6fLSHsZozE1G6uhvbNYJVq6TPMpf/VDG5xm9j/0UIKXELA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970


On 04/09/25 22:17, Aaron Kling wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Sep 4, 2025 at 6:47 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>> On 01/09/25 09:03, Aaron Kling via B4 Relay wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> This series borrows the concept used on Tegra234 to scale EMC based on
>>> CPU frequency and applies it to Tegra186 and Tegra194. Except that the
>>> bpmp on those archs does not support bandwidth manager, so the scaling
>>> iteself is handled similar to how Tegra124 currently works.
>>>
>>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>>> ---
>> Tegra186/194 had multiple drivers for BWMGR, ISOMGR and LA+PTSA configs
>> on the CPU side. I am not sure how effective this patch series will be
>> in absence
>> of those components. In Tegra234, those were moved to BPMP-FW. So, Kernel
>> forwards the BW request to BPMP (R5) who takes care of setting the final
>> freq.
> I know it's not ideal, but it seems to be working okay as a rough
> approximation. When the cpu governor kicks up the cpu freq, the emc
> freq scales to match. In my testing, this has been enough to keep aosp
> from obviously lagging. Existing drivers for earlier archs, such as
> tegra124-emc, stub out LA+PTSA as well. Does the lack of that handling
> make things worse for Tegra186/194 than it would for
> Tegra124/Tegra210? I'm trying to improve things across all these archs
> small pieces at time. In several of my recent series, I'm just trying
> to get any form of load based dfs to work, so I don't have to keep
> everything pegged to max frequency with the associated thermals and
> power usage.
>
> Aaron

I am not much familiar with the previous SoCs. But yes having some kind
of scaling is better than not having at all and running always at max. This
can be a starting point of more improvements for these SoCs in future.

Thank you,
Sumit Gupta



