Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8C70DAE7
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 12:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjEWKwX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 23 May 2023 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjEWKwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 06:52:14 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FADE50
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:52:04 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-94ea38c90ccso90048566b.1
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839123; x=1687431123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeR2559/IBhCTk+4cTxI4IyLsNHqo6jbECyyR2Nc+pk=;
        b=Jtb5DYzMQh5j397OqZ1FBml8nNpPzk79S1qz0cIxmSGebPoBTADQZbbqr5wX/zYVqt
         LY9HctLCUMxPGoBsbE0Ndf1NgX6xd5VrCCe6uPy+uR+BjPjcXNpJ9IyHMtegdh94PBgF
         fRiUCdvJTvZ6qBFOEPB/GCTWIMLRaJNrqSud7qZzCZrLs5xaKmZuKkqVzYUxBjEtpOGb
         jzohQyBSwJW8SfY+kKLmBet8bhEkzdTvIXUv7QQfdvmahPIhrk81PFN/CImvuFD2SCHw
         x/r/0WuOt4+g35lVisFRKs72n2sqPNKMZZjvHMdAc//PlqGz+BGlAs544NMZQ2ZeSJoV
         ZvRw==
X-Gm-Message-State: AC+VfDzxSC2ItKpA+7cothz4T5zuLrchOuRDkId8u7bA1Ent/WAfCJfa
        4fXJExDq3inOmNDDZ9Q7Fx08SgvwhdFHD36PRKs=
X-Google-Smtp-Source: ACHHUZ7dFsUmMoI8pNQVyraKDrNF1E1YQzV4Merv92Hu5DIAgNFBPyPVEWaHuJM1sJWMJ5nDQnfE6PAbuOBYdY0WeME=
X-Received: by 2002:a17:906:748c:b0:965:9c7d:df96 with SMTP id
 e12-20020a170906748c00b009659c7ddf96mr13003047ejl.1.1684839123232; Tue, 23
 May 2023 03:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <abcc6689c283bbe91b6fd16572cfd4a8d5e78cc6.camel@linux.intel.com>
In-Reply-To: <abcc6689c283bbe91b6fd16572cfd4a8d5e78cc6.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 12:51:50 +0200
Message-ID: <CAJZ5v0gNC+39S7snmYNfRmTmFWXhftjYCDkHYMoCxWHCt7r4rg@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas,

On Tue, May 23, 2023 at 12:34 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, 2023-05-22 at 19:12 +0200, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > I'm going to submit a Power Management and Thermal Control
> > micro-conference proposal for LPC2023 along the lines of what
> > happened
> > in the previous iterations of it.
> >
> > If you have topics that you'd like to be discussed there, please let
> > me know by Friday, May 26.
> >
> > Please note that LPC MC topics are expected to cover work in progress
> > or at the concept stage.  They are not  supposed to be about work
> > that
> > has been done already.
> "
> 1.
> Idle injection and soft IRQs:
> We still have no good solution to avoid races with soft IRQ scheduling
> while using idle injection. The previous post to kernel to solve this
> issue is rejected. Peter proposed a change, that also didn't work.
>
> I am proposing a discussion on how the solve this:
> - May be we need to use some in kernel IRQ affinity change for the
> forced idle CPUs
> - Other potential solution?
>
> "
>
> 2.
> Thermal sysfs/API Update
>
> Thermal sysfs v2
> There was proposal to correctly abstract thermal zones, sensors,
> cooling devices and policies. Are we happy with the current state?
>
> - Add capability to define additional private attributes for a zone
> like cpufreq

Good topics both, thanks!
