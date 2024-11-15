Return-Path: <linux-pm+bounces-17622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EAF9CDFD5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140541F239F5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C5D1BD9CD;
	Fri, 15 Nov 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ce/aq8wS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479461BA89C
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677070; cv=none; b=hTqlWDTWwoG6ugn/6c8lfabK+JVs2eomE06stUdyKUpFjvi8VMWQWT/NE5ECVGWfMTp56Dm2RpZ6DK+LPa5KGYpcNwVXbw6Nbz9KewCiHkbgySdgfFclLJrWMEyt00bzPUW85umAIIA08jQtnjWnfI+3Ld+R6yU3z3te53wLuas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677070; c=relaxed/simple;
	bh=qQnysFRc9BeaYS/qXGTAWVan7gIzgnJHjeDujp1K8a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlROP9KC1jBznfymKQwe3DIvOuoJKYjufqZZZakwo1lkDjW0scJobsAFgQ1NqjlHh/qkFP141FcjtT+QDkyWf7OSvd68EX8fdxn2KtMToSXEALnxjA/CCyaWfIaHaySVeQ05F4M52PDqYAK8wFllvU+geW+jEgjngsfcSV1wCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ce/aq8wS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1017651f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 05:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731677066; x=1732281866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsmYkfI9SAlOdysNsS4+loYZlaU4nZ+pAyan3DcICaY=;
        b=Ce/aq8wS9HF+9GTaqDsZWAyEeXjQkAxijnHuEUcT21rfUkEUT68BkD3ODljVa4ids+
         lLhzP7tCTvACrZiFONjQbiED5UvVF6/BMp8PC35dJrq/lL7RlmpyHIq9eazH0DiK2ggq
         1lx3xHyGqT5w5rnx2mvvaHe+SDPRknZWpEi1xsUrA819q2wkmEDNcoFZFHMDiqj5Jbrj
         ym5lN0PrJ34lckF7XHD7w8qhRi2xYG0fnqDGuOkpYDOadn71MjxeXdBHSWQxQ1muwZ3E
         QUPfxaBtKdjNDxFVOjvxtj/4zNMO606+Veh07Yc1wWtWm27tJ7t7sToCk+ZE3ky/qcln
         oopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731677066; x=1732281866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsmYkfI9SAlOdysNsS4+loYZlaU4nZ+pAyan3DcICaY=;
        b=CzFaYzXRvx0pTT7dz9KKoJAhknzqhQ8DJGuojniwDZSChaur4YqiUQmIQN3eHg+i5f
         TCz9r1jQCYLlnBoKuwQzL/d2J9AigJvTo6IVFV53n0JwNJ3WxbgreBqspRNNcCaR6SWm
         /SXNdmm98INKVooCSWuPdWiNe7NVvY5bjzq9DBcFynmvbp2SHpSxj9m5yqTMCZNaM5v8
         kzjKFwoAUm6DX1rOcnWUwuByCVqm3ZgTxK3cn9CB/z4R7SrusoWK2TtUBtvKnmOFvRCV
         vYWUVblEO+TjUovuNiZUKgVf0JzgblyuaAomxCRl5RbvP9w7sK0IG2w//EvHhpHdJGW3
         QqHw==
X-Forwarded-Encrypted: i=1; AJvYcCVk8B4czfcSNuY8qWGlZf9Ncf4YjpBtfnoV1OOVeJi2+Xb2U2kgEnDtLIwFsLwo30+YG+slXJAQ8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/p40RNiqKRtGA7+MvkG+xlepI+hfIWa5WvUDt32ZbOs0kCHf
	6yolgSKa8rFqEjR8zGoqv0u9PTgC06db8y4R1sXLkXMx4r78f1hmzClGd9OmOfs=
X-Google-Smtp-Source: AGHT+IF7XUW+P100edaXbGSm//he90Ln1D8fWPVA6iuq6Xwn8rQ18Ry0V4E1cmRJmi1XGnVwJ/UreQ==
X-Received: by 2002:a5d:598d:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-38225a2163cmr2191863f8f.34.1731677066346;
        Fri, 15 Nov 2024 05:24:26 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821d0ea3e2sm4023804f8f.109.2024.11.15.05.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:24:25 -0800 (PST)
Date: Fri, 15 Nov 2024 14:24:24 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Message-ID: <20241115-20b5e02dd05173bfdc3a7d7f@orel>
References: <20241031-cpuidle-riscv-sbi-cleanup-v2-1-aae62d383118@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-cpuidle-riscv-sbi-cleanup-v2-1-aae62d383118@gmail.com>

On Thu, Oct 31, 2024 at 01:21:17PM +0100, Javier Carrasco wrote:
> The 'np' device_node is initialized via of_cpu_device_node_get(), which
> requires explicit calls to of_node_put() when it is no longer required
> to avoid leaking the resource.
> 
> Instead of adding the missing calls to of_node_put() in all execution
> paths, use the cleanup attribute for 'np' by means of the __free()
> macro, which automatically calls of_node_put() when the variable goes
> out of scope. Given that 'np' is only used within the
> for_each_possible_cpu(), reduce its scope to release the nood after
> every iteration of the loop.
> 
> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Changes in v2:
> - Squash patches for mainline solution without intermediate steps.
> - Link to v1: https://lore.kernel.org/r/20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com
> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 14462c092039..3a78d6b7598b 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -504,12 +504,13 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
>  	int cpu, ret;
>  	struct cpuidle_driver *drv;
>  	struct cpuidle_device *dev;
> -	struct device_node *np, *pds_node;
> +	struct device_node *pds_node;
>  
>  	/* Detect OSI support based on CPU DT nodes */
>  	sbi_cpuidle_use_osi = true;
>  	for_each_possible_cpu(cpu) {
> -		np = of_cpu_device_node_get(cpu);
> +		struct device_node *np __free(device_node) =
> +			of_cpu_device_node_get(cpu);

nit: wrapping the line is unnecessary, we have 100 char width.

>  		if (np &&
>  		    of_property_present(np, "power-domains") &&
>  		    of_property_present(np, "power-domain-names")) {
> 
> ---
> base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
> change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

