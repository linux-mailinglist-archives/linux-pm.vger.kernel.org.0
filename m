Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B7290898
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408385AbgJPPhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:37:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35599 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408350AbgJPPhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:37:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id f22so194013ots.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 08:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szm/GbXah6hOlvML5pjEqHXfGiXMXqer628Kza3rp4o=;
        b=gHqhyS+RhpBvUzOALffm+V/jtVi6YargGjUjLplhgVAdPAkFczU+Q4RuwfhHrkcMAU
         7+KDtTWdXy/BJT8E1OJrytt8F2BC7FbMo6S5DKUYsif348OOz/IequUc+qOhEkFcVKse
         rgFeJVkTpxPuKSDY3vjNKVhmydDUNjmLS3KtOk9jyBpNI1QC9LXclyGbEoBDG2qFnR39
         Z03G3VifdbCAAF8rcvzvxrW4hjTzpxUt0hZRX4Tz9Plg/00ix6BOg6aYXXM8doLEWuN6
         9kiG/aRQa145oKtASAt/6QLmweqAVS0nfj6oeS6fvDmOjYo0+13mAzDGHXSiNW3LGYkb
         +Oxw==
X-Gm-Message-State: AOAM531PpJOmcx/km3f1NbUq+qXNzqHJEk/p+ZET6SBSCgL3x7AcmW+X
        QMYPfZysxc4OB+jQlrEuMqevRuiR6U6Vq2fSni78ZvbB
X-Google-Smtp-Source: ABdhPJyr6XbdbPQKCol3cUpvHwwbI03Oddr44IjKdZ8PLrujQzEJvTyrQaEUWTwRkjama51hUHD8cWFHrFH0vvtMVlQ=
X-Received: by 2002:a05:6830:30ae:: with SMTP id g14mr3186018ots.206.1602862659929;
 Fri, 16 Oct 2020 08:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201013074241.8797-1-rui.zhang@intel.com>
In-Reply-To: <20201013074241.8797-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:37:28 +0200
Message-ID: <CAJZ5v0jiT0sraaCBUvyHKnzL-5aZLyzBe7e7pnB-AmAdi=AStg@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap/intel_rapl: Fix domain detection
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 9:42 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> As only the low 32 bits of the RAPL_DOMAIN_REG_STATUS register
> represents the energy counter, and the high 32 bits are reserved,
> detecting the existence of a RAPL domain by checking the low 32 bits only.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 983d75bd5bd1..2651ea6cd6d3 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1228,7 +1228,7 @@ static int rapl_check_domain(int cpu, int domain, struct rapl_package *rp)
>          * values, otherwise skip it.
>          */
>
> -       ra.mask = ~0;
> +       ra.mask = ENERGY_STATUS_MASK;
>         if (rp->priv->read_raw(cpu, &ra) || !ra.value)
>                 return -ENODEV;
>
> --

Both patches applied as 5.10-rc material with minor edits in the
subject and changelog of the second patch.

Thanks!
