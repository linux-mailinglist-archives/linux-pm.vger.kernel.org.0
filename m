Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446F860CD40
	for <lists+linux-pm@lfdr.de>; Tue, 25 Oct 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiJYNSb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Oct 2022 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJYNS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 09:18:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A50FDFB7E
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 06:18:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f140so11804865pfa.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Oct 2022 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8iBlKsLRePu8lxeGZNajhb3cTDeiUEJCk/+foleLtE=;
        b=F2g+U3MIymcr3dy7K3a7VGX7/VsGlDl+sjNOuT90x/XOtQ/k0IYtJoC8W5oQZS1qg4
         ZhDGhUrDa085/cjO/WleqObr3pwVjr44tZLR2hBspLRyvzVJVhAX0n60E2TANBr4RUaS
         Qe6UEwceOwpnpy/KxjF1wRxo1Nlc+Hk65tcBXdNfdMiW3wSD4LrK/0a3UB7YzdXcQZCh
         gJhZ8Ol/X8R4BS6LsnBpzFC0VYqHta9gFz85+z5xe1dXNTn3XWpByt8BQEXc0Br64qCM
         fiL+GTNC7oUz/XtlA5psGQD9/WEpbwFZrTFwZqXsD5kD//8mXM0Jbf6Da/kRLi/GPlhB
         jsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8iBlKsLRePu8lxeGZNajhb3cTDeiUEJCk/+foleLtE=;
        b=Ryz01JOAaZfzmHI0lp2nQUCximc1gvDNPiTXmhN1Yvt+GVuTKMQ/Adsqgk/D6f4zJI
         mGsFhPh+9mogP0CK0mHSD2cVlQW9gida7ZMbges5ZEGJUPOE+VL6JLIwOqgVIemAKPH1
         CM3pXoTKlp5CmqEAQl9jdTCZb+FSzWSN8aWP9BYn1sBhMGzWC+TiVn5zpvdY0YRdGoyF
         guaQRnFTnL1oTmUtdhl2hxgXWR68G8Yk0ZZILqvcVk+BbANZGbkkevWkCYvbWXbtQVxN
         RkbVcK+nq9Wwh9tQLp891p4q/bg0PcMHJfLxJET0yhCavDyd0wA59vtwiCbuIog+YOf0
         EdsA==
X-Gm-Message-State: ACrzQf1IiFrQVJmV1jrC4gfk+QKll5wvhry3Z0XYX3F2hG452xx7Z4sn
        8JGuUJJ1WE6vtCeNk97jVYZI/ignId1wx7Osz3w9lQ==
X-Google-Smtp-Source: AMsMyM6oe8u33WL7gbbjZJ0AfgfwnLmB4YCqjQEdI/GORqNhLNw1ggdtAwwdYKmzQxFKRJum9UW9SSr3clLixLnRXPQ=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr33596437pgl.434.1666703907223; Tue, 25
 Oct 2022 06:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221020115513.93809-1-ulf.hansson@linaro.org> <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Oct 2022 15:17:50 +0200
Message-ID: <CAPDyKFpo_JhpGRZwJExMxPoit7yzp_LByfUEbkkLZxgUdNGRFw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Oct 2022 at 15:16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 1:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > It's useful to understand whether we are using OS-initiated (OSI) mode or
> > Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> > Therefore, let's extend the print in the log after a successful probe with
> > this information.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> > index 821984947ed9..c80cf9ddabd8 100644
> > --- a/drivers/cpuidle/cpuidle-psci-domain.c
> > +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> > @@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
> >         if (ret)
> >                 goto remove_pd;
> >
> > -       pr_info("Initialized CPU PM domain topology\n");
> > +       pr_info("Initialized CPU PM domain topology using %s mode\n",
> > +               use_osi ? "OSI" : "PC");
> >         return 0;
> >
> >  put_node:
> > --
>
> Am I expected to pick up this one?

Yes, please!

Kind regards
Uffe
