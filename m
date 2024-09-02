Return-Path: <linux-pm+bounces-13343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B245D968603
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E99E281078
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A013B58D;
	Mon,  2 Sep 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7GiY4dB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3EC13AD33
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275915; cv=none; b=k31tm08AVE+zdK5tcCX8A+fUfAe695x3scs89bKGLo0tZ8jgaNgKzWfOVUjGN5dgJg49aSc9BkEfTftskxpHCuV9Ts1VxBUSrfpCKphbDbmcZFGoDZ16H79BsMQ9Du0IL/VfDW6O0cojo3hlSWq0WhKzXtG3lyLX4IEPM/DyW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275915; c=relaxed/simple;
	bh=5Up0rVIRbTZk2mMllYRdh25drBqDWVwWw1oznGeUOKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2ZhlWi315HhA0OOMT6GJDIOZ/msxopZOzcbVENbVOjCPY/BJVsj7/NTz9YOrXvvHW6fPrYuqY1HeQy2SQbtpkSSveP7LsHMyfy4mBCtGX0pWvfoDP+DWG9DvW3zLNfTtlp6M8bJwc/gjTXs42YsRAn0Y4NksI4uBlozoih8eK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z7GiY4dB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso18582065e9.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275912; x=1725880712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VeFvkY/xK/isUYlYCWnwjqPOZI62Hvci0+jBt5nm+E=;
        b=Z7GiY4dBi+yLI1hdx+Xk+mCMeP2F69DZPx1HBSxis3RunbLnL1iWVo8VlcQ4+5Kz/R
         Cegp6Y6/IBEprFYgJ8S4munI2MzCJKiD5hMqFi/yuiBAeAGu9SocI94noYCfP+dR2Y3B
         o67ldwzO2dWud9JKjBQsxTyVDNJ/pwnSGtyPPcnWfwdLErZ2Ua60T+uNI0CFSxHQ1MIM
         qlZzz/NFLQBwd48vX0CBpbcgCX+yZaj9v8khuYUiqrbGu1XWv7l3MrrDCc4bcXTxobUp
         isS0RTDlbXcb02a+1ntm9SidIBde0ZaEOENek4i1Ae0iG6ei0zej84YQVv7DrrfEKaNA
         PRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275912; x=1725880712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VeFvkY/xK/isUYlYCWnwjqPOZI62Hvci0+jBt5nm+E=;
        b=wiRXgrDBGXWNAN0ytHgFD2VDOzysNPsQybOSFIw+KEnA+R7fLYY1y0hFuiVTjs4o9f
         as88nvUt8n+a4kYsfrCCSR4qKnX55N6tXbToy8gyGvITqIaBnK7p1K7mdFVmqRIKdXLO
         0kakJzgX4cwjzqR2WrweXREnBaQQ0nAKlMxkaNHAAMYQwqG2D7BuHZay56aiWsNtYDQe
         KTSMjvddn+HSGmciDUrSkFTB2sNJoz2YHoXrAsNz2nxVASkX6TxLxn8fTqSPvrtbY+c/
         c3uFRjtJ1dzuBo7sgMiE5LkhqnejZAfaNP/GLcmA6kZ/XxlZrEyOd1FNbI1nYEceUu7n
         VgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPS2RepKhdTdv5CJBS+Vsip/q+fUA6QLbejfXFqB5+gSZHk047cAPXTAlzZLxO/3x18j28zZRLVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4OBZJs4L+5F1+XEDyZPBLpovSCD8bdH0SEaPnfOxJPqh2tQO
	MoxQ5H85r5zTsN6qL3lu3jSvA8LC5VkIg4boVnFYH0fMNqCwfcSq1x5/y8tzzhA=
X-Google-Smtp-Source: AGHT+IEtF70MJFP7XTLP48g2CuRp5TETnvH1e5Pi0DToO+t7bJr6WSrcY5bpknrE+4TxDVzq4T9m9g==
X-Received: by 2002:a05:600c:1ca8:b0:428:1a48:d5cf with SMTP id 5b1f17b1804b1-42bb01b9925mr106733605e9.9.1725275912092;
        Mon, 02 Sep 2024 04:18:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33e37sm135573345e9.42.2024.09.02.04.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:18:31 -0700 (PDT)
Message-ID: <df1c12c4-c5cb-45ff-9881-eb2099528dee@linaro.org>
Date: Mon, 2 Sep 2024 13:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: qoriq: Remove __maybe_unused notations
To: Fabio Estevam <festevam@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>
References: <20240820012616.1449210-1-festevam@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240820012616.1449210-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2024 03:26, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The combined usage of pm_sleep_ptr() and DEFINE_SIMPLE_DEV_PM_OPS()
> allows the compiler to evaluate if the suspend/resume() functions
> are used at build time or are simply dead code.
> 
> This allows removing __maybe_unused notations from the suspend/resume()
> functions.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---

Patches applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

