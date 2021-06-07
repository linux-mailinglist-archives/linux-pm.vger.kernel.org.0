Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2339D840
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGJHg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 7 Jun 2021 05:07:36 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:40739 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGJHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 05:07:36 -0400
Received: by mail-ua1-f48.google.com with SMTP id e12so6623728ual.7;
        Mon, 07 Jun 2021 02:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ree0VoIKO+hfXYOXZMiZs8kc6gzeIIbI23nwOl/Ctlw=;
        b=OwLpYpB20VEKdcK+3A7QTSkFm4OeSDhXNUQ8UKEUiRTFnDzLmkX2fGYPP67Yj7FGNw
         NjwXCQHZTGi74HRZ7yTzGAseBUW4EuCI2xSPO+onptw/kwe+E+WLuhXKru4SRsOP86vg
         C1KKy6nlyjqhY3UC2VTs2DPvGReW+isv0ujZ3pbs4sNm7Umrbh5X/2ZGOCMhNfcJ679L
         cHZDtyWHM2phmlTQafF6tWtrnNu0Cu7bCylfpEAHKXNMWazQDajWKhGOGRD2GJmrUoau
         ZwnKxpWSW7JCOc3witjJIP4xMJPs3xw4wzJ55bbHgNQ+4SPXx7USqy24jP86irhylB0Y
         MiVQ==
X-Gm-Message-State: AOAM531BnIfrghcBQBgbPY+qiHLITXjalLBcAEgdT986L6UM9fpwP3ae
        7FkbNKsZdmZe6cnCs2gya7ACsHcVGSDRmQoDVdGQMfSwUQs=
X-Google-Smtp-Source: ABdhPJxlFlvt6daPf9//UgmsAUZAtfipIdo56Po1nepptsF4Fr0WlNU+kCAcwlJ4F2qADZu5ObrDYhOGKGG2a/P3VNM=
X-Received: by 2002:ab0:2a4e:: with SMTP id p14mr755064uar.2.1623056729044;
 Mon, 07 Jun 2021 02:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210605085211.564909-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 11:05:17 +0200
Message-ID: <CAMuHMdW_PPst6VzXmzyHW5R7PzEX1zVqFzs80MV8564Wd+rQjQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix coefficient calculations
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 5, 2021 at 10:53 AM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The fixed value of 157 used in the calculations are only correct for
> M3-W, on other Gen3 SoC it should be 167. The constant can be derived
> correctly from the static TJ_3 constant and the SoC specific TJ_1 value.
> Update the calculation be correct on all Gen3 SoCs.
>
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
