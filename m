Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03DE7CC0EC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJQKq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 06:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjJQKqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 06:46:55 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D50EA
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 03:46:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so5884808276.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697539612; x=1698144412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EF8shAUhSiUH0r32leaAQytaKmwTr9SigqTBH1STMOk=;
        b=HUvlHVEuiMLrC1KuWqsfC3YtBbP2192PSbEp6IKfG3PMl75j/LxD0Ay9NSPiTRiH7y
         guQ5zO6mAM4HwMurDmy6e3RjFT/WTgVjZG3Nfv7yPR+PHcYq22fd1L7wuIci5oVfLH0O
         dm15lH3BfW1Bw9uuAyE+HhAaTijRzTgDsvj8OmeAjVHh6hzExtlRh1kbH1tNpXs2Ye52
         R/TYzB2k7SM9xOqOU3bzb07cGnBwJwuSURAI3fbT5UodiiUzBcRI3MKxYsM56I5fPC6T
         aJRG4jyOvrb6jxAOfR4bfNLW3EDBUISoIakAPVOAXVTrsACUNuI+FjmF/kKoT078jAvo
         Q/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539612; x=1698144412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF8shAUhSiUH0r32leaAQytaKmwTr9SigqTBH1STMOk=;
        b=Y2AnKrlMdjpFTCdOAL35CSnZwpnxtqN4JiAv+SpS+ERWt/TaXQgZgTcR3Q/i5gb7sk
         8OJJ2+fHJjGMkitglXfkxT2mHGHggg4r3z2LLXow3oVmFBaqfPMMNBsl4ywXWM/Bf7fX
         COZum8DpKQXOXfGuTq30tzDjXK12OhB1kqFyKZ3GR8DQdxtSfuepgkk82gtZDtqBsV+t
         o7TLzhVJhKzoJlRwxtCURaFwGgoZpvcyhku6PLt+pi9cxllrdZKHzRJ1UGZfwyVp6fnt
         1JHLDuzHbaGZui9UONOfTGM+VkIoiOcfYso3YQjQJbIVE4ITyhzzKZf+xpiVJLZ9/8x8
         XCnw==
X-Gm-Message-State: AOJu0YySt2wE2AqwtNnyo5Qa0IRK0L7Ot6lGJQ5oH6cq7rAL6V4s6sAU
        69BDjBo5kABJVhrDSXB9jqalPYneEvebkP2EPKUbgCt8jpYxlQcG9+0=
X-Google-Smtp-Source: AGHT+IGV2Me36vkp2DqECHJK34k++gDObdR3JYhPpt5lekDNF2AUlnJoZ2fqs84mu/xxcl/bISPAXfl7+hrGM9kb9L8=
X-Received: by 2002:a25:ce8a:0:b0:d7b:957e:e476 with SMTP id
 x132-20020a25ce8a000000b00d7b957ee476mr1656142ybe.45.1697539612630; Tue, 17
 Oct 2023 03:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231010130054.ieylxocuapugajif@bogus> <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus> <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus> <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus> <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
 <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com> <ZS5OFzLjEEZi0Q8s@bogus>
In-Reply-To: <ZS5OFzLjEEZi0Q8s@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 12:46:16 +0200
Message-ID: <CAPDyKFqAr8D=d8FuTThy1SwjVguQFmWTTUqS0WUEzGoVzKjDOw@mail.gmail.com>
Subject: Re: Question regarding scmi_perf_domain.c
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Oct 2023 at 11:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Oct 16, 2023 at 05:08:18PM +0200, Ulf Hansson wrote:
> > On Thu, 12 Oct 2023 at 13:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 11 Oct 2023 at 16:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:
> > > >
> > > > [..]
> > > >
> > > > > Not sure exactly what you are referring to when saying that "automatic
> > > > > power domain on is broken". Genpd power-on the PM domain for a device
> > > > > that gets attached to it, if the device has only a single PM domain.
> > > > > This is the legacy behaviour.
> > > > >
> > > > > When we added support for multiple PM domains per device, we decided
> > > > > to *not* power-on the PM domain, if the device that gets attached has
> > > > > multiple PM domains. This behaviour was chosen deliberately, to allow
> > > > > consumer drivers to decide themselves instead. Is there a problem with
> > > > > this you think?
> > > > >
> > > >
> > > > Just my understanding. Since the second PM domain added now is for perf
> > > > and is not strictly power domain, Peng's concern is switching to this
> > > > binding will make the platform loose this automatic genpd power-on
> > > > feature.
> > >
> > > Yes, correct, as they way things are today.
> > >
> > > It all boils down to that attaching a device to multiple PM domains
> > > can't really be done in a generic way, as it becomes device/platform
> > > specific. Since this needs to be managed by the drivers/buses anyway,
> > > they might as well get control of what PM domain they need to power-on
> > > to probe their devices.
> >
> > Due to the above, it might be a good idea to power-on the SCMI
> > *power-domains* during boot and leave them on to allow drivers to
> > continue to probe their devices?
> >
>
> Such workarounds in my opinion are always inviting troubles as few platforms
> make not like it that way.
>
> > Maybe a module parameter or Kconfig debug option could be used to control this?
> >
>
> May be that works, but again I see this as working around. If the expectation
> is the driver must manage the PM domain eventually, does it make sense to
> start doing that now. You termed the single domain power on automatically
> in the genpd as the "legacy support". Do you mean there is a plan to remove
> it or make drivers not rely on it ?

No, we are not planning to change the legacy behaviour.

>
> My main worry is now we are spreading this work around every where. It was
> in genpd but now you want in SCMI power domain driver. It just makes things
> harder to remove if the eventual plan is to make drivers take care of the
> power domains themselves.

The drivers need to take care of this, no matter what. My proposal
isn't going to change that, please see more below.

>
> > In this way an updated DTS with that adds a performance domain to a
> > consumer device node (which already has a power-domain), should allow
> > the consumer driver to continue to probe successfully.
> >
>
> This will work, but I find it hard as addition of some extra information
> in the DTS is ending up losing some feature which was otherwise available.
> If platforms relied on it, they may just stick with clock bindings silently
> as it is easier that way. Even expecting a module param might be a big ask
> if someone working on the platform isn't aware of all the details.
> That is my main concern.

I am not quite sure I get your point. The clock bindings can't be used
for generic performance scaling, but it's limited to CPUs.

Are you worried that the "debug option" (whatever we may decide to
use) would get set and then evolve into becoming the default behavior
for the SCMI power-domain? If so, I certainly agree that it can be a
concern and an argument for not doing something like this!

In principle my suggestion was to avoid us from *upfront* having to
patch lots of drivers, before updating the DTSes. With the debug
option, the idea was that drivers could be extended, step by step, to
deal with multiple PM domains and OPPs - and when all things are
implemented, the debug option would be unset for the platform.

Although, maybe this isn't such a problem after all. I guess we need
to defer to Peng to understand if this is really a concern or not.

Kind regards
Uffe
