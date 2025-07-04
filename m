Return-Path: <linux-pm+bounces-30106-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28B4AF8B09
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE597B40232
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4A532623A;
	Fri,  4 Jul 2025 07:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ok/N6c8Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E0326231;
	Fri,  4 Jul 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615845; cv=none; b=Aa4vhqTgIZu2wIE48O0DcObBTS1zri+VfnAoe9aokw5G5qdSF3sFEpFX7BNeQt6dS6v5qf40DQVxi8I5HrG5QVe0cEBh6lQnivIyyybW5M8SeNf7hQME0IA3AdEDG5jw5oG5ZWXXEJAVI4i+m5xWAVZY0pEm0n5lN/XKAvKfb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615845; c=relaxed/simple;
	bh=MgFEolINa2mqHDNtnOb4oERRABfY40yjNkoZlWQnkZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBnpWD9HzOuvSXGueVapoIlmwa8kA2sJQttSDjgPBEALCMcon28OLMbvsqBdo4rQLXCB173R2EViyNyX0TZGI9ghZoADZbGnBtgb380bfXZxbCRlf9Q7dm06e62Us/moPwCtVK61l1MF79QEy4vCHWZGPwWhlIcCLpgwgpb2ErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ok/N6c8Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L0bdJ55ZuGgGGTacDM0SpqaswUQMNdvtMXzThUW4T3M=; b=ok/N6c8QoiKqC9VyX88ZXrEXhj
	wYv0ERTE0LGnSRzAhporwVm9X77AJX2ZvnFfYvToGVRee3PmRp3WHJNQ/np0X8up+AEOzJxtcp4AP
	YiaXVYTagHG0IOgYDVNGWvFeSRQ2vo5vuZgT9xcbJ25kTnpd9T++xGJlaAptP6ZB0CWWstc5mOXsG
	jRA9U7UeBhZEk+88wlppPBF9K8Xk2IbeQCkjnKN9Tl2InP9wGhHcokumn0kAuZRQte7cgkRX9w2Zd
	BlNA4mFA2b55FUgMR2PBc4zVbAL0xBrGo1ZxqlFKSS1IAQcA8996dTYayewmhcF2sHJSkva3ffrcx
	Mj1+WNSA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXbIN-00000007pyj-3Jvg;
	Fri, 04 Jul 2025 07:57:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4906300233; Fri, 04 Jul 2025 09:57:18 +0200 (CEST)
Date: Fri, 4 Jul 2025 09:57:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal Koutn?? <mkoutny@suse.com>, rafael@kernel.org, pavel@kernel.org,
	timvp@google.com, tj@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [PATCH next] sched,freezer: prevent tasks from escaping being
 frozen
Message-ID: <20250704075718.GA2001818@noisy.programming.kicks-ass.net>
References: <20250703133427.3301899-1-chenridong@huaweicloud.com>
 <n23vsu6y6cjf2vwdbfcjl2mj7venvpzpblncoa7adn3q5r4lph@qsfa3deqtamc>
 <f4c4f465-72b9-4682-99e6-c249ecab8572@huaweicloud.com>
 <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dae8006-e63d-467f-bb7c-e8470878e534@huaweicloud.com>

On Fri, Jul 04, 2025 at 11:11:52AM +0800, Chen Ridong wrote:

Your patches are mangled; please educate your MUA.

> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -71,19 +71,20 @@ bool __refrigerator(bool check_kthr_stop)
>         for (;;) {
>                 bool freeze;
> 
> -               raw_spin_lock_irq(&current->pi_lock);
> -               WRITE_ONCE(current->__state, TASK_FROZEN);
> -               /* unstale saved_state so that __thaw_task() will wake
> us up */
> -               current->saved_state = TASK_RUNNING;
> -               raw_spin_unlock_irq(&current->pi_lock);
> -
>                 spin_lock_irq(&freezer_lock);
> -               freeze = freezing(current) && !(check_kthr_stop &&
> kthread_should_stop());
> +               freeze = (freezing(current) || !cgroup_thawed(current))
> +                        && !(check_kthr_stop && kthread_should_stop());

This makes no sense to me; why can't this stay in cgroup_freezing()?

Also, can someone please fix that broken comment style there.

>                 spin_unlock_irq(&freezer_lock);
> 
>                 if (!freeze)
>                         break;
> 
> +               raw_spin_lock_irq(&current->pi_lock);
> +               WRITE_ONCE(current->__state, TASK_FROZEN);
> +               /* unstale saved_state so that __thaw_task() will wake
> us up */
> +               current->saved_state = TASK_RUNNING;
> +               raw_spin_unlock_irq(&current->pi_lock);
> +

And I'm not quite sure I understand this hunk either. If we bail out,
current->__state is reset to TASK_RUNNING, so what's the problem?

