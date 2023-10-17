Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9297CC093
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 12:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJQKUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbjJQKT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 06:19:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8A19D
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 03:18:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so5832359276.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697537910; x=1698142710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ktWaOruBUJv9gHaQQ46lfwZNwa4X3oOXCjZ7LwABmo=;
        b=gzMtPyuB+LwFGeSyBAWQwDMfYZHYp86HOTVNiZRziQqyMmJCoyacdpIBYNUOwxtUPs
         Z7+CjC3gT9kF2mxGKO40ApJdF27iyKUpYD57qFv780w1q2YIMQ2NJtAvrGh2lg7+Pr7u
         wZTLekOtqdyN+8rYDhjkFMRUvN4f7YKlaRbmUXmBjx7mv1vTU7mOMhecwy//ffxNm0QU
         +HxYwSLUDrnltKltG3GB5aHDrJ06GTAKrWawKYnLqs6lqOgnGEuQL8bReTq/3S30EIru
         D+em4k1kvOXFPAyLrYsPBJTRddWkEbV3xUmf99G8WTbA1pNGv0rPGxl9goh6JykekIEK
         gI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537910; x=1698142710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ktWaOruBUJv9gHaQQ46lfwZNwa4X3oOXCjZ7LwABmo=;
        b=Pu4v0m3XzlToVnSxPXK+fwEW1xAsTDHH7b32X7RBM3EI11PHIh1KrRxjpI5I1D0uVS
         pzeOU6dOAiZ0Vh0q0LdNWYw3dSSwI7skmewJuT8hamfkN3wf99pKTrSAgwi/q3vZCa9l
         TmPUpofVn6Ep3UZz/GoCCfv5GNPvSFahuTkn9t1NpMgTSGuO5zxzU0vbp+ILShmI44Oe
         enMGOIPwMKwHEf/k+T/SOyg12rLDTZrIBJOUFEI68aeNbNzY+w24NT/b/ioXBQXAVIM8
         ORoqxcxDOuHEkyWE0YLU7BgKD7FfQB99DmjLPTTrHgeTPLPRNa8Y5wwBAVdz1PKdBMYr
         BBFg==
X-Gm-Message-State: AOJu0YxsNXXL4PryHAhSs/3qopc1gF4dfbh4W1RTl+RmNtqXRRZkWlWC
        4OBJsVHDOYg+Ny/MS84O4YhKJf8KdKfHJg16dqUz1g==
X-Google-Smtp-Source: AGHT+IHWurbz2txUr20HWYPC5aUPeESgl0nAZwOmo0bsLoG2ZVNauyqa5WyOCHDyT5Gabd/QnoSvk/5H3QV3o7/prL0=
X-Received: by 2002:a25:4155:0:b0:d7f:d6a7:d57d with SMTP id
 o82-20020a254155000000b00d7fd6a7d57dmr1464515yba.27.1697537910046; Tue, 17
 Oct 2023 03:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk> <CAGETcx9mUVzERc8Uf3FWYtMv+RZyNgvjm1oOtQZq6yN4_3Bp8Q@mail.gmail.com>
 <CAPDyKFrjtZH-yHu9od7bAA69=AdUHmsFr-amhhW70JLCKZGH5g@mail.gmail.com> <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
In-Reply-To: <hhx2tqxmgrjbhz2wnhozffpcq63spuli4mrensvbnmilrvbh2d@6qo444ddawc2>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 12:17:54 +0200
Message-ID: <CAPDyKFrSzepC0c7-XGeGcHSsfpEGpF0a9ATGpemxvcc8mtL86g@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     Saravana Kannan <saravanak@google.com>,
        Emil Kronborg Andersen <emkan@prevas.dk>
Cc:     linux-pm@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 17 Oct 2023 at 10:00, Emil Kronborg Andersen <emkan@prevas.dk> wrote:
>
> Hi Ulf,
>
> On Mon, Oct 16, 2023 at 11:53 +0200, Ulf Hansson wrote:
> > Unfortunately, it's not that easy. It's not required by
> > pm_genpd_init() (or of_genpd_add_provider_*) to use a struct *device
> > when registering a genpd provider. In fact, that's also the reason why
> > pm_genpd_init() needs to initialize its own struct device.
>
> Do you see any way to do it properly at pmdomain level instead, or is
> that not feasible? I agree with Saravana that a centralized solution,
> akin to what was implemented for tty devices in commit 1a5ecc73b2bf
> ("serdev: Set fwnode for serdev devices"), would be ideal. However, I
> was not able to find other reports or patches of problems regarding
> fw_devlink at pmdomain level, so it might not be a general problem here,
> and fixes per driver might be okay in this case?

Sure, we could fix it though a centralized solution, but it requires
us to patch each and every genpd provider driver too. At this point I
would therefore say, let's just fix it for those that need it.

>
> > That said, can you please explain the special condition that caused
> > this thing to be needed in the first place?
>
> I noticed this issue when I updated from 5.15.93 to 6.1.37. Except for
> the commit I bisected, i.e., 3fb16866b51d ("driver core: fw_devlink:
> Make cycle detection more robust"), I found that the issue was
> introduced somewhere between 6.1.16 and 6.1.15. Here, some commits
> regarding fw_devlink was backported, which might be relevant:
>
> $ git log --oneline v6.1.15..v6.1.16 -- drivers/base/core.c | grep fw_devlink
> 11d93294b7c3 driver core: fw_devlink: Avoid spurious error message
> 3dd596616d10 driver core: fw_devlink: Make cycle detection more robust
> a3c171751512 driver core: fw_devlink: Improve check for fwnode with no device/driver
> 7a8ce4d2fbbc driver core: fw_devlink: Consolidate device link flag computation
> 16aa2487cf15 driver core: fw_devlink: Allow marking a fwnode link as being part of a cycle
> eaf9b5612a47 driver core: fw_devlink: Don't purge child fwnode's consumer links
> 2455b81afe68 driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links

Thanks for sharing the commits. I haven't looked much closer to them,
but maybe Saravana has some ideas about whether this potentially can
be fixed in the fw_devlink parsing instead?

Kind regards
Uffe
