Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9FA2814AA
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 16:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJBOIJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 10:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBOIJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Oct 2020 10:08:09 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F14F207DE;
        Fri,  2 Oct 2020 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601647688;
        bh=+3VAWIyE736i8QJoJWyBkDl46THgUH5Y4ZYxc7rww6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YS1CG4Oq4huZaIu8Ij+hCQ8yMeyS36kpM3ri/SpDmf7c/4ohOYavdzjqQINHrtMh8
         S5TM/P/23W3g2UnzrPxSe2Cntf/zAVfCMhcH9eXkTdMJNNfMdIo/WYFPRCIjCth4PB
         eR0N9LtyPPEpeKWJA/sR5JRvkpq+rlfyzILcDgr4=
Received: by mail-ot1-f51.google.com with SMTP id m13so1437744otl.9;
        Fri, 02 Oct 2020 07:08:08 -0700 (PDT)
X-Gm-Message-State: AOAM531bQPWfd7wgP9QFVIN1VvpxAL30hBz5JwGPdvepdcwGWXdfPvu0
        4Mu3d4ctwv3QVkGCP+HNiTLUxBF0u44Jwbp5lg==
X-Google-Smtp-Source: ABdhPJyhESEM7l1n2tIx5F0cvgikaOZ2/i+MUqha3K8do3Q2vmEsuhRy0a+dFZdN8iCN+3dCIkrbCldSgjZJebzgVBg=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr1914471otm.192.1601647687409;
 Fri, 02 Oct 2020 07:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
In-Reply-To: <20201001225952.3676755-1-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Oct 2020 09:07:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
Message-ID: <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 1, 2020 at 5:59 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> adding all top level devices") optimized the fwnode parsing when all top
> level devices are added, it missed out optimizing this for platform
> where the top level devices are added through the init_machine() path.
>
> This commit does the optimization for all paths by simply moving the
> fw_devlink_pause/resume() inside of_platform_default_populate().
>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 071f04da32c8..79972e49b539 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -501,8 +501,21 @@ int of_platform_default_populate(struct device_node *root,
>                                  const struct of_dev_auxdata *lookup,
>                                  struct device *parent)
>  {
> -       return of_platform_populate(root, of_default_bus_match_table, lookup,
> -                                   parent);
> +       int ret;
> +
> +       /*
> +        * fw_devlink_pause/resume() are only safe to be called around top
> +        * level device addition due to locking constraints.
> +        */
> +       if (!root)
> +               fw_devlink_pause();
> +
> +       ret = of_platform_populate(root, of_default_bus_match_table, lookup,
> +                                  parent);

of_platform_default_populate() vs. of_platform_populate() is just a
different match table. I don't think the behavior should otherwise be
different.

There's also of_platform_probe() which has slightly different matching
behavior. It should not behave differently either with respect to
devlinks.

Rob
