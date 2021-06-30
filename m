Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7147F3B829A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhF3NC2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 09:02:28 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42511 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhF3NC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jun 2021 09:02:28 -0400
Received: by mail-ot1-f54.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so2567967otg.9;
        Wed, 30 Jun 2021 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXAIdi0xNmG5NEoCovX1fvUaYsQ0NHqGfhMkmms0NEg=;
        b=h0AAJd+dGeXDuqupecrzU45mhfrYBsVxIM8mZB3EK7LxO6uC1XvdVUIHgUe9MvfFFW
         aJmy5v6Jw+0QBezQ/n6qmbVe3TsNURZQzDd4PSmUoyKNlMVvcKk9mPkYOYzK4/sdHKlh
         BWE15L4tiR/hTFVMO9PwdxMOKZI6mFPKwcfsZFYgAzW/YJeZwMFdebIp0TL/EMzsV6i8
         w4ZfR/0dOme6wI9L+riPseYmnzYMqFCBMdpRaIJqd8WxD83RhVyrZY1aANf+MdD/Vkx4
         pxL22G1z3kzR7zkJysfyl1lpZY9Q5U0RW3pngL7lAHni0t4ifat2LI4KTWoA3Ff9OIDD
         o4Ow==
X-Gm-Message-State: AOAM532Q64s0DiX+fIdrvbDS0vYnA3EQ18DdIB6nLok03A/crh+CWHKJ
        PdSgQDWUQCqeai0FzKXG+HKEXbNF4E10coWfC2k=
X-Google-Smtp-Source: ABdhPJwa4GI+6mvvfdfOgELd65bIALzlz5ITBKs10VLxLSSKBygf2EOizEN/g2ihvFGV/l/Q5dqb/R/W0sozl0jo9d0=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr9015714otm.260.1625057998154;
 Wed, 30 Jun 2021 05:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <da5ee4be-e62c-53d0-167a-55f6bc5bab4b@linaro.org>
In-Reply-To: <da5ee4be-e62c-53d0-167a-55f6bc5bab4b@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Jun 2021 14:59:46 +0200
Message-ID: <CAJZ5v0iYt65Jtf6aJUVHp_FtDotT79KzcLFSLzrgGnARxRM6+g@mail.gmail.com>
Subject: Re: [GIT PULL] cpuidle for v5.14-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 8:44 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:
>
>   Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/daniel.lezcano/linux.git
> tags/cpuidle-v5.14-rc1
>
> for you to fetch changes up to 0f0ac1e4eef2753d4f9cd0117019da9501921fef:
>
>   cpuidle: qcom: Add SPM register data for MSM8226 (2021-06-16 20:03:26
> +0200)
>
> ----------------------------------------------------------------
> - Add support for the Qcom MSM8226 (Bartosz Dudziak)
>
> ----------------------------------------------------------------
> Bartosz Dudziak (2):
>       dt-bindings: arm: msm: Add SAW2 for MSM8226
>       cpuidle: qcom: Add SPM register data for MSM8226
>
>  Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt |  1 +
>  drivers/cpuidle/cpuidle-qcom-spm.c                      | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)

Pulled, thanks!
