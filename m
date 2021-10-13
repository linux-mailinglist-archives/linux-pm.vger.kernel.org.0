Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCD42C119
	for <lists+linux-pm@lfdr.de>; Wed, 13 Oct 2021 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhJMNPC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 13 Oct 2021 09:15:02 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:44816 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhJMNPB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 09:15:01 -0400
Received: by mail-ua1-f53.google.com with SMTP id e7so4306689ual.11;
        Wed, 13 Oct 2021 06:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SZTU9qsAIjc2ntHEHyUQbLyl8RJJnU6CIgwJ1rDx2bM=;
        b=eIQ5uakWBEa+AjRNAUKhho2bvjMyvqIFakICvswTlgN795ULLUJcE+Z/LQJMbb0pjD
         8M0kxtCV9Mifd0giZ3xgz0J/lQdAeB2AsG2SQjQySJBaEDAPsDikHMooBxHF3n3f236J
         gmOOkBVtIZB0Mqr2qIYPiKAyeHOyVPGtA7j5Z4K2WaO2A9ehvh5wDdq3DZU8Kh8idS6Q
         wxltCgRS9ww+VJmezp5VkUFkzWZRVg59ZRA6j3f1aQbGYb2rswsnqy7DHIVFEOCm6Iqx
         vfk8110aedy3nEL8RoVQ7kr/DZSRoI4935R1HGpoIvHjjK4XYKdZrbUGFEOEsJtc76vF
         I5uQ==
X-Gm-Message-State: AOAM5318v6nj+riC3KtGU0XCo/DurdslxFibxGIogWwy1QsaWHB3s0B0
        GQ7ZJ7aF0OohmVqYgqjAlwxD7C5vq7fTp8sEfuQZBDri
X-Google-Smtp-Source: ABdhPJwFae4VkdKxJTeSvz1bstTiQw++i/JCBnr6GWGlh9/NZ1+HhquBjDaf8S+Tniu2/ZbV1s7C7n6LsJ31ZkLZOHg=
X-Received: by 2002:a67:d583:: with SMTP id m3mr38211683vsj.41.1634130778319;
 Wed, 13 Oct 2021 06:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211011225802.11497-1-niklas.soderlund+renesas@ragnatech.se> <20211011225802.11497-2-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20211011225802.11497-2-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 15:12:47 +0200
Message-ID: <CAMuHMdWzXYf_sjSU+d1nSCWycJskhmZKs=RQQwoLpKAC8Nb5MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: rcar_gen3_thermal: Store thcode and ptat in
 priv data
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Oct 12, 2021 at 12:58 AM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Prepare for reading the THCODE and PTAT values from hardware fuses by
> storing the values used during calculations in the drivers private
> data structures.
>
> As the values are now stored directly in the private data structures
> there is no need to keep track of the TSC channel id as its only usage
> was to lookup the THCODE row, drop it.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since RFT
> - Keep thcodes array static.

Thanks for the update!
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
