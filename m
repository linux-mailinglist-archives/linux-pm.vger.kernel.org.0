Return-Path: <linux-pm+bounces-36009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AFBD6599
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10D923432BD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDEE2EAB66;
	Mon, 13 Oct 2025 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bUxRLSPu"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E92D837B;
	Mon, 13 Oct 2025 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390859; cv=fail; b=rfkG7RqMB9V94KjRferDgIrcBgGxtt10bzoRie3wst4JxT9iXbCgRBjbToNbz1lYERLVUeGPx0wavnMiyA1MGyrumwPGYp8OpwWWU+wDRBg0fNKb7kJx5x5QrK/tS+mXNOc7/Uo+YD9Ju7ZDi3DTWXb6TRK6MGIs3iQzRUT87Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390859; c=relaxed/simple;
	bh=No0pbV2rSjL1U3PCpShFjZB/1pudxoFwGUn+/v8hylM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4fkohOQeJ0+riFZEfvKXkmxY3FCtM4H+hHwL7ncmAjlz4Jqwe5Y8X7jSDywV3Zb7ntQ6tXDCr7+lwIEVchvR8SplG8nQIWt2IG5udG6UyT4QJIWbYrLP4lKGvBI5V4EsesRGAHfBTc2QH+rAULKGYBaPu+augflB0GG5vrE/bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bUxRLSPu; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW4x54bqfmKy3l0rs6szUFYRAtjWFT2jXwtk/2/oDVg6MkJFKdA0iEbdv+uuPG9P3czvEWLITILrRUsRMvFYafvstPvLFhwP07J+YPaIjXzWmOPYb4+fRxUUPKCkEt3rtc78mrUe/f4SWn0kqAf7XwK0moDVOj3Ys9VKWNGtX8Tdd2FekQYHve/eBHYkusblnJwz+DdeVjrPD3ixUXsVAZlMENiT6PEMeLHESOtHn9Vu7iXjYidxJo+/JJvp8eYkimwT0WRT/pF9a9PST30JjIaAj8MYFFFZPcmLL1y9+izEpO2lzVlzeL7xmKaY4MxEVBFtGKsN22r9+Oarn6An/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5PkxY6xl6bfAsCx4FqBulipJ6Sv8pbUNc9OAATRjSU=;
 b=gFqBW1cveq3wYBXnVyZiNAky4Qhm6uvTw9ciaFsCKNsaQwBiYpHzZq072AxJ4HNB7Bmo7InoZ6fxkzOqTYB9HjFnXOcy4C2bxHFTg8QYcj4Btn0CXj4EinT2MTl88neg0hCtBgy7h1+fxIZfQDwa4m1rRpTLTNtAsICLNzei97pzOM6mCiy3GVveTiLLJhCWStv8o8oDpu4ZCGUbqs1kbBVAMTgpNfKZi6kAQRKq5a7JEHcvgQCPLZeGqkNpPTRdWdA54/oS12KykFVMafltJY2zKRgL9Idtf/JQhglRCk8u5HqyG8TE57HdBd1gg/vCpANTe4GFE9r+LMwx7x75Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5PkxY6xl6bfAsCx4FqBulipJ6Sv8pbUNc9OAATRjSU=;
 b=bUxRLSPumepS5UTZk7A7Xo5ZZ2WwEya5aYQxEJCphigTqfqo9BD7yZeZVW7mZRH40UEJIQme1vbXSTuWkEOxufP9qGezz3boAX5GLh5BM2fMVXdRlcbySU+UCYwo0WLcNEFeg8ibwCJXOJ+rn1gPZvUp8scQpnB9vdsiuKCCSwnqSB3/0/RsDBnKN46aqCeRCh9jthi6+dW35NoNtRaDMwoFWfi/jl7VxiRu1y32pJf9/aUcCl6PDPREMdw3X8vgKuCk6gQOdaj2vRua/OPP7oDuLOxgRUjUu0km03sGH+wjjAoy1rxqt+n4cHj9mfUHIIVj/InFD+g4jWudAEWYvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 21:27:34 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 21:27:34 +0000
