Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED4717DAD
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjEaLHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 07:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjEaLHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 07:07:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0211E8
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 04:07:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so2076787a91.2
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685531257; x=1688123257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVSiS0Mc8nxseUz2EN6kwrL5Hhv0xKZ8/kyJz7nOUZU=;
        b=yXyOte9bE1OBPTr2TobC/sY+XiVcG0MLCXBfImNSG49GfOQqNXzILNkFeAnHUMJ6P0
         WIZ3C8vyKudrfkyiqMwSWvLYz2KZNLCZe5C7F4C4DiaY90wBS9yW95cXVQs+2Dyf1I22
         BY9BXLE7d+uX8DWdeZCsiBUaL/d7hmNgp2KIAFFJT98liOs3MyLryRHRDDbcppmdBFUb
         EzgmfN8ezpd0DRiFDfGZhth9Uw5DRiTT5JyUTpKNM/zryGrwAljJzabg1ZonB+BAlM3F
         7o3yVdOThky/F0X4s4omODvBnBjsJJvEp3HrDV9jw3ecpBKabTVyaFaAzLAfM+ze3HvK
         Njdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531257; x=1688123257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVSiS0Mc8nxseUz2EN6kwrL5Hhv0xKZ8/kyJz7nOUZU=;
        b=S9QG7odkddv0zpeuTOXRk2gCNgRZtmtKRuIiXRCZ5XHrrGFL03E/+wtmWG9fhHt0Af
         RvIPjUMvWOOdJAjFoqBbu449DXSrk4xHa5eAMz/aynQGC/Y75I2fopSrR+vv+0SaZ25I
         Lgk7vnIvsZnN0dam/BxR5PgmZggi7ssk2K2lWUbKftIj8B4WyBXULHPhQvgW8GbKA61v
         OwhLGSZOzl4Fv9xCf7bXtP5dd7GZkRnlEsfmxxo6kZ4I1880f72OmkEBuC3d+rOHuMcB
         IcM92d9X8vH/QwQ0mJnWSjUYapULUXJA2/Oucqx1V9SuKigF0S6J/6AXPJelCEXCcg2X
         15ew==
X-Gm-Message-State: AC+VfDzzXmu6Ri4S7GK66ApXj1FCMWce6TpSRm/3DWym6iS8f0RA8hoK
        5TFx1Djs4E5mEoK0XIS2729m9f0/I79Nyh2WP7a7Uw==
X-Google-Smtp-Source: ACHHUZ5UgYEq44wSjGALp+A+rRzAc+zQCT9MVZCPD6uHYn9TTXz9Xs6iTjrBnM9mnP3A7Jzg9119QuEX5MsGkIXMXLY=
X-Received: by 2002:a17:90a:fb46:b0:24b:7618:2d16 with SMTP id
 iq6-20020a17090afb4600b0024b76182d16mr4190402pjb.31.1685531257107; Wed, 31
 May 2023 04:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <ZHcebApf6WCPMxPa@R5WKVNH4JW>
In-Reply-To: <ZHcebApf6WCPMxPa@R5WKVNH4JW>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 31 May 2023 13:07:26 +0200
Message-ID: <CAKfTPtAkCTE+Ef1yqc-CqftfmQnCzm85gpMrWWm5s=qK85Xk1A@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
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

Hi Morten,

On Wed, 31 May 2023 at 12:16, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>
> Hi Rafael,
>
> Thanks for organizing the micro-conference at LPC again this year.
>
> On Mon, May 22, 2023 at 07:12:39PM +0200, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > I'm going to submit a Power Management and Thermal Control
> > micro-conference proposal for LPC2023 along the lines of what happened
> > in the previous iterations of it.
> >
> > If you have topics that you'd like to be discussed there, please let
> > me know by Friday, May 26.
> >
> > Please note that LPC MC topics are expected to cover work in progress
> > or at the concept stage.  They are not supposed to be about work that
> > has been done already.
>
> A late proposal, if the agenda isn't already full, is to discuss the
> deeper implications of uclamp in CFS relating to fairness, latency, and
> energy savings. uclamp is being adopted in the Android community for
> controlling performance/energy savings but alignment with upstream is
> lacking behind.

With Daniel, Juri and Steven, we have submitted a "Real-time and
Scheduling MC" which is not yet accepted (so it's not yet publicly
visible).  But this could be a better place to discuss CFS changes.

Regards,
Vincent

>
> "uclamp in CFS: Fairness, latency, and energy efficiency."
>
> Thanks,
> Morten
