Return-Path: <linux-pm+bounces-39140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52BC9DA15
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 04:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9808A3A917D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9078E20C461;
	Wed,  3 Dec 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NAji2Y1g"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA91BC2A;
	Wed,  3 Dec 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731925; cv=fail; b=dYJszVSk/7mOr/ZhraT+0RvrUZb2PDJUI5Ol+p7tuZzVcBcrY+1LF973ANAzPPpYsgCL3xjARAmKHlb5rpWnXWWcruSxfFHjhLFBg/jS/DKKO/Ldld+ujUsDX3mRzd6X9mUjuSODVffwQlI32ceeKJQkVg2dg+ZygTGdIflu0yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731925; c=relaxed/simple;
	bh=9FZNMK0JOb5kcikMDM2lWOEMfJl3e1Cb5EN06Der3X0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=iEQhTsqOd6z5dndo/okZ1eW2OIQH+fwOX9W646bt09qVo+NTgjxuoeH7ON28G/JCRJVTOY9xYKYdM8aGPyojqmxiE01yl0JP5bxLQ5f6tF9KEQdSE6sZwc7BsAku08Ju/vFEaJM5iIcLBSLWzrJqtuwm57FJDS7Khzg3HrkPv+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NAji2Y1g; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqzzgybtKx0LaOMtToBDLG0E5m1j4kEenE3BrWFPGw1iatrOP4XH6TbqEzQTm/GSsP8LOnhfZWZpzoZlomiQoTtPUfg7WBF3zy++IsB39U00Yj1y7oOav6zEbHDc139yhTa7f7rgGiQoohd52K9kDwxCBn9DqwXNYdY1PAWnjcQpm56P7GHqvoQkJVd7h/mG3oq2EVGitE/ydHF9q9m1ti2ShaPg5WXq1MDmhY2IzA4RV6JOT2+eGCf/ihQBkJtwDFMpmaLEhL5YP7XFB34iY7hhuAAlRhPsleih5bSuWqraOX9eZL8t6hgC9fH1n+gl5QVTTOO9Q8p+UQLxJcll6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0C5pLMWLLqyomK8W3E8QY2KTMMVgzXTN5z6MB8xySs=;
 b=kuOtLSYZAI5ApjBD6XU5qFBf6fP79m08WHe9ni+pe11yxu8PXNrOwYa5sT1nJ2bB8yJU9K5aFWl9HQCKnUE70dUaioR8CYQ4XkAEwmsR9xM1neGZWQwHOJSK1VG1r2LjGsCe/tBf5yut5QLRLZ6NTZo8jZOwU1/35eBequIFIlgA3l/QIh7M5nwKsKMdOCCwChBsZ3DhgjttxnVo3fakTe/1if9FBXtO7oKFNDXkZdx2UEB/DneKOYoTfpQjSdYndCA9YiL4Aye6BRl0WUgtnKKVZPjdpu3hbk2+kCDmDe8odR37k1iuE90DpudS0HkYEBn6s1Zp/aaP66NpfAN1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0C5pLMWLLqyomK8W3E8QY2KTMMVgzXTN5z6MB8xySs=;
 b=NAji2Y1g35/zMCP44prgRFgcJXDPXyYezVSf4eDTy261CFP9zwIps++BcA5z7SmajFWs8qyWKLEpSA0M1RIdq6hcx2DBXbgCERdHxg00ZFf7UuyPEOdRzGRi70J5cqprY5hV9CaoDNAr+h9mhLNcmT5u6JDvWUaR7Fw2G3jZh4teGbqsm3DEHL8w7rxIUFOXCC6klgb6yvAJG2WNeESZ9WsHLBmfu7Uj/hpcJRppmMuVFzTT/Vl9Ca7YikWZUutQyCZdXGdWX5S3yTPYuZr5x83qrsahdGJ1ETzVSl4NdkUo+WcH9MEw7G8Kca9jM0PG4PaQQxaHR1BxbLGarg8bjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 03:18:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 03:18:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 12:18:34 +0900
