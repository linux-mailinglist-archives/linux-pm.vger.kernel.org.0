Return-Path: <linux-pm+bounces-33820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AECB43868
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 12:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 103537B610D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE02F7463;
	Thu,  4 Sep 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMNP3pES"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30F2135B9
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980910; cv=none; b=XdlWf10wcJkApAhgmt2Zcgq7/tINYHbPmRNiQzLoBRS6i0gq17du9qMNcHIYdpUpUgZr9eIt0u5vJXgDIKS1HhKB55wKn0nAPLm33L+pComLwFxVPHX/WMXebxFVOTyfKr2jumcAMtHgYJNZ7j6ZPw/MKUrdmE1NoD775Rmuskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980910; c=relaxed/simple;
	bh=hXmp/6NZtKOVFeRFoYpqlmngv8dalmMKWbkl+IudaVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyy3eFXqKic3sXVyTwIGDjK9CJ6PV11WvPyOY9F8OLV1tNWazMIaaWRUUNqZbekscvC1DQVTcz76uD9nl9Aayn8DTjp8piA6L2oancg8S1aEVGjvJa8he3dk8ZqRQA8ICEapzdUNOVAaFrAPZeKaY8lExmKbKlC+EuKMTrcL6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMNP3pES; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcac45so8860007b3.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756980908; x=1757585708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUjaia+OhMAEZTusU0F5Oa10icPeXNIDTIJALCJZSU0=;
        b=HMNP3pESzpg354o/f1ivPsH6ICqaXLiQ3k6XhQ9WH6r04GsM217BK17frrsV6Rng5q
         uHdqRw9d1h/te5VTnMtUDHyluuMJO4oSF24CSY4tDgWXVHGctf040OfwLW49Uzmm1LnK
         teKipBw6nh8X3GJoceFg/WaRPo2ffS/6Ba09+Hza6Hrej2PE8jVaHzCjbbKFQKU059HN
         5ycy3P0KqxJ4T2dRpiSBzbOzFcTYbpyP8tUf14fFJ2oYw2VUMzGO9eyQqP0jHzjjLSmo
         w77UBL7J6HmolPte2FPsooG+W33p4oRZY2LDaYN0Pa+nnAaJHkQZLEB5REeWJl5MQJ/4
         UKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980908; x=1757585708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUjaia+OhMAEZTusU0F5Oa10icPeXNIDTIJALCJZSU0=;
        b=at4ylgdbfpFPj0Nwmmm99Nw4bV6t2keCSgF1zTeZJcZGw9c0MDWWvOmFFhnZ1TkbHi
         /p5l1UKWNq/VL4DX+vjhgI8MlgaKZNvya8Y+uJ0O8eXY+Za+CVYH9CnMD2sVMeFlgKd8
         XSvfQIhFjYWEe+J68095KHXMgVhMB1z/ihgakXEidpg8LmjCYgRrPE1lAYQ09r21cFtB
         DZyXAyfyq7s4pHf6c2OFca3bEsy0kAuSdfmJcTBhXTu2X8+iqGTtuTNjMacprS0J1WsJ
         VeN8DpiIbkciyjfUwG3j/b4lP/M77pH5MXp/IRm7WcVOCJeL9vsaKK76ToPlw9YX52fV
         C2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWtvtl/yMc7H2sU8NPUnRdvd+wHtP0KNR03yKsLt5x9p0kSlNRqhG0REmnAGGL51tKSjQy6NGWBqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3gfR9va0ft3ZyDMwsuWS43DAa3EpxAHg8HWX7YKItSF3zoZqv
	TW2/XVrG2vz3qpkZXgEqXrazqB0fsULgeUmqWZ2+XqxSCbWFpqoXlxXY3HmATYlVEmidAqQ+5Sn
	GBvup1LN98Qlmqpaynapa1ZXWxL9StqTMBr2prbRq4Q==
