Return-Path: <linux-pm+bounces-23489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F5A502FC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2729D189E1D5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC824EF66;
	Wed,  5 Mar 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYWrzSbi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4024EF60
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186447; cv=none; b=QgLk0i3pwDbdts0dVj8UIQefKNwKCyp5Xtvp94WFi592KwRinG0Pv1Zjro8ztHLNpkPV94MhvU6k98DxoZ4kggD4uDCOT/3pSvi65F5DjcCSycE1M9Be5P7uybI6347xzN5Z8EHiPqBFTEvPOGdO+k0JygB1mioNZyqgt1F84Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186447; c=relaxed/simple;
	bh=WwcEMSxxHLOGH9XJtwTKimEYpC2lcD67Srx1N2R9Nj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VY11lFV9AqfGOQXWdvzZkalgHubG9cbQJLxX86AzrT6MlN/K7cCe1CdXYCNKPJD0b0CpmxltjbTszlRw2cq8LX3rJzjOf7SwjShYQOJ/RL+z4FjMRwUW3GUtWi7BMSrlzJjRC9zHYFcoj642msZHuAleeq1Z0snm/LpmatqiU70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WYWrzSbi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f4434b5305so61454077b3.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Mar 2025 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186445; x=1741791245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VeNLwaFo16zfbUMvLDVk5OOLd3X39XkqYnX5zvlPNF0=;
        b=WYWrzSbiP/d/yY1ksRcSJUCn4y1DK7lmTatxizCLzUldPJ7vvnQ01CzaKgrxKxFX8h
         MbI719Agtv6mPco3dXZ8ACO04azQY4Aj0a7SZuZep8w7Bqqc9EHJEPyPl9ZJ3e6JZe3Z
         1tTH2dGEYwmlXfQTkexaosnP0NQvgEUpSu9eupcE0cTxfbd9Li9bIkROisDlMIFdRlJY
         Ieyyp0hTpwhP6Q6hrRkOn9/T+tSY8Ma1EeQ3BmJlu6SWXDzK2jPIGfk2dKTKY7UU1yh/
         vsv05aTb+JzTZWUyn1gKlJ3MQkpDd1FxMIZFca2HRst8Ns8/38dXgaqA0VQMKLDBfDZs
         jZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186445; x=1741791245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VeNLwaFo16zfbUMvLDVk5OOLd3X39XkqYnX5zvlPNF0=;
        b=Ihk5FKkaLEB6ET5rQ82PbfodJKR9OsTwojY0rPebPaigBE8K8/qt4KJOB4X3jboUJ1
         aemMe0CAeu7aHoAToFDGhhc6WoRkliTNvcl83zeTnlNKSbUUDHsf31sGNum54BHkqmp8
         GojEgDd31kh8ahIH4PNllAMeII1QjIw/Yswrm62p+Pq87N9pjQTzrNrNVcq3kLMSvH2/
         BlfAMucia0mXaATQ2xfJfUmOwHu0E4+6G/S1nUlTIgPtemvLkKItB7g+j/1/CY0lD0H+
         ZiU/QMzDVZtngueG6J3dVG33byeAXxTVhuVkuGAGEg18KdAexs32p7JrRkAxQYPMmqJc
         Nx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/pSvOtTomj9ailBSIu8iSXauxSG0B5s51LmVBKRWttoBLR6hAiQQ52UxTPReyd6GIy50pNU2+/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQGWYizopEUCoeQ7drohX44t5OjJIAwg/o30+K4j7b7DMNikz
	f2CTgDRmRmFkZOknSowo2dOo8EBO3LzO+pKKL1tswdTSUQzUyXDn++XLGbe3Khd9lG4GoOgSNzN
	pNg+r0Qm+c6tokJrUs3pa2lCrvYhY4NnSlF/bkg==
X-Gm-Gg: ASbGncvbm5srPUnGb+N+z3faQv1nuwYf2FPOv6EyBUf/u8oKfP1p5GAOZCpqpybYKeY
	VOTNtgkV+DiWbX7Cu1OgVAI0NvZqFAZdGxfk0axB12NTVg+eW2/y3shtqFyl8aQtCk3Jci5DDv+
	4j7cA1J1UIyAV2SObWUmlf8jo0n7s=
X-Google-Smtp-Source: AGHT+IHaRzLfs4e0s/mjCkKbOX/Qq8AuRys4/xKKYjDcoyyp0XIFqNuIteg7ybYGY5j3p+l87FS/VuOkxSFDK6iD0FQ=
X-Received: by 2002:a05:690c:3749:b0:6fb:b78a:c0e5 with SMTP id
 00721157ae682-6fda310bbf6mr42777697b3.28.1741186444835; Wed, 05 Mar 2025
 06:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
In-Reply-To: <20250303-fix-t7-pwrc-v1-1-b563612bcd86@amlogic.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Mar 2025 15:53:29 +0100
X-Gm-Features: AQ5f1JpdUfHmjKXFkOL_14EaaLzX4OU9jP-SAbgoA1LHg0Ze3bkxnPXr7Krf_aI
Message-ID: <CAPDyKFoTBt4g=M1rHrZEPLO1y61csy3_cHfJDANPbvV+bH+YXw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: fix T7 ISP secpower
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 10:06, Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> ISP and MIPI_ISP, these two have a parent-child relationship,
> ISP depends on MIPI_ISP.
>
> Fixes: ca75e4b214c6 ("pmdomain: amlogic: Add support for T7 power domains controller")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/amlogic/meson-secure-pwrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 42ce41a2fe3a..ff76ea36835e 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -221,7 +221,7 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
>         SEC_PD(T7_VI_CLK2,      0),
>         /* ETH is for ethernet online wakeup, and should be always on */
>         SEC_PD(T7_ETH,          GENPD_FLAG_ALWAYS_ON),
> -       SEC_PD(T7_ISP,          0),
> +       TOP_PD(T7_ISP,          0, PWRC_T7_MIPI_ISP_ID),
>         SEC_PD(T7_MIPI_ISP,     0),
>         TOP_PD(T7_GDC,          0, PWRC_T7_NIC3_ID),
>         TOP_PD(T7_DEWARP,       0, PWRC_T7_NIC3_ID),
>
> ---
> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
> change-id: 20250303-fix-t7-pwrc-f33650b190ef
>
> Best regards,
> --
> Xianwei Zhao <xianwei.zhao@amlogic.com>
>
>

