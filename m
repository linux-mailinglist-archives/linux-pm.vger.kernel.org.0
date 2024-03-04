Return-Path: <linux-pm+bounces-4633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1065086FA7C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 08:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4164A1C20E44
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3012E4F;
	Mon,  4 Mar 2024 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlxHZzva"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB113FE2
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536155; cv=none; b=uOKO6m5sEmrq6ciHpmy4lC66DW28EgJmfGbX8h6SM5k4A4VKKDltC61YCJlvpVvypt5yd97YihrfjTfRzOS3Bl8dYvVN8KZwN5rPrJkRSzJZxfrs4Hko+k5MVh9sikNxwc+ZxiokxX8tZINT5P4MJmR7IBxeMbKapMT5AzYv9U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536155; c=relaxed/simple;
	bh=+A9vsuYrYL7prLESEnutlZM5tyD4hloL5PPKBkU/1yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJTWOpw6lnnyQx4ciEElN1Qa2be2wRRAazw90uCo+1UKFWEAXGMOOFecVK1m7GG5bmKS4KJ8ib30e6LthtNP+nTzLQN+3Q0THZ4IViyZD1ldQyd0ru3ngHcommpg1thYZH+jpk+BANV1hCTQt2hNJF0K+e2wDBw3EnSUnXOnkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlxHZzva; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dcd0431f00so25523125ad.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 23:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536153; x=1710140953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+zV8At+QIPEvAtFzvpCNXCNPoGBw00JoBxGHFZGbLM=;
        b=UlxHZzva85PRbTojHEfpKtD8RvQci8xwjEnaAygal5I55X6jFdMZq6wZ0tPn+5BoRv
         aNCDGBqPNqZeGfcDhg4bAvV8j1gwiYPUACaVt8m9Gnz261oBuIUYve1zDgaGxdqs7uNk
         U6QFurIjHkLwYp0CrtddNEvI+os878SsM4+x6i3VJCwz4GkJf+lyN+6mmfCnlus27dmw
         /MxKZ5o2nKNeS+GJZN73cZY/0evEGGx2yrAHgJhTxUojvWNVqDuytgKXZYXa9bZvONGk
         ggOHGk6na7jKYQR5cwJL2Iz5m6knyho0vkf+ceL+sy6e8RLK7VCUHjc6P2YTPbFeg4bZ
         meWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536153; x=1710140953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+zV8At+QIPEvAtFzvpCNXCNPoGBw00JoBxGHFZGbLM=;
        b=htW/Ug3wFi6tSQTwAmdPOwCHifrIQ6FzFRAv7gnFCnKCtuSKRSZ4w16/5nlX0lu5l2
         G8HigeLUl99Hv2ZhgFblfv+qE80pLK8R6G5e6KAAWdAPYsekficLRGlNYYTsngkZ+rQR
         Y4SBlUlVBDXiejtb/ej/CTjWncnabmmhH2wSeDjjuoTi+WDIOZzD+dGrKYACA6K/icJQ
         3B/weMw7vDdl6LP2kPb6xo4Buar1WKna3D1ldcorPEsF0WxX5xeYk2zZalA4nInf3nI0
         GEqxxSaaedk19pdR4ktgOlqgUqVZXWNfhVuPBIaRI4YB+tjreYEHHXMpQP5pMqdWESzA
         HGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWw0ikWgD+EdZZnZVJchOo6bbyqQksfgiKl314wFRqqCans1IRPIuUr4wWwiDkWKe2UdOVrbur5ai5f1xfZ95eyNpCbd3SfPSI=
X-Gm-Message-State: AOJu0Yy2VTi/6XNt88Tldr9sL2G20DoblCOxSoLfd3fe6GXIXx9rM6Mh
	rdadutfmNVvRONTV1Fd64HKzihQ0IbAwo17lhyzhrDReR3LDwnGT+MSrBq6hXDc=
X-Google-Smtp-Source: AGHT+IHJxyX4EeUgRH56ZjuDB4mXGWhmRD9wMKWNWNmFh6nkhr1j78oSpV79A3Sr6Lv0eXlAvlfSaw==
X-Received: by 2002:a17:902:a385:b0:1dc:afd1:9c37 with SMTP id x5-20020a170902a38500b001dcafd19c37mr6968268pla.24.1709536153521;
        Sun, 03 Mar 2024 23:09:13 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001dbab519ce7sm7689865pll.212.2024.03.03.23.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:09:13 -0800 (PST)
Date: Mon, 4 Mar 2024 12:39:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: sudeep.holla@arm.com, Sibi Sankar <quic_sibis@quicinc.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, morten.rasmussen@arm.com,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V2 0/3] cpufreq: scmi: Add boost frequency support
Message-ID: <20240304070911.lr6uye75ykz4gilj@vireshk-i7>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227173434.650334-1-quic_sibis@quicinc.com>

On 27-02-24, 23:04, Sibi Sankar wrote:
> This series adds provision to mark dynamic opps as boost capable and adds
> boost frequency support to the scmi cpufreq driver.
> 
> V2:
> * Document boost flag. [Lukasz]
> * Remove sustained_freq check. [Pierre]
> * simplify sustained_freq_khz calculation. [Sudeep]
> * fix default per-policy state. [Dietmar]
> * fix typo in commit message in patch 3.
> 
> Depends on:
> per-policy boost: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240227165309.620422-1-quic_sibis@quicinc.com/

It doesn't really depend on it, just that there is a bug that needs to
be fixed.

> Sibi Sankar (3):
>   OPP: Extend dev_pm_opp_data with turbo support
>   firmware: arm_scmi: Add support for marking certain frequencies as
>     boost
>   cpufreq: scmi: Enable boost support

Sudeep,

Can I apply this series ?

-- 
viresh