Message-Id: <DEO995E7PYDL.WLIHRO9TPA7P@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use
 with function arguments
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Edwin Peer" <epeer@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com>
 <10bd4b34-f28d-45cb-8d6c-8383cd63b56b@nvidia.com>
In-Reply-To: <10bd4b34-f28d-45cb-8d6c-8383cd63b56b@nvidia.com>
X-ClientProxiedBy: OSTP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:216::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: a10bebd8-fa12-4922-2dd6-08de321aa6e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzhkcDBTVk9veTE4ZFZJWXpqdHZHQkRRNjhHa0VNVUg3NXd1czVkRFE4OTVK?=
 =?utf-8?B?K1R4eDVJZUp1dnA0WTdLTmd4amdtL2cxS1l4a3l2dXFJdHkwdWNaRUVWK1Nm?=
 =?utf-8?B?UVNaNGthRDd3V2pRcXZpQ2NadHltT21BQ0VIUyt5Vms2WnNDL0wyc3BjMHpO?=
 =?utf-8?B?Q0dXTi8yQjJZdFZIZnVXT05CaXBLbCtjc1NzTUdOcm9JakNyaE55dzBSRlQ4?=
 =?utf-8?B?dkk4REJlVXpaa0NYMndjemFvaXV5YStVVHVyL1Njais0NjZ5Y0g0aUM5R1dF?=
 =?utf-8?B?TVdsUnlFdmZ1Qmhoa1laVTFqNTFHWmxoTjZXQnJTVkNjcSt6QWZNQUxCZWN4?=
 =?utf-8?B?THJ2djlpNkNOK0NEZXg4UzU5YXdlRDVBTHVYUkdvb1kwN01nRkFHdFk0UWZN?=
 =?utf-8?B?S3p4bmQ0YWx1eEpuRGJwM2ZmSXZIWWNnOWFCMjIyUEppOHBEcmtNWHRKNjZt?=
 =?utf-8?B?MVNZczUwWC9KdnBTRU10VlRYQTYxa3FPakEyRXJVUTJHZWh2aWlYSVpucEpz?=
 =?utf-8?B?SlRSVXJBeEJKM2lPSzR0ZlFOd0lxZmsxTlFtTUZNUUEyQnc3b0lvTXVVUFZj?=
 =?utf-8?B?K2hFSFd6TGNpYjVJR2FnYzBZRm5MS1NOT2w1WVZtUVBVZGtJSEZGWVZaSzFD?=
 =?utf-8?B?bE5jbkwvQnRpd3dDejFlcXVUdTNmNGNlUDJ5YmxJZWJwUk5kWUNhbWtxT0VN?=
 =?utf-8?B?Y1FqUmdBTzM2TmtzOUlCYUlKaVlOREVZM3JjSU9nRjE3aHU3NXJiR1k0V09j?=
 =?utf-8?B?ME16akxZd2pUdVZGN2M5emJ6T0h4a2ViRjg1MkhpZ29pRFdJb1NoOGdNRUc5?=
 =?utf-8?B?QUtqZjd0bFIzVWYydXRCby9YdHNpbUlKeWpMKzFxb2k1MDNUZzY5SUcwaHhj?=
 =?utf-8?B?MkNSVGdUYTR2TVlkcm50dWhuMzJBTFAxaDN2Q1VBZE1IM2poS3R1ZHcxR05z?=
 =?utf-8?B?OUtldWU4WlE1T2MxQWMyVm1SNU9peEtleHZqYlpXYUt4cVQvK1M2cGJXM1FH?=
 =?utf-8?B?OThESXUvbkNhK25lakpOQUNDOU5vVTBmSzl2R2hxMzlML2JWNDYvVmRobUpl?=
 =?utf-8?B?K1VBNm1XRXBqbUZtamVOSHh2OFBoWDByOFVxTThFbEZEcWtNdkdQQktiVDJn?=
 =?utf-8?B?RDd4L1FNMDJRdE9GYXVNT2JZa0FLd0FzbnBWK3lxQ1pZQTZRT2Q3aDF4NGtI?=
 =?utf-8?B?aXBuRG5ITWRTZlgrL2gyY0k4Z1VkZzYwOE40bjZvS3dXakY2ZGprTXZkbTJr?=
 =?utf-8?B?K0tyM0VNSFBhcFRLU1RwME01VVhxR0E2bm52ZnkyOHpzTTFsRmVrVm9lSUFM?=
 =?utf-8?B?NkR0MWhzdWxLblhteFZDUkZadDhHc0JWSE9hMTIwY3ZIRTRsL09IMVlGR21a?=
 =?utf-8?B?TzBUeW05SDJ6aG5jSStyYUc4N1d6VkRKb1h1cmZSVFEydUFGVmNJbkNWa1ZD?=
 =?utf-8?B?emtYV0syNVNYVGVjcFkwdWdvQlk3NmZkelhMdnJDYm9pRm1PanZIK3M2cGFv?=
 =?utf-8?B?cXJrckpjVVQ3K2pqTFAwUkNZTEczS3JwdlBNWllQZ0pMSTlpRTNuQ0VpNXhH?=
 =?utf-8?B?bkJIK0l1Y1hJUFQ3V3ZMMmF1RTl5aEthZU1Gc0lHSksyTDd1RXBGZ0NzdWFn?=
 =?utf-8?B?ZEVzWXdTYm4xYTE2S1k0Y21NQ2VmVWhvVURMMEpIUlFaNVBJMGxnbG93MDBS?=
 =?utf-8?B?aHNIOWNQZ09nTVZycU1hRER2NmdLRXRLbGhUS2lvT3RsOWxidkZlUlB5eGJM?=
 =?utf-8?B?VWh2S252U2V2YkhtdnUxd1dnTU9vdWhmb2ZzeEl2NFhuM1ZBdmJZbHp1c21n?=
 =?utf-8?B?aFFCSmRrTkM3cVpHVlVHVUlGeDNPd210WCtlVEtwTFV4YWFIV1hicWYzaHhK?=
 =?utf-8?B?ZEwrMjlJaWR2K1VmMlZDYm1RY1pyTWNDazB3LzNMbEQ1ZmJ0cE04ZktCTnBw?=
 =?utf-8?B?ZGEzSnc0bm10UW96YmRBUHl3VW5kVEVCckFKeW5MNDlZRTh0WERURTZaSzIw?=
 =?utf-8?Q?AnxxyOoIKuF/fmK0UJSRr1GQVtPlQI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1lLSTZUTzlJVmdVSTVXSW1YVjFmUTdENVVZeGh4SVk5ZlBGNElUeHJHek5o?=
 =?utf-8?B?SDkvNjRycnc1cTQwaE1Da0RZWGxKR0RsSWtLVnhIK2p0bi9HSm5WT0h4Si9R?=
 =?utf-8?B?UDIwdGpBaVhEaktFakZjRDBEVnVVTStSQWxUU05lU1BoSE5udkllWHhJTnFp?=
 =?utf-8?B?dExuenVXcjNlNmJEQnZqQVZmb0h0dkZTMWx0VHBEYWhBa3ZWU0d1WnRhQ21j?=
 =?utf-8?B?cmVZZXVwOVlMN0hmdFdHaE1RMHRtbnd4ZkZHRFJpTnpvR0k3Qkw3b3V6ODlm?=
 =?utf-8?B?alpaWmJGTzN1U1o4cFFYZmV3ODcrbG9xSmxTeVZSNmtXeWJ4eUw3VEZGT2gv?=
 =?utf-8?B?WHc0eXFseUM3Q3E5d0tlQ2U1UlVKa3JUblZQSkY2TjlHRHdldkVoRit4WDUz?=
 =?utf-8?B?bldnYmFvU1o0SXVqRkdhcUc5ZDc3T25HWndEVWpVTGJMS1dkNHNhemVwMWxs?=
 =?utf-8?B?K1FnRytPaGF6WUNEL1Q2TnNBc1ZsUUxoc1Vqc2VwTVRDQ011UmNRSk9RMitV?=
 =?utf-8?B?MkR4REhMTjJkekJYZzR3NVRMeVlGWlg2R0tjUU9vYlIyMWkrQjY0d0ZDaElx?=
 =?utf-8?B?OVlyRmRvbWk2SjZGZ2doS2JpQmR4N1pUQVhNVGtnYmNZMUNMZG0zTTdlMXRj?=
 =?utf-8?B?OEw3bjlKSXJtYXZRenhYTXRpc1VUcnlXeGR6UHMxQ3ZuVEFGZ3Fvem5TQ1dJ?=
 =?utf-8?B?Mkp6OFd5c0J3NDNacGVrNXZyOVBjblIrRytQcHk0V3JLc2hZYitoRFU4NnNv?=
 =?utf-8?B?SjNZeFgzWkFKS2FNdDNmRlB3eFpiZ3g2V080VUpheWx1c3dZbDdSNCs4NVgx?=
 =?utf-8?B?WUxORUhUSWhXM0Nlbm5jVEV5Z0VBdFI5d0EwUFdyVytDdFk2akI2dFlJbURr?=
 =?utf-8?B?c1B3V3F4ZlYwdEd4RlU4YmR1bEFFb3RxS1NmWFY3Q0taMExENWo5d2hmZFor?=
 =?utf-8?B?eEpDY0RHQVkwcGNvNWlrOHVucklUNm9ESGNkU3RScFN1aUd4NW1JOHdhYU40?=
 =?utf-8?B?TUwzcXZEZ0QzZGJiVlFnQitxRjlQQnFwZmc4ZEhTUFk3dGhONG5QeUJLVStO?=
 =?utf-8?B?MVNNbzd4TlE3R2R2cFh0K1N0UThMSTZuZEJvMHU2R0JTWFhMUkdiVnp1Wk1M?=
 =?utf-8?B?TzlkTU03UjVlT3lLYWRUR2ZaZW1RVXM0NjJmWG5OeG9MZjFWZ3QzWXlEdGcr?=
 =?utf-8?B?c2VYb1JwTk1OMSs2VktsRStQNFlVZ00wR1pQdTI1TGV4YWpYTWxzcTg2MU83?=
 =?utf-8?B?d2crRzQzRmwyZ0U0VVUxVXdPbll0RVFqU1VqQWhicHVPQkJpbnNSTmFtN1Qy?=
 =?utf-8?B?UGRabVAxT1QyUHdZNVBmMFJMbmdCbzVwaGJjS3dIU2JuQ1pXWjNOcHd2RmZY?=
 =?utf-8?B?T1c5OWdVb0ZrRjJFRk9lRkMwUW01UzE0ajIyWWpaeHBab081L00yNlpCRzNK?=
 =?utf-8?B?MDJkVjhkMGtiSW1qdURTVTJnblNkRWpFTk5UTVFyZDlEbXFsOS8vdHMvSzBL?=
 =?utf-8?B?clhxYlVBSit4VUdOaFRaNC9KSmc0cFpxdlNNZ1BSMHZNTit1TWw2M2o0Zlov?=
 =?utf-8?B?Z2h1QzV3NlNaeTByWXI2TUNkd1RoV3dqd0FtUEh1MEdhaHUwNmtZSnpVaTFK?=
 =?utf-8?B?eExvNjBLRkZ5WVBMMVNJZlpkc0I0VTd3R0FRQk00Y2FLT0F4TzR0Q2pVdTF1?=
 =?utf-8?B?MHp0TlF1dHE5cWlJN2tORnlHbTgzT2dZWi81WmF2UlNLaVE0amR6blY2Ym1Q?=
 =?utf-8?B?UGJkbXdlVGlHTnFJOE92UGM4RWVoam5MakU0cit4YzdXcXFLaHlISm1BMmFo?=
 =?utf-8?B?d1FTd1FtRExHTUtWSDNTbE8wVThQQitraXFLT2g2N3Ixd1hURDQ0Zm10eWp6?=
 =?utf-8?B?eDJIUGZUKzVaQi8yNmxhQmMveUVHM0plTUw1UnBkNkRFOWVsak5NMXNTQmg2?=
 =?utf-8?B?SnVmWU1ENEFYcmQyU3c3aENhQVpiZzRvYytrSzAwK05MZ1kyRU84OVNQSXF4?=
 =?utf-8?B?dW0xRmdEWUZNL1lDS1YzVmZBTlZPRkQzWjJ1SFh6Nk9yTFJCVlNjSy9qL3ZT?=
 =?utf-8?B?akd1bVBIT3dLQXl4T2g2MUJ4bVRXdzRqazBMMDBZUnpSRkdwZUtleUtFN1lq?=
 =?utf-8?B?czZwWmpRQXdrK2l2bTlXakROMU9pYlFNTXZHOHBuY2lKN0ZweTRheVMvNmZH?=
 =?utf-8?Q?I/Ky7w1t9Gmxce+hQtaIcs8SyOZd+xS/RtSrtvBJ/zUT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a10bebd8-fa12-4922-2dd6-08de321aa6e9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:18:39.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK6Hqivx4YSX8DwRYOFhTiQVJ12dK1Gf6ULe94rWIm0JrRTIOlodHOM+NnJg8Jodic+tHM9YUifjGDclsTkxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

