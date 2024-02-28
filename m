Return-Path: <linux-pm+bounces-4514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875B86B374
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29171F2A92D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7B215D5A8;
	Wed, 28 Feb 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMP16Zwf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF615CD65
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134875; cv=none; b=mJEb9Wp/274vfxmDAlT26+RhfrWf4OMJJjskJLgVOr1NIYUSJg0F1821YksWQX9X53myQxJdVdUgENesylYO+UNEJ6sCON8q9PglcMV3r48jVE5Pfyrr2XbpnA/hl8RXClUFIHmDKOBhfV/HiWm/SXlhR58CVZxtEj8y4M/pjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134875; c=relaxed/simple;
	bh=QHQxcBODUYiQb1yYM36IqEt4dgIYDC9UqJta385YNF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3Lxo3Tkb/s+89PPnwCFRintQRoP20t0tZggvtNnKa4E7xQF5YkdjuIa5x6JtAXc4NBzNgV+Set6hux+fX9Em8SFyczH87q/ECFqtNBndCF4mRdhHIQZVh6c/7/d4NZBcxWhm81Sdod9RsVA3vhPdCfRwDd5Ybofhad+u+kIsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lMP16Zwf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso7628039a12.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709134872; x=1709739672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tRApMKF3yJM+F82njXYmgcbTLvVNudocV6GcXTSm5g=;
        b=lMP16ZwfkwxT8itu7zCia8qjCyHhISvyKHBg9WrhqJmhgSFGCgE5eivwNA9R1vyV07
         ls0pgeMgSWkgXHFx1Cri+FdVFG9FYGruhs3JhUqHMVNmp8D4QvBgIGsFbksU8y4qW9+z
         zTBLSbdyzuh7Kfjluf4VS2eAc/hh44W8M5LGCN1iy3MbuW1tfCbIcFB8/FJdQ9QafNrY
         SYE7gTUcRBjM3qaJo+ICdsfPRU6rSqwSY/T0mtPJZlm2qnNktDGDGakEJXC0tXnI6Kzp
         qWhYNviSP2+wtn6i03sgY6c+/8B+5fm8hZwLoK1hBO8NauQrvm4mfIxEEqbGyWDi30Mq
         4KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134872; x=1709739672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tRApMKF3yJM+F82njXYmgcbTLvVNudocV6GcXTSm5g=;
        b=l+WD14rS7TF7O282t1RjwMJO9iZu4iWKx2vfU0lCszDGiBgDUtohuKn+pNE5wzEfsA
         F1jFqfcyFAcMCYOwUoKNG4nM+0LR6tlClJj4z5lZ99mkMl6Ek9OicD6rjTCxPOy29PQ3
         kz4WIIt+znV2t5UveSgdqgNKuHVKcZ/VLCYHKfYsHH0mZIWYjmyRcPD1vJDc/Pd72E63
         yCGpNxD71bJfRiNfas2ggvYliAm1rNxwkRuEn9FhqpmU4tCLS7ABV70C7yz3yzL88MB+
         ZCXam653jIYioj30EcXREBx3g7+Ga3aEKll01uZLJJrnxG9O2wF8xIkxzFq+iVtM1lqd
         CfZA==
X-Forwarded-Encrypted: i=1; AJvYcCW+IAlL6OXoJLsqMEhp/h768Zqfwe1exVpm+42OTK23rteD52jqiqOWiKZjGENDv/3Ke/VzGGNGiIzIoApMOTUPc4MAxAoWkHM=
X-Gm-Message-State: AOJu0YxzfGikhlLNXWb79QM9bQrfFaB80I3WRKckd4bgIgY6TWG25SEM
	8rD3U20XOTDLsp2AF5tlczKLbSPkSKNLoW2FJcZXgkDfjRUo1kRBd0gpmc5fg3udY7z+MnuxFZK
	QeaRzIA/rAVknhEak+jsbrbMA+QM7zWFp5Dmvgg==
X-Google-Smtp-Source: AGHT+IG365oga5w7zDBtHPazj2hxzm3EgUC8YA/EU30cur5ZUa1DEDy6fvESfJjz4iWUOKjXuivekncmBzXJyaua22s=
X-Received: by 2002:a05:6402:3456:b0:564:3b2e:2a2e with SMTP id
 l22-20020a056402345600b005643b2e2a2emr8870854edc.9.1709134871902; Wed, 28 Feb
 2024 07:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 16:40:35 +0100
Message-ID: <CAPDyKFogCeyMKU4iPeAHcx1J6nWrO-43yb9_2xYmXm202V-p3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: Update init level to core_initcall() for
 cmd-db and rpmh-rsc
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_lsrao@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 14:57, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> cmd-db and rpmh-rsc are used by clients like regulators, interconnects and
> clocks for resource voting. These clients are in core_initcall() while
> cmd-db and rpmh-rsc are in arch_initcall(). Update init level for these
> drivers also to core_initcall() to avoid unnecessary probe defer during
> boot up.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/cmd-db.c   | 2 +-
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..c344107bc36c 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -362,7 +362,7 @@ static int __init cmd_db_device_init(void)
>  {
>         return platform_driver_register(&cmd_db_dev_driver);
>  }
> -arch_initcall(cmd_db_device_init);
> +core_initcall(cmd_db_device_init);
>
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index a021dc71807b..c4c7aad957e6 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1154,7 +1154,7 @@ static int __init rpmh_driver_init(void)
>  {
>         return platform_driver_register(&rpmh_driver);
>  }
> -arch_initcall(rpmh_driver_init);
> +core_initcall(rpmh_driver_init);
>
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
>  MODULE_LICENSE("GPL v2");
>
> --
> 2.22.0
>