X-Gm-Gg: ASbGnctf5nm/eLMsZXu6uloBclpr3OUhuFniR9WqPLNeA7193lifr1ifOTL2dlzk0iW
	PKhLhlfEsBqgn+1FVPyzkNMInoZDXUWORZCwiimejJvK3CWGaDtJdLkF1luXfozPuNy+3+Uj4JG
	eHUU6/IVMGiywOUoz807D9J8xIAL6YlEVI6MB9qfiSLauzXrPFFejN0Mx+xEhCCR/DeG/4kYJEo
	ioKalQQ
X-Google-Smtp-Source: AGHT+IG8ldfxQaFlFR9n1LdiPDQHlQEpQI4SJcztaYgkxIV+25ENTr0NTKySauZEe4IfUI9wm1RmPMFKF6lcMHOVLNM=
X-Received: by 2002:a05:690c:2606:b0:724:be89:9b69 with SMTP id
 00721157ae682-724be899db1mr15536087b3.3.1756980907994; Thu, 04 Sep 2025
 03:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074906.2907277-1-uwu@icenowy.me> <20250818074906.2907277-3-uwu@icenowy.me>
In-Reply-To: <20250818074906.2907277-3-uwu@icenowy.me>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 12:14:31 +0200
X-Gm-Features: Ac12FXx0dPstIEelprge7mji5eoxeEe15kSVfZZNfNFrPoUORBDZRgDPR8LTXnQ
Message-ID: <CAPDyKFombYNFvTsChewQ6cFY2woS+vSb1YUV0Bp_+DcigrFFXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: thead: create auxiliary device for rebooting
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 09:49, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> The reboot / power off operations require communication with the AON
> firmware too.
>
> As the driver is already present, create an auxiliary device with name
> "reboot" to match that driver, and pass the AON channel by using
> platform_data.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/pmdomain/thead/th1520-pm-domains.c | 35 ++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
> index 9040b698e7f7f..8285f552897b0 100644
> --- a/drivers/pmdomain/thead/th1520-pm-domains.c
> +++ b/drivers/pmdomain/thead/th1520-pm-domains.c
> @@ -129,12 +129,39 @@ static void th1520_pd_init_all_off(struct generic_pm_domain **domains,
>         }
>  }
>
> -static void th1520_pd_pwrseq_unregister_adev(void *adev)
> +static void th1520_pd_unregister_adev(void *adev)
>  {
>         auxiliary_device_delete(adev);
>         auxiliary_device_uninit(adev);
>  }
>
> +static int th1520_pd_reboot_init(struct device *dev, struct th1520_aon_chan *aon_chan)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev = devm_kzalloc(dev, sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return -ENOMEM;
> +
> +       adev->name = "reboot";
> +       adev->dev.parent = dev;
> +       adev->dev.platform_data = aon_chan;
> +
> +       ret = auxiliary_device_init(adev);
> +       if (ret)
> +               return ret;
> +
> +       ret = auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
> +                                       adev);

We have devm_auxiliary_device_create() now, I suggest we use that instead.

That said, I think it would make sense to convert the pwrseq-gpu
auxiliary device to be registered with devm_auxiliary_device_create()
too, but that's a separate change, of course.

> +}
> +
>  static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>  {
>         struct auxiliary_device *adev;
> @@ -169,7 +196,7 @@ static int th1520_pd_pwrseq_gpu_init(struct device *dev)
>                 return ret;
>         }
>
> -       return devm_add_action_or_reset(dev, th1520_pd_pwrseq_unregister_adev,
> +       return devm_add_action_or_reset(dev, th1520_pd_unregister_adev,
>                                         adev);
>  }
>
> @@ -235,6 +262,10 @@ static int th1520_pd_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_clean_provider;
>
> +       ret = th1520_pd_reboot_init(dev, aon_chan);
> +       if (ret)
> +               goto err_clean_provider;
> +
>         return 0;
>
>  err_clean_provider:
> --
> 2.50.1
>

Otherwise this looks good to me!

Kind regards
Uffe

