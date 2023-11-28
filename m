Return-Path: <linux-pm+bounces-423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B77FCAA7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 00:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBFF1F20F97
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F705732F;
	Tue, 28 Nov 2023 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="DuiXrfui"
X-Original-To: linux-pm@vger.kernel.org
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B0F197;
	Tue, 28 Nov 2023 15:17:48 -0800 (PST)
Received: from tutadb.w10.tutanota.de (unknown [192.168.1.10])
	by w4.tutanota.de (Postfix) with ESMTP id 3B8311060171;
	Tue, 28 Nov 2023 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701213467;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=JqVKyMAMt9Bj6vMHPBXGDNf4LP6ToGp593DuEmyVmVg=;
	b=DuiXrfuiZatvQK8SRbBUX5h4qnitFshGTibmQ7My96Ji3pbzkj31MwcfRW5yozFF
	uDBBJIz0cWqEOVfxDIFPzxzzV0xDs4Nc2eqG0gLeyQrjYwO05NKHmzPnzV2QFHTM+rh
	cKQgd8g3wxhtyDo7abslOqpRazaosNLz75lyydlP65iGOfgWigxMNlJLBN9GAGsUUTv
	ZcRbRkCk6tL36cjxU9Y2BFeXmIHHr1zw/cWE5j7oqXHIVLb9ADUMYnnJ207eNPc3f4Z
	yg/hRXpEJ+zUdn+ySfiHtsqFGh6E7injjcbURlpkQl8vO19gyQ/QNcIQ+L7mMG9atBF
	Ff70xakhLw==
Date: Wed, 29 Nov 2023 00:17:47 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Yu Chen <yu.c.chen@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Message-ID: <NkNDM2v--B-9@well-founded.dev>
In-Reply-To: <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com> <b2b9121c6d2003b45f7fde6a97bb479a1ed634c7.camel@linux.intel.com> <NkN3JYx--3-9@well-founded.dev> <c2a9ceb3d7b1f384ad94d10b7058bb1cebea3d07.camel@linux.intel.com>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Nov 29, 2023, 00:10 by tim.c.chen@linux.intel.com:

> On Tue, 2023-11-28 at 23:33 +0100, Ramses wrote:
>
>> I applied the patch on top of 6.6.2, but unfortunately I see more or less the same behaviour as before, with single-threaded CPU-bound tasks running almost exclusively on E cores.
>>
>> Ramses
>>
>
> I suspect that you may have other issues. I wonder if CPU priorities are getting
> assigned properly on your system.
>
> Saw in the original bugzilla 
> https://bugzilla.kernel.org/show_bug.cgi?id=218195
> that you don't see /proc/sys/kernel/sched_itmt_enabled which
> may be a symptom of such a problem.
>
> +Srinivas, is there something Ramses can do to help
> find out if there are issues with cppc?
>
> Tim
>
Yeah I'm getting the impression that something is going wrong on my system. AFAIU, itmt is supposed to be auto-detected and doesn't require additional config?

I have the intel ME disabled on my CPU (it came like that from the OEM), I don't know if that can have an effect?

Let me know if there's any additional info that I can provide.

Ramses


