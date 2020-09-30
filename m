Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB3427ED76
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI3PjN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 11:39:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44090 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3PjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 11:39:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id 185so2131799oie.11
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2020 08:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc37h7a0HpcuQSQ7npavP/zcanPJUZY3IMs2yQyrUP8=;
        b=Qx/nSJNVAkH8Xr0jYc0EhpeCgJVqAouF8D9o7AxJsLSrZWRiT3la5Xnsx23zjbO501
         ixQumAn+r6yQimfMYMveprz+B3OFeOY/Bi66cRZLXXqRbBKu8BsA1hQ2J6waz9DlOOYA
         NrWF7nciVVq0T3NUbb2YwYk1n14T79khzjN1VDMlC408ifNJOl+TiNPeSx7Ea0WiCUHo
         PMvg17hlI2ycyxFWCi7c13qhgPEqpiRjtF1M+yb7DS9tJNfoDirAafdyJXS9Y8TvZf9R
         ew0EOoc6HmPN/vWTvtqPAdlVh8Pg6M8PaVM65COL3btZ+HaQwEDA8Z12Elr/ypJ7VHyL
         51XA==
X-Gm-Message-State: AOAM531s0HjW/GZM+p9r2pFKKJV7MJGaD2Fo0n0mmdsSNVQXok6yi0de
        wB1QpFkD6/QiTqXJ+ww6RtT7pso0ZLdlUAHni2KmylwH
X-Google-Smtp-Source: ABdhPJyICO+bwGiTxYfx9mADXnCxKxtQzWCkN7fRe1BhIJFYfWf41bIY2binuzgSifp8KE7kCJVaJHBUPtSABV9g5l8=
X-Received: by 2002:aca:df84:: with SMTP id w126mr1781508oig.103.1601480352852;
 Wed, 30 Sep 2020 08:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <89e655dbf96777b897ceb721f82be0d5ea7210e0.camel@intel.com>
In-Reply-To: <89e655dbf96777b897ceb721f82be0d5ea7210e0.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:39:01 +0200
Message-ID: <CAJZ5v0i+KJxS=GKCP8r-5XJ7mnKLAo2hU3fNgFYXush=NrViUw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix missing return statement
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 28, 2020 at 4:36 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> From 1027ed2cacb0b50676eb52dd0089076d951033d7 Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Mon, 28 Sep 2020 11:33:42 +0800
> Subject: [PATCH] cpufreq: intel_pstate: Fix missing return statement
>
> Fix missing return statement when writing "off" to intel_pstate status
> sysfs I/F.
>
> Fixes: 55671ea3257a ("cpufreq: intel_pstate: Free memory only when turning off")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index a827b000ef51..9a515c460a00 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2781,6 +2781,7 @@ static int intel_pstate_update_status(const char *buf, size_t size)
>
>                 cpufreq_unregister_driver(intel_pstate_driver);
>                 intel_pstate_driver_cleanup();
> +               return 0;
>         }
>
>         if (size == 6 && !strncmp(buf, "active", size)) {
> --

Applied as a 5.9-rc fix, thanks!
