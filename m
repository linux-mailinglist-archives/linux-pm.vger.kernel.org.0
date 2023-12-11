Return-Path: <linux-pm+bounces-906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20C80D4C0
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75ACB2154A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661B04EB5A;
	Mon, 11 Dec 2023 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy+XZfm/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B824EB34;
	Mon, 11 Dec 2023 17:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD5C433CA;
	Mon, 11 Dec 2023 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702317350;
	bh=TDsZZcW//Yjkn4AZvJmsYsqi1Yqt03hg0vEJ8F1Khno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wy+XZfm/xBwdGjaMO0iafORqU7AYUAKBrpmfPhZnS63W2LD+9lIUmmY85M7iDotZV
	 RUUIwg0POXN4Tkdavv6UXUiOqqIzFni8VQZhDxQXeupY9UVawI9v08XKg2gq0caO+p
	 bb/oY/p81QaSRDsWLnEdSbbaXi5FUQWA3fN2rcUuikHcWh1dLUY3aINV97NKCubO1y
	 l1tEo9YR5UB1hVIpFdg/ivykxGAYb0eRvemLSdGk5XfxND1zVPvoEgRkS3FVf/9l7S
	 zVh3HSiOyx1yr1oE8BoiPzfD3sQ8wFq0jjsCHcAeefrs846eDBoTAiVYXqLGpWcnwo
	 b9f2qqc7TPtxw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bdec453c8so5633504e87.3;
        Mon, 11 Dec 2023 09:55:50 -0800 (PST)
X-Gm-Message-State: AOJu0YyLwFCyWuctzlW9fzX+J6DSrjCi45cu081ACeOFixmvpNgPC2AV
	KKcTdsOTobn3vI5bNHtGG82xlRREQ9jGiF+fcA==
X-Google-Smtp-Source: AGHT+IEv/8aN3PfaLGZ9JYm4t5UMDrJAklhI4W9r08evSljkXdLA6kO7mL8YfS3YKHyNIbwwq6+C5bGH+jkLyGQVaN8=
X-Received: by 2002:a05:6512:2242:b0:50b:f812:b313 with SMTP id
 i2-20020a056512224200b0050bf812b313mr2431265lfu.77.1702317348971; Mon, 11 Dec
 2023 09:55:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125-topic-6115icc-v3-0-bd8907b8cfd7@linaro.org> <20231125-topic-6115icc-v3-2-bd8907b8cfd7@linaro.org>
In-Reply-To: <20231125-topic-6115icc-v3-2-bd8907b8cfd7@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 11 Dec 2023 11:55:36 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FNYS-Ue1NQgDW_0D_NgONfsJj4Q-nzFWHHXpm0Ka=_Q@mail.gmail.com>
Message-ID: <CAL_Jsq+FNYS-Ue1NQgDW_0D_NgONfsJj4Q-nzFWHHXpm0Ka=_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add SM6115 interconnect
 provider driver
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:41=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> Add a driver for managing NoC providers on SM6115.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/sm6115.c | 1427 ++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1438 insertions(+)
>
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qco=
m/Kconfig
> index 4d15ce2dab16..697f96c49f6f 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -191,6 +191,15 @@ config INTERCONNECT_QCOM_SDX75
>           This is a driver for the Qualcomm Network-on-Chip on sdx75-base=
d
>           platforms.
>
> +config INTERCONNECT_QCOM_SM6115
> +       tristate "Qualcomm SM6115 interconnect driver"
> +       depends on INTERCONNECT_QCOM
> +       depends on QCOM_SMD_RPM
> +       select INTERCONNECT_QCOM_SMD_RPM
> +       help
> +         This is a driver for the Qualcomm Network-on-Chip on sm6115-bas=
ed
> +         platforms.
> +
>  config INTERCONNECT_QCOM_SM6350
>         tristate "Qualcomm SM6350 interconnect driver"
>         depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qc=
om/Makefile
> index 3a8a6ef67543..704846165022 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -24,6 +24,7 @@ qnoc-sdm845-objs                      :=3D sdm845.o
>  qnoc-sdx55-objs                                :=3D sdx55.o
>  qnoc-sdx65-objs                                :=3D sdx65.o
>  qnoc-sdx75-objs                                :=3D sdx75.o
> +qnoc-sm6115-objs                       :=3D sm6115.o
>  qnoc-sm6350-objs                       :=3D sm6350.o
>  qnoc-sm8150-objs                       :=3D sm8150.o
>  qnoc-sm8250-objs                       :=3D sm8250.o
> @@ -55,6 +56,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) +=3D qnoc-sdm845=
.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDX55) +=3D qnoc-sdx55.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDX65) +=3D qnoc-sdx65.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDX75) +=3D qnoc-sdx75.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SM6115) +=3D qnoc-sm6115.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM6350) +=3D qnoc-sm6350.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8150) +=3D qnoc-sm8150.o
>  obj-$(CONFIG_INTERCONNECT_QCOM_SM8250) +=3D qnoc-sm8250.o
> diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qc=
om/sm6115.c
> new file mode 100644
> index 000000000000..c49a83c87739
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sm6115.c
> @@ -0,0 +1,1427 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/interconnect/qcom,sm6115.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

You probably don't need this header and the implicit includes it makes
are dropped now in linux-next. Please check what you actually need and
make them explicit.

> +#include <linux/of_platform.h>

Also probably not needed. Please double check.

Rob

