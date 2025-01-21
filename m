Return-Path: <linux-pm+bounces-20756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F5A17A72
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 10:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4228D7A0585
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E11BE23F;
	Tue, 21 Jan 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS94ByCw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BB3BBE5
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452810; cv=none; b=OIwsmpx52RerJu4GFG7OXX2xpE2Uar1GFlZtWVHPdzYg6ysLYvcSIAKpSkifMqNq4gYjfisY6VVXkBeQq4xLi8VpfzfA56ocTbG80fmtdn8xDvYr4s1VpKVn6bQJhpSyV9x1y3Jfe5NGaglULoz1qn6AWpLSuZbIQ6X5FzXXAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452810; c=relaxed/simple;
	bh=1I+Uuama9ugZyQKsEohJdKjjc55GB3IcqY9SnNbolsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJq8HWwXtZ2rffEY+9L7g7looFcXwolD/QCqXxaj/+T/zZLuU+Mda7ZktPksyKKNWEJvqOU/OqOwk+QMdigzVFVk17X8hLIGd9RnCKwsCAxAQZ1ZPNoUumRh2LX6gs4t17VPsSOuVJmhEvBiYSRlvLY6y/tlHilMu5+y2n4x9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mS94ByCw; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a26de697fso8427529276.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737452807; x=1738057607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xCznPro7DzazvTiUhQrmITM+It7rrjrCA9i0Q4NMQd0=;
        b=mS94ByCwoazYn5agMSJCfV49vWPyyKcP+fIjGUIMSx+D+YxEdWu2xOM1dDIMwJh1ad
         tJ+zstROR0CbL3yx/i+RW018AI+uCyFhBSyl9No9AEl9xAJGHlEpC07VWz+hdjuimL1z
         uK+S6Fl/Z7k2qZbegcALlPUm6BSsJzq8H3ZMmk8g/Q3o3/sm2xFr8BO55TZRMMB0DGBJ
         +/wUNnNUYBR++suXUtUt/HG8zXY29O8pTdJaVu6NCOj/LsRYJOROLNFvp4Re5KPwkfv/
         H2M4PORAP4Olha5Mi94rPVfWC908EyKGPoJPPeOkthyUBksVcMjh7zJgUoQlCPNcvnrr
         PEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452807; x=1738057607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCznPro7DzazvTiUhQrmITM+It7rrjrCA9i0Q4NMQd0=;
        b=umd4hfGjdppN3lliJWFlSR8oMZrq9uCC3wTivqaSRZqSJORqwdMMjo+JFUHZx4XMgE
         EPFUpi9uiCZYyMD2G/li/ePAeHGwAuCORzRORoa0Ap6ejVM973D2roc4MZiB0EXegCLS
         fImG81UB8u3tp3xpb5oCLq2cASiPG0dsA2aL0F1cj2ThOhcsozE5EcbSZO3f0B14lL1r
         FesPkZFhGHqLhkewFad6dCmMCRBoK4YH3i3QkQ33lkmdhCMKHw16n8SF8x9Pz2OKGl4g
         KPwPfbN8hAw94HDJKqMMQmocJ8BQo8/RBBj4vUYt6RkONgJhlZRQJdFIwfvP+yibXhrB
         hT2w==
X-Forwarded-Encrypted: i=1; AJvYcCUKc4kty9pUNf4C0BLCINmFnKnpLw0VxuV8npOKeUTYiGbp9OkIXUf1AYmD4z/C1E0aLk17n2i/OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YznyBgYjN2k8fxV0o1occFZy0VPofaDkCRjnrEn6BaW/wxj3eT5
	SOm043XagllWQYFZMOwDFz4BAuvc+EMaFjyCryjsf6yr1G8WpGE+b3+foXe8rr36BRZ9sGa4561
	eHGV+VO9WV0MXCpgmgI7JBg2Mzre2RvVS4ZRtYw==
X-Gm-Gg: ASbGnctNsHMqCjJsJqkhxPo1SoBPYma3HhUro5Dd5mFUbBbc3pJm/9AGfWrRB9QNhoa
	dJx3PSV+hlGlwdqaWsfa4SCeN7ljHzDctfxIzwS1Vc7DZwmjZfBo=
X-Google-Smtp-Source: AGHT+IE4NvWjhVwcZefMFMPsNF1/yZL/+GizgE7O5W0l1UUq/sk+Rp9xLLX7buviHENqfSARwR8NAFZJ6rRHBgoskwA=
X-Received: by 2002:a05:690c:7344:b0:6ef:5ab8:2c53 with SMTP id
 00721157ae682-6f6eb68695cmr133051747b3.19.1737452807535; Tue, 21 Jan 2025
 01:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120153817.11807-1-ansuelsmth@gmail.com>
In-Reply-To: <20250120153817.11807-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Jan 2025 10:46:11 +0100
X-Gm-Features: AbW1kvZ21pVNkI7qM7rGH-9wFnhv5SdIw9t28_ewxvHO8LS13hlMrra20J6gTIc
Message-ID: <CAPDyKFpBtnsEfMg73UHdXzZvSNHaL8H4N1h6-2wAMnFWNTM75w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: airoha: Fix compilation error with Clang-20 and
 Thumb2 mode
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev, 
	Sudeep Holla <sudeep.holla@arm.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 16:38, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
> pointer in Thumb2 mode, which is forcibly enabled by Clang when profiling
> hooks are inserted via the -pg switch.
>
> This is a known issue and similar driver workaround this with a Makefile
> ifdef. Exact workaround are applied in
> drivers/firmware/arm_scmi/transports/Makefile and other similar driver.
>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501201840.XmpHXpQ4-lkp@intel.com/
> Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/mediatek/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/pmdomain/mediatek/Makefile b/drivers/pmdomain/mediatek/Makefile
> index 0f6edce9239b..18ba92e3c418 100644
> --- a/drivers/pmdomain/mediatek/Makefile
> +++ b/drivers/pmdomain/mediatek/Makefile
> @@ -2,3 +2,10 @@
>  obj-$(CONFIG_MTK_SCPSYS)               += mtk-scpsys.o
>  obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS)    += mtk-pm-domains.o
>  obj-$(CONFIG_AIROHA_CPU_PM_DOMAIN)     += airoha-cpu-pmdomain.o
> +
> +ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
> +# The use of R7 in the SMCCC conflicts with the compiler's use of R7 as a frame
> +# pointer in Thumb2 mode, which is forcibly enabled by Clang when profiling
> +# hooks are inserted via the -pg switch.
> +CFLAGS_REMOVE_airoha-cpu-pmdomain.o += $(CC_FLAGS_FTRACE)
> +endif
> --
> 2.47.1
>

