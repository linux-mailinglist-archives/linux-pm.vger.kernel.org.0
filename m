Return-Path: <linux-pm+bounces-24574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A77A7444C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E3118984E9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E219F11F;
	Fri, 28 Mar 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ng3KVIfJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712321129A;
	Fri, 28 Mar 2025 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743146443; cv=fail; b=snQigzG69+LrPoE4zRwKOLYZ2lWq2guA7iWJiJPginJAgtqh8pOaGaeFO1ul9Uq/+h4fqEJK3Xc52zsRRVQ1AvOBHnfYppEIVQKyRIj8pee9JCsQ2c8ljl/SMwWglkwLs4s2dXc1mo9vYxvEJOscGKuc29/GpPqWNxfjqONsDps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743146443; c=relaxed/simple;
	bh=wFUmCxnlP1heelvFFW0ALpkIiNvgwS+wV11E4ZIl0eQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcjvrAFnA4pREr5YN9NqciXNx1XABciiMQ8MMW8TOk/eg+wnrJF2OWg9hlo7lJrO+WUCjZSeXx+QP5MjMAyAOrkTdPLnaM6mpKIAMaw571T43GurRg4kuITZftmqaAP44g3/27VNlN0Hk/doBzxWVzpNFZ7CKG6H0u8sB00xmgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ng3KVIfJ; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVnKNCaMoJ1mvDyfTt6srypreMNtkGMUL916ClPQDw32ZUt3Sd3CqZJ+3y5b5EgT6CM1s8LhHOvbcrYkAdAvkWZaWlkCLJhgW2vPW6PYyXDYdgt+/yLNAiSKlEnLdGvjwmu2kWSnCaH5xXE08Itcnvi3go8gy22R4rJlSxvKBrpTgFcdzqFWeIVcroa3zuzCdkDA5UjrbKLjZ3k2y6pi6BRK8YOYO7fP1UhxiWkuq/UNanQ7cc/AqLeq2tr1l7UmxpoVf95A5OWR6ggeliB3ZndhwrJh1oKQ/l3J38dmGeg0qrq9t9RmJDOMuUjAE3zoJ5mfoAw/SDobCH2KNz+lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o92vduA0RystV03hM9Vn6a8V6Cf4xbTy6NjoTb3le8I=;
 b=su912jA+v9/O7GK/DfPyulpOF/+0RJNsTt6CV6X+rItex0vn5P8GPnVDNyaFutTLBKqebU3rMVgztR0slioB76WisQSkJR/+KzEd1JDyTvq/JHUhjnk9PToY26TpcIZWjhaubJzXFpsNFYi0CWBKAJcUl+7x7KO0SDyhR3N4CjzHY0aJ6u3LTiHBDoAmGCNlxZnHKm3htyXSkV7KjYJFLmdTQhFr3l6+NTLitLiT0RAVrJgyeJKINJp8BZTWKoj9szYsYEHcKZJxDEO5VcyvcaLzPGdWNxxFakTMCkSRIGCqtCCEQJFXQD6ZqFkEp6jfaCwnlbxz6h7cDZMOUBIwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o92vduA0RystV03hM9Vn6a8V6Cf4xbTy6NjoTb3le8I=;
 b=Ng3KVIfJbG90X2FR+Nz6jpa1XZfToBhG3nfze3qHldDAcwvpSH8wDOlpt6CxYCe1wd++Q10HAVxp6ukdMw9HbMKKN41l1jDQYbroqrfDoGLS3nKiD+yRW9s3c1ilvlPGOmTsZYxspuCn1ZYJ5Nq5fLBjmI7Jw3SgTATwLBFVCEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::985) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 07:20:38 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 07:20:38 +0000
