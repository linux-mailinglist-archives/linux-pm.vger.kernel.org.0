Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF84C8FE6
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiCAQOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 11:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiCAQOn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 11:14:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D402B3B29A
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 08:14:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cm8so22691853edb.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zB17C2H8amzm3lE/3Osytk3n5h0zezXc46JIi36Gcp0=;
        b=gTUU0hsxwZ5ymtXgkL7PxDzn2ErgH0cpNuz+LeUA3f5f1EIhiK3lshcpf8jqLKeoC5
         //ZgjeAXJgZQwJejKAnTX3iMhdwCPjNgjvuEPogc47i6sBqYXt4AOydXcC7nMtdPs8yu
         cJgp+m9VrT0N4m0zxCPCb3aRnl/zgFy4P1EiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zB17C2H8amzm3lE/3Osytk3n5h0zezXc46JIi36Gcp0=;
        b=YZ1g22ZQDTXjqEUsKCX65jvbE7QvanDaJX7uCnYZ/FJUA1m3i0q2sJqT2pQ2Lx+ZqZ
         /qqpJZWfCNps1mset/GGcsnd42qzvlafgJf9lQ741cDfB5kvmLijBhCTuITTps7XamAI
         A2kvL24BBw7tpC0X6yI7DGdNb9AdEMWRVwYKlt8vpNETmLpyO3KOTcvCdmr2gb4nX1J8
         K6qJQc1plKqu76Nhe07jw2gCbUWCj1ra2Q87qtTzYlrbgd1ccbqrP7CDb60NlAH66cxu
         bHZu8nfhCB15dApmvtd0raqC9rPZPSvQm/5IAfpCLWEIO/aWyLSQ5W/vnGTQ91BBJG0u
         WCLA==
X-Gm-Message-State: AOAM531FgOdYNamXgKy6M7cbfcdG6bZt4eQoPePn4wROMpaFGckPslWp
        NxnoCEZmgh7IYNF7vynXEzY8H0NMZLnH5JJE
X-Google-Smtp-Source: ABdhPJxJrjL6EIHN659hd4tnrCSRTqVGWmsljFQYXHcwjN25xGxYqa6KlQW4tVsoCHYgPbVj7AftVg==
X-Received: by 2002:a05:6402:5c9:b0:412:e7f8:81c3 with SMTP id n9-20020a05640205c900b00412e7f881c3mr25840734edx.386.1646151240060;
        Tue, 01 Mar 2022 08:14:00 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm5440322ejo.195.2022.03.01.08.13.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 08:13:59 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id m6so4096707wrr.10
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 08:13:59 -0800 (PST)
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id
 g10-20020a5d64ea000000b001ea81486b97mr19504763wri.679.1646151238740; Tue, 01
 Mar 2022 08:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
 <CAPDyKFrDncw0D2ccw9GJS+oRdm2kROJh25OV9pMs+992vQV-cQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrDncw0D2ccw9GJS+oRdm2kROJh25OV9pMs+992vQV-cQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Mar 2022 08:13:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XxCMMLAyfnf=MBu--Fkcjxza6603deCA-dOCCXKeX7uQ@mail.gmail.com>
Message-ID: <CAD=FV=XxCMMLAyfnf=MBu--Fkcjxza6603deCA-dOCCXKeX7uQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Mar 1, 2022 at 2:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 23 Feb 2022 at 17:35, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The PM Runtime docs say:
> >   Drivers in ->remove() callback should undo the runtime PM changes done
> >   in ->probe(). Usually this means calling pm_runtime_disable(),
> >   pm_runtime_dont_use_autosuspend() etc.
> >
> > From grepping code, it's clear that many people aren't aware of the
> > need to call pm_runtime_dont_use_autosuspend().
>
> Well, I admit it's good practice that they should take care of this.
>
> However, it doesn't really matter to keep the autosuspend turned on
> when runtime PM becomes disabled, I think. When the driver gets probed
> again, it will most likely call pm_runtime_use_autosuspend() again,
> which should work fine, right?
>
> >
> > When brainstorming solutions, one idea that came up was to leverage
> > the new-ish devm_pm_runtime_enable() function. The idea here is that:
> > * When the devm action is called we know that the driver is being
> >   removed. It's the perfect time to undo the use_autosuspend.
> > * The code of pm_runtime_dont_use_autosuspend() already handles the
> >   case of being called when autosuspend wasn't enabled.
>
> Hmm, I am hesitating to extend devm_pm_runtime_enable(), as it
> currently makes it look too simple to turn off things at ->remove()
> for runtime PM. While in fact it's more complicated.
>
> A bigger problem, for example, is that a driver calls
> pm_runtime_put_sync() during ->remove(), relying on that it actually
> ends up calling its ->runtime_suspend() callback to turn off various
> specific resources for the device. And in fact there are no guarantees
> that will happen - and when it doesn't, the next time the driver's
> ->probe() runs, things are likely to be really screwed up.
>
> To cover this case, one could use the below code in the ->remove() callback:
>
> ...
> pm_runtime_get_sync();
>
> "turn off resources for the devices - like calling
> clk_disable_unprepare(), for example"
>
> pm_runtime_disable();
> pm_runtime_put_noidle();
> ...
>
> In this example, it would be too late to call pm_runtime_disable()
> through the pm_runtime_disable_action().

In the example you're listing above, though, you can't use
devm_pm_runtime_enable() anyway, right? If you have a reason not to
use the devm approach then that's fine and this patch won't affect
you. However, if you're using devm_pm_runtime_enable() already then
there should be no downside, right?

Though I'm by no means a Runtime PM expert, I think the most common
use case might be when a driver is kept simple by _rely_ing on
CONFIG_PM. Certainly folks have debated about this in the past, but at
least for a set of drivers where nobody has a need for running them
without CONFIG_PM they can be kept simpler by relying on it. When you
do this, you don't need quite as many machinations with regards to
playing with power management when runtime PM is off. You can
basically just enable runtime power management and assume that the
runtime resume / runtime suspend will do the work of powering you,
right?


-Doug
