Return-Path: <linux-pm+bounces-25616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E95EA9161B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 10:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB405176A53
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4438F22DF94;
	Thu, 17 Apr 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6GoVa5G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64959223323
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877225; cv=none; b=JXVYmCKm2EIiTS68w2SoblJP0sl1yhFSMh/+UBgEtgngeV8UQU3E22CJbTCzNon5/XoqXCIecq1S1oE8vUCSlvpF81yXtkbPaif1yZTwMbXUPdzkdPVhP2LkcuQOQNRmjGUrYQtIjdTonVWkWbYVk1lg/6O+b8o9m1FMkgyTTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877225; c=relaxed/simple;
	bh=oQW7F29atGBld5YpHbUvVkkrHeYES/dxTGRbEkLyYvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5M9ww9m6VK1EhD22ZSodPJMoxoRpij2PXz+cHTqQ0MxSJZIt6+vL4Dw/qO+K0a0cwHR3QqgjT/xZuzisHG5WPIxN3PpLG0H/dNQwoq5ZaUXLN7kemrPd3IhQlQALBfJuRi4r2vE0AwRS9GviMUX+RkXHoINOBx+jn970GbU0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N6GoVa5G; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso7507825ad.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744877221; x=1745482021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbStn/1mMmnWgEwNfLXRh0m0K6lLNoUi7YPIyXHV8Io=;
        b=N6GoVa5GgRHtKOg+65A/d16DuSfFzCPhjYU+xEzMy6acQfPrIJ/pxlJf6rCCITZKnL
         NgFaajcOk9FVWDA9JWQ9fhB7Eq4ZNVJ4qKREa3gq0tKsgKyXE5lO39NgatufJJxfgEIN
         xfykB7SC1pE4aQ73x+UkuBjVERaqTPXxvTTGCDjysMqRLUtEIHSfTnyzSqgiydtYJ3W0
         +5/Rajn4N2VMHRYfqB1nZ1rUcgI90l9DEtLLgrdhRqQ4w9zbPpe9Ao+GEwtk0luRlPY5
         aeMchopLh6ZRub2EWdJRqhSFviYy9AIyWL1YjAUVKlohMOsPtL3bSZ6OCeeyVh4Uux3A
         +klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744877221; x=1745482021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbStn/1mMmnWgEwNfLXRh0m0K6lLNoUi7YPIyXHV8Io=;
        b=BVUSBHKT3ci77jwqmTVK4bqDJuldprs2mVGNaTmr+ERYqctwjCaLCpJur8pg3t+aDE
         6vLRwEU/c0OKYsg9Xns4ckNy7+kYSVWnIJciYOWn3SrXEs2PxA+wTu+IqgbZ2lmFPyUQ
         ikbZZPxyN7KwtFWK1g+v/eEmuMEBAI6hUBAppVa7domJtLh6dLZXSkkD42yTiVccfDj/
         HoTgMI6VnP+QuiJv6iv+N6XHqvwp0agmA04JcaVZpQ8+zZz0A4fBiXUUTcqCJ5I2gddO
         xCQhRo6zAmSkQsoUa1d+XkgNgAN8sylaqwZ0PBnjns7D2gD/UPT8I2sx+11svWcQWONM
         h8BA==
X-Forwarded-Encrypted: i=1; AJvYcCXXwf1GsOGMJcbcJ6vlOglZ1Yzm5mPuIS8QS5DNC7stmzuV9X46848z+KaMlDkyQvawGe7lFNA6+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKZZ1MLm+VfBcZuqexiyxsqdSt2aEmD4qXcZQlfobatekgZ0c
	kXCCgY3bc6GOCBcK5SZh9sIzrrsSaENRgk29XIPqU4UhSZykCnmjEL/+EdamyLU=
X-Gm-Gg: ASbGncudd8sHvB1/ukAtel+kCeB4iUagmQnvLkXDQ0Yo2WeXOiSWhkiROZFp/J+7OBs
	74i4rio5dDi+uyx0URZz9rhBe+WxrGnjRerV7Gr8h+X3rbrmbR62j/gYdvTmbI3AjlipNfIY13S
	Rv+GH8zZEWn2P1PEzSVKz+0uZikOnVv2xiZJO5kQSODkxgslgFemT2v+5i9O5Cti/u6cXz6/vXG
	pLD7Umj8P7UD2zB7wfNwV05WvsqEf/VPxXL8ej6UwrqgfRm8k6q65yVXHN24dAAW2jZmgFMAnix
	rTkLDMg39CYyEW7YCTl1Ur1yNQSMOma5jasrTXHobQ==
X-Google-Smtp-Source: AGHT+IF8kAlRnm7dgvBGiP4dp8lCId2BiMHsLBv02PsMCD5r3qOQ9HE9u6StR0v7aFBT90CEbczcwQ==
X-Received: by 2002:a17:903:41c5:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22c35916c6fmr82576225ad.28.1744877221505;
        Thu, 17 Apr 2025 01:07:01 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11a6sm27376855ad.23.2025.04.17.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:07:01 -0700 (PDT)
Date: Thu, 17 Apr 2025 13:36:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: fix compile-test defaults
Message-ID: <20250417080658.dccdn6luc5ss7dgt@vireshk-i7>
References: <20250417072838.734-1-johan+linaro@kernel.org>
 <f151f848-d337-4bf3-b88d-8a032e843ae1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f151f848-d337-4bf3-b88d-8a032e843ae1@linaro.org>

On 17-04-25, 09:56, Krzysztof Kozlowski wrote:
> On 17/04/2025 09:28, Johan Hovold wrote:
> > Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> > enabled compile testing of most Arm CPUFreq drivers but left the
> > existing default values unchanged so that many drivers are enabled by
> > default whenever COMPILE_TEST is selected.
> > 
> > This specifically results in the S3C64XX CPUFreq driver being enabled
> > and initialised during boot of non-S3C64XX platforms with the following
> > error logged:
> > 
> > 	cpufreq: Unable to obtain ARMCLK: -2
> > 
> > Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
> > testing") recently fixed most of the default values, but two entries
> > were missed and two could use a more specific default condition.
> > 
> > Fix the default values for drivers that can be compile tested and that
> > should be enabled by default when not compile testing.
> > 
> > Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> 
> I would not consider original code a bug, but a feature, however I am
> fine with other choice as well, so to close discussion from my side:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied. Thanks.

-- 
viresh

