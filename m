Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0C28DDCF
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgJNJjY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgJNJjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 05:39:24 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D9EC061755
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 02:39:24 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id j21so911201uak.5
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPSUAuXFi9XZcusioE4srw1Rf5cg3gfsXUEyszXqcWM=;
        b=NaItG0AOU9W2NVgXsRuRdN9MT63voNLQ9JQBrLH8A0wXE+vLF4OCuqBkAHu1TUh0Dt
         0pDZ//YpKwI/MZc3ZyseGQ9UpOZZ+x880gezz8+OZ4TwrzCoEO5oWYefuTk7xq0H8cKD
         bG2tI4O4ArJGiMsq4xgCHfztPPeXpNLgNaJW3ol0BHGIuRdx1VPiUq58oi5XUNbBzyEi
         O0qdmS2qwWwKLF26YIB8k17QMqksJ0DLRfn64bVM6Zpkp6zE61s6QJtUwZ0A1wqAASCS
         DOn6AoMmzwyt5b8pR2L4JxxZetQVjaDxr4IDyv8nF1ZF91LjnChUTpMt7VE52IDNbu5u
         wADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPSUAuXFi9XZcusioE4srw1Rf5cg3gfsXUEyszXqcWM=;
        b=XIz6t2JUhpF1NmEUfRxVsPmbljTOrK62Ck8ae5mLk9mAnrXMgq3DSCgJU0RUBZ2hHJ
         tzmN89LmM836od9IvDrccuaST2dp1TUA81AP4fNosZ9GtPqaTtx2hTwtnKjmViiFJ3QH
         SJz3g6OddyBv2Mn0+GpZf/fKm52cVb+O+3IUUMVXBJb4CmujwcmYo1bFlfqyddioMo93
         obuCAcKYfDyBFoO/tWGYpI5pFEu8dZGQi1fk3liDCtI3dOg5rNXotiODWh/lM5Oaty0h
         vh36JgU3QojF+bHHSMMbr2c7Gx0+2xHpLjJNtJbpWMszgOlEkJVc6UteMpdIVm3Gx3xx
         aHOA==
X-Gm-Message-State: AOAM532Nv4w7alxMeMDUgIpZ8uBdXeIjeo9qvABqO/VJzCRPrLc8FYUv
        wJI53U3LuK0j2e0tn7pUB/WLHUbMVBz5sY57j6Vktw==
X-Google-Smtp-Source: ABdhPJywMgnb2aSPAIkBqizgwlb+m9mEagJsf5NSEjw32VfN8QHkea/OrMJkCbwUg1xkkzc3aCF5zz2FJknojORL5LE=
X-Received: by 2002:ab0:907:: with SMTP id w7mr2664596uag.100.1602668363221;
 Wed, 14 Oct 2020 02:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201013141459.28599-1-geert+renesas@glider.be>
In-Reply-To: <20201013141459.28599-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Oct 2020 11:38:47 +0200
Message-ID: <CAPDyKFo6Owf92RmP5cofuz97WNWJ--iwYgNw-3svvRsWt=Fc-A@mail.gmail.com>
Subject: Re: [PATCH] PM: Domains: Add curly braces to delimit comment +
 statement block
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Oct 2020 at 16:15, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> There is not strict need to group a comment and a single statement in an
> if block, as comments are stripped by the pre-processor.  However,
> adding curly braces does make the code easier to read, and may avoid
> mistakes when changing the code later.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume that this is the only place of this pattern in this file?
Else, it seems like we should fix them all in one go.

Nevertheless:
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 05bb4d4401b26e44..f4a28c33fafa03b2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1270,13 +1270,14 @@ static int genpd_restore_noirq(struct device *dev)
>          * first time for the given domain in the present cycle.
>          */
>         genpd_lock(genpd);
> -       if (genpd->suspended_count++ == 0)
> +       if (genpd->suspended_count++ == 0) {
>                 /*
>                  * The boot kernel might put the domain into arbitrary state,
>                  * so make it appear as powered off to genpd_sync_power_on(),
>                  * so that it tries to power it on in case it was really off.
>                  */
>                 genpd->status = GENPD_STATE_OFF;
> +       }
>
>         genpd_sync_power_on(genpd, true, 0);
>         genpd_unlock(genpd);
> --
> 2.17.1
>