Message-ID: <e75a4f57-37ac-4c43-8385-8b476d3b94db@amd.com>
Date: Fri, 28 Mar 2025 12:50:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Prefix setup messages with FW_BUG
To: Mario Limonciello <superm1@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>
Cc: "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20250320214132.664522-1-superm1@kernel.org>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20250320214132.664522-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 392a6e9f-d3e8-4d29-51dd-08dd6dc90a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG81cTNtWnJZWnhqbzlKdWRwbElCNGJtVkZ6aVN4YWdNcTl4MWJTV3BJdHM4?=
 =?utf-8?B?QkVLbTUxUGl4M0NoUlNSampiS2V6ei9BekVKYzNJaFRjdlBGWVV3ZTlLNTdt?=
 =?utf-8?B?ZU5uTUp5dXBhVkhJcW5KMGgxMGhPVWlTZWJPbEVkSjZGVFU3Mkp3OVFMVE1a?=
 =?utf-8?B?czBLZzJ3VkxScXF5ZVpDenRib3BvcURWSkRaNjBsMDlhTDluUlBVVGJwTGVB?=
 =?utf-8?B?WVFHUG9aaVJ2ZzJma1lTNUNBdSsyaC9hUDk1OHBWa09RZHd1d2psV3puUk9X?=
 =?utf-8?B?SlN4ZGsxYUF5amFhV3FxTWRtdC8rUGs2bUpkSXN1WnNRbU90ci93b1hBcks5?=
 =?utf-8?B?NXh1OEpIZmphVE12MGVwcVkrK3B1bHY4aVRON0ptMkZNQ0NjTmtnK0t1aHJ4?=
 =?utf-8?B?OGNYU3FsTDUybEJRb1lBYmxCWTZOWlFDYmN1NEJ5TWtMbGV3YkJOYmxieWFD?=
 =?utf-8?B?U3duVndLSnNXaGRDZ2hCMHZScEdXSS8ra1pTUHNSdzJuN1NCUUNaUENuOFdp?=
 =?utf-8?B?aVRqaDNtV2lIU0J2WkphZFRQc2hqMlllUGltT0x2endzZ01hZXRMRkRTSFM4?=
 =?utf-8?B?SmFIZjlWaFlUSkRUL1JlbHdQK0NvenhiWGVTME9hVVQ2ODdsNE5CdHZUS0k2?=
 =?utf-8?B?Nkd6QTJ5WXc0R1lwM1BWMFdQTERPSVR4VG9uMzdtSGlNcHRYZGlPQmdTQjEr?=
 =?utf-8?B?SjJVMWQ4Ync0bUdUWnhIZVdpLzBwTEVCZmZrS1VkL2hmTEJ1MTg4ZWNrRjlF?=
 =?utf-8?B?dFhld0RZUTg5cDJpaEdLSlg0dDFhelJaaitMWDVqL3RPZWhPbWpncmJFTFI1?=
 =?utf-8?B?c0xtSzZ3YnRtUjVnb2tGMVB2OEtSMzc2VFZHMHFwY3VWUGhDS0tjWE9pYTNv?=
 =?utf-8?B?SEdSRnNyazUyZnhJeWkrS2FKOERTV2E3UzljMUZ2TmY0RDJzV2E0ZmlFWHF6?=
 =?utf-8?B?dWNVRXRKaFhvMnk3SmtncGs5cncwM2YzYy9HOUVIL1ZuS1pRbUx2MU5HV3JC?=
 =?utf-8?B?QmVtaTduSkd6S3pud3JmaUxaYm9qZEhEZE9CVTdxU1QyS242aFBsOFlYVkh2?=
 =?utf-8?B?VlJsMkdDQ2dSWGVVK04wSTlTR2Qrb0s2QXV4dzhpQUlhSGRVS3NhZ2RNeVJW?=
 =?utf-8?B?ZUMzeGtpYXlwTm9kZC9WOWl3WTBPUDhSMU9ja1V5U0RQOFdZaUVUUTgxa0Jq?=
 =?utf-8?B?MmllODNNWS9FblRGRGVUamFTZkhVZmlpZlp3VVE2N2hpK1JiQnp2UmJ2cnRx?=
 =?utf-8?B?M3V4bTg0WlNrQkk5bmhwaUsyR1lKdloxUXNkbWV4UHZ2c0x2VzcvQ2lkcEhG?=
 =?utf-8?B?MmJDVTVhNkZiSzlNWU5YdHJZSHlVZW43NmxjUFpqVDRGLzhtRjB5amo1dnNX?=
 =?utf-8?B?ZEpvS2FQVGdsUmJXdzBJSCtvbTZPNjZHYk9Xd1k1Zks1YlhsV2FHY3Y1dnZO?=
 =?utf-8?B?b0RxZllQeVFPUk5kdmd5Sk5YUlVLc0wrODJzUTBUeDlGNTl6TjZBK3d0NEZ2?=
 =?utf-8?B?WC9FZXkwUG9pL093OUJjYmpyenM2WHhwWmZGTk1qMkZVdzlhRGhFTGIwOFUz?=
 =?utf-8?B?aGlhUngvTUNPdEdySklNcnNiRmVzREUwM2doUWhDR1BRSUdDemZyZWtjWjRK?=
 =?utf-8?B?bllWNU1WVXk3SHpUYXhVN3ZIcjBLL0w2YVNnTlVLUWV2dStGS1l0K0xaM01Z?=
 =?utf-8?B?TnZ1eEw3eTVBVy82SGpmdGZvMW1pZnQxZmZIZmdpejl2QjVXS3RLcVNWZUZ0?=
 =?utf-8?B?ODFyZnEramJTNU10SC9GSUdKWUFvUnIzZFArenl0V2R1cHZOcEc0NFEyZ1NH?=
 =?utf-8?B?Umw3ZWh2akFQRU0rWnFTenZUMmVKR1BpdWNxeEI5cE1Lak5MQnhUdEVac0du?=
 =?utf-8?Q?NswvJeJv1dLTD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdFQTRXMjdUeURvYjA2SEp1V1FocEU2QUpTd3huT25zMTI4L3pXUDNxcm1W?=
 =?utf-8?B?aVNDTTRnaERFUG04RXhhRitKN2ZnM3BobUhHaTJoU0pLRjQwYm5sWWcvT01V?=
 =?utf-8?B?THcwZjY0bE1IaFk1Rm43ZHBZZTF2a0ZUUUJBb3ZTOUZmSHROMHhSVjV6WHBl?=
 =?utf-8?B?UEZWZjVJQmNWVysvR1UwV08xTVJBdGtPN2E0b3llejE2blU2ejNrSTIwNERV?=
 =?utf-8?B?QmhpSXhTVzFkR05CWmNRWStOTVdFQVF3aU9UUHVQbzdoMTc1dTdUeEI3QTdH?=
 =?utf-8?B?VTI2SGpDVlZJdUNOUFdNekd5WDhyWTRHVmZIVzZBcTBoZkJ6V1BibU5GREhm?=
 =?utf-8?B?bmFMb1hzdjI4aFJxSHRzOEhJZVovYk9kb1hZTitRaDlNNkxQSi9ObElRbkpr?=
 =?utf-8?B?YW5kdTJobVNCSEpqeHhVUCtvMVRDUDRla2phdk43OEd6MzRvN1JJVTdSanZG?=
 =?utf-8?B?MnhpRTRmZ3FSYlhFektsSUpXNkJjamhhS290b0hINkw3emtHNlloemxXaUIz?=
 =?utf-8?B?UjhTUnV3d05ZcUIzYS94ZUF0MExVbnR2eW1OYVFOL2x1dkI3VGRicUZkZ2VV?=
 =?utf-8?B?V3h2QXhGWlVjWnNDeFFISlZwc0YzcldXcFgrdnd6VVBoSUxQREE1TnFmVmdC?=
 =?utf-8?B?NkZVNENlcGhnRmZvVEhMaEFZditQNllNU1ppQlR2TVBISUFzRVRUamU3TElU?=
 =?utf-8?B?MS9IOGlVWitjWmprYWhDaFlkakEvaW5aOXVlbTBKYVFxL1RaVnBPd2FvS0ww?=
 =?utf-8?B?blVQclZ0N3U1Q1lTcEtvNHB1Q095cWt1R3NpaEVaRDdZdWg2STZhUTNiNDhG?=
 =?utf-8?B?NmNWWVFHMS9kVk5BaUpaaitWRnRYUUF4UWJscENFOVRQa0pZd2JZNXc1L0FD?=
 =?utf-8?B?akNnWkpxMlRjeTZkRUtUNUtOQXJuN2d5MmJrVE9JWWRKWHBMQlRUR2NJdG1I?=
 =?utf-8?B?T1UzVENiUGJubWtsNk1LYnk2YXQ3M2xtQTE2U251UW90d2hWSUx2UzQrTkky?=
 =?utf-8?B?WHJ2YzdqNk81RTMwUE5qdU9wVWVldnQvM0pMeitBbnhXVWVVV0czNzh5SEty?=
 =?utf-8?B?cjV6UWs1cG9vN0Z5VGRoTFowbSsyVUlLRlZDbGJRWCttekkzOHBNeVgwcFo5?=
 =?utf-8?B?c0NUQmhVZU1ORndONlIxVkdQcm9ZZFBsYjNVQVcxUWRQZVdOWkNMNEl6aWx3?=
 =?utf-8?B?VEdaQ2t4L3dob2xkY2k2SkhxN0ZmUTVEMDJKQlhiRnU0SUw1ZEs4ek9yUTd0?=
 =?utf-8?B?bDFSOWpzK3B6eWIzWFQzL2ZaVThZcUN6SXkzSi84OUE2ZHJOR1NldGlHd045?=
 =?utf-8?B?WWZWQ09oM2htbFFXd1E3MEdBN1BUZWluU1JWOTQzVWJGeGJzbDlqNUc3MU4z?=
 =?utf-8?B?M3VVbWtIVk1vSm1qUmhTcFFNSUxDaGMwYllvUEpyVjdlcXA4UngxSy85VzFX?=
 =?utf-8?B?NmNxM2FjT21XRzMvZm1xNkVVTWh1bGZSWVNpUzdIc0JyQjJLSldzK0RMdTA1?=
 =?utf-8?B?a0NFUEU5citBcUtmdjFZRVpYTlJWSkhsWVdGNklRSGpHRjhqT253MVBVOUV1?=
 =?utf-8?B?RmdLQVJ4ZU1QTHdGdkJ1Z1hubEw3WXJqeCtQSi9hR3NEaTdGUjhrTWc1d2cy?=
 =?utf-8?B?SlZUZUFkazVuU1poRnF4eFVSTEJKUVQ4YmsxRVljU08zWVZIeWo2aW5zaDEv?=
 =?utf-8?B?VjExc2FDUzVLRDZRdEdtaStDQVpaeEJscjUxUHJVMEdWdHFQR3Exc2Z3VHVs?=
 =?utf-8?B?cktUZ2Y3UGd0UkE5UFVHdUFEcHdndVJVdFBxemRNU3Q3MDM2SSsrdU4zamk2?=
 =?utf-8?B?SURYTEZlRGI0a3FDVDlCR21jbDQ4R0MxQkg5bCtrZmVxeFVvUC9xblV6KzN1?=
 =?utf-8?B?Y1lRbUVXWmJobTNyanBsdnFtSzhSVTlabXdoYmI4Qk43VnJTZXcwdzViQm1L?=
 =?utf-8?B?NlJFZnN0cHdjbVhBUUtpa2JXRk05ZjV6YjRkRzVUOEFZd09vaHZrNDB6ME01?=
 =?utf-8?B?RnYvR080b09GeUcyQUxRcjgxSlhUUW9yalNHY3BoMGNrQWI1bzdEMGxzZTN2?=
 =?utf-8?B?d1pnQ0JZa0pqWVFKV2FNT0srcjhhTlg3WDlpZEwrK21BRVdzT2JLQXU0bzNk?=
 =?utf-8?Q?WJG0g0dIIos5szRsCpQC7/K1Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392a6e9f-d3e8-4d29-51dd-08dd6dc90a16
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 07:20:38.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJxj2r0CBCngp5gVf87Tl48LQ1cbeVKOIN0gTdpRlYcOE2m4q3eujlL/uAj0B/G9khhvs+W1FaU9UDWvp2nDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2

