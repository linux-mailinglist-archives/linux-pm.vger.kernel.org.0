Return-Path: <linux-pm+bounces-35227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AE5B96573
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FF1167708
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EA724635E;
	Tue, 23 Sep 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbbifZ/2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36821ABDD
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638268; cv=none; b=W03EovChYbtn8w1bbvaUXtHIhMM0IOK3aAt+jz6StVhoiFCV3Mdr+oJabM+ULQ8asQQ5SNHoaIJj9GxK7z66wyJUqL0sM9jg1FXWKAgTwIQYJMQLjRxFdE0J717RhMNioQfOpet8PefTy2dVI+rPURAvjiHN2pUf9/Dc+9tHYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638268; c=relaxed/simple;
	bh=UcZep7l4gtYTIQyVGonuLQCx5rE2XP5lhttbFIWJNmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+hj7O+R3yziKSlAYxMTt9FFf7JLwGAAcPRXu+hVYIdtm2XUJO1YCT8RvybxdyvIOeXl2ggMGiA46VQVeOvpeVrCPyq1OStvyQTTARx7LSUB4IrZE8D/em7F5Vztwf758ZbQTqO3aMNT2uqHKd+Rn80Fy56moH6sUvt10MV2E+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbbifZ/2; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea5c06bd2b2so5769666276.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758638264; x=1759243064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oglCBmL4B4WbAybvmqD8cJJViYSD9fzgh1Gue4gY1UE=;
        b=JbbifZ/2B5kh540y4ADqATKaX+xr2CitB/nPPXKxjCTyHS6M6pCn5GqUhRocs5KW7o
         LyX1JTqQMa/rcZVXpjWiQrYjOoCxjxlSMiK6iOKFyBb6YXu6WTLt78pdVsYPb6lLIlAN
         opUwBUSRF4mIKLdcmhqbBzY2h1k+JYf6OcdTW1vBJg9snbPlb4Id3meu8uXdrZP9bKYV
         m7XtS5PkRAk98xKxzhBcDt87CUdcvNstgOb3Ht6K0nKqw2rCL1QoMMAnRj8pPA6e6g26
         3JGY1r2VS1ATYJpLW3/M2fQL2T7KeDGgj3XzBoTYAHiEZyerSj95LyhkzsvZtG9gh4RC
         lDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638264; x=1759243064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oglCBmL4B4WbAybvmqD8cJJViYSD9fzgh1Gue4gY1UE=;
        b=M1eHt3f2P4dWA67wVNs093axH7FHhPqproM4BH4c9fOLwmevF6ndVei1Rov1SAtYD2
         gp6CLLwEj3bYpp7OVmtS1IONiUOJt5rItZTTi3UbFiGgsdfBxZAhzbJ3lKJxq1x9ptvZ
         uCBG5N+stcTsCkB7vWBRHgW0+J2DWVMjxKEfdszTUP81sjs7tBNdMRoKHq5CzpV6hRPE
         DnOcx5o1XcJhipIJlpcxoUoF9fWc8NOpJhPB1Z1MPVKZWNYU4nGL+1epYNROLrZrDQaG
         F9SZ537YuoIxMDN98FW7I+9mcMkJqW8lqT3o2kZawekbtEquSQMLWlLHCI4IMUekGCL5
         8jTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQLx80U6voPHmMvGcTowtk1DpvBcOMFoQwQsAKzkJdyp5Ng1+03G0r01pCMjeuw7f0ttysQrELeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxytrTBZnJT9nPQ0DMV77eICZUWcj+AlduDXdHj4yekRXzHtb
	CjltH8SgveRM4MJmYeqyYJY4nq1+itLA5Qkr9HJzR354hMM0hMo0odQUTcF80P/ZyYyi3nmJ23G
	qVTfsUzxjZwlQF1p5cdoV2CR3eUudB4EgRx2EYo8q3xL2HHgal3Bj
X-Gm-Gg: ASbGnctJ3Eo9uU1n8gaeaVOi35hHocplp7laC4tyav5kC48buceOvlFRJfS9rjGBGmT
	uw4qePUwqDkOo0qcN4eOpbUf1xEuDvde6ABgjcZ44ZtkVx1/ElfQls+lnvV8uRrQoEKsoiwQ2OF
	d40/WXCeodIdCTl9rPpX7FAM/YX8kaN4C4rPE/z2CnSyIRjoZbT4dYFGkGP2R+uBWHI9TEk+oEj
	aFeXVcM7D2N
X-Google-Smtp-Source: AGHT+IEXKuzIArBc91/KA3f/YzDK175N+zTx0haFXxYxlTGRRGGJLMlWHDTe/A1+uBFUxsZwnePdVwoGLZBFbpfcE78=
X-Received: by 2002:a05:690e:42d3:b0:635:35a0:c5a0 with SMTP id
 956f58d0204a3-636045219e6mr1586791d50.0.1758638263271; Tue, 23 Sep 2025
 07:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
In-Reply-To: <20250923-mt8195-pmdomain-audio-fix-v1-1-782190385f46@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Sep 2025 16:37:07 +0200
X-Gm-Features: AS18NWDFuHpbFMIzRsDGrqDtLAtiZBYWyMCQ67uXlma11BT4iPN9Gof36Ta3gH0
Message-ID: <CAPDyKFrpwZ+7202Zzs=Hh3=AYqAOPpr98CubYw8dRp5Y+ScxpA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: set default off flag for MT8195 AUDIO
 power domain
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 10:52, Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> In MT8195 power domain data array, set the KEEP_DEFAULT_OFF and
> ACTIVE_WAKEUP flags for the AUDIO power domain entry to avoid
> having this domain being on during boot sequence when unneeded.
>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Patch tested on Mediatek Genio 1200-EVK board (based on MT8395 SoC)
> with a kernel based on linux-next (tag: next-20250922).
> ---
>  drivers/pmdomain/mediatek/mt8195-pm-domains.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/mediatek/mt8195-pm-domains.h b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> index 9405e8f62eaf07112d52a28e6545d26a4342c7c6..1d3ca195ac75806c458db71db4538940f37128a8 100644
> --- a/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mt8195-pm-domains.h
> @@ -126,6 +126,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
>                                     MT8195_TOP_AXI_PROT_EN_2_CLR,
>                                     MT8195_TOP_AXI_PROT_EN_2_STA1),
>                 },
> +               .caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
>         },
>         [MT8195_POWER_DOMAIN_MFG0] = {
>                 .name = "mfg0",
>
> ---
> base-commit: fba389ea7aa6401d3539456123cbadfa1a87231e
> change-id: 20250922-mt8195-pmdomain-audio-fix-f7ebf2afb15f
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>

