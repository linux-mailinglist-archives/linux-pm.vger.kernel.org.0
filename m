Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5F4555402
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jun 2022 21:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377710AbiFVTKL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jun 2022 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377692AbiFVTKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2022 15:10:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4843914033
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 12:10:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-317741c86fdso170739757b3.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jun 2022 12:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2EKhR0TRoyufPiu9Flo4efSG9iVQ7Sr7NIfxXnG//E=;
        b=q0iBpeFzXmVjuV9RJ2U0tO6ECKKIgXqLxhTrd/XuqGhMkas+He99laUPoyLdnfoNFL
         +PttCvM62NPrGDH6bN6Tam5nPc4Jt6Lhqq9iRLcdZDXmODHt/VANxFARtdqBpIOWNqbl
         AatF7ctiFGf72C+0OC82zliefxVYa8dtkAaYmnq0JCPtTgfz1cWUVQ87m5452KZkW/cW
         SPNNeBKYphGmdKaYImVx82HxgMYh2fon8Z8I1JzFAAU0CLZraMDpT8R9qd8YGH1YLF5l
         z+/MLbNzdLViy90RdBW0wFmvw6BnGUFs9HZsF90abo3WhbF4Ja8pDA24KBOpYxV847T2
         I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2EKhR0TRoyufPiu9Flo4efSG9iVQ7Sr7NIfxXnG//E=;
        b=Tvv5+ZXPb7Z8QvzYQtlqpjuU/TEz33QGQzRNPIbhUjCugKP4Mk+zdmezXANyuZXpg7
         jw9vuWPklFWN7lTgy+yVBmbEv4wKBIEVUDPfDuW51U/4AV3Coj2Jo4Vqb8lJLSCqBQwM
         Jzdk2zKb9lL9334JYrTqbwkYZswnzdiNuh6ZBaHhD1RPfiiX7dtLN22G4RWCygdFvqsK
         vVYpURRFog8B8lGZS4QWAol2xcjVitd8gAVxJxY32q6+O6YL+pOBPRoWINFG8qcdfyQb
         uX+Ys0+mH/y/HkRCUMrkVJXO6EzfEHr5X9lRzcq/A1CelyjvKjSaXtGh5oxQCNvM3PTr
         bELw==
X-Gm-Message-State: AJIora/umHIoR2dBdZK16YIXDwcZaWLg/3tL+C4KWBbO4jLH0VxHW+W3
        T4L3JDLlvKJrlmxjI+yrnbCoxR5oQEDuwn6xTx4faQ==
X-Google-Smtp-Source: AGRyM1solygMwSWCkiPF1NFwzx5BeilY1scDMXVDLNy5qaonwBsI4xn5J0zOBjmp0RWdt2LaZxnizqSGP3n3TRaTEKc=
X-Received: by 2002:a0d:eace:0:b0:317:87ac:b3a8 with SMTP id
 t197-20020a0deace000000b0031787acb3a8mr6074480ywe.126.1655925007151; Wed, 22
 Jun 2022 12:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com> <YrKhkmj3jCQA39X/@atomide.com>
In-Reply-To: <YrKhkmj3jCQA39X/@atomide.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jun 2022 12:09:31 -0700
Message-ID: <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Saravana Kannan <saravanak@google.com> [220621 19:29]:
> > On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi,
> > >
> > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > "power-domains" property, the execution will never get to the point
> > > > where driver_deferred_probe_check_state() is called before the supplier
> > > > has probed successfully or before deferred probe timeout has expired.
> > > >
> > > > So, delete the call and replace it with -ENODEV.
> > >
> > > Looks like this causes omaps to not boot in Linux next.
> >
> > Can you please point me to an example DTS I could use for debugging
> > this? I'm assuming you are leaving fw_devlink=on and not turning it
> > off or putting it in permissive mode.
>
> Sure, this seems to happen at least with simple-pm-bus as the top
> level interconnect with a configured power-domains property:
>
> $ git grep -A10 "ocp {" arch/arm/boot/dts/*.dtsi | grep -B3 -A4 simple-pm-bus

Thanks for the example. I generally start looking from dts (not dtsi)
files in case there are some DT property override/additions after the
dtsi files are included in the dts file. But I'll assume for now
that's not the case. If there's a specific dts file for a board I can
look from that'd be helpful to rule out those kinds of issues.

For now, I looked at arch/arm/boot/dts/omap4.dtsi.

>
> This issue is no directly related fw_devlink. It is a side effect of
> removing driver_deferred_probe_check_state(). We no longer return
> -EPROBE_DEFER at the end of driver_deferred_probe_check_state().

Yes, I understand the issue. But driver_deferred_probe_check_state()
was deleted because fw_devlink=on should have short circuited the
probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
probe function and hitting this -ENOENT failure. That's why I was
asking the other questions.

> > > On platform_probe() genpd_get_from_provider() returns
> > > -ENOENT.
> >
> > This error is with the series I assume?
>
> On the first probe genpd_get_from_provider() will return -ENOENT in
> both cases. The list is empty on the first probe and there are no
> genpd providers at this point.
>
> Earlier with driver_deferred_probe_check_state(), the initial -ENOENT
> ends up getting changed to -EPROBE_DEFER at the end of
> driver_deferred_probe_check_state(), we are now missing that.

Right, I was aware -ENOENT would be returned if we got this far. But
the point of this series is that you shouldn't have gotten that far
before your pm domain device is ready. Hence my questions from the
earlier reply.

Can I get answers to rest of my questions in the first reply please?
That should help us figure out why fw_devlink let us get this far.
Summarize them here to make it easy:
* Are you running with fw_devlink=on?
* Is the"ti,omap4-prm-inst"/"ti,omap-prm-inst" built-in in this case?
* If it's not built-in, can you please try deferred_probe_timeout=0
and deferred_probe_timeout=30 and see if either one of them help?
* Can I get the output of "ls -d supplier:*" and "cat
supplier:*/status" output from the sysfs dir for the ocp device
without this series where it boots properly.

Thanks,
Saravana