Message-ID: <d481f196-703e-4ed0-8db1-dbc3822c349e@nvidia.com>
Date: Mon, 13 Oct 2025 17:27:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
To: Peter Zijlstra <peterz@infradead.org>, Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
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
 <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251013200035.GD2734756@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0600.namprd03.prod.outlook.com
 (2603:10b6:408:10d::35) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c7f765-d06f-414a-766c-08de0a9f5323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEVidzYxUVRjcmNpNWhsTFcwTlpGa25zeTlWMmNwaXUyR3c2WGtWSmMxajBV?=
 =?utf-8?B?OURyK2orTE5tWWRweEhMTHVZWUtIWXdRMkNBbXYyZXVUemhSTWs4UW01S0Ny?=
 =?utf-8?B?R1d0TloyTDQ4c0x0K3MvdjQrazY2VFVRUk1VNjY2eUhoSmQyUWtCa01WcVVP?=
 =?utf-8?B?dlhxS2ZkZnRndnZ4RjArbjEya00xN2YwYXBoVWpLc1RzUkY1UXhxc0tWVzdo?=
 =?utf-8?B?Zml1SlF2eEg2Y2wyOFdwQ2xGdGIyOXgwekQxdlJLck1iQmkyRzJIN2RHZWtO?=
 =?utf-8?B?OEFDWWlQZG13dmZ4YUpoVUoyNGwzVWlLaHlMQlIwd2Noc1UxMHUwem51K2ti?=
 =?utf-8?B?K0REY01Td1dTeHlpR3V0Q1JkL2dKcVZ3RjNLRm4xcmRudDQ4WS8wOGZHRmtS?=
 =?utf-8?B?dXdCV0tURUNpOWlObmRlRHh6OHNHUnB5NnUwUXArTktGdHN1OThGYVlJUW9I?=
 =?utf-8?B?a1ZOMXBPZnlabWl5TGxLd0kyOTM4bkIxbnllODVyUTY2Vnh0Y0MrbHd4S2ta?=
 =?utf-8?B?L3hCUTBaMHNyaWlnZE1ZL3lBNEdjWTZ2TjdJMEUrZi95VGhJMDNSYm1SY0do?=
 =?utf-8?B?L2NZSlZab1MzckFZTGp2YXhGMFAwS2tjY210ekdDQnVLNGd6M05tOUIwaUNO?=
 =?utf-8?B?WmRDMFlmK2JIeXJGbmY1cHQzOW5lQnhWNUJ5WTgvYkQ3ZDRXNC9yK3RqNzJB?=
 =?utf-8?B?alZXTW9FY25QS0w4L1FEK0VkSXM1bjFmbXBra0pOU1N2VElMcHdYUTlveE9j?=
 =?utf-8?B?bmJ5L083bGNlV1hBY1A3dVVqUTk5R0RXY09pZGFEWW1CL0ZVbUZUZFJqWmFF?=
 =?utf-8?B?aDJRK2QrN3dHY1FrTVVuR1NQcUpYNnpBOURMdGdCc3gzenJiUWVqRytyUFZE?=
 =?utf-8?B?bHNoM2hvQ2FCT1hPUkowOGRTS0hOeWovMUV1ditnOE1HbGZNZGlZdHdYSlFh?=
 =?utf-8?B?UDQ3UVk3RXlVNVlVUTFZWHI2dHBlR0tVRE5YMHVuMkdqRHlWWjJLRmZzVHl6?=
 =?utf-8?B?dWc4UWxkZzBEcVlBSXhhLzByanZIZmpIN3dBMXJiVzBGdjhaa1VGQlZLVTl6?=
 =?utf-8?B?SFV6TVB3Q1RMK01DbkIvS1pvUEVOdkswUEFLeUJ6NnJwajlJd3ZiWEJDVzJr?=
 =?utf-8?B?cVdsU05vanJGRitRVXJCL0oxMVBpOUxiTlpPQ3NMUXV2alk3d1d5QzNEazQy?=
 =?utf-8?B?b1RMYlF0SEVZT1IxV3RaV0NkRG9oV1NBejArV2ZmREVGRjlyZHJidXJCZ3RY?=
 =?utf-8?B?bXZ2U2xkWERzV1VUYTNvZlpPVDlIMGZZSDhUUnZHVVdZU1RKRUxFNUtiZ3lR?=
 =?utf-8?B?aWQ2QUhqaTJnT3dEeGdVRXpwOEpwaUhUdmJnMFV3R1Q0QUdkd1o3RUdOeXNx?=
 =?utf-8?B?Rms0OGU1T3EreXlIUVpWbVRLeW9HMjN5NTI0czJCUTZFSFlLM1BEK28rbTR0?=
 =?utf-8?B?ODhyMEtzcVhMZWRBb1dTSVV6NkhUZEFEN0poK21abkV0NTlCSUZKZnlsUlZY?=
 =?utf-8?B?U1RpVFVzZVBwZ2NDV1dzUDBDUWxOeml6SDhqN3o4aVpmajl3aGFDUWY3OTVs?=
 =?utf-8?B?WDc2eThxOFVNOUc5emdOMnNtdG1DcTcyWmloN05kVkVtb2dzVTNrSlFXVEdC?=
 =?utf-8?B?ZkxnSkdyVzh2M0hHV2c1Rk1KaHpJVERwTXdXUU9tRDNBMmZXNWZtRFpacFls?=
 =?utf-8?B?bm1yV29hdlNpM202aHN1S3Jza2ZCWHNacmxvTWhOdjdlbDFtV1cvck1yWWcx?=
 =?utf-8?B?bWt0dzFJc05GZTdaK0ZWaDFjbkEzZVpvTzFZbjFjT2RYVDJRbm1HVGJkR2g1?=
 =?utf-8?B?Z2p0U1ozaThGZ3pNV29uVTVFc3NrY0RWRFhDaUdybEJjUW1DcnhPdHFIRUll?=
 =?utf-8?B?T2t6dVRESERUS2R2SXdEYk9nVUdZU0J4NFpNTXd0TjRhY3hYSU1ZMjJydUNP?=
 =?utf-8?Q?5J8LCdKRHuLuuOGf8F/BKXaxbnSXfneA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUE0UWo2N0JSNHNickcrM0ZXNFBYNFdYUFVqQmpGTkRId3VIbEJDQ1BDckhD?=
 =?utf-8?B?ZXNJMmFQeVlMUG55cFovd1lITE1jQTZlZzZwbThVMW5wa2l3MU1SaFlvalI3?=
 =?utf-8?B?Zk9mQmo0S3R5NlFnRm01TFhWT28vTTBZV2RtTFUvRE1NRnp4cXc5QWZRcFli?=
 =?utf-8?B?alBHeG12ZXV4VzlxdTlSaUxvVEJleFhKakFEWlZDRi90VHNJdVVVbCtRUys3?=
 =?utf-8?B?NUxNbTFTSCtkUndpN0lBU0tqbjVZOEFtcjYwWjRUb1p0YUVac3Bxb2lmVnRh?=
 =?utf-8?B?UEtnNjdEZ2FCc2JkdlFxcjc2ZjFpKzViR2hvWjdpM0M2V3R5c21kWmtubDVX?=
 =?utf-8?B?NzVkSDNLeXJlamIzQWJ0emphWEc2ajB2RHJvQnp0VHlsZnVibVRkL01MWHpa?=
 =?utf-8?B?R0YvdGJWZDRoSTE4Sy9sMGNKbUNPSFpyMGw3OVRZRkxqeFFZNlZoaExvUlVL?=
 =?utf-8?B?ZDN6dFJDcDVoQ0xOaTg2UUloL1gvRFBrMjR0ZVBIMzlTUFI1UWxxb1czRmVW?=
 =?utf-8?B?RU9BZzdSRmJXYVBzcm5IREQwTzE1Z1NicmhkeDdsektOSTFkdUE1dWJLWld1?=
 =?utf-8?B?a0t5MDBtVWR1NjZQNmJVdk1yMTJXQldMTjArSFRHSGdlNnh5ZHpXeTFTYW92?=
 =?utf-8?B?OW1wMzBtcjRhYzQ4ZGtRNWZSNDJkZDZZd1NVWGxMQmRNZ1dXUFNoYTJ1c1BE?=
 =?utf-8?B?ZnlOTWtVK29EU2dVMTVLL21JUnpNU08zOEFKSWs3cXllRkFBWmFHNmJvejFW?=
 =?utf-8?B?T2tFVUN3ZWdyVXRFMFA5dGtxRHBaQlNsWVVhRzJaUTkwZllWRXlKSW5nNEw1?=
 =?utf-8?B?Mm9lSVI5Z1hUY2syTWlaN3E3RVVkaHRYSzB3b2lVcGg3RVl4TmN1M0RJUG5D?=
 =?utf-8?B?WktnVjdHOGttWENwU0svOW9ZTGwyMUxBU3QrdnNKVGJVZ1E5Rm8wUnJYWWlL?=
 =?utf-8?B?RWd4dDJKaWorNitsSkZ4NUYwUTQrS0lwRWxuQ0o2NmwyTElTaDRId0ZhT0to?=
 =?utf-8?B?OUYzc3V4cVIvVmRhbjJ4VHk1ekRSYXh1QmZkaHRKekdaWjFJYWtsUXQ5VFAx?=
 =?utf-8?B?V04raXBobEVlNVAyaDJKTjVTTmNVY1JwdTVxamp4NUlScVhqZ1BwSnB6OUto?=
 =?utf-8?B?UHFmQmRzUDVSODV3cUwzQkNIcWxTalNkVmVuRnhMWUk5VnZrdU5pdU5sUitY?=
 =?utf-8?B?ZFdRRWgxSHJaSGI0WStUOFhTU0pyQTY5L3Q5VHdlL25aUkVTdjk0SlNtVHZh?=
 =?utf-8?B?cGVnVEtpMHBsNkt0bTF1d08xb0FvcEZrSzVVQkJpVEFxYXlXYU5JT21yWC90?=
 =?utf-8?B?eUkxcE0rc1ZKaUhQcXlKMFpSSUFEc29FdUtEdDZCdnVROUFPYksvWmEwRlJz?=
 =?utf-8?B?SjYrUUUyRFpGZzN4MitMeXJoNVAvQTFzeWxZRmV6b1lYQStET0NiYjRoZG9G?=
 =?utf-8?B?SjRuUE1GN2s5TlpEUThnSnpEYzA2SjV4WVM3RDlUdWJRMDRzYnhJMVdqakJv?=
 =?utf-8?B?MWE3VTEramVBOFdVYmo3anBxV1ViRlBzN2lZbjRMdVZYNW9ZdmlCekJNOVl1?=
 =?utf-8?B?Q1BsS2wzZGg3aXpZcHh3MFhhMHlTaXhObnFhM0poc3Y5OURtZ1BmNU52YkNi?=
 =?utf-8?B?NjA5ajFFOEJiZ2pUQ1JJOGFTQnV2Njc4SSsrdC9CWlBRR0F4UEg1UnNMUklT?=
 =?utf-8?B?Ni9DTEEyQmVzaVlFaXpLc3ppU0dmR3ZHUWwvWWR0djJYYkZ2YnhUQ1JBWXd0?=
 =?utf-8?B?czgvMWdzSUFaR1ZkRU1hdFJtN2N0Q1NTOTlUYUQ5dHhBQmZJMVVWcjlIY2pk?=
 =?utf-8?B?WHNvOHV1VUNYcGIrbFUrTUthSGgycnFCWTJNMlAxM29PT3FpNndiTHRMM29h?=
 =?utf-8?B?bmpncVlWd0pmMFRxUUMzZzA2UmF6cjg3dXRPc3EyMG9uZVIyb0pYcktEaUZw?=
 =?utf-8?B?ZzV2UERaMnFuRVQxeEpIUDA1dVhzRDQ1Mkx3NUxabER0VHl5NXlEdFplakRV?=
 =?utf-8?B?Q1hRb0NYNWxTdHE4Z25oeHVpbnV4ZXl1ck5OVUVNUUI0emtXOHc1K2psUFgx?=
 =?utf-8?B?bFE4eFlwaGxxbU1TNkRvakpjL05yOXpvTFRkRWNFYTU2TmJ0dGorOUt1Vy9R?=
 =?utf-8?Q?06WAHbuBnhj2WxiSnOL85ljir?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c7f765-d06f-414a-766c-08de0a9f5323
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 21:27:34.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap6BCMbJ84M356tEg3Hrf9Dj52cQY4qfXuQLSrzjmjafOLk69OAieQH/Plvet9AXVZR02n+s0yxfjh8Ss+UOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023



On 10/13/2025 4:00 PM, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>
>> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
>> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
>> allowing those bits to be repurposed for other uses.  This also has the benefit
>> of tracking more than 16-levels deep if there is ever a need.
>>
>> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> ---
>>  include/linux/hardirq.h   | 17 +++++++++++++----
>>  kernel/softirq.c          |  2 ++
>>  rust/kernel/alloc/kvec.rs |  5 +----
>>  rust/kernel/cpufreq.rs    |  3 +--
>>  4 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
>> index d57cab4d4c06f..177eed1de35cc 100644
>> --- a/include/linux/hardirq.h
>> +++ b/include/linux/hardirq.h
>> @@ -10,6 +10,8 @@
>>  #include <linux/vtime.h>
>>  #include <asm/hardirq.h>
>>  
>> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> 
> Urgh, and it isn't even in the same cacheline as the preempt_count :/

Great point. I will move this to DECLARE_PER_CPU_CACHE_HOT()
so it's co-located with preempt_count and run some tests. Let me know if that
works for you, thanks!

 - Joel


