Return-Path: <linux-pm+bounces-5920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C448985BB
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3A3B2691A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959880C1F;
	Thu,  4 Apr 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HhNRhFOA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472076EEA
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228844; cv=none; b=HrEUlV9v/IFWdOyc2sQg7DAewbgXbrD1JOom/PdR9O+ZJULU+4qQdRlVzBrkZDB0byT4kGwsuRo9vlUs7UuF3MWFybX127fB06LPPyOw/cbuLnXKT68+T2XQxHqDjpzICiuPBX6kabOtZfs1Y6TmEYSkPIVzdHRhjkpvuALtu84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228844; c=relaxed/simple;
	bh=bKpNseyzs35xJjlrg2U75nMP+r4dPa4IHVFOyJk4SZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNah59DMILiS2mPcQWGMDyMSFATYIvnHc3pXdPfi4YaU4Y4zYgeG9fevLaaNrdmvxY8ON3SLrLoPmR7WWSjQfeCKUUIiohF+TlRycgUKz7xk1KWofqX7zQ9vqXRc0vIKc0KiESwVGieHEyXVX+ioCtFM8+6nTZuI1kLWnFWkzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HhNRhFOA; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbed179f0faso1552916276.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228841; x=1712833641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oHD9JV4m82nygiSTDAq5ON48xPlEJ5FvZuZE2N1ZJm0=;
        b=HhNRhFOAIPRgNlY3AVaoLv3N7UvDbMyqabq9f2B+5c9pGH6wE7t8G8q5RMRxerEKha
         Xqd4E+VS1bq4fCFE+2XNNkDOPlHKDgzvcp7gIuhZeUxg+3CUwNcZh1KMFKb3u+9o2AmA
         8h+IDMlQVh9+6jwi56lX6wCkPSG8VUHglkF1+yyocx68JZ9xsYOBc0g34By8xvaXKQpW
         p/3/V3dEapsda25/H1t57mkMi28yK6peVH/7GKkKfij3k984TPGqFv4f2oA4oxqFKMR5
         ngtAdufOXzoyqd7TKK8aDb3fvCPUBArDiQHn7IFC0mc5Ie7Ukom7HmcJJYM95PD4Arff
         1NCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228841; x=1712833641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHD9JV4m82nygiSTDAq5ON48xPlEJ5FvZuZE2N1ZJm0=;
        b=E/eo9reWfrTw6rb8J0c1/3fOLwjel64xN07Znhoo4HZrdP7KdebOiM6geZkvI50SQP
         MOXmZEhQVzVEUe8TBUt7N2GYFRBHBqTcZpZMwxR/FLmfz73L10RdR+Dx2i59whqbPed7
         vj31CxON4YxGEwjd4MhZ9BmVwkCijA3Xm3fuo3bAZTII1x2NKfU6Sbd0tknr/GfIO0kK
         598Zx4S9MgK0kXjq54v7XkXRt0dGhL1ptfzWg5x5RK5rQrqfInOHPZm06BEoFDja1155
         8nLqNd3UHeW9SzrHQLxXegBFzze5IXy4vjjimue2dqYpFnGFx+1DgbBMprTP2g8Ly+wD
         7Stg==
X-Forwarded-Encrypted: i=1; AJvYcCWuW3xeAFN5qDKwgQNZdBBanKp09lYPVDVsBUVLcdDdqCr67UroRavd9imkVSttbqJ9V3rPLoL/zMfbsz9PZXhfqnS3uD9o8W0=
X-Gm-Message-State: AOJu0Ywg9MfffR6TSQTU3Jte1gEbFfHMnOeQaffC7jK+xkPs5FQLcn8/
	SHCE+y8sDjXpx57iHOO+i7ywxfLxvLfO7f729MN+xMebbVRd6gcwPqeNTMtsqFsotmWhUAFYrUs
	s74fW04z8rQHCDjE6X8vatyb9mtIrNIy9kDJNPw==
X-Google-Smtp-Source: AGHT+IEdb5eDdMR2pzlmAeWFysl5vbrnmwOuO47TeOKmLsOviJwwZdcwKy2kO2pvO93pIdJM5SmQx94UTo9d6J6akDM=
X-Received: by 2002:a25:bcd1:0:b0:dcf:eb30:c580 with SMTP id
 l17-20020a25bcd1000000b00dcfeb30c580mr1729408ybm.3.1712228841409; Thu, 04 Apr
 2024 04:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 13:06:45 +0200
Message-ID: <CAPDyKFrWHTcW=gSL8qPSovf8C-KnKpp67N6fD-wAn55Okb3PLg@mail.gmail.com>
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

I have picked up patch2, leaving this one for Bjorn/Konrad to manage.

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

