Return-Path: <linux-pm+bounces-43624-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KmUCnyWqGkLvwAAu9opvQ
	(envelope-from <linux-pm+bounces-43624-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:30:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848892079CF
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 21:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7EAE3025D07
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E2377002;
	Wed,  4 Mar 2026 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PWu4sbY1"
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD96375F97;
	Wed,  4 Mar 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656236; cv=fail; b=d/lHTn1YD2rTB6SyOaBEtcna99DOUJ45ac0oHFZEdmabYjgUGj5g6Pb6MbU3Gul+Jm9eslZyEZxHI8G1iGL8Dtyo2BW6T9EqnRKym8Wd9T29MDHniBlKt8ayOvrrsp8wWSTwr0IKSZkEEIqqsTukgvw4DVlDWAD3cBioqw9Fpf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656236; c=relaxed/simple;
	bh=1y4vpA9//jQ+VhQNNpKamjcZgXPTzfI6ZwLjs22UO9k=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jAxapGIPcSyXvyRYMXfFPpQxQF6LVTCcVf57kUywvB5FXxSzEbIlXdOHi0EtAZYrtUWQnShMoXY0Gu4A9PgtYwfzprQxpYUKf/N2IkE9hC3j70VYM6tkUCuVvmxpuEbFyLZCzUPMNi7biJH6bL/5uZCAAJbcMnjyyLnPyu/CE4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PWu4sbY1; arc=fail smtp.client-ip=52.101.100.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVRxQY9uvLx/EY5U/aZiO4f08enCNtcOX1Icar0VzzcK/D/Wj2lZZirTLWjTzr04aHHHm+72THkO77JhCGWAOtGl7rKuj22n+2h6PRzGKERjiZaqXP4napt4ehUn8duKHeVW2jq0DfALoqWIgOzdigORcYFNp8ieGYLr/Ue9pniSmTr7dHyHnf9gy35nLcw6cpeLKyVh9cvNrlAIqsHMn8AoOlSl7X6uf5nYHj9eAZW4/214JedooUL4R8QBArJfNqXCBKGR/7BRwueOthkYQ3w6HAJcErnpm/iTJgQPiNtdOk6vH7PcYuBhkB1HWcwhO9tBhw0x2RlcoEDavn0G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R+E4n2LgU6t1JBVoaUivVX0a1NKpzgvcHzF5te37ok=;
 b=Cfw+Z9RFMu9VLJivsC7trSHlQakX49bclYSE14Ld+IYXPsVntLr858eMkVaZJn+TTaEdC/IT96xl9voJzujLkch4viLl0ZqrjyJLGpOxdDrjrXgHfa0R3jE04XOHQMLCvPKNOnOA0PSfk0j12LNQ0xldC7AJrJrFHXgaNb71b7k02R8YGN7OMCL1uVfPYqPYLNDPVa2VHBkbE6IOFcMoiOvlM9h1nw+t1MjROxAL3IMY9fqgxtKUyjgOOXznj9u0zUCgcwUEPx7nguwcNchNZykuyLpCaJOcCjulA2/3iMfbiMdsRFe4J18dMw1UfQN6kjrcfsn/FuZ11qOqzZTDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R+E4n2LgU6t1JBVoaUivVX0a1NKpzgvcHzF5te37ok=;
 b=PWu4sbY1uyhMNTEhjkvrkvrwxajLu0tq0QV2dY4TzCoUbxL2Wu9ZB2U6XCfVoRap6LE8xAjwgU+g0TWJMLgNMEAcdwyWekGx8qboPH+TSsHBlyN9K5shYhJt8yxrvphI+LylWdNN7bpij0l6/qIOB/TjpohUAmkubjGz817AOcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB3367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 20:30:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 20:30:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Mar 2026 20:30:31 +0000
Message-Id: <DGUA6UMYDGG9.1AA0FD146PS3K@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-pm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
From: "Gary Guo" <gary@garyguo.net>
To: "John Hubbard" <jhubbard@nvidia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.21.0
References: <20260304195330.185829-1-jhubbard@nvidia.com>
In-Reply-To: <20260304195330.185829-1-jhubbard@nvidia.com>
X-ClientProxiedBy: LO4P123CA0529.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB3367:EE_
X-MS-Office365-Filtering-Correlation-Id: 400e5791-cb7e-4fd1-ae1d-08de7a2ce1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	+/4m49IiwRrXt4pIwnqP6KgXQaIX4nylMDAUHEVZ6KCS6uXH1ZAJAK1LFGA7dsH+AxwLldq1zXz6NzagwROt9zdceNX1mvwU81rLQFeL17oSpQYIEOtG2mEoTgACd4525KHRtme0iqXBohlqmpJ3s8xObSk35B2/PJCCFSDpX+e7iFAE5nLnKlPMDzFYn348aoOyYN2n0kTDydoqL0r8B0Nuuvs4M1Twn/ssYr7YuR843S2GvKaPjBpIPaM7wMEmC2yo/l8L4GRd9PGO4I2Akbf0JcVhYffxGTttunxwwjRaRG7bOiQbUWqBLAxCnTXDcnXlpt7BAafIYDKSYTpIoDj9qEeQfeBG+/MCcKnvLi+F3AczDcPoqDuCrDgbU9kEA2Ob1JwoLXhUe5sULXnJcAEN3CsTrv4Fu9BzcL4fytED9A17xvIwiSxoK9870FADByJmV2oc7R6dBpWq+ezjRpZWqFJThQG3N+6BCDUaq6+qjjM8OoSVGN/MqOh6Mr3R9C1WC5ASRXIgh+Ftl0hWc/eq4QrzlRoDP3hZt5vN+r/CwFIxeNy1opOHeWf49KRTIsLJtRo+UWdOSjfroaayNdSaQ6mcw/lpPp/oPivnfwpJjh8sftXUG9l1DAzc7XbfKaeFiD9VT14y9wW6jlp3YIJ5kDOrMf9OcCgV1BoXiXoJEGQiz/2E2nDro7vcVxvwDj8omp2dJXNzafR/w3sqVlz0RznuYIpcv7r4a7HA6nI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWtoSEZ0VDRCMnMrM3doS0cyUnR1MHFXd3d1R0tib0crYjdRSE92K2psam5l?=
 =?utf-8?B?WG1kTFk0WGNVLy9UZE1UYW1WNkphMENOenA5VTFVT0xLbVFRbk83UFdEQ2hL?=
 =?utf-8?B?K0xwNXROaVkwYTJVSTJGRjhYc3d0R2U0VnYwMnhXcGY1bnovUTVXWE5PNXUy?=
 =?utf-8?B?cVg1ZlptZklKRE5VWHZsOXovTndFTTRZaWJ2WmRGVzlGaTdDQnNqNmtVeU0r?=
 =?utf-8?B?Y2ZMNzlzcEVhR2xZZk1uV3Q0dmk1dWt0MXN1MjNJZmhFVFRQSUR6NmsvOVRz?=
 =?utf-8?B?YktFOHFiQTAxbXF6RlF3ZkgwbUNFK3BZQTBnaFEwYmUzQUU0VEZYSlBhNSsr?=
 =?utf-8?B?N2hIOWI0TXRYSWtEYnhCbTZmaVhnTFZBUlNvS3lXM3hmSUVzZ0JTVTBkR1Zy?=
 =?utf-8?B?NFJCTlF2M2FBUlBCbUJielZPVUE0SE1sRFNOaVNKWlZFenlDWlZPdTl5cnMx?=
 =?utf-8?B?TkJ4ak5zcFdxNzZmbkd1ZmRDS2FreWR0dmZTM0E4THhvaHI0REVIVmdWRE0v?=
 =?utf-8?B?enVOTFB0a1dGeVRVZXc5RitNbDFoSmRST01idEVFY2Z3Y2gvOFlEYk83c05C?=
 =?utf-8?B?TmEzZHlOM3JMNlh4QjRTMFdaN2tYcW5uaWZ0cTBSbmtScnNXaDZ6Vmx1TXAx?=
 =?utf-8?B?d3M3SHpEaW9LbkxhdGNOcTdJR1NPS0xENm93aGY1UC84SXBId0JMek9zYXR5?=
 =?utf-8?B?QXZYNlRiNjQyZVEzMnliZi96ajVKTXNUMi84T0NmajBWb1Zpd01zMDVHeFdC?=
 =?utf-8?B?SGpRR3hldlhucWU0SG9FS1djRzVhSWNBS25JZTJGNEh4RGlQNDFMWENWNXZ3?=
 =?utf-8?B?dldXcHNWUkUyVFNYZGFxZlE0YmpzL2FUbVR3aklXSnAzY0x1b1NUSmwydnBQ?=
 =?utf-8?B?M3JXSzBqRmlnQ0pGaWZtRDVDUGYzYWg4OEpRWmRNZlZXYVRaZG9QWHpFQTdM?=
 =?utf-8?B?M01yN25nZmR6dm0zSXdIVnNkSllGa0lpWHR1dkFPZGx5Q2tPYzB2Umdhbjhs?=
 =?utf-8?B?RGpWMEkwV1lEYm84S1dPeGoyL05iTW5jd05kRjNIWjdza0krNG9DZmtyZEZ1?=
 =?utf-8?B?dlVYR3c3c1hTWHg4MEVVV3h0eDdDZTJ6d3hMdSt3Q0J4RzJmbHJMaTlPUWhN?=
 =?utf-8?B?bUVZKzVDbC9aVTZKblFpMm0zclFlTzRSVFpaQnpXbFhHbjlVZ0o4TnA1NkE5?=
 =?utf-8?B?d1cybUFQYjBDL0QyVEt0RHowaVhybFFuelRGQ1dvWlh1VlM0VkRKZ2U4aVFW?=
 =?utf-8?B?dHByanhFMkQvT1IwOXB4aUpGUkk5ZGQ3QjRpKzVJYnhTQVhyeGpERm9ybXVY?=
 =?utf-8?B?TnpDMTZZaUJDR1hCUG5TQnNpcXFuMUVWYU9oM0hPTUdlUlpQN2dpSTdSOHhX?=
 =?utf-8?B?ZFh3MXFnTlExVlZCdEpoRWhkajdobzdXdGczNjNlNkIrVmF5cktKeFMyUDQw?=
 =?utf-8?B?SGx4Unlsd3NRdzNZdzVVazIrTFE3aVFVd0ZGNVd5V2pGeTU3T2d6dDdiQmZD?=
 =?utf-8?B?bXNEY21Ld0hicG94d3I4cXJSWHV3ZVdqbkRuazhGL3NEWTczSjR3ZDY0R09v?=
 =?utf-8?B?L0pERXcvS3Q3a3FNOHQ4WFl5eW4rakhFazh1bFE0N2ZHMENnQXErWDFlWVl5?=
 =?utf-8?B?eXBaN2dLWXFnNE9lV0xCOVZJNy84TFZ0ZG5XdTlBY0NoV1BFTzNrZzBMZkd6?=
 =?utf-8?B?OUh6aDFYWHFlYnhRak1sd3hwSXVtK0d4QWR0K3VxakRiTDVrdEhwQlk5TEJL?=
 =?utf-8?B?R3gzTUdVY2o3ZEc4NGxKVTlvcmljR00vdVIzeHBtU3RHajduR05LODkydHpa?=
 =?utf-8?B?aEtsQ2FsTEc0bEl2SFpWQ1E3QnBHTC9OU0dPc0lJVm90c2ZVUVAxZmlRZ3Zu?=
 =?utf-8?B?RkhQbWtUOXFQVlB3cXk1UURIS0Uwa1RXUWYwaHo5RWpPMjZIVG9RZnQ0WFZs?=
 =?utf-8?B?M0xzdFp1RitHY3FnR3h6VGpUK21SdnVQelVObGtsdzdveHZIaU9RdVBKK0d0?=
 =?utf-8?B?WE5RYVBRdkd4YjZHbUFsVjlRdHVFOWFKaGIxUzhFVXBXYTl0Tk44ZlRxZURv?=
 =?utf-8?B?WHMrdG4wbkR6Y0FsaHZ4ZHJpenl6ajFRUUlhVnNhUjJncHhwWERKY3JnWHBB?=
 =?utf-8?B?cjEyYTB4bEMrT0FNUisvYXduNGY0QWQ1UjJzamlOSHVhSVAwVjRZekNEYndO?=
 =?utf-8?B?emR2UUpLMVp6QkFrWHZsalJ2ZE9SbEJYWC94ZURQU0g1NGpQY2tBNjlWd3JM?=
 =?utf-8?B?ZHI5Tmo3TTlNYjc4REhjclBBVis0dkhzM3ZTUGVCTUFkT1JHdEY3OWFIUzVo?=
 =?utf-8?B?emhRaStSWG90ZlMyNG5nRWUyaStHT2FYcnpUQzRLNy9FZjBYM3Z3Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 400e5791-cb7e-4fd1-ae1d-08de7a2ce1f8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 20:30:32.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNPUG2+l/UWKzHOv80esswNNFqkslH4H3rHFOAasWpmgZdtb/sQvvWOXrgOZ5VKTqELTGJ6Kvbhf/yvieFvElg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3367
X-Rspamd-Queue-Id: 848892079CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-43624-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Action: no action

On Wed Mar 4, 2026 at 7:53 PM GMT, John Hubbard wrote:
> Clippy reports:
>     warning: consider removing unnecessary double parentheses
>       --> rust/kernel/cpufreq.rs:410:60
>        |
>    410 |     pr_info!("The policy details are: {:?}\n", (policy.cpu(), po=
licy.cur()));
>        |                                                ^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^
>

This looks like a Clippy bug that's fixed in latest Clippy:

https://github.com/rust-lang/rust-clippy/pull/15939

Best,
Gary

> Fix this by using separate format arguments.
>
> Fixes: 6ebdd7c93177 ("rust: cpufreq: Extend abstractions for policy and d=
river ops")
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..e94a17731557 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -407,7 +407,7 @@ pub fn to_table(mut self) -> Result<TableBox> {
>  ///         .set_fast_switch_possible(true)
>  ///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
>  ///
> -///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy=
.cur()));
> +///     pr_info!("The policy details are: cpu=3D{:?}, cur=3D{:?}\n", pol=
icy.cpu(), policy.cur());
>  /// }
>  /// ```
>  #[repr(transparent)]
>
> base-commit: ecc64d2dc9ff9738d2a896beb68e02c2feaf9a02


