Return-Path: <linux-pm+bounces-39006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 440ABC98ED9
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B894F345BA9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A83248F6A;
	Mon,  1 Dec 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cJKYoB3Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0010F1;
	Mon,  1 Dec 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764619017; cv=fail; b=PXdsiN4vjHUp+d/07AQ0WIGF2fgGNnO/dFreNQfdRyJrg0uf8scaViG1bKH7A7qPyNP7qBtLh5/ua9lg/Khrct1+7EFydU8SeSUxdj4GHcdVOfed8Q1g6+ejYgBurkLnfmq8MR/QzXynpu53+Aut2gk8G+iBErUUDPBpJFqsZCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764619017; c=relaxed/simple;
	bh=OuqwXfV521Ah/KVARB9F8lraIKm/l0BbSMlebq1yAfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hWkcgMi8y8ZcVLyNP0QBIw/+ekyS02J0DEY+iB2CHpJIkRaZbjzibHfJn0h2lCJeUf9FtDWv4Rhp8uoX5Q33C1MqNogpRYuJ6R5PwfHeLYgKg9HNrSH4aAKNacMF7iTYe9mxOnC0K5xCViqKxvkpuGlRS3I89mnVpLy5/3/lwYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cJKYoB3Z; arc=fail smtp.client-ip=40.93.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DClmxiGW2a7291pF624HVJ0N/Tv/R0Q2Av4xlookenwQZs4aIuB43yomD4mCG3xAhZ23XmlNp8Mq085lNvCKBdlYGh3pu+or1CvRfijbTOTQbMReff/IocP6L//bJDPykovcG3lwbSMjfiLBcyu9bWQB1SKfpAXmDErCPII/9EIrCnw6J8aeTBS87xFNQvogU3jzaaE3CrVnpKSyUZw7s9etJZ1Gi3V7ZCEcJcR/ZqW2WXyUXEUK46jKE8MbJbp+1PyioCq7DxkhyfmW4OVlwnZha/bQ3Tu9nua2+Qnm8S9wvdB9Fd4l9upWXV7RkbBB/ZLmS3c15ZBtoxlUhh6xbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSuuzQbb9emVclyhUDhtV8+e7CVXz7T7A1IwKeRzlRI=;
 b=ixPCPGu+OREERSkMeNkqOQUVJxoQ6J3vg1SIReyVmb/gmdcS98/C3uOe0ht199Cjinkxj6ZP3Nbnjrcv8Rc5IdgSzMfAWCV47nqZg2cSuKlaZt0RI/hZZA2ov5vadGSuuoIzKoygjLCZAMKEwbGxcJjBj6o1DO0ShRMjDEULzdIZlLTZifeokVqPLQAo8Y2PgavEyYUsxrrHK0ypUvTKvubVge5OFkhRAzRq4IbmQs3G9IPGE6IeGVsJqMJOXZnobxkdUzz8XBElxWRJ2W8DpDPzIwqZv8KvU0uuK9J40NbKg4kOt2SUi1D3LX9YRuRK80N92CzZvvX7lLMyv8pNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSuuzQbb9emVclyhUDhtV8+e7CVXz7T7A1IwKeRzlRI=;
 b=cJKYoB3ZAzTHz1Mh0vyOsQruM8vdKXqE4tDrMVOrVJGbj1ny10JPIpiHhWAYsIX3xllG20uBfAW1urSvqSFd3x1O6rSd8+Fb072eOSRKwHW9M0ASE3ch4XLpMVaVyVGIFs88Ho1lMp/aCvRg09lzriybbquLU9dZpqL5ippE1KYCwrGGgupCGdXg6M1EHQtmqpIbkBOn9FE/xS5CnMhMzcumwZkKrTxpFEApuhNt4bi+ZxTWsG3tq9RAoDDDoamqmnxbj6ufvvieaNinuYDVU832NCoAoH4sCyhfntT6oqqHMCSeLM7bngNnsYs7IG7sGx2Gk6YPeYW8HvIYxLtLsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 19:54:19 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::e73f:7d5f:7a1a:f363]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::e73f:7d5f:7a1a:f363%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 19:54:19 +0000
