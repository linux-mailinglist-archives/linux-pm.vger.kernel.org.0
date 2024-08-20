Return-Path: <linux-pm+bounces-12551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250D95825E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4831F24823
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE47418C91D;
	Tue, 20 Aug 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0rbr2Ua"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54818C004
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146476; cv=none; b=jmzTVSKFmVVhIrF3J6xxjVUoiz0f4qvn4PPsHS7pLRaFAyXkSqsGW0ZBXuPufC4lTlZwCAxBoiuug5Qvu7uZ/sGBg182G3dqnbmgJ1W92IEG9zfhZvIc5sJHuHqSUV444Jzmnf2hk+mUax0nzpofpZQ/srwKdr7MLW2HjsW0beg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146476; c=relaxed/simple;
	bh=bAq3Hg8xmnP2KH0grH4j9Qm33qBDHEt9hOktxqu+u9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQZvPsmHhVrVA0BSU0pH9WTUjrdZ0ddo/x4g+xJuj0pGmjuUcSjt9qPeKpyl0LIfOQYWlYjGP+lwIA/m0Uxg2bpHL/msZKAvmS3daSwMNtG5ima4VStNRJVBh73uCrmHiEpf8rfEcP8sbOtKZpvTNaMpCCJWmJKqyK8miXfxyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W0rbr2Ua; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1651f48c31so650909276.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146474; x=1724751274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDPgJBCq1kxO9wbeFyugQyBH98hbT0XIZ0Mk7Mav/Tk=;
        b=W0rbr2Ua3PycwEbcN2I1N8QbNIiX3SsK+8qf1oWGv7RA/CWQHc/j9qD5+1IzLxBxe6
         SG3UOvV/olWM4T6V9GjqgIOb/XyBi4VV9KCw1iNxf9spPXa28lDC8ldJhva1zWWqTWuz
         uUK1mmtidoecIvBtgflYZIUE680gGdRaTM/5G9l3ah3Tk9du73o803uNRJQMoR1E4kV4
         +wab/0XRXp0MIgMPniC/TWPudtZjo1YYK5WdNuGAg0RAktRQ6CSy2ccAsnR0JU/+wpam
         hrSjmiue/+jGrHe7UYfbC3XHbITsvAfFtNvi08yg4MynCmFYKt1VvxKvgsL22NOWrzvK
         GZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146474; x=1724751274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDPgJBCq1kxO9wbeFyugQyBH98hbT0XIZ0Mk7Mav/Tk=;
        b=jIW/aDvG14a7BaI1XLFQ0rtWQcMYarkc97iw8+StsSmCz7k6t2EiEoh+i8TmKz6dc/
         VqAzeCYgRp5LUNZ5EZyiyTlD2ZNXosMOwodDaRpGbQKm0M3tVMmAcxW80yUvrkXRHipE
         jj+czvM+NTyzohek3cLkn+j1tPftcqNa3BiMLpRmF1qBdTQsPJx3f/rlft05y/2Wwj4o
         VU5y6aBk3BkEY0kD+icHBqNpY0laF2y/Kldw/cnDxvSXlBqW5BwS66/cXmoIOicCYrFL
         QtHo95xPpiUSQSaR4olV7WicbP4lfBhIaU24ibhKfifgPOx+VM3QqAmroZYS/rGUNYM8
         ug3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRDEvRjlgaePUOJB8LO0vZVka5VKahD7lZWFonKKaz3b+ebVhrEVIMBU0yJrLISBaEDV83NCecnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJDfXeVfOY3LVZ4aFYe8E0v4mWoEME21X8N315N6EOnBYJGMZ2
	We4T2R7Vctb7d9+F6jqVffhI6FQo2w4ngn/Imav0cSAmWeJmHQGjzYQx7vsTpQlKx2tPzLLwKub
	KOpmivZkf+VGAV/4Dvu/XSep9mPhlnPoyUGlZYA==
X-Google-Smtp-Source: AGHT+IG+n9FSFEOe1JiKKz3Rk6QBY5s4AnGwrZNnNZD361hchMNJL5Kyar8IXmLLJIBCe/aZ1QdLIcBPSSESXxqy+bQ=
X-Received: by 2002:a25:8204:0:b0:e11:7ecc:3b0b with SMTP id
 3f1490d57ef6-e1180f45d93mr13140044276.14.1724146474273; Tue, 20 Aug 2024
 02:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Aug 2024 11:33:58 +0200
Message-ID: <CAPDyKFpVmELdcK8WXe-3OgenF9nHMM1Om4JW=UkSBKycfkQhsQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpuidle: psci: Simplify with scoped for each OF child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 17:09, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ea28b73ef3fb..146f97068022 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -142,7 +142,6 @@ static const struct of_device_id psci_of_match[] = {
>  static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
> -       struct device_node *node;
>         bool use_osi = psci_has_osi_support();
>         int ret = 0, pd_count = 0;
>
> @@ -153,15 +152,13 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>          * Parse child nodes for the "#power-domain-cells" property and
>          * initialize a genpd/genpd-of-provider pair when it's found.
>          */
> -       for_each_child_of_node(np, node) {
> +       for_each_child_of_node_scoped(np, node) {
>                 if (!of_property_present(node, "#power-domain-cells"))
>                         continue;
>
>                 ret = psci_pd_init(node, use_osi);
> -               if (ret) {
> -                       of_node_put(node);
> +               if (ret)
>                         goto exit;
> -               }
>
>                 pd_count++;
>         }
> --
> 2.43.0
>

