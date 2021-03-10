Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A822B333D73
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 14:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhCJNO4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 10 Mar 2021 08:14:56 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:35329 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhCJNO3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 08:14:29 -0500
Received: by mail-vs1-f49.google.com with SMTP id j12so6425172vsm.2;
        Wed, 10 Mar 2021 05:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=53hH6CSEIzCBZULTLy/0ufaoot71sUUYvZJYMTqZQsk=;
        b=kjBqV9Iz+drUkPbUiiHEgRANcyy72mEwhaV7h/ZNf25LjKPJS5d7g5WMNNmo85DEdE
         Wd2m3mpJ8jLsalWD9SEVSZOHO98vWX2B9IVGOgsbnR2sDRXos7+G9l/kpfQqds4+gK5v
         Vi1yL4n+ZT2AgvkJeQXEvEhvPe6qWO14tYCEngsO+quLAxSLgUcbZ3RBdHzwBorAjpHV
         16DCeaodZbglxndCsiqWZ4flS80548iQpOlG0/PzZqY8Zo2JtzYYORu4H8TnwGmElEvx
         iGJHueeZk1xmGR43wlIHL6k+iefkSn5u1NIYCdU6TeGgcnLiZbr0/5eYdUgcs3I3GaMv
         blTw==
X-Gm-Message-State: AOAM531KUnEyB96z9oWn1+P81lNWuPzaA+8qDBgZMiI74aes/PoCfFv6
        Vt2TneZkuhX25ibBElgoPpqYF5+SnVEyzlbbzpY=
X-Google-Smtp-Source: ABdhPJxXTFq+3iCRbvvQ2oB861mpT5qLn4uHTnoVD1B3v1h2bwafXVSu2qidRHsPHTbzghSrJTX0b6DQg4Yc2DpPQF8=
X-Received: by 2002:a67:fe90:: with SMTP id b16mr1565916vsr.40.1615382068261;
 Wed, 10 Mar 2021 05:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20210310110716.3297544-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210310110716.3297544-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Mar 2021 14:14:17 +0100
Message-ID: <CAMuHMdXJ1o5hfXKcx1OnGR2prbW0nA5+GdOUgRrS+nXD2-CNzA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Support five
 TSC nodes on r8a779a0
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 12:08 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> When adding support for V3U (r8a779a0) it was incorrectly recorded it
> supports four nodes, while in fact it supports five. The fifth node is
> named TSC0 and breaks the existing naming schema starting at 1. Work
> around this by separately defining the reg property for V3U and others.
>
> Restore the maximum number of nodes to three for other compatibles as
> it was before erroneously increasing it for V3U.
>
> Fixes: d7fdfb6541f3be88 ("dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support")
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
> * Changes since v1
> - The register layout for V3U is larger then for other SoCs, fix the
>   example to reflect this. Thanks Geert for spotting this!
> - Fix a bad copy-past in the register list in the example.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
