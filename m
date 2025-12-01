Return-Path: <linux-pm+bounces-38940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468FC95784
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 01:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58950341B88
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 00:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE21DFFD;
	Mon,  1 Dec 2025 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jS93XroZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884D36D50A;
	Mon,  1 Dec 2025 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764550336; cv=fail; b=ssvo/l/Si+p46uT/dy3R8MEke6BhM5qK7YTj4T3Q8F2leMmGFSmaC0W++fK29wDyJgo/1tlaF+zgtAcDaeGGfR08wjwWtaBdF4X5oO4RzSHPMJpI7wPRMOrbf0bT/KLuwjp3cGvAamksJlla8ujByhhWQSN5t9Z/Xi1DPgI0gTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764550336; c=relaxed/simple;
	bh=aQP4iu7pyRACw0fCohh63GLsnm+cQRcc78yopRtcXB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i3Xp7G1EQcogNlVA5Jc6yDQW8ch3ocAvGh/5lQAjqNb460VlWDEAP4PfAf4KK05w2J+ojyJn8OeXBCFFcI+fdvNcTp/t7hdujfJT62OBDbTu+sgiQjpQ9fPK0wUEdVgloHx8rV4ubw/+eqTgJH78/ByJXDT59RMKG698PCCAyIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jS93XroZ; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh8jSmtGAUtaixo8sYLg9uLuHQTEmnXFPKAkjinLPrOn03dG25DGU3kgrLTzNVRjhvhurTas9GgCQtDsBthwvDP7/rZkYrOpB84KUKQQQZe20Lx6sLV+wNkJdg76mOQKqN8OV6hOY0wysRMGrr0l2l59Wp6XcVl98S8cRM6e2+WawzNrJC/ARPWEugdIbJK78f9ZbDxBTD3iOmjhVeBOwDOqz15/2hrFK03qwCqr+zgJAYRjcCh5XU6TTG49Z8dSDaVIq/VX2y4eakE+20Uzi0GV8NuWoPFigvFQDZe74BqHN2SYRa5IY6FMv4WTqJoy91J5MEcjClioIn/WO+fCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNSvz5lapAtEfCszC8ODJB54CHV2qsa6fzkZXN8My20=;
 b=DXDmWCQDmJEDzgZWqvO9aaNguMtwiXFRHSy3+/aOudJXbLWcIZ/scK1BvJEM7+mm7T+T5HJ2XmZs+E85vNi2NanmUEuHqhH0shFE/HiCUcQPIxNv+Y526pp/Ojutc0de16BXb5kConX26PUDdO8jPpT4lf5owqncNUMzYS/G60zjFGFJjVy3TTvdHdd49I69FTBDZ+7UYqdfCHUcJ9Iw0fbrb++BPeRDlxbC4t1WXugoM1wXnFZ/vkwuPQHWWm1FfVOl9seJldw9ZjTLOPPmTdODdJ6e1bYmTmvSEbOOqVcqZTQlwGx3SVkMqIzO+k9d8GFdM60nZ2725T4MXUnePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNSvz5lapAtEfCszC8ODJB54CHV2qsa6fzkZXN8My20=;
 b=jS93XroZRc8yniRNUoFLvrkX8KzJRIx2AcR0Nn3H7sPyH9kgaNKpZVRwGxHQ2oMHVA/d6j5kRMI2UEeItEHT6U+ytvZmO1V0g6vOY9d7dWyF8to+2D49KZUh3M2GO+mHKHGXz80CSYOsU89tZZ6TAAZ/WHLktB/J11/5mDGzZgqRtnt7E957z4lIv8izPYA6emBpLpCAgLNIppdJZSfwlYF9AKC5mXlOFL5Oft9xprUG0FUXMp6T27yrMnHQ4MQpTe4aYFOn0wArnGxzm0DTnqoSeAkxgY8B3QIfI4q5yU3KTLQylnAvkV0N1c/Pm04BOH4QMhTvNt2k3k+M/dVrWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 00:52:12 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 00:52:11 +0000
