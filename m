Return-Path: <linux-pm+bounces-36518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705DBF37B7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577C118A4F09
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD72DFA27;
	Mon, 20 Oct 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NmOLzQam"
X-Original-To: linux-pm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA0240611;
	Mon, 20 Oct 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993070; cv=fail; b=WYrVaRe4HRc2HefgFQ2vitWMnPcrq/54n/jKYpTnQQPGEWZcbSgB0UHMmlALw++MYZN/TAFxWDI2zpp37+Oac1UgeZ7V6slZvjo0PiL1T3gAuQ2eABQ64yUNiLHwW6S67bdgOc/CkJqDoW8V3MZh/tP+r66RJCRRNTL5urAjTGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993070; c=relaxed/simple;
	bh=qE9k+VS9SPzCMRwvz2SFmZBXZn6fPMXghelCcIk5Txc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=musYMc1U3i7DrUJ6vG3PIyIcw3W8HU/gxbJPHqqDbeZRNVmEVxC9EbEPnuIqgUitq8yIcPlyCjoPCXM8h6cBQpJKPHMQhThA13QAIpaoFe3pWm9SO64RbcOj2FUl6ScUOKLHb/evFDfpvK+gaXgYYaMIqC+3PQilbdlEE6YiEnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NmOLzQam; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0tOTVRbhCrsYqC7VUHSCBX3VXHFRqxat8kyiWzaLqXW0c58YjEzF6/zdBTlUhrly/E+vJwjs9IVlA7bktPnFKQclOpDPrEzPkmiWpYy9KDBR3t0RMB2POCqoIGqEAosEbds1EJS04QLksNtuRlNyL7lGuXNXatJ+CfdMjmo4yOAZxWkKStmkEoz6XHDEK9WChoqSNKA58nt+z82Eit3u0smtognnyraKG6zvHA6OL9uisJBEcKGk+8Xa+ULzdWBbVoZXIHRmi6lXdQZ93PnJJ6yy48tTAiNYgO5buLU6qtkbdRxfi19EJGo+jGWtWWJusDjBgTrmRlwbavZO6D5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3gghQ4MChrCqP/MLAEzO2lpO5E8T82mA8G2gdh0WNo=;
 b=ttoXPBDgtEz1ycu0+vP7U926vpEj7X0JnD1DPUEUUbzB/a1jxdL7Nv5O9bBnXNdGOGrHia6lVsRvd2c/2wRcLyS54564MP5qIvQiLcLTwQmAZE4XaYhgkzOi8QHkf9SlMsn7MHmDf1EO43lSKzvpbYwNkC+MtbGbu4OoMUngMK872nTPa8EoafmvCqxLhECy34UKTmE+rV3ZSMcIzqAIllzJ+KsaYvvXkAiZFEkUZD2G+u6bu8LORJCf9f8PwFS/1V6Fvhr9Ds5dG+UIdDgEBHMWWm2T+hrEkzcjK9NoACCcF2fzOhTnWldMp4dQ/KxVSk+Zgf113iSfzbNRv6e3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3gghQ4MChrCqP/MLAEzO2lpO5E8T82mA8G2gdh0WNo=;
 b=NmOLzQamUuZNZHsvLOQPjqJTw+7C5ADafk7wXckRI53e+DqxN2+wDokSbkMShlgbPMh8O7HFovBJI7KTIrDJNRWAQ7L1jmwkmFrn5SVhczHJBmuJHJCQpnDOH5VI31ReWGGkaz5mTP62h/8kQw7ciUl23oR/hT0zp5ho6V/57fLJw75n+azpQnGEcBFauVWDG7Q/qe2krplcpra1Eo7oVtmPD4l7XJbdMdcLMuL6ZMqwqDEQ30fKyEi8eENSCza4R/TqMwDyhMlEaIhzzrx+OdWE/AscAC7jKL/NXVbXhUaOUaTy6jbVCoXGEFlzm0f/2W8vMjLtSeAUHVNNUkLNVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 20:44:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 20:44:22 +0000
