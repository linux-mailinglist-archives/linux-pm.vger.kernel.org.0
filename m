Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A74591014
	for <lists+linux-pm@lfdr.de>; Fri, 12 Aug 2022 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiHLLdS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Aug 2022 07:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLLdR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2022 07:33:17 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EA5AED80
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 04:33:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l10so667635lje.7
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zv3slSVz2UVMdlITVtenonaSRad2lXBuS+dRpiix4js=;
        b=iKRRLJ1kPc47fn8xxLpMGpd4qXn90LhtwEoG2dySKT4kgXsfZDyre/WHZl70B02BHa
         SSFS8uuNDq04qVQ4d14ODGmLnppyCAk0Ham1ribbBuIQOizEiBTS4V16iuc1AhfJiVHx
         I94e8QT2PSfAwy3rMmHrIKHqPkA5mr0wwV+7dcEwzSRxxjWbXP6YhClNsQWgv8o68ynH
         Xe9IaC5AF2uq5lghpYLJPIT41kGrY0IFJt8JNFCjdm6Sp16PAUuH0OiSRbGskeiI4Uub
         GwpaLKdfxDWqOpV5byQI/akkgkcDLGMQgLJm0LuE0HEQXzqOaV0QUQluY7M0XvXnXDKy
         ncwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zv3slSVz2UVMdlITVtenonaSRad2lXBuS+dRpiix4js=;
        b=2Mu31/yAJWpJJWtQbI1fQl03ncQ2kbgmtWYXimjBBAG4SvkaUCtjdtf6+oxdj3ehhH
         f14J8pwiazm2KK+vH0ZFrHuJTSXolRQEAI3cRg7gYZ6nOkjZ/w5C5WkOXbM2KaxtRlbJ
         dt1NjbG7uqF7HicY3Et5tkFutDbNu4WYpma75MMRjohVUOsEtMqPCnqvw1uTms4y3V0M
         mVqofN31/egssNrvlmj+OembJj2O+9XHlInxBCH3k2T/+xmUKb0LYZ5T1Go8luvERFLB
         rPOZmw1zHrmFqIza8KsIIPgTgSiU78Okxd9auANuF8v9jldoiXxpgzsMJESqXy+RC3R0
         XeSw==
X-Gm-Message-State: ACgBeo2bsml52BpF4OhPsnpn+1BiOTWKg2JUaTT2XFZ/GIZSDtt4GCqK
        KtO49LaIqxDhfwLhY/rpO0fMS5iqbDDXTfMGUMAOsA==
X-Google-Smtp-Source: AA6agR46ARhq27fpblY8hra5c8h7n16wgvVW1mUNwP4aDpLkTszyr2iMsTbEzwGQXdQqobq6pHYNNDMGjbcg5l+79g0=
X-Received: by 2002:a05:651c:92:b0:25f:f326:f2c1 with SMTP id
 18-20020a05651c009200b0025ff326f2c1mr1008534ljq.273.1660303994591; Fri, 12
 Aug 2022 04:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAA8EJpr2S-81+q-vjmk5i+T-JwaadkRpjCr_oGi7fMf7o3iH3A@mail.gmail.com>
 <20220727111410.bglx2u26456ray2u@bogus> <CAA8EJprNPJfGjkq2=hexbZn-=t2wKG6ZjSm5Mcbo4JuPQ-sc-A@mail.gmail.com>
 <20220728084012.jjbmycplye3zuaok@bogus> <CAPDyKFqT23A_4EdBe=2-+6821BzjPvGzsMositM2=Of692iv3A@mail.gmail.com>
 <20220805160020.fc5s3hv3u5h4gcmv@bogus> <9a53b01f-e112-314b-faa1-13f0ed36f595@linaro.org>
In-Reply-To: <9a53b01f-e112-314b-faa1-13f0ed36f595@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Aug 2022 13:32:38 +0200
Message-ID: <CAPDyKFrk=4Uic5m-JiLOXfQF10ptK0jyydBM7_KVmtOwmZn4xA@mail.gmail.com>
Subject: Re: PSCI domains without OSI support
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 5 Aug 2022 at 23:39, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 05/08/2022 19:00, Sudeep Holla wrote:
> > On Fri, Aug 05, 2022 at 04:12:42PM +0200, Ulf Hansson wrote:
> >> On Thu, 28 Jul 2022 at 10:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>
> >>> On Wed, Jul 27, 2022 at 04:24:22PM +0300, Dmitry Baryshkov wrote:
> >>>> On Wed, 27 Jul 2022 at 14:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>>>
> >>>>> On Wed, Jul 27, 2022 at 12:09:27PM +0300, Dmitry Baryshkov wrote:
> >>>>>> - Allow DTS forcing the PSCI power domains even if OSI enablement fails?
> >>>>>
> >>>>> Meaning DTS flag for this ? If OSI enable fails, why would you want to
> >>>>> still proceed. It is non-compliant and must be fixed if the firmware
> >>>>> supports OSI and expects OSPM to use the same.
> >>>>
> >>>> I'm not sure at this moment. PSCI firmware reports that OSI mode is
> >>>> supported, but then when psci_pd_try_set_osi_mode() tries to switch
> >>>> into OSI mode, it gets NOT_SUPPORTED.
> >>>
> >>> Yikes, fix the damn broken firmware. That is utter non-sense. I don't
> >>> understand why would the firmware authors enable some feature before it
> >>> is ready.
> >>
> >> I certainly agree that the FW is broken and should really have been
> >> fixed, but that seems unlikely to happen when moving forward.
> >>
> >> On the other hand, it's quite common that we try to add workarounds at
> >> the Linux side to fix FW issues. Of course, it depends on what kind of
> >> hacks it means for us to carry.
> >>
> >> In this particular case, I am of the opinion that it looks like the
> >> "hack" may be worth it. Unless I have underestimated the problem, it
> >> seems like a new DT property/flag and a simple if-clause in
> >> psci_pd_try_set_osi_mode() should do the trick for us.
> >>
> >
> > I don't like the idea of new property/flag for this for simple reason.
> > Once you have that it is impossible to control if downstream new platforms
> > are using it and they will expect it to be maintained once they ship the
> > product.
>
> According to my quick research the requested issue was present on
> platforms revealed from 2015 (2013?) to 2017. Since sdm845 (December
> 2017) the issue is not present. So this is a part of history rather than
> current platforms being in need of this quirk.
>
> >
> >> I wouldn't mind maintaining such small parts, when going forward - and
> >> of course I think we should also reject any newer platforms from using
> >> it.
> >>
> >
> > The only way that we can achieve this IMO is to have quirks based on
> > platform compatible which needs to be updated and can be rejected for
> > newer platforms. New flags means new feature which is expected to be
> > supported for long and hard to control newer platforms not using them.
>
> I see your point. However from my point of view, the DT property allows
> more finer-grained control.

It does, but perhaps it's not really needed, as you indicate below?

I share Sudeep's concerns about future possible abuse, so if we think
we can get the "compat list approach" to work, that sounds better for
me too.

>
> Compare the semantics:
> - Proprety: assume that the platform is in OSI mode, do not call
> psci_osi_set_mode().
>
> - Platform compat list: If the psci_osi_set_mode() has failed, ignore
> the error. I would not dare to blindly assume that e.g. all msm8996
> devices are in OSI mode.

You have a point!

So it looks safer to ignore the error that is returned from
psci_osi_set_mode(), rather than skipping to call it (maybe we want to
log a warning when it fails though?).

[...]

Kind regards
Uffe
