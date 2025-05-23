Return-Path: <linux-pm+bounces-27617-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F1AC2B33
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 23:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58051BA5752
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216C1632D7;
	Fri, 23 May 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qochiSPL"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C926AFB;
	Fri, 23 May 2025 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748034151; cv=fail; b=ViPwoLD2NZowOGFYwS8dbj+AaVZMtGgMryudUP6vN654GndbYNNTWZ1xmS1bOLGenPmdjQwJZwPBAAv/V0Z+idSNqTNIeZtNsYMHcRI2IvekjPANLN5xOW+iz9RyyXhIO/iOiF88VckU38LLLHRsYNkra3mImbthQIRne/xjduA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748034151; c=relaxed/simple;
	bh=VugymrGG45VpWZ+K4KSGJ1as6iE9VDIra+PkRkvpT+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dSVgUvtyXI47OlmkU+Ol8eGBJFaEdlIT2ZczzkdkLjvt6pwaALz0Uff1Oi74uW9UPwtmzYeQEN17pd7N88mgbd9HtpSOI7PLov8UHYJJDDlI0Oxe0V6Inz6ZCNDVrn0cBjamRurC27J9V9rFqMTY5HhAN8MDTzLaASfryBshFqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qochiSPL; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNR0nLIT8QtwZN1EnDSz3nojGQFYirBDS7MI1ore3KO+yvRd3DRfMmHsiVacz3RPshkFri2QBSkASAXU/p1SZNJ5PXl86ppxyVcyQuK6bzE5lp/sUNZ1dF5egnn+FJml24lAOQ94y6ibawlnKVyfds15y+ybtGtEPvPltxi4OcFGTRm7oAMYGCkMBpSvYmlciaJk0uQ5ZxopGZw9p4IMUPtwdGQfjZ0OJCoMXbuvKpyp883RXkXoPPzFUHWjq7XA8k97CL53ULSisnut7OQdkhoWJHAi7RbidgEbIyqrMiumU+DJKdIoZGUDqKBjhATAM5mBCpwA/f3/W9h4+phbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybkRY00lUL2owVEbt0CVYRbV1mDe+pYHZiDdK/bdsX4=;
 b=xmZezwQ/wzN1G+IFwLeEfcxrkDh4IqTbW4c74jZa9XsRZTTqcQVEf0QGwKQg6lNVksFT2orq69g4MUs0Ds2VaNaW1xkuJedVUMcvfWibHHtZ49Eu3YypPXlPAe2mIZPClaC7EEnpHJgRiZ6CgXumv0tAHVWLkv2AESw5byCnizGtV4QG+7ZNccOroOAFt4vij9y36rs41hGU8Z4GDJRR3a8ZHXPQLFK+rRXR0s8fZS/aYla4mjVB41lZ0W+Xb6tM5E3yJHcw//2YkWeiyj0NwF2+zx8eAljc1vzC+mS4fKheNKOCTBB1FRm/KCRDfe6N4mMFa1+AoH70pGmNcRyiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybkRY00lUL2owVEbt0CVYRbV1mDe+pYHZiDdK/bdsX4=;
 b=qochiSPLBJtA4MWhK9XKktMwiETQhgWb31B8IEUnNZjdbPIRVgOFa9qeujed8nOiiowuG5Zn2z7tjMWJYoZpenX4Kq23WL27AF6u9hmwubr7DuELdYpmB6f/S0RyAK0m0fuAZz/o+QRw9q9nYMdQEmh7P87q9KSHQPWu9lL9yYoFyXPuGQkvuADpuk19JMx03tBddXp6SjFa+4flOOylrTFx3t37attDOfVxRdG4pjU9WFU+ZE5aZdmU2sFa4y6WTrG20OwTZAIL0USNtWNcZPk5gQMkkudaPGMHrHtzgeTsMxezm0OXKIuqGlQmC/Wcz8W1vntmGmROOlCc4P6Q/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 21:02:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 21:02:26 +0000