Date: Mon, 20 Oct 2025 16:44:21 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU
 counter
Message-ID: <20251020204421.GA197647@joelbox2>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-2-lyude@redhat.com>
 <20251014104839.GN4067720@noisy.programming.kicks-ass.net>
 <4a237ec0-05ae-439b-a1cb-6b7f451c0d7e@nvidia.com>
 <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014194349.GC1206438@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd026b1-0be7-42e6-fdcc-08de101972f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LpX8CQIIE8fGZYF8JrP3Aa10AGeQFfp63Fwwluz6OZd7HJJrZG5+wDROwA6w?=
 =?us-ascii?Q?8Z1cFQjomtiVzpLAdUR+VDK16o1gCTb8VxHQZ8DBcw+D+Kd5T5ATYq7uZHGo?=
 =?us-ascii?Q?KB0iYcM1AKpYz5opi95m+VhNkiYfY5hgRDUyUdlAZlEK+KiuK2PGTB4RqDr2?=
 =?us-ascii?Q?OQCek5C8Vvw9FS3DThNRX9m5sjZKAMGXVQpbvwX+o5WJkSqJnRCfhojOcg8n?=
 =?us-ascii?Q?QSGHnFY/vPjJBOFD03szMouZ2qHocbY8XBv7u8y7cZh3m6AbxvQE3tqPMXTY?=
 =?us-ascii?Q?wLXlCmw93vKWitMLE59HiSsRbdZylymTRUWPwtv0Cy44DM3WhzFtiJD26bZt?=
 =?us-ascii?Q?x5PwJMgHg+S8vEC+Hw8DaZ1tA58F55C9WrlOI6mKdK1h4chLglKjz7DKRM4+?=
 =?us-ascii?Q?AlUfOVKTctKDxZQ99pmeoGnCHQ8pISTfSuSOumS6Uuha55giooRB/p6YLFFF?=
 =?us-ascii?Q?EpAlVyX38AVpXM9k6i81y/l2LLKFCOUmzbJEGokOqbkl++fwmO11LR1cdV/W?=
 =?us-ascii?Q?UC87WOuW+THDOIJSxQt1v6TMM7yYasy5xgHPIqqIBnQCRaJO6/36/o9+lkVo?=
 =?us-ascii?Q?db/UMcgFZZ+oV6w7D3pQzqPFk/yvU7TZ7fVUsAitaMXNiMG9Qu1yFtpCNY3x?=
 =?us-ascii?Q?o5kDT6Ez1y0DEfnkJ0UmGCHVXoEgTyz/SLQ+sIN7VfCb87+3SzEEWELAHoMC?=
 =?us-ascii?Q?WktxlFjOPq8lNNIEUIVuHuGAIdRzhaBmjQ9rvH+jPGm+tYT7q31XImMhLvnq?=
 =?us-ascii?Q?4pA4l4BEHJZXmm5SF2xhGuaux+QpIoYhjrPOSs9/vzR9gl70N3dpwhmoSijc?=
 =?us-ascii?Q?Wd+hQ+Q0cqQ/gzhBYxfAmE2bhtUurQFnw3yRoem6mh+GAf80gC/uXh10Vf+m?=
 =?us-ascii?Q?9b2KD5Ry4P/q4ZbktACtcHeGbYr4mEe9chLZRNUSAGnFaP4bmO+jZBx3dA1w?=
 =?us-ascii?Q?8EEGfxoq9H16tT1sNF35ZA+PijmJ/B5tuy9RkaVKCYKKQJGUvXIVMY8QLbzt?=
 =?us-ascii?Q?cpkbLLPhqcdaZWTI1MJrgPB8ZMFAdom7rv3/u4vDiGezfuF6Vyip6s6Y5nB6?=
 =?us-ascii?Q?6o8dwUqzfOEHT2iaAI7Xpxfs2C7bL8MdeFMq4TWm7zeqxOptbSYtmw8E/81E?=
 =?us-ascii?Q?+2TBLQ3UISS+XXURr3VLk6VWXk9e/ef/e36Mh9HZVUyAubS4+lH+b6rEUohV?=
 =?us-ascii?Q?3WtXYwZD/AJJsNSDvyqBHTLhnf7et1xj5cVaoyTYU6Ex94GWe+kTho25ZoN3?=
 =?us-ascii?Q?eyDIkP63Lxk998zuy6jPBQzZD9YhIWeSvbdgmYwILlOrmTCkS1opAA3Xq4Ta?=
 =?us-ascii?Q?Ro8j12VHXFEctXPbJQJ/BsLylavMqmmRQg1sAk3zbXVN7S9hBX69vZSp5/DK?=
 =?us-ascii?Q?d7CftfPlEqk0LWKgm2ot3DdyzWQC2pGiqJ+sLJiDpYoDf1H6ugwtzEHIpIjH?=
 =?us-ascii?Q?5VuJiTDjhVvk78b88UQk+5VSmLNuF2yy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ak0Hv85X/N5sN0qdf+lc2yw4C5wJd+GnPfYAusi5mm6zJtM1pRMoNNR44iC/?=
 =?us-ascii?Q?YZZ7iPdoMbJl3myqzcuIiIzBcJi4SrCU8E5yMNO/G+LmPLmsv+9qCxDNn+68?=
 =?us-ascii?Q?TaGYUOVAU2re5WB81n7KsXspE93lelowylvvTKfjJv4P5sbvHLemu2lGV9rP?=
 =?us-ascii?Q?Qje80HHxV4k3mY3PDKu2ml0Ff2i7NUESJHrYvqVsWFZLQKUZtduwY8+/acgp?=
 =?us-ascii?Q?MqTrNs8753bn+kxMuz72qILnlU5nPce3J66clsK0fHbpcGbfrlD2hfHR+sqr?=
 =?us-ascii?Q?M9ybCiPkScea+YR3izXDbFKFGGLnuhfyU3gJjfOldi07Xo8xS5rcu670VCcE?=
 =?us-ascii?Q?NL1sC8TsvRoflFzNPVvOmxWqCEanFkG8EWkHtynzG0BVxLBghvPNRuf3UUXK?=
 =?us-ascii?Q?2M8djSvkjQlYUVo3hTD8XP4qUIbKVLZZyTY9SEAmZx98Z3LNHlgPiz/etica?=
 =?us-ascii?Q?ZOvW7ok8wURdzJC0pnxaza9S2nGBmzOfrRGKvP/ZjpQ/5MOH/ms/JceO+ZnT?=
 =?us-ascii?Q?zgk8qGd8FSVeQr2IBoxGunQma1U3LxupT+c5lJsWChZQJPSUAdP8ug4kDFK1?=
 =?us-ascii?Q?9zNb2ZFpIUTQ2ImCpA8778mzW2k91wdTd1lE5cWxwDnUqOWY4vkxVDPDSlur?=
 =?us-ascii?Q?PyrgbcokJRELMgAfftnB9dW1dybzBYQkhq53/tpJgoYxsHXIrN34HrOKS94P?=
 =?us-ascii?Q?ylN0UMuiPexkn9jgHracU/nWpZ12NucZnANeXlU7H4ekjkJ5GCR3tvp9GgO0?=
 =?us-ascii?Q?8sItyzpXGoP0gz3Rzq/mZIh0JXJfZ9JB9ErVV2n7IvGhG6bMdu6JLFhBftq4?=
 =?us-ascii?Q?OSkFXkzHIrxlAI8m8budkWyb/a12P351Cnzj9qVVmav+K5JYkc85YTSsNsgS?=
 =?us-ascii?Q?HKSY1x5vmAZX6SPf6tNrFqbS3FGERZe22687KcpSin0Aq15R3iMWsA3ZIt9Y?=
 =?us-ascii?Q?voAWmOThmuQRWwL2o/v3/go1eicxozUh38I8+HHD45MTHc7DQVDg/fPSk9C9?=
 =?us-ascii?Q?+vg/Xfu70O3+1l+vGDNd+iAgrNDaucgNbPIo6p7G1gzHnFquaLeBPC/mo3US?=
 =?us-ascii?Q?9khP6WQO7XQ8rawmUIFIRHT0cnI27QjVw9dOprNWv/0BKRdaq3uErhmv3yzg?=
 =?us-ascii?Q?0Wei4YF6DGMrGflOY3Pl2aE4r7KCreEWgnIYMAl88S1oKw8P22L/619kv2bZ?=
 =?us-ascii?Q?Bs6jPjyuTt8Yo4f0RjzMkzhesk6ZjN3GMB6GnA3rE9qwOKPhareca8vxfjka?=
 =?us-ascii?Q?CQ5V/KQepHicv0BUK3EnHdL23hGhkn5+os9WAOVX7Y/IxLyXfJyWQmizaE1i?=
 =?us-ascii?Q?/TTUsuFICHIJ+uFmjYyvonNoqnnqXpsKcGYQbSxbeILUdU4h+mkmxe7OrmSt?=
 =?us-ascii?Q?29b52CFcQn0wspINnfTdz1oji8jE1yjYGRZfyOvI4B7BuwOG9d8LBWi4rH3m?=
 =?us-ascii?Q?q7UMyE+yCqrIeC1G1OC09U+RvpTesE65hqoLxF0dFR/f5HiyPn4AkEHsl4DW?=
 =?us-ascii?Q?rB2CHVTurdR0vX8eB8qSoUzZVBtnj0c2mvFyuaSOgQW3AEZampMU9sAvJg2o?=
 =?us-ascii?Q?Chjzlr2P0iccWTET75MQeG0NG7fkKMI1CkTRWYTE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd026b1-0be7-42e6-fdcc-08de101972f7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:44:22.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsrt2pYL05wRv/6D8ZQHcN3zT9/47jyaVMSt2SyWUc1bSqAVvXn4NfnOxWKK+jejb9lXnDtKUITL5WgnhpNc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671

