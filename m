Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9771B4FF9D5
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiDMPTK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiDMPTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 11:19:10 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC45252AD
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 08:16:49 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e71so4313473ybf.8
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 08:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9DqIC2bHmQHNK2I7tJoTIp/jQ3ba+WlywWXlfKyZlY=;
        b=YKWnCjtjT+XLN2lzRe6Q2I6oVsdNQKKnlccFppaDbUljjzRGYEFPPAXmf1V6Tdv/gp
         Vqk6RbSMciffS0te75E3Wnz43D2kbinxwAaV4S5Ra6tWl5fuqeLJxylETNh89ZhTnY27
         74Vrf09R1gOJ41zqH/dGchv64s2L3m8bQr3wRYIAI/pbfixfE2EVHEPiggeTZUYWxveL
         htMcFkwVaXWVwwj5qXtSfTDYuY70JFUBleGGpOuONEOLLlL99VxySv3b4Ighf/CURuAo
         0T3rs+1CgnTXq3F0T+LJC3z+NW2Kbrj9ei5TJM8f5CnWi2AXexKPXlFAf9XGMuH+3dpI
         gi3Q==
X-Gm-Message-State: AOAM532/VKDkt0RksB7Kb4Fe7bpJ4IBaeKoJu62X5QDrFjWH/dT7iQPO
        7zY+D13aqiaZdAtdqN62piQwKY2R3RDmV+VzNNs=
X-Google-Smtp-Source: ABdhPJyHv+JSlsItq+c52Arc06WnvW4WnM5vinuvjvkMaQoR9rPCfl8WFYQaND0hc8yRJTVGT+ASPK2g7TeTEdmuVxY=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr11903048ybi.633.1649863008269; Wed, 13
 Apr 2022 08:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220401141124.27272-1-ulf.hansson@linaro.org>
In-Reply-To: <20220401141124.27272-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:16:37 +0200
Message-ID: <CAJZ5v0gt0L-6TNTqD15LvLfpHfn2GZr2EMSxfaiXGeOqjkx4XQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime/cpuidle: Improve suspend-to-ram support
 for cpuidle-psci
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 1, 2022 at 4:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Maulik Shah reported a problem with suspend-to-ram for one of the Qualcomm
> platforms that is using PSCI OSI mode. Briefly described, the genpd on/off
> notifiers doesn't get sent when the boot CPU is turned on/off, which prevents
> the needed platform specific operations to be executed.
>
> This series intends to solve these problems.
>
> Note that, I have tested this on Dragonboard 410c, with some local hacks to the
> PSCI firmware driver. This was needed because the PSCI firmware didn't support
> SYSTEM_SUSPEND, so I basically made psci_system_suspend_enter() to call
> cpu_do_idle() and forced a suspend ops to be registered.
>
> Maulik, can you please test this at your setup?
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (2):
>   PM: runtime: Allow to call __pm_runtime_set_status() from atomic
>     context
>   cpuidle: psci: Improve support for suspend-to-ram for PSCI OSI mode
>
>  drivers/base/power/runtime.c   |  9 ++++---
>  drivers/cpuidle/cpuidle-psci.c | 46 ++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 4 deletions(-)

Both patches applied as 5.19 material (in the PM-sleep category,
because they really are system-wide suspend support material).

Thanks!
