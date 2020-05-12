Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84381CF102
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgELJFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 05:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELJFl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 05:05:41 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34093206A3;
        Tue, 12 May 2020 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589274341;
        bh=HS+53ZodqD34omUaUnfZGaaf3rHBhijbLO2ygOHvWBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z5s6zPoUUzxvR8qdd57Vjpx+i5DWghLNc9KIZ5neo+iBD64HzEyZi8RxetyQ6FgAf
         p/3OXO0bk3sgpbGnbI5D8i6vos1yEge44MH1NFdXwmPDlDgqUHr3Ee8bPHRUxKlnUI
         xMjhjGCrlwmh7TZSetaFhmkh+6r9aiDJRhJaMysw=
Received: by mail-lf1-f54.google.com with SMTP id b26so9913862lfa.5;
        Tue, 12 May 2020 02:05:41 -0700 (PDT)
X-Gm-Message-State: AOAM531fk+a+XsbFpJ7mVFpvoIyWINsggM1WQ7lyAXYxKM/IjOioNCJZ
        76INQKsifcuCF7wyrpRDnGC9916Fnk5pi8R2yds=
X-Google-Smtp-Source: ABdhPJyrJVrAT8momuEFoaiqxBUOKAS3w1MEWaOBVANtVD6B7+0T1Wih7oQd+8Fm3Od1tfwC7O0GXietblUkp8+w3O8=
X-Received: by 2002:a19:f00b:: with SMTP id p11mr13835301lfc.210.1589274339295;
 Tue, 12 May 2020 02:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200508131338.32956-1-bernard@vivo.com> <20200512065023.GA10741@kozik-lap>
 <e762ce12-eff0-d3a5-f083-2b592921de59@arm.com>
In-Reply-To: <e762ce12-eff0-d3a5-f083-2b592921de59@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 12 May 2020 11:05:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPekrkyDf2TMCnX7Nvbdaj-JQwuyqrsurFM4moALqVx8Sw@mail.gmail.com>
Message-ID: <CAJKOXPekrkyDf2TMCnX7Nvbdaj-JQwuyqrsurFM4moALqVx8Sw@mail.gmail.com>
Subject: Re: [PATCH] memory/samsung: reduce unnecessary mutex lock area
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Bernard Zhao <bernard@vivo.com>, Kukjin Kim <kgene@kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 12 May 2020 at 10:47, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Krzysztof,
>
> I am sorry, I was a bit busy recently.
>
> On 5/12/20 7:50 AM, Krzysztof Kozlowski wrote:
> > On Fri, May 08, 2020 at 06:13:38AM -0700, Bernard Zhao wrote:
> >> Maybe dmc->df->lock is unnecessary to protect function
> >> exynos5_dmc_perf_events_check(dmc). If we have to protect,
> >> dmc->lock is more better and more effective.
> >> Also, it seems not needed to protect "if (ret) & dev_warn"
> >> branch.
> >>
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> ---
> >>   drivers/memory/samsung/exynos5422-dmc.c | 6 ++----
> >>   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > I checked the concurrent accesses and it looks correct.
> >
> > Lukasz, any review from your side?
>
> The lock from devfreq lock protects from a scenario when
> concurrent access from devfreq framework uses internal dmc fields 'load'
> and 'total' (which are set to 'busy_time', 'total_time').
> The .get_dev_status can be called at any time (even due to thermal
> devfreq cooling action) and reads above fields.
> That's why the calculation of the new values inside dmc is protected.

I looked at this path (get_dev_status) and currently in devfreq it
will be only called from update_devfreq() -> get_target_freq()... at
least when looking at devfreq core and governors. On the other hand
you are right that this is public function and this call scenario
might change. It could be called directly from other paths sooner or
later.

> This patch should not be taken IMO. Maybe we can release lock before the
> if statement, just to speed-up.

Yep.

Bernard, you can send just this part of the patch.

Best regards,
Krzysztof
