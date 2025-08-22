Return-Path: <linux-pm+bounces-32888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A90B30FA7
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 08:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E4E1BA16AD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA62E5B15;
	Fri, 22 Aug 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YykTIPYK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08412D47E5
	for <linux-pm@vger.kernel.org>; Fri, 22 Aug 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845715; cv=none; b=GjOgNq7jTGagwBfS21k71ojD6Ugfnva1qj4arjKK/eae5lxrtzTTsSvb9SsQPRBI04Mc4P/1cojtLGoOEQJQ2NUhPkrk2qHG0DQrtJZKyn7otVgVsN9en4vmlhu2/bdYHR3nkndqBDoX+X4CzB0QO7RwF5WwcUc2w0UADsIWM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845715; c=relaxed/simple;
	bh=EWHdzyRT33IHKlwkAtAepytBgh5e0kzufrx+qy60ECY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh1JpTuk9FXgqnrS0PC7ckTEXnBBWF/elxKh17iEt9KHwyi/3LKkj7CaDTd5GO4BKwniwO/tCk7rZWC7kvSWX0P18cu1OI65tsGzkmoPB6vMafeJS48LIIpAZkPmV+CnicK/yb1eckj6ovsfz9KMfc1VX0+91NCdca1Dy9uvI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YykTIPYK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e434a0118so2364094b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845713; x=1756450513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjicZI/1Nbr8qAa/3VcUbv7hfNRQcnbsv7M4jPSglw0=;
        b=YykTIPYKV3nDmtOadZW4FF7zUtzPipM5DuFSrcLQZzI+iXYbd8bPHvItlkcBKVcNK2
         ZvRiSCbi8ykK1ixRIqNVVdD6v9mZGRO8uQDVG9fMoM21VUU2pHwZPO1V3X+V4prUAcI1
         EApeBiqvUT0UghRt5AtnghXMn1Ykm2iGXWADeUuf1/M4U/djhWNzfFszrtIyje+oB4hK
         2sULttvrecfJXDQwP9C37eH/tbHo57Fb6rj8cR+WhEoKj0io8juZVrVtcdDCdAUHkyRc
         /PpdjoRWuHS2z9IkZRl2EUrMawj4PDA/hzO3lFzOzQ5T2LiNz3+ryXRC6M50+PJ6jp7z
         3WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845713; x=1756450513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjicZI/1Nbr8qAa/3VcUbv7hfNRQcnbsv7M4jPSglw0=;
        b=Emo0ct3qT6vVm+HFIW1JEQV2ivnP04fmL7KVkNxldQ7N2jnKOQOhZomwjTahfgqxwD
         h4FIqqgG/RPZJgQNzemS6B94YiIkFFovf74HQeNsk9neQJzeSPSnO2McdBNxJ47aLmN2
         /tZA/8o5RGTD/PC7FlFNJohqGUUnhennvF0C3gHDixPwHJnJLViPOIUn+xTwwyyBu4qx
         Wo5IOZ8G/nmpFgMEKGklzroMB3XcATI6i1caeHqgHugOu23RWKi6xeI9qWO/xO8+zA7t
         I/RipG6eWU4mHAuanGJzSqpck4RA5eZ2Xnm7ZWI2KYmtHb3eoKO3jPJ1ADP+kK2ArJRq
         zhtA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNeaQ+xRXNWHr6jmN0dAgZgPZfrx/9yAhr69tzHxaJ7SAA2kCZQjBNBwk5j05grEVXgBO0//9Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH98n+z89qBvyteRNBNu7eNfvDQxS4TOBBcBoGi3H9k8oBMsng
	Xd94b+nV4uTsBpbo0W6SGlQm/ftFIsow4fmhhXoIaeIlZ7ZYHJ/u+g/nFG5DlQmig/c=
X-Gm-Gg: ASbGncsKp7y99//qzT/RDTUJycWxiDx7An8c1Q5ATWN+nibS+99sony8RlBFFwhtcSi
	E+6EIs/UeRcwdflnh0j58YEfhwtiM2iUeQ8W7tJODJkgoynPgCSLbwrLj1ZbJo6qC0OqZaMWOIV
	bNAIxQYZCZoJxipPYOMg36F/7bbQXwJM2bBbNxE7gA9GYXEYkN1gH6cfaD2JzNNYYOMUhmkdQoM
	JDHPuHOO6G7V+CaETn2dPC3ek41WmBXPx3F3trrnqt8SjC99i/81NBKqEh7QYkBsyqZ3uPs+eLJ
	l82azhb7BgqhbOYuEjpuBneErZATIg4ag9rAFByH9TNWlXqGT/fviV/5xQzkfMGl90/yLHbP9A5
	xBrle3IPBks4dKTPJ1HxMo33l
X-Google-Smtp-Source: AGHT+IFqTCtn1vTBHrNEXFDiI/RKgrZ8CU3yklaDBqhgIBX1zop4EhNr7+iPGnFTdss9iSbzazknMg==
X-Received: by 2002:a05:6a00:2355:b0:76b:e0f7:42f with SMTP id d2e1a72fcca58-7702faaf381mr2736161b3a.19.1755845713053;
        Thu, 21 Aug 2025 23:55:13 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d137dfbsm9903213b3a.44.2025.08.21.23.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:55:12 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:25:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Bryan Brattlof <bb@ti.com>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: ti: Allow all silicon revisions to support
 OPPs
Message-ID: <20250822065510.3vlbjwakt7ts75gk@vireshk-i7>
References: <20250818192632.2982223-1-jm@ti.com>
 <20250818192632.2982223-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818192632.2982223-3-jm@ti.com>

On 18-08-25, 14:26, Judith Mendez wrote:
> More silicon revisions are being defined for AM62x, AM62Px, and AM62ax
> SoCs. These silicon may also support currently establishes OPPs, so remove
> the revision limitation in ti-cpufreq and thus determine if an OPP applies
> with speed grade efuse parsing.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index f7be09dc63e3..90c896d02649 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -311,9 +311,9 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
>  };
>  
>  static const struct soc_device_attribute k3_cpufreq_soc[] = {
> -	{ .family = "AM62X", .revision = "SR1.0" },
> -	{ .family = "AM62AX", .revision = "SR1.0" },
> -	{ .family = "AM62PX", .revision = "SR1.0" },
> +	{ .family = "AM62X", },
> +	{ .family = "AM62AX", },
> +	{ .family = "AM62PX", },
>  	{ /* sentinel */ }
>  };

This got a minor conflict, fixed it as:

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index d6bd0d2dcf15..6ee76f5fe9c5 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -311,10 +311,10 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
 };

 static const struct soc_device_attribute k3_cpufreq_soc[] = {
-       { .family = "AM62X", .revision = "SR1.0" },
-       { .family = "AM62AX", .revision = "SR1.0" },
-       { .family = "AM62PX", .revision = "SR1.0" },
-       { .family = "AM62DX", .revision = "SR1.0" },
+       { .family = "AM62X", },
+       { .family = "AM62AX", },
+       { .family = "AM62PX", },
+       { .family = "AM62DX", },
        { /* sentinel */ }

-- 
viresh

