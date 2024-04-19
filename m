Return-Path: <linux-pm+bounces-6700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4FD8AA898
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB4028433B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0FF2E3F2;
	Fri, 19 Apr 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/owIBop"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB12206B
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509187; cv=none; b=DSQ5vuItDxI/eOeVNV+YTaUjwy6LabYd3Hz2oP5iyapvn9VWIg/6IYC3ZYcb0AKYa0Ry7ndRc+VY4IEfUyrVeIGqPEaQyXUPvi0mgDaNvKNf8qVOZcWBHVndMTw2WRnYkhsb9TwCXphMmye+rFeu02OTbOOVVV9H3QzO5IA5Efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509187; c=relaxed/simple;
	bh=u0HF41IZwgeTJDQsNauxGr+WavqSpst5cZbgaiLVR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8BsLSmvQoLK5Cw0xCGSUCauNpFyH1QUXtMOUrSJA+7BxRCKV+id/B8MmiMoyLMKwmhVXLPTPkFrxwC5ogkSc0GbKaFbKwmB+3hcNxW6UqliHCJRkK0rQr7Bsda++wvcU37jnnbrs68XR1awXJSGFWQR2HwB6cIu9JdjhpRFmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/owIBop; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso1590120b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713509184; x=1714113984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=W/owIBopzOD7dPCYJ2XOmjBD+ELNGChEk1AqkXfin1HLtKqfC9Ro/ZUoMfdXCX641z
         N5qEgS77nHwatWXeSznhLBAayJa1oFLHEdmQcbM47Le2Pj9jGun9voRXQdxgATb41XCZ
         C8TMcsf065eZSJfUnVDgH9tfKWim8b84uKJNfi/IjpcJJyjUWIKof5KtcA6E4WKI3Wj4
         7QO649qpB260BNFADZdchzMGoMtTwMj80tLpIV0lQ3bL7UZQSkoporjWDEP3FIwsBQKQ
         4s21A7NzVh32IltPh3eCde9z5ECph6UrD16Np+cIOaHtYbUW+UXWI0jH4uVf3j+65hSJ
         XQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713509184; x=1714113984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=v+HHO9grzLAfab4XOSVs0aHfJLarwMFGEDXU+KGmAA7ShenSy5nefnloISU3Gqc9q/
         8eOVhXgnXoRfOv6/qUwY/EBJlwHzW0IFvQlgntAsiEkplSxk/glvWSBxCcgeQ789LGNf
         Af8AYqCpGQVcr4Yn5+J+LnjpU2REShSYfcp+bSgz6Z3Yuirl7sZFoEMyOb7aESipsYcq
         r55PsHcTVL45b6uLRNyFyXUnaEd5TUUP1D8sLnbSmbYo4DgvYweGwxQ/nre+v2FiL3Sv
         uz/g61pAtMZOB8voG0E1oQvdfOqHk3T4LjiEXj/NR2HshKjCd6QRaOGLN4hQgyf3pIxy
         zPmA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDmTd2E/i2xACMnrk0J1DoNI9fqSxyiI/HD+b2Fa2LWLHF4OTNQvmPykrCdhzalxjxRW08UFbtKloZpyWXuhBlQYNGLWgexM=
X-Gm-Message-State: AOJu0Ywo0TSaVu1qmU5osSXCC6hSvSRZh+16v0+PBc/xVycjARO92Wy1
	Q7PthyX9D8pX3BL4lcfVqsyKWI96qHOoNrO6914z8BMPUAVQa80J5kZgxdJcsqs=
X-Google-Smtp-Source: AGHT+IHJdn4XMlV/f4j2y8kUhBIVDEUhNZSWwAvnrLM5ep4RxiBIGPPNC3RiVuCyXUa4Dmo0aTOsfA==
X-Received: by 2002:a05:6a20:5653:b0:1a7:bc31:933b with SMTP id is19-20020a056a20565300b001a7bc31933bmr1492291pzc.47.1713509184494;
        Thu, 18 Apr 2024 23:46:24 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm905236pga.91.2024.04.18.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:46:23 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:16:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cpufreq: conform test to TAP
Message-ID: <20240419064621.a4qcqt6ck26te6up@vireshk-i7>
References: <20240418153146.2095230-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418153146.2095230-1-usama.anjum@collabora.com>

On 18-04-24, 20:31, Muhammad Usama Anjum wrote:
> This test outputs lots of information. Let's conform the core part of
> the test to TAP and leave the information printing messages for now.
> Include ktap_helpers.sh to print conformed logs. Use KSFT_* macros to
> return the correct exit code for the kselftest framework and CIs to
> understand the exit status.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh |  3 +-
>  tools/testing/selftests/cpufreq/main.sh    | 47 +++++++++++++---------
>  tools/testing/selftests/cpufreq/module.sh  |  6 +--
>  3 files changed, 31 insertions(+), 25 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

