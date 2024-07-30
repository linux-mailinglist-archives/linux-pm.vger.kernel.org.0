Return-Path: <linux-pm+bounces-11689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6D941EF7
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 19:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4EE1F22610
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 17:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9E18990A;
	Tue, 30 Jul 2024 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dsa0/mTq"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61121A76C6;
	Tue, 30 Jul 2024 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361443; cv=fail; b=bLyRyfX56grXBOg2yZbTNWd3tvlwTi5HyuoM1xk0JNr7UBRFKyk99D3LIriME6mwB2Vkzbt5VsK2c3VXRQbcGTRtvLmXJJx1JBjFmrTYlm0CSxU+IPlmiL1VciWuBLK78tdWJ/0EfmcF4KmBUnDZhaJ1JgygK/rPagsdQISjIWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361443; c=relaxed/simple;
	bh=LAMRd+tE3PRhtGr+q/yyt9qsvDq5vRXcPDlVCC4ysAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pN3MG7wSsnJJr1DAwbgdTnnXZ7uSxhwQ1CuQC06i6WFxz+JlOCC8+Za/Bj/SiRHhTlCNXgsWTQkcChW32gGKuKu5O9r55vn7SuGzocoWMGPRPnvyCstJuq9iSk4V2IfHrMx1nNrOWXcjmlkvUDrx1XupNA2CSc4CZ9UyvDgBSu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dsa0/mTq; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQixEWcuWjxW8PBS4JHI7cgd9Non11zHVYai0SWXRn8dGAGJmKQLsQJG7EC3yzOyuVfLivJuqzlweW0Ig7yTV5CUhsKT/A/STNMq/sxXsJ8u+KcByT+IusmYCEksyHA2EG5bexDKvgJyPHaQFWkwbkD36e6vbPEqqu0FnAL7RgJvxfyrlTdPXgz/oyE+gZv4vO/O78vjQ4PnK5UrdUOFUlR7yg9cRpSp3Y0QyQSFCYIvvcZZpci5CGOcR6sp+JFoElE1ER3du3PBebd9fNZlXSrR5CvMvbmqPZVWfWNE3chaBwz+z13fyWHrq4iU+1s7itNulMZQPiPVhyV93+N28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw8/bNfQKr+TAaTGOBeqy3fMlLdOE0nKYrhB9RG5Yfs=;
 b=wTZhLTFSZEIfFwNxKD3CbFaeHkuBjGr0RX/yCCA9R7dvTtmoV6QRVOOHUXO45kSKKa+HcCtFHdH3Ci6G0uqKeNlBTcFhalhVw9KBqLH1g/dv/5V0DxIUpIGy1NaqeiTX5UZIfMHcdNQtN1j8fuUONgPeX6birHKmrs5cR6jMLxVPS6Q74E74NsW6Qoj5xNQt4alMuQyLn76r6C+0F+pnCCoyVSWIu9oVZTx6DYHmw82OMKvwgwZd/al8WhB1OC0NRHone5hI5aNIXctG5oniqp5UF5puKSPLXDyPyk8/d92HyfU36qnWhvJd4wAf7OpRbHuyAouAToyBZWyRuOnHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw8/bNfQKr+TAaTGOBeqy3fMlLdOE0nKYrhB9RG5Yfs=;
 b=Dsa0/mTqkEFnMBfPWqokPDSQC3yrZVF211+13t5H0EmJ2MnRCgfRZaIVYpHpMVIPs8l7r888TyYZL8GIt9tM9fX7B4bKlwai5IBs3L+YXiOvQaOWCwFcnJNVwicvez+G4OhgZJ/IY9Cm9IQxo07fH0SPLiWMMlIM4TBGpfEcP4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 17:43:58 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::bc87:6c1b:cadb:67a%5]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 17:43:58 +0000
Message-ID: <1d5f4859-6810-355f-3e0e-ed1c9e53c3f4@amd.com>
Date: Wed, 31 Jul 2024 01:43:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Regression] 6.11.0-rc1: AMD CPU boot with error when CPPC
 feature disabled by BIOS
Content-Language: en-US
To: David Wang <00107082@163.com>, perry.yuan@amd.com
Cc: Alexander.Deucher@amd.com, Li.Meng@amd.com, Mario.Limonciello@amd.com,
 Xiaojian.Du@amd.com, Xinmei.Huang@amd.com, gautham.shenoy@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
