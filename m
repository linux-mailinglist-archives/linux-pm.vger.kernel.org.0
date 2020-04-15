Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76D21AA950
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633930AbgDOOAn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 15 Apr 2020 10:00:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44279 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633864AbgDOOAl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 10:00:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id o25so13482623oic.11;
        Wed, 15 Apr 2020 07:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LLkurERwPqup0U06ZSkreXeLskweCKS6mJwG3ZnhpC8=;
        b=kKi5hIYdYZENld8RAV2ADFMjK8I6cwqpHkMjZKROfjQG6gAF2989Sg2MWU+CxiscDh
         TOVaUhBzw1ZxCLv792smLy4vL6/m51i9qnhCVpqluRv9ZmkZxxuaMqRbLR8NuqFTuqWq
         lJx5MWcqfZ49wh53vU70q6jJBxlbkmSVVHtz8jWqKcnuFdKUHYYS9oB2+q8OzY914fiY
         jcvgZOI/h9SFfLFVCnUKBGc0cieIV0jsZWF10vzl442oG6RyEjH/ykMMo1WXLO9TGSme
         4g/29d4bDFQAzTxKan2Rzq3ghrPl7G6YiwJZtDYUaUtXDN5LYJl3gKsIdw+ygv7hxwAp
         tmrA==
X-Gm-Message-State: AGi0PuYw3uabWvEL0URRe3bA8c4n5kUl9wO3YYXG1GauFUjwI6lGNa/C
        hZ+DokMTv7TtESc1A31m/f3ycWjfZJwQXESrhK77TEiv
X-Google-Smtp-Source: APiQypJZSNfOtMzStekV30aR4PWnFiXUrZgHZKLGs0Qhj3g/g5DRmWjolGUwdRYrVoNcGSRspNdndWqwnqTPJk6OYZY=
X-Received: by 2002:a05:6808:8cf:: with SMTP id k15mr8390047oij.54.1586959239624;
 Wed, 15 Apr 2020 07:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200411092719.1170489-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200411092719.1170489-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Apr 2020 16:00:28 +0200
Message-ID: <CAMuHMdU5E3kLrn=dGCfpUD8+CS8NvcnD2PjnJERvKbytf8ggow@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Convert
 bindings to json-schema
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Sat, Apr 11, 2020 at 11:27 AM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Convert Renesas R-Car Gen3 Thermal bindings documentation to
> json-schema.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a7795-sysc.h>
> +
> +    tsc: thermal@e6198000 {
> +            compatible = "renesas,r8a7795-thermal";
> +            reg = <0 0xe6198000 0 0x100>,
> +                  <0 0xe61a0000 0 0x100>,
> +                  <0 0xe61a8000 0 0x100>;

Examples are build with #{address,size}-cells = <1>, hence please use

    reg = <0xe6198000 0x100>, ...

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
