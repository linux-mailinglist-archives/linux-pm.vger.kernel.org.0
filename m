Return-Path: <linux-pm+bounces-4515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399186B37A
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 16:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4022F284965
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586BD15E5A5;
	Wed, 28 Feb 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X44IyKpN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DF15DBC4
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134900; cv=none; b=ghKl9L+L9x4coLiP9uxSUHOShX1XlVpIxtmc5CRclMp6L+I8FDiE77egc05/4FGkqHBCoHKbcsqEaWD68sh7II55Wjx+8hzGACLRyFsK3n6rMg/CjKVmIYep4KCbZEIqtLfyNlVirAssejj+VyQ/MpIgODCLQ9TN6/tXLSOlWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134900; c=relaxed/simple;
	bh=Y3CqL3ZtH8qv+iuGi9/RE7DcS3/Oa1WDQHkXAOzWuWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHQdzA3W9A7ijca0oPklsd2doQkxLj2NdW5Kw8RdRfsClCjeyCBDGjrWMYtghNkpKvIaZ+Ot7GkxNWuhZ0OPzX08cg7zw9osqJ3Z8WB2Bt+p+1Cau0Icr/+N8Iv6/j/CjW0jmdTWBTOui4+exerjR99Oqvmmmf2gI91TYBagnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X44IyKpN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5661b7b1f51so4364773a12.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 07:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709134896; x=1709739696; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUg2H32plNGlq0vHABZiW3cHIK6mnZ+TaVaS2PgJthI=;
        b=X44IyKpN0Jq1Oy/R7g+eEGcAj+NhfzZPl7T4kDdMZUrmnZ9B1rJb32z4g0XrLsZmZr
         ApupvEm0tYxPfqjAhjmJehr5lI/u3whZWNwdUSWJP55BuGxA6VHyUONIjphNeBAPOBmO
         GcAeOlR8yaXlLq2s5dQ6oZ7PjYR8oUyObDFl8jcwCeMDr0Nt2nO2aYTbq9c+OY8SNfAh
         NdqDs8XQMMOSUOYd30gT3hJuatcB6oYaErgizeeD7NX31dzXFWh0Gg/D5XQRzW2W9Qpb
         wBuTwJOJwrbkkDK0bBJV6DulGhoqPLIlwWkgwkK9GFbGkP0JItjRhVz8zfF6U5PHPaJU
         7rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134896; x=1709739696;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUg2H32plNGlq0vHABZiW3cHIK6mnZ+TaVaS2PgJthI=;
        b=UiAX2LGgvGBYJg2ErzVsKKn+3lCT/sGFs/AU82S4r3bOT+FbBW719u3DuDQ+oiJZp4
         QzepMw0+L20oxleDlrpHKrGJ0N/StR0YTFleDRnSdKZ6g9xZG7SA2pCwAnSWNcbdK8bL
         5HGz9gr+6FC3ZI3ql+UsQo55aqj/N6aukafdNHqV0CDV5obz/4aMuNZLReLFCoV7eBSa
         WRlnhP6ceGa9ghVcJtfPowK3ia+yNv87b27hRBdSH4EGUrUMiFglFrEzzdpxaRZerS9G
         tploTMKpzCJhzOQsZ6Agwte9x2K7Vl+66r2ZTKk7i9Gelgptsu8eFCZmaIqeFOgiHKbp
         auOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNNgAd5N5DkIgzYDxvn7p8CbuC1SwUwQCSlewjQctc38Z9pDIBlo2fZ68XIgyOoZQKlYWz6ZoiAg0A0720YgcBTbiS7oSHCDg=
X-Gm-Message-State: AOJu0Ywp960vn5YPFdFINlS+4bPlEfJj1XQuFdDUHZMpjiyTO3QIvwiN
	S2XB9DL9H1gWGh4jrBqFgqcaZDDZjEkjerPpvwV4t9TKj18Cb9y5pxe/VXV49eVq7p1rfL+rNq+
	rGu/nPblhjXYrmE2ZRd8txavZEsxY6Gbjx5mB5Q==
X-Google-Smtp-Source: AGHT+IEdoGphs4qV9yXffW2xSbebK1gxJ1XCt7GmQTsCwVCc1R6Uk48iHbYCDQmdSAdkDcUcqwe5iX6aNn0qqtrYjDA=
X-Received: by 2002:a05:6402:556:b0:565:cbba:b79a with SMTP id
 i22-20020a056402055600b00565cbbab79amr7175525edx.13.1709134895902; Wed, 28
 Feb 2024 07:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-2-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 16:40:59 +0100
Message-ID: <CAPDyKFoBmZ1CW1OrT5WW64jKHnRMw2P7DCc8bRxR18PJhmUMig@mail.gmail.com>
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

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

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

