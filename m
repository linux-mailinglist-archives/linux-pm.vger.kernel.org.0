Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E75673A9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiGEP7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiGEP7V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 11:59:21 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AF13DE8
        for <linux-pm@vger.kernel.org>; Tue,  5 Jul 2022 08:59:18 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 15so6025817vko.13
        for <linux-pm@vger.kernel.org>; Tue, 05 Jul 2022 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU7W/SaUNwlLynUXHU1559g+E1sKkpeDnZgFm447AJ4=;
        b=RUpc5HbairS1muuAandh0K1YIz3OU+CY1bzs4MzSb9d/yXOHKExzfTTMvhjxdRoGrH
         brzzY7co1C3auBZAiVCPtPod3rgW0LVIwohOoXpsFpPcsR2TYsHiXUFJD3jKlnlZx7vf
         eSowmcatcNNChGbFwNzBc3isGsXUvaR+zL838=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU7W/SaUNwlLynUXHU1559g+E1sKkpeDnZgFm447AJ4=;
        b=JFdL06j+nlkcoI3Mna7GPnqcNCmkXsZa/9+xYWpfL4DE2YUQ09nGxKMbGCV8q/dnhQ
         JQc2WK8PUdBoAVq32Bkai/gqOjIu6M8nEiyPP1bmiOGYA8e8lzVXQdcieRy+xyHE0q7O
         tGEMI3XY91oarh/kG4uii5EeSCEaMXXZqVvpRm71gsU/3dbs34wexae01zbSJx8hYynV
         kp8LSTRvLpX5K4dAvHjGVw+fYXQF/8g+oqn7A+qVq45ov0AP/JxXMRVOXmey4gaeRXHY
         axntOSMYCyBTmYlhwqFgFyHK8JTWJpbK6b1wG+iJ1FaoYnx5ceUL1IDDv1KaJwyglz2i
         tD6Q==
X-Gm-Message-State: AJIora+aWwwG0QyiEcRwjLIOg7cO+rAUVG1nFrYE0B/+qTaxmiLNaSna
        7rtlnbhYuxw0ey3xa7K9cna0awWF0xGZrD1757ai/Q==
X-Google-Smtp-Source: AGRyM1tVxUSAm2T1Nxl7N7tWHLd/SqB3cVttIW1P+Qnp4RcyMMq977b2TfF3xiIS+RI8lj7Eq26HwnjCbDy4xYL4lEA=
X-Received: by 2002:a1f:1f84:0:b0:370:44fb:5e90 with SMTP id
 f126-20020a1f1f84000000b0037044fb5e90mr20575906vkf.6.1657036758529; Tue, 05
 Jul 2022 08:59:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220705094946.827697-1-hsinyi@chromium.org> <YsQUrXfugKT1IV75@kroah.com>
 <CAJMQK-jA-GWw=v1PGAfYBKq5KWyYXGbYk30jVx26b1HWiw5yTQ@mail.gmail.com> <YsQluCvLLRXSo3Oc@kroah.com>
In-Reply-To: <YsQluCvLLRXSo3Oc@kroah.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 5 Jul 2022 23:58:52 +0800
Message-ID: <CAJMQK-gtfCL3smM6EAm2bLsSWvuk1QzviCQ6de4k8wiphEKQHg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Ensure genpd_debugfs_dir exists before remove
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 5, 2022 at 7:51 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 05, 2022 at 07:06:41PM +0800, Hsin-Yi Wang wrote:
> > On Tue, Jul 5, 2022 at 6:38 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 05, 2022 at 05:49:47PM +0800, Hsin-Yi Wang wrote:
> > > > genpd_debug_remove() may be indirectly called from others while
> > > > genpd_debugfs_dir is not yet set. Make sure genpd_debugfs_dir exists
> > > > before remove the sub components, otherwise components under
> > > > /sys/kernel/debug may be accidentally removed.
> > > >
> > > > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > > ---
> > > > An example:
> > > > scpsys_probe() in drivers/soc/mediatek/mtk-pm-domains.c indirectly calls
> > > > genpd_debug_remove() on probe fail, causing /sys/kernel/debug/usb to be
> > > > removed.
> > > > ---
> > > >  drivers/base/power/domain.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > index 3e86772d5fac5..5a2e0232862e0 100644
> > > > --- a/drivers/base/power/domain.c
> > > > +++ b/drivers/base/power/domain.c
> > > > @@ -222,6 +222,9 @@ static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > > >  {
> > > >       struct dentry *d;
> > > >
> > > > +     if (!genpd_debugfs_dir)
> > > > +             return;
> > > > +
> > > >       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > > >       debugfs_remove(d);
> > >
> > > Why not just change this to be:
> > >         debugfs_remove(debugfs_lookup(genpd->name, debugfs_lookup("pm_genpd", NULL)));
> > If pm_genpd hasn't been created yet,  debugfs_lookup("pm_genpd", NULL)
> > will return null.
>
> And how is this codepath being called if pm_genpd is not created yet?
> Surely you are not relying on the presence of a debugfs file to
> determine that?
>

Caller didn't directly call genpd_debug_remove(). The flow is as follows:

Normally, scpsys will create pm domain by:
scpsys_probe()
   --> scpsys_add_one_domain()
     --> pm_genpd_init()
       --> genpd_debug_add()


If something fails, it will do the cleanup:
scpsys_probe()
  --> scpsys_domain_cleanup()
     --> scpsys_remove_one_domain()
       --> pm_genpd_remove()
          --> genpd_remove()
            --> genpd_debug_remove()

genpd_debug_add() checks if genpd_debugfs_dir is init by a
late_initcall genpd_debug_init(). If it's NULL, it will return
directly without creating anything. Later when genpd_debug_init() is
called, it will call genpd_debug_add() again.

pm_genpd_remove() still needs to be called on the cleanup path to free
other stuff, but if genpd_debug_init() hasn't happened,
genpd_debug_remove() should be a no-op, or genpd_remove() shouldn't
call it. (We can move the check there, but adding in
genpd_debug_remove() is more similar to what genpd_debug_add()
currently is.)

> > If genpd->name also exists under root debugfs, it will still be
> > deleted unintentionally, since NULL represents root debugfs.
> > Eg. one of the genpd->name is "usb", which is supposed to be added as
> > /sys/kernel/debug/pm_genpd/usb later. But pm_genpd is not yet created,
> > /sys/kernel/debug/usb will be removed.
>
> Ah, that's a bad name to pick :)
>
> But still, don't paper over this problem, please solve the root issue of
> never relying on the creation of a debugfs file to determine functional
> logic.
>
Currently we can't remove genpd_debug_add() called in pm_genpd_init()
and genpd_debug_remove() called in genpd_remove(). If some power
domain is created after genpd_debug_init(), their genpd subdomain
won't be registered in debugfs. genpd_debug_remove() also has similar
issues, eg. failed domain not removed after genpd_debug_init() is called.

> thanks,
>
> greg k-h
