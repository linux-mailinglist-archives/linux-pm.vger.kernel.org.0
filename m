Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81064717D40
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjEaKhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjEaKhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 06:37:16 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38483BE
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 03:37:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bacbc7a2998so7728771276.3
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685529433; x=1688121433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hb+atrwIlXfcQwoujRisOu3uUtS33yWyq8g93LAKZU=;
        b=TGB7PYbc8AYuNFEjAnGpoUMD+eXlSzOCZXIwMaIbUbr4KlPJ1HyNYkBO0N2/KMwBQo
         fvDLSPaiyGAt3vyTLgHwOTcUEVQK7yQXhY6wwCpElDzEJLrcxfW9IUaumOTK8gL8j5xz
         GzIO1scm+Z8zCXDnbFHAXamDQzwAszn0gKZPgNFgHmli63ZKHLN5p+lmKVFHRvM/kMRg
         iugwuy2XE/hCwhvLbl75Ceu0VsSvfaDkHGV3W42ZoSWeZl+bvpW9zravGe9y7ebiN3Pk
         R7wSYAtniexA699wklH5clgx1PFBMPHIirz7l+PuCi1dkl6e8vu+RhllT7sSpRy9AgmC
         SRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685529433; x=1688121433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Hb+atrwIlXfcQwoujRisOu3uUtS33yWyq8g93LAKZU=;
        b=d1w4GIP40ul+q7qk+urMXVuYlxFiinCqeApxDAnRHk+6AwuYGV8IbfguMSGhuZTpff
         lmgJrVj51Tc8XmQarkl3ZkJGRqmeedCOqPNHXZQrbih1FZ7uq3KkxLBsZTdpz0BW2IpT
         GxCkIXNc2qGkEsX1+wVRySzQbUmG4LGSQWz8VBUpodMPxT6bbIPSoyU3VKQuOJhgLKMr
         KZJjSdcrGNMnqKpsJdyeqcK03U5wxbKJkMfaj6xCWbPj0qt1XNPkLUn6F6VrchKsuKmA
         GKz0kIkbotLL8acPs9vep7VjcK+iVvJjhZJtqkxcyXQwO51srNSNm508YuUZ6HHWSNNw
         So6g==
X-Gm-Message-State: AC+VfDye8RjS7RJTr2OHnbhrr3OnNwP3KU/PfNPfvcczmAshLy21m4lJ
        cTCk/siEa1zxYCuNoj2nct9hdVREfKrbxOEoskYF7A==
X-Google-Smtp-Source: ACHHUZ6YFB1+LG5hx+dy+tgiMDuaBMOHhepPU+AfVOsYfxotTsiAKiTHKgkuuV5e+PoMbhV9tM5ElNRC/VlxeCjRrME=
X-Received: by 2002:a25:df15:0:b0:ba7:bb5b:d2c0 with SMTP id
 w21-20020a25df15000000b00ba7bb5bd2c0mr6549992ybg.23.1685529433155; Wed, 31
 May 2023 03:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 May 2023 12:36:37 +0200
Message-ID: <CAPDyKFpeLcH53A+jRwU41aHs48zhSA54aSrTmHASWxPofaU-tg@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 May 2023 at 19:12, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Hi Folks,
>
> I'm going to submit a Power Management and Thermal Control
> micro-conference proposal for LPC2023 along the lines of what happened
> in the previous iterations of it.
>
> If you have topics that you'd like to be discussed there, please let
> me know by Friday, May 26.
>
> Please note that LPC MC topics are expected to cover work in progress
> or at the concept stage.  They are not supposed to be about work that
> has been done already.

If not too late, I can raise one potential topic for discussion.

I am hearing, mostly from the ARM community, that there are needs to
support multiple system wide low power states. Not only based upon
what system wakeups that need to be configured, but rather based upon
wakeup latency constraints required for certain use cases. s2idle can
be explored as a possibility to make this work, but I think a wider
discussion could be valuable.

Maybe this is something that can be valuable for the x86 community to
discuss too?

Kind regards
Uffe
