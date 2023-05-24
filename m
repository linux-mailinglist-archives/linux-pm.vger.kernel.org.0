Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66770F420
	for <lists+linux-pm@lfdr.de>; Wed, 24 May 2023 12:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjEXKZz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 May 2023 06:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjEXKZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 06:25:43 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E2C18C
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 03:25:29 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-94ea38c90ccso18349966b.1
        for <linux-pm@vger.kernel.org>; Wed, 24 May 2023 03:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923928; x=1687515928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfTRBKm1BEkzU5bRv8SrhXiMwM5/H2fbSFyAi0DO3Cg=;
        b=Q4HJFGDQhUq9rYW3JlztwlEG5pmyxAk3K5srnUz/bXPbCR1l09l30CFO2cT/XIXQy1
         3TiSwpZP7Sb6igucRQ9Th94SBgWhoYO70miAj8hwFkG+WiG12q7x2/aNZfwC0YV4acT4
         87FETs2mjGV2f9fOkSSKTPEImoSvzzL0B3k7Dg74TV54OB4NX5E9cl3S42zfakUG7gfH
         pv3fFAJnu7EHwTF/MbP59ZRYqCy1gF1akYYnY/kRdH7hvcF4nKLxu0m9CiGIH3FiUHgL
         u3PdDgQUM/wew/C46A2d/SQ4M60pp46xG2OAm0N8whJHiliRAKVcm8DAXXuBGu2gXKRr
         lG6Q==
X-Gm-Message-State: AC+VfDzqdGTdcys+9vQTeBXb+rspo+rliEaAstaPCgZirQ6kVrPh+5di
        VGwP57iOI1UFekD6y7ynri46NzweWdaSu4vHHJqAX5xj
X-Google-Smtp-Source: ACHHUZ7UqCl7ULk2+h40hfbomZvNovUpxEMdsqtkdpm1TQVB7GE5ab2KJ3P6HD+OG5Dd4RKqhkm77XRltaMbfNogzP0=
X-Received: by 2002:a17:906:2097:b0:965:86ed:ca6d with SMTP id
 23-20020a170906209700b0096586edca6dmr15320243ejq.0.1684923927748; Wed, 24 May
 2023 03:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <745b8b17-af4d-e8e1-83c1-89d600e7cd19@linaro.org>
In-Reply-To: <745b8b17-af4d-e8e1-83c1-89d600e7cd19@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 12:25:14 +0200
Message-ID: <CAJZ5v0iqWMKZo8yJMqymwLwZK9kXJFi89USd96A-H+aktSYT+A@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 24, 2023 at 10:06 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/05/2023 19:12, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > I'm going to submit a Power Management and Thermal Control
> > micro-conference proposal for LPC2023 along the lines of what happened
> > in the previous iterations of it.
> >
> > If you have topics that you'd like to be discussed there, please let
> > me know by Friday, May 26.
> >
> > Please note that LPC MC topics are expected to cover work in progress
> > or at the concept stage.  They are not supposed to be about work that
> > has been done already.
>
> * Create a relevant debugfs thermal infrastructure + cleanup the sysfs
> debug related information.
>     -> average temperature (overall / moving)
>     -> mitigation episodes (duration, temperature max, min, avg, average
> performance througput)
>     -> thermal zone behavior (temperature slope dT/dt vs performance
> througput)
>     -> more TBD at LPC

Sounds good.

> [ RFC series ready but depends on the generic trip point ]
>
> * New thermal trip types. Currently we have 'hot', 'passive', 'active',
> 'critical' trip points. The userspace needs to deal with the thermal
> also but in a different manner. Currently, it has to poll the thermal
> zone to get the temperature, thus introducing more wakes up on the
> system. However the sensors have now a programmable register to trigger
> an interrupt and the userspace may benefit that. By adding one or
> several writable 'custom' trip points, the userspace can program a point
> to be notified and do an action. So we separate the actions from the
> kernel to protect the silicon and the ones from userspace to manage the
> overall thermal behavior in the system at lower temperatures.
>
> [ depends on the generic trip points ]

So this basically would be an interface for user space to add a trip
point at run time?

What about a "send me an event if the temperature is equal to this"
interface instead?

But yes, as a discussion topic this would be fine.

> * Thermal management without the time dimension taken into account is
> too simplistic. Add this dimension in the thermal information for better
> decision (eg. notification when a temperature is above a temperature
> after a duration)

OK

> * Improve the step wise governor. The step wise governor may take too
> much time to react when there are many cooling device states as it will
> increment with one step at each update (eg. idle cooling device has 100
> states). That may result on overshoots. Depending on the temperature
> slope we should increase the number of steps for the cooling action. The
> result should be some kind of PID regulation loop but simplified
> regarding the power allocator.

Sounds good, but it is kind of minor with respect to the above.  We'll see.
