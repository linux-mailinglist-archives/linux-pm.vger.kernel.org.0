Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E581E0A94
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgEYJb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbgEYJb0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2020 05:31:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D167CC05BD43
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 02:31:25 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u79so9606157vsu.4
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2020 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SJy3teeS/DAEycN8FRbgylUfmtHnW0QUGPznK0vKdk=;
        b=oOVlDGlyYvsjt9O70aWettNvYp5QuWpirQw83njS4tN9OVs1QOHpQ6l4kTXcQxSSyH
         Nhslhcled0cALdykwKEM9G2EaYphVlW+R4mq2rsKBu1pBFetLlagvOXR8qS+HhpbLsfv
         EfsZ8lsKt84cOgjPFwv4DmDm0ZPvnauZJpxKpOo+OpMGpvtMwjQ6XKPlh3MotvunFVL9
         WD2yTLvNTyCG/2t90ne8LWfZc32BozQ1R2+QEeYjj/yC2M0mLjdFEr7Rpjxhx3xSEYoq
         8v/VxK+F4xDjizjBPUPqFQu56jScEuiwTQ1LcqmVtKUa1VPGxM84KBhaYWAlwlkXpfRC
         itEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SJy3teeS/DAEycN8FRbgylUfmtHnW0QUGPznK0vKdk=;
        b=bhTtRw3///UGpOQqmho6OFVk5Tpb2f7zl08XQrjbxHYIiFtfV42eKWv1pMEz10kkG5
         xBW+2dcq2NZeABcrkyGNht6BYt7FEBrKc9LYXcZVJhNFl/pz+AEcstNjAWU+jvaDEzOo
         z6V2ukvWxWtfo9coDLAvWw2auSui/V5emD+QO4AQpejnGKQGMYCialJyFezh8W1pTFCX
         8RMeO5+KWM8qgKxaGmdMq9v1N2uitLIZzImILPjsYYAWuzZQV7WSLwKNwRPZgN1PuCj+
         Bf/1vp4cXXA9dwjZpzJvYljm+8QtFgZhTUOKUTQgS46wyQpqh0sZd9uZdEO79rPSX6wF
         yP2Q==
X-Gm-Message-State: AOAM530iVnNS7stbFA2VX0y08VryzmXlNCLMEZmsCCkwybJcd8Q2qMV9
        yRCY0o+uK6trGmeM+cbthxHUAvOlCa2Dr2qH2YAcSA==
X-Google-Smtp-Source: ABdhPJzdToedW+b7g2VJmgHmi3EXlqTSzajnqP28mVcwwaT9fRa4OEbfVkWvnBRvi/o5+XV/vwN09H2AFAdUDE1INz4=
X-Received: by 2002:a67:1486:: with SMTP id 128mr13187332vsu.191.1590399084957;
 Mon, 25 May 2020 02:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200521170817eucas1p13d9477a0a5d13d2df876134cf41131d8@eucas1p1.samsung.com>
 <5127441.yGvM1JjtLk@kreacher> <e9130ce8-fd22-c871-c089-585585c7133f@samsung.com>
 <CAJZ5v0j+bsHaQcxK41yph8eRpMZ3DoerqA7uwS2B8De41Jwi7Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+bsHaQcxK41yph8eRpMZ3DoerqA7uwS2B8De41Jwi7Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 11:30:48 +0200
Message-ID: <CAPDyKFrHcvhi+qZk-65+FpDMu6y_ZU-K=nRWQY63qMR21m9yMg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: clk: Fix clk_pm_runtime_get() error path
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 22 May 2020 at 20:39, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 22, 2020 at 7:19 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi Rafael,
> >
> > On 21.05.2020 19:08, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > clk_pm_runtime_get() assumes that the PM-runtime usage counter will
> > > be dropped by pm_runtime_get_sync() on errors, which is not the case,
> > > so PM-runtime references to devices acquired by the former are leaked
> > > on errors returned by the latter.
> > >
> > > Fix this by modifying clk_pm_runtime_get() to drop the reference if
> > > pm_runtime_get_sync() returns an error.
> > >
> > > Fixes: 9a34b45397e5 clk: Add support for runtime PM
> > > Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Frankly, I would rather fix the runtime_get_sync() instead of fixing the
> > return path everywhere in the kernel. The current behavior of the
> > pm_runtime_get_sync() is completely counter-intuitive then. I bet that
> > in the 99% of the places where it is being called assume that no special
> > fixup is needed in case of failure. This is one of the most common
> > runtime PM related function and it is really a common pattern in the
> > drivers to call:
> >
> > pm_runtime_get_sync()
> >
> > do something with the hardware
> >
> > pm_runtime_put()
> >
> > Do you really want to fix the error paths of the all such calls?
>
> No, I don't, and that's why I'm proposing this patch.
>
> The caller that does what you said above is OK now and if the behavior
> of pm_runtime_get_sync() changed, that caller would need to be
> updated.
>
> OTOH, a caller that fails to drop the reference on an error returned
> by pm_runtime_get_sync() is buggy (and has ever been so).
>
> I'd rather update the buggy callers than the ones that are OK.

I agree.

In hindsight we should have dropped the usage count in
pm_runtime_get_sync(), when it fails. However, that's too late,
especially since there are many cases having no error handling at all
- and in those cases, that would mean the subsequent call to
pm_runtime_put() can mess up the usage count (if pm_runtime_get_sync()
failed and has already dropped the count).

So, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

[...]

Kind regards
Uffe
