Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB02A1F3F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 16:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAPqX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgKAPqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2020 10:46:23 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583FC0617A6;
        Sun,  1 Nov 2020 07:46:22 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so12313931ljk.1;
        Sun, 01 Nov 2020 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zX46IfLHwd4bVoupLB6sliJ0B4O7hy7KdEbX/qvcK38=;
        b=FvaV3k/iAAAahR7wKtbjzKXlSim0muqkBdvJvHwv/0IIFwQRudzdQlH9IdfJZVOjOl
         r3Jo6Q93z1tAKN/yKZCBc0wW/F8R8/O5q7j0W5lP12mcNwzcZQ9SoMhcyN/WXWjLVjt1
         V4+e8teKvWL1ODkjecjER+hnfGIz8FhHruhl2bgy3NlX3x9LIUhJnTY6VBY8Yz91gw9V
         PIshrFEljey44MIr1BXLmgNEdhlLP52AcHDoCQspEVJfIFtyaARFrM5XTwGvIZU9mOeh
         aRLbzhaW4Dtg2FN2Qmg5v1o9kyNP3yADJlDuVoUqgUi+2NdVfcvGvY5t81UwDUVAQ5PE
         oPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zX46IfLHwd4bVoupLB6sliJ0B4O7hy7KdEbX/qvcK38=;
        b=a9gN+fGSt/bwilD8cglRLauPXqnughrwwvLrWVaxZ7Gj64afpmoEsDD71IJC2yYX+R
         bpAibZtbgXtjqMuoidKp3FUKZLBbQ8URrqM6CKzRC06hBgNsdZKGCkmo7ssUtSrr5Jnk
         Zlmb9+hRLu99I0hqEOGFNgN+zxgbIxP4FMB2w8R3Evr4raN8bsr0zQplNNAH5nBST5CF
         F3LQpBsZZ9NUgbqgL1j2FCaTLHLERgl2aHChj20/WOd666NdLUQ+SOsT6aKk4YpgCv49
         s8QqIX9xU4+5Q43+2vwt0EFc64/uvIHF1PekE6IPpcRCYFxCX+tsl5hSevXne7bzrVFY
         5f2w==
X-Gm-Message-State: AOAM532FcPWlycSSPP7xaxXtrp/wn13FPqNAKRv5sf5FGmKUGzqI8yN8
        DvRHdeiZnGSmuLTNQf5b++NQ1T5t8QTDOYso1xI=
X-Google-Smtp-Source: ABdhPJxzkjtgFTFxQMQNdXV5G23QSL6dVE5OHZJB58MRUFp9ulnEvauc2OTiPFtT45bMx0Sr7cgnObAiG7CtycCqcqg=
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr4646697ljj.271.1604245580967;
 Sun, 01 Nov 2020 07:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-52-digetx@gmail.com>
 <CAGTfZH2rBaWKox9nKM=_Wz8k65FLt1R7D8xSOUxe7xAJ1A00hA@mail.gmail.com> <961863f7-933d-d455-cd5d-99bab898ee75@gmail.com>
In-Reply-To: <961863f7-933d-d455-cd5d-99bab898ee75@gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Mon, 2 Nov 2020 00:45:44 +0900
Message-ID: <CAGTfZH1d0t_Cp7J5LNntCPMNrkDDzwqDz3knJ6XpR0+qTD4HbA@mail.gmail.com>
Subject: Re: [PATCH v6 51/52] PM / devfreq: tegra30: Support interconnect and
 OPPs from device-tree
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On Mon, Nov 2, 2020 at 12:24 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.11.2020 17:44, Chanwoo Choi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi Dmitry,
> >
> > On Mon, Oct 26, 2020 at 7:22 AM Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>
> >> This patch moves ACTMON driver away from generating OPP table by itsel=
f,
> >> transitioning it to use the table which comes from device-tree. This
> >> change breaks compatibility with older device-trees in order to bring
> >> support for the interconnect framework to the driver. This is a mandat=
ory
> >> change which needs to be done in order to implement interconnect-based
> >> memory DVFS. Users of legacy device-trees will get a message telling t=
hat
> >> theirs DT needs to be upgraded. Now ACTMON issues memory bandwidth req=
uest
> >> using dev_pm_opp_set_bw(), instead of driving EMC clock rate directly.
> >>
> >> Tested-by: Peter Geis <pgwipeout@gmail.com>
> >> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/devfreq/tegra30-devfreq.c | 91 ++++++++++++++++--------------=
-
> >>  1 file changed, 48 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra=
30-devfreq.c
> >> index 3f732ab53573..1b0b91a71886 100644
> >> --- a/drivers/devfreq/tegra30-devfreq.c
> >> +++ b/drivers/devfreq/tegra30-devfreq.c
> >> @@ -19,6 +19,8 @@
> >>  #include <linux/reset.h>
> >>  #include <linux/workqueue.h>
> >>
> >> +#include <soc/tegra/fuse.h>
> >> +
> >
> > This patch touches the OPP. Is it related to this change?
>
> Yes, this is needed for the dev_pm_opp_set_supported_hw().

OK.

>
> >>  #include "governor.h"
> >>
> >>  #define ACTMON_GLB_STATUS                                      0x0
> >> @@ -155,6 +157,7 @@ struct tegra_devfreq_device {
> >>
> >>  struct tegra_devfreq {
> >>         struct devfreq          *devfreq;
> >> +       struct opp_table        *opp_table;
> >>
> >>         struct reset_control    *reset;
> >>         struct clk              *clock;
> >> @@ -612,34 +615,19 @@ static void tegra_actmon_stop(struct tegra_devfr=
eq *tegra)
> >>  static int tegra_devfreq_target(struct device *dev, unsigned long *fr=
eq,
> >>                                 u32 flags)
> >>  {
> >> -       struct tegra_devfreq *tegra =3D dev_get_drvdata(dev);
> >> -       struct devfreq *devfreq =3D tegra->devfreq;
> >>         struct dev_pm_opp *opp;
> >> -       unsigned long rate;
> >> -       int err;
> >> +       int ret;
> >>
> >>         opp =3D devfreq_recommended_opp(dev, freq, flags);
> >>         if (IS_ERR(opp)) {
> >> -               dev_err(dev, "Failed to find opp for %lu Hz\n", *freq)=
;
> >> +               dev_err(dev, "failed to find opp for %lu Hz\n", *freq)=
;
> >
> > You used the 'Failed to' format in almost every error case.
> > Don't need to change it.
> > (snip)
>
> Good catch, thanks.



--=20
Best Regards,
Chanwoo Choi
