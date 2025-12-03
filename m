Return-Path: <linux-pm+bounces-39150-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC0C9DD1C
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 06:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99AC3A8546
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050A728504D;
	Wed,  3 Dec 2025 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNgufZtd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71348280018
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740921; cv=none; b=FKTlbqlQNpzq4yQus8vyoS8tXMWL10soRXVYCZFJfbHY5zv6/PiGfs6q36HJDX2yg9xHzumxZklXeM2O13MRrmEwdvk3xQqQ4ecfGsyH9vb3ZAUjCj+GVnYCTHq9C13pC7zM+jzJ9Tn5e2zUGMHPAiVsdSx7A13nhpjdekMqRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740921; c=relaxed/simple;
	bh=QOXLxWx1f91A2ezRoFQpXoqA4u3WO0ay954toGFKrYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdccaZ5alDow/7UrQlFq/Id8QcxmCuK3X5xK0NdcUGaOV2YIS14rj6UbP7TtfqxkIc6LcHTLMU72Olyk3viZEaTUizWhyOdbt6qf4/XWW8JL9nfvm3GZLWqHRhz+giGMqgLpspt4yFZcykHiGTPwP7sVC3OYU2qDzYGZEs/GXYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bNgufZtd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2958db8ae4fso64139165ad.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764740920; x=1765345720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Um7WZrOc52htQuQHI+IKOO/kj8j/l/2iMMPC4W41Dw=;
        b=bNgufZtdUuxTMmIPn1Mkn9xIdyQh+kUfrSk5JdtV5LJcb8fuDLWBubf4oY1aKJ5sWL
         TBJX2rmo3ToBqOE9hZnwIuqw6PiUmZSSjyP6hg75ksG1pbjEIgKr9EoXoBuoNu9x1kn8
         9Tnm8sJjQbbLD9cg8XgaSnCquRkzh4KzIzGhnYRAKtcattVUjK7lws6PiSveDrcO0IJC
         Hqdd6z7kShJSkLvnP4J3J49dvMzDFf/S9LiHnsN5bdbLRHrUSY3xViKEtc4DhACCGDA0
         9NGqtbt+uwnnxUqewMKT2S9R5svSHx6qLLnWtC2p1s4Z1yeuXN6qIJtw+utwDHCyHWnv
         BdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764740920; x=1765345720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Um7WZrOc52htQuQHI+IKOO/kj8j/l/2iMMPC4W41Dw=;
        b=n674xSEneGWwF60NmYt8rVFR4G0KijJKSBL4sU1c7NwyNX0fQu1m/uxWAEvUKcKRuP
         5n9ZgHvmp0iqxe5KPwi0JGgiNBANKBzsBQh7ZOms4hB/n0bt9fuaslTIZpPveoKZf3Rc
         LYjl7pfQfvly7PLRivGGaj333TRV9kZBmEH9lxq+rH0Dm8r6Gl7QWxtBM9YB21qGEkTP
         ohQLVxtIiqQk3pZeHXmuhbE5itLByVprXWLDmNMkoVVXlVsMyPkgd19kE6XGXXzbIFX9
         HCIcTiTNLCWw3dYco05WXyv7PGcv8yJacWfLE0XRdPGyVvaJj+VsyrlFCIm9IJXJ52IF
         z2qA==
X-Forwarded-Encrypted: i=1; AJvYcCVppS1k+bvjMns2V5e7psD6bNAxMqlkB0Lp91hpBblWlBe+zk3uLikVqC6K9DMRAAEVPLiyG7278Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBxlaFJuNCw57Rd0YQ6S2TkKiRaRm5zBA+TihmMcatgvwhDcb
	OLLIvTQahP+tMnLgcZig0TmeEnDT2uM2I0roq6nfvFcaHOCpkYbikHSBFRPwbXKNGRA=
X-Gm-Gg: ASbGncsmFCj6VuuZOz5PxygWJGQaSEq81nl37fgMW6thonGkQUeJlO+K0U7TdkcbI7x
	1peQzvwNK4ftYm2Vt++JXgxxykyfxo25DWpmYtmX1y0g5DNcGAFd3H7Hr0XMzjxSu8AfRG3beG3
	+t25eJDEN9zoxnUD6LjWFtpp8YFBzsWbgHp7gCMMfqeRpLDvIrZX6dCMT4AvbKccPoSqJxWCoHb
	eL752RKTrN7udXVQYHUqscmL2GMnaKGm+7kZCnHidABsUaNgI4+Uve0/MJlSJYM7kCQreqBxb5d
	NPZbYIZXlKtw7/EaCeYGzYCBFF7X44XN586X7IvwdjWWgXDEblJs/bAoqzQTEy3XK5Y9Wiqp1kW
	D8lv4qbIP09Rv3cUTs9DzEd61CMEij70RbXVcrLUoFL1Bm3/Aib23XWAmdN7TgqXizv7aqzPyfk
	0I2YPiqnE9gyM=
X-Google-Smtp-Source: AGHT+IE/1qLWIAoXXmBzs2FAgqz/NW7C8OfqRH9EIyc2L+bzyq1dQjuAmwkNxtLdw6O1nx1Nmewmjw==
X-Received: by 2002:a17:902:ecd2:b0:297:dd7f:f1e0 with SMTP id d9443c01a7336-29d683b2842mr12705915ad.43.1764740919428;
        Tue, 02 Dec 2025 21:48:39 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb27691sm174413795ad.64.2025.12.02.21.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 21:48:38 -0800 (PST)
Date: Wed, 3 Dec 2025 11:18:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 11/46] rust: cpufreq: add __rust_helper to helpers
Message-ID: <fb4pcnw7a252oqrldwmga5m4bijtenkoo3smktns5jstwocdnj@2qvb6ceh5gu5>
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
 <20251202-define-rust-helper-v1-11-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-define-rust-helper-v1-11-a2e13cbc17a6@google.com>

On 02-12-25, 19:37, Alice Ryhl wrote:
> This is needed to inline these helpers into Rust code.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  rust/helpers/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
> index 7c1343c4d65eaff6f62255b6c9a9a67f89af1541..0e16aeef2b5a696bf8974f37d9e5e3c24d999f40 100644
> --- a/rust/helpers/cpufreq.c
> +++ b/rust/helpers/cpufreq.c
> @@ -3,7 +3,8 @@
>  #include <linux/cpufreq.h>
>  
>  #ifdef CONFIG_CPU_FREQ
> -void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
> +__rust_helper void
> +rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
>  {
>  	cpufreq_register_em_with_opp(policy);
>  }

Applied. Thanks.

-- 
viresh

