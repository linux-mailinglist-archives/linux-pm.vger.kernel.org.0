Return-Path: <linux-pm+bounces-25591-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D860A91234
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 06:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF635A1F57
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF11D5ABA;
	Thu, 17 Apr 2025 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hr7KPjGE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5A19DF9A
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744863906; cv=none; b=GIVEqKX5/aHx/bOd9iIGKguXps+iglRFOEqklPc2iP+ISdc799cGtF5L/sDsp1dTuefze4gVaUHSoS8Hxb5oIRMiHRJLv19UG+D4we5KBzXaToFSV9/zWC8SrPeAkZvqrVSkOHaN3zxI3kSJBn5XPyvd3jQ7+7zQBo647cJZ9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744863906; c=relaxed/simple;
	bh=MlMsrIFgwNPUXQlQUeeWv3zwmDoBQ1Ow0x+5qtQ/UTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPwA0YqoGp1l53F6aXB0B6K82jFjMkHjwm5OXBQD7mlG2/OAxHz0D2/Lq3Gsw7luBGKoimFPBWMeoz47D0Q688fjj6HWA4or1rxgfmswDj6YmiH7xxiRqBB6tTcxwc0xXI/zTOIVHXinPHMqfM0YUomiiRm1ZHzgsXG7bGVaHuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hr7KPjGE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224100e9a5cso3901785ad.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744863903; x=1745468703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmiUHUUBKI8PJIWV5sMJoVG3SND4wAcYpi9OlzawyYI=;
        b=Hr7KPjGEJTHH0n2W34l7jZXH2EXyhNphcZpk+mLeSzGEXR6DZkk28QqgOzOwInBJvB
         LcUP0VB7PtY4prI79xhNW8tT86NkwPGGyeqeBFEk8im3cF4tPGXexfcFK7S7lrWozOgd
         4abIpoM7bbD2Ftq1588yT0Tbg3W0tR6W1VFmdaVzNbymQwlB1vncGkJDsPhd94YT5NCc
         Qgkc9be5z9xocNet+LXnqougjkdb2eh8OmeJy4SqMYL1ZDCpl6tNcaO8vfUlXt66lo0E
         K1zVcZs+BBMVsKkHj75k8a+Kg+XDFGBpMcUPG90h/3eujjCYi0uKbzRNZHjNJseAWHDD
         u+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744863903; x=1745468703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmiUHUUBKI8PJIWV5sMJoVG3SND4wAcYpi9OlzawyYI=;
        b=WxZQLEGlf8X1ni1eWDABsTW339OcPOuDSGB45ty09TC7N0VgEBxr41xWTbLtiggZcR
         DbuKKN2rcAV8bZY8rr7ydiOo7HPHfMyGvrN+PdaVxN0iCx6gTqYVsVWXEXQmxe4XJ75i
         6ov5BmAmhEQMER1Aafm5ltNbzstI50pb38NEtlkOgWLyf+/4ajEho/acQ4KNRTUX8y6t
         /zMywqK3eD3bIR6Bo0iDNze+J9C3gBH4XLXBbL9L7/i929eguJTIdKMTPr9TEN+9EuBx
         EnBm6H7jXN3jQ1sPNWQpakAUgh4p8BeOkrxpIvgE0jv8IQNsqB/E1Sxu23YIFmogKogO
         EXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaUnjQSFwcVDtEJKyqaGobrGiA0hDna7JVajSG2ENtik5+Moqb6i5bh5QnKUtB9nSwMf+1B66Z8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++wXQEE8xOrqzYQwRrwFJB/UMkSaZrFkdiwPgIGW+97kkSYdF
	v+Wco8PLIuWCpIulAw8kmCsK8BpwgP6x4U+GBUrEM/2amHJR/3cgvkoh+OF4K1k=
X-Gm-Gg: ASbGnctoPkh/3Kd+rxI7twiS7yL1KO68Ok0wd+UXPlCdvKVltjRtVORgRlBpeTlCQaM
	uNtJ7bfUynVmvVQVRHAvfkF3xN3NAIt5z4oalWLT29LpjpuKJ/JMNVoCyE8VSHLodG/SH60p+Qg
	ewc09SwgHSo1m22m7qCsudaJ9Mm230nUcmS4yM9Vd1Jhc74JDniC+LmZL1Cdlv17nbXaauJz8X2
	iFIQnVe4xyqgxJxGGlecQ+ozXPzsjim+whNfJTW+kRNAXvdtQ2huWR/nG5n9mWZS/P1sqEQQK15
	M+ar/+FyYDGTT5H/1CIuaH76O8Fv5bGOrvIM+kx4SA==
X-Google-Smtp-Source: AGHT+IG2v69nuDWH4FgYa76B5nKgqy58L4Wid65MFMUFPK5+zr5XnBZE9bRrkKyZECa0wTorHqTLjA==
X-Received: by 2002:a17:903:1cb:b0:224:721:ed9 with SMTP id d9443c01a7336-22c35981e16mr67570055ad.44.1744863903581;
        Wed, 16 Apr 2025 21:25:03 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2333859sm11288413b3a.158.2025.04.16.21.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 21:25:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 09:55:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix compile-test defaults
Message-ID: <20250417042500.tbuupp3jdpfkk7kh@vireshk-i7>
References: <20250416134331.7604-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416134331.7604-1-johan+linaro@kernel.org>

On 16-04-25, 15:43, Johan Hovold wrote:
> Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> enabled compile testing of most Arm CPUFreq drivers but left the
> existing default values unchanged so that many drivers are enabled by
> default whenever COMPILE_TEST is selected.
> 
> This specifically results in the S3C64XX CPUFreq driver being enabled
> and initialised during boot of non-S3C64XX platforms with the following
> error logged:
> 
> 	cpufreq: Unable to obtain ARMCLK: -2
> 
> Fix the default values for drivers that can be compile tested and that
> should be enabled by default when not compile testing.
> 
> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> Cc: stable@vger.kernel.org	# 6.12
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

I have already applied a similar patch:

https://lore.kernel.org/all/20250404124006.362723-1-krzysztof.kozlowski@linaro.org/

Can you rebase over that please ?

-- 
viresh

