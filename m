Return-Path: <linux-pm+bounces-15904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544D9A2DCA
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 21:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712E81F21EF1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD22281C6;
	Thu, 17 Oct 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4YRDf6m"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA822737E;
	Thu, 17 Oct 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193274; cv=fail; b=dqBkMa/bg8yUbnwQuZNfOmqbXFCf6KYCYE51R9eEkzDaKnHhBbKUr9mKaHhgo4WASawGO+njjygWya8E8LEhNLb7kSPWRWH477VGFJDcf0Hu3quaHRMBNwu3ixem6wzY+qVhnSNOfmxTRGhDuZK/N7lg6dez84GdMnDq5M3lnGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193274; c=relaxed/simple;
	bh=OhfGDSSU9hns11hxJIsFuhgRh7HkUBmLqfCIiYZGNGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0CCCoHiUUL+gJ5bCNJ+WfTEeE9qDE+5PcntrKxCqtzYiF1s4bc3jzane7oT5HE7N19+fWfMz+F91QKtivh/pt/Jt76J0HK4wOUvfCONwVFZ7MI+8TYcuvV1n6sReYxD8s2bxfxxKU37IJ1BGi31iWO9fxicK+rcVUuI1DHFT90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4YRDf6m; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVCie10lQcO3xsZx6ZRlxs8U1+Upiow354yeCP5YiQTRkwD45qj05hSLme7NO+Twa3+27uopLTuPsGSLvu3u+1jKvBbSsq8SyznNG7NVehNym6PQvykqj5T3fzYNbsdlZHeIKnp/SXihxseKG9QolCFrqHMLlYfAF9O8vqMMJj21opbQNiFvR3gBQ+RegDYX94E6EmMMr3wi6vKhzABpAx02KKiBVI38Z9fydaNy/QtwrtSPBl0v+H6uens20fu9QVwPHopjPKtJWfDBUSy0d240ATlVCMakTSTaiIpfG73kfi1m5zmPluAJkpChaixAQjw6KSUMFil7xMMXBliObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3/pjh5M+JLlTbFFe7jmvBCEbQNm+diM9gNQnoYzhSk=;
 b=IKavz8FPgJTdRo9rLMDkUudLNfPgC/Wwr5GPiBSR6txZLyA6y6Z8U6nOusjCyRDK1K3QYiXZpHqdirCIz+m+0wkoU//Oj6S1YEoLEhWH8PCUrKozMbMaO7nsJkQe5x5sOoEV2meT1iSLoS8MjDZn81rjIua3/5nZ3hU8QvfNcB560Zr1/z9ptUUc7SJWFRFzyIHXYOPCtLZ20zaWthCZRgs9L51zrw3AS0NFGM8LHwtl0wR2JG4ve2jYi6Ufzyegx+Iv9BOZdrcEEbJWoMaN8cYTxDKQviEMALlwHb16lyXO6ol5j/DCVVqsidjl4ZauXdXdYt6/c2tQO3bttOc+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3/pjh5M+JLlTbFFe7jmvBCEbQNm+diM9gNQnoYzhSk=;
 b=E4YRDf6m/DW82T3IxPLNwbXlkm0l/MhzDkR35ObjJ+sPdOOU7Y4Hwb7tW7nsnzY/Mo4GwTjPFagMxnNboXaZLFCW82x42bpddKVghsfraurPUcuLSHjRjHJuDU+COG9VIy5Ril/7y4ofYkVzcflyF8wEVbqKXXkm8W1pY2eBtWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 19:27:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:27:44 +0000
