Return-Path: <linux-pm+bounces-13582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E996BE96
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153232825AB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD241D9335;
	Wed,  4 Sep 2024 13:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ej4V6gEZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71C1D88BF
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456916; cv=none; b=MuVzgjf3vzHnuV37ioSqRCqPZFcIeYiEJboTPeoobFiMmnh19kkyrPU1dYiylJaknYSbsfljVNNxTOpxAYJGRd/DUeWWIVxhONxnwlhOhvb7LLOPLpIBFD+jDuqXFgiK4BCQ+AO+NsAw10NeUH8J/OWcPjuOHDRxI52Tcri5IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456916; c=relaxed/simple;
	bh=41xFYfekiMubd9r2YEtmUlcXoreoFCjcE8w50qz+NWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PB/fhTbAL6n9Fj7mDdXdPUd3TQFPKFuEyLXMyqDLVsLBxrfSF7+rnR/vW6sB5iPt+vI8CzLhQxk77exrnEC/EfpPl3G1G7Wfw0vTQzgMsTmsH/kn4zAYRJrRqQrGvF3e/PYqcWhegZeBjlyYLfKUGBGlZzZsh4L/WaLLMqjfjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ej4V6gEZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb8cf8abeso53157615e9.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456913; x=1726061713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ld5cWyae/iB0k1Ca1RVlaEbBbyAMRHm9ax0zyn7Axo=;
        b=Ej4V6gEZcpHkDMvv2oF4/93mwpXkOpfLs0BFdhPTM5ooPwiAu7EX+XEwng65Ff+vJu
         OozDsLXqQpgiSHHbhjnVfAOn87kh8NGPrbHsp7YCnIIzTXRfvFiIqp24cdSZb046osVb
         YornORTglNi8CF4gFzeBdo5YpUPdIOfwOkXwbw24fnWJ94vuHJQgpTPUIH1mhJNLFXi0
         CchpZm7lal9tlSd8eylPQYkBW/b8XuA8Fm8uyTznQhOELOYpfQhJzW5RRAlTA65stMCj
         B7VfWtrSwibEwAADeoScnSTwWtNb+gcDTMn78xJq+eCHl2bpxa4wPjpbneVVWFf8stI/
         fTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456913; x=1726061713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ld5cWyae/iB0k1Ca1RVlaEbBbyAMRHm9ax0zyn7Axo=;
        b=BSLc0fV3PRdPlf5DF+y1xuLSMfXsQTZbyRoRSQivvlzb+mMVFPmPvwiBZGz7RZii3q
         +JswhbhcfzJ2+jMQ7GzQBeD/ZzeSYETHNoSD+kK0nFZuPQQGYEQi8VdkWYZvEUI/PcA2
         uGvxKMnlVy2YoLs9/2xBOtkJ55I1UaUjAyGsUaAnM/p9vVu8Auvg0tQX9g5Agy+URuDh
         o5XZkX1S2UK0GjkwvmemBF4cmulpnfI3DtPxfBC2M8kTZdaO9i3pX6BaysgC+zmDh6Ck
         WeMJyIutetBxpcBBZr76yJyr0gM3nImHFLqvLldyBzILMtMtRgUS+TB1L47CJj6pt/VQ
         Ma+w==
X-Gm-Message-State: AOJu0Yyzn0wtJb+WveJStlFvFzeELoZ1KaxMw9R4pR9ONZKk1ZijFfQF
	MIGVDL4h3c8BesMBqfzeYMeJkW/7kiUnvh/JpKuK2kSTfETf0DqvennSBaEpeMQ=
X-Google-Smtp-Source: AGHT+IE1R2i+awcjDPl197c7K24+01eFHTYrMYyuAR8ePTTzDeEHp8BDpPPt5Zs/ISrbNMsn/ws9NA==
X-Received: by 2002:a05:6000:4029:b0:374:ce9a:ff11 with SMTP id ffacd0b85a97d-376dea47205mr4000346f8f.50.1725456913032;
        Wed, 04 Sep 2024 06:35:13 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3767dc16f83sm4099348f8f.60.2024.09.04.06.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:35:12 -0700 (PDT)
Message-ID: <eac88362-4b3e-4fd1-b649-2f374453aeae@linaro.org>
Date: Wed, 4 Sep 2024 15:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/drivers/imx_sc_thermal: Use dev_err_probe
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240717085517.3333385-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/07/2024 10:55, Alexander Stein wrote:
> This adds the error code to the error message and also stores that
> message in case of probe deferral.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