Date: Fri, 23 May 2025 23:02:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, hannes@cmpxchg.org, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched: Make clangd usable
Message-ID: <aDDiWHUP8bKirsmo@gpd3>
References: <20250523164348.GN39944@noisy.programming.kicks-ass.net>
 <aDCmyEGIpPv6ggF1@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCmyEGIpPv6ggF1@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: f680728a-8c55-4598-fd5a-08dd9a3d1f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txumvCA5f6OOT7IMDqC/Xz49XKT940nlf9N0O71Hp+b6LvgSWsOMcsD0wLsO?=
 =?us-ascii?Q?oJxhm0LcP6aB3NEvBr8qkbN3qc+XxAIVdd8gXsZ4P3yXDqJruliqqfRfv/dh?=
 =?us-ascii?Q?NsehnWgGtmbIrxny2q4alVkAaRy4bzSjdlkZNcITF18e5/I9R9bDwcMUDeiT?=
 =?us-ascii?Q?dfoCNEq73drpcioF5ECQ3NwAHNJQ/OFUZGhGjalQACUG9KidHXDYqQdPBa07?=
 =?us-ascii?Q?SkIM723G7ABdYGoznif9qDT53rPIMfRl4Ej467vb/y3sx6ZVc+vulbTVDvpO?=
 =?us-ascii?Q?f6uLyaCH2JugKl29htvKbPUmkeeHyLaidiPJBY02sfkoh5GefTEoGbObUncO?=
 =?us-ascii?Q?kX9KXFXVDtRGflSjyqaBy3+YIti/he518RaQ42EPfH3o22H3tqCC4SogPZ9X?=
 =?us-ascii?Q?OcOOsfFOjvh5KApZXB8ctmVGwzPOcoRvSjPnxkemPRW8VbptB89Fn3g0S+eN?=
 =?us-ascii?Q?gaBovdopKIsKrCXEKJzBuj5bdpanCxPutce9fePH96lpDhRLXmXypR9BSCIR?=
 =?us-ascii?Q?3axParyXu1dx8SCWnnmnN0eqL5rBzQbrKwsb8W/29jMtXgYLuppJkDPdouQ/?=
 =?us-ascii?Q?mC4lgQ45ida4FWvDYjmofn4GS4hyjAz81cbUvaQmZw48OrpyWak/oCPOcmvQ?=
 =?us-ascii?Q?Heb4JrHE761+5lCe2ZaOobiixvZzxH2acMNm681zuMIfM3GSYeYF6MsWmJNW?=
 =?us-ascii?Q?Hvak4fGvirsZvYgYQO14PLfls8taDkZ5jw29qg1GZHL9EcTJxR4CcR11mXXJ?=
 =?us-ascii?Q?QTcWfYHTtEIwM9u1qScgNLZ8A2RMKe0OlDYGvQl2xENMG9mAbPSoCKZX2utn?=
 =?us-ascii?Q?MtAz/RIy3TKlNE1ykrT1FxKlx7AwMwc52SRQd4ovpjO05JACbcpbA08omV7E?=
 =?us-ascii?Q?QRYEyGUwl83uzz7leEt/8p8aIfqU8y0/WQzGYFmaQ9mPQCxq0GQZ3fJXIS14?=
 =?us-ascii?Q?aZSgks2BuxIaejRr7Rww0jfcj+cbn57lVMTmtjIISf0qd7QZHmZUFUGtp+CM?=
 =?us-ascii?Q?+hBGIwaDEbeUWq3+U0c73cJlWCYlGzorv34vzIw/GKfcYZXtZk+rOgfnstpk?=
 =?us-ascii?Q?GCdliFtRVCd5W0idmYup0IXOcLej2MUc+AGLl7uRVsd535xilw+n7qFaROxE?=
 =?us-ascii?Q?zIUN6oqPu2gO0HlYMkt9OQxgR5XseGQ/rKfJso5VrwlfBwv0wWbgNaCyqQee?=
 =?us-ascii?Q?OqoKBeZ5PZt2XR19fGfYtkqrCkuJDT0X+EVHQbKjhySX6R9pf0Hwplevk7qG?=
 =?us-ascii?Q?56OfM3fIyt8HKLgDX489Q4Y4K/KvZbEPMsP4OAlN4sYu/sgTxuCaWFcn38yV?=
 =?us-ascii?Q?qWZTFK01hMWxuZxW2IWnY3d0owxmnbYrl4vZLTYmQw/iVzJdQBQYWL+ABtcW?=
 =?us-ascii?Q?mmMDUVFOlh/ezJB9ZjCw7JWANsvrtpr704ddLP4DowqifGVuBT6XZpB/qVR5?=
 =?us-ascii?Q?aKMVKz9ZXWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BdkkjFM1ccicO3pzDc3t7R3boQ5NW8ssqSQPyWegoUh1NzwR7uiAWKmHPuGU?=
 =?us-ascii?Q?OKagSHwcrZbZjQbIVLrEFegsLR5tRZrPmMawutEjSI2LSaiYiXinAqVKIfn7?=
 =?us-ascii?Q?ctynZmpOZ9VP+ttOlJMnvao3qQYINallg2TG83nUxm+4fcIz1OUO0R1PKhez?=
 =?us-ascii?Q?qYw6mtIiViHdQ8uDNncqRbKIiP/KFW78qELPubYPye+omnyaBj9gQUNqGH27?=
 =?us-ascii?Q?hAN9PTseWuw7zZAklpnpl+cj9J5Tyj/UAQSGtArLwvPoqdnqJhlEo1zR1Gec?=
 =?us-ascii?Q?lx8lIIo2Ib/kO5lzKhuu/FR7MfjKX5CWTRaHe9AJ1OMRQ+Ftgi23PT8ysx9j?=
 =?us-ascii?Q?BT76VxuyUPPqZDqQOZlTjFKYPKOkgI06OngKZjDNOdMszvpfr3qg3C7YbO68?=
 =?us-ascii?Q?tScAzVDWn9dSYcN0hQnO+XcNHCMx6H3yIZ20yFagSuk6hInZLzS145k+pKC4?=
 =?us-ascii?Q?1WoF8WN5OfLqrVRnn9iIOW6ihj1S0QWvKRqkdEpxWhREMYMHqupaNIAleCEA?=
 =?us-ascii?Q?Of0+Zund8E75xJGTzhfYU6A1tcvX+6P1rxjpaMF5MNZBSfMk9OFnY+hqTVGR?=
 =?us-ascii?Q?JBTGlDC808TfwkufTSGKvlpSdAqvmM4CklkdQJR4wZ65cm56Q2ugbl/RA1b8?=
 =?us-ascii?Q?L5WlwJUQs1zrNH9bedKQZ7VIxY9NOhxzTjVkVNqgVt6nTdbtSE/w7hxBkZIO?=
 =?us-ascii?Q?UlJOJoWbUgPV0K7DHKsDSoTUnKCkRlUDwO9Rk/9DiFTlI3a05YooYUpBzTQF?=
 =?us-ascii?Q?WxH4STXL+Db7NC0g+rCyh1jkf34p2xVvMx3NwCse0C8+dfpnxO8fnXXE7PxP?=
 =?us-ascii?Q?WqlMvcKKBqcyBg3pLUYNIv1gU+rpDkXzHk7BLS9/BkxjVeCfSXNYmONc6oXu?=
 =?us-ascii?Q?WG2oiwQ5Zkb4mmoKfJv2/9aY9TAdIFml74tJu2nLW+1e0H89LXXS0CUTLDwG?=
 =?us-ascii?Q?SAKlbSrhzM329r0i1dFSMQ1DektMMM6ihGr1h8LNVAZIZhiMD2x7+g6fByrb?=
 =?us-ascii?Q?f/xiIzP5GOLeqkM1SO7wCd8+0/PakeIT/B74+PFY51OcHHHf8PaORBew+Mzg?=
 =?us-ascii?Q?QpfO8ootWxIpq95BHodF3ayqVwSCxFlntjpNryUeLx/yW9+5gjD/5N5CSDFi?=
 =?us-ascii?Q?1J9oTT/OGNNFyq5B1Oo/cpDnU801g9ngRGexcgSvxQCPXYa4EDEQa6cjDHSg?=
 =?us-ascii?Q?to2+E4MfOBlRbeAfFksSh0R1OBB7D/fZkJAMG9gdIS0SLaoYFrMgoN4o/EMA?=
 =?us-ascii?Q?kFjQZqtc+6zuON7v0PFeGqpg+qFbxBTUMdEaNYJpuN4dZPGC3WgDxizbOxqj?=
 =?us-ascii?Q?7hgLboXNZWdKy+g+81ijP1mUFOnpA1fsuKNTGDPHv4PsFZjsm0hpFWB9xBno?=
 =?us-ascii?Q?cn3vUb3BFnyAYxcqL7lkiBiBsQqJbxE6hTiqOXRvHDJzN+0n7pzi5bDO2+QL?=
 =?us-ascii?Q?yoJP3CzsyAbxqb4IDJENskaU9WrAX2XSv/hYxGIY8GDfsEtlDq4PIjbTM2j9?=
 =?us-ascii?Q?6kkyPPc1MIn7B1YbC9ZcLybcL+PttnBdd6oOTpJx8mvBKpOr8VytdEGVnPzm?=
 =?us-ascii?Q?oxKyx6/uj+OP8XiRnDIPbSH2e+GJuGhncHDyDFdm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f680728a-8c55-4598-fd5a-08dd9a3d1f65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:02:26.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGBNEpDPXmPEMaWVBN80mnUIO/gSHxwuLJxbR3QLYJEnQHYj/sVEMN+PBEl1z896RlDY3NZx+0x/MDPluOgmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013

On Fri, May 23, 2025 at 06:48:08AM -1000, Tejun Heo wrote:
> On Fri, May 23, 2025 at 06:43:48PM +0200, Peter Zijlstra wrote:
> > 
> > Due to the weird Makefile setup of sched the various files do not
> > compile as stand alone units. The new generation of editors are trying
> > to do just this -- mostly to offer fancy things like completions but
> > also better syntax highlighting and code navigation.
> > 
> > Specifically, I've been playing around with neovim and clangd.
> > 
> > Setting up clangd on the kernel source is a giant pain in the arse
> > (this really should be improved), but once you do manage, you run into
> > dumb stuff like the above.
> > 
> > Fix up the scheduler files to at least pretend to work.
> > 
> > (this excludes ext because those include games are worse than average)
> 
> Yeah, ext needs to move the stuff that's shared between ext.c and ext_idle.c
> into ext.h. cc: Andrea.

Ack, will take a look at ext_idle.c and do some cleanups.

Thanks,
-Andrea

