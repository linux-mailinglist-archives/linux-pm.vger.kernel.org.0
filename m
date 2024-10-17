Return-Path: <linux-pm+bounces-15843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DD9A1CFE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFD41C202F9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DB1CDFB8;
	Thu, 17 Oct 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCa8o7M5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE5199944;
	Thu, 17 Oct 2024 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153193; cv=none; b=tEUcq9xjF876EcGjMsbX9eP22zYBlhKqWHAKicYL1ghXt8qV3dXLEAnNpme/hgqkUZBX/1fnX8I8HOSJE06aFJ0CCR1/ZhSX2JYLS/a2xSQeONfibmx2xbRDtyTww5D8nShb2kf0ORd+28txbznG+FpEEnlOlKVwvpggLiRPO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153193; c=relaxed/simple;
	bh=GInnBn+NilFxTVvAPhppcfdBhV7v8zyNPgMLAjfhsQo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJN/b1RqvqsHCBtaTNO7eoGamQwV6pecs8LgoMOwRB5/WzXdXXOvABdhE9JK29Sd6ycjqN6raUkqmI40ai6DAd7jQrcZvVZggDa+BTNT72X0G1qq5ED1/p/TLlOTMNgCgGgqh9GJs8dBvy+wvi+ic4+nYs28QwHo+xDfZR817+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCa8o7M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C0C4CEC3;
	Thu, 17 Oct 2024 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729153192;
	bh=GInnBn+NilFxTVvAPhppcfdBhV7v8zyNPgMLAjfhsQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCa8o7M5nHa+FK/+KHfno1zUrcmbPZJE0vROcSMmvepPJnZpDXPlyoDNxM4wN2xkL
	 gQZjPMmC3otKdK68P+T/C11hStPc9YiF5mo6vr2THaENJ/c1+XHM2NSD8Tc4Rc1yuq
	 D8GFv69HBeFOw7O5CK5QLFJh1fX6wyS5Bk4LBBoEsxJe4nmmavI7zbh6MbFZNtteip
	 kV/ZKgKaPlkRsl8zuRgclmOGg1qVrvSCaui3FXpBemsXzz9NwZPFXrxj/8kv8Ac/yT
	 QicNm+C1wv59fIrZYpQzMEQCe8JlSb5mGvPHVY+XdrqndiXvWYOFoMtu6Yb5tFETJI
	 MUniEkXjrdmmA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1t1LjZ-004M2D-TO;
	Thu, 17 Oct 2024 09:19:50 +0100
Date: Thu, 17 Oct 2024 09:19:48 +0100
Message-ID: <86sesv3zvf.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	pbonzini@redhat.com,
	wanpengli@tencent.com,
	vkuznets@redhat.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	peterz@infradead.org,
	arnd@arndb.de,
	lenb@kernel.org,
	mark.rutland@arm.com,
	harisokn@amazon.com,
	mtosatti@redhat.com,
	sudeep.holla@arm.com,
	cl@gentwo.org,
	misono.tomohiro@fujitsu.com,
	maobibo@loongson.cn,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v8 00/11] Enable haltpoll on arm64
In-Reply-To: <87plnzpvb6.fsf@oracle.com>
References: <20240925232425.2763385-1-ankur.a.arora@oracle.com>
	<8634kx5yqd.wl-maz@kernel.org>
	<87plnzpvb6.fsf@oracle.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ankur.a.arora@oracle.com, linux-pm@vger.kernel.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de, lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com, sudeep.holla@arm.com, cl@gentwo.org, misono.tomohiro@fujitsu.com, maobibo@loongson.cn, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 16 Oct 2024 22:55:09 +0100,
Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
> 
> Marc Zyngier <maz@kernel.org> writes:
> 
> > On Thu, 26 Sep 2024 00:24:14 +0100,
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >>
> >> This patchset enables the cpuidle-haltpoll driver and its namesake
> >> governor on arm64. This is specifically interesting for KVM guests by
> >> reducing IPC latencies.
> >>
> >> Comparing idle switching latencies on an arm64 KVM guest with
> >> perf bench sched pipe:
> >>
> >>                                      usecs/op       %stdev
> >>
> >>   no haltpoll (baseline)               13.48       +-  5.19%
> >>   with haltpoll                         6.84       +- 22.07%
> >>
> >>
> >> No change in performance for a similar test on x86:
> >>
> >>                                      usecs/op        %stdev
> >>
> >>   haltpoll w/ cpu_relax() (baseline)     4.75      +-  1.76%
> >>   haltpoll w/ smp_cond_load_relaxed()    4.78      +-  2.31%
> >>
> >> Both sets of tests were on otherwise idle systems with guest VCPUs
> >> pinned to specific PCPUs. One reason for the higher stdev on arm64
> >> is that trapping of the WFE instruction by the host KVM is contingent
> >> on the number of tasks on the runqueue.
> >
> > Sorry to state the obvious, but if that's the variable trapping of
> > WFI/WFE is the cause of your trouble, why don't you simply turn it off
> > (see 0b5afe05377d for the details)? Given that you pin your vcpus to
> > physical CPUs, there is no need for any trapping.
> 
> Good point. Thanks. That should help reduce the guessing games around
> the variance in these tests.

I'd be interested to find out whether there is still some benefit in
this series once you disable the WFx trapping heuristics.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