References: <20240730140111.4491-1-00107082@163.com>
From: Xiaojian Du <xiaojidu@amd.com>
In-Reply-To: <20240730140111.4491-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:54::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5136:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 32da1a56-36e3-432d-b756-08dcb0bf30e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b05JOGZTYmpPZzhVZ29sNWYzVGY5RkJtZTVWSkRjZDJuZEJRcUlIbnRxTE9C?=
 =?utf-8?B?eUhiOWdRVHlmOG9rUnNSbVBDR3dwWWY2OXBVSkRYZ2xNUkt1VW9MWmhMdGlm?=
 =?utf-8?B?VmhIUVU1ZDNwSXRBSTlVTTZaWlVKejdkRjVCc1dWMVhCTkZrdGtINTZkYWdj?=
 =?utf-8?B?aGM1cUFIZ05GQkRLV1MwZ1lDdWNXOHd3ajZxV3NuYnNGeFg1WExQclJPYi9X?=
 =?utf-8?B?bHVsSlhRak5nUVE5OHZXU3EvbjZreVljRkY1U3pGQTI4UkNCcm9HMWNEWGhM?=
 =?utf-8?B?eG1ySW9tTE1sajVOTUVOWE1CWWJ2QmpBZit6eCtnNkdWV1l3TUxYdnhZQ2tT?=
 =?utf-8?B?V1diTnp1Rk5wRExnMjEwVHdnS0hheDhDSWdFOTFYditVUXgvV2xVZlpxYVkr?=
 =?utf-8?B?Q25IK0Q0YzRCclN3aE9wMTN6dUF3U01SbXJmUGpQcW05RXU0bktHZFZVOGNL?=
 =?utf-8?B?ZHZmL0dUdXBwdTlqWVFKM21MNktJUmZELzBsSnlmeEp4NENwTno2eWNRM0M0?=
 =?utf-8?B?MHZQdVlEdlZNaE1FejFwWjRsWkU3SzhrOHZWM2FxN1UxSkF5VXZBOHZKbFp5?=
 =?utf-8?B?WGZCTTB3QmxFK1RHcUpqcEVONTVUYVVzc3hQQlRtdnJtVHFHeXB1L055UE5F?=
 =?utf-8?B?eFNidFR0VFNBcUFTWkRzZHNOV0EzWmNwSm5PcXZ6a3V6N2lUS2J3QjYzeFYz?=
 =?utf-8?B?ZUpjVXhJY1dIa2xRWkwwOWhxM2tBaEIrMHpOd3VVcVhoT1lTZXZaemlDRzI3?=
 =?utf-8?B?aEhmSmwvNDdjY01JaG1ONXdqSkZoOE9zVUxlNDFSVFlVdERtNDF1UnlVV0x3?=
 =?utf-8?B?VTVpdUZUTFN0dktFKzMydHIveXAvZkU0Y2R6OHNXb01POHhqQ1A1ZUJCcDM4?=
 =?utf-8?B?dEVOMTRXdzdwdnNsVU5pamV5bUhkWkY2OUljeGorT3BOS0RVYnBIM0tzMS9T?=
 =?utf-8?B?Sk0yV2ZIck9LbVhDaVBDWmVTTjJnVWJPa0pMMGduTEovaWt0RWxqZFRsRy8w?=
 =?utf-8?B?MVJQc25HNy84QnpnUm5hVkNzL3B0Q1VvQ0pHWjlHRk0wMGhCMWc2QzJPeUF0?=
 =?utf-8?B?Ni95czFsUWQzYTBNTzVzbmhHSnRnOFdvTnZXT25pVDRSa1gvblNiaHRVLzVt?=
 =?utf-8?B?NDY5U29hSEV2MXQ2N0VtMUhmT3E3djdxam9qQlZYS2JMZzFJS2xiaHFVWWND?=
 =?utf-8?B?Z3IybG00Rndoc0xZdDJNZzNlQm1lOEhZQnd6aE1WeCtDellCNU1vVVU3bG1v?=
 =?utf-8?B?eTd3MzVZM0dRY09wOE5KTWJYTWxYOHpjaVcxUmp5bVFRRllYbTlkb2VqNWxQ?=
 =?utf-8?B?M01yeTJySEFCaW13YlJaSEYrZVE5VTB0dW95MHJhdkRiczZSamt4czRvTVRs?=
 =?utf-8?B?UDNNbFF6Vy9wWUdxR3hXZlNBR0JUSWxjak1WRU1aNFhZT21XU29uZDhIVEtI?=
 =?utf-8?B?SWc1UGdvQzVxOHhTbmdMdXRMMEIvWUNPRG9QOWRkMEoyUEJmNStqUEhBdFBH?=
 =?utf-8?B?THloVEJweCtlVC95UzdsNW1TczZYN0VKRFcwRDNyN3ZJZnhMZEVFLzA5dGlL?=
 =?utf-8?B?d1dmTDVkaWpKb3BZZXZDNHFxbnQ4bTRDZElhN1ArSzVQaUxIZjE4ZlVYTlVY?=
 =?utf-8?B?NXVMWWVRVTVGSnJ6STFjN2dOSCtEWVBpR3NiY2NYOE0zZng0TGZxZGl0SVFO?=
 =?utf-8?B?TUMxSy95T0NROGxkOEVYOXFlZ1lJcWtmcmlJZHY2WkFMZ29BaHhUN3dQWnQ3?=
 =?utf-8?B?NWNYRStBMk9uR29RMmswNmcvTkQ0eFE4ZmphYVVkdTI2RS9tUDVQZzRkL1Ev?=
 =?utf-8?B?NklXVWlrNnNKdlBlRk1OUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlY2YXVoVnI2SkNSc2tEd1MrUkduYi9YdXNuUW55b01HRS82SFlndnNrUXJr?=
 =?utf-8?B?TU1PMnhRdGw1WHo4MktUMG5aMEFKZGNHSllwTThkTlRmMWYrZmViUWU0ZHZ1?=
 =?utf-8?B?TlpONUFidzFkSHBKMHMxWWdTRzJMYkRGd0hmNlBUVkNrYitvZHJ3eDZsdGVy?=
 =?utf-8?B?L2IyY2NGTmVRR3dQRUxkZjc1NnpsVnNBa1NHSzVCZUZZbHZ2RW5jVmRVazFt?=
 =?utf-8?B?ODhKK1FybVJTYkszYkN5azNZUUx3Uk93aDNacUs2L3lHSDNtMEVNdTNKakMr?=
 =?utf-8?B?U0JIb1JWaHhRdFg3eG92TnBmZ2lnM0hpTXlLUDNCV0s0NXkvOCtEN1RJMUlw?=
 =?utf-8?B?NlF1QWpkQjZIZjRBRHQ0cENZQ3gxaDAwN1dCNDNvMk1IcHFrT3N2K0pwZnh5?=
 =?utf-8?B?dDZINXh3WGg3L1g5QmJSeHY1YlRIdUFCS0Z4aStQRW11M2g1L3JQemxBZ3JT?=
 =?utf-8?B?dVpSdFFFZTEwSXNTOVBSZjhRbDJRMDE3QXFqR3JzN242YzFMQ0ZoWmZzOTFB?=
 =?utf-8?B?cDZFU2lPMGNWMUVDa01KRkM3NE16ZTI5SkN5RXJNVlZ4ZWtqdjBDSTVhZHdu?=
 =?utf-8?B?UzFJMHo0bll2am45V1hsV2lBMDhXNWxObVg0RjBFUXRPUEgzNFBhYmpHZTZG?=
 =?utf-8?B?cUsxekVhS3VwSkFITW5CR1lhT1gzTEhqQXV5Skg2akh2b0lVUWI2MWt3UENs?=
 =?utf-8?B?ZlM0b1VSOU5VSkJnN0UyWlJIQ3grS25JbnlMOGs1ME5IZGE0VStscDcvZjJY?=
 =?utf-8?B?SXEydW84K1lzKzA3ZEpGWU1VR1ZkZldzMi8rMGwveEhueUFCT0locFpXMk4w?=
 =?utf-8?B?TFBrTTN6Wm41WUorUEpVVktiYjV2b2Foak1WZnBQdVRQY3dVeVJpNDRXQW4y?=
 =?utf-8?B?NW5iSlk1OGZoMGZOMmFmOHVLYmdKbXNJUnkrNlVtOGZBS1I4bHhYS2hiREFq?=
 =?utf-8?B?eGN2OGI4T1NlUnBBK1VXK0Z2N1M3SHBzM0ZzcG5VbnI0dFlORVJ4RlBCRjYw?=
 =?utf-8?B?YVFWY1hSZStUaGpETHE1TTZ5b28rcDcrWW1XWlF3amhDTWR2RE5LREE5Qkpm?=
 =?utf-8?B?Y3ZxelJwVFpiZjhTeE1MdHZ3bzgzZnlicUZtQ0wzVTlpYWJwOG9VNnp2Q0Jv?=
 =?utf-8?B?bzhvbWwwYzZJYW1sTkNiNHZNTm90UmZuTUZGeTVIYXB0L09KUGVFZFU4K2k3?=
 =?utf-8?B?RVNjTEdYWUFTUm5VaENCbHJMTVMwRm9Gb1F1ZVNWbW1TYmRucmlvOTJzMUJ0?=
 =?utf-8?B?ai84WkJIYkFXQ3NmYnQyTTB2YjZVMDZZZGMrQWdJVzM4MVdsUEx5R0cvVzBm?=
 =?utf-8?B?bEVZcVNiR0JES1pxZmc5d0NHczRRU0VDdnhLZEQyMzFXc0s2QkVJVUZzN1h4?=
 =?utf-8?B?NUpFV3FGV3BReTNjb050VTU2VndkalB1QnlBUGVHTUVVclB1ZmxHN1BzUTZx?=
 =?utf-8?B?dWp5R1VQNjUvYk1DWWdldk4zRllDcGZQTXVRR0IwaEgrRzBNRW9iTlhhUlIz?=
 =?utf-8?B?UVFBeEZPZlNWbnc1UFJVUXhXVWtZMlc1U1VlMThQSElZZFJLcnZWWXRqWWJT?=
 =?utf-8?B?SkhDZG1yVkQxaEpJamRHb3hUbjVrcXp5Qlh2MHJsYVJSRWYvcUVmYUREOTNK?=
 =?utf-8?B?dm5hSll0Z3k5ei9TNWVEUGJxLzMzTG04QkNoL3VKTFAyRmVGMHB2c2tyUDl6?=
 =?utf-8?B?QUtDMzVQR2loQ0FzZTRyWW5sRUVtWE4rMCsyZk9UTytTVTN5b3RIZWdveVNa?=
 =?utf-8?B?eUJNRVpOQjRDVnRPMklsZ1hoelVjVzl6eTdqUG91QWVTODJsbzZlUTdmWHor?=
 =?utf-8?B?WXRjc1hTVEJueDl1cUMwMmp6SXJqWTAyOTAvOG03c1FJOFNuWEVsN0ExRE5j?=
 =?utf-8?B?UHFzSzNiMlVJd1hBQndsV3VjRU5tRmpXcXpvYjhia2RSUCt6WDVURFVVSHRI?=
 =?utf-8?B?WTZsbDkwemFxWXBGSTM2VWt1MlA3ODkrNFFJelZsQnVaRUt2M0JWYnFlSUtZ?=
 =?utf-8?B?MzNvV3ZhcG4rN0RMWUFCQmFuNjZyZndpb3BGb1M2UjdFTUY2bWJtalRTS0xk?=
 =?utf-8?B?ZkpiWWZEeXAxWUE4SDNrY0tmNHJSdEhVVE9WN0RhOWhzMnNsNlpPVGs1N1FJ?=
 =?utf-8?Q?WaNO040J0D8/ZEQpyMqrT+d4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da1a56-36e3-432d-b756-08dcb0bf30e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 17:43:58.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ay29FjBotKLd1CHUZNmhUI16Tfarj4jlcYheq0/X6qL4AazFlmR0Z8293UesE2nSazhI+q+eEL0TNw4dQpQLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895

