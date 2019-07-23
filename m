Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5223A7176E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfGWLtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 07:49:52 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46266 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLtw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 07:49:52 -0400
Received: by mail-vk1-f193.google.com with SMTP id b64so8568996vke.13
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCc8oz4uiY5oWVmZXIo5sT3kYxDAiMvuCiy1W2eyWGs=;
        b=IcKy60K678v+J0heI68tZHz8GPQxO3NxVDFj7+zJrF5AlvdfaU4g7QvRBm4WzK2N23
         pDKiRHpCNnOLUYPIN99LoT+yt2FC3qBbHHQCKxLUEjiAu1+4X7mxR23Ke87joLy6cjbI
         s3/6QiwZIo4K0jxG1wUGV+ZYdWyrhdjWi+nN9ZjiCyoRpATnDAt+2ggPiQacmFtWkrVD
         BrcbtUmBD1XehP1guAAKJcsNS9FBV6Hj/B9IQZitsYgSfyYPTwanhyZrQB7wwo4flyGj
         NNhILO8zBbNZ6oupsz5WyUKBloxPApdSZeMXiRE1p5gl+NEcbn5V4bIv7J/i7P9twUoG
         bIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCc8oz4uiY5oWVmZXIo5sT3kYxDAiMvuCiy1W2eyWGs=;
        b=FSZqAioYzE7PIWj8eKSts8TwplQ6Vg+7ewRvMXIcGzrfhEFaRrRSKAdFzxWrOJst4s
         cRV7y8bvJgaeMmXX6LKryEGixv2vbQx8gWRWVMpdB2Kdgol/6hphuP2ITKQQpxng2jG4
         75sgKYQ0QhW0go+HvUzML+7B226iZpHiQRh/4OLrzND2nQaUvA6N8DkB0ju7gN8EJQTi
         itwFNMugoPkzCQDRjHTIH6RoIcwgtHGEq85N+7u1JOMS3MShWbU5QOLHYIRR/rDa6Qv/
         BfrvEq9btJ0UUCAtrmHFts6170UBP98lLRMbEZvGrnp2B6KufwlZSbzCdf8H3hrNIzEy
         Awzw==
X-Gm-Message-State: APjAAAUUlT3BhlwUn0j7rrqEkPljMNP2lkBPxiaATtCBV1ofyoi2O8xo
        mCZiN7PBWBmxXiVFKg7dZ12VpUI3oq1PYcK+tHoSWQ==
X-Google-Smtp-Source: APXvYqzQew1R0hp4RpT558NdXJ2lVRHSHKaFuji8MnNl0ExroDkpLeuQgO9KGA19hr8dIxNU/dxd/h2ROvbh8X67rj0=
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr27496163vkk.36.1563882591235;
 Tue, 23 Jul 2019 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20190722153745.32446-1-lorenzo.pieralisi@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Jul 2019 13:49:15 +0200
Message-ID: <CAPDyKFqAMhx_8T5FF7MujYc7HuNVAfCYx4j1UEfesuCc-TE-rw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARM: psci: cpuidle: PSCI CPUidle rework
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 22 Jul 2019 at 17:37, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Current PSCI CPUidle driver is built on top of the generic ARM
> CPUidle infrastructure that relies on the architectural back-end
> idle operations to initialize and enter idle states.
>
> On ARM64 systems, PSCI is the only interface the kernel ever uses
> to enter idle states, so, having to rely on a generic ARM CPUidle
> driver when there is and there will always be only one method
> for entering idle states proved to be overkill, more so given
> that on ARM 32-bit systems (that can also enable the generic
> ARM CPUidle driver) only one additional idle back-end was
> ever added:
>
> drivers/soc/qcom/spm.c
>
> and it can be easily converted to a full-fledged CPUidle driver
> without requiring the generic ARM CPUidle framework.
>
> Furthermore, the generic ARM CPUidle infrastructure forces the
> PSCI firmware layer to keep CPUidle specific information in it,
> which does not really fit its purpose that should be kernel
> control/data structure agnostic.
>
> Lastly, the interface between the generic ARM CPUidle driver and
> the arch back-end requires an idle state index to be passed to
> suspend operations, with idle states back-end internals (such
> as idle state parameters) hidden in architectural back-ends and
> not available to the generic ARM CPUidle driver.
>
> To improve the above mentioned shortcomings, implement a stand
> alone PSCI CPUidle driver; this improves the current kernel
> code from several perspective:
>
> - Move CPUidle internal knowledge into CPUidle driver out of
>   the PSCI firmware interface
> - Give the PSCI CPUidle driver control over power state parameters,
>   in particular in preparation for PSCI OSI support
> - Remove generic CPUidle operations infrastructure from the kernel
>
> This patchset does not go as far as removing the generic ARM CPUidle
> infrastructure in order to collect feedback on the new approach
> before completing the removal from the kernel, the generic and PSCI
> CPUidle driver are left to co-exist.

I like the approach and I think this series definitely moves things in
the right direction.

Of course, some additional cleanups/re-works on top are needed to show
its full benefit, but step by step we reach that point.

>
> Tested on Juno platform with both DT and ACPI boot firmwares.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> Lorenzo Pieralisi (6):
>   ARM: cpuidle: Remove useless header include
>   ARM: cpuidle: Remove overzealous error logging
>   drivers: firmware: psci: Decouple checker from generic ARM CPUidle
>   ARM: psci: cpuidle: Introduce PSCI CPUidle driver
>   ARM: psci: cpuidle: Enable PSCI CPUidle driver
>   PSCI: cpuidle: Refactor CPU suspend power_state parameter handling
>
>  MAINTAINERS                          |   8 +
>  arch/arm/configs/imx_v6_v7_defconfig |   1 +
>  arch/arm64/configs/defconfig         |   1 +
>  arch/arm64/kernel/cpuidle.c          |  50 +++++-
>  arch/arm64/kernel/psci.c             |   4 -
>  drivers/cpuidle/Kconfig.arm          |   7 +
>  drivers/cpuidle/Makefile             |   1 +
>  drivers/cpuidle/cpuidle-arm.c        |  13 +-
>  drivers/cpuidle/cpuidle-psci.c       | 235 +++++++++++++++++++++++++++
>  drivers/firmware/psci/psci.c         | 167 +------------------
>  drivers/firmware/psci/psci_checker.c |  16 +-
>  include/linux/cpuidle.h              |  17 +-
>  include/linux/psci.h                 |   4 +-
>  13 files changed, 338 insertions(+), 186 deletions(-)
>  create mode 100644 drivers/cpuidle/cpuidle-psci.c
>
> --
> 2.21.0
>

For the series, besides the minor comments I had on patch 4, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
