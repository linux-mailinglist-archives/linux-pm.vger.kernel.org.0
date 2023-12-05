Return-Path: <linux-pm+bounces-716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B1805BCC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4DB210CA
	for <lists+linux-pm@lfdr.de>; Tue,  5 Dec 2023 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB31E6A326;
	Tue,  5 Dec 2023 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XczyRqP6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8C6A320;
	Tue,  5 Dec 2023 17:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF7C433C8;
	Tue,  5 Dec 2023 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701798562;
	bh=PK2vCfbXtlwtD+G6evFibgNJ248BLr3rSJX0bTPzSv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XczyRqP6XKk6NmwbJAiVw8qzZu2d15u9Y09nPMYtc3MduPMmAykmqW3+ZS+qy6Yjx
	 /MYoHPl5JF1ouJeyiIYi706tyo897WWZflqBQ34K+eEdhKmRv2UzRmwb74gsx4JkpV
	 RnINHJ9HbLwdR29PK6kBjm+Bh5DSlfnQF0F7VBDyUJBq8WEKRUs84atW0O8vlN8wTl
	 TLK8zVwi0imtvTiU45lOcaWP1hVr456Z7nuOXMHadBNsBxnbzxqsQWVO2rSApFL4M0
	 Fofzqb6w6siEK+UXnKqReA+PL90tB4HRZYp3LaTAkkKCQjfpNEAAFElxrdwviZDuxA
	 iSbtZe7XAt5Dw==
Date: Tue, 5 Dec 2023 10:49:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: sre@kernel.org
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, u.kleine-koenig@pengutronix.de,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] power: reset: at91: Drop '__init' from
 at91_wakeup_status()
Message-ID: <20231205174919.GA535965@dev-arch.thelio-3990X>
References: <20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org>

Ping? I still see these warnings in next-20231205.

On Mon, Nov 20, 2023 at 03:35:32PM -0700, Nathan Chancellor wrote:
> When building with clang, there are two section mismatch warnings:
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x7c (section: .text) -> at91_wakeup_status (section: .init.text)
>   WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)
> 
> Drop '__init' from at91_wakeup_status() to clear up the mismatch.
> 
> Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
> Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I suspect this is not visible for GCC due to inlining
> at91_wakeup_status() but I did not actually check.
> ---
>  drivers/power/reset/at91-poweroff.c      | 2 +-
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at91-poweroff.c
> index 126e774e210c..93eece027865 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -57,7 +57,7 @@ static struct shdwc {
>  	void __iomem *mpddrc_base;
>  } at91_shdwc;
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	const char *reason;
>  	u32 reg = readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
> index af95c7b39cb3..959ce0dbe91d 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -107,7 +107,7 @@ static const unsigned long long sdwc_dbc_period[] = {
>  	0, 3, 32, 512, 4096, 32768,
>  };
>  
> -static void __init at91_wakeup_status(struct platform_device *pdev)
> +static void at91_wakeup_status(struct platform_device *pdev)
>  {
>  	struct shdwc *shdw = platform_get_drvdata(pdev);
>  	const struct reg_config *rcfg = shdw->rcfg;
> 
> ---
> base-commit: b55d073e6501dc6077edaa945a6dad8ac5c8bbab
> change-id: 20231120-fix-at91-modpost-warnings-beabd2bac722
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 