Hi  David,

CPPC feature is enabled by default in BIOS for new ZENX arch CPU, and 
amd-pstate driver is enabled in new linux kernel.

For your system ,why CPPC is disabled, is it for debug or some special case?

If you want to use legacy acpi cpu driver, you can disable amd-pstate 
driver module in your linux kernel config file and compile a new kernel.

> Those warning message was introduced by commit:
>   bff7d13c190ad98cf4f877189b022c75df4cb383 ("cpufreq: amd-pstate: add debug message while CPPC is supported and disabled by SBIOS)
> , which make sense.
>
> Those error message was introduced by commit:
>   8f8b42c1fcc939a73b547b172a9ffcb65ef4bf47 ("cpufreq: amd-pstate: optimize the initial frequency values verification")
> , when CPPC is disabled by BIOS, this error message does not make sense, and the error return-code would abort the driver registeration,
> but this behavior could be handled earlier when detecting CPPC feature.
>
> I feel following changes would make a clean fix: do not register amd_pstate driver when CPPC disabled by BIOS.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..b06faea58fd4 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1837,8 +1837,6 @@ static bool amd_cppc_supported(void)
>           * If the CPPC feature is disabled in the BIOS for processors that support MSR-based CPPC,
>           * the AMD Pstate driver may not function correctly.
>           * Check the CPPC flag and display a warning message if the platform supports CPPC.
> -        * Note: below checking code will not abort the driver registeration process because of
> -        * the code is added for debugging purposes.

As you see, it is for debug purpose, in some corner case, if CPPC 
feature is disabled, this debug info will help to guide user to 
*re-enable* it.

Target system, including CPU+baseboard+BIOS, is supposed to enable and 
use CPPC feature for better Performance per Watt.

>           */
>          if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
>                  if (cpu_feature_enabled(X86_FEATURE_ZEN1) || cpu_feature_enabled(X86_FEATURE_ZEN2)) {
> @@ -1856,6 +1854,7 @@ static bool amd_cppc_supported(void)
>          if (warn)
>                  pr_warn_once("The CPPC feature is supported but currently disabled by the BIOS.\n"
>                                          "Please enable it if your BIOS has the CPPC option.\n");
> +               return false;
Maybe need a pair of curly brace after this "if(warn)" for your change.
>          return true;
>   }
>
>
>
> Thanks
> David
>