On Tue Dec 2, 2025 at 4:53 AM JST, Edwin Peer wrote:
> On 11/27/25 18:11, Alexandre Courbot wrote:
>
>> `build_assert` relies on the compiler to optimize out its error path,
>> lest build fails with the dreaded error:
>>
>>     ERROR: modpost: "rust_build_error" [path/to/module.ko] undefined!
>>
>> It has been observed that very trivial code performing I/O accesses
>> (sometimes even using an immediate value) would seemingly randomly fail
>> with this error whenever `CLIPPY=3D1` was set. The same behavior was als=
o
>> observed until different, very similar conditions [1][2].
>>
>> The cause appears to be that the failing function is eventually using
>> `build_assert` with its argument, but is only annotated with
>> `#[inline]`. This gives the compiler freedom to not inline the function,
>> which it notably did when Clippy was active, triggering the error.
>>
>> The fix is to annotate functions passing their argument to
>> `build_assert` with `#[inline(always)]`, telling the compiler to be as
>> aggressive as possible with their inlining. This is also the correct
>> behavior as inlining is mandatory for correct behavior in these cases.
>>
>> Add a paragraph instructing to annotate such functions with
>> `#[inline(always)]` in `build_assert`'s documentation, and split its
>> example to illustrate.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/build_assert.rs | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/build_assert.rs b/rust/kernel/build_assert.rs
>> index 6331b15d7c4d..f8124dbc663f 100644
>> --- a/rust/kernel/build_assert.rs
>> +++ b/rust/kernel/build_assert.rs
>> @@ -61,8 +61,13 @@ macro_rules! build_error {
>>  ///     build_assert!(N > 1); // Build-time check
>>  ///     assert!(N > 1); // Run-time check
>>  /// }
>> +/// ```
>>  ///
>> -/// #[inline]
>> +/// When a condition depends on a function argument, the function must =
be annotated with
>> +/// `#[inline(always)]`. Without this attribute, the compiler may choos=
e to not inline the
>> +/// function, preventing it from optimizing out the error path.
>> +/// ```
>> +/// #[inline(always)]
>
> The compiler may still choose to not inline the function, even under
> `#[inline(always)]`:
>
> "#[inline(always)] suggests that inline expansion should always be
> performed." [1]=C2=A0
>
> "Note: In every form the attribute is a hint. The compiler may ignore
> it." [also 1]

This is true, but AFAICT this is the best we can do as of today (and in
practice it thankfully never failed so far). If there is a more reliable
way to always inline functions we should definitely use that though.

