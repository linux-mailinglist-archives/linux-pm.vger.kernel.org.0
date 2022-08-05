Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17D58AC2F
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbiHEONY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiHEONW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:13:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B517E2F
        for <linux-pm@vger.kernel.org>; Fri,  5 Aug 2022 07:13:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u1so3629151lfq.4
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2022 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nAZInEnOaZkqfsEfJKMhoQnnnp1Khg6CL+YASSQVmVc=;
        b=g9upt6RCJhatqQbagYGeERNo7jG+NZWz9zeY3YEzsO4S1KpFPwYIPE4qSGb3j4rbjS
         oMVPI511i7obvfrO40wKZ82h97gSSyNIYruPuuy0w5QGO4tuE9zM9Me6SsW2U7JHVlwa
         YAnGzzhT7IQDuj+QrdV/+R8oiMtuZrEm6RlrKbkLiYipMipkLL4WLIT+CRWP3Tm16FDK
         q3N7g3te3sLxq4OuaaiQqsSsiXOKVtY+Hjv8fA0s4q/21HNQsgydcZ2v7+lkH8kwhwFl
         lZR4awklyCB/5HMQ69PYS3TXgqhIi+M/CAvTHRd6+pvZhHV06HBi92xrjYLVI3vgKcON
         /OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nAZInEnOaZkqfsEfJKMhoQnnnp1Khg6CL+YASSQVmVc=;
        b=Wybdapp1o2aR3W0WYUfV6aD3ogi8F+4DaK+gBjRNNsvvfnihf2HfKHUIdfM/RoGMFZ
         9zasCzcuKhqtl3AFX14rXHmxAr2/QF64pXjd4HIXEEhyUR3+6k4KXscKfVuKsx4HzVl2
         YbQC+zMJ/uJYGfe2Joeoa3F4Bo+48jekGDFWQdwSWqjY+SeMblN+TzmXkRAtUmlThM04
         2IYZa4d+VF02xxVHiGtO4gT+OKow99e0ZryZQOAqmZ7s4rHn2dU1vl0qtaz0OBvcI7K5
         mJXDuSVHTwIvCyIyRObI7knVtIHp4SyWGMceJZPiV92Ppa1JKgQdnpam/OwPl/DMhNq4
         PdiA==
X-Gm-Message-State: ACgBeo3Ajrqf8XiHQidYm4clx6sL5yjdUan94ZVGD4g9k7dXLQprN/4H
        TGkR0fbyUqqdvSUGxZeQWphRW53itfErtRsFOpB2tA==
X-Google-Smtp-Source: AA6agR7ue80VmS/YRPCVaJvvHzBWhX7QOl5Snu1NnpKAA81V1UkS2E/zmOzmR6CaeFSl6fFxiO2Ei4jYGEG5RZScYYI=
X-Received: by 2002:a05:6512:38a5:b0:48a:e9d2:3c2c with SMTP id
 o5-20020a05651238a500b0048ae9d23c2cmr2395281lft.71.1659708798660; Fri, 05 Aug
 2022 07:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus> <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <20220728084012.jjbmycplye3zuaok@bogus>
In-Reply-To: <20220728084012.jjbmycplye3zuaok@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 5 Aug 2022 16:12:42 +0200
Message-ID: <CAPDyKFqT23A_4EdBe=2-+6821BzjPvGzsMositM2=Of692iv3A@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Jul 2022 at 10:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
> > On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote=
:
> > >
> > > On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> > > > Hi,
> > > >
> > > > Lately I have been working on improving the msm8996 platform suppor=
t.
> > > > Vendor kernel seems to support domain-like idle (see [1], [2]).
> > > > However when I tried changing upstream msm8996.dtsi to use PSCI
> > > > domains, I faced the firmware reporting NOT_SUPPORTED to an attempt=
 to
> > > > enable OSI (thus rendering PSCI domains useless, as they are now
> > > > marked with ALWAYS_ON).
> > > >
> > >
> > > That's not good to hear =F0=9F=99=81.
> > >
> > > > I noticed that vendor kernel makes a call to cpu_suspend() with
> > > > power_state following the original format (described in PSCI spec
> > > > 5.4.2.1). What would be the best way to support this?
> > >
> > > And why is this not possible with the existing code ? Not sure if I
> > > understood it right, I am assuming you are mentioning that it is not
> > > possible.
> >
> > It's not possible with the cpuidle-psci-domains.c. The driver marks
> > all genpds as ALWAYS_ON, thus making sure that they are never
> > suspended.
> >
>
> That doesn't sound correct. I am sure Ulf has tried this on one of SDM
> platform for sure when it was merged.

It looks like there may be some misunderstanding here.

I think the point Dmitry is trying to make, is that the we set the
GENPD_FLAG_ALWAYS_ON for the created genpds, when the OSI mode could
not be turned on, when probing the cpuidle-psci-domain driver. In this
way, all of cluster idle-states become disabled.

More details about why we have this behaviour can be found from the
commit below.

70c179b49870 ("cpuidle: psci: Allow PM domain to be initialized even
if no OSI mode")

>
> > > > - Allow DTS forcing the PSCI power domains even if OSI enablement f=
ails?
> > >
> > > Meaning DTS flag for this ? If OSI enable fails, why would you want t=
o
> > > still proceed. It is non-compliant and must be fixed if the firmware
> > > supports OSI and expects OSPM to use the same.
> >
> > I'm not sure at this moment. PSCI firmware reports that OSI mode is
> > supported, but then when psci_pd_try_set_osi_mode() tries to switch
> > into OSI mode, it gets NOT_SUPPORTED.
>
> Yikes, fix the damn broken firmware. That is utter non-sense. I don't
> understand why would the firmware authors enable some feature before it
> is ready.

I certainly agree that the FW is broken and should really have been
fixed, but that seems unlikely to happen when moving forward.

On the other hand, it's quite common that we try to add workarounds at
the Linux side to fix FW issues. Of course, it depends on what kind of
hacks it means for us to carry.

In this particular case, I am of the opinion that it looks like the
"hack" may be worth it. Unless I have underestimated the problem, it
seems like a new DT property/flag and a simple if-clause in
psci_pd_try_set_osi_mode() should do the trick for us.

I wouldn't mind maintaining such small parts, when going forward - and
of course I think we should also reject any newer platforms from using
it.

>
> > Just for the sake of completeness, I added a print to the psci.c to
> > dump the result of the psci_set_osi_mode(false). It also returns
> > NOT_SUPPORTED!
> >
>
> Well it is simply broken then. Not tested firmware, so please don't
> attempt to use OSI if it is so fundamentally broken. I find it hard to
> accept the argument that well it works just that the query API is failing=
.
> But what is the guarantee that it is tested well enough. We will end up
> adding more quirks after adding one to enable it.
>
> > My logical assumption would be that the firmware reports support for
> > OS_INITIATED, but then just fails to properly support
> > SET_SUSPEND_MODE.
>
> I knew this argument was coming as I wrote above, sorry I don't buy that.
> It is probably one of the early platforms supporting PSCI and not well te=
sted
> for conformance. So I am inclined to just say we can't support it.
>

As Dmitry also wrote in his other reply, the FW has certainly been
well tested with the cluster idle states (acting like OSI mode has
been enabled).

To me, it seems like a pity, if we just decided to leave all those
devices out there in the field, lacking support for deeper idle
states. Don't you think?

Kind regards
Uffe
