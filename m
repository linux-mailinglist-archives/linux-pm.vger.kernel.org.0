Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7733583B4C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiG1JfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 05:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiG1JfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 05:35:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD626BF57
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:35:12 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e16so1047023qka.5
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEujygdF9HiNBZrDC/mPTjbQJRIpLwuClvEFyJRFbX0=;
        b=B+NFenYCmKOGwyipO0AWS0JL4S/XXDSFPzTrfLfbNU56v2IjkGscmW4HMoMie1dS3T
         o5aUOWWg4SFppm50Z8/dgligjSYUeFHpX55MSbmV93vAy6w0MQviM4UakHBE9hK0/hB1
         ODI/intBFqskp9CbVCiB7caqxn0ApAN1RC8wpZHQt81XB/aYPe0ZEbwqEuRXTK6ulCKg
         CkkHZujT+b86slvjFeMY5SrJiKs2hZ7SOIl2SJGri8OXWmvab8IAwxkgSEpPpMbkMC5c
         KdxnL2delyLucdDSk3rFbhH4a0onbnScYTKRSGJUa0HXyHvniC7lYIdgkagzg1UN/gtA
         tv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEujygdF9HiNBZrDC/mPTjbQJRIpLwuClvEFyJRFbX0=;
        b=Ewc/XkGoRPV8WMBSuryoj4q++KB8rt6c13rhxT2TwR4f5KNlyQDbdGbn1anyMEw19R
         LYFzKW+srWYEeQwm1YGFfwo6BYuicSq4NeRMcqz5hMJosHrMbe18bx7V+wkWarEZ+u9I
         LLmGH5l7Mnc4eCpOiL809xuV8hkHjIIkv1CKCByQBQHfr8L9pA3fxAYjpfStQgk/Qptk
         mcX8NHnClnGG/F5UPpmFxg8mhPJ8Jt3ozjoI2A/O6d+hsnKD5OUitaoVH2cTrs0IhsSY
         SB3+ehJ1mgaLU0vKkMGRH2aDxfh/pKfzeqV8Fcl9EKHH4rT6ephMxq5c3xUuvk3YVjVF
         MegA==
X-Gm-Message-State: AJIora92jqMHB1yX4+B4vYX3tfpxgZRQrINkjNr+K4h2EQbHw4uK8B+e
        7nxCqBfIK6PP2jmHIxbR+EvlDXdJElgyvfKTXUwbEQ==
X-Google-Smtp-Source: AGRyM1tOVppTMhS5GfKC9W+WkJoKDSn+YflerKIstoCUYJPQLbdjfAeAVY1r2pn+UfCGjCgS4kyL32kqPB0OE754vzM=
X-Received: by 2002:ae9:f311:0:b0:6b6:30a9:1bb1 with SMTP id
 p17-20020ae9f311000000b006b630a91bb1mr19223162qkg.30.1659000911771; Thu, 28
 Jul 2022 02:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220727182034.983727-1-dmitry.baryshkov@linaro.org> <20220728085809.sct3swhs7xuls27t@bogus>
In-Reply-To: <20220728085809.sct3swhs7xuls27t@bogus>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 28 Jul 2022 12:35:00 +0300
Message-ID: <CAA8EJpqd2K1YB2U9fixi4qxpC4n645O+8GwLj5DsXCqcFJoiMA@mail.gmail.com>
Subject: Re: [PATCH] PSCI: Print a warning if PSCI doesn't accept PC mode
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 28 Jul 2022 at 11:58, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 27, 2022 at 09:20:34PM +0300, Dmitry Baryshkov wrote:
> > The function psci_pd_try_set_osi_mode() will print an error if enabling
> > OSI mode fails. To ease debugging PSCI issues print corresponding
> > message if switching to PC mode fails too.
> >
>
> Are you seeing that even setting to PC mode failing on msm8996. The platform
> must boot in PC mode, so even if it fails we ignore so not sure if the logging
> is of much help here IMO.

It helped me to understand that it is not only setting OSI, who fails
with the 'not_supported' status, but setting PC mode also fails. Which
later led me to checking which functions are provided at all, etc.

>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/firmware/psci/psci.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index cfb448eabdaa..b907768eea01 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -597,7 +597,9 @@ static int __init psci_1_0_init(struct device_node *np)
> >               pr_info("OSI mode supported.\n");
> >
> >               /* Default to PC mode. */
> > -             psci_set_osi_mode(false);
> > +             err = psci_set_osi_mode(false);
> > +             if (err)
> > +                     pr_info("setting PC mode failed with %d\n", err);
>
> Since we don't care about error value here, does it make sense to add the
> log in psci_set_osi_mode() that covers both PC and OSI case whenever it is
> called ?

Yes, this sounds like a logical idea. I'll do this in v2.

-- 
With best wishes
Dmitry
