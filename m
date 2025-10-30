Return-Path: <linux-pm+bounces-37149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5BC229C5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 23:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967804E04B3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 22:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E833B969;
	Thu, 30 Oct 2025 22:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlwimdgI"
X-Original-To: linux-pm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC825C802;
	Thu, 30 Oct 2025 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865030; cv=fail; b=pge7xteCeAIb123rlrjwxqsISskMhrrOKUJQ7my10nqin+ta15Z+vn0j1qmI4WD5hsXtziK+QjUUx175ZoHOd720afi36bw06yWtXFfKHTtR0k3w8MrmN/E6ddlQaSK/fHVm8Y5Gh4M5/7SJyE8X62i/ygQ5K36WZqWFLu/OAaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865030; c=relaxed/simple;
	bh=ec7QfTYxGOnsenHOC0snGNzmxdg8BPWMs79MCj5lrbk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bP9gAMhzYlQ4aLseYO8dA9ooBCSJ/Evqbvgq1MqxKugTXukIGbAKHK081Kp3lTn4voj1GtOEQFz1bQTnUBA5P0O7kB1/OOtAOGGUQBQE1OfHd4AqMadH8yWEItePA4i3VbVq7NCXOdTFkdN33Kex3mlnL7nYcDkQEu29sLERtL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlwimdgI; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqwSJI4vPEtM8X4p8dsjPqng0qfUGBMvXu5sqc9D79oFIBpcpxTDN7Xx9IIQaI7URV4QCWxZ76fHoRLrIrKllfgfLysSbzlf3O/sZJDqDWEvt1G0ia0Oz/cFqBpgxr5LL/QGh1EtEQfS1Vv3LwEUoL2rIS1VquTdW/ley1qXJWZ8DHiUGCdiaRbUAUTY3LGpd1F5rabr1rNyn2h37YziJbYneDDR9rIV0YZmAeElBa3aCewevPQIyr4pjA+FAsZTNFcI2hBe0eYxx7LQuDGBUxSSZlONfyB8/GBlvxLSSGcRZ2zhRqCSjZ8ZGQWzcfCfzmvTILGFFwoBX1Th4Zvtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdqFetZ9gTjlZDTy6iOOEG4xAX93UcYycus4CMmaGzA=;
 b=dlAdDlvhRdpb6ki+usjXve7IjD6MjEY4/lU+pcLDAS48O3gw9SIEl8Nra+VCDuRheh8xIAMIAkl5BdbO1fv8Gny4DNS+X0fA8zcE/i9Mj3FRytMyrGa7/avE4VFECFM23/5C02xRJj6Tdexn4BAHg6um04KcxTXjp7R7Zt2ExNjnqn2ReGXi1uXfI6EDSkQF8VMi5Hif/UOzlMDW4JdpP5vfA13ulI5RU5OV5uNBbgnLF0w6N3L/WIurXgh/Y+D4vAG26afB7H9VBrm9EzBI9eZkc39W+WLmCI24uxTCGOrvnfYWQB2nnRouYrCFBmBVATLVWckSiWSfkNRN6udavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdqFetZ9gTjlZDTy6iOOEG4xAX93UcYycus4CMmaGzA=;
 b=GlwimdgIK1eo39G+NVa0fjhPMSsJy5+8k1XwFtkde97HJMX5zuyzoU12n57jiivHjwant5h7OWdHXJyucMAx8hoJ4GMFFYAxTqjUrQECbZfWrFe57j5a33bEmH+QywcHJhwL+SOfOb2jrmXT/jgBFEq8ShRX+REltP0M6fA0ZQDb2IbXC1WXgUbbiIezFXyZ/GxqD0fl/ftkNYzTv9mhi/IeS4C+phMI+uwUipEJKjLOJLY7DAE0UWkrshY1fQfXkbkx32RtE75QiXjeEPZ0huF+ge/+U+ZF+rCA5rYrdm1OxGqgpyyPFa+wd77W10RTKLGGOt6en6j9cVwyr9iufg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 22:56:59 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9228.015; Thu, 30 Oct 2025
 22:56:59 +0000
