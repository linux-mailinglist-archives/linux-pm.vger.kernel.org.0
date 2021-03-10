Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD13339B2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 11:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCJKLr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 10 Mar 2021 05:11:47 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:37405 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhCJKLn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 05:11:43 -0500
Received: by mail-ua1-f51.google.com with SMTP id d3so5586788uap.4;
        Wed, 10 Mar 2021 02:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vv+IhGQqOwrZwR8YmDLebZP3NhYU/Y7gNKwVOPMZ9Pk=;
        b=pGAyk4ub32ynVv6qpIi9TAIEnJ2t4cK0Jc00UaoDWfZ3Ybpk1+SFNw96l84sgZhxL/
         6Iib1praF0Z2UKTGoCCtEwan4Dp+K62c3Go/ckJJ838xui+QUO9WzSgXPw/gV2nfjuzp
         TAxbjN3aEDRJtPuBgmhlfR2SYd9Pyre7ftmWVwNtkBRScbvJIdLw9ozMu2lfj7jyCYs6
         wzzeiRzIoidk8KrTMMD+cUhz41ti9cwKxc+/+PnMjHoh1koPjHBJouprtN3a4so+n7g0
         qINWhQoAR6/0I8/reomUsSv0qEM9UxicNj/oIofbOjNlQx+wweFbyHiXe7mcP2Kv+vHX
         oDmQ==
X-Gm-Message-State: AOAM533cY/l5IHKXucHzUnM/IUq+DErOZUWmCV4fhwdjgAetVcYl/LGB
        iCvKtQKpYneLBIlpyKpQO9K8gm6Tb6AqEqJxPJvSioLb
X-Google-Smtp-Source: ABdhPJyuEmL5cUU1NWZHjoxUevh5V6Ga6CzUQIVNbwqNxUUguBO/6ED2XjSfgC9drurniSfBPa5jT0xtfS6LnfD2KEM=
X-Received: by 2002:ab0:3c8:: with SMTP id 66mr1153377uau.4.1615371102896;
 Wed, 10 Mar 2021 02:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210309162419.2621359-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Mar 2021 11:11:31 +0100
Message-ID: <CAMuHMdUwbeF1fbCAT0AzKUJ=XabTX4JL6yRNk3ydqq+n3-OZNA@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Add support for up to five
 TSC nodes
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Mar 9, 2021 at 5:25 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Add support for up to five TSC nodes. The new THCODE values are taken
> from the example in the datasheet.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -60,7 +60,7 @@
>  #define MCELSIUS(temp) ((temp) * 1000)
>  #define GEN3_FUSE_MASK 0xFFF
>
> -#define TSC_MAX_NUM    4
> +#define TSC_MAX_NUM    5

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> @@ -68,6 +68,7 @@ static const int thcodes[TSC_MAX_NUM][3] = {
>         { 3393, 2795, 2216 },
>         { 3389, 2805, 2237 },
>         { 3415, 2694, 2195 },
> +       { 3356, 2724, 2244 },
>  };

I cannot comment on the actual values, though.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
