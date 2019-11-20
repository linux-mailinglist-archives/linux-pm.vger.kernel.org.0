Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629A9103958
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 13:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfKTMAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 07:00:43 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43808 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfKTMAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2019 07:00:43 -0500
Received: by mail-ua1-f67.google.com with SMTP id k11so7669925ual.10
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0tsxj8KZGAT/o1qcGiW6HKsR+OIwQVXMM2ODuLvIpk=;
        b=EqVhZA3XS/izMBNsikllPUdPo/A4jO0CJ2WlCc6sonVPI2GnfaVvbdDuNlHdyVmBWs
         04nfUBbI06D35YPWUGTFpPWM+eHRl7KJqzvMQZ83STlGgvja0fblAtHeSfAFZaJtrKA1
         zmFiNtK3ttF7B1Fj4bDCbrnfA1x2DjrISFT4bYrf4bnivgaf2hWaN/7r/wMso4uvtHqe
         shcCcvg8GlTnd3B7NHCeEdi4N+JTWa5XVlWqJoGC8NG0l9O8cxzUQYX3uLaU9pld4Ptn
         uKq5VO98MpAoB+6hx23bKtwlM4Kx3cxqoTlHoH7OXOjuf6SVEg0kUKz7XdpkTWoKVgaL
         HNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0tsxj8KZGAT/o1qcGiW6HKsR+OIwQVXMM2ODuLvIpk=;
        b=VRJn1qExIYCS7mynMLoKp4VK46Bhy+bXnjRC2FsE1032wj3g4619CjsniLPyPhVWen
         53aslnmHTjEWuxyGUr0iAn/skQw1Fn/vsAB0FYxe1+i5jjwIQf8tPKkgSo7yfTYiYVtH
         Ekb4GghW2vwvOcv45lR1UZ00IiNvFtDUIxIHaFyUfhwujkK6im3+AMhnmIzgDBF32Ahr
         fGeQhO31wbVDbKA6MkxpKLj6WE7Ntzmil3dPJxo26knFMyt6wEaKI+zctEy4nAzOrfaD
         ojcPh+L7ozCOw7fuO8JU3a2s8qTnFTljW4ygUgXFNscvzdQEjRUmfAZzn9ozn/hTUlxE
         IXKQ==
X-Gm-Message-State: APjAAAUxHlPFXCJWUIkLfqJ8byvm5kSorhdP5OXUbegK0PNyxA9hD/AC
        iOfgpzKGr+qcFB/u6+acp3q1G8u2JBUeHMW7mMiC7g==
X-Google-Smtp-Source: APXvYqyiLCF3MBQoSmzlqqxli2MvGV261pRD3zdGvysKb7s9Nit3G2b6p/dRiZmGs4K0UtVDM+P1vhy5Y89wBip3NWE=
X-Received: by 2002:ab0:74cd:: with SMTP id f13mr1351834uaq.104.1574251241748;
 Wed, 20 Nov 2019 04:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20191119154621.55341-1-niklas.cassel@linaro.org>
In-Reply-To: <20191119154621.55341-1-niklas.cassel@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Nov 2019 13:00:05 +0100
Message-ID: <CAPDyKFqjsJSRW7XvfUe2Ssewqxo5Xjk_3p_EywP_rTsvrdNDYQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Add support for QCOM Core Power Reduction
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Nov 2019 at 16:46, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> This series adds support for Core Power Reduction (CPR), a form of
> Adaptive Voltage Scaling (AVS), found on certain Qualcomm SoCs.
>
> This series is based on top of the qcs404 cpufreq patch series that
> hasn't landed yet:
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=173423
> as well as that series' matching device tree changes:
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=165457
>
> For testing purposes, this patch series, including the dependencies
> listed above, is available on the following git tag:
> https://git.linaro.org/people/niklas.cassel/kernel.git/log/?h=cpr-v6
>
> CPR is a technology that reduces core power on a CPU or on other device.
> It reads voltage settings from efuses (that have been written in
> production), it uses these voltage settings as initial values, for each
> OPP.
>
> After moving to a certain OPP, CPR monitors dynamic factors such as
> temperature, etc. and adjusts the voltage for that frequency accordingly
> to save power and meet silicon characteristic requirements.
>
> This driver has been developed together with Jorge Ramirez-Ortiz, and
> is based on an RFC by Stephen Boyd[1], which in turn is based on work
> by others on codeaurora.org[2].
>
> [1] https://lkml.org/lkml/2015/9/18/833
> [2] https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/regulator/cpr-regulator.c?h=msm-4.14
>
> Changes since v5:
> -Removed pm_ops from platform_driver struct.
>  (This was embarrassingly not properly removed in previous patch revision.)
>
> Niklas Cassel (5):
>   dt-bindings: power: avs: Add support for CPR (Core Power Reduction)
>   power: avs: Add support for CPR (Core Power Reduction)
>   arm64: dts: qcom: qcs404: Add CPR and populate OPP table
>   arm64: defconfig: enable CONFIG_QCOM_CPR
>   arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM
>
>  .../bindings/power/avs/qcom,cpr.txt           |  130 ++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |  132 +-
>  arch/arm64/configs/defconfig                  |    2 +
>  drivers/power/avs/Kconfig                     |   15 +
>  drivers/power/avs/Makefile                    |    1 +
>  drivers/power/avs/qcom-cpr.c                  | 1754 +++++++++++++++++
>  7 files changed, 2034 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 drivers/power/avs/qcom-cpr.c
>
> --
> 2.23.0
>

For the series (except patch 2 that I provided some comment for), feel
free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