Message-ID: <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com>
Date: Sun, 30 Nov 2025 16:52:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
 <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 09167937-33f4-471b-acde-08de3073dca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STkyK1lJOW5PM2ZRcVJJV1NrVFI0eU9iMUszZjBNSHdCakJRNS9GWXZFaHpY?=
 =?utf-8?B?QVdDY2VrN2E4eFBuMXE1ZjY3S3lQMHRxS3RYZHQyS0FheGk0RDZuaUEyRG9E?=
 =?utf-8?B?WnNqZ01YNGxFL05Va3JBVkJMNEdrekNweGpQWUNUcnQyV2hQQUZtSVJMRTQ1?=
 =?utf-8?B?dmNFMC82VHorWlluazJ2bzJWaDhWZmlFOGIrV082RW9Ca29kdDNBdzhiR3I1?=
 =?utf-8?B?Tk81eE5ZQTNMeVdIUDNBeERMTzZuQ2xUUXhkMFpVOFVNeGpZUkdneFNRb0Nx?=
 =?utf-8?B?NHM0MWVJMkZ5NFNMY0xDMTlmTFhVQ1FReHVzQmo4RXFLczFtdHJhWWlmUC9V?=
 =?utf-8?B?cHp1M0dSWnJiYTF2U0psWmJLTWtjSTcvbmF3cEJqUGYxa0wwOWk0VHlsd095?=
 =?utf-8?B?TThXRGNPNmM1SU9LRjVCOThFMTlkNEk3M1RSbUpkc3JLek03YlZKMCswVytG?=
 =?utf-8?B?NFNML2JnVklEbzlEeEtrdHl4bE0zblZtcHdpNG8zbldYSVFOd09ZZWM2Nlo1?=
 =?utf-8?B?dXYyb1VNbjNVL1JPZmxxanQyUWRMbEx3UmVSaS8xb0toSC96NHJhekxuOGlP?=
 =?utf-8?B?OFY3MExYRllpc29QdHNOWVQ1Y21GUXkyOXRsMmx6djRxa0hhTFVPM284aVMy?=
 =?utf-8?B?VmNUa1ZtTE5KYWVOZ3BpZi96TDNDdHVPMW02OFVwcklERWRGT1VZbXlHZ0Fp?=
 =?utf-8?B?VVVIcndPVC9STnZTZmJuUXF2UjVuakdrdnR0eDFZTTYxRGJjN0ZaemUwZi9r?=
 =?utf-8?B?ZllEKytnUGxGRTAvUXhlVUl5NmxEVDFrRUlpTTFqTE5La2V3ZjZlUDlGNi9v?=
 =?utf-8?B?QThEYVoyRVVIM3FkV3EzZFJ6MEpVSGpKOVNGNzlBS09HUlFKTFZrMmMzM080?=
 =?utf-8?B?N2JOVEVaZmwvVHNKeTBNV25najJuZVlUTjJnM1VMRHVKbVhNRlEycDI1eTVm?=
 =?utf-8?B?TnV4SGF0RHBZcGZDL21KeVFHYXVNdXJHY2RqbnZxa2Z0R3M2Vm9uZVhmc3BK?=
 =?utf-8?B?eXVUMXVQUkZYS0plSWJ3VTlkTW9KRlVCUitlWUFTelFSYldoNHNiTm4rT0pU?=
 =?utf-8?B?dWFDR2ZBbTRVY05oWVlaVXNvaHNXR2greHg1SmRpUmlsZ2hVWmlJaTl2dFR1?=
 =?utf-8?B?bjdIZ2JQTkUrSmhBZ3ZFS0x0YzFGU2YyRTBQNXIxRzkwVjd2VWE2OTZBTDg0?=
 =?utf-8?B?bEhEcGNWVEhSQjBiRHN0bEpWS2lxWEJpWUFqSHRBK05BMmJTenZMbk9IaXJ2?=
 =?utf-8?B?UUVyVnR5d1lISXdhM29Ob01vUHZnczl6Sk9lZDR6NVYwYmZRWnFnR1Npamtr?=
 =?utf-8?B?bUhramlZU0taN3JzRUVaYUwwSnNEdVJqZXgzS2JiK0p0VGtCclk3ZjB6NjRZ?=
 =?utf-8?B?YnZOOTYvczVLYm5VNjdvKzZ5dHU5b1FNdG9kY3ZuS2FZWWxFbmxKMzNwbGZk?=
 =?utf-8?B?ZFY1aXpJOHo1dVI5Ni90STVMdlhLc25uSkMwaDJRWno2R2RTS2o3UHhqejNv?=
 =?utf-8?B?amFhaFV3cUpjdmpJMmYxR2hEOTZ3Znkya2pBdE84OFNMZWNWbi9jZ3JjUlls?=
 =?utf-8?B?ay95Z2ZPWUg1bUdRTElGZFZrUVdQR2JBd09ENm0xbDhZOXByNXZKZDBtUHlR?=
 =?utf-8?B?bmNYalh5aktWUHhoT0dpbG1xdDNUZTFKNy9wYVQ2Q005QVVpTU9HSDA3aWVH?=
 =?utf-8?B?M1d0WUgrTTRxblFmYm5yZzk5RlRQY3dLdzQxUHFGbUlNc0g1ZlYxR0lBeUpP?=
 =?utf-8?B?MlhzZ05UeUxDVW9aRFNESHB0eURqS2pSQkJ4Yms0T2dTUHRSUHd0N3NheEl3?=
 =?utf-8?B?RnBuTG1ndDdrcXNrVk9oYjBmcUY5eDlhczJMZDhCYXZjVFhvZmtKWUxKeHZy?=
 =?utf-8?B?YitHazEwV2xmaFlWQzhDL3ZaUkVlVm5MbnVnS2NlMENlL3VIZGc4alJLNDVa?=
 =?utf-8?B?UWQyNEg1aVZhNjF1bWMvUDQ1UlBRZWdSRmlRZzhYdGtGcks1MWJDbEhNem82?=
 =?utf-8?B?TmYvVDdNakJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUJJN1RSanZGZkhjQjI1cUQ0YWk1ZjVyZEE0Q09aL3Vra3lkNUhPRVdWY0h5?=
 =?utf-8?B?eDRGOGMwRWl3b25raGtzMi9qajd4N0lNc0orTnNoYlRZUllIbVRSUDVhWUc1?=
 =?utf-8?B?S01FeWkyRTJLYm5uYmRaM1ExNitIWnEvR1N6aFhKdXZjYjcremE1YUtOeUhu?=
 =?utf-8?B?azQxNTYrSUVUOC9CcWRGZC9LdEkybXlVcTdHMXdNRC8vNnJoOGN2TjRRZ3J5?=
 =?utf-8?B?Y0hPNXBHNEJvamxMY283MXA2SmMrL1pQUk5QMk02N3FLWHEycjZOdWRBME4w?=
 =?utf-8?B?Q1piL21jbHN0RmROZXY0Z0k0aHpWMFJGWjlhRi9RNkp5VFpEa2wwLy9LdUpO?=
 =?utf-8?B?VDdkMWU2N2oxL2hsTERSWndBbmdIaWdGYUR4L0llWitVS0N1NE5pRWRKOFFx?=
 =?utf-8?B?dVAzcHZ4SENKV1NkbExVbSt5S21hdEM0MjIvV0pjSXdMWWNubmE3cWdJZC9L?=
 =?utf-8?B?ck5GekpMdGNkM3hXTU4rU2c5dXBtb0RjR1JkMkRPTSs1YVJ0RmtCODVuYUJm?=
 =?utf-8?B?VGQwRklic05GMmtRODBmbjFXWXprajBWVzArZDdrbWlNTUtWWHZVMmpQMS9O?=
 =?utf-8?B?VnNBdVlXTDlwS0Y0d0JKWWZ6SVhSTUs2Q0thcVQyN05GWEtkSjRIajVGdjdl?=
 =?utf-8?B?dC9hbyt6dlJlSDQwdy91UmpBaklzazFRZCt0aktndFZoM3B5UjRWWEJRTjEx?=
 =?utf-8?B?aXR6aC8wb0w1bWJEK2FCS3krbHhBZStUZGE3dlVFZ1lBUmx0LzFhYkdHc0Vo?=
 =?utf-8?B?SllxUXRibllxem5VYzhTV3FNL1RwRndTQnloc1I4T0cvZDBrcSt5VEF4aGlU?=
 =?utf-8?B?Y0E0ZjMvYjE4Vk9lNTZzMXE5SzJGQ1R4RnRaZDNkRVlFUFZyUjhoUEVGRnpN?=
 =?utf-8?B?OGhkVEZmSkFLL3BoSlBxV1pleVh1MkZ2Z2ZocTlvVmdIeXc0TzdYT0lCdW9J?=
 =?utf-8?B?aFdQc0dCa2hadTVNMXBsTXVZeGMyK0RYWDNFM0pxLytBT2FPN3dqS1hBRzVY?=
 =?utf-8?B?NEV1dk05bTB6OVdhSUdxcXRJd29odWFaMHowNGExU29OMEZTeFQ3eksvNnNU?=
 =?utf-8?B?WWdwY3dOOUo3cGFVL3ZZNTg2VmVIb0MycUlLOVJhVjBhQ2tRZktHYmlXRXRm?=
 =?utf-8?B?Qk01eUhzNWlCVHZXNi9sc3pKeE9FS3Uxa2RpYmdHem5pU29GcDcrYW8xV3Zi?=
 =?utf-8?B?TXlKa2xpVkVoUGZudmNNSmFHWGhGQlo3Vjdham9ZMzdNN1I2M25WVTB5Z2lN?=
 =?utf-8?B?bEJzR0NsQ2xKdHR0SWJVM29pL0dKaThvY3hodCtnWSt3ZXh2Mk1vNllCSVNk?=
 =?utf-8?B?elRkWldmN0xmeXFSa1MvOEh5dkt0aUQ5OExKRU5GRHNsQkxPajUzSys2Ukl6?=
 =?utf-8?B?Yld5WXY0bXdXZUJQREQzKzhZcStKMFA1YmNOelBjZ1NmU2VXNEE1OFVPdVhr?=
 =?utf-8?B?eENoWjRYZzhNYTkvNnhSM1cwV2VyRjg2MFVZSkc4cmxFQmM1eHFIQ1lRdVlt?=
 =?utf-8?B?WGMzTFV3amdDVGR1ait2YXZMOXRzZ3N2cXpGOXN3NjdDbEVPK0RGOTc5YkhY?=
 =?utf-8?B?K1dOMkVuUDFKUjhLdHkrN3ZBa0RTR0RLT0h4dlE1L2QvQ3RvY3BGdFRIYVV6?=
 =?utf-8?B?N2NHVGJrZXkyZmsvTFhBcnlPR3VRRmlHR0l2ZTl6UkRZMmxsTmQ4VUI4d2RK?=
 =?utf-8?B?YmtxZUxtc0hybUpUU0wweWhEU1IxaTM4RjRYZlorTjVIMG1kbElrMU5xSzJ2?=
 =?utf-8?B?TU9Fc0RCS3gwSE9sbE55ckhtWG5BZ2FSc3hqb2xQdlRucW1VSTRLUzFaMVVu?=
 =?utf-8?B?WjgzT1hsb3lNTzhIRkFpWHprMDRHSkI1NU5QbVF5cGRuVFVVTVhvb2FKZEVN?=
 =?utf-8?B?bXNxVExocHdSVE8xNG90cnZXRmN5TmdKQnZWNnc2TnA4Yk1vVnNKTTFqMTZF?=
 =?utf-8?B?RGM0NXk3WUkxTnUzSlVZWGg2eTFDOTcvOGRNZlRqcGdmV0VlOFFOOEJqWUta?=
 =?utf-8?B?S3NQZG5FMjRzUEZBcG9pZk1BNDN3UjNOTE9pMXZXRWtZNnNzSEloVXcwdGpE?=
 =?utf-8?B?WUhUZmlERjV6Q2FSWUhxclV3dCtVYlI1OGJFK3JtYXd2WDVVU09BS2UrTk1t?=
 =?utf-8?Q?xvlHLjHmGfWpWGwbrLHSOhAMv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09167937-33f4-471b-acde-08de3073dca8
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 00:52:11.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDNY0iPFO/mQlWSXq0aadG5EHtrDVoio0yb4AtDeqVPxcTBkaOFpGHiBEAv6E727GYFBsfUOlYriETmFU8ye0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

