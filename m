Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4D16DF8
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 01:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEGXyH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 19:54:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39601 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfEGXyH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 19:54:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id f1so354956lfl.6
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QNaGI2GD35FNHKpaisMd7Mb++bashXvi1hqDDOr6Y20=;
        b=qTYA5JC2UtqQi1Puhr92FNgpB5llHarohMUSh7nKWbLR074m0i0U3ykD0Kimw8LIGJ
         VHamCvN8DpC1iO2PQOOrSBVtRjytiIbz/aELoB/0QwATQu+SH8+OJk+t7C4ou4PFLySm
         NADosKT1RWMXouX8XisFkCRonZ5QMDdjlknvP4EafRwA0ah3c7p9tCHU4DQgHtuo9Daz
         cQMwpUFCRaFjqwoQPF76azpyL+5nAmPhwIrJ/Nj7lty0/YG6SauqQcElftx04XFUEjhc
         G21iLOmF7nA9mjIwraqo9+n6tjrPeKg/BRjMkY8gHJVjhEiL0ZTPHchRSP4AeGrVI4ae
         cVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QNaGI2GD35FNHKpaisMd7Mb++bashXvi1hqDDOr6Y20=;
        b=hDAznFayLFlhmHb7cJ72ru0CKk+gG/KE/3jUWILhnSXEaXtK+h4Qzqm96JvlpF/Xkl
         TLza2b/p4SOX2DlaJRfithLNm61fnWHZbZQjKcCmHfHwO5pLzFBkklxfbhRnEiezbp6z
         vxur+8egKivFoTI7pwMN4LmV6rMM/1c7NslzV6gezFkm0SBWikEB7YKOaI2pVo18P/TL
         tVtW5hUIqH/XxSBaBcB+5r6MFVZpNu3rJ8v3T8xZD9ii+YHgiDClIXJwP72fZLEnT4Em
         6bvxOti3ELZmKNqUX9hAU//jsJ23JqJEAU3g/Civrx6ciW4f8DPpgyo0i8AHvOKvdgB8
         8E7A==
X-Gm-Message-State: APjAAAXM2OTXy5JFYEEf7vFdcr/jl3QFTv5LqrV4bv0efxDfT7F4ZYMw
        sOdOKpFvgysXQVRv8A8oSiXz+g==
X-Google-Smtp-Source: APXvYqydoAUVbppS2HV4ZpYsr3VsJCICRDmG0N4Q6P6HR2w9HSV1Zh4qeo5wt0jD10HXiGeF/TUbPw==
X-Received: by 2002:a19:f243:: with SMTP id d3mr17540768lfk.168.1557273245412;
        Tue, 07 May 2019 16:54:05 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id j19sm3594338lfj.52.2019.05.07.16.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 16:54:03 -0700 (PDT)
From:   "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
X-Google-Original-From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Date:   Wed, 8 May 2019 01:54:03 +0200
To:     Jiada Wang <jiada_wang@mentor.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms+renesas@verge.net.au,
        geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
        marek.vasut+renesas@gmail.com, kuninori.morimoto.gx@renesas.com,
        hien.dang.eb@renesas.com, fabrizio.castro@bp.renesas.com,
        dien.pham.ry@renesas.com, biju.das@bp.renesas.com,
        erosca@de.adit-jv.com, george_davis@mentor.com,
        joshua_frkuska@mentor.com
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190507235403.GA24112@bigcity.dyn.berto.se>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424051145.23072-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jiada,

Thanks for your patches.

On 2019-04-24 14:11:43 +0900, Jiada Wang wrote:
> There are issues with interrupt handling in rcar_gen3_thermal driver.
> 
> Currently IRQ is remain enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> triggered but not able to clear IRQ status, thus cause system to hang.
> 
> Since the irq line isn't shared between different devices,
> so the proper interrupt type flag should be IRQF_ONESHOT.
> 
> This patch-set fix these interrupt handling retated issues.

I really like this series, nice work.

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> ---
> v4: remove 'spinlock_t lock'
>     add Fixes tag in ("thermal: rcar_gen3_thermal: fix interrupt type")
>     fix typos in ("thermal: rcar_gen3_thermal: disable interrupt in .remove")
> 
> v3: fix to use correct code base
>     remove unused "flag" variable in rcar_gen3_thermal_irq
> 
> v2: use irq type IRQF_ONESHOT instead of IRQF_SHARED
>     disable interrupt in .remove
> 
> v1: initial version
> 
> Jiada Wang (2):
>   thermal: rcar_gen3_thermal: fix interrupt type
>   thermal: rcar_gen3_thermal: disable interrupt in .remove
> 
>  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++----------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
> 
> -- 
> 2.19.2
> 

-- 
Regards,
Niklas Söderlund