Message-ID: <2276df05-86f2-4f4f-a790-e26d09859352@amd.com>
Date: Thu, 17 Oct 2024 14:27:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] platform/x86: hfi: add power management callback
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 x86@kernel.org, Perry Yuan <perry.yuan@amd.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <20241015213645.1476-1-mario.limonciello@amd.com>
 <20241015213645.1476-10-mario.limonciello@amd.com>
 <ZxCoG7vaLmvTMXFT@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZxCoG7vaLmvTMXFT@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 840a8931-f3a3-4e01-7978-08dceee1c6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzB4WW9wNnU3ZThuc3hHV1huV3Z3SkpsdzBKZ3ZaeWtVRnBBVWJUK3lkalBX?=
 =?utf-8?B?NEFXcTlvNE8xbCtsek5hSVN1ZEJsL2pta2htOUlGNmNTeFdxUTZUL2hMcWZu?=
 =?utf-8?B?ZW9PMURCbFdFK3M4VW53UmlSZnpLaGoySWxCdVRXcU5ZVFkySE5LTWV3MVNK?=
 =?utf-8?B?ZjVneFBQRVR2VVkrbzhWUlFWdk5LVE1xaVFHdVRkSDdmRzkrM2tNY1lhK0c1?=
 =?utf-8?B?S0NXM0NEcmFkblZZRFkyR0liU256VVJnUDBNN0hHLysrdlRDWGhYaUVJRGcz?=
 =?utf-8?B?eHFYMTQ0aE5ZSlhrbm93Q1lDSFdHbHRnYW1haS9aSTl5eTR4U3RDN0ZtYm9y?=
 =?utf-8?B?MmRETk45WlJVOTNrck5kbTZ3QWtCelBOdkxBUGdwUWY2cDB6UHpXNzdCVU9q?=
 =?utf-8?B?TWxqZUxVeWdVN040MHo3MDRwb2h0SFBWNlhnWjVhQVU1amtKRDYyWnpLN1R3?=
 =?utf-8?B?QkR2NkZSdXpvejR0ejFJSmpVUTcrK1Y3d1lMcXlUeUtmVWdHb1plVmJRZk9u?=
 =?utf-8?B?UmhvWmF6TWc2dU5oRHNnS3VqWVhXNi9uMjZSbGdxTFkzOG9KNDVDbUhnMHJT?=
 =?utf-8?B?U1R6ajNETzcwVXlUa3F2cUg1RVFLN0MzZW1IaDVkK29RK1htZ3REWXNYRUpa?=
 =?utf-8?B?MGg2VW9uRDBnMmJnb0VaUlhqblJsU1p2MWJvZWxDU0k3cGFsVDJ0dE9VUEg5?=
 =?utf-8?B?SmVMZjhVSXBYaTVqbHBhTWIvKzZiYStZcnA5NFBtN3N5U0pPd3g5Z3NUTkdK?=
 =?utf-8?B?SllrVERHWVRtMndqRU5ZM1lnNnhxSUtQVGFzRkM4b0VRNUZwSWRXZzYwelZ3?=
 =?utf-8?B?UWNlZk5nbHpwZ3VrRVRCanJPUDhFT0xhWHJsb0xVTWVGS3hlOXJzRTd3RU5j?=
 =?utf-8?B?aDNjajExb3JZSWJ3K24wSnVYZDlLdHZSbGtuRlR0SGhNWU5TZW45TC9hemhF?=
 =?utf-8?B?cldvY3pzQ1VleFJCOHdCbHphSFhBSWsvSWlYVktFazc5RTcxNEtIaGZOdUtN?=
 =?utf-8?B?R1FHTk52NmFkUG9FQ05FbmdtdXpyUGY0RTBhK0lBdW9NbzEzeHZIR2ZrZjNS?=
 =?utf-8?B?bGpZU3AzaGxNbVNRQnQ0amVmQjl2TTBka0IxTFQ5Q3NyS3hBN3pLNmFSSmR4?=
 =?utf-8?B?cjRiUXhxZGo3b2orUjlMWHhURzBYNUsrUUN4VnV1Wk5vS3hzemRGL216OThD?=
 =?utf-8?B?aGV6MU5mcW8ya0NLNVV1R1JBZ29XS1FpRFFsZUZHUG9ybHFMdzBuTXpGTWdj?=
 =?utf-8?B?VGdPeHg0dWJ2ZURFWmFKbDhuT3pFSmpxWXR0WVRycDhlMTFPcHAwZEc3Z3Iy?=
 =?utf-8?B?OE1zY3owc3FjWkdvMkVBUGd0ZnNvbUJNd3ZiRnJ4N245b0VJYjFweUZiRHlW?=
 =?utf-8?B?VFJ0bHJwYVMxUTdGdGRMR1JreGY4Y0J2YWtDNWQzRzUzQWxGZUxMRzU5TlF1?=
 =?utf-8?B?ZHRORWZOQ3ZBUHZNMWx4SklzY1hnc2tIdnVzSmtNN0plY3ZHU2t5WEZ2YVpI?=
 =?utf-8?B?N3JCd2tKKy9TS3ZLZzhsV2M5QXcvdXZXaEhpU0xnMk9PM0Y5RENLQWFFZXM2?=
 =?utf-8?B?Z2ducXNaSFFHRDhPODdLdElZK0hsb3hUOTJBN0Fud0I2eU5FbWdqWUFsOTRr?=
 =?utf-8?B?MWo3K3cvWDdQWE8rYWtpcEFsWWFJL241cSsyZkNGcHY3YkM3dkFWeUVyN0h5?=
 =?utf-8?B?NmFhTStFdk9UajRQT3BQQjhyM081RlF3VjFqNi90K0E5Tm4rN0Y2Zlc5amp0?=
 =?utf-8?Q?tyPyTECaAMqj8vi3GBvePxf3Xq5wocGgphSxEgG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enhKN0VWZjA4MnMyS3QwMC9zWGxrVEZFZE4wcjFFeS93NFJjcHlGWlp5SlN4?=
 =?utf-8?B?VEQ3Ukt5RDhRL1Nwck9jWSs2RWw3RTNBSm9QMWhHRDM2MFYvZm5HVFBpRzZC?=
 =?utf-8?B?a2JlS3JqK0ZJR25JSkxnWTNQM056RFZYek1rb3Q1T29pVkQ1NjQ5TzR5MEtE?=
 =?utf-8?B?SitnWGZFYk9PMks4ek14Z3FwRWdnS1RvT0dkWUZ6Q3Z4S3pKUjNCT21SeldM?=
 =?utf-8?B?ZEJEemNLN1lhNXlIUG1Lc0lGc1p0WEdjZ244cFpCcWpjZDRoTkZTb0FEWFIx?=
 =?utf-8?B?em1nbW8xUXVLU1ZzRUZIUHMwZmdEbXhiU2gwZ0ZDZlJQUlVEQWMvdmVlQlU3?=
 =?utf-8?B?bTRSTzRWYy9KUTdjc1ZlODg2ZTUxYUhFRWxaQ0F5YlhQY3YrM0x2WXd1TDVO?=
 =?utf-8?B?ZWV2WE1hU0diWUQ0WmtSa2NPcjFIZnNqbFR5OUFXZkh4VHdDMHFEaEhXdmpT?=
 =?utf-8?B?eG84S3pkUEEzeENTNmY1M0kyallYUUMrbEc5bDRRQ3pnUWpuU2w3TVhkdi9v?=
 =?utf-8?B?R0ZVNkpHMEZhL3VwWXBRRzhJNU45bXczK1lOOER6eVIyWEJEdUk0OTM4QVVU?=
 =?utf-8?B?dmxTQXJRU2R1UHF5cXkzVXRRbGFrSjBIeHYwZnBjMmEvUGEvVGQ3eUdER3Ex?=
 =?utf-8?B?QW1KckIwYnBYOTJ1NjRYbU56alV6MXdhZi9sTCtiRXZkVmNGM0tzUGlxVkEv?=
 =?utf-8?B?eTVPb3dwS2QxVmJzMlJDKzQzOUZmTUtvQ3dzS2NrdzEzZ1BreDZ4ZDVQMUFI?=
 =?utf-8?B?bzM0Vm1zN0k3Zm1FcXBiS3lBUHJjRmtUVmY0aVNEUzlqSk9DSmZWK3V6K3BV?=
 =?utf-8?B?c0hqekJSL016NEUyNGlYeUlFZVBsTWE4WHoycnB4Z2FpOHZBVHJNYWFaYzlk?=
 =?utf-8?B?ejFkVTBteXlWc3FhbE1FSXlPMVgzSzE4dHNkbUtOTUlHWEhybFVONCtpbDBS?=
 =?utf-8?B?QjVoWlNSa2FDYzNvMlFWL3hDSHNUc0pucExjUk16VjgrWGd4YWt0SW9FZ2RN?=
 =?utf-8?B?LzNGN1FEY01QY1BTRmdKOER0UGxPd09yY2Q3NDVXdTVJK21TS0FFMmZpY0dX?=
 =?utf-8?B?WnZOZU4zN3ZCczJydjBIVUd3VFk1WG1zN000bWV0VVJKV1pKLytUMzdkaUdE?=
 =?utf-8?B?OUVyenhYOWNWUTdJYy9GSkRER2NoNS84Z0w3dnJ4T1Nsb2U4NWcwRUQzQ3lG?=
 =?utf-8?B?S3NRZ3NsK25uN0R5RG5BU2JkMHlQMGIycUZUN0c3dEQzRTBId05VQURBQWJC?=
 =?utf-8?B?UytDQVFDZXJvR01rM1dQK0JGcUpURjl5emQrOWFmb0VLRjFndml3SCt5Tk1n?=
 =?utf-8?B?V2p0aVZ4MEpHYnBiYWxULzRmZ0NveWpib1FDUGFWSnNiN2pZTXJFblFNNE5m?=
 =?utf-8?B?R1FsMnVFTjBKYTU1SE4rUEZoYXdlQUQwaE9UWEdMM251K041SGY0SEs0TWNG?=
 =?utf-8?B?WW1YU3NFQ3BJSnovKzVTWnk1VnFXV3Urc213NldvdTgvRno4VTN1bnNGeTd6?=
 =?utf-8?B?am5JOTNuL3ZGcDlZLzZCRklvMER5Q2VEL2dXZ3l4MVRLZHhYTEsxWVAwUnBv?=
 =?utf-8?B?b2JGbGV4bWFwTXBMLzFFK0tSNTVDTWlncWthN2NqbDEza0E1a1JCUVNid3ho?=
 =?utf-8?B?YU5qRnh6dm5JNmQ3YXRPSksxY2NnRkJOQ2pVaXJlSm1nb2ZOWmJMU05BY3I2?=
 =?utf-8?B?K0wyUUt3UjhlU3ZOZmgyNDhMMUYzSjBwc2tXNlltc1dZWFNNUitFSmhOdU9G?=
 =?utf-8?B?YXdOakxGVFh5N0pObjczc0hScmQrQUFpcDBPY2p1Q3hWbW5VMkl2OWFvb1o2?=
 =?utf-8?B?MUpocmhTaW9qMWFpSE9ZNmpnOXZjc3ZkYzF5Z3JUQkNHcHZ2UE9ySWhYakxE?=
 =?utf-8?B?eUMzdFllVzgyZUhwWXh1bnJ2NFh2ZGh5di9wdUlzMHY4c2ZORkdaWUh5WlBR?=
 =?utf-8?B?eTE0bWFxdXBubStIblQ0M0VOQ0poZkh5N2JUNWIxalh3U2pPcWZERmFlSFIw?=
 =?utf-8?B?elBWQ1J6M0IyWEhibHFmb2JiOGJDYUdzTlA5WWdNMHI4TTFkREMrSlBZQnFw?=
 =?utf-8?B?OVpTUlhGVWZTYXJnWHhMTEw2UmtzTXlVZFFXZ1piZVZXNHEvdWk3VzB2V3BU?=
 =?utf-8?Q?TOAv72wGrsPoyUkFdRNCsTKel?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840a8931-f3a3-4e01-7978-08dceee1c6a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:27:44.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVG/aMQCueKXGnhvvjkNe5ZCt0IycG/VwcUqiig4MmhbhSmNHwY3O+lu9AZTGuC06UD4tEi+T2xZFeaKCWpKfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

