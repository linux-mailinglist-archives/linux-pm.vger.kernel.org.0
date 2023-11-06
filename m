Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17E7E288D
	for <lists+linux-pm@lfdr.de>; Mon,  6 Nov 2023 16:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjKFPWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Nov 2023 10:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPWl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2023 10:22:41 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D746D8
        for <linux-pm@vger.kernel.org>; Mon,  6 Nov 2023 07:22:38 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a8ada42c2aso52803447b3.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Nov 2023 07:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699284158; x=1699888958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CfNEIWDHgSE3pUG9rhjfsEcnlg782by1zvc5CufYugE=;
        b=c84mRhc3EgkuTjvXE9ge4xEzIDJabU3pvYEdjSGCR5TsGNacd9Eg20x1bSVqYoMsy8
         LSpds81s9P7OhwncDc0CHqj9LSo9FWW53CI5fZygREexBsNEj4il5bGeRlKx8bgIGdIL
         2D6mh69C+nVwttQ3ZB3m6GxSkptZEz2MjW++fzSC0sQhQEYlKWi5tEY8QGgc7BnTRo3T
         kGDFAmTQjRxmqI7Hx9keFvAlrtdfW1cbSaNZnQS9dXfzrYVNLtWr42KesL66TjgSmVdd
         3EoykVndkZzAHRbOzZkU107+mdhlE4MNRBr4VxMAlweSq2CcRbdQpO8mukoUPNe7l8rl
         IzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284158; x=1699888958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfNEIWDHgSE3pUG9rhjfsEcnlg782by1zvc5CufYugE=;
        b=ECWnPIU5UyM32DuWSEQai8wPQBNqeogs9rmdwlU4mFYkKZR05/e2Gu9KyHri3bOMWG
         /ERIsTGMtRg3Ki4377sgGcZf3+2j4D698gACBrS3Mq1Pgr8ccmCUwhFk/0H4zB3N22t8
         RjAelQSYLF9Zy44sqih36OE9JYv25Nv4kUAwud5dHxenuIWf8dc7Qi116C/pIf7po7zB
         W+2Bw/C0TcoFT1Wl6Gyct9Rf29kazqW+xThKEbD5o0I3GdCN1FPih3VquzN5m415QixA
         EGyQ8GSCKto9vVF2vF0xjteBwPJv65ThovupWWxU4v4Jtxd8uTb4CSHtQmc39xbcHYyV
         RcyA==
X-Gm-Message-State: AOJu0YxD7sNXWeCWxpnnzEXCpdCgo1TU47VPTkJt3bC+Uo5eIYPrh/CI
        w297vam48/X/Tggr9mt2ir4eK9d+dTjVo0FmoCa1WY2S82FvHTUS+o0=
X-Google-Smtp-Source: AGHT+IGjxRlMNlUxUN5P42Lqg572iPhqbjml/dJIbcBCLbUVSbReCv9ZSQoxJ8TC1qK3VHDBT9xjQLAuY40Ax6O7Two=
X-Received: by 2002:a81:7102:0:b0:5a1:fb1d:740a with SMTP id
 m2-20020a817102000000b005a1fb1d740amr11168419ywc.51.1699284157798; Mon, 06
 Nov 2023 07:22:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKHBV251ALNTBUHYG_EJzSkToj2LuR8nChTKjJvUaTNXjRYnEA@mail.gmail.com>
In-Reply-To: <CAKHBV251ALNTBUHYG_EJzSkToj2LuR8nChTKjJvUaTNXjRYnEA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 16:22:01 +0100
Message-ID: <CAPDyKFrGEMq7H9dfw5iCAEot-2Mme_R3HMxmonfq8sfsh4ALYg@mail.gmail.com>
Subject: Re: Using Genpd notifiers vs RPM callbacks for driver re-configuration
To:     Michael Shavit <mshavit@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
        Quang Hoang <quangh@google.com>,
        Koudai Iwahori <koudai@google.com>,
        Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 6 Nov 2023 at 05:50, Michael Shavit <mshavit@google.com> wrote:
>
> Hi all
>
> Reaching out to get some design advice on drivers that we'll
> eventually be upstreaming. I'd like to get clarification on whether
> using dev_pm_genpd_add_notifier is appropriate and acceptable from the
> upstream community for our use-case.
>
> Given a supplier driver (as defined by devlinks documentation) whose
> hardware needs to be reconfigured when its power is flipped from off
> to on, what's the best way to reconfigure it:
>
> Option 1: In the driver's runtime_resume hook:
> In this case, we reconfigure the component only when it's going to be
> used. Assuming that devlinks with the DL_FLAG_PM_RUNTIME are created
> between the supplier and all of its consumers, then the supplier
> driver's runtime_resume hook will be called whenever at least one of
> its consumers becomes active.

The above option is the preferred and recommended one.

The genpd's power on/off notifiers are intended for more special
cases, for example:
1) Due to HW limitations, the consumer (genpd consumer) driver can't
reconfigure its device unless the PM domain has been power gated.
Typically the device also lacks a reset control in this case.

2) The consumer (genpd consumer) driver may have additional
"last/first-man power-off/on-tasks" to carry out, when the PM domain
gets power gated. CPUidle makes use of this.

>
> AFAICT this is the intended way to do such things, but there's a few
> unpleasant caveats:
> Cons:
> 1. Such devlinks can automatically be created by fw_devlinks, but
> requires that the fw_devlink=rpm boot parameter is set. This can be a
>  fragile due to various timeouts that can remove devlinks or downgrade the
> DL_FLAG_PM_RUNTIME flag from the devlink when modules aren't all
> immediately loaded during boot (depending on the Kernel's configuration).
> 2. If the consumer device is attached to multiple power-domains, then
> it must manually create devlinks for the virtual devices created by
> genpd_dev_pm_attach_by_id (which it should arguably be doing
> anyways).

I don't think the above should be considered as caveats. If a supplier
device has a consumer device (not necessarily a genpd consumer) to
consider from a runtime PM point of view, that simply needs to be
managed, no matter what.

> 3. It may be reconfigured unnecessarily, if the power-domain wasn't
> cycled off/on between the driver's runtime_suspend resume calls. This can
> happen if a consumer depends on a supplier that lives in a different
> power domain.

Yes, this is correct.

Although, in most cases the re-configuration is done rather quickly.
In many cases, the driver also implements the runtime PM autosuspend
feature, which means that there needs to be a small idle period of
inactivity, before the device gets runtime suspended.

>
> Option 2: By registering a dev_pm_genpd_add_notifier notifier:
> Pros: It's easier to reason about. The component is always
> reconfigured whenever its power-domain is flipped back on and thus
> always in a functional state.
> Cons: It's not clear if this is an intended use-case for the
> dev_pm_genpd_add_notifier callback. It may also be reconfigured when
> it's not used, if the power-domain
> was powered-on for a use-case that doesn't make use of this component.

To be clear, option 1 is preferred, while strictly not required.

Note that, if all consumer drivers would use the genpd's power on/off
notifiers instead of the runtime PM callbacks, this would lead to a
"thundering-herd" problem. All devices sharing the same PM domain(s)
would then typically be runtime suspended/resumed simultaneously,
rather than in parallel.

Did that make sense?

Kind regards
Uffe
