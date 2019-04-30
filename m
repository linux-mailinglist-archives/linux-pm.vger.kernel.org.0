Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0DF539
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 13:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfD3LPp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 07:15:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40645 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 07:15:44 -0400
Received: by mail-vs1-f65.google.com with SMTP id e207so3454224vsd.7
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 04:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSBbwzwwF7jNGcnQ7AVNOQW/kFea/OR3OycjgcD+M5c=;
        b=rqr36y92aNmQTYvCTP0FbjlLcgvOVgOIBDQwTiV31lnCFvvEh8wCoUcO64jDLLDEVY
         erRc/duAARlv2giV0RtYCNNtSSCmqITwLtB+L4/D0ucYfJzTeOIB89fcC/J2ZOZAffia
         JrkKLpnlC9Wp/ICfZhlxo3jAJq+YRQRtDZQ/0aafaMj3L3tH3gTwA8JMsEShNcWpEvbU
         AF/x1vC/l7cxkkQSdkJlKbiNVILNcykOjHmE2vL8rr2FlwozHnQquuhJRRpBH0lh71t+
         6oQhOCuBTEy9fGKd3IkepvbwFpy3ufl0kWCdkGv4N7yE8fF1UMT07z7o1d6//HstvPZ0
         CCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSBbwzwwF7jNGcnQ7AVNOQW/kFea/OR3OycjgcD+M5c=;
        b=htuIpfjDK/m4/DlTUZsVfcUl83mOch3tkXYPnKL5CGMOC1QEhCNWpUSw9Gch9hk5qy
         dAydIO3Z1quiOAHJaAs0s++ramiHeAGxIFurRvxaFzdDh+mY+Yox/Uxva/SN+xmqoAfA
         Pic47oBJaIs9lHylIyuFkiL2XGnDuf2H7JbFMlq4Re+wimkDmnEBMLfOAOxVSEF7eXwg
         EZmyYIkM5ALvI08/3Iqnac921ipIK3UPCytQ19GuGvZ36OcR7wzU23uP9zd9ZlGOefgs
         sJ4VMGwIqGEJ+n24YIT3nub+tiKgcdtwJUmopK4PVPfrTJ9uYkxmtn7PaErzLX9ADkTm
         Lq2Q==
X-Gm-Message-State: APjAAAWUKLclcWUvNfC/T5bhyrREfwf8jABerFAFC6maOr8cXV3E05Mx
        BVgWUNKNblaI2LffETOsvpxl/dPxsn3uXH6oj+tHvw==
X-Google-Smtp-Source: APXvYqwIlfZlHtUketaXOMujjHfd/qGbL3oe7HXJ7joLacYaYzlaaHb9SIRBw0nNzNuiizbcbBYifZAmFXX0o+LqXyk=
X-Received: by 2002:a67:8155:: with SMTP id c82mr5940813vsd.200.1556622943522;
 Tue, 30 Apr 2019 04:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556313614.git.leonard.crestez@nxp.com> <68ccb5a90d1d2a596e7ed94ba3245171f013c781.1556313614.git.leonard.crestez@nxp.com>
 <CAPDyKFpCCapBfNbsR1Q+nyg8aenVJWxj9qmTCCCfmONZR3t1sg@mail.gmail.com> <AM0PR04MB6434B2BBECCA6B2644CDF044EE390@AM0PR04MB6434.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6434B2BBECCA6B2644CDF044EE390@AM0PR04MB6434.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Apr 2019 13:15:07 +0200
Message-ID: <CAPDyKFr_CsHBTjAXC+g7Oxnz9WhhyhyW3BGJkr=dqkJECvsyRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Apr 2019 at 16:39, Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 4/29/2019 12:11 PM, Ulf Hansson wrote:
> > On Fri, 26 Apr 2019 at 23:38, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >>
> >> This is for power domains which can only be powered off for suspend but
> >> not as part of runtime PM.
> >>
> >> @@ -126,10 +126,11 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >>   #define genpd_status_on(genpd)         (genpd->status == GPD_STATE_ACTIVE)
> >>   #define genpd_is_irq_safe(genpd)       (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> >>   #define genpd_is_always_on(genpd)      (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> >>   #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> >>   #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >> +#define genpd_is_no_runtime_off(genpd) (genpd->flags & GENPD_FLAG_NO_RUNTIME_OFF) >
> > May I suggest to switch the name to, GENPD_FLAG_RUNTIME_ON.
> >
> > Other than that, this looks good to me!
>
> Then it's easy to confuse genpd_status_on with genpd_is_runtime_on. How
> about genpd_is_rpm_always_on?

Even better, let's take that.

Kind regards
Uffe
