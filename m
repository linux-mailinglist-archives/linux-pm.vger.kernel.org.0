Return-Path: <linux-pm+bounces-17296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA19C3770
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437F61C2091E
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC09126C05;
	Mon, 11 Nov 2024 04:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDObEpn1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECE4595B
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298546; cv=none; b=SkL9B36MZpn9Hm0tNpoGoP4SI4ffxddZVzbPbi2QBP6eEfimh4plJ7xmNCTY0mE8eecikQWWCVRPqW0NTbrtdETaKRU9GI+nC2rj5Iv+2+RtRkG/MQAicX9d6hNnWDN3KHxruHYJGd9UGxlOz6A9M5XbW4QCyu0VDkQfgiE9ad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298546; c=relaxed/simple;
	bh=fle9jir2XkQTPkMIv93KMYsqrh4kDkUf/SHSJR5R1Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRofgCHCTNmnoVYsFpYi4KUOO7Q90yoFWSQnKy3pDv4Ug8wrDM52P07VXdRcK+j4SorxtGefXpfk+doX/eI8J+wnBP4XFRlXXg3JHgdO8Ck9GL6YPTtq0FvKhVxepmpSFcrdDtqbbOBq7wVOuC+7dv3hTxYbuGiMqvrQyVOYa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDObEpn1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c8c50fdd9so34470885ad.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 20:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298544; x=1731903344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knhfiz6v1X/Y5Phw5qTTBL8KQ/Mw5RIdq1X0vCWMUt0=;
        b=rDObEpn1doCrwYhHHvVPh7h2PsZ6zj7LQtC/G6vOMVUlfRWIBt+lIGlYeg7a2yTwIq
         0roUjwZ27fDcH+hDGpLfMsgQC8gmUPQ1JZkEljwzCnkhM+6o5wIkvUWb/CN9sUEaPd/U
         Cc97JuCkjS9GGuItyjYwg/cLx5k1EowGLGj8SrMzEu/RvupYzPCOJI+OESyeuRN4qFwQ
         Fdg9tbAFM0aiTfIPjPoxvZnEMBUw2kkj+LTqpABohaZTg2WsXqyNt1QWgj9ACepHvqFL
         fOZUscFTkQIOQPl5ToVl/OCwpfLCqxCS2X0MI3VV1Wcm0at+lcTGPM5ZEeNLYvuebla0
         H0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298544; x=1731903344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knhfiz6v1X/Y5Phw5qTTBL8KQ/Mw5RIdq1X0vCWMUt0=;
        b=QzZ+K4ZUhCOndijYR+nx38jhBGRN/VeySvNQr6xK63lsKJ4Y8iecCn8vl+kwHTDXSA
         NgVh2zcBhaosOVXsB0n2sP3UhMGe0cGx+0XAlREKPlaHOQbatac4ZHih4cKZLxhRvCjI
         wK673IsIVYi4tuM8ReWjmCwHIraSlDvSRzMFLKzkjLHI5x2sakJSvfQ/GT3+dVYH2+3G
         nQxle7dL377jep6eYBXO4V030UheoZNPIYAlnxeG4+4uQqF1P6QNqS2S3eaF7qwi3PjI
         zi10FkrCuHaLy4y3Wgm0cuQedESvwzbbChIEYThOyU3Xk5H6S0uHBguPRGPQtVU7eJ3w
         C5Og==
X-Forwarded-Encrypted: i=1; AJvYcCXHrW+mBRoyUtY2aVWGmGwymfhBqp4thd935a4gd/4cJ8AV7EgsHiOxrexzE7KKXCN7EUJrRHsOjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1ICflfRQo6rJifaUZEcq6YmXnoi4j7sFzkmVqFxxvrfOKz/p
	b2jFENd1tcwwIR3e14H6dUxplabuUSX+1N4NZ3Zdq1042yvv/MWIEvAK4yGs66U=
X-Google-Smtp-Source: AGHT+IHxCb9wscTjmGmnrU/ke01iamppePTNlMCSebsPTr/XCYGY/bNBzPupEwPaf2R5gdgxQNJBBw==
X-Received: by 2002:a17:902:d486:b0:211:74be:c09b with SMTP id d9443c01a7336-211821ae0e7mr198879005ad.12.1731298544156;
        Sun, 10 Nov 2024 20:15:44 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1a9fsm7577101a91.37.2024.11.10.20.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:15:42 -0800 (PST)
Date: Mon, 11 Nov 2024 09:45:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, hector.yuan@mediatek.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 RESEND] cpufreq: mediatek-hw: Fix wrong return value
 in mtk_cpufreq_get_cpu_power()
Message-ID: <20241111041540.7pfksjopw7qfupsx@vireshk-i7>
References: <20241107113841.989475-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107113841.989475-1-ruanjinjie@huawei.com>

On 07-11-24, 19:38, Jinjie Ruan wrote:
> mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
> em_create_perf_table(), the later zero check for power is not invalid
> as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
> the 'policy' is not found. So return -EINVAL to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2 -> v2 RESEND:
> - Update the commit subject and Cc Viresh.
> - Add Reviewed-by.
> v2:
> - Fix the driver instead of em_create_perf_table() as suggested.
> - Update the commit message.
> - Add Suggested-by.
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

