Return-Path: <linux-pm+bounces-25766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A01CA94C34
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA76916FEBC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7E257AF2;
	Mon, 21 Apr 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v977lrKk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD720485B
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214298; cv=none; b=j4rhbCF+xe7BJxE9i1C2GOOaRxRCJF6HE8Qdfg1o1KjFw1eLXhFKOs8w3e/oNB8L0xDw5ZIjN0MCe7HE3Mbu+HJTAH0NFOYa7MWt5G7DFiiYABpefKIC8N+En6/bS0PiXITgNp9sOzdzyYttlZGAw/5pibm6B7X0ouq40aartD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214298; c=relaxed/simple;
	bh=eBG1slbqTRw8vsbgYrWTwEorbArUGPZrqx8A3p4gBj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY95bObkDtYKvlXyfSRR/kuHsqqOh4WQazUQCIbYZVcJeNGIE17s3KiRw4N5anHQpl4yFUngbhAqgeoqCdVySrXW8Vq8ytdeWNNlLxO3A1yRxwE90kCAkNmtGXjuDs+A3qEghlEnmdrAN0Ru/4anpCGIAddGktwv6ctAA+YXzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v977lrKk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2243803b776so57113715ad.0
        for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2025 22:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745214295; x=1745819095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyOTo7rnTJ1HQMNMgNbpA3SfQ6Ks6YJstKsXKdKshu8=;
        b=v977lrKk8VNZnHgjNCWgZcKvluYqucgQMqsBUL9hoHL74ez4tx98oJCsDI63kFTpDO
         ctgAGV1cdhyEWYlBGSsgM08ycWsKY9uZwDL5JjyBBaCAEmwLQkBSoNCumeyeVvW6XLBe
         QIzp3whntcplHQPwhS+IuJVwQ9gyjqXHfHI8e4rTHbTU4q7NV6w4aPWQQvUwOp41gSdX
         zeWzwBwqwc4G0K2XlPZI3jGPfzTjTT8Hv/2rl9V23Ah767XNZuztZncJuzD49Te5Q9p2
         gSF5ccjRbhUnxd43S2noCBb52fNaOXFDJSVuedkzQUcu1UNtIcF1hvRn+JUyAy86XqIM
         ldiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745214295; x=1745819095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyOTo7rnTJ1HQMNMgNbpA3SfQ6Ks6YJstKsXKdKshu8=;
        b=uBWG0FztFe4h5LOsTXawn0me4f0N0H7daxqzv1NOI1dFJ2m4WRVt5IbxirWEmberW0
         Rb5ieShilwVRXkhM3ROi/IApACz3uBl6ArTzKEPG5j7i1/AAZwsotsZHoFhOeSh961Ki
         blxIsPyu3ZcuUtk91w4kTOEgkFR+PecBfCMK2u/Jto+YUgG27CUvfmLgDfZLGjzBPl/b
         XhDdQahcYEYTDckd/YSyeha5xSaSVFDTdJ0hqVaqXaDLsJ1Z3y4kDPw3PnN4ydJHrM5i
         3J15YnyijV903Eq0mdlr4W5GT7Gj0+SFyTzOeBKvBns/0bVy533euJ/LcW5gsqKQYMDM
         ksdg==
X-Forwarded-Encrypted: i=1; AJvYcCXBY+RehhPZu65pB5g1Fmd1I/TPBI5yQI0+v3P1Lsyai/TFbYev2pV7xFsqjrRNBB784txEnoeAIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJrM1e8704eRA6a2Uy3onIpKHHIfjJMs6i/yaQocbCYVPCia6
	XBUspYXS+wOjExLWXmcU3sb6M75OKw3dbeec0Ju2Ofio3jgKd2u9uaILJQHSVivZPCwjceSEIwR
	a
X-Gm-Gg: ASbGncvELkk+5l+UZfw4XFK8RtZa/K/NDDGnNTvO7jJ1JiBvsgAvXygNUtnW78/589E
	WIbhXSBg6krNEDipjT89WPjScLvIJvLS0NYn2nEUCH6sH9M8to1pBwUNuglcU6RVTVQgogLhWGf
	GQ3LABVPUI6KaN+jq4YMZH/+eQANxucZcbOetAp3nd1qQB47PmlvVFLf+Tjx6fe6c/a7VN1mNPi
	ZnNqSCKzfC50kqlrfuaSh0ax8e+/dboi7tjMoJN75iNq2JB6Z2PXXMGkx+2jFSduUAf3CKIoo6/
	0AFNmeMYyWZIHo7im5gly8Qyl2YSa6GmC42eXaRK1g==
X-Google-Smtp-Source: AGHT+IFhnaa0z+ayVrcmvAvIxkBt8wrJ3nfuin/kbU7E0Vx+ZE9g1E7PEVYhPkwAR5/xTaisUcIpCA==
X-Received: by 2002:a17:903:2ca:b0:224:ff0:4360 with SMTP id d9443c01a7336-22c53654c0fmr157873595ad.53.1745214295413;
        Sun, 20 Apr 2025 22:44:55 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdaca6sm57336995ad.9.2025.04.20.22.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 22:44:54 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:14:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: Export disable_cpufreq()
Message-ID: <20250421054452.fdlrrhtsimyucbup@vireshk-i7>
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
 <20250420-tegra124-cpufreq-v1-1-0a47fe126091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420-tegra124-cpufreq-v1-1-0a47fe126091@gmail.com>

On 20-04-25, 15:42, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This is used by the tegra124-cpufreq driver.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0cf5a320bb5e864709b259249fb1af8bfbc0b04b..78cddc78ee98630f99ccc332c64c94f437297177 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -109,6 +109,7 @@ void disable_cpufreq(void)
>  {
>  	off = 1;
>  }
> +EXPORT_SYMBOL_GPL(disable_cpufreq);
>  static DEFINE_MUTEX(cpufreq_governor_mutex);
>  
>  bool have_governor_per_policy(void)

I didn't realize earlier that tegra124 uses this call directly. I
think this call was rather meant for other parts of the kernel
(non-cpufreq drivers) to disable the frequency switching. It may not
fit really well here.

Instead what Tegra's driver could do is remove cpufreq_dt_pdev, which
shall lead to unregistering the cpufreq driver completely.

-- 
viresh

