Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C7636352
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 16:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiKWPWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 10:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiKWPWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 10:22:30 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90462E1;
        Wed, 23 Nov 2022 07:22:28 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id x21so12650842qkj.0;
        Wed, 23 Nov 2022 07:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKLiu8mvQqLVm/5twakOnq9ApBtwsaynO3ONlkGE+yo=;
        b=m7isEkAZFUPFk32Z7aHsqYSO8UD0u01VpUflEKI17nQlxjcmw2MFlrfI0OgCc3zF+S
         i/5zptCSDzJ+GfWblT1vO22xjLUYPAwmvml+mAMmajVY2+erxSr6giKcWl/MHAL2bKQz
         d+UDuSghEqVy67tcuXfRiwa4qmR0n/pY/U6IcH8HfWCxrJHTio85R8nK+TYp0ZWGwY8K
         MVRgTXZEGnHTGSWKej8wHEdr2i16QT6JLZLAzsKX820Rvt8CmHPPEydo389yT2uMc/ea
         EttlyhvRtjVX8M+LKHSsWr8wgS4FBYn4jG7NuXA1PSq1gETBqqcvlGIO94DQ9xHNy4oM
         in4w==
X-Gm-Message-State: ANoB5pkzK316VS6qNxTBPOflK/AOxurf//vlNy2TW0SDOnp1OE7AswJC
        XI0GmBjXb4sOtq+wtIiWySSR/BnosywtqBPSgGORJGj/
X-Google-Smtp-Source: AA0mqf6MEB5xnEeqXHk4nvmmdJZJTWwJv4S83b9ceNvqFpJB9uOw4Y+/hQJSbsIheXZhvDMZ7QUp9+krLMOc0nUTwWo=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr24969054qkb.443.1669216947973; Wed, 23
 Nov 2022 07:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20221122070014.3639277-1-dedekind1@gmail.com> <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
 <01c732b1-7211-8298-61da-0a6892988743@redhat.com> <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 16:22:17 +0100
Message-ID: <CAJZ5v0idhsaTxOFG5ncpV2fmFTnGd8yoNPY5c1+hWG4Y-ticnQ@mail.gmail.com>
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 23, 2022 at 3:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Nov 23, 2022 at 3:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 11/23/22 09:45, Artem Bityutskiy wrote:
> > > Hello Hans,
> > >
> > > On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
> > > There are 3 different issues with this patch, next time please
> > > check your patch a bit more thorough before submitting it:
> > >
> > > 1. This is the first time I see this, or that the
> > > platform-driver-x86@vger.kernel.org
> > > list sees this. Next time please make sure you address the patch to the right
> > > people the first time you send it:
> > >
> > > sure, thanks.
> > >
> > > 2. This has checkpatch warnings which are easily fixable:
> > >
> > > [hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
> > > intel-uncore-freq-add-Emerald-Rapids-su.patch
> > > WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
> > > line)
> > >
> > > OK.
> > >
> > > 3. This fails to build on top of:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> > >
> > > OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
> > > this upstream commit:
> > >
> > > 7beade0dd41d x86/cpu: Add several Intel server CPU model numbers
> > >
> > > Would you please consider updating?
> >
> > Ugh, no, *NO*! I really expect Intel to do better here!
> >
> > As I repeated explained with the
> >
> > "platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"
> >
> > patch I cannot just go and cherry-pick random patches merged through other trees
> > because that may cause conflicts and will cause the merge to look really
> > funky.
>
> I don't think this is about requesting a cherry-pick though.
>
> > There are proper ways to do this and this is not it!
> >
> > This is something which Intel really *must* do correctly next time because
> > having this discussion over and over again is becoming very tiresome!
> >
> > So the proper way to do starts with realizing *beforehand* that things
> > will not build on top of pdx86/for-next. By like actually doing
> > a build-test based on top of pdx86/for-next instead of this nonsense of
> > repeatedly sending me broken patches.
>
> This patch is based on the mainline.  The requisite commit has been
> included into the Linus' tree since at least 6.1-rc4 AFAICS and I
> suppose that it has been tested on top of that.
>
> You could in principle create a temporary branch based on 6.1-rc4 (or
> a later -rc), apply the patch on top of it, merge your current branch
> on top of that and merge it back into your current branch (that should
> result in a fast-forward merge, so the temporary branch can be deleted
> after it).
>
> I do such things on a regular basis and no complaints so far.

Alternatively, if you'd rather not do that, I can merge the Artem's
patch through the PM tree (it is PM-related after all).

I suppose that your ACK would be applicable for that too?
