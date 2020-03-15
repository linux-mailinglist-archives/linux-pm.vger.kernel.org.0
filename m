Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B82185B93
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 10:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgCOJjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Mar 2020 05:39:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42325 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgCOJjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Mar 2020 05:39:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so20816665qkg.9;
        Sun, 15 Mar 2020 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zle+AXTHHc8jvGKTvm1/uLrZYjwwT5iLZONbBDLgdjI=;
        b=deZEA2cqlVslAyUp+XM9hrPXQGjNqXuxdRJ6RRNrUQWpLbIyqe7GDsg3lh5uhO8bZL
         UHuM7rATjvPvJAUiTxA/2hV3MdFJoVO8HDBK5Lca3B7x2XxagObGG9agvkk3PnzUNXvF
         2PI1wDsjxK5yIyojKkThAAoahTcEePAeabUhKkqwKzoAvSkHAu6rzWrB5TxYUEhbiYf3
         d0BaFjmdKxV7lUvBpJyamB9vYekCd9FsJe0k0SpuyEN78rlPn3wpaFztM7+Ravt0qXst
         JiUGVzGHlwDN1k06ekqf93AX0ku07JXppoR9XF4fbS0Um8Bc2Z0aHL+qYYGd4B0Gm738
         oiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zle+AXTHHc8jvGKTvm1/uLrZYjwwT5iLZONbBDLgdjI=;
        b=K3yr9nfmhQH/pmI5dGIJHxZB+MTdv2KDjltQ5vE//3MFkzxVlhbi9FZllr/SxiF52b
         e4OgiexoekuoVNrgDqwiaAxCn7cZNR86oLteonGKRpd6+7XG63dfyztGij21TLvkAwO5
         dZnReXatIk1CTROXQXNBjwyVkUyXL9WImJesQFF7s9dBI9QT0eJdg9s9ndoiwGm7iWsL
         DDpfpHi9VFgqjLRjrpZ7aO4j6NQgRlUav+ukl6QD2IqKIN95X+iB3ORikNjONAFOah/9
         Nvw+kWYhad14EhtCgUKSlH0oEX9PkvsrwhrvKJTrmjKOZccjCO+8S0YLlEtAPd4VJuAq
         9vBw==
X-Gm-Message-State: ANhLgQ04unS/nlQ6XcpJv9JEpn7hgP0hiGxbmebLzGs1OxWutubYGWU4
        hsL58aA51ZALfb/NWuTRCL6T62w0sB3+IlnpXa4=
X-Google-Smtp-Source: ADFU+vuJPHfHU6s1UseuEr7Inqsk7XkYeVKkmL/siV5j8Bz3dKiby8xbiNRLCy60RE2b7R3GhofRw+cidTKfuDh3YHE=
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr14353887qkh.395.1584265145009;
 Sun, 15 Mar 2020 02:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200313214552.845-1-robh@kernel.org>
In-Reply-To: <20200313214552.845-1-robh@kernel.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 15 Mar 2020 17:38:53 +0800
Message-ID: <CADBw62oL5hhw12bSAFv7Jnx39stXFeEuTMZ3hWvMCRKpt2vgXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: sprd: Remove redundant 'maxItems'
To:     Rob Herring <robh@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 14, 2020 at 5:45 AM Rob Herring <robh@kernel.org> wrote:
>
> There's no need to specify 'maxItems' with the same value as the number
> of entries in 'items'. A meta-schema update will catch future cases.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@verdurent.com>
> Cc: linux-pm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks Rob.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  Documentation/devicetree/bindings/thermal/sprd-thermal.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index 3bfe05504456..058c4cc06ba6 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -31,7 +31,6 @@ properties:
>        Reference to nvmem nodes for the calibration data.
>
>    nvmem-cell-names:
> -    maxItems: 2
>      items:
>        - const: thm_sign_cal
>        - const: thm_ratio_cal
> --
> 2.20.1
>


-- 
Baolin Wang
