Return-Path: <linux-pm+bounces-35688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CEBBB7205
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A4142839B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6978A201004;
	Fri,  3 Oct 2025 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tmd5B7J0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A51FDE01
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500710; cv=none; b=bQ7BwWIpBtk4hlNQMvT23xNEdpmcxkk3vFIhiChgZGRCWMCvxhBnwHVI/qjSQxPuu7xruKr3lN/9odxZiNQVKy780QUuQaT3r/ftEKMHE/ENV03V0oZZLJ6OAZ5JHT2PqhXLVxbDdEUOlFT1FrX1cWUG+M89jANvUBj71O85a48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500710; c=relaxed/simple;
	bh=ga34MQLMl1SyMutFNVq6TRklpM6M66gamu3P72fJZvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUZe+pIF11UUwbeDY73JMLYpt1SFTZoyp7CWQxGWZxOvRFyZFGvjGnlv4WQ5rkOdSZ11t5zzqWUU+rmgwvJh7wUEOMVRPULnmPk7jKiz1nr/i0r5tP0a/UkdNdEyKDlqxluEauGybh8rLvVI4JX3fyPxwhn+45q1RkfdOwfZFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tmd5B7J0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e37d10f3eso16345475e9.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759500707; x=1760105507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxPR9K0HC+xbwxtRa+T+WvGGIp6IQ59ISiN3ZkhzXyI=;
        b=Tmd5B7J0/tgVN5vSizSbddWSNpmfLdPWD9F9lSqwKt+m1Nz0b5nwqfBRMXsJewGlK0
         FPnrtnzGhyKDtigVZ+uxr8dSycRjX16AClTbmaD+5fbhxdmcGoNMxh8eh4yojqR3E3IO
         rKMty55jMpUJPkA0mfGnp8ghWi+lu0JXSVt8xEyBef0OVIN9e7l3Q0Xb8QTPv48b7SuB
         OLc/UO9oQad2Rr2K25lDR0IOAT7ls0diYLYqln86oeFvur4jqfrvK7bbhOiFoCgEDFia
         eLpXmFrDWD1IHqsweiKvmQ92CC0l7li4FMb4AeXfxzCzdNsWrokdvMB79FVFWw0jt5V/
         +o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500707; x=1760105507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxPR9K0HC+xbwxtRa+T+WvGGIp6IQ59ISiN3ZkhzXyI=;
        b=mM5aYU0kMU2uZ+dw9vtkLWHggMzrRYQAZsitYJRolrU6z8j5upUTpbrVQcw2vIs+R2
         pVTkPeBOayI8+mVcAXWZPk2eLWntFgzmI1Z6tU0wDwxpKKlEBl83f91hIfnIk+XOXMG2
         /zTa8r8E0PRjUz1ral96tSI73iOzwL93cVauMiPY60tGJtYmcn89xLYeRM2Ci4DOA/zc
         5EFqXvH3X8O/A4l+8YB26cBG8Wl4Xf7n/ss5JtF2SZ+fc2NjKJfnEPH9m0iO+EigOMcQ
         h6tFLi1VmA0r+8kRo91D6Rm5O0RItf23oemB/Oh4Am8vgqBWY2jEeAk+NLGAySbKt5Mn
         JaLw==
X-Gm-Message-State: AOJu0Yydjfba+HmayYFheAAjIeqFyJprwFXy/neaZQyhtEU3NONzKgPs
	Sx5lT2h9H2cMVEuLCqWcmlGHikLKEFEoPjcrOBA5NWFqDxzYHmyd3khYQT4yfHoO9mw=
X-Gm-Gg: ASbGncuIZ2mkUWI8ttVzrqDRlekzwmlJULX3mjbBVRu80iD+sbe+ARsQdiOX5VLNsAM
	RclEH8uYEcKq7rbkhOpGDkSErD6C4OJmlz53emf4oi7/fi9P5T6XQe7hWDoLHFRHu7+yihotIHs
	1nXwhOjb6N6mg+jxM8lcHV5fo5+PVCRrZbBZVzYJo53ysgoRb5cQvjlVDDaIQkOWhu6rUbD3RFU
	PjGwj9rJ+CsHE6WX8wh0vFAHpgqm1kqah0tL4GI5RwWvWoP3Oa2RByvZBWWkLeCn1lW4iQkwBcp
	aTTHq/rw77g2Tbc58/W+9bhlsH2eBkOJDfJ4egBf+LhK0gjpr/d8um99baXlnBz9u4ZoF1J86aq
	lOb7UjgL4HRpisy06srDVXxQ4WJ5JMvgpKL8FDvMRLKWDV3GJFZ5s2exPzMF45DVqYpiEpVyauh
	SxlNcoVgpVwhl7mV9eYmNHQtIXt06puOhOo00pE7WpNueKvvuo1Ew=
X-Google-Smtp-Source: AGHT+IFYIJUsAi1mTEgCo5N2hnwJFhkd6+46mapxkLBHuXxqoKtww2lCr6Ocq4qA5nCWxX0PP3pwNQ==
X-Received: by 2002:a05:600c:a11a:b0:46e:711c:efe5 with SMTP id 5b1f17b1804b1-46e711cf13cmr14022415e9.19.1759500706645;
        Fri, 03 Oct 2025 07:11:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4c79:9d67:d5bc:d285? ([2a05:6e02:1041:c10:4c79:9d67:d5bc:d285])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm133764065e9.14.2025.10.03.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 07:11:46 -0700 (PDT)
Message-ID: <59a02980-3d3f-4baa-b466-271121a97a2e@linaro.org>
Date: Fri, 3 Oct 2025 16:11:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools: lib: thermal: compile/install improvements
To: Sascha Hauer <s.hauer@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Dahl Juhl <juhl.emildahl@gmail.com>
References: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251001-libthermal-install-v1-0-3071fd3f6612@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/1/25 13:40, Sascha Hauer wrote:
> This series contains some installation/compilation improvements for
> libthermal.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Emil Dahl Juhl (2):
>        tools: lib: thermal: don't preserve owner in install
>        tools: lib: thermal: expose thermal_exit symbols
> 
> Sascha Hauer (1):
>        tools: lib: thermal: use pkg-config to locate libnl3
> 
>   tools/lib/thermal/Makefile       | 9 +++++++--
>   tools/lib/thermal/libthermal.map | 5 ++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for the series

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

