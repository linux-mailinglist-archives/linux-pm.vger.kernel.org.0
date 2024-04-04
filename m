Return-Path: <linux-pm+bounces-5919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE20C8985B7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0011F23825
	for <lists+linux-pm@lfdr.de>; Thu,  4 Apr 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67680BF7;
	Thu,  4 Apr 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLuw9HF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431A745C3
	for <linux-pm@vger.kernel.org>; Thu,  4 Apr 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228823; cv=none; b=P+0EcI/0pqGKhkM3P8EUaYHDtkfloZgsTebgf/N/POEOgdV+45krx/xM/Ho4LkctBWOj37t+DUtlL1pc/g1svL1if/JbmggMrVJ9uaiuEYs2kqnpy2MweI99bH4wpe5LQWiyDtgb5me/tOwS5Kiptro5QneK3S+yvtdd6YXlexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228823; c=relaxed/simple;
	bh=smjTSYhH7gbTnsCwUt060q54oqGuPVkPiEP1WSeLBRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxSexWOLODWarkyNkwdg4NCOmC1bTddF6cBm0937gDLIIAmB7EQYxWHzPpOOm0bCejCu4Na1WLphGiCRU2lhQg0sl0YX1RjvB7FfasHf0KZE+CU5hleSZnjSpvgAJX0gkNgogzpTKq4XrkeY8Zx0lJcZ8DizGtZ3F6y31+JYtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLuw9HF3; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso944189276.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2024 04:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712228821; x=1712833621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CGsX++L9+ujhMyLx1u2hIAzny98z/SAWY5CGSjDOSb0=;
        b=jLuw9HF3FArb+Q0y8ntGeFossdmnGvjqc/P4ly5RQPY5VUorbufzOceOYzCCuaTOxx
         PkwelVx59Ghvdy6MQgp2BOn+6OBaVY0baFlR3tawLK1TTU1H4+v0izqoGroqJQSRuh1F
         1TKG4GPqTzLk3j2yWJQ346WvX7b0Y1v5JX/tfGgUc5hFaZRSrIY7CSKUTyDJfsUh4hCg
         PMp/E5U1I5RBV423Orf80ruq1X1SVCRAWn71NGMZ8wlmKu2PhKtp8Q0BelSrCiXPtj2a
         PxVxLKnPKk8RW807MCeOhzxC+Qa5cXxgXaTo3l8eqr9yG78sd+/SZHngJDqs4LZ4Srtz
         9eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712228821; x=1712833621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGsX++L9+ujhMyLx1u2hIAzny98z/SAWY5CGSjDOSb0=;
        b=Xb9/8XnjOM4ZloKH3SV3q68IDZlaZFoXZiHqWCO1YciXmoILP6c0c3O4Bs4GzLLvFP
         AIzni4CSWsWpLASVBx4MylMiWqBgu0HyQl0E7xrL76M8hNX1rpHEvNdhScox3ZFKosfI
         ff5GStWa43G7vh/0/mebCmHA7UMkd8c5e47b7JPbS7pdiwECYRmZmStnl4sK/FIeOkt6
         rfoR2lGV/a8rQztdFtf+9xm7qeAc9c4Ykdx5emXxPXLkoBf019i2jUeO41TKRUGIRDfL
         /Rl7t0VXgy247fvMVcJjNMqnUfVH9mVx+XaEfQACg6OOn49K+OL7f56fzOp3oaSLhp70
         iSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYIudlQxKLpWhcHOpmozvWyMukJyMKNCP156ESlYk+euOJqIE0m8kTQOqgvPB1peXIU4BPJ4ovIv9H0W4IofjHhe8GL+8sEKI=
X-Gm-Message-State: AOJu0YwH8ifMFydV7PJlXRLh+NXSVe4ZO6IG6BwKnmtDabUhmUm3RVrL
	dIm4aJxbP2LZ4xl5MDl41hG4ZAfl6upwE0bXL+X3rmOtFlrfpVumCCBpnxk61FD6JQl6vN7RvD+
	FOZo7RQPsxrv6PQX+eIket4Kl3ohft6QL58CKxQ==
X-Google-Smtp-Source: AGHT+IFw+8brBd6LN/Kukzcljb9jj6pC2FMNpnmCLIgwBkv5VrTUBCR8g0DssTUbjdDazcsVvJj+fUy2FXpfWXLjx+Q=
X-Received: by 2002:a05:6902:c0e:b0:dc7:4860:1214 with SMTP id
 fs14-20020a0569020c0e00b00dc748601214mr2686805ybb.4.1712228820938; Thu, 04
 Apr 2024 04:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Apr 2024 13:06:25 +0200
Message-ID: <CAPDyKFpG3wRWicOnp5hshBNN7FF0mEqiooju3UR-21HUf30BPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle: psci: Update init level to core_initcall()
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_lsrao@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 14:57, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> Clients like regulators, interconnects and clocks depend on rpmh-rsc to
> vote on resources and rpmh-rsc depends on psci power-domains to complete
> probe. All of them are in core_initcall().
>
> Change psci domain init level to core_initcall() to avoid probe defer from
> all of the above.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Queued up for next via my linux-pm.git (pmdomain), thanks!

Kind regards
Uffe


> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index b88af1262f1a..3e5b1150f75b 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -200,4 +200,4 @@ static int __init psci_idle_init_domains(void)
>  {
>         return platform_driver_register(&psci_cpuidle_domain_driver);
>  }
> -subsys_initcall(psci_idle_init_domains);
> +core_initcall(psci_idle_init_domains);
>
> --
> 2.22.0
>

