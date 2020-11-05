Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C672A8088
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgKEOOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 09:14:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39972 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgKEOOh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 09:14:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id 79so1520876otc.7;
        Thu, 05 Nov 2020 06:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEEowh+T0pIbAfgPY0YhtXnXk1K1Ucdlz5bSuRat+js=;
        b=jR3XFVe/4o7IkamlnjIqLxeMnNGl2xqz6N7GxWjXtnFQI0Ln+LU2ijc1mcEHjYQeuy
         nl0wEJGadLkWcRShoHE8dduFfNJB37aGojIWvomcjMV6MyQPklvPLZjdlmB2KBFNrVxI
         L4QyDEgYJT1IqINWufi7Ah4DWTR+mzfF5Zt+8RkZhPhPwEOOkSjJdgz95j94OxAK/laP
         Ra8kcsxRW/QyyXKI2hfIBjvVXp9XXz5mmxRI/PGNLD06w//lCcSW3yWZLrZtSKavwEUB
         NTyNzNywWRUZzTyek5+YmcmekotQHAFH+0FgEmsOxulN2KJlBKbbhQni8EcDlVBENiNs
         0i6w==
X-Gm-Message-State: AOAM530qnG2Lnpwq0EIebrCtCEjkB6mHmpaGYVnREA2fbXePJTRFW7IT
        ZF7WXefyVxsOcgGBpn6flRUE030teSC6uerisrQ=
X-Google-Smtp-Source: ABdhPJyY0c11aBEPP3RfRuyNxeFNRhC+g8jVlC9nmLx5QoPAm7TthNzjVoDFtMI86kZ9Id/tQPkJlyCR5cmHFYpMdIA=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr436919otu.206.1604585675001;
 Thu, 05 Nov 2020 06:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20201015144431.9979-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gPYXhqP4CF+ep3tE7ov5zza0FW9_9cuDsiqznUX8CTCQ@mail.gmail.com> <8fef63ad-a081-e543-0c18-3797f3aaf1be@linaro.org>
In-Reply-To: <8fef63ad-a081-e543-0c18-3797f3aaf1be@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Nov 2020 15:14:23 +0100
Message-ID: <CAJZ5v0g9d+Y2gGXaXiAiCFjJ=VmdCq+HBCkke4TbKqKkyXrsDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] cpuidle: Remove pointless stub
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 10:31 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 16/10/2020 17:24, Rafael J. Wysocki wrote:
> > On Thu, Oct 15, 2020 at 4:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The cpuidle.h header is declaring functions with an empty stub when
> >> cpuidle is not enabled. However these functions are only called from
> >> the governors which depends on cpuidle. In other words, when the
> >> function is called it is when cpuidle is enabled, there is no
> >> situation when it is called with cpuidle disabled.
> >>
> >> Remove the pointless stub.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
>
> [ ... ]
>
> > Applied (this patch alone) as 5.10-rc material with some minor edits
> > in the changelog, thanks!
>
> Does it mean you disagree the other patches? Or are you waiting for more
> comments?

Actually, both.

My primary concern regarding the modularization of cpuidle governors
is that they really belong to the core kernel.  They access the
internals thereof and the behavior of the idle loop in general depends
on what they do.

OTOH IMV a potential benefit resulting from allowing them to be
modular is very small, at least from the mainline perspective.

IOW this case is very similar to the modularization of the schedutil
cpufreq governor which we decided not to do for similar reasons.
