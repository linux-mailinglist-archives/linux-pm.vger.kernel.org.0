Return-Path: <linux-pm+bounces-23558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415FA548AE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1063D7A8929
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35C20D4E0;
	Thu,  6 Mar 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXIN1VTT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F020A5E7
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258882; cv=none; b=LisBMx7sdSUn1uhZD9XzIB6cN31OVFzXZTmtx5zRDK6oXbeQmh9kBrehtzmmoVEHUZNarR4Js9yfxortuhK+Cv6Liv1C7ogX0+iyjI5s/3j4CniMvsGb3DbENpEGGfZ72P4QDM1jMUNztaYCkGH3uJWsvLMWfnpErcV99E7BPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258882; c=relaxed/simple;
	bh=fF0AHv0s3S+dBIkriG8rfycx3SWlry9DEa+eTSo1+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvmy9qG3yNrvB8PC2N9tJ8m4nPT8wGkCuyFHvzPswFkdIs2oL6T2UlWE0lk0Vzs0tOmIMV76wMWRwIh9LpEtP6zjZJFJ46m/GH3lAnkNbvkQpQSNckNjl+GMTIDhwCIbSfvY2Yvj3VpOaRRuyDO7WRpkRE6Q9D+ce1GRlh+78L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXIN1VTT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bd732fd27so4464875e9.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 03:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258878; x=1741863678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=zXIN1VTTTw2CqhlyeLaxW2YtNmml+KoAPBVDknget7P290ejT0JEnNHLL7EXWAAiZ6
         4EL5IuZaHbIa3vqd+28Jj1QonSHkoKmlar+A5usyq8JYvmQ6Auc7dfrWREYuzhBMbsq+
         nuBrDnWuRI9bVxIElm5sng4eLCNBFgQHmA8NqE/haxyRoryNZWfFHRZ13mkH1a/YQpA2
         J5EhZWW9iCXryUjorLglIKbGcACMgrDgPu8xl09Hxvp0vj7NS5bn5l8rIfpUm4dwzgj3
         mM1LJLGoJ0OQqqezJ9Gm8kzArwWubH9cw08PJkMvhCTtK/Svm0TEtWgTxeM65yWp0iB9
         KPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258878; x=1741863678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=EbiM3lm2wpjCmQGECYHkL8QPdc5lIQMjGZARDhFBWjQqFa2iqGdq9y9e4KPwk1j4dF
         LZ0ZdmOHSYWvBHdyEcSvwOMHN/xECkvncwSMV3/YSaZPIcCie5o8+/9SYgiXRsnpeUHP
         CA9rwYw+HgAUdZ1ThKjP1kOl07Qj5PbzmTDfTSvwuAiyrGTL71UzhQMmrZUYrpbdYd4N
         0H+czhQgGpKwWiDPFfpYNZZuM9CzqR8riXQCiuRPqDZZmKGtUN4eVXQY1nhFui5iGO8p
         1K79odEOXhlSwJLeCJVCNGyKN3OEibgLDHZUb2Luwc+ZALYnNXPK61OZHc8M+jfbAWH7
         Y6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUfFk/hN5migD2sG9cY9rnxh9v+O9SWYx0PM+RA59FA4HWoegyR9yCClnL2UYUbK+KpztPXODv47w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNXjnKpqWQWWD3kIZBp7a/q67Ov1rydAK9YwmbiLP0TLea6CM
	XG16FrL1F3W8ZbvCj802B5v2w4ww/OGgv4fYOj3ktAIHOyvDnvf2VVh3Mvn/opI=
X-Gm-Gg: ASbGncvEmll356h+Lo+96RXLTwHyRgxb5U9dgi56YJjjGT0Zl0rtYHsJlQxTXt0pIby
	1+zRV2hoFjVNr34O5FstZ5u4bVI4wN4WT4eUXpJRvRcBF4MkDw9BmnUs8cj884YHWYSnnWu5r7Y
	gE1JpnDLnSnB38f5nTc8g7UP3+EdncO0fWodyBay5Xa8uMisY2CiToXP08X7ZB7S0I+5r3CC2TP
	2IoD4Xm4R5w9KhhY5NANXryP0iOYv9qq0ESgLr3s5bfbOwomi4EaFiPae8wqxeaVz9N4l9WSJbn
	IDZXtwHNI0om4gUBUR1sNsWyAAMRwtLj0+/GftCQGjS3g5j05A==
X-Google-Smtp-Source: AGHT+IFaNI6+FuJB441Zt0saVFEq17tskKV/m1XJhXDsSDNyn2Dt0uqOjvxwn86BlqWjcXdpYtDX5A==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr5660504f8f.24.1741258877759;
        Thu, 06 Mar 2025 03:01:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c327fsm16444235e9.13.2025.03.06.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:01:17 -0800 (PST)
Date: Thu, 6 Mar 2025 14:01:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zuoqian <zuoqian113@gmail.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	viresh.kumar@linaro.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scpi: compare kHz instead of Hz
Message-ID: <c6b8aa98-b5d3-4fc4-9f5d-4bf2471c3d6a@stanley.mountain>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <20250125084950.1680-1-zuoqian113@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125084950.1680-1-zuoqian113@gmail.com>

On Sat, Jan 25, 2025 at 08:49:49AM +0000, zuoqian wrote:
> The CPU rate from clk_get_rate() may not be divisible by 1000
> (e.g., 133333333). But the rate calculated from frequency(kHz) is
> always divisible by 1000 (e.g., 133333000).
> Comparing the rate causes a warning during CPU scaling:
> "cpufreq: __target_index: Failed to change cpu frequency: -5".
> When we choose to compare kHz here, the issue does not occur.
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: zuoqian <zuoqian113@gmail.com>
> ---
> V1 -> V2: rename freq to freq_khz, change rate to unsigned long, and
> update patch summary.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


