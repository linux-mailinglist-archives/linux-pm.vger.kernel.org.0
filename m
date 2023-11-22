Return-Path: <linux-pm+bounces-71-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB07F42BA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A0BB20F63
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD579584F0;
	Wed, 22 Nov 2023 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAfvNJSW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE782129
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 01:48:38 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cca8b559b3so2021087b3.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 01:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700646517; x=1701251317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ygGpIikdffA3zI0CSmuuy6nPAmKVPCLvFv3JJHDPC+E=;
        b=gAfvNJSWoLkbMqMzI/YXVFmLGb5aBqNH6/wkfVxdHTvi9hcIK/F9rdqB/q6iTEFDVi
         eqgVotjwqGXVLOBCGGYNb2ICRJXFdAF4wvGY6Du8Tly4z5IGpTdt7BcBdkbwKtewpOfv
         RQo5nURaG2j7XjpR9prVU13m8dveW+14a63hVBwlmPufLx6SvrpOWogFMox+QpfGCLCN
         WD4nn9Hxy8IXzW9faZqs5cA03kazH4qsL2m0+FzraG/Lytyr1LLl+PlC6UNEj/nborJ0
         S8U3Wgr7AAbFIXr2Ifsqi4zkCS6bdNZC6p8wmg3fwHRpRhXVKYS57I7I/DDqs656Mrdg
         cN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646517; x=1701251317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygGpIikdffA3zI0CSmuuy6nPAmKVPCLvFv3JJHDPC+E=;
        b=O1xabgr95gPxllJgwArnmaJcb6nVUPry7I/S95HnR+1vrWSkFaAHI5VXp10woMeswW
         zbKSSoivA1nysjJDrNFkSCV/LoUYAsz4DZtJQGHZxu2ZbKznP8wL9BPNOcikB4lLyaTo
         VMlULF9rdRx9nXWUAMpYlG2m13u7HUeQQRcQh2nofAaigoO+0mGUDmQuVLZtYMQVV3s5
         q0xAVQuH3qIGd1zePQS5LoYboGpp9Cg+PpVgwWYY43tZFd9eETlcd9/PVTFZkbVZjzTs
         0wq/d1pQmJSHtNUtegGxF6hMl45gUBnG39wvJO4lOQrc/k5ehrKnkKw81G6sHEC00Iha
         0emw==
X-Gm-Message-State: AOJu0YyCHQN4992Ly+u2DCyHYlrbU/aR2i20+bSDsLxDLBoXb+AJYBS3
	B3vg6NVqOmBjmwVvBHVh1kPBmmodMfdJ7XXe9pVg6w==
X-Google-Smtp-Source: AGHT+IHg3xtWznL7RoXEO+Wk8qVQlDpVyn+jAxEz7GbXdU/LSx4+N+Ut3/07i5p33DnA24H7agc2O3KIwSPgMDwgTH4=
X-Received: by 2002:a25:374c:0:b0:db0:6cde:3859 with SMTP id
 e73-20020a25374c000000b00db06cde3859mr1535108yba.41.1700646517145; Wed, 22
 Nov 2023 01:48:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com> <20231114-msm8909-cpufreq-v3-2-926097a6e5c1@kernkonzept.com>
In-Reply-To: <20231114-msm8909-cpufreq-v3-2-926097a6e5c1@kernkonzept.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 22 Nov 2023 10:48:01 +0100
Message-ID: <CAPDyKFrwZn1Po+aWwPusjhfoxWoy5qJn4SBK1Csr=280_JPRkw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cpufreq: qcom-nvmem: Preserve PM domain votes in
 system suspend
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Nov 2023 at 11:08, Stephan Gerhold
<stephan.gerhold@kernkonzept.com> wrote:
>
> From the Linux point of view, the power domains used by the CPU must
> stay always-on. This is because we still need the CPU to keep running
> until the last instruction, which will typically be a firmware call that
> shuts down the CPU cleanly.
>
> At the moment the power domain votes (enable + performance state) are
> dropped during system suspend, which means the CPU could potentially
> malfunction while entering suspend.
>
> We need to distinguish between two different setups used with
> qcom-cpufreq-nvmem:
>
>  1. CPR power domain: The backing regulator used by CPR should stay
>     always-on in Linux; it is typically disabled automatically by
>     hardware when the CPU enters a deep idle state. However, we
>     should pause the CPR state machine during system suspend.
>
>  2. RPMPD: The power domains used by the CPU should stay always-on
>     in Linux (also across system suspend). The CPU typically only
>     uses the *_AO ("active-only") variants of the power domains in
>     RPMPD. For those, the RPM firmware will automatically drop
>     the votes internally when the CPU enters a deep idle state.
>
> Make this work correctly by calling device_set_awake_path() on the
> virtual genpd devices, so that the votes are maintained across system
> suspend. The power domain drivers need to set GENPD_FLAG_ACTIVE_WAKEUP
> to opt into staying on during system suspend.
>
> For now we only set this for the RPMPD case. For CPR, not setting it
> will ensure the state machine is still paused during system suspend,
> while the backing regulator will stay on with "regulator-always-on".
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
> This patch can be merged independently from the pmdomain one for RPMPD.
> Both are needed to actually preserve the votes during system suspend but
> there is no compile-time dependency.
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index d239a45ed497..ea05d9d67490 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -23,6 +23,7 @@
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
> @@ -426,6 +427,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>         .get_version = qcom_cpufreq_ipq8074_name_version,
>  };
>
> +static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
> +{
> +       const char * const *name = drv->data->genpd_names;
> +       int i;
> +
> +       if (!drv->cpus[cpu].virt_devs)
> +               return;
> +
> +       for (i = 0; *name; i++, name++)
> +               device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
> +}
> +
>  static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
>  {
>         const char * const *name = drv->data->genpd_names;
> @@ -578,11 +591,25 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
>         }
>  }
>
> +static int qcom_cpufreq_suspend(struct device *dev)
> +{
> +       struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
> +       unsigned int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               qcom_cpufreq_suspend_virt_devs(drv, cpu);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, qcom_cpufreq_suspend, NULL);
> +
>  static struct platform_driver qcom_cpufreq_driver = {
>         .probe = qcom_cpufreq_probe,
>         .remove_new = qcom_cpufreq_remove,
>         .driver = {
>                 .name = "qcom-cpufreq-nvmem",
> +               .pm = pm_sleep_ptr(&qcom_cpufreq_pm_ops),
>         },
>  };
>
>
> --
> 2.39.2
>

