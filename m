Return-Path: <linux-pm+bounces-40149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DE7CEFDEF
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 11:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBDA43051315
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD952F7475;
	Sat,  3 Jan 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLyZC8sX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C522D0C8C
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434617; cv=none; b=i1N6BUSPyArPCVVzyQE47QB4c0YFoYOV9/zDhf5oVBta64H/fWymz3mGncKbdxqtudfszyfTmu4H6yCVnRWWXa0XPjKZ2mrzCLjeR3JKZSaA/NuSTsHnlJ0ADBVg5dwmU7IMfGwYkSPM+S0PefNTQ3IAVwzhOhtPPIxsPKZMnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434617; c=relaxed/simple;
	bh=YOxYeG1gOisubTj0MId0tBIEjLYkB9npr3rINp7eZ1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umKrtTfFwWvkIXFJyrOJ52Yh59KD6ZupTNnqUs1R+6DUr413YXc0Rbzh2GHGn07cKczvM+BI9IX18xQhbgpM/jdxB7YYdF5Vx/V98My3X6+TRhYNsWhK+s78CRHWxyMAc8DoG9t/kWSboIfy2N93ijXCuUdH55yy6XQIz1cLGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QLyZC8sX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso14340066e87.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767434612; x=1768039412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HHxJTJ6jLGr4jRZYNFd3Wgy5zhSvQPzyDXSFu1NA0Mk=;
        b=QLyZC8sXf1JkpBQyRQ+3a6JTbrLS1mIJqvL8eN7bF8rxm6UPs4cOdw2r84JUpKJc64
         7N0tovdELyhyjW4e7PlzJHTLYDdZzql2hjRsyxKD0l7tzBhK/+DeuGGE8t7j1l02CoAK
         TuVbPht0LSeC5S7tZ+SxYIUXMC2lkcGQ8R1IHW3achL8qCXUP3V2Z0BsgKZRUr4+B63K
         J8BYRmnIIytXkqV6E+Pj0Qx//kDaCKorIUVBk1TWn2ABU6ns7iM2gWm/OiCRrqAVNYxL
         X3/ICndx8gulgowTyDhBbMVY8r8mDW3FlovEt4hYg4evH3LmqdoDlTb8+dRv7lQCKk22
         86AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434612; x=1768039412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHxJTJ6jLGr4jRZYNFd3Wgy5zhSvQPzyDXSFu1NA0Mk=;
        b=SflCT5BuNnDoTpE9nTHkQAZdrmpGBjP18TfIjdE7WGgAia90xc+5R7FHDITVMqXuT4
         RLxHULt60FV9+PYuYiEwO55/URNZYRSd8rlx4Uw7xmUoGHH2YsC9NTHnPriLeO0FXmM0
         RV70PV9nf6JFt825zZ28fXioZQbERh82in2n6xJK2V9UNA2+tNf7grPdgsb2vlMMM9MF
         mCCc+pKVrdbVAGu9CKak5WgnE9dC3PrfVgoVSV1T9VTD0/iUOtRHfw3X+TryCksB5vZx
         rw7IuH23oHrzLVi7BTq8ezLNT+Msky/yRext1UDVTa755CRoTK4TXIxMHJXhSfBdLMbr
         x/nw==
X-Forwarded-Encrypted: i=1; AJvYcCVCZftLifDG98iSrTEmH86u0/YYHCK4cvdY+nzyvHSmL0HnU8jvCW7q5BAPXEJVqlz6ThG9+CBr2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEtIDexkSeT3owpeO9OhT+uUlEdIoLkloxGnRhyfx8FzxF1KQ
	WHczNlROppDgLyVhxtMiBY9XjT/wmdti1HyOUyc+Iq5JTqwPKezcvWJHEieJ6BZsl8lDN8DZxp2
	hvJhvk9fkVEXBVsIsu3hrlY8tZnNeXkFmKGPx242AlQ==
X-Gm-Gg: AY/fxX4bspqeowp0ac3qnT5ANoR3Pfwt9dLc4QDkU579wZbbYICxrSfQs8feI486z17
	VzL7nQv+cZjaaSutJyWDxmkJ4TDCOrxv9SkSa46Gjvkjm6jfl8NufRRl2xcw+9w6iUMk50YJPgG
	/mFp3z2V5+fe/iwQAnTJuFPXYq30UY26xeeBgVlq/vvI9ti6wbA7dZgA9GoEeFFKyby3glZm5v1
	lTIOcnRTKEfCeHvnIPnUkb5MO3C4pj9vH8s/QjW4aXi7KKhyj09tRRals+e858eGIjt7ZuW
X-Google-Smtp-Source: AGHT+IHTuUDA2frL2lWGCTN+qAVB9fALj4UxhdOgtU5kDcFiw+PtpJTP7vF0X8xaSzS7IFgYXZBQXy2NaxWawmUtdow=
X-Received: by 2002:a05:6512:ac9:b0:594:2c42:abaf with SMTP id
 2adb3069b0e04-59a17ddb4a1mr17911978e87.34.1767434611895; Sat, 03 Jan 2026
 02:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102124840.64424-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260102124840.64424-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 3 Jan 2026 11:02:56 +0100
X-Gm-Features: AQt7F2o_tAyNn2nFZ_Fhmspn1PF6naWnC3_O52iyThpjfOwNV7jebNizhJNd23k
Message-ID: <CAPDyKFp9zYd+-LyTEka8UwcBeAnOWug_Kiy=K4J0GCL+DBWrhg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: Simplify with scoped for each OF
 child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Jan 2026 at 13:48, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 80561d27f2b2..ab2514c78c14 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1191,7 +1191,6 @@ static int scpsys_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct device_node *np = dev->of_node;
>         const struct scpsys_soc_data *soc;
> -       struct device_node *node;
>         struct device *parent;
>         struct scpsys *scpsys;
>         int num_domains, ret;
> @@ -1235,21 +1234,18 @@ static int scpsys_probe(struct platform_device *pdev)
>                 return ret;
>
>         ret = -ENODEV;
> -       for_each_available_child_of_node(np, node) {
> +       for_each_available_child_of_node_scoped(np, node) {
>                 struct generic_pm_domain *domain;
>
>                 domain = scpsys_add_one_domain(scpsys, node);
>                 if (IS_ERR(domain)) {
>                         ret = PTR_ERR(domain);
> -                       of_node_put(node);
>                         goto err_cleanup_domains;
>                 }
>
>                 ret = scpsys_add_subdomain(scpsys, node);
> -               if (ret) {
> -                       of_node_put(node);
> +               if (ret)
>                         goto err_cleanup_domains;
> -               }
>         }
>
>         if (ret) {
> --
> 2.51.0
>

