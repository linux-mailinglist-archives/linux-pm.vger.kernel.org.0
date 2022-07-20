Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865C57BAEA
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jul 2022 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiGTPzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jul 2022 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiGTPzJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jul 2022 11:55:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F10FFD8
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 08:55:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b9so16843908pfp.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Jul 2022 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PxGJvhLtJuqRKmxgyWTr3dyw5v1u+NUlBmHboKdNo9s=;
        b=mWWCpocdFnO3thggu3OhtEeoCRaOv3M5lOueJvcCQTDYgBpsXplJkCW9pyIUUD1KJo
         E1hjJYf//4wroHUvXHMsE89HyiUxh2cadFeyDwjm8H3bp+YubwWJMW6md4/xf7QxpeLT
         OiI539zgmrx3amHbiNUlt4Y+2Acmt60Q3rRp4hqagxGPa1rW250S91jBO3DN3OGjk+pC
         R5s9iq+e7RljNkCwuICuNxnAv6/U+3x+1uLG5epJ7fNFAjbHsg7h/uj+sQjR3AoxAHlk
         4MFxlyk0PIdFFqfJnyzfhaozFX7vBmRSO8fReDtFSyaRdislkq+L19Vf2qT05MkQc8Zf
         9Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PxGJvhLtJuqRKmxgyWTr3dyw5v1u+NUlBmHboKdNo9s=;
        b=o6xWUKv9hyRYXEbVw9l/92oBNegAaDueA40JPnRgrjXvC/cwm0Bl+akp758DfPsQ7t
         wOgg0FnyeMwn/ikDYNrA5VeeU/d/fzD7FIcEc2LhJZI61/JXG7rTpm8hawLCzH1ZP9Id
         Qn4p0+yLMcws3ni1m2Bx+kKZXMz4YvI1JlOFSnLvXbAHnGqhtVlOIqp1LC5cc5fU3kAy
         c2gMQiaQG1QR6aPkNBFQgq9gMruCpd3hMO2qKLnVMlCr/3bojG+C3X9jeAX98yCM0Pnn
         g3MVhur2q/WbfHTVfVev3ybNr3SEhp2Z4pLroM1pPllmDMd3Nd2NStLa1YFqYssblwlr
         yGHQ==
X-Gm-Message-State: AJIora/VLe1SdnfReVaOGaukwYutsf0bvQJtRGghUkMKMM//bI5Vm8BC
        w35cMpuKZa6HwhojsU+M0tUegH1rZ9eVFb20M1KCOQ==
X-Google-Smtp-Source: AGRyM1ul7/N7Zqa3MQFIdsZV6cTIm2wPxyfvuArvrrqMeepFbTobVgzG+U4Ck6m1AkuT7qqmt0jbBh1ZDj00OgWkUwU=
X-Received: by 2002:a63:e946:0:b0:41a:7350:6cd5 with SMTP id
 q6-20020a63e946000000b0041a73506cd5mr1530570pgj.247.1658332507848; Wed, 20
 Jul 2022 08:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <20220707125329.378277-2-jaz@semihalf.com>
 <CAJZ5v0gdCN3P52ko44LQMqWJvDArHxZ7p4aSiQamML7aG_kRAA@mail.gmail.com>
 <CAH76GKO9sxnuLM--x6sg7m3bC_NgvLA94N6jHA-+5gW741-ByQ@mail.gmail.com> <352edf44-5983-403f-b8f8-5dfbd92ea32d@amd.com>
In-Reply-To: <352edf44-5983-403f-b8f8-5dfbd92ea32d@amd.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Wed, 20 Jul 2022 17:54:56 +0200
Message-ID: <CAH76GKNie4m=SOEEJGks+CEyR9=aB+dJzDA1wxTuUo=uUjmZog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] suspend: extend S2Idle ops by new notify handler
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmytro Maluka <dmy@semihalf.com>,
        Sean Christopherson <seanjc@google.com>,
        Dominik Behr <dbehr@google.com>, upstream@semihalf.com,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=C5=9Br., 20 lip 2022 o 17:22 Limonciello, Mario
<mario.limonciello@amd.com> napisa=C5=82(a):
>
> >> It looks like you want suspend-to-idle to behave like S3 and it won't.
> >
> > In a way, yes, we compensate for the lack of something like PM1_CNT to
> > trap on for detecting that the guest is suspending.
> > We could instead force the guest to use S3 but IMO it is undesirable,
> > since it generally does make a difference which suspend mode is used
> > in the guest, s2idle or S3, e.g some drivers check which suspend type
> > is used and based on that behaves differently during suspend. One of
> > the example is:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
xir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Fa=
mdgpu%2Famdgpu_drv.c%23L2323&amp;data=3D05%7C01%7Cmario.limonciello%40amd.c=
om%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D5M1s=
n3iRybQzSFi3ojQ4YTJuW41DlgJNl5sxbWEvLBQ%3D&amp;reserved=3D0
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
xir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Fa=
mdgpu%2Famdgpu_acpi.c%23L1069&amp;data=3D05%7C01%7Cmario.limonciello%40amd.=
com%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DfIr=
LmZAgpIRPYO4to4uYUoBSEWXmz1lr%2BTnR14kAfvM%3D&amp;reserved=3D0
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Feli=
xir.bootlin.com%2Flinux%2Fv5.18.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Fa=
mdgpu%2Famdgpu_gfx.c%23L583&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co=
m%7C7bdd972291324d03847e08da6a51ff4f%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637939197694682503%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DSNsbm=
pV4HrgA%2Bkff4JzRodNDzKvwM5tnkGDvrKO44dc%3D&amp;reserved=3D0
> >
>
> Actually I recently was suggesting a change to add this detection to
> another driver to set a policy and Rafael pushed back.  He's actively
> removing it from other places in the kernel.
>
> For amdgpu stuff you pointed above, are you wanting to pass through the
> PCIe GPU device to a guest and then suspend that guest? Or is this just
> illustrative?

Just illustrative. I am not focused on amdgpu stuff right now.

Thank you,
Grzegorz

>
> For a dGPU I would expect it works, but I don't think passing an APU's
> GPU PCIe endpoint would functionally work (there were bugs reported on
> this I recall).
>
> That code path you point out only has special handling for APU when
> headed to S0ix and that's because the GPU driver happens to be where the
> control point is for some common silicon functions.  If the bug I
> mentioned about PCIe passthrough of the APU GPU endpoint to the guest is
> fixed and the guest needs to do s0ix when the host doesn't we're going
> to have other breakage to worry about because of that common silicon
> functionality I mentioned.