On 3/21/2025 3:11 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> To make it clearer that amd-pstate failing to setup is a problem
> with the firmware, prefix several messages with FW_BUG.
> 
> Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 024d33d5e3670..0a9d6fe426d1c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -931,13 +931,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
>  	if (min_freq <= 0 || max_freq <= 0 || nominal_freq <= 0 || min_freq > max_freq) {
> -		pr_err("min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
> +		pr_err(FW_BUG "min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
>  			min_freq, max_freq, nominal_freq);
>  		return -EINVAL;
>  	}
>  
>  	if (lowest_nonlinear_freq <= min_freq || lowest_nonlinear_freq > nominal_freq) {
> -		pr_err("lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
> +		pr_err(FW_BUG "lowest_nonlinear_freq(%d) value is out of range [min_freq(%d), nominal_freq(%d)]\n",
>  			lowest_nonlinear_freq, min_freq, nominal_freq);
>  		return -EINVAL;
>  	}
> @@ -1505,7 +1505,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  
>  free_cpudata1:
> -	pr_warn("Failed to initialize CPU %d: %d\n", policy->cpu, ret);
> +	pr_warn(FW_BUG "Failed to initialize CPU %d: %d\n", policy->cpu, ret);

Just thinking are we sure that we land here only through a firmware bug?

If not, we should probably use FW_WARN ?, 
or 
Should we add to the error message the specific firmware issue that might cause 
each of the functions to fail (e.g. amd_pstate_init_perf(), amd_pstate_init_freq(), 
etc). 

Comments for the macros, for reference,

 * FW_BUG
 * Add this to a message where you are sure the firmware is buggy or behaves
 * really stupid or out of spec. Be aware that the responsible BIOS developer
 * should be able to fix this issue or at least get a concrete idea of the
 * problem by reading your message without the need of looking at the kernel
 * code.
 *
 * Use it for definite and high priority BIOS bugs.
 *
 * FW_WARN
 * Use it for not that clear (e.g. could the kernel messed up things already?)
 * and medium priority BIOS bugs.

>  	kfree(cpudata);
>  	return ret;
>  }


