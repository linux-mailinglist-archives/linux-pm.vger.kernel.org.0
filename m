Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C21656DC
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 06:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgBTF1s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 00:27:48 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:40799 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBTF1r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 00:27:47 -0500
Received: by mail-vk1-f201.google.com with SMTP id s4so942941vkk.7
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 21:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W0+Qsok4oHbZGyXChyR+IRt/a8kG5juFEyjjlXhevNk=;
        b=HRqIYU6n2M7e6jh89sZo+ewE85AfSOVSBO6wrBhPQxUWmonRwRL/cVevuwJlBmUkq+
         mf8c7FYI8Ij9jDFC4a/cNViBWezTTOxOpQ2AUGMXCNwfKYXmrUvGBNU8P4H9ee+oo8Ow
         xFweVMIM4cFWNU/PqnR0vV7F1r0prxw96JLLVvrjN9xwQOxei++rgT52wvJG7Jk4htJR
         /mNBjD8XGIReyvHAUqC28rWyjuj4ynOTIQbIszhzm704hS6FbbclqLJzvQOoyXOrMswJ
         B9lcHqt0qmuhEC6L46zxn9JzIvok153AWcs0dE6upTC0UpkU13aIUu96I6yxRRFmmpTs
         p1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W0+Qsok4oHbZGyXChyR+IRt/a8kG5juFEyjjlXhevNk=;
        b=HpKB9bQ206quw0vMrTHwpbclUkoxn/HgtVfogq7SNDeOSDwq6LRQNVgSzDpWklvTaG
         hDNndLBR/D0GneVjOiBo9Yx8bghaAEj/Gf4bT9KDwt/b0x6LLSf7pzXU7bHmlq01AlX+
         Je0dxiiKxKho5DK2fYnbbdmWbB9q4QSBgp31X6BrWrcBXi3oL07GdappW3hjR+i4vmJI
         iaJuNcJc9JeXcs+YPu7j4fz4/dDw57TPtTA9i68iOHLrV564bVnrN8/dzMAR9htPGlJC
         CE7YXbuFN82hfQc9wh0hF8gOJu99nSeYDmq2YuBfQaILhlUffrAZeWqeR/Ze8jTdQ0Gr
         npAw==
X-Gm-Message-State: APjAAAWeukuwRZrhg/NuIu28RHl7LRGIBQhgbp7ihfcr+B6h1Y5MGyY+
        hQ8b74ilAEEQvn3bDSHCUaZs1r/yyHtV0w0=
X-Google-Smtp-Source: APXvYqx7UYZrF+NELBJAur5GTkT83RGTPAinxyJ9i+Zwuqnu1BZtsoXFlzXAlTuDLzNZIRGYaheylatSL73RSao=
X-Received: by 2002:a67:320c:: with SMTP id y12mr15995010vsy.47.1582176464977;
 Wed, 19 Feb 2020 21:27:44 -0800 (PST)
Date:   Wed, 19 Feb 2020 21:27:38 -0800
In-Reply-To: <20200218220748.54823-1-john.stultz@linaro.org>
Message-Id: <20200220052739.87057-1-saravanak@google.com>
Mime-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
From:   Saravana Kannan <saravanak@google.com>
To:     john.stultz@linaro.org, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, khilman@kernel.org,
        len.brown@intel.com, lgirdwood@gmail.com, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, tkjos@google.com,
        ulf.hansson@linaro.org, Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Apologies in advance for replying to this one email but discussing the
points raised in all the other replies. I'm not cc'ed in this thread and
replying to each email individually is a pain.

On Tue, Feb 18, 2020 at 4:07 PM John Stultz wrote:
> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.

Both of those patches were the best solution at that point in time. But
the kernel has changed a lot since then. Power domain and IOMMU drivers
can work as modules now. We have of_devlink and sync_state().

So, while a delay might have been the ideal solution back then, I think
we need to work towards removing arbitrary timeouts instead of making
the timeout mechanism more elaborate.

I think driver_deferred_probe_check_state() logic should boiled down
to something like:

int driver_deferred_probe_check_state(struct device *dev)
{
	/* No modules and init done, deferred probes are pointless from
	 * now. */
	if (!defined(CONFIG_MODULES) && initcall_done)
		return -ENODEV;

	/* If modules and of_devlink then you clean want dependencies to
	 * be enforced.
	 */
	if (defined(CONFIG_MODULES) && of_devlink)
		return -EPROBE_DEFER;

	/* Whatever other complexity (including timeouts) we want to
	 * add. Hopefully none - we can discuss in this thread. */
	if (.....)
		return -Exxxx;
	
	/* When in doubt, allow probe deferral. */
	return -EPROBE_DEFER;
}

Rob, for the original use case those two patches were added for, do they need
to support CONFIG_MODULES?

> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.

Once we add of_devlink support for power-domains, you won't even hit the
genpd error path if you have of_devlink enabled. I believe in the case
you are testing DB 845c, of_devlink is enabled?

If of_devlink is enabled, the devices depending on the unprobed power
domains would be deferred without even calling the driver's probe()
function.

Adding power-domain support to of_devlink is a 2 line change. I'll send
it out soon.

Also, regulator_init_complete() can be replaced by a sync_state() based
implementation. I have a downstream implementation that works. But it's
definitely not upstream ready. I plan to rewrite it and send it upstream
at some point, but it's fairly straightforward if anyone else want to
implement it. My main point being, we shouldn't have to make the timeout
logic more complex (or even need one) for regulator clean up either.

On Tue, Feb 18, 2020 at 6:07 PM Rob Herring wrote:
> The one complication which I mentioned already is with consoles. A
> timeout (and dependencies in modules) there doesn't work. You have to
> probe and register the console before init is done.

Rob,

I've seen you say this a couple of times before. But I don't think this
is true any more. With of_devlink enabled I've booted hardware countless
times with the console device probing after userspace comes up. The only
limitation for console drivers is that they need to be built-in if they
need to support earlycon. If you don't care to support earlycon (very
useful for bringup debugging), I think the console driver can even be a
module. I don't think even of_devlink needs to be enabled technically if
you load the modules in the right order.

Thanks,
Saravana
