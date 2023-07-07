Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84EB74B348
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 16:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGGOuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGGOuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 10:50:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207D91FD7
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 07:50:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so2192256276.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688741435; x=1691333435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sp/uA5IfbAuF+hGROjsdKR3qA3EtgZfyUKAVT4Nkw4=;
        b=x5sw/ii2BLnKBGR/rtRCUO7YPRyP1pWvW6pdAsXrs1hw0YV3KSSFhTJ4aFSThjiNe2
         iQL9/ZPQDO44hEJR8irC8l37EPMHGkcRFBFfo6c32mI2dChyn2UcIws9sBCKErzJ48kF
         3q23hpJgvwkcCSMOVkJe/p2t/P6DVrun4ZJ80xlDf2m8P4qASsieCzI5M62Dw5ZlHRRU
         mJQltxSdKzoA9hb8u6MNchKauws/KQ7aI4pjWzPiaiHV2SjHmiAxwtDUyi8zv59QeEND
         UqcS2Md4Su+qtIOuYJdSifSCn08WTFlgeS+DKIoKODGKvc/RDRvacBTdPBajx6bIb+S8
         OOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741435; x=1691333435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sp/uA5IfbAuF+hGROjsdKR3qA3EtgZfyUKAVT4Nkw4=;
        b=DjHd9VQO2ic68QB0TyH0I5UJ+yt566d/kILYP3RX7b6QOnKHAjLFnPsyxhGNAdnuui
         rjtiY4UooAOt/pkq5ggxXL/HjNTDkGQm7HPUheV1tPZXZaeEHtTF/H3h44l+sWUzVxb8
         uHH2DETi2pqFBotvarsldqY5jhQtVTQpa/YwASkY34WWuL7o/50R4T4E2SvWGFaw7IBv
         TbjIuX9/KyYCfIPjXqIWue9uSmKQ63dLHrqa1gctUlEwx++lQkqWA8h/g4E8Axk/r/DD
         rR9e0QVgZBPHQXXulQRiVeuSKdZrF9f2MZwHXxPxxa+K1hDfmqcdlX6tJBKSCzazrosL
         eE0w==
X-Gm-Message-State: ABy/qLbqNS9hsRVSuN23eBVKhb1LaGcGt7PUVLquaKs2qTA0OX8E4vE6
        Wh9cOi6zYNJDbZ7oZo5dyBmYzZqZfcXsSUEYWfBBDg==
X-Google-Smtp-Source: APBJJlEKONstJ7DrgNwd6Gmi5G6P6HU0HS1ioa7jdA62/7EJShy5yUhhnid/2w55qOEy+S6s+R3/hNvYCE5JEK/7QEE=
X-Received: by 2002:a05:6902:289:b0:bcf:b219:7919 with SMTP id
 v9-20020a056902028900b00bcfb2197919mr4403052ybh.44.1688741435310; Fri, 07 Jul
 2023 07:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZKYvpgs6p3S7nglh@google.com>
In-Reply-To: <ZKYvpgs6p3S7nglh@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jul 2023 16:49:59 +0200
Message-ID: <CAPDyKFpWybtCWt9pVcFMKcV0zBrjCzhhmAzYN-JPw2ZS6mUpwQ@mail.gmail.com>
Subject: Re: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
To:     Ajay Agarwal <ajayagarwal@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        manugautam@google.com, mshavit@google.com, quangh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Manivannan

On Thu, 6 Jul 2023 at 05:06, Ajay Agarwal <ajayagarwal@google.com> wrote:
>
> Hello Linux PM experts
> I have a question on PM domain. As per the current PM domain driver desig=
n, the genpd_finish_suspend turns OFF a power domain if it is not already t=
urned OFF by runtime suspend.
>
> I have a usecase of a device having to stay ON during system suspend. Thi=
s device will be used by a co-processor which is running its own OS. Thereb=
y, it requires the power domain to stay turned ON, so genpd_finish_suspend =
should not be powering down the domain.
>
> I studied the code and found the flag `GENPD_FLAG_ACTIVE_WAKEUP` which ca=
n be set for the power domain. And device_set_wakeup_path can be invoked in=
 the suspend() callback of the device. Together, these will prevent the gen=
pd_finish_suspend from turning OFF the domain. See: https://git.kernel.org/=
pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.=
c#n1260

To solve the problem, this is exactly what I would have started to explore =
too.

>
> But this flag is really intended to be used for devices which are capable=
 of waking up the system from PM suspend. But my usecase does not involve a=
 scenario of the device potentially waking up the system, it just needs to =
stay powered for the co-processor to be able to use it.

Sure, I understand your point. Maybe it's as simple as renaming the
device_set_wakeup_path() and corresponding flag to something more
generic.

Solving the problem that you are looking for, would probably be done
along the lines of device_set_wakeup_path() and
GENPD_FLAG_ACTIVE_WAKEUP anyway. And we really don't want to two
solutions for one similar problem, if you get my point.

>
> Can you suggest if I should go ahead with using the existing framework of=
 `GENPD_FLAG_ACTIVE_WAKEUP`? Or add a new flag, say `GENPD_FLAG_RPM_ONLY` f=
or this scenario?

Let's see what Rafael thinks, but renaming is an option (or add a
wrapper function that calls device_set_wakeup_path()) that would work
for me.

>
> Thanks
> Ajay

Note that, I have looped in Manivannan, who is working on a very
similar problem. The problem can be summarized like this:

Depending if there is an nvme storage device added to the pcie
interface, the nvmw storage must remain powered on during system
suspend. For that reason, we also need the part from the PM core where
propagation of the flag is done from child to parents.

It's been a couple of weeks ago since I chatted with Manivannan about
this - and I suggested the approach you have been exploring too. Let's
see if Manivannan has some more updates to share from his side around
this.

Kind regards
Uffe
