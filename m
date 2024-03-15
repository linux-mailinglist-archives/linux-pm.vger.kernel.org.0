Return-Path: <linux-pm+bounces-4971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8E087C89B
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 06:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB62B213D6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3741D52F;
	Fri, 15 Mar 2024 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wmkDciih"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B055FBE8
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481829; cv=none; b=IFJdd1KXtbikIbWdsBEdZQ3fYsutlz/dosP2EHyn6lxwpgWZQ/l2ePFiP3psbvu9a8/X0MlWXpZltvmw8tqON0KWMGjAYc9adROquklOMkGpCPXYpDzPZ+eNWOX9jIQHYjgrDZyFLGXdsyZCp6b5rU4Yaa4dU6BLqWnA/qh4xj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481829; c=relaxed/simple;
	bh=Naq9CDfVLJcnya6EOl3vtZ0oDKB1UwOPAMZ9XUdYhW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbwJz0xEAPhshi9QIFL8Rgkf6dn5Jp659JXIYd5M7EeErMD2/q70wUkCFncG2xZvlhkNC4DUrKXnHqlOdmAmPWbihZ8Q7TQGHyQRXud/6tXhbHjRfZkqyT02Zg9uNnEGAEvnGJbZTI5+yXzwFLHEL/AaNu8G1MjycXA2pgXyG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wmkDciih; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce2aada130so1460023a12.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481827; x=1711086627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmeqZQFsfILznkSe1TDD/d0MuJKx0Lhu/2GiKczhwds=;
        b=wmkDciihrW5uRQUtYyPQUML0MbOxl3cE4UMXLoxK+4OjAURzdiICFc7eyjTehN6NbL
         Vn1aNfWoAnALHvCy26hWFDGZ7d+V1qx/i80w2WLhv8A5CIeuTngMHORKOrlVEdGshCD9
         rbPuKbpexGMMJB0/tEyCHsl+YwPHRyP7J+XA+LeSwSk2AXvLk3bqdIhjKpCDxYz2770E
         3CK65OGZdd+ekC/VqPfHBsA0y1mgwVgqA3/3pjuRhvityKjMRbmJxaouRd5My8mFGJ+P
         iZgBLL/tuxedrVUoTVf+FKTDdpoRqety1tapZ9hBOTOFF4778Fc60NIhcd3xUWS8TA54
         IhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481827; x=1711086627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmeqZQFsfILznkSe1TDD/d0MuJKx0Lhu/2GiKczhwds=;
        b=UiL7QQN9/67UBm7e3Z5662CCxtH6HtCmh4F4rNfHcR5FPlnJeqoJk7QKiCknDUozxP
         gpD2F17df71lLeyhzhGsnZ+boUmjJ61F7WA8FlkEagxj4fskc4LlfAbDjwIxNjjk5xVo
         X4ajlXZsxiCmCgSEaPL7mgOCSoH9Z9J8T/7sjuYWfpFTWFC2NH92ifS4Nzxlc+iV5iVB
         j7FnxVNpYuSNmS5Y75BZ2Fxq8ur7wyshl/h8oDnIbs+rd0dtz1fQJ73aJ7B8FSPo/toq
         XU4CJbIU4My5FZWUiKoe/zqqQaqhvasVMA9Z/6341NN1WFB9QqDxB1awbljX+qoPk/Bk
         rDWw==
X-Gm-Message-State: AOJu0YwPMHyeKDBdAz47u765b0LMuJV58277yvbeJmo5hHC3ZGSimg4x
	kXW7sCqj8cSIOk+OohdIF6uC6XzT0gYOjpQNRKKBoGmBBg3ziEB3dsjlXNkZUdg=
X-Google-Smtp-Source: AGHT+IGfYH1h68xEMnxaFPv1hFUKOr5YSQLITq8lOAM9Fw+k62f3AwJ0HdbWBTJZFkUgfCmfapPMfg==
X-Received: by 2002:a05:6a20:9d94:b0:1a3:2f5e:6126 with SMTP id mu20-20020a056a209d9400b001a32f5e6126mr4304199pzb.22.1710481826596;
        Thu, 14 Mar 2024 22:50:26 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id le13-20020a170902fb0d00b001dcc2951c02sm2823712plb.286.2024.03.14.22.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:50:26 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:20:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Christoph Lameter <cl@gentwo.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: always allocate zeroed cpumask
Message-ID: <20240315055024.bm7vvznq3nzhfsno@vireshk-i7>
References: <CGME20240314125628eucas1p161af377a50fd957f445397bc1404978b@eucas1p1.samsung.com>
 <20240314125457.186678-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314125457.186678-1-m.szyprowski@samsung.com>

On 14-03-24, 13:54, Marek Szyprowski wrote:
> Commit 0499a78369ad ("ARM64: Dynamically allocate cpumasks and increase
> supported CPUs to 512") changed the handling of cpumasks on ARM 64bit,
> what resulted in the strange issues and warnings during cpufreq-dt
> initialization on some big.LITTLE platforms.
> 
> This was caused by mixing OPPs between big and LITTLE cores, because
> OPP-sharing information between big and LITTLE cores is computed on
> cpumask, which in turn was not zeroed on allocation. Fix this by
> switching to zalloc_cpumask_var() call.
> 
> Fixes: dc279ac6e5b4 ("cpufreq: dt: Refactor initialization to handle probe deferral properly")
> CC: stable@vger.kernel.org # v5.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 8bd6e5e8f121..2d83bbc65dd0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -208,7 +208,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (!alloc_cpumask_var(&priv->cpus, GFP_KERNEL))
> +	if (!zalloc_cpumask_var(&priv->cpus, GFP_KERNEL))
>  		return -ENOMEM;
>  
>  	cpumask_set_cpu(cpu, priv->cpus);

Applied. Thanks.

-- 
viresh

