Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12068519BFB
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 11:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiEDJja (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiEDJjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 05:39:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694FE2611C
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 02:35:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p10so1320325lfa.12
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/WJ0tqMozkcFwQbk0zwDH9itMdQXF9SUhVNLVNoj+0=;
        b=boEv99Alzg6cPbETkNH72ehzATXFLMi5L3muYvYsEn/vKqkvsCs1VdacBOyJpuE0N9
         /RiBOILz34hEQ06GMFwyq7fIDpy8/fsTesXOsvHRgDwhs6aAYEAJOE3siuM5BFHieTVc
         1QBC2R6vyZUP8e3ACeDowMLf3pXC8YeRdpx6O6fF0tf87oJHYuLu/93+ZGIww1e/YC8A
         RxOHBwucOrOR6Opexh2tUF2w5dDuZXmJ1+dXRv2YKsgjflGj1dd3ObIOq5xQD+oQ3Fyz
         OsuFogZisOa/u4a0Km3JfSnfWScn0V00W2g9UA+R126iqo7tmLlI7sUhj3RDLDQyDaSQ
         Scqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/WJ0tqMozkcFwQbk0zwDH9itMdQXF9SUhVNLVNoj+0=;
        b=R+pvpOXOfdU3j8dRwuHIB8R2k6J68NnLkP7MJfAR1nFOqBktiimZX0x/lOhJkpFCkG
         Irh+JKnwh4Ob18IRbuqGOFtrPpd9K7owwiCOEFczANsEJCRFP2qZg7OdNrc3f6hOzibg
         iaFW7RMzp4pA/UONtLR7v3F1CSvzZ9t5bkbx7Xq8n0kd7GokzM4T6zndPoWaqIaKxshW
         bSNycLbZmrp7/GBWOhdWCBAvfgHfvlbs4n1UaLK3DpqT+elVHrSFQnlRvBwg4VfkgKmX
         VGWNO0fQfIz/uEvZINIL+4NiNp0WMyUj5niBvCWdo9UOmCy4o3QE8zHIvyVatzRZOoxW
         Zbyw==
X-Gm-Message-State: AOAM5339yoPSdo4P7bsw20HYC+oQEGI8ORrl3UQtX4XNVXbUk2fn0Lx2
        nm4Iq0h3tTHACC49t3syKpDihcacAT2dgyo1Yq9oUQ==
X-Google-Smtp-Source: ABdhPJxdJ7AeCc3WGwsxm2aWitYelOiSZyUAsthyGttVRji7k1IxzTQn213OcxxbKtIt5MCydz7+Y7/NhLVt1QyP9b0=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr13432121lfg.254.1651656944773; Wed, 04
 May 2022 02:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220426141507.89868-1-ulf.hansson@linaro.org>
In-Reply-To: <20220426141507.89868-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 11:35:08 +0200
Message-ID: <CAPDyKFrxr_t5iCa4E5Obvzk25wQbLCoY2Co=8iG==WfbBhpRVQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PM: domains: Some minor improvements for genpd_power_off()
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 26 Apr 2022 at 16:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This small series intends to improve some of the execution paths when powering
> off a genpd. More information is available in the commit messages.
>
> Ulf Hansson (3):
>   PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
>   PM: domains: Drop redundant code for genpd always-on governor
>   PM: domain: Don't check PM_QOS_FLAG_NO_POWER_OFF in genpd
>
>  drivers/base/power/domain.c          | 10 ++++------
>  drivers/base/power/domain_governor.c |  6 ------
>  2 files changed, 4 insertions(+), 12 deletions(-)
>

Rafael, I have another slew of patches for genpd that I am getting
prepared to submit. However, it would be nice to get @subject series
queued first. Is it ready to go, you think?

Kind regards
Uffe