Message-ID: <10bd4b34-f28d-45cb-8d6c-8383cd63b56b@nvidia.com>
Date: Mon, 1 Dec 2025 11:53:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
Content-Language: en-US
From: Edwin Peer <epeer@nvidia.com>
In-Reply-To: <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:a03:54::35) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bd9ac1-f6bb-42b8-56d6-08de31136a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUNJUDR6K3VUWHFvSHRjWU1WaE4rWVR3S2x3U0p5T3FBL242OFk4amNUN0h6?=
 =?utf-8?B?d1lIL1JVTE1hTHFONnJqTHZ2WjgyS1czcmRuTjlvQXh0Q1JpdFNpS3pIODhq?=
 =?utf-8?B?aWU2TmgwMzl2Z1FuL0w5UFI4UzFmbGJSQVhiQ2ZmN3U5amkxYkVHYndDcWVC?=
 =?utf-8?B?VmVIYkI1ZS8rZUdHa1MzQnMzYWQrdGVUMURHOE43WmUvN2FNdHh3VlNNTDlG?=
 =?utf-8?B?T0pkVmVSaWlQeTlrMjhGSW5IRGx0VG14T1hFUTYwbmwxOFZ5UWp4dUl3dTQv?=
 =?utf-8?B?QWtrY3FaU2pLdktNamw5TXluVkNFRWNoZUFmMlcxRXNVTDhLcmp1a1Bmc3dW?=
 =?utf-8?B?NnpZZjJRYlFBSUpmN3Z0c2R0dWxmYXdlWjZjc0FBdVVMaHhITmkzNnNEbTRt?=
 =?utf-8?B?TVpwUitmZEM3bHZ1aFA4V083N0tQZ2dja0FZTndTcFcwZWJ6RXVGQlJ2Zk9x?=
 =?utf-8?B?Ti8wQUphNWRwcFh1c01BYUdkY2NkU0xrWGZQVTZXd0FPL1N1T1g0UnZJRG9h?=
 =?utf-8?B?NjdYdXNSeFlOSDh1WTZ1QjU2N09adTFXQytHWEVzVFBocFpmblg5eHIwaHJy?=
 =?utf-8?B?SS82TUZZV0xxTGJyNVJqVGZNSHYydGFBU1hSdU1hSUF3eWR1eTRycWtMdjJk?=
 =?utf-8?B?RDhzUGZFYTVRelhJWUJ4VVRZUXlyNWRWVGdSYVU3M3R4MkhEWFFyeWdLTkdX?=
 =?utf-8?B?MXFEYUdpaDJYcFZ6WU41bVdUc2JkYTROcXU4Z2hyYkl1Y1RGWjg1d05qTUNN?=
 =?utf-8?B?Ny8ycENFb0sxOU9ubWdTQmgzOUI4UnB2TGlscm5XbXhVKzR0WEhOajFsOG9M?=
 =?utf-8?B?cEFhOGgvVWhSOXo0bWVWSFhEVkZSb1BHMDZWN1lzNkw4NDNTWjJFWmJkM2la?=
 =?utf-8?B?cE1HUVo1emN0WEZrNndNSkxIYkQ1cXVxUmdYVnNHZmtqa2l1Y1pEaGRnL2ZH?=
 =?utf-8?B?OTJzQ2NnaGttbFFYR282ZHpIZFB1UmpwMy9vREdIRTFHOHdRQTBLblN2VVgr?=
 =?utf-8?B?VStrV3hIQ3hmOENUYTJLRUgrQm5UUGI3WjVVbmZjcUlSQlR4VGYyZnpJeFha?=
 =?utf-8?B?aHd3UTZvb2NqNEdXVXAwZThmRHNwenkwU1pROG9XR2FFcXZsWTY2SndGNzA3?=
 =?utf-8?B?V2lyUGNxZFZHRGNCcFNCdG9SczRjbWVwQ1p6VUtXbXY3dlZUNjdZMkJ5UjVt?=
 =?utf-8?B?N3N0dElTcVNJdGlQSFg3L0tHamNQMmVZTmQ4c1FuOCtTL2ozaFBTT1J6TlNx?=
 =?utf-8?B?ekRmRkNoaU9jNWNCVU5tUlBSTGpENVpEUVhiMmZodWlpREZwWnl0Y1dEeUZZ?=
 =?utf-8?B?UDZicHZ0ODhMNm5jUkQvVHlDVnd4cEgrbG1TM2ZmbitXTkVmZTVFUmlPUXVB?=
 =?utf-8?B?Um90aHpuWWV0M0JRUlltdUV1YjFhbjAwbjQ1eGE3T2NjL0QrV05YTVdVeGVX?=
 =?utf-8?B?SXpzWWplU2ttdmxqNWlFNld0M2wxZGhoWGFzbXloWVBSL3dzRVUrQ1R1Tjg1?=
 =?utf-8?B?QVpvU0lYM3oyT1Jpb0FhT2swWE9PeCtZVjNodFlBUjVKTkNvU2lYNyt6Z0xq?=
 =?utf-8?B?UHVzdlk0Vm0rS25hTUpGTUpOajhmRnJ4RVBWbjZCd3FnRGQ4S0t5TGJ3SnRs?=
 =?utf-8?B?NE9qK2p6WlNJb2xNRmhsdGZrazRXb0RrS2V0NlM0YnowNHU3RjBxV2lIaWVt?=
 =?utf-8?B?dENsMHhkQTlQMGZGRkpYdGJxdDNubTRUcE13M2lWUEUwMmRiR0JISDE5MXJi?=
 =?utf-8?B?bFIrVThMakNJL05mNjRiL3JwZkZ4d1FDSlU3ZVNlU2MxVmpxVmdnNFhnZU15?=
 =?utf-8?B?cE1NR3d3OHpMaE53TWMwZS8rUVpXMWFNNFRLTjdsQW9PdmlqQTNTcnpwc3Zi?=
 =?utf-8?B?ajRVWStXTDN5dncrWWYvVmcrckNOVGF3RnB5YUU1TXoxOU1SSTJXc2cxanVv?=
 =?utf-8?B?bkZqMU9vcisxRzcwY0Rsa2VTa0pXUnBmWFFrVjRsYlBENm9mc2FvWHo1ZS85?=
 =?utf-8?B?a2RvSXV6ak93WEZ3RFV0b3plVFpOaE9Sc012QmpBQWVXMXcrWnk5NzlZeFpO?=
 =?utf-8?Q?nxGWTF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5182.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWk1ZWdjUGlRbVN3NkdIU0NKQ2VheTkvNURBTmYyOVUxV0VpRTBpRE9UUG4y?=
 =?utf-8?B?RlRpTERJbWFLREpYaWMxQ29HaEg4QlhvWVEyenlLODdpcDFzamVOVjM2Nm90?=
 =?utf-8?B?ZGEvNFNrOHNkNjV0VEs2YzZ2clZSemhDNG05TGJTTjhRWFNMRmpHZGgyT2lN?=
 =?utf-8?B?YXdwamxCS1A2QkhoNzNDZ3ZuSWg0NnhmSTM2V0s3dUk0YmVHRjA5NEVnQitq?=
 =?utf-8?B?WHRzc1MzbC9rZXlhelpaL080dHZvTVAyS1pid0RlQ3Q2b1lMdTRVYWd6eEl4?=
 =?utf-8?B?RkxDUHRteC9MQlI2QTZZWk1ldTFIc3JCV1pvd0tNcGN5SkRoQ3dyWmx4SHdp?=
 =?utf-8?B?YXVFRmk3QmlCVEJ3UFIzNkVISkNGMVAyYVQzNDNldUJCK1E1eFkrSmZ6cU1T?=
 =?utf-8?B?Vk9nWTFzbmRnTnRrZ3dIU3huNkVrK2ZUUmJ0N0RiUlhhQXFJRzl4c3lUYlhC?=
 =?utf-8?B?Y0J5SThkUURNbFpmdzBGSS9kYTRybXAwOGVnbmluS3FMTFBHRE9zZUVjZGU5?=
 =?utf-8?B?L0ljNFhDaVZBdjRSdmROZ005UDVST2RFSTI0UnhzYzVCMXpuOTZsbEhlTDZl?=
 =?utf-8?B?U0t2cWZ0UmJteXhvamRYbmhKQVI2T2xCeHgvNDRuMzBtamVUcjhSSURLOTEz?=
 =?utf-8?B?SXQxRzZlZW93VWdkZEVXQUJSbVdrd1JjZWdkelpTWGZUSnpCUFhXVFdvdU15?=
 =?utf-8?B?bFpXdUlnSnpPbWtwckVKWDRBdGlnc0pTekJnYTljMEpQTVhveS8vOVdBWTBy?=
 =?utf-8?B?Si9ZTzJKRzE5N0Ezd0FYS2JVa2Iyc3UyRkdMVFZDcklranpKek9xcnFCZi9t?=
 =?utf-8?B?cENHaUplcU1lN3QxUmJQNTV5OW5qL3RhcDNlUnBESHovV2xuUkpyRjFxYloz?=
 =?utf-8?B?Zno5dzJtdWFsRklDeXNaakw3ZlQ5L2hTU2ZjNm5OS2dEbTNLTHA2bTRoMzJk?=
 =?utf-8?B?MW9hand6OHVWcC83aHBOMmNaSWZsU0RPUjMyOVdTNGxHMDRXNm5kS2h3TFE1?=
 =?utf-8?B?d202OHdDcU5TZEZWT05UVGlpcHVmbGZkdDRwZHJlanFzOHlhQ2hmWEJySzNP?=
 =?utf-8?B?WHQwVldFOWlyczF0ZHFzOVUxd1RXTXNObzlSYmhpV0J2Rk1VTEQ4SzRSMWlh?=
 =?utf-8?B?Y3NEazY4THJCS2RPNmF2TTdaa0c4cFhyN3k0TWNQUHQ0MjJ5SEJyRGtROWpT?=
 =?utf-8?B?SzFrK2RONDR6VkRNdy9FdnhuUlpZd1VDUlB5OTZva0VsZStpVDM1SGpPRjEv?=
 =?utf-8?B?ZFpJU0IyOGNHMUlwK2N5S3Q0WUlKcmVFU3VsVzZOTkZ4ZXNIRytGSk01N3RF?=
 =?utf-8?B?K0JpNVVaeTZVQ2I1eiswaElYUGZIalZOdHhpZnhFbndBcFowMVhqcGo0NDZW?=
 =?utf-8?B?Sm41c2RuOXU4bk85bVlpYXhtVXNQbGNDV0xwR1hqQ0VxdGVqYStrK3Bya0Vx?=
 =?utf-8?B?RGptWFc1VmZSdWNxNG9vYmRCRlQ3YUhXS0RCUGtMYjlyUkxaQ2JrWjZTWXN4?=
 =?utf-8?B?QVhyMmx4ek9oNUhHNlI4SGhZMEl6Mmhsd0RaZ2U2Ky83ZVp5dTNzVnRUQm1P?=
 =?utf-8?B?bTJOWnlrV1FhM245TzU1UExTa0tDcHRmTzZia01EOXZsYkNCYzdNVWNRSjJ2?=
 =?utf-8?B?b01UZVRicGdPQ0thZXd6WXE2cjRINEY1MkRDZHlWWndiWnZHalR2VzI1NjZT?=
 =?utf-8?B?Rzg5dm9qQnAzVWVBdk95bFE3czNyNk82d2MrbXpEaU9WWUllQ2d5aHJ4cW8v?=
 =?utf-8?B?Sng1clFxRWxqcTdLU1VKTnNLS2xxMlVRajFIVXNVY09WSitCemRzNkdxdGQ1?=
 =?utf-8?B?TkFHbTcyYnM4ZVc4aEVtMXUzdzJUSmpYTFhiS2ZMSDl2OExHRlI0NDFBbXQ5?=
 =?utf-8?B?MTI5dnV5T1UwcnJJOTZHRFBpMVE2K1ZaVTQ0UjBOVkVTcFQ3TEpCemd1OTZH?=
 =?utf-8?B?UENuWHptaVZCSENIemp0b01tTDRlWkZ5ZjBEZ0t3eWs0ZEpIK2ZXK0x6L0JJ?=
 =?utf-8?B?OVlNaFY4VzE2WXBMSjZXTGh6eGd4Z0hlTTF4UjdvOEpiVnRTam93OEdvODBi?=
 =?utf-8?B?WFVaS3oyVFE3d1E0UDFaL2RHSXFFcUJPaTNBMld4dkszUDVEVWZLa0dsa2ti?=
 =?utf-8?Q?0ayQe4nTLkOdVZga/wVqbs/sV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bd9ac1-f6bb-42b8-56d6-08de31136a1f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 19:54:18.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBC9ijWIPBj6O62irvSBynuE8HcJjaxD6PFznHid5SBXGFY7I/NJvj5PJkyohui7orTXNz+fzGi2pcgMlSbUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625