Message-ID: <01ad0644-4639-4217-ac31-b04777658d18@nvidia.com>
Date: Thu, 30 Oct 2025 18:56:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
 <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>
 <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
 <20251020204421.GA197647@joelbox2>
Content-Language: en-US
In-Reply-To: <20251020204421.GA197647@joelbox2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:208:32a::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c77f9a1-9383-4fe0-4f91-08de1807a213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHB5NHlwUUJLeE12MHIvaHQ3SG03OGZyT0JYUVRlMC9GTVJ1WnJ5SjA0N0Jl?=
 =?utf-8?B?b0FoSjlBMGtsUFZkWnVhUllGWThDZGFyNlZtVmFtRmFyNnNUM2ZHSnYyWkpj?=
 =?utf-8?B?dEdlOVFrdFJsTkEzQXd3WHVySjM4cGtmNjFudzB4TWc5SXRYLzRLT3p2Z0tP?=
 =?utf-8?B?ZmF5VGtjdGlCd3FNVGNOamZraU5lUUpEclJYTi9vaDU5MDJCSTJhRXB5YjRk?=
 =?utf-8?B?VGxkeHYyRHFEaWVlQ2hJTUhJYkppKys4KzVhMGlDbmh4UlloWEpNRkFVLzdn?=
 =?utf-8?B?U1JzcjhqdFdmZCtUZnFNYW9zclNEYTQxNzZKejRmSm8wZXZUZXBQZ0N5Y1Az?=
 =?utf-8?B?dS81YzdTdnk3U3IzMjdxb2hvUWxkNE55UURNNVZiTUtrbERHNHNNZXlSNm9F?=
 =?utf-8?B?dzJReUJUUjQ2bGtHKzlEOWhRVk41QjVCNnpvTkpEUkluK1Q3WU9rUC9tN2p0?=
 =?utf-8?B?bmNBZ2t5VjB3Z1lJL3NURzNkYmREekJUSjNZbXhNb1dmbnhhUS94clRPbkhO?=
 =?utf-8?B?cENQOGU4MGtnM3Q0V202eXVyaU1KemNHWWM4Y2wzKzhRVkJUYmM1NU5WZG5r?=
 =?utf-8?B?b0RhWU5BbkFLTGNUMTBRSFJ0SVhGZEE2aGxpUkdBMjMyL21sY2tSSUF0M2lt?=
 =?utf-8?B?cEFleHhBaWdNVDYwUDNadTdDNDArekprd1VVaDBVQ0JvSmltUW5YVGRBbG9M?=
 =?utf-8?B?NXZPRFhUYUg5dDdSRHh4NndOT214aTRneEJ3RjkzeThVTHRac1dNd0ZhZ1RZ?=
 =?utf-8?B?am5RQlc4S1d4dHY0a0Y1b3JRTjVXR1VZazhZV0FnbUJUcnBVUC9iWFJiOGVo?=
 =?utf-8?B?cWVLZUVEYTU0dFFwUDhtOEFoWDFiaWlKeUNCajFQWTFCYXR6L3NuNHBIWXpX?=
 =?utf-8?B?YUltRGxUaGRwZ2Vyb1lKOXdkeUdxeFA4QldBdHVGMzZabE43aWp4UStIZ0NL?=
 =?utf-8?B?c2VhSzVza3QzS2ZUQ1VqQkY5M0F3K3F6QnFJTDQwSVhHS3BCQU1kUnN6VGhG?=
 =?utf-8?B?L0UzU1ZJSlk2UVlWNmIyd2ljMG5tcXV3bXlHR0h0QkV4RDhzRzlXalF0bFBK?=
 =?utf-8?B?VkNidlBNcHdER0VSNlYwR05WVEp1OVNPVXoxWmJWM1NMbm1OZUt5K0M5cGxn?=
 =?utf-8?B?Y2ZZZjhhcE9wRHMvOVZnaU1aR3RiWWd1a2Zna1VFWTE2Y3U0Q0V0L2lhc0N2?=
 =?utf-8?B?ZEQ4U2N5UWhLTHU1MTJ4cEpGd3pPTVl3a3RMcWhsYU0wenkwZ0FUdkg4bTF4?=
 =?utf-8?B?ektjL1lIVUJkM2dBR2tGK3ZUbVltVjBXNFZDdm9Wb0xSczZRcTMrb2lYSGND?=
 =?utf-8?B?aDFYV0JRbGRsVWE2TG1yaGFuU2NLM1FFQ2tTZnpSUGdwd0hxS0pPV2tSVVFZ?=
 =?utf-8?B?eERuOE84cStSaEZZSkkzTTFYblVidnRaRjVKZDlTWG0rZzRFVFNzZ2NIVmJp?=
 =?utf-8?B?WEwxUEpGMGFBUTJXMVdqNXVTUmtpbU5pWUJvYmQ5TDh0ZmVQUXVHNzdBMVZB?=
 =?utf-8?B?cEIxMFQyY0FjQ1VYU1NlTVkxdjRhYithOTZzNy8zcmNmUGI5SmE2dm8zNEVV?=
 =?utf-8?B?cUxGQWtITDBBczBVOWErQldsd3lOL1F2QzNQSU8weEQxcDJudFZ2SWV3MDhB?=
 =?utf-8?B?R2doTDI1ZWw4cjlJRWZjRnFJbWI0WW1UekNIU210TUJlQ28xRldZM2VHeGxS?=
 =?utf-8?B?Vjc4NGtzTVgzWjVGejNmbE04Nm92c29hcHBDUkFJUHhqUTREUWhDemx2VUZQ?=
 =?utf-8?B?NDlkaUF2ZXU0Mmw3Z0pVZXBNaHpTZVErK1VEY0tNczMxa2cxdzZXZnZUaVhR?=
 =?utf-8?B?cVNNVm4ySHJkalBHRFVBdkkyRFlXVG5XY2hkSVhvdnB2WWlKR0NxY2hMYkRx?=
 =?utf-8?B?WFBmbFZVWmZXY1lOZXhYakwxVFdiWFpBSWJMQUVNNHBnOFdlYlF4L0RXQ1Yz?=
 =?utf-8?Q?WJkr0Bigly5viehLPdNfzv38I1P0Ni+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25TdnZ5a3dRZVNCdlhybW1lSU5FeDNJRW1JRTNqd29iYVdCbGtCcnNOc0dy?=
 =?utf-8?B?Q3RHV1psb3RXR2xaWFI1TGlQSk1oeHl6VUhISWg3c2VuOEZjWnlKVU10Tlla?=
 =?utf-8?B?eWw4a3k1NVZnSnd2Zzh3Y1VwT2x3eXZCYUxLVGVkSXdwdDhaR29NMVNQY3NK?=
 =?utf-8?B?NFBJYWtXc3ovajBJOVZWb05EUUlLaGZ5cENDL3B3N09Lb0lrUlBSVFJlMTlz?=
 =?utf-8?B?SzlyajY2T3BvU1BaMTZaRXJSOEIrai9GcFpuc2hrSjNSd1NVNGxYODd3MU9k?=
 =?utf-8?B?akpyWEdadlNIY0sramJ6SjFLSlRKUStmM2N6Z1NKVnYzRy9iRmE3UEZaNWZz?=
 =?utf-8?B?djRhSjljOGF0UVltaHpJUHFLandNcEpvN1pja1lRQmZHdFg2UHJWWGlPeloy?=
 =?utf-8?B?Rmc1QVNSY0pBNUpoYmtVeGZTdlg1b0ZZdmFDWWFJK2pEYlA5dUc4b3FrYlFU?=
 =?utf-8?B?TzNWNnNqMDNGZWRSaVFWRm5yempPN09udTR4MEFVLytKbWxlMndqRURZYlVn?=
 =?utf-8?B?ang4RFFEMzRKZCtJQkJyRnRMQTRiWW44ZE1Bd2xQa2M1bHluNUZ6S1U0bUhE?=
 =?utf-8?B?VXJaT0YzdXM2VEdPQkh6OXR6QWRLOTBMUXUrWUNQeGVhcytISS9DblRDSXZj?=
 =?utf-8?B?a1AzNlpHUk5MeFl1MWFhNExMbERTMHJPM2U1WnA0Tk51VUtsdWR6eGN6UjdU?=
 =?utf-8?B?WllRSWE0Wjl2dHVCb2ZVT0lsRE5zUlFDc1ZwWjl3bDkvaXMzRXpTL2R1Z1B4?=
 =?utf-8?B?U3RUeHhKYVFWN0FpNXoreDJaOHdlUjlBdlVLT3dHR09nR2dEbW1BTzd5dTc0?=
 =?utf-8?B?WHljbWdGelVqSXpFUWUxaXFBZXhnRlhLalM0dnJFMGVWc0daaXlkclJOVkpv?=
 =?utf-8?B?dVdEbmR2am9KalAvdXN4a1M1eU1UMnB2V0FWdDR1c21QTHRiaXRsa3JIcFhu?=
 =?utf-8?B?NEhMSUtOUjEvRnBYbjJ0WnJET0pkZC9XTG5BTGhFdWNZMmxGSUhDUUhKZm0w?=
 =?utf-8?B?RUdDQ1BHeUo3YWh0bHBkL1BraVpSNlozWGoxcmRmcjhTMzkzM3RnYVFBVnhI?=
 =?utf-8?B?NDkyRmdnSjNtM3c3ZktaSVQ5cHdPMUkyaW45akhtMTdsQy9TSmxwK2grSzUx?=
 =?utf-8?B?OWlKR0lweHVkTzY2WnYycTBHQldlVm4vbUd0KzQySG1zbnpSRDY0SHcyNHg2?=
 =?utf-8?B?RFlacGJ4VVFSKzMyUEc0SmR5aFRhaW5aYVYraDFIZ3JQQ3VCMFVZNmhkOHVz?=
 =?utf-8?B?RFZ3ZklCd3Q5ZGlxT1k2WVc4azdpYytIdEZWY1cxek8zTXdHbWIxcEZwN0Mw?=
 =?utf-8?B?TGtKTXM4dXlTQ0JlQSsvNjBZTXp1M3BBL0ZqcUJOSkh3VFJzcWNkV3Q1TlhC?=
 =?utf-8?B?UE1TUnlyRDl1Y2hKVWREWDYxbE5PN0NNNTY1c054Tk9DTEpyRWZnYVVIRHVY?=
 =?utf-8?B?QmEwT3JzZm15OFIwNFhVT1NGaWxOMG1vaEdqRXh6ZnNwNDd1SVc3VkE1bmxN?=
 =?utf-8?B?R2Y2UVlvMUR0ZjRoQUMrLzRRMm9OWlJKaUZMQUFhbXNoTDN6amxjb1hjSEF4?=
 =?utf-8?B?aERRWVN0OGxuZG5pV2ViOFV6OEk4clZkRDA0WTdjQVE0bXVSc2hoTVExKyty?=
 =?utf-8?B?eXk3VnFub1FxMitUZGZMaEdBMDRYSDhMbkwrYWh2R0VxYTZ2dFIvWjJZeTR6?=
 =?utf-8?B?ZFdGRTM1UVZ1WlRXVmJXNzJjdEduT0dxM25WaWV1citXZVZRRDdmZEJzU0Fx?=
 =?utf-8?B?bjRYRUo3a0k2VnRhTmY5Y1lSS1hnNVRnMERxOEtad2JSQnV3bDY2ZkwybmlO?=
 =?utf-8?B?VDdCaitBeUs1Vm9zQ1VHUVlMOFlXdjdhcG1IVVJWaHhZYnlhTkh2ZjMraCtP?=
 =?utf-8?B?c2ZjVEk0SmdoYmtGeXZYRHAwWmhVcEV4M0pqZjRGSk15VTJXOVhCUWNDRXFn?=
 =?utf-8?B?RFAyTmNaL09ZZHJpeGVJUUMySXRnOVBoUzJlOGZLY1BWTVEzL3RtVE5obFlI?=
 =?utf-8?B?amdRdjhqYUs0UEV6QWE3UG80b0ZnYlZZU3NzaGMrMmRLaGFaKy9hU2Q2RTZh?=
 =?utf-8?B?Q0U0MUtLZVdyVjhyRlh4dmdEOTF0MVlvWHlMSmhrbE5RWVgvR0FFUzRVY3V4?=
 =?utf-8?Q?uvYTfAcO5uBChBgWrEh7tAAwZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c77f9a1-9383-4fe0-4f91-08de1807a213
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 22:56:59.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQKrZC3Ke/Dot+tH9mQ7ZkK/4o2dn8M7YKQ52k0zZdeLA2q1P5eRdHAYPSmTWMjWdFhQmIzBFRrh/gALW2a3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024



