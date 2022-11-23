Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD8E636513
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiKWP61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 10:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiKWP6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 10:58:11 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93835CB9D6;
        Wed, 23 Nov 2022 07:57:18 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id x21so12731019qkj.0;
        Wed, 23 Nov 2022 07:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EJSBmYoSSSmNh31enrB/3qdGl3C0nH6Q10DeSYW0No=;
        b=POwyjhEhkkRIljDTGT8JUFtic7T86vmisQjpUJsdiErMBn02r5wrY0Dt/OoZzLETAZ
         U+7YV3l4mxvXsk4ArCK9grNmcdq89wlQnISjV5WtFo7hkB0x9zXbBGLJY08iAUY6qhXq
         oj45NpmGyPBxxL1p4ka1n7llmZX+FPDQzaQv2EZI8Q2Tzr9WsucYBUn3bRaFgC0RNL+2
         SNp1Bp17HfMSaxC+NRHOS+JalHb7maPoQBseLJb1LHjWTKQfd4hga28cLrsFaK92yktW
         ioTuocBcGG6Q+pgZaDKovcY7uSTWwLJqiGCH7a2Y7dSbR0jG8xTll5b76Jlok0o9kEjr
         xZqw==
X-Gm-Message-State: ANoB5pkKmNsMCqFcG0i/pvvIRPn+7+a2/0jvQIP1kLYA3vCKWbkqOEV+
        aPpf1FmwSi6zFMTwj2Qask6CAK0pxT0tmv7qnOw=
X-Google-Smtp-Source: AA0mqf4Sc8lvYEYVrjXBOrqllEusAJ9pFQTXsKDTgyWjQtHTtF4M+EbNbmERuKSaEw9s4qUfQI89hRIS/Ozcdp5zugc=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr9384412qkb.764.1669219037340; Wed, 23
 Nov 2022 07:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20221122070014.3639277-1-dedekind1@gmail.com> <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
 <01c732b1-7211-8298-61da-0a6892988743@redhat.com> <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
 <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
In-Reply-To: <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 16:57:06 +0100
Message-ID: <CAJZ5v0gJAQfZVvrAfvvF0vjeAQPnwHbpFcnvCG8Jxo2McxyYwA@mail.gmail.com>
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
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

On Wed, Nov 23, 2022 at 4:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 11/23/22 15:59, Rafael J. Wysocki wrote:
> > On Wed, Nov 23, 2022 at 3:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 11/23/22 09:45, Artem Bityutskiy wrote:
> >>> Hello Hans,
> >>>
> >>> On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
> >>> There are 3 different issues with this patch, next time please
> >>> check your patch a bit more thorough before submitting it:
> >>>
> >>> 1. This is the first time I see this, or that the
> >>> platform-driver-x86@vger.kernel.org
> >>> list sees this. Next time please make sure you address the patch to the right
> >>> people the first time you send it:
> >>>
> >>> sure, thanks.
> >>>
> >>> 2. This has checkpatch warnings which are easily fixable:
> >>>
> >>> [hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
> >>> intel-uncore-freq-add-Emerald-Rapids-su.patch
> >>> WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
> >>> line)
> >>>
> >>> OK.
> >>>
> >>> 3. This fails to build on top of:
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> >>>
> >>> OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
> >>> this upstream commit:
> >>>
> >>> 7beade0dd41d x86/cpu: Add several Intel server CPU model numbers
> >>>
> >>> Would you please consider updating?
> >>
> >> Ugh, no, *NO*! I really expect Intel to do better here!
> >>
> >> As I repeated explained with the
> >>
> >> "platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"
> >>
> >> patch I cannot just go and cherry-pick random patches merged through other trees
> >> because that may cause conflicts and will cause the merge to look really
> >> funky.
> >
> > I don't think this is about requesting a cherry-pick though.
> >
> >> There are proper ways to do this and this is not it!
> >>
> >> This is something which Intel really *must* do correctly next time because
> >> having this discussion over and over again is becoming very tiresome!
> >>
> >> So the proper way to do starts with realizing *beforehand* that things
> >> will not build on top of pdx86/for-next. By like actually doing
> >> a build-test based on top of pdx86/for-next instead of this nonsense of
> >> repeatedly sending me broken patches.
> >
> > This patch is based on the mainline.  The requisite commit has been
> > included into the Linus' tree since at least 6.1-rc4 AFAICS and I
> > suppose that it has been tested on top of that.
>
> Ah, I did not know that; and that is typically info which I would
> have expected to be explicitly mentioned in the non-existing cover-letter
> for this patch.
>
> >
> > You could in principle create a temporary branch based on 6.1-rc4 (or
> > a later -rc), apply the patch on top of it, merge your current branch
> > on top of that and merge it back into your current branch (that should
> > result in a fast-forward merge, so the temporary branch can be deleted
> > after it).
>
> Yes I could merge rc4 into my for-next, but I'm not really a big fan
> of back-merges like this. I try to keep my for-next history linear
> based on the last rc1, because I find seeing what is going on
> a lot easier that way. But if this happens more often I guess
> I may need to get used to doing back-merges more often then
> just after rc1 is out.
>
> What I don't understand is why this patch was not send as a part of
> the series starting which also had the
> "7beade0dd41d x86/cpu: Add several Intel server CPU model numbers"
> patch. That patch just adds a couple #define-s presumably there
> were more patches in that series actually using those defines.
>
> Things would have been cleaner / easier if this patch had simply
> been a part of that series and if it was merged in one go with
> that series...
>
> Btw this new CPU ID is also missing from:
> drivers/platform/x86/intel/pmc/core.c
> drivers/platform/x86/intel/ifs/core.c
>
> At least I assume it will need to be added there too, although
> I guess it might not be as simple as only adding the CPU-id
> match there ?
>
> > Alternatively, if you'd rather not do that, I can merge the Artem's
> > patch through the PM tree (it is PM-related after all).
>
> If you can do that, that would be great, thank you.

No problem.

> > I suppose that your ACK would be applicable for that too?
>
> Yes.

Thanks!
