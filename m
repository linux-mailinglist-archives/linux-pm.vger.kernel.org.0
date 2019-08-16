Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C904E9091C
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2019 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfHPT7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Aug 2019 15:59:45 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33164 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfHPT7p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Aug 2019 15:59:45 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so9899100otl.0;
        Fri, 16 Aug 2019 12:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0znWCL2JJCPaf78DgFnSy9/d/B/Bzcyp+w8HeYdmGmI=;
        b=DxSnSKBGO4eAioFOO33lqh/jmuo1THcJaCtP+wyxEQLflBf/74QxknqZYq9rrXi+N2
         lqspyjEvL/k9FEAn2OuHL9TYJvRvNbWagaN6HR96qq0LXyfahFVyvhBnwEDYYNNc62EC
         i/b9Irn4pFIMwsJW3J87Mh6ReAJnvJ9PYgt7QR7Kh6NfRlW1CLYqgPVAUsZgoAt1UM+c
         jcLCp5elHU7SamkxK6f/lFvJrtOz+B+67b/VRbkL4RBO8pLlE93ts8NRGGAFeqqs/tyj
         WGVJP/9rdDOEMPny9POANMoR6JNxvocEUJ7jxOLO4xrdgpzL+T61LhoQPn0JbPAw0B82
         Tjgg==
X-Gm-Message-State: APjAAAWKGFCj0oxHzUfztAUDX3v3gKwU0hJ4hIvhQmSCleNZPkPXAYhP
        iLXIWEgfeYBjcsdi/CufWZaiIEahIDXuYphCEW2bR2RT
X-Google-Smtp-Source: APXvYqwQUqy/5CXkXTlDaYElB+zhy4Vgctbg9m4vH2dQE01zadOTSabBmTjhlYATc0PSxDOFHHcoFDwpt5YZqwGvBDE=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr8916994otk.145.1565985584096;
 Fri, 16 Aug 2019 12:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190816125225.16061-1-geert+renesas@glider.be>
 <20190816125225.16061-2-geert+renesas@glider.be> <20190816180123.6299720665@mail.kernel.org>
In-Reply-To: <20190816180123.6299720665@mail.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 16 Aug 2019 21:59:32 +0200
Message-ID: <CAMuHMdVvwsXU2YwFRA2Y2K9KKzF4L-hqDudarmc-OeHXRMCifQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: renesas: mstp: Set GENPD_FLAG_ALWAYS_ON for
 clock domain
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Fri, Aug 16, 2019 at 8:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2019-08-16 05:52:23)
> > The CPG/MSTP Clock Domain driver does not implement the
> > generic_pm_domain.power_{on,off}() callbacks, as the domain itself
> > cannot be powered down.  Hence the domain should be marked as always-on
> > by setting the GENPD_FLAG_ALWAYS_ON flag.
> >
> > This gets rid of the following boot warning on RZ/A1:
> >
> >     sh_mtu2 fcff0000.timer: PM domain cpg_clocks will not be powered off
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Are you going to add a Fixes tag?

I didn't add a Fixes tag, as there's no clear point in history where the
problem appeared: the Clock Domain code in this driver predates the
introduction of the GENPD_FLAG_ALWAYS_ON flag by ca. 18 months.

Candidates are:
d716f4798ff8c65a ("PM / Domains: Support IRQ safe PM domains")
ffaa42e8a40b7f10 ("PM / Domains: Enable users of genpd to specify
always on PM domains")
075c37d59ecd4a8b ("PM / Domains: Don't warn about IRQ safe device for
an always on PM domain")

Do you think it's worth adding one or more of the above?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
