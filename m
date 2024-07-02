Return-Path: <linux-pm+bounces-10382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3F9248B5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 22:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7821B211B3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 20:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33D1474CC;
	Tue,  2 Jul 2024 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh3b7xn2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B61A28C;
	Tue,  2 Jul 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719950551; cv=none; b=L0IZPr12j1r4YqoFHYpHxReVZOqxniFK6aLasXf6FwXr9zvYBQD3kzh5RlXMKtIpFFIb6g984IR6c4Exrlz7kj5JjiYNKgCCaC5CXQIr4U8ymKadsMs1bXJ+fAofkD1zQ8CLFwZfbh4kS8L1cBtGz9ocD8oTGwAiB0nUa4Zmtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719950551; c=relaxed/simple;
	bh=aNMcKdGJy1ejuhUj8RLapiBJNpx/dCopM/eNakY/F+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgGXP01BI9OC0aC78/7eDnb5hfPy4p7LscsCVS9Rj3KpwgQOBDDdEQhAlS+l+k9p2/A4sf5BzPAy+NLrxV6ztmnR4uXBrPkq2/Q4Dk8YUcE9egwZbhxpK5UTbf348RM+GeD7CTwQrLn0yQQiDZpRPWILOX5fUNnLmYDzzSYnyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh3b7xn2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so1447116a12.3;
        Tue, 02 Jul 2024 13:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719950548; x=1720555348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Pg/7/y0EFr0qym6npwJSRe3aSLtAiBDqbT1OWBwL6c=;
        b=Vh3b7xn2bqmX5/Pm8w1yaXy6BUMKUWFXOUsCnuDRaMwSgvHoV2ff7ZVBiHpCKhLYHP
         ELCr9MJ3eYnT4PwJB/ylr72K86QydMTqlIdorNBZTdiGlQWFB+ZgTqoEWoJy6M/7Jc2p
         P0J7n61aKn01+u8COou8BF7R1Xm55UQeciLXJrSrlKCxgo8OA63e3HCTdnOlm86UvH9E
         0Bhbz+Mqg1vq8m8LU62v9RTDjFSkkKqwkJzBKzei4y3uHxAzR404gsjlwVYi7pXaNRs7
         QXu+DMuKTBzUbDdgVExlCuS7mBg0ERrWm/J/SZYc3AwPwmnzz/7gG1dtN/ZB0xdCpsGO
         IkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719950548; x=1720555348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Pg/7/y0EFr0qym6npwJSRe3aSLtAiBDqbT1OWBwL6c=;
        b=KgBHnGp1sX4Xce8vFGQcbMHP7UIaupTDBuG3sInnf4012hlUo1GUAxquArRRPTWX8g
         NV9LQ2LiBfJ6CA3HSC2bqOxyj8TQW8rBKCeWk5u0Mfa38uDZRMMKGfJ0oyjvN8L4xakS
         2/aETU4/b2SJB68T9Pw7Mdx/kL9vHmbtwUC3HSZFqTUObqf284FiN0+SWvFO/2L6mP+X
         lM0xK3k2Gqfknw42Hpax3/cM3yrm3+rI76MPOA3+RxDzzktF6lEP8Ldr4fviPw5YPY5U
         aPXWU7ycYPAuS9nxsYGZXGKYJOA4CgT7CdW71ainn0YlDLXwavlAZk/CW/eFzi/tiE/Q
         LFnA==
X-Forwarded-Encrypted: i=1; AJvYcCUwV3F7+Cs7EFz16Eo6gLxwULcHBXF4b0ihrm1SylAlPPDrXOpVq1m1HRwamJKZ5xRf7ucdLt7NAEBsyV6zD7/1HOVGO7kdwuBm1VTVMYotzi26tCVnLDIm90TXsfMcre2Gi7GQyQUpdTq9zzv+KN1cLoxeP+g9w0nNmT6oBvXfD/g=
X-Gm-Message-State: AOJu0YxXHbFwYCRbKYuBaZUUE+0HN9Kx5P4UHVa9NrDr0kCuU/rNfiv6
	j/RrJuz/nSW0b15ng/0odj+PrCDFBysfndjJIVAbgrhwJ8n5RsXXyNjYSaZAUHiDfb9wguioa8i
	qFoXWInBx3wivFLRlg+cibzPkojY=
X-Google-Smtp-Source: AGHT+IErxlYpYjfRcRB5QMt7MSaZ5l3hizvYH11QkFqGX9oRaokGttb3uuyPnhbm4/zJYyWoC3TDeO2AFSWSTp5Tgyc=
X-Received: by 2002:a05:6402:51c6:b0:58b:a92f:2917 with SMTP id
 4fb4d7f45d1cf-58ba92f2c06mr1496921a12.36.1719950548285; Tue, 02 Jul 2024
 13:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630153652.318882-1-wahrenst@gmx.net> <20240630153652.318882-8-wahrenst@gmx.net>
In-Reply-To: <20240630153652.318882-8-wahrenst@gmx.net>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 2 Jul 2024 21:02:16 +0100
Message-ID: <CALeDE9OpdUntjW61i=Ge2b9uOyPKWRmeP+2ybxoNA2CR4DHWXg@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/vc4: hdmi: Disable connector status polling
 during suspend
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Minas Harutyunyan <hminas@synopsys.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, 
	dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-list@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

Hi Stefan,

> Suspend of VC4 HDMI will likely triggers a warning from
> vc4_hdmi_connector_detect_ctx() during poll of connector status.
> The power management will prevent the resume and keep the relevant
> power domain disabled.
>
> Since there is no reason to poll the connector status during
> suspend, the polling should be disabled during this.

What about HDMI-CEC? I don't know well enough how CEC integrates at
this level but CEC can wake up the device over HDMI from a TV display
for example so if this affects that, while it's maybe not required for
first pass, I know the rpi is used in a lot of media use cases so the
ability to wake up via CEC would certainly be welcomed.

> It not possible to use drm_mode_config_helper_suspend() here,
> because the callbacks might be called during bind phase and not all
> components are fully initialized.
>
> Link: https://lore.kernel.org/dri-devel/7003512d-7303-4f41-b0d6-a8af5bf8e497@gmx.net/
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index b3a42b709718..e80495cea6ac 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -3106,6 +3106,13 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
>  static int vc4_hdmi_runtime_suspend(struct device *dev)
>  {
>         struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> +       struct drm_device *drm = vc4_hdmi->connector.dev;
> +
> +       /*
> +        * Don't disable polling if it was never initialized
> +        */
> +       if (drm && drm->mode_config.poll_enabled)
> +               drm_kms_helper_poll_disable(drm);
>
>         clk_disable_unprepare(vc4_hdmi->hsm_clock);
>
> @@ -3115,6 +3122,7 @@ static int vc4_hdmi_runtime_suspend(struct device *dev)
>  static int vc4_hdmi_runtime_resume(struct device *dev)
>  {
>         struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
> +       struct drm_device *drm = vc4_hdmi->connector.dev;
>         unsigned long __maybe_unused flags;
>         u32 __maybe_unused value;
>         unsigned long rate;
> @@ -3159,6 +3167,9 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
>         }
>  #endif
>
> +       if (drm && drm->mode_config.poll_enabled)
> +               drm_kms_helper_poll_enable(drm);
> +
>         return 0;
>
>  err_disable_clk:
> --
> 2.34.1
>

