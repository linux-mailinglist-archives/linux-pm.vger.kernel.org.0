Return-Path: <linux-pm+bounces-20549-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD5A13C97
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 15:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE30188D35D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604422A7F6;
	Thu, 16 Jan 2025 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tU2zFCn5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F85B198A29
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038815; cv=none; b=DeCcXh/5JuU111wqwF3uMy63EOzIpZz8xjwEi/bGXKgFjmtwUb7uhCtOEUibSwi0KHolj/ZucjOkpksgyK5CXrQ01JVWsy3RPM0Ue0/C8AkYE1/cq/PJyXdIYAINAa9HT1prtzgEmj5Szl5zrbQRSYxOcaM5W/+7hmxOkBkU9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038815; c=relaxed/simple;
	bh=i1ov65Y8cUCAStPqhpPeNldJn7A+FXiyzqBKaFwGYVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6U3XGV2yID/sNklShgc+iaiJF+h88edjzIFQUG7vhKnLd2q/+hgWFR70VheBQE1wPgriey5Q/sUnGudL9uj+cIsYVn/TaWKn/yb39fQzlfrqsWqbOd1WDQ7c7yNWQrLbudK6be/fdtRJOPKfi35+u74YEUMNajVrVdb3v5WX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tU2zFCn5; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a91756e5so1882714276.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 06:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737038812; x=1737643612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+m1G7PofLTIXji56NSz1j24b2b2T3MuG3/CntqxLBBw=;
        b=tU2zFCn57OXje7jPtVqtqnnwUbkz0QBzk3LI+997vuR/mgqjnVtxUIE9MlTTTCUnEY
         pljBF193EpFXPyLy/f9f8IbTczd7FyGM78eonfNq31eQwwxg8uE5/stwMzXeYyEjoKj/
         k6Vecwgwsu1a907vfgO8lNIBsQ3kLTtRY2+r3RYtW2joAqCAH8BZOI3FlpEWHpK2Lq6j
         +W+dNNTBm3a2l0ofFYYTZ7ssF7su0uCJ3U+AkA2r90DREni0kPQZfMLs96R5ZmI9bH4W
         7XCfYYjJWTY9bnumjiM/wDOo3WpgxXuKVcC4+Gehut+nZDBs0fMUfn59bS9OWZp0VvY2
         xZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038812; x=1737643612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+m1G7PofLTIXji56NSz1j24b2b2T3MuG3/CntqxLBBw=;
        b=uPicXRSoCp44PoYuAW59UrBB5/iSqcWUIEhnCXYiWUSbxWrZgSEX9zmC9COAIzg6dg
         1jVi+Opcn40BC7dcP42+BtmYSRan+s/SJBHfzBpBbU5Bso/s4GavAnRUn8Tc/1WAZfQA
         fpXiUQRi1JcY8vFCzx0MXqbTYy4YTd+H1gBAUwQ6p8JMUIx0HrGW4BMUmazdqrK/v1jz
         sGE7SDGuGVUQS3jSOLyhKDhpuq4xTwdJfrwL4ZOetBwG0ffpRVQUDkVyVrJMcQYjFqJV
         aZTTyIM4ahAGEABOQWkWo83ygJWKV0FBC3pW8/MFPiWmnF4wOKlJIOszZbrXbtfLtwVt
         fT9g==
X-Forwarded-Encrypted: i=1; AJvYcCUegmdKWc+iqgN8h45Y69Bm1f+kDD9bcCsMRGRyqcjE4CqaD5po1d5BxHTiEfDtEja7IVPERoDufw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsiTiGkm2UKtIPLi6ic/RV45hPdUFvUltsp77CIsoKHbv2hEzM
	qMwQAu8nm3mRcR8P3O9b5xuwbptC3Y0FwF1Of7kBv+hk1BhXsG7Kiuhafxgg3F6ADaqig31Ugpt
	zmzhEyCO50T+a18CaATuSa2NWEw5PAPNWCs6x7Q==
X-Gm-Gg: ASbGnctu/Vpr9gs5M940K8tG5U4CPtD1IpNhU7FQiZ3MySh1AqWduli9/u/Ube32J8e
	nD55YF4VwvM93Ps2Z0WAMXMsw+mbZqcRvITDMz24=
X-Google-Smtp-Source: AGHT+IEgtTusJYrVZnLJqpkMnaQW6PKvqXaBdJ1qWB4u4sYFRvuNXZZiCbeAuzNh5mb57/Q5o/7WHYssJXuaOMTG558=
X-Received: by 2002:a05:690c:4d81:b0:6ef:7f34:fe08 with SMTP id
 00721157ae682-6f531224a36mr294371267b3.18.1737038812063; Thu, 16 Jan 2025
 06:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224093920.3816071-1-kever.yang@rock-chips.com> <20241224093920.3816071-2-kever.yang@rock-chips.com>
