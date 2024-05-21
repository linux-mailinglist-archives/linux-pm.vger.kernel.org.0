Return-Path: <linux-pm+bounces-8020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A58CAC2D
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 12:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CE9B20DE8
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49E74297;
	Tue, 21 May 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jngtXm0a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B13548F7
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287001; cv=none; b=LiEKcy6zMtA1j8ZIopwX2QCsZCBeUKB5nJsSb4/kvil7y0g2R2z5af+u5UJY7ti1BTQ9NmFV2q8aGACPKI4JhPtcfSW+3UB+JXxHEYheucA+1cgOmPFkRsjimlShvIsW5AJOv8WmriCE6qrHlNvJbGDV/qEvTGHnudrCPShs7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287001; c=relaxed/simple;
	bh=lNI0Hg8IC9ycV+6uxxjEMkC5MeHystRDrTQLKIOejwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4P1DKDhTtANO5LhGjWBwaYv7SXnKdrkUKwA7fmVwvTHF2TNn7f+oGFnOYb9kRL+I8VR+yvQURvTsEhOsmy1vyB33n/Tk2L9Pss+sadWpbPZ0uRPVJFf09+tWrKMjvBMSw2GCpNkqKNeEzdNbqqMxcKcOAvAYW9bY/LCXKtTrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jngtXm0a; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-deb654482bcso3600318276.1
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716286997; x=1716891797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eQal9jlDbLEH1BqRzTobfVTZmQmUTVx0/uC+Hwtv/IM=;
        b=jngtXm0al9OXO5noZQIZwetNA7ZGfjFdE7rWdfSyq6QZxSeI7dN4F/Nh8EvN0ZPZSk
         aCeHrqhN+7gO+hGx+RYVyAaMQ0eZ5b9gVlqyT4sYwrjJ3eyl1KuS8Yl3/VarGqQaCPQq
         aLCHnbJ529IHLP3Je+Dldczz43NAlIP5sLMCZHUem13LigxRYUYTGjB7GiZkbYE2cTiV
         3rkA0lDy1IEJ2iznYSe8LA21GaSmRbC1hjdfNY5HgdzgQn1csNWjmENNpY8n2GNLVD4e
         LdWEVIZMttP2sdhqA+gQGd6koRTdUfDHJmPmbukwUo3mbdYNwCJAIjv+ZUvXVjdcfjAk
         lBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286997; x=1716891797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQal9jlDbLEH1BqRzTobfVTZmQmUTVx0/uC+Hwtv/IM=;
        b=DTRhzoi7+xvdX3cArPRaY/tOKDqxBhsQPGMpBudfUH07ab5HE2+wIWd7Vr6jn1ifyb
         +jwDEDB8wSIgUsRSYGIyT2Gpd8bAnXHbp0q1TQotsvhTuN+A/3p37FMG076D5aGYNCRr
         bpQeLBTkh5P5GOCmlmVtx5DDXGkJLDN7Lt/i4gqH1j4uhYbpF1mjornkeqzpxC6isw1b
         OCDcPqWIG1FCQYxnEFYBhJePon6V/AJCPxiP/7mDeSDaJE3ZcbQT9ZQAkaACxPEMey05
         e0gG204VDRqwe3Bi6kOXzGyZFH+AxvmZdAsjFqtEBFSAxXFehTI/QKVSnEm5RcMIql4R
         Ykyg==
X-Forwarded-Encrypted: i=1; AJvYcCWEV+IFZEXezZVRMg+u5dkB49HQCe+WRfUTo5GhuAGzM2EilhmD9w34qP4DETq0VShYyAwX2yv+fgBZwlBqdb6UVOCHbj8JGkY=
X-Gm-Message-State: AOJu0Yxl0WwDGd+cbyRnYW0xbyowbYn5MODiR6/odfE2rkr4BZllZ8c2
	m8BELS0H2Atfh0isuRNTk4qoeSGYmTyZ8rRcPF/tgyf+eqvndpV48xjapmRkuZtusugrul6ZEd1
	47S6aF+J5NbJsN49AD+VXHgqjcwZv0PBLbuMTHQ==
X-Google-Smtp-Source: AGHT+IFusdwxmPQewGjPt+54YRS/caX7jsa//59b5F79W2aGKtmYSc/Hc4mM2ZuST8VV01w+uClOUSg1l5sjccug07M=
X-Received: by 2002:a25:3619:0:b0:dee:9baa:7760 with SMTP id
 3f1490d57ef6-dee9baa77e6mr22767700276.19.1716286997611; Tue, 21 May 2024
 03:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 May 2024 12:22:41 +0200
Message-ID: <CAPDyKFp4V8f0iyeRASSEu4YaCSz0m56=8ssBJ9ogSvqG1dzMZA@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: imx: gpcv2: Add delay after power up handshake
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: heiko@sntech.de, u.kleine-koenig@pengutronix.de, geert+renesas@glider.be, 
	rafael@kernel.org, linux-pm@vger.kernel.org, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, shengjiu.wang@gmail.com, 
	frank.li@nxp.com, mkl@pengutronix.de, linus.walleij@linaro.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 05:15, Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> AudioMix BLK-CTRL on i.MX8MP encountered an accessing register issue
