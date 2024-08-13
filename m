Return-Path: <linux-pm+bounces-12144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A85950305
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77303285105
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC519CD01;
	Tue, 13 Aug 2024 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEdlSNcA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A619CCF2
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546412; cv=none; b=e2Onmd5YenAcDoFPp612OnRHJl7VyEovuadYWYuHNb46YBWmjTWIdYNfjONPvZsUPqYtgVHUW0OU+whxOkiKyOSDfByE9bdi4z8nIxj78GEtG4oOdWc1STioFR9HamWUnZuzQBlbmpZi1nYd8i08GQYK+bI/pcdvmB5SzUvmFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546412; c=relaxed/simple;
	bh=q8pNAgjw9/3tHHnWRFEJHbq63k2GtWgWLWiFMw3DnYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2wHwGTN0F8pboVx07STVJnJt9A1pyW6/v/sFPwIr1cBWjMXqrD81ZgWsAplei1GSzsD4sL37ECsGwMBEKBUJ8ezYfgPXzB81w4n6cunijL6IItLHe20K15j1kiixFJyvzQ4xNL419yyH2E+oa5WXKvkTmKgcvsOvicJrqbQWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEdlSNcA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1137aafb8fso1374561276.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723546410; x=1724151210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/XDKrkkMHvWOyw5p4QJtIumEMqEgD/xVT5SgNZelBg=;
        b=sEdlSNcA8pSYeZNy35Z2d1R7MRMOAVlMv4/gVXeJX1wtken5bplBAjFKLj7tKdfAWC
         /koFQ1lBpwnPUFM/0ACdAQ8+qi77W+Ww1FS0PYzDigSLy53renVmyyerIu7JwgtIRgrx
         4/q2xO80uPNHstpCiSzsUh9j7IsvbYDwsnymmJ+wEGTpVJdOlYgqRZwCZNLk8ObU97v1
         Axvh0XhbtKmKhoOjaONO5bwEkV/3scoW4QOMnLm6J4OdnvtfN9ZGdn8HWTa6O3txUzDa
         iU++OLVw8k97JY6mxTEMWxT4ucEIdop3BA0kNIyD8bCFYuLZFUN0PhGp4VexqTuCtMCL
         xYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546410; x=1724151210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/XDKrkkMHvWOyw5p4QJtIumEMqEgD/xVT5SgNZelBg=;
        b=Oprq2x/pEaKBzpUtMI+DDZB/A8KirXjB3/FLyqM2kdQb1iDwMvBGmJfweI6NLxnE/4
         wY264b5z4WZjoZFrFCnOstdt1lF2manxyeJuno+/x0ZywPXg40XmAQU2r9WqkuO4nEh8
         Jwz3OQ4//H1YyMm3t2Eebq1NwdpP4sapSrKtj0OC4uwzY9nXL2/XotnYGxznB2ijsVQj
         dRrlKfhx6b2J0n45/zAeLKbVcVG2SHTOmv4B8XjLpEQo9Tl+25Uhdbd1nijGgfMqjAJd
         IHzQoK9bMlxxlzLR0Cr4YeaNLq4JKVbbBzqUr/FuRIlEPKYPdaKuuC1RZ41cQMTVtrFc
         ObeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRtrCtGd8ak8ycO5b5c1sm6gVPFwLPH/OSJVRg52hkpC9jODzoySnoEmkSNfcvQ6VSGzqWlT1cDT0PBWeT3tNe5/yzWH8eeo=
X-Gm-Message-State: AOJu0YzLK31jEDfzx/wUDqJzvK9SsmTc2W/knxctUkfNgW9mnyvv0ucU
	RVTbq9xjQo0Uc0zIxPZB+hBnL5sC25XC/KSE8AXKPwvYqe6xS4lpP15fn1FXBQEtpxdPiuGJvg4
	UeJjqan7IHsH3+7ogC+Y3AmsqyVf/zmoio1mToA==
X-Google-Smtp-Source: AGHT+IFItO0D7OclX/S5B/e5ClqeA9JU/P3uqhBqfY7zfqkekKMs8wX80GxMDY1wDSzUbaTJC9QhhNMbySj25mpFIPs=
X-Received: by 2002:a05:6902:13cf:b0:e0e:cd17:6130 with SMTP id
 3f1490d57ef6-e113d07894cmr3177420276.37.1723546409963; Tue, 13 Aug 2024
 03:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com> <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
In-Reply-To: <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 12:52:53 +0200
Message-ID: <CAPDyKFpUMmveKQ2Pi33VwcvG9tsMQHEcAg88icf7v9mzzm+k4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 09:16, Dikshita Agarwal <quic_dikshita@quicinc.com> wrote:
>
> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the
> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
> during remove phase.
>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 13 +++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 327d168..729d6c2 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
>
>  /**
> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> + * @_list: The list of PM domains to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach_list().
> + * it will be invoked during the remove phase from drivers implicitly if driver
> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> + */
> +void devm_pm_domain_detach_list(void *_list)
> +{
> +       struct dev_pm_domain_list *list = _list;
> +
> +       dev_pm_domain_detach_list(list);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);

I think this function should be internal and hence made static -
unless there is a good reason to export it?

> +
> +/**
> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
> + * @dev: The device used to lookup the PM domains for.
> + * @data: The data used for attaching to the PM domains.
> + * @list: An out-parameter with an allocated list of attached PM domains.
> + *
> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
> + * you during remove phase.
> + *
> + * Returns the number of attached PM domains or a negative error code in case of
> + * a failure.
> + */
> +int devm_pm_domain_attach_list(struct device *dev,
> +                              const struct dev_pm_domain_attach_data *data,
> +                              struct dev_pm_domain_list **list)
> +{
> +       int ret, num_pds = 0;

There is no need to initialize num_pds to 0 here, as the below calls
take care of it.

> +
> +       num_pds = dev_pm_domain_attach_list(dev, data, list);
> +

We should add a check if num_pds is zero here, as in that case there
is no reason to add a devres callback for it.

> +       ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
> +       if (ret)
> +               return ret;
> +
> +       return num_pds;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);

[...]

Kind regards
Uffe