In-Reply-To: <20241224093920.3816071-2-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Jan 2025 15:46:16 +0100
X-Gm-Features: AbW1kvahorrlWkjwCiv7wkTLlUP8_JyQ26Uq7qZus2JotVO1Pyr02DSo-fK3yF0
Message-ID: <CAPDyKFqYjTsWsqf-C+iHJz3x-RKdsm2-2cPm-HMeH=WBNzcSLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: rockchip: power-domain: add power domain
 support for rk3562
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	Finley Xiao <finley.xiao@rock-chips.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-pm@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Dec 2024 at 10:39, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> This driver is modified to support RK3562 SoC.
> Add support to ungate clk.
> Add support to shut down memory for rk3562.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v2:
> - update the header after rename
>
>  drivers/pmdomain/rockchip/pm-domains.c | 48 +++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index cb0f93800138..d05ec0a009a0 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -2,7 +2,7 @@
>  /*
>   * Rockchip Generic power domain support.
>   *
> - * Copyright (c) 2015 ROCKCHIP, Co. Ltd.
> + * Copyright (c) 2015 Rockchip Electronics Co., Ltd.
>   */
>
>  #include <linux/io.h>
> @@ -32,6 +32,7 @@
>  #include <dt-bindings/power/rk3366-power.h>
>  #include <dt-bindings/power/rk3368-power.h>
>  #include <dt-bindings/power/rk3399-power.h>
> +#include <dt-bindings/power/rockchip,rk3562-power.h>
>  #include <dt-bindings/power/rk3568-power.h>
>  #include <dt-bindings/power/rockchip,rk3576-power.h>
>  #include <dt-bindings/power/rk3588-power.h>
> @@ -129,6 +130,20 @@ struct rockchip_pmu {
>         .active_wakeup = wakeup,                        \
>  }
>
> +#define DOMAIN_M_G_SD(_name, pwr, status, req, idle, ack, g_mask, mem, wakeup, keepon) \
> +{                                                      \
> +       .name = _name,                                  \
> +       .pwr_w_mask = (pwr) << 16,                      \
> +       .pwr_mask = (pwr),                              \
> +       .status_mask = (status),                        \
> +       .req_w_mask = (req) << 16,                      \
> +       .req_mask = (req),                              \
> +       .idle_mask = (idle),                            \
> +       .ack_mask = (ack),                              \
> +       .clk_ungate_mask = (g_mask),                    \
> +       .active_wakeup = wakeup,                        \
> +}
> +
>  #define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup)     \
>  {                                                      \
>         .name = _name,                                  \
> @@ -194,6 +209,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3399(name, pwr, status, req, wakeup)          \
>         DOMAIN(name, pwr, status, req, req, req, wakeup)
>
> +#define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
> +       DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup, false)
> +
>  #define DOMAIN_RK3568(name, pwr, req, wakeup)          \
>         DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
>
> @@ -1130,6 +1148,18 @@ static const struct rockchip_domain_info rk3399_pm_domains[] = {
>         [RK3399_PD_SDIOAUDIO]   = DOMAIN_RK3399("sdioaudio", BIT(31), BIT(31), BIT(29), true),
>  };
>
> +static const struct rockchip_domain_info rk3562_pm_domains[] = {
> +                                            /* name           pwr     req     g_mask  mem wakeup */
> +       [RK3562_PD_GPU]         = DOMAIN_RK3562("gpu",         BIT(0), BIT(1), BIT(1), 0, false),
> +       [RK3562_PD_NPU]         = DOMAIN_RK3562("npu",         BIT(1), BIT(2), BIT(2), 0, false),
> +       [RK3562_PD_VDPU]        = DOMAIN_RK3562("vdpu",        BIT(2), BIT(6), BIT(6), 0, false),
> +       [RK3562_PD_VEPU]        = DOMAIN_RK3562("vepu",        BIT(3), BIT(7), BIT(7) | BIT(3), 0, false),
> +       [RK3562_PD_RGA]         = DOMAIN_RK3562("rga",         BIT(4), BIT(5), BIT(5) | BIT(4), 0, false),
> +       [RK3562_PD_VI]          = DOMAIN_RK3562("vi",          BIT(5), BIT(3), BIT(3), 0, false),
> +       [RK3562_PD_VO]          = DOMAIN_RK3562("vo",  BIT(6), BIT(4), BIT(4), 16, false),
> +       [RK3562_PD_PHP]         = DOMAIN_RK3562("php",         BIT(7), BIT(8), BIT(8), 0, false),
> +};
> +
>  static const struct rockchip_domain_info rk3568_pm_domains[] = {
>         [RK3568_PD_NPU]         = DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
>         [RK3568_PD_GPU]         = DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
> @@ -1331,6 +1361,18 @@ static const struct rockchip_pmu_info rk3399_pmu = {
>         .domain_info = rk3399_pm_domains,
>  };
>
> +static const struct rockchip_pmu_info rk3562_pmu = {
> +       .pwr_offset = 0x210,
> +       .status_offset = 0x230,
> +       .req_offset = 0x110,
> +       .idle_offset = 0x128,
> +       .ack_offset = 0x120,
> +       .clk_ungate_offset = 0x140,
> +
> +       .num_domains = ARRAY_SIZE(rk3562_pm_domains),
> +       .domain_info = rk3562_pm_domains,
> +};
> +
>  static const struct rockchip_pmu_info rk3568_pmu = {
>         .pwr_offset = 0xa0,
>         .status_offset = 0x98,
> @@ -1429,6 +1471,10 @@ static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>                 .compatible = "rockchip,rk3399-power-controller",
>                 .data = (void *)&rk3399_pmu,
>         },
> +       {
> +               .compatible = "rockchip,rk3562-power-controller",

I couldn't find the corresponding DT patch where this compatible is
being documented. Can you please re-send and keep me posted for both
the DT and pmdomain patch?

> +               .data = (void *)&rk3562_pmu,
> +       },
>         {
>                 .compatible = "rockchip,rk3568-power-controller",
>                 .data = (void *)&rk3568_pmu,
> --
> 2.25.1
>

Kind regards
Uffe

