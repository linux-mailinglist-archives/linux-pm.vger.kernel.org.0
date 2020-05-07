Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF711C88CF
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGLtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 07:49:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42473 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEGLtl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 07:49:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id i13so4890361oie.9;
        Thu, 07 May 2020 04:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+aH1yBOOObNG5A6jSqvawJqChJjtjYvvgrlnPsFqdg=;
        b=tOSZaMrvIeCuf89K5lKBxGjb8gTlSnghDKQRGHbKc0infE8pLWPUNkHiQpJPWU0IBy
         ut5JH90l4oWVVbTURNZRpKU7ANzAhWQaNpXStjQmT8/l3YhhuwOUNHtAO2Ec8b6dzLU6
         TpoQt+T9sVAGk9T6n6tOEyr70oNLNOY/wwMam9u1XNW8xjNUkx8iTaAAh7dDzvqfrc8i
         DJSvAfWDLQsAjoTMgqtcceW6mYCJA16G9VR2Klu7RrY+uoetTST3csx3jk5L7orv4oip
         8leme2k03IfS4LUHZrVkgksUGqL9SSJhV+q76XVmijOdVU7bRQNjzA5d0okCsCFZgfTL
         APaQ==
X-Gm-Message-State: AGi0PuaIFGZql261kbfnjb3WlRg/6yuPS89m5uISTuxhkCd773rWjI3G
        NAP0Uk6FaJi/l53Of8lSjQ3kgtixX4PuoZzy6wTL+A==
X-Google-Smtp-Source: APiQypKBxDEbsH83Yv0T0SNjuH3GFu34qDH49J6uOMcPFccKq+j0kkCa+vULradOgiIRYYQy8f0b5gEvedmQh+IHZ0Y=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr6194446oig.54.1588852179333;
 Thu, 07 May 2020 04:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190109223452.11184-1-niklas.soderlund+renesas@ragnatech.se>
 <20190109223452.11184-2-niklas.soderlund+renesas@ragnatech.se>
 <alpine.DEB.2.21.2004291630090.4052@ramsan.of.borg> <20200507111610.GA1598@ninjato>
In-Reply-To: <20200507111610.GA1598@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 May 2020 13:49:28 +0200
Message-ID: <CAMuHMdXMUUXkfMvEo7--MN7-fO2c7RDHuOyq2NSaWB+Lx9Bq6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: undo PM autosuspend when removing the host
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Wolfram,

On Thu, May 7, 2020 at 1:17 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > When unbinding the sdhi driver on e.g. Koelsch or Salvator-XS:
> >
> >     echo ee100000.sd > /sys/bus/platform/drivers/sh_mobile_sdhi/unbind
> >     echo ee100000.sd > /sys/bus/platform/drivers/renesas_sdhi_internal_dmac/unbind
>
> Confirmed. Happens on my Lager and M3-N Salvator-XS, too.
>
> > Removing the call to pm_runtime_dont_use_autosuspend() fixes that
> > symptom.  But that is definitely not the right fix, as doing so causes
> > genpd_stop_dev() to no longer being called on unbind.
>
> Yes. So, we agree that this commit seems correct but it just makes
> another problem visisble?

Indeed.

> I'll have a look. Thanks for the initial pointers!

TIA!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