On 10/20/2025 4:44 PM, Joel Fernandes wrote:
> On Tue, Oct 14, 2025 at 09:43:49PM +0200, Peter Zijlstra wrote:
>> On Tue, Oct 14, 2025 at 01:55:47PM -0400, Joel Fernandes wrote:
>>>
>>>
>>> On 10/14/2025 6:48 AM, Peter Zijlstra wrote:
>>>> On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
>>>>
>>>>>  #define __nmi_enter()						\
>>>>>  	do {							\
>>>>>  		lockdep_off();					\
>>>>>  		arch_nmi_enter();				\
>>>>> -		BUG_ON(in_nmi() == NMI_MASK);			\
>>>>> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>>>>> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
>>>>> +		__this_cpu_inc(nmi_nesting);			\
>>>>
>>>> An NMI that nests from here..
>>>>
>>>>> +		__preempt_count_add(HARDIRQ_OFFSET);		\
>>>>> +		if (__this_cpu_read(nmi_nesting) == 1)		\
>>>>
>>>> .. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.
>>>
>>> This is true, I can cure it by setting NMI_OFFSET unconditionally when
>>> nmi_nesting >= 1. Then the outer most NMI will then reset it. I think that will
>>> work. Do you see any other issue with doing so?
>>
>> unconditionally set NMI_FFSET, regardless of nmi_nesting
>> and only clear on exit when nmi_nesting == 0.
>>
>> Notably, when you use u64 __preempt_count, you can limit this to 32bit
>> only. The NMI nesting can happen in the single instruction window
>> between ADD and ADC. But on 64bit you don't have that gap and so don't
>> need to fix it.
> 
> Wouldn't this break __preempt_count_dec_and_test though? If we make it
> 64-bit, then there is no longer a way on x86 32-bit to decrement the preempt
> count and zero-test the entire word in the same instruction (decl). And I
> feel there might be other races as well. Also this means that every
> preempt_disable/enable will be heavier on 32-bit.
> 
> If we take the approach of this patch, but move the per-cpu counter to cache
> hot area, what are the other drawbacks other than few more instructions on
> NMI entry/exit? It feels simpler and less risky. But let me know if I missed
> something.
> 

If its Ok, for the next revision, I will just do the following to cure the issue
Peter found, and respin the patch. Let me know any objections. Thanks.

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 177eed1de35c..cc06bda52c3e 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -113,8 +113,7 @@ void irq_exit_rcu(void);
                BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);       \
                __this_cpu_inc(nmi_nesting);                    \
                __preempt_count_add(HARDIRQ_OFFSET);            \
-               if (__this_cpu_read(nmi_nesting) == 1)          \
-                       __preempt_count_add(NMI_OFFSET);        \
+               preempt_count_set(preempt_count() | NMI_MASK);  \
        } while (0)

 #define nmi_enter()

