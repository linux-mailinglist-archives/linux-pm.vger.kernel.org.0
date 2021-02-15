Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC9E31C23E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 20:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBOTKo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 14:10:44 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37089 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhBOTKn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 14:10:43 -0500
Received: by mail-ot1-f52.google.com with SMTP id w26so1213402otm.4;
        Mon, 15 Feb 2021 11:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMNki+2cLVuzdgn1S3zieom87YpudSs/d+vM8W4aiTg=;
        b=Qr2xPBonwteO0sMXXK7DSvAo1ngZkejp91DAlETc6mCUt2m0ZDTnQkIVqapKjr5WsY
         VXBQLy7vfcmeRRNb/6NbL1z3XFkNlhqDXcI3mHdNNFEPeY1JHk/jXEVL6KnggqOl9SOr
         AH91zhR/zNdBwQH6l9JvlWdShi0J2I5AlwUiZGc3c5Y8GSY+VQoBGGVtqLT/XqNhKY3H
         SOZoLekwuJm2CZZwDQFT2zvi/1RCumcMW4k7+HWj9B+s3wXTz63CAfswgUYtECwhotWg
         RCKXwytDXB2Kje7ug+R1NQhNxNWFIzuQM4FGOv7If9Q3Kh8PKxqLqYecmO+5uSRQmlpm
         YfYA==
X-Gm-Message-State: AOAM531QOoPLu1hdXFqZrCz/SXR2mFhICszIcdHo9/uXCInWuTotImyl
        KXUQMirWtKuwUOI3KJU6PvmKBGlgK6L7mPEniow=
X-Google-Smtp-Source: ABdhPJwNqm8geu1/m9D1iBU2bID0cSAEp0uJQb0mrLtQVa7KqdOWFl5IclWqgtU60vTtxlb8xGCb4KV6NWkoF33evNw=
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr12307625otp.107.1613416202410;
 Mon, 15 Feb 2021 11:10:02 -0800 (PST)
MIME-Version: 1.0
References: <20210215151405.2551143-1-geert+renesas@glider.be> <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com>
In-Reply-To: <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Feb 2021 20:09:51 +0100
Message-ID: <CAMuHMdVXCH+27cpC=-viQev1HeN_DkU0=7Dydp4G50z0bB2Ang@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Fix uninitialized spinlock when attaching genpd
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On Mon, Feb 15, 2021 at 7:37 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 15, 2021 at 7:14 AM Geert Uytterhoeven
> > @@ -148,7 +149,11 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
> >         pd_args.np = np;
> >         pd_args.args_count = 0;
> >
> > -       return of_genpd_add_device(&pd_args, &pdev->dev);
> > +       /* Cfr. device_pm_init_common() */
>
> What's Cfr?

"compare to" (from Latin "confer").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
