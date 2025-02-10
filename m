Return-Path: <linux-pm+bounces-21623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2A4A2E370
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6900E1882146
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93631607AC;
	Mon, 10 Feb 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl8cC1gz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA944C77;
	Mon, 10 Feb 2025 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164546; cv=none; b=jpvSGsDv2YQyPle2VKqR4MpcQz5meWHcGXlO6+uNIrxk2kC4TwcSHAo7pOEDWsJZjavHFAdm+ZohclrY9YDws4VJSM3Sz9M3XfPh4fGpRa1iOTRZZD6fGQuDQ2ZueRSrUaJmTh6H7z6SaDhv0keaC7jHobUnmz8RbauofLcdJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164546; c=relaxed/simple;
	bh=I49Os3Hg9shTQO+uWcYWYApq7iweL8ZgvJcrf7gXHx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L00vMQ13+pMyJW4XC+IMxbbZaXL1x/LZlg4JiGlyJ4mgcQ1DiHFrBrE2AFmFmN3TwK90niAr9ZZcTqoRZVH5AHrr6LiBzllDAfsbYLgAAwMsXQtab6pFDLGZ09T3gWk+yofTCzdjsVfyo4pIvq26/s2LFqramuygoDKx0o2NPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl8cC1gz; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0506ec9b3so172605285a.1;
        Sun, 09 Feb 2025 21:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739164544; x=1739769344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L9DLRZ0qU+2ZbcBORnSXjCBvtxIqhUuc8Y7yicFr4ec=;
        b=Zl8cC1gzjB+6GLs+gtQ4MMCYKuClPagaLoLEiIik7Hp9SJ6QuGF9EhOr0IJvhV9OKE
         VuokDrl+bsPHSK9wGp4UPO1hGhBHaxWHYFfnPeChoH19qmJLzJy5uONEwGp9Ey5V/9sb
         gPRNedoSIG5evsJqM5fevRuQdKzov/zg31vs+hA3bHT1Qe9VcSxm8BbkVt0Shb796BBW
         eXhC5DZqdLRMh/+BjbmHFsm/4ae529FWvOeI+NvOaR2lAhf2PCQGXmtBGU74RHd8yTCj
         Vh7kbW/2XkhlZ/kVg7gERpJwLat8oysLDnuemFm1QTkopqGeLU3Hjk0If0RDaGK1bqr2
         xw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739164544; x=1739769344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9DLRZ0qU+2ZbcBORnSXjCBvtxIqhUuc8Y7yicFr4ec=;
        b=ucrx42ksyXFiio6+vUYNOk/SvNTx/fPqw8I9DPRvhr/5szp5V9xX7J1NHirthL8EYT
         RfzqErCwBXVH/kle7VZWcLLYI5zTyCE9JIdofjwYnLWIwAxB0Gr7QytBGW2raWSthZMr
         3aitxAL27A3C9r3OwbncLrsluNyD96WQGfVZOdFGxrXw1hOccE4fZ3GAdCRiKXWGIjwT
         Inhl5ctGGdViM/L6eY8ybONle6jzuhiMfIIc1Z3I0ybPGxCmZQhdC1QgaPpberWY5g7F
         7tEGBv4btxEDEZjaxxah0APxaP1Jpp41q4c7XjtwAWQU1cEiEJp8/xlhCXSqaQlJcSWQ
         ySRA==
X-Forwarded-Encrypted: i=1; AJvYcCULoTHwszxueV2DZViAOQ3HTKywBRSkp47w1QQlZgHu0+M+c/YFEPhjwotoS+hOX382cSw1yjKaeAc=@vger.kernel.org, AJvYcCWF9pcYiFGDLE5FXkbNJlwLE3OEZRyd0r6SbpUJ1PqvDOgEWLg7jrDIgFwTnwVwVVka8MVBMZYO8nHh@vger.kernel.org
X-Gm-Message-State: AOJu0YxnaPByhytKdXxEbH6Mmaqd8i6kzEXJxPUu2Z44jLVPlgQdHG6S
	XJm8yDw+PJmH0xisTtJuAFqirTqv1SagsdoDU5vN8BFG7JkrGlrz
X-Gm-Gg: ASbGncvKAlcF6G/UiKMkYi/R5wtT2gaZvAQNNEqjxvNgFmpN0pJCOkYMMV2ImeCGkVB
	f/t9LRJNHIjVuLit9rdPj9mLYmWjwULF1s7WFyMdQrXNKBAx8skFztn15RMiru6qtvnddYwirrj
	nssjtcO2AbcJmxT9yhY9NFcimP7Fr67vZJOy+/l2bQ2K5Bt5tYqqGMs8GdH/7szPo9Vr4Zs9Q1T
	AGYbF7C+fvBHTdvEsYhFiNH8I0vN9/r819bH9AL8qwfvHFXwsJvIG9IRv8lkG0TgZs=
X-Google-Smtp-Source: AGHT+IGPRpX+BzWoRnQ2ghPlZC6fPh5J0DAxWKcAyO1DOBNAeBgJVLAvp3g9A/FBncSgBfpNJ8wavg==
X-Received: by 2002:a05:620a:261b:b0:7c0:5aa5:87e with SMTP id af79cd13be357-7c05aa50a21mr661627785a.44.1739164544167;
        Sun, 09 Feb 2025 21:15:44 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041e13863sm484740485a.60.2025.02.09.21.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 21:15:43 -0800 (PST)
Date: Mon, 10 Feb 2025 13:15:38 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys
 core and ctrl compatible
Message-ID: <uhvm34h2edevntc6uw3u5qiuiwfaolf6iqlhuutfkqs42ievdg@abkygsjiajcy>
References: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
 <20250209220646.1090868-7-alexander.sverdlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209220646.1090868-7-alexander.sverdlin@gmail.com>

On Sun, Feb 09, 2025 at 11:06:31PM +0100, Alexander Sverdlin wrote:
> These syscon blocks will be used for CV18xx reset driver.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4d67ff26d445..5a0b102d1bd9 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -108,6 +108,8 @@ select:
>            - rockchip,rk3576-qos
>            - rockchip,rk3588-qos
>            - rockchip,rv1126-qos
> +          - sophgo,cv1800-rtcsys-core
> +          - sophgo,cv1800-rtcsys-ctrl
>            - st,spear1340-misc
>            - stericsson,nomadik-pmu
>            - starfive,jh7100-sysmain
> @@ -207,6 +209,8 @@ properties:
>            - rockchip,rk3576-qos
>            - rockchip,rk3588-qos
>            - rockchip,rv1126-qos
> +          - sophgo,cv1800-rtcsys-core
> +          - sophgo,cv1800-rtcsys-ctrl
>            - st,spear1340-misc
>            - stericsson,nomadik-pmu
>            - starfive,jh7100-sysmain
> -- 
> 2.48.1
> 

No cv1800, use cv1800b as the base one.

Regards,
Inochi

