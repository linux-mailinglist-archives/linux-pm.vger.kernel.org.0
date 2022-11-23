Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89D8636297
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 16:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKWPA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 10:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiKWPAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 10:00:09 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51C1697E6;
        Wed, 23 Nov 2022 07:00:08 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id cz18so5958323qvb.13;
        Wed, 23 Nov 2022 07:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jaPagakVEmjc+rLD6CdKE6P/t2nDJkUd7Qkb+JUaUw=;
        b=bt/yjvcXOYvPeMZz/sGFliZD2bH9917sEKAxrl9GdyIdE9YLFkdn0mpicde98NiRkJ
         mjqUA7YdcNqHUHqELI1r3zXTdk61OJyUW7pF7QoJnXIKmIs+XqjmIIGJHWn9Hted5PLs
         8xJNGHF+yCe9tf8IBCDD94taPL0zms3t08idg4EJfGamMjh1cwGQJi2LWdwRfYiTPNVQ
         iHh+D663wp/TyqRpDgCJG75WbuTEBjAJiYtHLv1eprFNhx7Jwek9sQ4/kBPUne42kn6S
         jy8ztfJXSmGAUe/btzJ7a2kOAHjvMmHHyzojKLLhTHJXCh3uziHheVw7tUGuv0jz4fnE
         ZI/g==
X-Gm-Message-State: ANoB5pn/aeDigMPSRHf3nUE2HuQl5w95ZDSkcvqsub8qo6qXa7wqg/f8
        sILmP4BXdI4ipn9av8RckGSRPGRhkcolGd5yjkEPbr7W
X-Google-Smtp-Source: AA0mqf5sZk8OcfXHVNC6AZdHhDAWB5zzuT69ovtRfDwtSqSqcTPHLLdqDtqW0107F/ldB8SFs1mecarlVBt1wdcf06M=
X-Received: by 2002:a0c:ed50:0:b0:4bb:f952:c799 with SMTP id
 v16-20020a0ced50000000b004bbf952c799mr8542131qvq.3.1669215607400; Wed, 23 Nov
 2022 07:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20221122070014.3639277-1-dedekind1@gmail.com> <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
 <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com> <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
In-Reply-To: <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 15:59:56 +0100
Message-ID: <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
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

On Wed, Nov 23, 2022 at 3:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/23/22 09:45, Artem Bityutskiy wrote:
> > Hello Hans,
> >
> > On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
> > There are 3 different issues with this patch, next time please
> > check your patch a bit more thorough before submitting it:
> >
> > 1. This is the first time I see this, or that the
> > platform-driver-x86@vger.kernel.org
> > list sees this. Next time please make sure you address the patch to the right
> > people the first time you send it:
> >
> > sure, thanks.
> >
> > 2. This has checkpatch warnings which are easily fixable:
> >
> > [hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
> > intel-uncore-freq-add-Emerald-Rapids-su.patch
> > WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
> > line)
> >
> > OK.
> >
> > 3. This fails to build on top of:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
> >
> > OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
> > this upstream commit:
> >
> > 7beade0dd41d x86/cpu: Add several Intel server CPU model numbers
> >
> > Would you please consider updating?
>
> Ugh, no, *NO*! I really expect Intel to do better here!
>
> As I repeated explained with the
>
> "platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core driver"
>
> patch I cannot just go and cherry-pick random patches merged through other trees
> because that may cause conflicts and will cause the merge to look really
> funky.

I don't think this is about requesting a cherry-pick though.

> There are proper ways to do this and this is not it!
>
> This is something which Intel really *must* do correctly next time because
> having this discussion over and over again is becoming very tiresome!
>
> So the proper way to do starts with realizing *beforehand* that things
> will not build on top of pdx86/for-next. By like actually doing
> a build-test based on top of pdx86/for-next instead of this nonsense of
> repeatedly sending me broken patches.

This patch is based on the mainline.  The requisite commit has been
included into the Linus' tree since at least 6.1-rc4 AFAICS and I
suppose that it has been tested on top of that.

You could in principle create a temporary branch based on 6.1-rc4 (or
a later -rc), apply the patch on top of it, merge your current branch
on top of that and merge it back into your current branch (that should
result in a fast-forward merge, so the temporary branch can be deleted
after it).

I do such things on a regular basis and no complaints so far.

Cheers!
