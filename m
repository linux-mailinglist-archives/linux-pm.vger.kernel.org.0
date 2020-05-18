Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21851D7780
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgERLls (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 07:41:48 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35366 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgERLls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 07:41:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id o7so8701533oif.2;
        Mon, 18 May 2020 04:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqReWwa+eOXbiTkJ7H5L2JLijrqxGjQZXWkiXBXsjxo=;
        b=B0F3R1LI/yrCOe/ZwNVRl0o5oKIgF0vCcKsz2yX/nl4BdEzu0ra6ia1ABvS1bpYvFA
         bOrHXSKHItmTw1sKCMQKQUqbgY+1FxgkFiFCEBRP81eSsRAI/92RgM6LHwwSZs7KS+oi
         SFaehDsVMeaEZBfEuTqVqD48eVllQZoMs+hif2uio7JrkQicyjKvloV0BJ4NNJaQFIUF
         BYppnro0gz7141Avv8rbnmK4hZPRqajFrZXXobFJJpkanBJx/knmdJtykXUoNUIIpQrQ
         Wy3EY2CqaXzwE9tFhsmS91ka/tosZytiUqKnj9yoyb+rkGpRkb78dtQQ/gqys793LGUE
         Kt/A==
X-Gm-Message-State: AOAM533FC8GOk7mgpI0i80CSCsWMv4CT+l4Zez3fG+OiAbYbX6rLAbIp
        C4HErAtcRBMy91ZvLuFfPdUrYnEgl7Q4+4Z4AvQ=
X-Google-Smtp-Source: ABdhPJzIwYIkEvuiD2w8vDyPT9D/C6gV3A976p29r7GQ7YCcyQdXeFiyb78DlmVhOcTpbd5AuMhOO07U8ucNsiLsSZM=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr6233663oic.54.1589802107215;
 Mon, 18 May 2020 04:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1589555337-5498-16-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1589555337-5498-16-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 May 2020 13:41:35 +0200
Message-ID: <CAMuHMdWdc5P3UyDZs1BPzAXZzkhvmZM8gVSDUnJBf=-dsH=izg@mail.gmail.com>
Subject: Re: [PATCH 15/17] ARM: dts: r8a7742: Add APMU nodes
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Prabhakar,

reduced CC list
added CPUidle people

On Fri, May 15, 2020 at 5:10 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add DT nodes for the Advanced Power Management Units (APMU), and use the
> enable-method to point out that the APMU should be used for SMP support.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm/boot/dts/r8a7742.dtsi
> +++ b/arch/arm/boot/dts/r8a7742.dtsi
> @@ -18,6 +18,7 @@
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> +               enable-method = "renesas,apmu";

According to Documentation/devicetree/bindings/arm/cpus.yaml,
"enable-method" should be a property of the individual CPU nodes,
and not of the parent "cpus" container node.

However, so far we always put it in the parents "cpus" node, which works from
secondary CPU bringup, but may cause issues with CPUidle?

See also "[PATCH/RFC v2] ARM: dts: r8a7791: Move enable-method to CPU nodes"
https://lore.kernel.org/linux-arm-kernel/20190514085837.18325-1-geert+renesas@glider.be/
which so far has received no feedback from the DT or CPUidle people.

Thanks!

>                 cpu0: cpu@0 {
>                         device_type = "cpu";
> @@ -305,6 +306,18 @@
>                         #reset-cells = <1>;
>                 };
>
> +               apmu@e6151000 {
> +                       compatible = "renesas,r8a7742-apmu", "renesas,apmu";
> +                       reg = <0 0xe6151000 0 0x188>;
> +                       cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
> +               };
> +
> +               apmu@e6152000 {
> +                       compatible = "renesas,r8a7742-apmu", "renesas,apmu";
> +                       reg = <0 0xe6152000 0 0x188>;
> +                       cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
> +               };
> +
>                 rst: reset-controller@e6160000 {
>                         compatible = "renesas,r8a7742-rst";
>                         reg = <0 0xe6160000 0 0x0100>;

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
and I'll see what I will queue in renesas-devel for v5.9 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
