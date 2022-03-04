Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741FE4CCA6A
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 01:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiCDAFp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Mar 2022 19:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCDAFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2022 19:05:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7CCECB2E
        for <linux-pm@vger.kernel.org>; Thu,  3 Mar 2022 16:04:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w4so6161175edc.7
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2022 16:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZhufTpqT+5isQeXv5BFMiydi/kBXzIUJ82mZUo2gkg=;
        b=J0JKSjlKnAiSdcvPuHcxdiz8X/ziS3bofSLzgvGXNSdxY6MSJSWzfCrJxHo8GE5yLO
         HC4J3t+Gn23Dm+Ih40L/lKMFXrQey9suI9noqRnYuDAdr8P+vZRX1dyxCYN782/lDx84
         iFoOgTWvEYBK9wn4os/FSjWZgeu7+kiFEemlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZhufTpqT+5isQeXv5BFMiydi/kBXzIUJ82mZUo2gkg=;
        b=0g0w+l5m01qu6/PA52DlmdZdvrpa/LecuydeoIa0nPMrtJPsDqA1bkt8JlXJ2klR3j
         awzTBVfb3vVRC0gYYoBx3zSGZbgfBlXTexZ0n5OJhUDnIYfFkLGNhvo8RgLDXAKstbC/
         IUYxiXH5fXr7hquedanK44dPBPuWUkBAKxIO0EXbMt7zjlJW73hdcN+ebtkhLVCQH7H9
         9YEgn/i8V7GrHmGk9wl+kb2gbCsWahbXZqFs77BPtBSXmzHgQoXlkLY2VBpjUZa5MrBe
         EUZf38Sb2nnZ+tbr1WTm/URcIcZ/8oQRF3pbeAYWvHz/QlHGRkfXiBPmeuFaooIACTFd
         SOBA==
X-Gm-Message-State: AOAM53288psyv5hy9Gw8XA9GnAxxwX3rZvKTrYWesZWCM4bxRYh/UASF
        R10zK0jnvhKjc/+UlQz+S1pxi82O9NFGig==
X-Google-Smtp-Source: ABdhPJzKy5YwZiGCptt1oH4tU/x7COwn0HwdE1NYvJDd9lkWHvnZrBaoPnNQM4Dv351AsIGOzrNSbg==
X-Received: by 2002:aa7:c446:0:b0:410:9a8e:9b85 with SMTP id n6-20020aa7c446000000b004109a8e9b85mr36435923edr.319.1646352296065;
        Thu, 03 Mar 2022 16:04:56 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id fd16-20020a1709072a1000b006d90b4c029asm1174352ejc.28.2022.03.03.16.04.54
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 16:04:54 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so1334408wmq.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2022 16:04:54 -0800 (PST)
X-Received: by 2002:a7b:c0c1:0:b0:385:be1b:e6a with SMTP id
 s1-20020a7bc0c1000000b00385be1b0e6amr5595603wmh.73.1646352294058; Thu, 03 Mar
 2022 16:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20220223083441.1.I925ce9fa12992a58caed6b297e0171d214866fe7@changeid>
 <CAPDyKFrDncw0D2ccw9GJS+oRdm2kROJh25OV9pMs+992vQV-cQ@mail.gmail.com>
 <Yh36R817IjCw2dMb@pendragon.ideasonboard.com> <CAPDyKFrchzHnph9zg55yCbpQ5hu9P=ZOdcuigyqC_4yYjFs10Q@mail.gmail.com>
 <Yh5J6yYyTaKldlO+@pendragon.ideasonboard.com> <CAPDyKFoUb7rdjfTiDBkZkhNBJ1_AYKQeAmW4VYURKZMLJ7dDHA@mail.gmail.com>
