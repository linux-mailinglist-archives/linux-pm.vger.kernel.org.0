Return-Path: <linux-pm+bounces-24129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444AA64084
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 07:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C881890DE6
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF3215047;
	Mon, 17 Mar 2025 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbG8FZrL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFB157A48
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191275; cv=none; b=OprMEYWbUQr3bjvF9v/Y2rWkaMnSWWj+R3ZtGNGnHWM7pdnBUKXo9Q0ceb34xyZu5vKJMLDHx1BQRDumSDHDZiqXGypiWY9tPl+JSC62/+OKS9WfDyLQbgO00kEAW1Z0NfC8bIq4bw/k0Ci1d7XwRrUheL0N6z25Vhn48Q7Nw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191275; c=relaxed/simple;
	bh=sYhKHIY1kH/Sv85aMyZfq/DmcwiJ9qI1WjhsBbWJhMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh7Bci4R798+pwhXvPPaBfpLi0Qk1WwBKG/Qh7mguJNi+vAispFV1ZYEw/aDmD808VemHL938M9adwAe75IsPZ0nFMF2f7N70gUNkKgzgUVJjst2TVYttRUHnquQefjJxFMvXNJxMhZ72itxYZVu5xdWn4L2RkeVRUkHZBNlVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbG8FZrL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso70969765ad.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Mar 2025 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742191273; x=1742796073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/t696LxEbizTgZEO/Thjd7sK7TQiRojJYmJJpO8fsxc=;
        b=fbG8FZrLehgdWCO29kUwKdr5YeM4Sl83jKaHqRmb3b+8SC9EvCNovHHLocuUyjgik8
         8P9QhOqy4su9VZzcmM54st1NYFvLDoiiC0KrRyi7fGNSu0PsV+B5lHoBwvIrDHYKTTR3
         vuwA2w/B8nFy2Svdy5mSs8bzt5RRwkX4HawcfA4oLB6PTjWDF/Qf8MxMSw1tPWUDQrvX
         auWxWqMcxCi64taM3jz+p7TzGu9yPNTYATVqk9vmx9M/S3DXcSlQiTpixBG03IjO0wmL
         evnPcksjQdVQYMX3Z9GNqZiit6mEz5+28akOHgjBR47Qjib1rzrvVRhFk5oDPW93Jz75
         KPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191273; x=1742796073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t696LxEbizTgZEO/Thjd7sK7TQiRojJYmJJpO8fsxc=;
        b=jMyQT5sx1MFuBnHyNnGv78i/MeXXKupTcVxRmujymBTm5RNx95OolWndPbRir2Vdor
         l7x9pmmjnNGRgl1bnbBvV4hsfxhN7JjpYYioSQVLQSJJ60W1FECF2SIywgClclOR3TLu
         23DOMFY04GSdd+YCCT/TZwZz6YON/TONXRD/Nr0PidSY1TGsyRl/xsxISbANHMQOCW5c
         X3ts+Sgfcx9oqTVopkgUrU3fBVrdwnpfi/176woD7+6GsPuD2DXq7C+uaULBqEt/YDRg
         pUhdpRcJWi3IKWWbgonDpdcCs+RHxoBbZaNNNejpvlJ6mExJMYoYrXfs7OYUv2M0YAZ2
         KiEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIA8TiHnaCJaNid9zho3nnDe6uItxcLPMKlUP3klbvurGY6SdS70j5RivR6tYQ+BxsWP0xmrOlWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmknjC0/pt+yr9rdqij2XskyirrBS4fIdT6AoZrcRePGMfqIz
	2AEWRWfwoWR4ec3HR2raMGzAtZVF+l9fDugkLEWiew6/3O02O4GNKfrGo/+IbU8=
X-Gm-Gg: ASbGncvzdFEgTiCCaH943GzCnn56m+dg92W+HuzTYGzwsZJanvfv6b6mLbdl+Bs4a0i
	AyRZHm6zsadXHImRC8os/3Gf/KcBf0c2JN6jwvNqnEyGhTXW+Y/h9UgDc1tCh7/sY2Rvx7XsM+6
	W2jO1tCYZwO/KkX73OTeez86G431L1/E+rnn8k8BE25Jq+m57mIzXIAbf/PnIieUGU8sqApDO7+
	C3/TAjRhfdpSoYMHUnaJgZJ1uhUj49+LhOcd9msw+UShyUrDgRrqpC5zRCPNhrSnOoDPL6hLyn+
	FfkoLdzJiEmTxtk6w8OXc+OBVwBnjHDSD6rJSTYlKnKZrA==
X-Google-Smtp-Source: AGHT+IGZgTvwmbnlN60aL/w128MQKSBVf0ulmLghu2RqTVsFN9YIVHdgYTn08PK0fXwGZKBluWTVCg==
X-Received: by 2002:a17:902:e74c:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-225e0a40bb3mr160011395ad.12.1742191273540;
        Sun, 16 Mar 2025 23:01:13 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbeb94sm66648165ad.199.2025.03.16.23.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:01:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:31:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jacky Bai <ping.bai@nxp.com>
Cc: rafael@kernel.org, sudeep.holla@arm.com, ilia.lin@kernel.org,
	tiny.windzz@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3] cpufreq: Init cpufreq only for present CPUs
Message-ID: <20250317060110.tvjat7ugmaceayyk@vireshk-i7>
References: <20250313013928.529926-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313013928.529926-1-ping.bai@nxp.com>

On 13-03-25, 09:39, Jacky Bai wrote:
> for_each_possible_cpu() is currently used to initialize cpufreq.
> However, in cpu_dev_register_generic(), for_each_present_cpu()
> is used to register CPU devices which means the CPU devices are
> only registered for present CPUs and not all possible CPUs.
> 
> With nosmp or maxcpus=0, only the boot CPU is present, lead
> to the cpufreq probe failure or defer probe due to no cpu device
> available for not present CPUs.
> 
> Change for_each_possible_cpu() to for_each_present_cpu() in the
> above cpufreq drivers to ensure it only registers cpufreq for
> CPUs that are actually present.
> 
> Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> ---
>  - v3 changes:
>   - refine the changlog to drop the changed driver list.

Applied. Thanks.

-- 
viresh