On 11/30/25 2:42 PM, Miguel Ojeda wrote:
> On Sun, Nov 30, 2025 at 11:01 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> It seems pretty clear that if one writes a *build* assertion about
>> a function argument, then that is just conceptually wrong unless it
>> is inlined. Because it can only really be a run-time assertion.
>>
>> This is what Alex pointed out, and looking at the code I agree.
> 
> No, the function here was already inline.

More precisely, it was already *hinted* to be inline.

> 
> What Alexandre wrote, which is correct, is that the fix is about
> asking for *more* inlining.
> 
> The build assertion itself is fine. What is "wrong" is that the
> inlining wasn't enough.

I'm having a difficult time with that statement, because if you
write:

fn bar(n: usize) {
    build_assert!(n > 1);
    ...
}

Then that is conceptually wrong, because it must be a runtime check.

The only way it can be a compile-time check is if you have some
way to *guarantee* that the function is inlined into code that has
a const n.

Absent such guarantees (and we have "nearly none", right?), we have
been writing "partly wrong" code in all such cases.

Why? Are the guarantees stronger than they look? Or other reasoning?

> 
> Nevertheless, it is (or at least some of these are) definitely a "fix"
> in the sense that it did fix cases we hit where the inlining wasn't
> enough, like Clippy ones which may change codegen (which in turn is
> why we say it cannot be used in "production" kernel builds:
> https://github.com/rust-lang/rust-clippy/pull/8037 -- back then it
> disabled MIR optimizations).
> 

Sorry for the fussy detailed questioning here. I'm trying to bottom
out here because CLIPPY=1 is a very solid requirement before posting
patches. 


thanks,
-- 
John Hubbard


