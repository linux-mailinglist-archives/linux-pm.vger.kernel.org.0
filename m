Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42C92FD69B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 18:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbhATRMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 12:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403811AbhATRK0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 12:10:26 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B924C0613C1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 09:09:46 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id w24so17885767ybi.7
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPDT0PVm4/aPIbV0EAFgXlokPV1lvrypzi2ZcvT8T1I=;
        b=rFRBi4r7OH8297hz1xcaXSPUbNFKEfIqzd2Rx6NTH6Y+ffjagOVvyD11mOjKIK6B0O
         EnTvixK2CI5mbaIucjkharRIVAqkKZG5jXeLsZt8H/leQjyUZfpCU/YrMuoQYOs7zzkz
         L3qyIDLjN5iwMYQDLHDxV5/WN03ot8PPm69Pjib6KSymHmyH+aT+P9pOLSe4amUP9zgH
         CITfFpa4KGafOK3wMO9DHmi/sQr8tpA4uiCLdHLID2eCDdqnrsUfY98E2eqIgUP/aMEh
         Fp/feg0UkH6IqjyNqHlfmOLP3AmpJpT9w9xsPjzaL1gKQTdRETZyG3AN8dWBD/XddnwN
         0T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPDT0PVm4/aPIbV0EAFgXlokPV1lvrypzi2ZcvT8T1I=;
        b=Db2DT+5d6gbSDzT7JbXvNFPf0W/aUIEDC8LFhaveGgyMVvi5jIBVmfZn1VKs4Uyavd
         nriLbYNVhmXDwJo1DKo4g68KjARWos/OsWDTTWTzHlhqyadhy8a52jQZHAGf12geUFiJ
         rKcK0Z/qobHnvwIT+XoPAUWJcH2MgreaRHN5HPEhBIKZl1XYWaEWv1pJejJBN5RSJIxT
         O1+VyqXcY7/t318d12LmKjRDhsHr7dK4joW5kdnIkkx+Wf4bp3Owo5a3Vn/SvsafONet
         aW0c5Xo9wWga/NZ1kV36BOkEcjKPq2WFrqGUt6CaD+ssSKk/efAoVFZre3/euhRprZLZ
         i+xw==
X-Gm-Message-State: AOAM5309ldF15ZpPXntJxDn+E3GilRl2JC9MFJWW18rUQZQOU7p5mi82
        dwqKuot2LejCIwx1itZn92olF1Zte6PawvAe9rHXhA==
X-Google-Smtp-Source: ABdhPJwgt9Cxc/JcL4f7pl9d8H1GVMqWeXV7Rq5bFY8Gar7UAQgJ9hjlLUp5Y+jDcGNKkVZXb2EOADxVGcwvFJ6fju0=
X-Received: by 2002:a25:3345:: with SMTP id z66mr7809991ybz.466.1611162585610;
 Wed, 20 Jan 2021 09:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20210120142323.2203705-1-geert+renesas@glider.be>
In-Reply-To: <20210120142323.2203705-1-geert+renesas@glider.be>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 09:09:09 -0800
Message-ID: <CAGETcx-ZcXB9Zw_RnMjA0G2oKAyeK3VfKgha=Mvqnn_dDREuOw@mail.gmail.com>
Subject: Re: [PATCH/RFC] soc: renesas: rcar-sysc: Mark device node
 OF_POPULATED after init
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 20, 2021 at 6:23 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The R-Car System Controller (SYSC) driver registers PM domains from an
> early_initcall().  It does not use a platform driver, as secondary CPU
> startup on R-Car H1 needs to control the CPU power domains, before
> initialization of the driver framework.
>
> As fw_devlink only considers platform devices,

Correction. It only considers devices. As in, devices on all types of
busses are supported.

> it does not know that the
> System Controller is ready.  Hence probing of on-chip devices that are
> part of the SYSC PM domain fail:
>
>     probe deferral - supplier e6180000.system-controller not ready
>
> Fix this by setting the OF_POPULATED flag for the SYSC device node after
> successful initialization.  This will make of_link_to_phandle() ignore
> the SYSC device node as a dependency, and consumer devices will be
> probed again.

It'd still be nice if you could (maybe in a later patch), at least
probe all the power domains that aren't really needed this early.
Using the driver core framework (when it's possible), gives you nice
things :)

+Rob. I know he hates people using OF_POPULATED, but I think this case
is reasonable and want to make sure he's aware of this.

Once you fix my commit nitpick, you can add:
Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/soc/renesas/rcar-sysc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
> index 9b235fc900273405..a00bb098e1fe7488 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -439,6 +439,8 @@ static int __init rcar_sysc_pd_init(void)
>         }
>
>         error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
> +       if (!error)
> +               of_node_set_flag(np, OF_POPULATED);
>
>  out_put:
>         of_node_put(np);
> --
> 2.25.1
>
