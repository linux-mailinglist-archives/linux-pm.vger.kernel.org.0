Return-Path: <linux-pm+bounces-33790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5CAB43177
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 07:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CD7ABAB2
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 05:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782E215F48;
	Thu,  4 Sep 2025 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zg6zZdZj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31D1DED53
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962243; cv=none; b=q36pKci/vcXg1EV4XCne1v4A80VD/xfLgAK6Op2W1xie7k7H6Zn7rWYT6DSBs6qESqikay06eAmxC5jJnq76uLFUV2DSuPNZiRa32vK4MFb3+AgRIjjxI+z9T2jnrDECqh4OkM3v6xY0TThA7JOIeHIY9NuoSWgCl/IfBsjhR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962243; c=relaxed/simple;
	bh=VN0eu04X+Blerv8n91iWc1v8Qm+cbzBBmKAIxRg+pTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3yG1spcPPw9951jjibocv35oGO7fvALML7dHiBaDFQTIxEp5vWlxE32DPau+QCIoIIou2PdR3YkvMnk3NsUP9Pm1mQy/4vPx303tS+arBLTr6aQeDFRzfQZNORzsn/CeNcBaAWyzPc4D9Drf09u+qHI1o9mFQfhGhcr+WNvGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zg6zZdZj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772481b2329so796413b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756962241; x=1757567041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUDDmkRugVO/LR/xckcLSLxhh+WNZoJcwv9OrEHQ+Q0=;
        b=zg6zZdZjAMwDbXBOanb68YdKX9lsOQCVoGk2abp698AT7KFDZKQzONPHjJoYFqvOFc
         ial8mIUePKWdcRyK77IlSvgcEGdIgjTF3cIVMw5J1qqp1IMgseto7BNwsXT/78VsECsL
         8yD6T56kxi0eRhw5s3guONTwS0LpUynSNrDUndp6Q1CCTJ6LXjijPxzKZsnlCeO7HFlX
         b32C1R7x6J63nLw11uJvFuOj3+3zeh8AgpAxotFNA/OiVM+YeuwDotSmvGf+ap+wiwRp
         ZGQb7nBaOyD825skL28vn+QUm+4VaBTkdPCTgePlZ20y0PaYRmQDywJJNyHyi/7WNtzC
         5oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756962241; x=1757567041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUDDmkRugVO/LR/xckcLSLxhh+WNZoJcwv9OrEHQ+Q0=;
        b=TGr60rcOV3MQa1gcD56eHD9e0FjOmgsKaFN7kMZmbscMK/rhmTX4XGVFwdcFzQHfjK
         rsB/YDpnO3gLLFrsoPYQUEYpjuG9ZH9FhRqasRg3LUi1ygLGf4xbIvNC2A6+GIhm/o/n
         7jcDgUBc1AiQmwsEmlxG3xkUEED2am045NekHrtHZ+RkjmqwwJ9lmA4+zoiaD2hkrX4J
         93qDoHunmZTBXKdDEFU1QNak1LYVoTRYyQYlXlYwzHDXTmyemKmhCD/YXYl9dOivjNjp
         vnV7L95rE700VEoTsyOF93rd8pXn8xG0AXOGen0IT/9Wvd3H9pFrERQIEwweteVmPM7U
         MIBg==
X-Forwarded-Encrypted: i=1; AJvYcCWK4MGLA3BSuTz1xKylTAxsSjwCW8oZDJd0/GOkwV9YvJDGcJjhEyFDDmd/1FYupz5spH99COiL/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB50pZrwScVD7c8/7LSDKQHvoJbL1qAXQyoagf4TROim8pbF4m
	Mh2nBeBxpj5MRBY9t8tHbwwJOvi/nbQFocKMkCarEtDj1a7mwRTI0SAnypGpw2Y03fY=
X-Gm-Gg: ASbGnctAi2ONyX6L7X1J5ed8Kun3IS2OkeLQIh1Noyguq0a3aQ+ukZV5TOMwxVYezZM
	CQR6hIBaj3gJ2PI1xt+1iIOauJvNVYiz36YP2NLFl6JdT35ZidaWkzVujnqSCd1g+u5EuF1ie34
	p/zQTQkRH1yikSChNcn4VHcQjHAuuARSviW4DMKppB8IPzwWA38AfJpjyL5UVc584HDj2cgGx4I
	RjbzjeeLkUhWYN+AQ8L+k/JHFZGihcq2DiBVqeaimOe0qd7BX2E8OqGmW6tVnb5mZrgkNK9CwS3
	+WIHYYlTWx2qJr1eR9pkpSajsvTrCVAvWJ9G+b0WvTR6Am3B7wP/hWsckWYWXCxtDJ7cGNlFR6g
	jyQDSHzUlMBmghVyFNcOBzsa/NbSuEJq9MGo=
X-Google-Smtp-Source: AGHT+IHag2U9U1XvmmR0U1C9VDKS1Bo6WCQfCQMDOrQGMz82TQz7MiXq1aOJIWslun3n5e6SZdxUJw==
X-Received: by 2002:a05:6a00:2e2a:b0:772:65b2:99b6 with SMTP id d2e1a72fcca58-77265b29bb8mr15449714b3a.25.1756962241631;
        Wed, 03 Sep 2025 22:04:01 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm16918405b3a.62.2025.09.03.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 22:04:00 -0700 (PDT)
Date: Thu, 4 Sep 2025 10:33:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <luceoscutum@gmail.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v3 0/2] cpufreq: tegra186: Fix initialization and scaling
Message-ID: <20250904050358.kj7gxypu5mmov4f7@vireshk-i7>
References: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828-tegra186-cpufreq-fixes-v3-0-23a7341db254@gmail.com>

On 28-08-25, 21:48, Aaron Kling via B4 Relay wrote:
> This series fixes an issue with shared policy per cluster not scaling
> all cpus and with some cores being initialized by the subsystem.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v3:
> - Use more clearly named variables in patch 2
> - In patch 2, fail probe if no cpu rates reported by bpmp
> - Link to v2: https://lore.kernel.org/r/20250828-tegra186-cpufreq-fixes-v2-0-fcffe4de1e15@gmail.com

Would be nice to get an Ack from one of the Tegra maintainers before I
apply this.

-- 
viresh

