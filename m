Return-Path: <linux-pm+bounces-17417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7A9C5B1B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D795F2811C2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369B1FF7A8;
	Tue, 12 Nov 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3R61XRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67FA1FF619
	for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423316; cv=none; b=sfE6czxw5d29paw/wpSm8OeYqFXT0PxxzBKW8Ad9gJ1uPRoTPoTix1GdVfZ4LWpbU0cLFyIel9hKuxbD2c1RNbEeRXPRFub/Vsiw8VqpC9W07X7FZqMjfWwkM1mXS29xaPx9cGrEE+r2MxWITTKtyvIMCNEaRlazRiyBPB8oRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423316; c=relaxed/simple;
	bh=7CgPmKR+pBqeOwpF5GsLSoRZ2dGeu8Y6nrW55fGI7Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcPAaFBAFNlDFp7158zPCiQg6EiQHECfRoHpuilhCLGWSRInZ/Ak8RNFlGlv07MMrOsHaYzte6fCdu2cXkaaWQw020yaUSvEyV6xATifnZjzI0/oUl6hqf8gyLPZePeR3rGzOfEMhqfNqFHhJCsoJyK3cltq3imbSh0PsDxYw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3R61XRm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso7536674a12.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2024 06:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731423313; x=1732028113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p7+ge7hJafVQtjpuuqP/E88xzOJBZSOXD8WkyCEkOXo=;
        b=G3R61XRm5rYDD8As+RXwXivYnECFbBHJ+2lYJVBGqOMhLxGt1cwZ7wGknG0s43bZdB
         SqOoJ0DFq1bqKUgQAveJJv57aLUDhOUnM7+NRuzwKBUmDFxABOZWh9RHA5uByfF/2NNk
         CjYRea4wCOmJAtcUSlDwZWNV2rVjEdG6iRMslqrNLBRd7i3lxedJQjbN9hJ+QNGMxU9B
         RdNy0mUyLHfqfgfpPA9DI4tLziB7zSTzsOof4Oh+l02QDACGs//4O5BwyAifAVNZR42F
         cjoriRjH2i2l9bhAF4YSRpRxzmbyr6JPcviGXS7h3HeXj2UGnf5dlx8TvG+OvA/k83wZ
         U89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423313; x=1732028113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7+ge7hJafVQtjpuuqP/E88xzOJBZSOXD8WkyCEkOXo=;
        b=NHRQQPpsSfiEAVm886xv0D7rHgGK/5LWu7Y/8QKLMbM0No0FECh66dJLFptK5aycCQ
         pHRBMCQ00LDj7yLq1/5PyGOFfhjMpEm0LXMl/y23LMlsWFllcjb7haK61r2TgNs+8YzG
         oFtKBtKHwxp1GT8cmDCvVTkthVJdBMoxg5pNx/7FhkfFwt1hHf8vIPdWqUKUiQk5gjYo
         t8HuRRmcx2zXkMY1Md7D+YP6CDUbGbt4fiPYPwfI/AueSYW8XV+jltgJlKEl8LZL3Hhi
         NUzZI68cpefaaIiNFR4rwuTkCWT1C/DcFFi/+nVoNnUhgLjJKHsEZB9MfVGMWcUQeUgU
         zfRA==
X-Forwarded-Encrypted: i=1; AJvYcCWtgxahPSLUVEUL1zq9E0aIghVyeX5Uxhw9GzbdD76D2uUhLkaIki8slLn3WS+TQJjO4tLsvKunEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwniHc/xg4zEVG5p9htJE0VfYjz8le3qyC258spFuNE+IBaV8NO
	EPXcBc+QhmshxnnPKGpUHSqkT3jFUkW1qlNzKJYEI0JB5nR1NI2QJmMbUtwthSkY8A9Jt/jIPQO
	b26U8IoluZ8oeALx6GsamdRpoWObe3vAp17N5zw==
X-Google-Smtp-Source: AGHT+IG5vgBt7SWz10m4bwHWl3WshDBGFWCRIXZLwIVJzAVLym8qK1LYVQnvPnJBn5988rv5zM1s0M0FA1lslSV8RBI=
X-Received: by 2002:a05:6402:34cb:b0:5cf:a20:527b with SMTP id
 4fb4d7f45d1cf-5cf4f3c018emr2916662a12.28.1731423313055; Tue, 12 Nov 2024
 06:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com> <1731048987-229149-7-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1731048987-229149-7-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 15:54:36 +0100
Message-ID: <CAPDyKFray463L3NcG3QF6Qi7q0cz15Z7sO0gEH1OgB7EK5GcmQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] scsi: ufs: rockchip: initial support for UFS
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ufs_rockchip_system_suspend(struct device *dev)
> +{
> +       struct ufs_hba *hba = dev_get_drvdata(dev);
> +       struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
> +       int err;
> +
> +       if (hba->spm_lvl < UFS_PM_LVL_5)
> +               device_set_awake_path(dev);
> +
> +       err = ufshcd_system_suspend(dev);
> +       if (err) {
> +               dev_err(hba->dev, "system susped failed %d\n", err);
> +               return err;
> +       }
> +
> +       clk_disable_unprepare(host->ref_out_clk);

I am not sure that the host is always runtime resumed at this point,
or is there? If not, we need to call pm_runtime_get_sync() somewhere
here and a corresponding pm_runtime_put* in the ->suspend() callback.

Of course, if you could make use of pm_runtime_force_suspend|resume()
that would be even better, but then probably need some additional
re-work in the ufs-core layer first, to make this work, I think.

[...]

Kind regards
Uffe