On 11/27/25 18:11, Alexandre Courbot wrote:

> `build_assert` relies on the compiler to optimize out its error path,
> lest build fails with the dreaded error:
>
>     ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
>
> It has been observed that very trivial code performing I/O accesses
> (sometimes even using an immediate value) would seemingly randomly fail
> with this error whenever `CLIPPY=1` was set. The same behavior was also
> observed until different, very similar conditions [1][2].
>
> The cause appears to be that the failing function is eventually using
> `build_assert` with its argument, but is only annotated with
> `#[inline]`. This gives the compiler freedom to not inline the function,
> which it notably did when Clippy was active, triggering the error.
>
> The fix is to annotate functions passing their argument to
> `build_assert` with `#[inline(always)]`, telling the compiler to be as
> aggressive as possible with their inlining. This is also the correct
> behavior as inlining is mandatory for correct behavior in these cases.
>
> Add a paragraph instructing to annotate such functions with
> `#[inline(always)]` in `build_assert`'s documentation, and split its
> example to illustrate.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/build_assert.rs | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
> index 6331b15d7c4d..f8124dbc663f 100644
> --- a/rust/kernel/build_assert.rs
> +++ b/rust/kernel/build_assert.rs
> @@ -61,8 +61,13 @@ macro_rules! build_error {
>  ///     build_assert!(N > 1); // Build-time check
>  ///     assert!(N > 1); // Run-time check
>  /// }
> +/// ```
>  ///
> -/// #[inline]
> +/// When a condition depends on a function argument, the function must be annotated with
> +/// `#[inline(always)]`. Without this attribute, the compiler may choose to not inline the
> +/// function, preventing it from optimizing out the error path.
> +/// ```
> +/// #[inline(always)]

The compiler may still choose to not inline the function, even under
`#[inline(always)]`:

"#[inline(always)] suggests that inline expansion should always be
performed." [1] 

"Note: In every form the attribute is a hint. The compiler may ignore
it." [also 1]

1: https://doc.rust-lang.org/reference/attributes/codegen.html

Regards,
Edwin Peer

