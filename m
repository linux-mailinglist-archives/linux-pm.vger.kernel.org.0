Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27F7AA1B5
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 23:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjIUVFs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 17:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjIUVFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 17:05:16 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31105490D
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:31:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dc89741cedso336480fac.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317507; x=1695922307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKBCWQGoZXYISlj4ce5hI/hMxdBTdeB63Q+PfDkksMw=;
        b=Z9LGvFZuIeW4vcfdgdO+na93WL90An6RwX4zaebo/eFulYRKzfoOsjzQ61zHURz6Z3
         GL9we0dD/1LjONmfwa5ctGzFhK2Tq0Gx/yNC/6dKPgJaoLwVG5bUDvak1qyXVioqSQZs
         tcZDUbzF4hVH1SPj2VpJHvQoIfT7x32YpwpdIYhC9pMfpRtZQNBh/MEnyyEZjvDN2oel
         qHQlh0kcHOy/WLAcVSuFTlWd59TUOV1KLlPw0s4f1oybh3DSp86+r2zlt+xem792ssKd
         isRmWu3Edx4FT7fVchyJf2OQiwFjEXtCIJj/yBY3IWyY9PKdJ9RS1YcDYmnqXOSYEpKn
         /jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317507; x=1695922307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKBCWQGoZXYISlj4ce5hI/hMxdBTdeB63Q+PfDkksMw=;
        b=k6hjrLNJQiE7OBbypBxt6tQlVRrnkqZkgCYxkbpUVJenO/kb2RGysFCCFLz39AttoJ
         nLmSq3Q+TDEhh0Qi9zepX2aGsxbE0nEBS7kEHOaBtF9hxnRutuCW7qEVLZheVxggmPL5
         Mr/YfrGQc7tI45kXcI2BZ3tz8uKk/VCC9TIA4YntMF2bw9GSOPglucRFXvzmfT65vxUI
         /xvb5iAHtBwIeo9mgwND89C2pOkhV8yXSUlanWNq4X0npjD0Ie+N7U0RT3AoRErU5Tod
         5xWhmUJU7KPkzIUdzKI7lQJ6ljRFnn1W8mlYS3DHwG/7aOvM2QDXW/IyEMJIbqAiUmN+
         eYVw==
X-Gm-Message-State: AOJu0YwBza8RjY70iNFdN1+CwP9NtENfTsVsTUbaeXznLpTwY5xl0Cfn
        GyZK9VRc2W8JlUnP3h/EOvll/S8fvTs0dCciyynsxGH5baQjsunh24k=
X-Google-Smtp-Source: AGHT+IF4etN+Lj1MoiBPYE9O7MxBCxBGEDBcLLZyD6+EOR0BOfhOgfmrV9Rjd46Xx5Okz8nIXqKXRgGlicgkoa5JBtk=
X-Received: by 2002:a25:cb14:0:b0:d44:af:3cce with SMTP id b20-20020a25cb14000000b00d4400af3ccemr5617959ybg.27.1695301892106;
 Thu, 21 Sep 2023 06:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230919121605.7304-1-ulf.hansson@linaro.org> <20230921113328.3208651-1-sudeep.holla@arm.com>
In-Reply-To: <20230921113328.3208651-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Sep 2023 15:10:56 +0200
Message-ID: <CAPDyKFrGDZzyp4G1fS5PGCE95b3_w4kJyZfnDs=BEuYLzJ7uXA@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Move power-domain driver to the
 pmdomain dir
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Sept 2023 at 13:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> To simplify with maintenance let's move the Arm SCMI power-domain driver
> to the new pmdomain directory.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Feel free to take it through your scmi tree!

Note that, we should move the Kconfig options too, but that requires
changes that I am carrying in my pmdomain tree. We can either wait
until the next cycle or you could send your pull-request to me this
time (instead of through arm-soc), then we can fix this as a late
minute change. The decision is yours.

Kind regards
Uffe

> ---
>
> Hi Ulf,
>
> If you are happy with this, please cck. I would like to take this along
> with your scmi_perf_domain change as part of you series.
>
> Regards,
> Sudeep
>
>  drivers/firmware/arm_scmi/Makefile                           | 1 -
>  drivers/pmdomain/arm/Makefile                                | 1 +
>  drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/{firmware/arm_scmi => pmdomain/arm}/scmi_pm_domain.c (100%)
>
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index b31d78fa66cc..a7bc4796519c 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -16,7 +16,6 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>
> -obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
>  obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
>
>  ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
> diff --git a/drivers/pmdomain/arm/Makefile b/drivers/pmdomain/arm/Makefile
> index 7128db96deac..cfcb1f6cdd90 100644
> --- a/drivers/pmdomain/arm/Makefile
> +++ b/drivers/pmdomain/arm/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
> +obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
> diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> similarity index 100%
> rename from drivers/firmware/arm_scmi/scmi_pm_domain.c
> rename to drivers/pmdomain/arm/scmi_pm_domain.c
> --
> 2.42.0
>
