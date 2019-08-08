Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0D86293
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfHHNEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:04:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41607 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732429AbfHHNEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 09:04:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id 2so62932757vso.8
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2019 06:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVPeB+St4GsfV4+rvU+wUWYIPVqFTU7qMjefLsTGDCk=;
        b=B0zU9BKtNhlSEKo6kKYAsY4u7PN+VPvRfvn+58jakXBjrysCX6tUOR7URHJIAMEm4q
         RH3G9v787hEUo9uudsxNZ/U5ymkg8YKbZ9X/sFY0l7Chji4cFFfnvMFaNqBl6IEoKvIu
         ADqhq3f1tsOe6K0RMz6rDuj0VIcE4rjQAalVJeVcjaADUo9YPkBV74qrFtI1gRRuc6RK
         uExR/PtW0Id9fobcvztepC7ZqnrMal9PRifw+s8uNyVZi4nF4O7ninIYFkmg1JKoOAUL
         zuc0HscZLEHCXMIkIxEZcOarnQu7QnnEri6lOX/k6qxN94tmfvREhBnWrnF/pA35X1Xk
         LtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVPeB+St4GsfV4+rvU+wUWYIPVqFTU7qMjefLsTGDCk=;
        b=H1OIYxiKtJSNwgj9pK/a3llnr/l6HRkFUcCs+Z8VSmuwYuQQPHMtpmOgtKkjJV98GG
         1X3cK1LO8v2dlBiR9CGALGeRA9S11P+pFXw/fAH78wOx1StVDU/08Qh5ujcJ9Ir+nYhM
         ReblTWMh2ZRUJzGw32iYkHELiY1968tl3gUDn7LdQYXHZwLxh5xiUeZdn5SAMlNeWj9U
         gvRjPiKuWC+okYctSB8lNA5m9c0+mLEWvv1tIwxoYmU6I0+AE2m7hKsA9w/03xpxewP3
         eoFRghhz3qZ8PhVTW5642NY/FbcgmMqy99qnFMEm3utAJW7JpRaPd0/QfT/tF3KCWAe8
         eZ3A==
X-Gm-Message-State: APjAAAVGtR/16/hKT9b4kGoir+4Mkwk51afE9GW4p+ujfS8XdxkcRtwf
        fL0edFlMX/W7uaCXw8in6GBEqE7kJvKBjol78TLtWQ==
X-Google-Smtp-Source: APXvYqwz4sEsZKLGse5oWlgt5eN1TzALbdcsnHo96qnOT8qI6DXH4l2SvV6vxlWxJGY6nX4j8iQr0jJNPuU3PgiNq7U=
X-Received: by 2002:a67:fb87:: with SMTP id n7mr9548609vsr.9.1565269488210;
 Thu, 08 Aug 2019 06:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564091601.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1564091601.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 8 Aug 2019 18:34:37 +0530
Message-ID: <CAHLCerP4v_Lz5OGswx7+Z5uHVq_D8G5brq-_M6fOc0K6DK2OKg@mail.gmail.com>
Subject: Re: [PATCH 00/15] thermal: qcom: tsens: Add interrupt support
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, sivaa@codeaurora.org
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Brian Masney <masneyb@onstation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 26, 2019 at 3:48 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Add interrupt support to TSENS. The first 6 patches are general fixes and
> cleanups to the driver before interrupt support is introduced.
>
> This series has been developed against qcs404 and sdm845 and then tested on
> msm8916. Testing on msm8998 and msm8974 would be appreciated since I don't
> have hardware handy. Further, I plan to test on msm8996 and also submit to
> kernelci.

Gentle nudge for reviews. This has now been successfully tested on
8974 (along with 8916, qcs404, sdm845). Testing on msm8998 would be
much appreciated.

> I'm sending this out for more review to get help with testing.
>
> Amit Kucheria (15):
>   drivers: thermal: tsens: Get rid of id field in tsens_sensor
>   drivers: thermal: tsens: Simplify code flow in tsens_probe
>   drivers: thermal: tsens: Add __func__ identifier to debug statements
>   drivers: thermal: tsens: Add debugfs support
>   arm: dts: msm8974: thermal: Add thermal zones for each sensor
>   arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
>   dt: thermal: tsens: Document interrupt support in tsens driver
>   arm64: dts: sdm845: thermal: Add interrupt support
>   arm64: dts: msm8996: thermal: Add interrupt support
>   arm64: dts: msm8998: thermal: Add interrupt support
>   arm64: dts: qcs404: thermal: Add interrupt support
>   arm64: dts: msm8974: thermal: Add interrupt support
>   arm64: dts: msm8916: thermal: Add interrupt support
>   drivers: thermal: tsens: Create function to return sign-extended
>     temperature
>   drivers: thermal: tsens: Add interrupt support
>
>  .../bindings/thermal/qcom-tsens.txt           |   5 +
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 108 +++-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  26 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  60 +-
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  82 +--
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |  42 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  88 +--
>  drivers/thermal/qcom/tsens-8960.c             |   4 +-
>  drivers/thermal/qcom/tsens-common.c           | 610 +++++++++++++++++-
>  drivers/thermal/qcom/tsens-v0_1.c             |  11 +
>  drivers/thermal/qcom/tsens-v1.c               |  29 +
>  drivers/thermal/qcom/tsens-v2.c               |  18 +
>  drivers/thermal/qcom/tsens.c                  |  52 +-
>  drivers/thermal/qcom/tsens.h                  | 285 +++++++-
>  14 files changed, 1214 insertions(+), 206 deletions(-)
>
> --
> 2.17.1
>