On 10/17/2024 01:00, Gautham R. Shenoy wrote:
> On Tue, Oct 15, 2024 at 04:36:40PM -0500, Mario Limonciello wrote:
>> From: Perry Yuan <Perry.Yuan@amd.com>
>>
>> Introduces power management callbacks for the `amd_hfi` driver.
>> Specifically, the `suspend` and `resume` callbacks have been added
>> to handle the necessary operations during system low power states
>> and wake-up.
>>
>> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2->v3:
>>   * Whitespace (Ilpo)
>> ---
>>   drivers/platform/x86/amd/hfi/hfi.c | 33 ++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
>> index d971ec1124af..79963c423d35 100644
>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>> @@ -392,6 +392,38 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>>   	return ret;
>>   }
>>   
>> +static int amd_hfi_pm_resume(struct device *dev)
>> +{
>> +	int ret, cpu;
>> +
>> +	for_each_present_cpu(cpu) {
> 
> Shouldn't this be for_each_online_cpu() in light of the hotplug
> notifier callbacks implemented in Patch 8?

Thx, will fix.

> 
>> +		ret = amd_hfi_set_state(cpu, true);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to enable workload class config: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int amd_hfi_pm_suspend(struct device *dev)
>> +{
>> +	int ret, cpu;
>> +
>> +	for_each_present_cpu(cpu) {
> 
> Ditto..
> 
>> +		ret = amd_hfi_set_state(cpu, false);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to disable workload class config: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static DEFINE_SIMPLE_DEV_PM_OPS(amd_hfi_pm_ops, amd_hfi_pm_suspend, amd_hfi_pm_resume);
>> +
>>   static const struct acpi_device_id amd_hfi_platform_match[] = {
>>   	{ "AMDI0104", 0},
>>   	{ }
>> @@ -438,6 +470,7 @@ static struct platform_driver amd_hfi_driver = {
>>   	.driver = {
>>   		.name = AMD_HFI_DRIVER,
>>   		.owner = THIS_MODULE,
>> +		.pm = &amd_hfi_pm_ops,
>>   		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
>>   	},
>>   	.probe = amd_hfi_probe,
>> -- 
>> 2.43.0
> 
> --
> Thanks and Regards
> gautham.


