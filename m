Return-Path: <linux-pm+bounces-19107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C949EE015
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F6418880E0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F020ADF1;
	Thu, 12 Dec 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH4zeCUu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688620ADE0
	for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987762; cv=none; b=JZE+oS9eMQp6oxftIw0EHKCU0uMc8SaVDw15Sqp0pblNBM/mFDy5KJlR6LFZlFpLv9b6pK0FXDb7bBMPpAjj41Q2WP2d0QkxqETVPUnR5FNQBzuzQAU6d/d8bXvX66ke/EZCFd5tGJhT93cSzbnVfPsvh+OGmJLjhYDvzHj4KuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987762; c=relaxed/simple;
	bh=/GRsmos36cXMIlpR9JSwG1RkBUOM946AIKMMDjyXANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1kuVGWGC0a0yJOb+d53xID7+QU6DVRIG0paQrurgDxc7qymSlfxPfqkD4gTMDzEsLF6Y7v6qNKzlPOK1XxGL5NNG7VfX5Lmns8gnq47UqKQwFg7ZWJda3z5n4tAySvT6DCODBseTGA1zf8iodjyi2M7Gn25b2pQNgh5cB3MAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MH4zeCUu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so174862a91.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 23:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733987760; x=1734592560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3L98iE6iEgWKW2dRYjbdeCK1aiyyhjOykPkAdKGjuiA=;
        b=MH4zeCUu+Ca5VInJmSz6Xa7lXCkjv0TH9VZokTjrQW5AAp9gEbVCyQnW5KxR++4bRT
         jJFgMpwhXWSHSTX3bqdCf3KQBKKGnUsAeDVygS9h8OkBK0RSKOoMx4CHO9RLp/Nr9WtG
         2N6zRByEjp6ShHIpPuuKjrrJ4ZiE+E9bS5vyse+JpzmUyb43GOhBVFmNbFp9w+4LIB/3
         AtVRn7LtIRlwqNbdHxHhguj3hdUlcLkH2A/FlvX4gG5xfD3xH8g+4+B/4HDvnuKmYPVG
         AGevP3CMCxCt1KS6qjjjWJtNqfpAc6pQTMwFlwLY90H3WAFeXeJbO3J7Kb4Feo4mHtGS
         60YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987760; x=1734592560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L98iE6iEgWKW2dRYjbdeCK1aiyyhjOykPkAdKGjuiA=;
        b=Bvhy1AycM5tZLNl5US4smxbOXwE0U8B7CoySTfFXoaL9KMfVEZQIDoRwTtFfaHRCC5
         1OA0dqwD8ff/iL1Y5hKVknyS3mvxWW7lDB1rtqL/jldlVByqJEcYDDcATAe9Bo5xRebi
         rUSh5LA7nFVBwSPyJ6nwqUKfjanDDt0lKo9nDnben97fIRB9/uIihzsbJAZp/TNTHCPx
         0xBk4LrH4Gt6N2E+i5YDPOCq1JkZAoGNBB27YRO1K3AcjU3IciTjOYoxXc5qIKjizBZq
         DfLmgGZctBpuVKxeMY2K0kdpNlzK1ctwFGk8sbeRZRjv0a2yZfWqKfPKAOZfrzHA7sqH
         lYXA==
X-Forwarded-Encrypted: i=1; AJvYcCXda7rjrU5JBtO8jsWq1/DhWPEntEFrPX0SxnWmt1nX7K4qeVOOh0ko39byvau1jkpOerr6Hfpsfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt6c1i9KwIml1Yd7M5g8KfrQrfgIzyihaD7jS7GIGcIsj8QA05
	Lu80er2z+B4pfTdyW05wFnFdUwnr/NgyeETG0lYGtiAbVZQEDgTAqqUNqyRWdw4=
X-Gm-Gg: ASbGncuIAeFIHQ/YB/Ucy/R/gWeg1uftXn2KEot6o99kegt2nDVpaph6NOtz33AINCC
	qzCU1js2T7gJGKJwWF+dJuJarGdv/zrDiWGsmrknJpu48FpvmkuL3e8RZvSEUuFnvcZt5lIfQei
	SFS2ayKnxtlwLJN8Xc7nzMvSfnKju2NAoIGTEyMBp6dNOztfQFEzHDNiSIEjOHFHOhZI3Y1DLfT
	DRnhkfhj/j8YZ8CLTDHvNckegPm41tLX1J4JXdxV84lNI5dwxa5X7ZHCMA=
X-Google-Smtp-Source: AGHT+IEUOkvi+y7f3A5lyEr4YtS9iRRSj52GzIA+ZuP4cB/sOWfFEYg7en1hPsQli/qSrMewFNomsQ==
X-Received: by 2002:a17:90b:38cc:b0:2ee:7a4f:9265 with SMTP id 98e67ed59e1d1-2f127fc7463mr10057310a91.15.1733987760404;
        Wed, 11 Dec 2024 23:16:00 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm563653a91.39.2024.12.11.23.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:15:59 -0800 (PST)
Date: Thu, 12 Dec 2024 12:45:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
Message-ID: <20241212071557.76viy5b7ottf7jck@vireshk-i7>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206211145.2823-1-ansuelsmth@gmail.com>

On 06-12-24, 22:11, Christian Marangi wrote:
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMC commands
> to ATF.
> 
> A virtual clock is exposed. This virtual clock is a get-only clock and
> is used to expose the current global CPU clock. The frequency info comes
> by the output of the SMC command that reports the clock in MHz.
> 
> The SMC sets the CPU clock by providing an index, this is modelled as
> performance states in a power domain.
> 
> CPUs can't be individually scaled as the CPU frequency is shared across
> all CPUs and is global.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes v7:
> - Add more info to the description for usage of clock and
>   performance-domain
> - Drop redundant nodes from example

Applied. Thanks.

-- 
viresh

