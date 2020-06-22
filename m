Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C4203243
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 10:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgFVIkZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFVIkZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 04:40:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9152CC061795
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:40:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so18257656lji.10
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFeVIaukde5cEJYosI/nKt2dPH3w8UvOLbWUnlXHsBU=;
        b=iEGUuJhLh3+NwbCNxjkkRe9EVuTa6QWYy1pemvrk9YZZt2QLagctJEfbVbcJm3GNqL
         XdU1vFbZpQJ9MY0yMrL+JM4jrBltzKfZAMow7TO4U8iz6WgaI8qShnkMrXigDZZFvxFD
         RBeIyRDTs+ycv/eO6kZtT1jPgvH7GJzZTAARh2+PpD0kHr0BSQrlEMwIN/jE38mW6Pmo
         YWEGWjwW5DsbhEW7jBaTCQuGWx+25ofFPoeJ2n7vJPcWvNpCNABDJHi4v2Mken1RB6r6
         C9kML6zezbYAd/Hnqn1IPXNudHg0e+N4TYUl/2iU8PsJJWpYOTULbYAMymthaJOFfY7R
         idaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFeVIaukde5cEJYosI/nKt2dPH3w8UvOLbWUnlXHsBU=;
        b=uI4KBXwjb5kNrZujo/Mp2agiW0OOIETwL5DyPXgMWenYo+kNtpK7QW4j+bUQqoWHtm
         2AwW7azqbYEvelPsirmTt0dttSz6Ioc8tBV2/6IG1rRBag7euWfuPqPidc/MmrzA8ZKj
         gEFu3ncAnNMxbqoO3jua3jQbxiV6QFO32SkyhausujLNBRs/eG79FHjDP+15+tWrlALy
         z+1IxBB9LjdjHFVbomdvXQ0Uh1m800tDAmHDZplIS+smF377NealRqRmmDQ546GaUQMC
         joZwevFN5cQO2UIue50m/Xj94/0IQwRXidKDKve3kAQJW4SZWv8dD9ch5S8JfaFr0ef8
         xFlA==
X-Gm-Message-State: AOAM531t2zRGDFqzc82HD3MlkmtmEhHCZClcevqetG1Xtp1it7G3k8He
        fCuWMy5+VlK12dYgjgvPFqP+3tzyvldXlamfGzPV4w==
X-Google-Smtp-Source: ABdhPJwBhI+o3WaB0VdNYziKJq6W2qVP2mYiDJ3QR8uHR3AWB7nuaFJazUewFMpxfNUCL74ZyOyKvTbpGiVkpD6bBkQ=
X-Received: by 2002:a2e:9786:: with SMTP id y6mr7668442lji.398.1592815222900;
 Mon, 22 Jun 2020 01:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591684754.git.amit.kucheria@linaro.org>
 <bf5ca7777fbb6f5e2d374a9a72d1e17d485bd8ea.1591684754.git.amit.kucheria@linaro.org>
 <20200621071841.GF128451@builder.lan>
In-Reply-To: <20200621071841.GF128451@builder.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 22 Jun 2020 14:10:11 +0530
Message-ID: <CAP245DWL0zRuV1LXq-FqMPX3BUFqLWwMFZpGrtr+Tg7SccQctw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8250: Add thermal zones and
 throttling support
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 21, 2020 at 12:51 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 08 Jun 23:44 PDT 2020, Amit Kucheria wrote:
>
> > sm8250 has 24 thermal sensors split across two tsens controllers. Add
> > the thermal zones to expose them and wireup the cpus to throttle on
> > crossing passive temperature thresholds.
> >
> > Update the comment in the drivers to list the SoCs it supports.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi | 766 +++++++++++++++++++++++++++
> >  drivers/thermal/qcom/tsens-v2.c      |   2 +-
> >  2 files changed, 767 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > index deaa8415c7b72..5cd18cd8a675b 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > @@ -8,6 +8,7 @@
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> >  #include <dt-bindings/power/qcom-rpmpd.h>
> >  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/thermal/thermal.h>
> >
> >  / {
> >       interrupt-parent = <&intc>;
> > @@ -86,6 +87,7 @@ CPU0: cpu@0 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > +                     #cooling-cells = <2>;
>
> This doesn't apply to linux-next.
>
> The problem seems to be that, as pointed out when I submitted that
> patch, the previously anonymous "cpufreq hardware" is now replaced by
> the "EPSS" hardware block.

I'll take a look.

> So we need a new driver (or update the existing one) to support this new
> hardware block.
>
> Presumably though, without this there's not much cooling anyways - which
> is sad, as your patch looks good.
>
> >                       L2_0: l2-cache {
> >                             compatible = "cache";
> >                             next-level-cache = <&L3_0>;
> [..]
> > diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> > index b293ed32174b5..58cac8f2a358c 100644
> > --- a/drivers/thermal/qcom/tsens-v2.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -26,7 +26,7 @@
> >  #define TM_TRDY_OFF                  0x00e4
> >  #define TM_WDOG_LOG_OFF              0x013c
> >
> > -/* v2.x: 8996, 8998, sdm845 */
> > +/* v2.x: 8996, 8998, sc7180, sdm845, sm8150, sm8250 */
>
> Even though it's trivial, can you please send this through the tsens
> tree instead, so we don't end up having unnecessary merge conflicts.
>

Will do. Thanks for the review.