> after power up.
>
> [    2.181035] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.181038] CPU: 1 PID: 48 Comm: kworker/u16:2 Not tainted 6.9.0-rc5-next-20240424-00003-g21cec88845c6 #171
> [    2.181047] Hardware name: NXP i.MX8MPlus EVK board (DT)
> [    2.181050] Workqueue: events_unbound deferred_probe_work_func
> [    2.181064] Call trace:
> [...]
> [    2.181142]  arm64_serror_panic+0x6c/0x78
> [    2.181149]  do_serror+0x3c/0x70
> [    2.181157]  el1h_64_error_handler+0x30/0x48
> [    2.181164]  el1h_64_error+0x64/0x68
> [    2.181171]  clk_imx8mp_audiomix_runtime_resume+0x34/0x44
> [    2.181183]  __genpd_runtime_resume+0x30/0x80
> [    2.181195]  genpd_runtime_resume+0x110/0x244
> [    2.181205]  __rpm_callback+0x48/0x1d8
> [    2.181213]  rpm_callback+0x68/0x74
> [    2.181224]  rpm_resume+0x468/0x6c0
> [    2.181234]  __pm_runtime_resume+0x50/0x94
> [    2.181243]  pm_runtime_get_suppliers+0x60/0x8c
> [    2.181258]  __driver_probe_device+0x48/0x12c
> [    2.181268]  driver_probe_device+0xd8/0x15c
> [    2.181278]  __device_attach_driver+0xb8/0x134
> [    2.181290]  bus_for_each_drv+0x84/0xe0
> [    2.181302]  __device_attach+0x9c/0x188
> [    2.181312]  device_initial_probe+0x14/0x20
> [    2.181323]  bus_probe_device+0xac/0xb0
> [    2.181334]  deferred_probe_work_func+0x88/0xc0
> [    2.181344]  process_one_work+0x150/0x290
> [    2.181357]  worker_thread+0x2f8/0x408
> [    2.181370]  kthread+0x110/0x114
> [    2.181381]  ret_from_fork+0x10/0x20
> [    2.181391] SMP: stopping secondary CPUs
>
> According to comments in power up handshake:
>
>         /* request the ADB400 to power up */
>         if (domain->bits.hskreq) {
>                 regmap_update_bits(domain->regmap, domain->regs->hsk,
>                                    domain->bits.hskreq, domain->bits.hskreq);
>
>                 /*
>                  * ret = regmap_read_poll_timeout(domain->regmap, domain->regs->hsk, reg_val,
>                  *                                (reg_val & domain->bits.hskack), 0,
>                  *                                USEC_PER_MSEC);
>                  * Technically we need the commented code to wait handshake. But that needs
>                  * the BLK-CTL module BUS clk-en bit being set.
>                  *
>                  * There is a separate BLK-CTL module and we will have such a driver for it,
>                  * that driver will set the BUS clk-en bit and handshake will be triggered
>                  * automatically there. Just add a delay and suppose the handshake finish
>                  * after that.
>                  */
>         }
>
> The BLK-CTL module needs to add delay to wait for a handshake request finished.
> For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS clk-en
> bit, it is better to add delay in this driver, as the BLK-CTL module doesn't
> need to care about how it is powered up.
>
> regmap_read_bypassed() is to make sure the above write IO transaction already
> reaches target before udelay().
>
> Fixes: 1496dd413b2e ("clk: imx: imx8mp: Add pm_runtime support for power saving")
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Closes: https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com/
> Suggested-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Sorry for the delay!

Applied for fixes, thanks!

Kind regards
Uffe

> ---
> changes in v3:
> - move change to gpcv2.c, as it is more reasonable to let power driver
>   to handle such power issue, suggested by Frank Li
>
> changes in v2:
> - reduce size of panic log in commit message
>
>  drivers/pmdomain/imx/gpcv2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index 4b828d74a606..856eaac0ec14 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -393,6 +393,17 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>                  * automatically there. Just add a delay and suppose the handshake finish
>                  * after that.
>                  */
> +
> +               /*
> +                * For some BLK-CTL module (eg. AudioMix on i.MX8MP) doesn't have BUS
> +                * clk-en bit, it is better to add delay here, as the BLK-CTL module
> +                * doesn't need to care about how it is powered up.
> +                *
> +                * regmap_read_bypassed() is to make sure the above write IO transaction
> +                * already reaches target before udelay()
> +                */
> +               regmap_read_bypassed(domain->regmap, domain->regs->hsk, &reg_val);
> +               udelay(5);
>         }
>
>         /* Disable reset clocks for all devices in the domain */
> --
> 2.34.1
>

