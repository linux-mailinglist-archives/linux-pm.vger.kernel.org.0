Return-Path: <linux-pm+bounces-2532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F7838719
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 07:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F08288887
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 06:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443074E1D8;
	Tue, 23 Jan 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRQUR74u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9A4E1D0
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990053; cv=none; b=lr5fRv5nR/k58NDpWe8p0j3hfbjk506V2HA4dNN5ASNHOxd24FEE132Z8tXCGsOE1eSDCsKuKy2Iy02WuAgZutI2uvrwl5jWB82hz3wCDF3rUCvuzK2mPJZ6GNur1Va8DRQzOLIINYMXN/s9OCB50EPfPcK5kiBj5vRZdshQvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990053; c=relaxed/simple;
	bh=ZV1WplPgij/l1/pubuA+HhF3/J9RsyejqWDz6pUqqQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9U/SRmqd4WhghcWdfCAyhUmZwzy46Uu/xadzrql0GliT/K9Cm31JZ0dQoVdOyzcxXGE1ZqXUVVxHmJHxOD5Bbhye+v3U8ZUGvRqRGFnoEskVYIXySqV5F9S8frlWXvd+0R5HNn+QiLZ4LWWU2noo1fcz0Jh+h5ZRgtsb+Tbkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRQUR74u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d75c97ea6aso9996005ad.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990051; x=1706594851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5yCGkOws+vbQrg1D61I8EXb9t0E6b3FMjrVHG/Yke8=;
        b=gRQUR74uQzem33Jo5et2Qj5kNb7xQ+SRgjZJde/nrIK6AR8PeSl0cRugjIJrcSZ7aB
         OQzuWduchoBCZPgzcTe7KkWg0SnyPnXgEAvL0jdIWHi3IItmgwpJucDhQl2hoJruRR1w
         MHrBjdkT2c21HjqL3H9Mzj7iI7knjandOJCY63vyKd+99A9hQVaA1FXa2zwcnEEtPlvA
         cq/qw2IwE5hcvScQU45DQwjvNGnbkXRhlMy+D2uescYat6vttkjKEmTsnOS7bVoLL8/A
         JHhU6lZ4hHTqjaKZZ/ImZyVpZOxtzbA90SSxRUX5cQWy+a3JvAss9z736SgMamXAvt0Z
         4mTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990051; x=1706594851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5yCGkOws+vbQrg1D61I8EXb9t0E6b3FMjrVHG/Yke8=;
        b=d22Nt4MwsZaobB/3qeLFcHqLgMXRl8hkig/MXiQ610LOgUxnrC0BMHTQyh5Q10DcH0
         pBy/tmSuIEqZRrhfk9DUPqifyTAkOtRjyGSkyDEnZ25B7cgYWQKHMP696WxUxFdAmkCh
         rujv/TeccIVUKyln5HYjbIGgwh3UP0YtetZg9fJpEL9RWa6qj5tWTGjhORozXMIiqoXF
         coORoaGOWNz0AGwptNG5Prp0otnKzNVXK/blqpV793mNEJxpcgu8Ahn87UTo+92kP/GP
         GbQYcosxuD3tDl7hDrLNsYG8CIkFsDtWwPW2aqf1W+4GmbaaHHfwl0jP+ozeogdzDtEI
         7pFg==
X-Gm-Message-State: AOJu0YyzFL7xvh8cJyZ7y0+PVwG1WVnKHU3IG4DyU2UnEuLkay50obu2
	rKjPcXq3HmYDrAoQevYjjwEJadSAA6RbPQXwv7EyjnbxexSg7WJ4GGv/YDp5Jo8=
X-Google-Smtp-Source: AGHT+IHRt5FcCDn0W8pHc34q1FfHn7oxKA43CJaOlgFJMsH1myD2DhUAoG3vfuv0HZ6E1+Qc3wC9Cw==
X-Received: by 2002:a17:902:d386:b0:1d7:106e:4227 with SMTP id e6-20020a170902d38600b001d7106e4227mr7112819pld.41.1705990051185;
        Mon, 22 Jan 2024 22:07:31 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id jx11-20020a170903138b00b001d7204de07fsm6310795plb.147.2024.01.22.22.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:07:30 -0800 (PST)
Date: Tue, 23 Jan 2024 11:37:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: add check for
 cpufreq_cpu_get's return value
Message-ID: <20240123060728.5drq2krpubhsvshn@vireshk-i7>
References: <20240117071220.26855-1-abelova@astralinux.ru>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117071220.26855-1-abelova@astralinux.ru>

On 17-01-24, 10:12, Anastasia Belova wrote:
> cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
> and return 0 in case of error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 35fb3a559ea9..1a1857b0a6f4 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -481,6 +481,8 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
>  static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>  {
>  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	if (!policy)
> +		return 0;
>  	struct private_data *priv = policy->driver_data;
>  
>  	cpufreq_cpu_put(policy);

Applied. Thanks.

-- 
viresh

