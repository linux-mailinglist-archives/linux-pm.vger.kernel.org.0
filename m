Return-Path: <linux-pm+bounces-15436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C7997F65
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99C71C23E04
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442D1E884B;
	Thu, 10 Oct 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZaX7XK9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC501E8848
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545176; cv=none; b=TgpE0ttIsSG9HLUdTpVxR+lk3jJ4GY1eW61Bk5pj5O6Xc5Up0vbOhP7GaEyaQ+cjC2hasdnF0nqk58q1z+CspFvYJcsPWnfh00D61j1BY+jLcevvpfnbnXNq8yjvSd6Dyv9esthEdEHz6NWofLoLtLnYBXQeogqqsAu0GrkuWB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545176; c=relaxed/simple;
	bh=Ybyjz5wLM3aHT8F6ATfkr4+lUHihxrdhi5y3HEe8Rf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcIISZ0AGNI64UrJzBr/2XZwbcxPkw6jvPE//Ju3j479toJY1Au/rwMkQ+cEKzyzTwJUQeDwzatqgTnVofVbQ4rKoBgt3VE+c/hopcKvX82QV4WivdpCOOAVFOb5NKrgDdTBdRhwPfixeMELs98upxxPWiVeabffF1uEl82fvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZaX7XK9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso514524a12.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728545175; x=1729149975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xn2CpKlZpFw1JRm5bw+GBM6CWvyGFQrA2wcnRi6mHVc=;
        b=VZaX7XK9hEMAEuhwMwp+J++wgdGB2ZjqYPjUs9+h4SZ9IVng5KX0dlnhwcFzUoF0qk
         IUR6LE2J854ELhUS7bdCPbinPmSfUQFbJxTK34UInsceiBKt1jGUBeWBhcj50AhrB+bz
         wnOZSWXwF0+QfHjMwPYqtnpcFJBvedDRU+FbIXCrwS1A7KGWShLtarNEzUtbmIMvmPfA
         NA7Cs89Nu3CZrWSLrNt+spH1VNCp9RKIMwIeiwtz/h9PZZF6Li/3eiL/oi+/VlDkDlOI
         PiG5S22U344jSz114JaZuN2CAJwBWy5PhiwjL++VG1fQTDcB3ZU4PUwMYi71BEa78dtY
         pZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545175; x=1729149975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn2CpKlZpFw1JRm5bw+GBM6CWvyGFQrA2wcnRi6mHVc=;
        b=pU5oH7VhYjewbvG4xRCphLm3uV2jlrwgnY833S/ufbg+ckUU3MwZiirFsT35EEmqPN
         FWM344IlffVjDsyibfzIhQ/XW1e95aUq5WJvLM/Hno0k+r/BbFNj1Oa0l5u5dqOPPxhQ
         Wu+0BSmQFNK1u9rrRPhiuJeVcmmMbHxvaYipsu4ESETJvaOR8IOQ6z50NrW66gNYIZi6
         sjUnxwyesRfnueZO+jVFh+t7u8ZCFxgEdM5zI4fScdUKgF5j3CagGENc0lqWgixGQ+aS
         fdrFoXBuQi8ex2FzqWtIVoyX4U4lUffj+N4Dom2+3uCjnOeFnR11N0GCXUMwk2oNOfOT
         taow==
X-Forwarded-Encrypted: i=1; AJvYcCWJMfHlrsTvy3Iaw9PQYt/8yHNR6Ud0+YIFn31gJpZ9Rlx9J1XcNGdh0iAQJ5DxSxgZtwjCPOGhDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+XN+JHIlBLhvfYrFp1BvIp7g0XJjxwlTTzYr7Z8xYDSmV8vr
	RjRH9Hc3auv+WX61Z+8Llpwd1dmHrOfa+VnV/W6B6KP16/W2ppB5vMNuzcHARZc=
X-Google-Smtp-Source: AGHT+IFiZBkiSEtr5BZMJYQw0D6nBM1UrBhV66yt3kBIZCsjkzkw2a8Xy80d3TuxRDf5FdXMq5NK9A==
X-Received: by 2002:a17:90b:198e:b0:2e2:af57:37eb with SMTP id 98e67ed59e1d1-2e2af5748ffmr4687096a91.41.1728545174723;
        Thu, 10 Oct 2024 00:26:14 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2b9483328sm2086035a91.44.2024.10.10.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:26:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:56:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241010072611.5zpp2tmf6jidko5d@vireshk-i7>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>

On 30-09-24, 15:02, Dhruva Gole wrote:
> With the Silicon revision being taken directly from socinfo, there's no
> longer any need for reading any SOC register for revision from this driver.
> Hence, we do not require any rev_offset for AM62 family of devices.
> 
> Also, maintain the backward compatibility with old devicetree, and hence
> add condition to handle the case where we have the zero offset such that we
> don't end up reading the wrong register offset in new AM625 DTs whenever we fix
> them up.
> 
> These patches have been in discussion as part of another series, which is now
> being split up as per discussions with Nishanth. Ref. the following link for
> more context on the same:
> https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/
> 
> **DEPENDS ON:**
> "mfd: syscon: Use regmap max_register_is_0 as needed"
> https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/

Applied. Thanks.

-- 
viresh