On Tue, Oct 14, 2025 at 09:43:49PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 01:55:47PM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 10/14/2025 6:48 AM, Peter Zijlstra wrote:
> > > On Mon, Oct 13, 2025 at 11:48:03AM -0400, Lyude Paul wrote:
> > > 
> > >>  #define __nmi_enter()						\
> > >>  	do {							\
> > >>  		lockdep_off();					\
> > >>  		arch_nmi_enter();				\
> > >> -		BUG_ON(in_nmi() == NMI_MASK);			\
> > >> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> > >> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
> > >> +		__this_cpu_inc(nmi_nesting);			\
> > > 
> > > An NMI that nests from here..
> > > 
> > >> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> > >> +		if (__this_cpu_read(nmi_nesting) == 1)		\
> > > 
> > > .. until here, will see nmi_nesting > 1 and not set NMI_OFFSET.
> > 
> > This is true, I can cure it by setting NMI_OFFSET unconditionally when
> > nmi_nesting >= 1. Then the outer most NMI will then reset it. I think that will
> > work. Do you see any other issue with doing so?
> 
> unconditionally set NMI_FFSET, regardless of nmi_nesting
> and only clear on exit when nmi_nesting == 0.
> 
> Notably, when you use u64 __preempt_count, you can limit this to 32bit
> only. The NMI nesting can happen in the single instruction window
> between ADD and ADC. But on 64bit you don't have that gap and so don't
> need to fix it.

Wouldn't this break __preempt_count_dec_and_test though? If we make it
64-bit, then there is no longer a way on x86 32-bit to decrement the preempt
count and zero-test the entire word in the same instruction (decl). And I
feel there might be other races as well. Also this means that every
preempt_disable/enable will be heavier on 32-bit.

If we take the approach of this patch, but move the per-cpu counter to cache
hot area, what are the other drawbacks other than few more instructions on
NMI entry/exit? It feels simpler and less risky. But let me know if I missed
something.

thanks,

 - Joel