In-Reply-To: <CAPDyKFoUb7rdjfTiDBkZkhNBJ1_AYKQeAmW4VYURKZMLJ7dDHA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 16:04:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W5F-iQW_1gXJYYnzyvm2kMS2a6GkJ9jbF4++4OFkTzhg@mail.gmail.com>
Message-ID: <CAD=FV=W5F-iQW_1gXJYYnzyvm2kMS2a6GkJ9jbF4++4OFkTzhg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Mar 3, 2022 at 3:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Hi Laurent, Doug,
>
> On Tue, 1 Mar 2022 at 17:29, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, Mar 01, 2022 at 12:18:02PM +0100, Ulf Hansson wrote:
> > > On Tue, 1 Mar 2022 at 11:49, Laurent Pinchart wrote:
> > > > On Tue, Mar 01, 2022 at 11:26:46AM +0100, Ulf Hansson wrote:
> > > > > On Wed, 23 Feb 2022 at 17:35, Douglas Anderson wrote:
> > > > > >
> > > > > > The PM Runtime docs say:
> > > > > >   Drivers in ->remove() callback should undo the runtime PM changes done
> > > > > >   in ->probe(). Usually this means calling pm_runtime_disable(),
> > > > > >   pm_runtime_dont_use_autosuspend() etc.
> > > > > >
> > > > > > From grepping code, it's clear that many people aren't aware of the
> > > > > > need to call pm_runtime_dont_use_autosuspend().
> > > > >
> > > > > Well, I admit it's good practice that they should take care of this.
> > > > >
> > > > > However, it doesn't really matter to keep the autosuspend turned on
> > > > > when runtime PM becomes disabled, I think. When the driver gets probed
> > > > > again, it will most likely call pm_runtime_use_autosuspend() again,
> > > > > which should work fine, right?
> > > >
> > > > For the probe path I agree, but are there valid use cases where, at
> > > > runtime, a driver would disable runtime PM and re-enable it a bit later
> > > > ? If so, we need to ensure this won't disable auto-suspend.
> > >
> > > I am not sure I fully understand whether there is a problem.
> > >
> > > Can you perhaps write the sequence of the runtime PM calls that may
> > > cause an issue?
> >
> > Simply
> >
> >         pm_runtime_disable();
> >         /* Do something that requires runtime PM to be disabled */
> >         pm_runtime_enable();
> >
> > at runtime (not at probe or remove time). If probe() has enabled
> > auto-suspend, we don't want the above sequence to disable it. What I'm
> > not sure is if there are any valid use cases for the above sequence.
>
> The above sequence certainly exists already, for example during system
> suspend/resume.
>
> So what happens is that the runtime PM auto-suspend feature gets
> temporarily disabled between pm_runtime_disable() and
> pm_runtime_enable(). That seems correct, right?
>
> >
> > > > > > When brainstorming solutions, one idea that came up was to leverage
> > > > > > the new-ish devm_pm_runtime_enable() function. The idea here is that:
> > > > > > * When the devm action is called we know that the driver is being
> > > > > >   removed. It's the perfect time to undo the use_autosuspend.
> > > > > > * The code of pm_runtime_dont_use_autosuspend() already handles the
> > > > > >   case of being called when autosuspend wasn't enabled.
> > > > >
> > > > > Hmm, I am hesitating to extend devm_pm_runtime_enable(), as it
> > > > > currently makes it look too simple to turn off things at ->remove()
> > > > > for runtime PM. While in fact it's more complicated.
> > > > >
> > > > > A bigger problem, for example, is that a driver calls
> > > > > pm_runtime_put_sync() during ->remove(), relying on that it actually
> > > > > ends up calling its ->runtime_suspend() callback to turn off various
> > > > > specific resources for the device. And in fact there are no guarantees
> > > > > that will happen - and when it doesn't, the next time the driver's
> > > > > ->probe() runs, things are likely to be really screwed up.
> > > > >
> > > > > To cover this case, one could use the below code in the ->remove() callback:
> > > > >
> > > > > ...
> > > > > pm_runtime_get_sync();
> > > > >
> > > > > "turn off resources for the devices - like calling
> > > > > clk_disable_unprepare(), for example"
> > > > >
> > > > > pm_runtime_disable();
> > > > > pm_runtime_put_noidle();
> > > > > ...
> > > > >
> > > > > In this example, it would be too late to call pm_runtime_disable()
> > > > > through the pm_runtime_disable_action().
> > > >
> > > > My experience with runtime PM is that it's hard to use, at least if you
> > > > want to get it right :-) That's especially the case if a driver wants to
> > > > support both CONFIG_PM and !CONFIG_PM. Here's an example at probe time:
> > > >
> > > >         /*
> > > >          * We need the driver to work in the event that CONFIG_PM is disabled in
> > > >          * the kernel, so power up and verify the chip now. In the event that
> > > >          * CONFIG_PM is disabled this will leave the chip on, so that streaming
> > > >          * will work.
> > > >          */
> > > >         ret = ov5693_sensor_powerup(ov5693);
> > > >         if (ret)
> > > >                 goto err_media_entity_cleanup;
> > > >
> > > >         ret = ov5693_detect(ov5693);
> > > >         if (ret)
> > > >                 goto err_powerdown;
> > > >
> > > >         pm_runtime_set_active(&client->dev);
> > > >         pm_runtime_get_noresume(&client->dev);
> > > >         pm_runtime_enable(&client->dev);
> > > >
> > > >         ret = v4l2_async_register_subdev_sensor(&ov5693->sd);
> > > >         if (ret) {
> > > >                 dev_err(&client->dev, "failed to register V4L2 subdev: %d",
> > > >                         ret);
> > > >                 goto err_pm_runtime;
> > > >         }
> > > >
> > > >         pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> > > >         pm_runtime_use_autosuspend(&client->dev);
> > > >         pm_runtime_put_autosuspend(&client->dev);
> > > >
> > > > And the corresponding code at remove time:
> > > >
> > > >         /*
> > > >          * Disable runtime PM. In case CONFIG_PM is disabled in the kernel,
> > > >          * make sure to turn power off manually.
> > > >          */
> > > >         pm_runtime_disable(&client->dev);
> > > >         if (!pm_runtime_status_suspended(&client->dev))
> > > >                 ov5693_sensor_powerdown(ov5693);
> > > >         pm_runtime_set_suspended(&client->dev);
> > > >
> > > > And of course there's no documentation that explains all this, so there
> > > > are endless variations of patterns originating from cargo-cult
> > > > programming.
> > > >
> > > > I don't know what the right solution is, but we need to move towards an
> > > > easier to use API if we want drivers to get it right. Any step in that
> > > > direction would be welcome.
> > >
> > > Yep, I fully agree with you, while it's not an easy task. At least the
> > > example above looks fine to me. :-)
> >
> > It took me several days to figure out how to get it right. Most
> > developers don't bother, so we end up with drivers broken in different
> > ways :-S
>
> Yes, it's definitely non-trivial.
>
> Power management in general relies on cross-interaction of several
> different frameworks, so one really needs a decent overview too,
> before adding PM support in a driver.
>
> >
> > > Recently I noticed that some drivers are calling
> > > pm_runtime_force_suspend() at ->remove(). This works fine in quite
> > > many cases, but it wouldn't solve the case when CONFIG_PM is unset.
> > >
> > > Perhaps we should explore adding a new API, along the lines of
> > > pm_runtime_force_suspend(), but make it specific for the ->remove()
> > > path, and in some way make it work for when CONFIG_PM is unset too.
> >
> > I'm all for an improved API for drivers that would make the above
> > simpler. And documentation too, Documentation/power/runtime_pm.rst is
> > more of a documentation of the runtime PM core than the driver API.
> > There are some useful tips for drivers, but they're lost in a sea of
> > difficult to understand and/or irrelevant information (and there's also
> > a tiny bit of information in Documentation/driver-api/pm/devices.rst).
> > We're missing a document targetted at driver authors.
>
> Yes, I agree - the docs can certainly be improved! I will add it to my
> TODO list and try to put some time on it, not too far ahead I hope. I
> was actually planning for a blog-post/LWN article, maybe I should
> spend some time on this instead - or both. :-)
>
> When it comes to the improved API for the ->remove() case, we need to
> explore this a bit more. I will think about it.
>
> About $subject patch, if you or Doug insist that you want to move
> forward on it, I will not object - even if I think we need something
> entirely different, in the long run.

Hrm, I guess the question is how far away are we from the long run.
;-) If this doesn't impede the long term solution and the long term
solution is still a ways out, it feels worth landing this or something
similar to it just to help make the existing code a little more
robust, even if it doesn't solve every problem. That being said, I
don't have any code that depends on this patch and I myself will
likely not mess this up again in code that I write. ;-)  Just for
context, the patch was originally suggested by Laurent [1] in response
to me fixing some code that I wrote.

[1] https://lore.kernel.org/r/YhZY+FLTlv7V5BIB@pendragon.ideasonboard.com

-Doug
