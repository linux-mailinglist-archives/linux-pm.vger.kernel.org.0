Return-Path: <linux-pm+bounces-14446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26B97C64A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AB1281CCD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0976E1991B1;
	Thu, 19 Sep 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VrVcQIQp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D91990A1
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736002; cv=none; b=VqFckMOoN0lRErEW12/1PB+afYT6k8XNxKCLf/vSV5pZ8Dv0JHlFuKcdeqGiekZOd0lsgBoR4F2p0T2/nph8PZDQcVgZDp/J4Vnqqvq5B+OlO26xCqc6XsrLPF9J0yJY5ElyCyPb/QxM40/dK2zGNvMwaBpraJ2vwZC2W7euXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736002; c=relaxed/simple;
	bh=jmQGSHPQAAX/GFq/B1HD2tAS5MutC16GzgAMXMtyErU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYgj3jeytjihPdFtw6lr5MWGgi06u+AokWchwjM1nHJPf8nYh5j52DTWTVmLdGd1bhIQvsUFukjz87pU8he8MdT/lDQen9hodoBqi4p5D9rzwxVq+OTZOjtq7VbMjS+6BwKj+6gubfYN0v1qiZfe8WLzcdbcWD0ASfXORo1+V9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VrVcQIQp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f753375394so4680511fa.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726735997; x=1727340797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ip5fmGFn7hygDUeJp4dufO1rEFoOFFXq7aKfuDJ9XE=;
        b=VrVcQIQp0aceaKbot7i8ZEXl8v+lcyWsAXbo+r+72B7NxUXwh9Pku0TPu0ZqsjDilX
         QzeQTrBVB8QP8b5WXmWIzvo1d5Fv5fNd9xU7Le0GGX+SmEIFaHZreC1YxoJmM7nDJL85
         2xKOIvG37p/aJFHsUmOKZNVsuQp8HV5iSDb8t/m0F03DeZlikJf7D0lb2JXPxZMFc4ly
         NOBIXKeJfgm1+q4Wycka/y/x7GUZ/bujf1PnoMhqANcarS/PkTnoG0jhCW5wqpUC11sS
         TaZFyE3tGJC3OeqMetUZrRrB6vuxkcmPviZLgySqrL3plHOOktupPzBn1Llz3cpRLXub
         gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735997; x=1727340797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ip5fmGFn7hygDUeJp4dufO1rEFoOFFXq7aKfuDJ9XE=;
        b=Fcw+DPytJ4vBDDETw+8cA8+BfIiXIf/ynzWVED2Bqpal6VOTVWi9WQVXWv8QZJsNXr
         vyfMS2snkirD8Xegl7/jMosrpfn949Bb/hEdGg0/hDuDRZVkFsgRQi9QTNQ0Zs7Wrq0+
         Y79ZtK/1QipQQdiG3Y/6SMqNIOM8p30MvV46DvPWm7f3pB4W7CghNeKza0UHcZAhKbvk
         3w8y7vFwjklT36WXnlC5uUUr2XsE3HFnU7EajNswG6FC4yrSnzIrxph8e10RKSkd0DMe
         DiSouLgXigF5QEUHwTpF+QaajjpEchA6gq4E7yM+IVxVGt5xZ6QGd0K2Ui1dS9Oyle5t
         9gLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX68+K981iziaJyhJqNOqsf0ghqgkp5JuSUqhHJEDALZj3I+5GTWac125UXNL+X69J2uFgwxw2YTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRWiJuV0T0HrG2zE8MZo7/G43IJOxf5LTj4iDSh0mH6Xf5qex
	TBGha3BCq2NefStuc0BibTlBfbICHn4qhmMjQrpytcmwPZiAr9yAubNr1XD1SuA=
X-Google-Smtp-Source: AGHT+IExHV10Jhw7pzq6Z+rh3ETzFIGUY1KRRXUiCBSFN21i+8wI32UjyZymk12trNBAHKYmGerSpA==
X-Received: by 2002:a05:651c:1549:b0:2f7:631a:6e0d with SMTP id 38308e7fff4ca-2f787dc3b59mr141352651fa.12.1726735997390;
        Thu, 19 Sep 2024 01:53:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm76076095ad.53.2024.09.19.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:53:16 -0700 (PDT)
Date: Thu, 19 Sep 2024 10:53:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
Message-ID: <ZuvmcclM_HzdZtwP@pathway.suse.cz>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>

On Thu 2024-09-19 10:17:24, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Am 19.09.24 um 07:51 schrieb Paul Menzel:
> 
> > Am 19.09.24 um 07:51 schrieb Paul Menzel:
> 
> > > On the Intel Kaby Lake laptop Dell XPS 13, Linux 6.11.0-04557-
> > > g2f27fce67173 (“6.12-rc0”) fails to ACPI S3 suspend the system. The
> > > screen turns black (as expected) and the power button LED stays on.
> > > 
> > > Doing
> > > 
> > >      echo N | sudo tee /sys/module/printk/parameters/console_suspend
> > > 
> > > and on tty2
> > > 
> > >      sudo systemctl stop gdm3
> > >      sudo systemctl start getty@tty1.service
> > > 
> > > and then on tty1
> > > 
> > >      sudo systemctl suspend
> > > 
> > > I see some panic messages and traces containing ktime_get or so, but
> > > I failed to save the messages. (Hints very much appreciated.)

You might try to enable the kernel crash dump.

Or you might try to set some delay in /proc/sys/kernel/printk_delay and
make a photo of the screen.

John Ogness told me that there was a trick with a permanent memory.
But it seems that there is no permanent memory on the laptop.
Adding John into Cc.

> > > I try to test the printk changes, but otherwise bisecting is not
> > > feasible, as it’s my production machine.
> 
> It’s not the printk changes.

There should not be any visible changes at the moment because all
console drivers still use the legacy code.

The conversion of the 8250 serial console driver is still pending
review, see the current version at
https://lore.kernel.org/r/20240913140538.221708-1-john.ogness@linutronix.de
But this patchset would have effect only when the serial console is enabled.

> I tested some commits, and assume it’s the timer core changes:
> 
>     $ git log --oneline --merges daa394f0f9d3c -3 --no-decorate
>     daa394f0f9d3c Merge tag 'core-debugobjects-2024-09-16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>     9ea925c806dbb Merge tag 'timers-core-2024-09-16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>     cb69d86550b3f Merge tag 'irq-core-2024-09-16' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> 
> 
> 1.  6.11.0-02659-gcb69d86550b3 succeeds to ACPI S3 suspend
> 2.  6.11.0-02710-gdaa394f0f9d3 fails to ACPI S3 suspend

Best Regards,
Petr

