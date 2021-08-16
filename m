Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5F3ED915
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhHPOny convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 16 Aug 2021 10:43:54 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42687 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhHPOnn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 10:43:43 -0400
Received: by mail-ot1-f47.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so6288337otk.9
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 07:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o3zIYhRKMYiOatvKkPmccElA+Ur3dI0oD6LCYLtXsM8=;
        b=O0jm+OOm0O4ciHOT/q7fYDWF5w2b0dP+tAF/XhoagWpNYXnF64FcWGm/9xTrEX/mgG
         OL+8HS380EJvk0i6+7SS+SBE06rkYou6LWJ1ysF1bUDEALC+QsJK+t+OzvEMolHtLc4k
         fpezJxTam/4gojOnvNvYW1kZri1ln6O1Y2Q/viVU2I3ZzzQ7lVyBgCyUojG3utKhyyEi
         ZwyRz9vnFvtG3KFrof1IK8wr+ichtc++oegDE69a9Cotd0w7h3R//ND0vA0uFqK7AtKM
         6rJX3iI4VMT2fcjH770jUt1HaHiO956aO65EMGRcg+EWXPidWix57rcMAP41F3GA4JC1
         d0vw==
X-Gm-Message-State: AOAM533e1/13dr/qtfvkaejx5QgIdqeVTg+IF04V9KTWbfs0KZ0lnbt1
        SGs7zBhG6jN/v/uXt/iw/0telPZAGKuFUw4sf30FjyVo
X-Google-Smtp-Source: ABdhPJzO0GJfZsW5LoZhQwwu/hFlQaP9U+IzDO6CTemReRJRU7prbL5VEKLkSIH+wEEFhuNwY9W33zGkZjnIvi/nVGk=
X-Received: by 2002:a9d:7396:: with SMTP id j22mr7703499otk.206.1629124952068;
 Mon, 16 Aug 2021 07:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210810085838.d3hv3rxli5vxozlz@vireshk-i7>
In-Reply-To: <20210810085838.d3hv3rxli5vxozlz@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 16:42:06 +0200
Message-ID: <CAJZ5v0j4N+puor2x2_vqB-zaJe-m_-pv6cipV_fCbRyKAd6Zgg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 5.14
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 10:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains:
>
> - Addition of SoCs to blocklist for cpufreq-dt driver (Bjorn Andersson
>   and Thara Gopinath).
>
> - Fix error path for scmi driver (Lukasz Luba).
>
> - Temporarily disable highest frequency for armada, its unsafe and
>   breaks stuff.

I wasn;t able to pull last week, sorry about that.

> -------------------------8<-------------------------
>
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
>
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

And now it looks like there's more stuff on this branch.

Can you please create a branch with fixes only and send this again
with respect to that branch?

> for you to fetch changes up to 484f2b7c61b9ae58cc00c5127bcbcd9177af8dfe:
>
>   cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant (2021-08-09 09:31:22 +0530)
>
> ----------------------------------------------------------------
> Bjorn Andersson (1):
>       cpufreq: blacklist Qualcomm sc8180x in cpufreq-dt-platdev
>
> Lukasz Luba (1):
>       cpufreq: arm_scmi: Fix error path when allocation failed
>
> Marek Behún (1):
>       cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
>
> Thara Gopinath (1):
>       cpufreq: blocklist Qualcomm sm8150 in cpufreq-dt-platdev
>
>  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
>  drivers/cpufreq/cpufreq-dt-platdev.c  | 2 ++
>  drivers/cpufreq/scmi-cpufreq.c        | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
