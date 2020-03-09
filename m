Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C917E5D0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCIReZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 13:34:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40998 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgCIReY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 13:34:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id q10so7674057lfo.8
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2020 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKwweRnte1MOD7p9TA/S2S3zf2g/0Z5sCRLZSuMOcIs=;
        b=gRt7ekmOg8rl5K+/4iBSCKcg6XtIM8giPFm9yVKDZMspyiOsDz19mv7YtW0EjPRmh+
         p1RLG4nYMhBc0w3RcvGOU1aYRVjPKHgqcD26DAfRgks0ixDF/rPNrNduwPv8pX0XwjXa
         U0ZIgtMaqHvJ6AhJ3iG5FSSA1anL8uvx569WyECwfgYmr6nUNg2v2W5Bm7pdNJHLZTWn
         KQjYMRvSXsO8CslfFBsouUi7OOPyTVO2pa/hTgJOzs5tuGtCPRq2Jvt737L3IxXxzGEH
         XH6HfGZZbNWgs0bzI+d/Bld6xU1ebtB0AFslJkd+SxjLYgRI3cWjdDnb9Xqb8te3jZj8
         JyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKwweRnte1MOD7p9TA/S2S3zf2g/0Z5sCRLZSuMOcIs=;
        b=KQdreu5k7MpWMZevBv8Yd0QxXvMNxKH5SYEZxgpszgh3hL8qPI45P3SpUiEQ2s+W3t
         QjN5yBZJsrq2HP7PH0NeD9TcT3+NXLC2PkdYO0F3oIqNHq9Gi/9zNKEIfpa0X6ELyLMV
         K5pvbR+NkpmXNT1NYHhGsiuyiSj4sb66H4s9jPQWefkMfn3Q5Xdr7lCsP1sH5Z4jnUjt
         QVgFatrKDS/Jj0plX7BzQqWO4GZVLKYmxSIYTfvpwShcDtioFUNe0f7Sibyl+c78yLym
         ClLb8lWfft3Js9tmA2tlDlVWov6Kr25A5uO44goOyaZTRaxkK3vi5oZA0TEKkR/gQ8Yi
         k2Vw==
X-Gm-Message-State: ANhLgQ1H5qjiR6I7qrRUQjPaYmtUa9k81ul+ncLhJFAByRH7WZ32Iu0M
        GsQlYAWH+kYn9idiUae7qRWpGhJViHXEitDHqpF1GA==
X-Google-Smtp-Source: ADFU+vuICxdS5HcWd7C+Tu3VndUCAPMP28WDkPVH8R+sJ4h8bsJf+5vcfGqb2LvTsz7pvpD2B2HIZdzAE0cuPTRXa8k=
X-Received: by 2002:a05:6512:304c:: with SMTP id b12mr10177018lfb.196.1583775261668;
 Mon, 09 Mar 2020 10:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <1583241493-21212-1-git-send-email-okukatla@codeaurora.org> <1583241493-21212-3-git-send-email-okukatla@codeaurora.org>
In-Reply-To: <1583241493-21212-3-git-send-email-okukatla@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Mon, 9 Mar 2020 10:33:45 -0700
Message-ID: <CAE=gft5LE=_hBLbkWHDAQ6O9vrbfF=LtS7B=1tWWDE3euZov_g@mail.gmail.com>
Subject: Re: [v5, 2/3] interconnect: qcom: Add SC7180 interconnect provider driver
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 3, 2020 at 5:18 AM Odelu Kukatla <okukatla@codeaurora.org> wrote:
>
> Add driver for the Qualcomm interconnect buses found in SC7180 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |  10 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/sc7180.c | 641 +++++++++++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/sc7180.h | 149 +++++++++
>  4 files changed, 802 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sc7180.c
>  create mode 100644 drivers/interconnect/qcom/sc7180.h
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index f6418a6..482c5be 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -42,6 +42,16 @@ config INTERCONNECT_QCOM_RPMH
>         depends on INTERCONNECT_QCOM || COMPILE_TEST
>         depends on QCOM_COMMAND_DB
>
> +config INTERCONNECT_QCOM_SC7180
> +       tristate "Qualcomm SC7180 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +       select INTERCONNECT_QCOM_RPMH
> +       select INTERCONNECT_QCOM_BCM_VOTER
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on sc7180-based
> +         platforms.
> +
>  config INTERCONNECT_QCOM_SDM845
>         tristate "Qualcomm SDM845 interconnect driver"
>         depends on INTERCONNECT_QCOM
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index d591bb5..5325558 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -5,6 +5,7 @@ qnoc-msm8916-objs                       := msm8916.o
>  qnoc-msm8974-objs                      := msm8974.o
>  qnoc-qcs404-objs                       := qcs404.o
>  icc-rpmh-obj                           := icc-rpmh.o
> +qnoc-sc7180-objs                       := sc7180.o
>  qnoc-sdm845-objs                       := sdm845.o
>  icc-smd-rpm-objs                       := smd-rpm.o
>
> @@ -13,5 +14,6 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
> new file mode 100644
> index 0000000..dcf493d
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sc7180.c
> @@ -0,0 +1,641 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>

Nit: As Georgi mentioned in the previous review, you can remove this
an replace it with of_device.h. No need to spin for just that, though.

Reviewed-by: Evan Green <evgreen@chromium.org>
