Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62B358BEB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 20:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhDHSIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 8 Apr 2021 14:08:09 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34386 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSII (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 14:08:08 -0400
Received: by mail-ot1-f54.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so3205171otn.1;
        Thu, 08 Apr 2021 11:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hha4WLCdP1Tred4k8z/7+ghIuMbscDUDnCCYfhCr11w=;
        b=byDsUxX0YiP8fNBxdqfK06Zyr5g5Ompu49RXYgrUN2bqs2DUJvVJSH4iKD8wiPQpWw
         G1YMTqmDu6rXG8/mdzLCbDjHrnAwCYgCBiRFnTHAL6jO42VlIJ+KeQdoNbt5NmKT0JrG
         +D+po84FGQtKdm83VgSO5yjXw4ZFIuU6R+VfFAeQVrZtPbSYo2eqEHp8RhmEz7Xoi0qH
         qaQ1W+O+UCrvkhbxChECAqi0Ip6LY7W5kgwlol61gnFxYnLcLqsQf+0tDY+hvqO2GSp1
         whsmgRvuKJbHTx8cCTKMfyrPTYmnfNhaSNA8IgczzjLASkCSi6znm6lJ2q7eB3LUWi7/
         dIYA==
X-Gm-Message-State: AOAM531Dx6USESkOH43my+KG1Bj39n7ctl30nuo7zSI6PcS8xwO/APPT
        Aw1SuJeXn0QRu5aJCTJ8Nh2kEq26jqS/FGJOt6s=
X-Google-Smtp-Source: ABdhPJykvn7GHTDQHeTAFgBSw7yNPQg2mzia76ADzeIDipJKfYEn0lTtjqQl9KkkV6NzPvEFXkUXGHAqnKu5tpw9NOM=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr8762177otb.260.1617905276522;
 Thu, 08 Apr 2021 11:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <03743d3c-a3bf-066f-614c-1a49f566fdb2@linaro.org>
 <CAJZ5v0iGQGRvjaesmvvxpmot9vkyEEVWHkj3Wka24xZCzL351w@mail.gmail.com> <4b8b0bc5-492c-7e95-9b08-ab87c9ac65d5@linaro.org>
In-Reply-To: <4b8b0bc5-492c-7e95-9b08-ab87c9ac65d5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 20:07:45 +0200
Message-ID: <CAJZ5v0iT28V07sg1cPTvNur4=y=H7pBw2FQZNMoMggmDVsWh2A@mail.gmail.com>
Subject: Re: [GIT PULL] cpuidle for v5.13-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        He Ying <heying24@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 8:02 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 08/04/2021 19:24, Rafael J. Wysocki wrote:
> > On Thu, Apr 8, 2021 at 5:10 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> please consider pulling the following change for cpuidle on ARM for
> >> v5.13-rc1
> >>
> >> Thanks
> >>
> >>   -- Daniel
> >>
> >>
> >> The following changes since commit dde8740bd9b505c58ec8b2277d5d55c6951b7e42:
> >>
> >>   Merge branch 'acpi-processor-fixes' into linux-next (2021-04-07
> >> 19:02:56 +0200)
> >
> > Can you please rebase this on 5.12-rc6?  My linux-next branch is
> > re-merged on a regular basis.
> >
> > Generally speaking, if you want me to pull from a branch, please make
> > sure that this branch is based on a commit present in the Linus' tree,
> > preferably one of the commits tagged as -rc or a specific merge.
> >
>
> Sure, here is the pull request based on v5.12-rc6 with the signed tag
> cpuidle-v5.13-rc1

Pulled, thanks!


> The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:
>
>   Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux tags/cpuidle-v5.13-rc1
>
> for you to fetch changes up to 498ba2a8a2756694b6f3888857426dbc8a5e6b6c:
>
>   cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration (2021-04-08 19:54:14
> +0200)
>
> ----------------------------------------------------------------
> - Fix the C7 state on the tegra114 by setting the L2-no-flush flag
>   unconditionally (Dmitry Osipenko)
>
> - Remove the do_idle firmware call as it is not supported by the ATF
>   on tegra SoC (Dmitry Osipenko)
>
> - Add a missing dependency on CONFIG_MMU to prevent linkage error (He
>   Ying)
>
> ----------------------------------------------------------------
> Dmitry Osipenko (2):
>       cpuidle: tegra: Fix C7 idling state on Tegra114
>       cpuidle: tegra: Remove do_idle firmware call
>
> He Ying (1):
>       cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration
>
>  drivers/cpuidle/Kconfig.arm     |  2 +-
>  drivers/cpuidle/cpuidle-tegra.c | 19 ++++---------------
>  2 files changed, 5 insertions(+), 16 deletions(-)
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
