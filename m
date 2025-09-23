Return-Path: <linux-pm+bounces-35256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DAB97685
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 21:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D016F458
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032B307AEB;
	Tue, 23 Sep 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SHkOlcHK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C2303A2A;
	Tue, 23 Sep 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758656871; cv=none; b=kWWv8AiH02tXtQ2lRvonhdB1LU/N5LrJa4fritPQP5Wda2H5y7Ag3u6OFUhCXZn1XkOiXgdHucNwrpLcUPLJYX+LYAE9aTtK8cd4bv4WdkG8/LuKsItVkl/FXqYyw7oTIIo1koRBlmN+ak49z/9XzPA8XfBxQVrt90U0Md9tPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758656871; c=relaxed/simple;
	bh=n25NwdGa22F7UFpYkFHB1MY/cvLwtVXI0a+A/O85MVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOKiEe4AtDRAUnLxsDuWgZyJpHbp88GHGvyokamtxPWru2dr+3gQvmbt8+manD9lPapAQAFqhKgyJzFV90hai11zZPgdrHGRwJS8YikDA+BScKyy9kjjaOPcwnDS5ad8AJQe+XurRQsPJNbUnLZUu34m/5qdRljTFHTaMe3wfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SHkOlcHK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:f59a:9e88:e782:b040] ([IPv6:2601:646:8081:9484:f59a:9e88:e782:b040])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 58NJkhJF1748090
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 23 Sep 2025 12:46:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 58NJkhJF1748090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025092201; t=1758656806;
	bh=NC/FMCp+mA6hZEgwAuk7JMXpuKxDpyNUldF6UUM33pQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SHkOlcHKUpeysLdqJMhSAMi2uQqOOKdjgeHt3faHcgPXJq++/gftOVvOyiNWygfqH
	 mCNqmK4bz0klnhp7YPRK1eq/FQRLjdMQSKLMB/mqn+iE84VILQxB53wklZylO+MG5H
	 7aEebR1QRZIW49ql+5opnL3l8MV8b/G8c3ADQruawUAMnQujQ7pqROYLe/GIjhiXJU
	 qgIc8svLtXnIjGybooftmsemHNAATHwk7mkElgxq/JyV60ganMI209CwsM3bX/SpJ0
	 p5gEc5IK4elWK4dm4KhTRI+/KWvhaPMM971aWPC/UTbApUf2+sEe7zLej3SIDiZ5Yr
	 NT54jFUY3zaog==
Message-ID: <f4041bf7-0984-4aff-887f-f77e58525e3a@zytor.com>
Date: Tue, 23 Sep 2025 12:46:38 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] parker: PARtitioned KERnel
To: Fam Zheng <fam.zheng@bytedance.com>, linux-kernel@vger.kernel.org
Cc: Lukasz Luba <lukasz.luba@arm.com>, linyongting@bytedance.com,
        songmuchun@bytedance.com, satish.kumar@bytedance.com,
        Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        yuanzhu@bytedance.com, Ingo Molnar <mingo@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, fam@euphon.net, x86@kernel.org,
        liangma@bytedance.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, guojinhui.liam@bytedance.com,
        linux-pm@vger.kernel.org, Thom Hughes <thom.hughes@bytedance.com>
References: <20250923153146.365015-1-fam.zheng@bytedance.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20250923153146.365015-1-fam.zheng@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-23 08:31, Fam Zheng wrote:
> 
> Parker is a proposed feature in linux for multiple linux kernels to run
> simultaneously on single machine, without traditional kvm virtualisation. This
> is achieved by partitioning the CPU cores, memory and devices for
> partitioning-aware Linux kernel.
> 

This seems to be much better handled by a lightweight hypervisor. There is a
reason why ALL IBM mainframes have a low-level hard-partitioning hypervisor.

Typically that hypervisor will expose a static, very low level view of the
machine (e.g. no scheduling - VCPUs are mapped 1:1 to physical CPUs; no I/O
sharing or emulation, except possibly as needed to boot, and so on.)

Because the functionality of the hypervisor is so limited, the overhead is
minimal, but it CAN (but doesn't HAVE TO) provide memory and I/O isolation
between partitions.

	-hpa


