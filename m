Return-Path: <linux-pm+bounces-39097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64CC9CB93
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 830014E3DB6
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6C2D46B3;
	Tue,  2 Dec 2025 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0dkdeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59A2D3732
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702549; cv=none; b=qHqv15hn1/nV1/AneE6U7JVqqCGgLVVT9j5/W174CZSovvARlaEsuagwrsl56tzgYfxmjUVzggAZDd0AFxPBx98ZJ6wSB5HuTP7z5MuuYo9mLHfU7QlN/GzdvgX5ToK5Y6yZ0u/Bhf/pMIJmOi5Pf3ioox8uKp8hciG60RznvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702549; c=relaxed/simple;
	bh=wQ2Q1bYuGpPDFmUhq9r5xNJXmVin/Q0cttq22S6x+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPd6i2rJRCo1fg2TInk584be4UsHZYbCPHvm0qrR/kBvoRUmy7efQsy92aA/xMqe3ttwOifWuL+qCRVvzaaxoAh2rTOkRkkh2pP5WpfOABCx1jr7S8eYPKnUvkGpkpeNsekGm5PCVRBafDOxR7ckrN4yeK5WPWLENQbbj1lTYxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze0dkdeG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so61023055e9.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764702546; x=1765307346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/dj2hPQG6+B9AxmgFXbvm/Feu7VMS9EdlNKmCT8+Y4=;
        b=Ze0dkdeG1JubEnwRQaUYFp/NYZZlzazUTTotPLJvahkM87xoWpUJ3ECEekWXVT9QW9
         lsAxkAUXtFhOAputq4o7mumNpfffHeWUgIio7M21mOVuevr94O1Z+avM/qOceVqpBftN
         fpj9ChShBlRF4wsNNtk1wa4Mh5wUqC84DnSRYzGztRnLtU/HhcFZ4qRivMpKrz/BxWIe
         nB+E+v39Mj3Q764P/ZlBPz0kdr7Wx12o2CQIixpLC90cUrjd8ObVriSHii5AWVV1NRJA
         u9EY4Y4bElwmMXdVCqoHhZB7xnRV0FaSQNDA3upTscAS9YVANGZKLbaTF7mN2StmcnzX
         Sn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702546; x=1765307346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/dj2hPQG6+B9AxmgFXbvm/Feu7VMS9EdlNKmCT8+Y4=;
        b=phTC7nBwOsO+LwqXHVM6WFHVJLT9Zd77BlQAy6upBfpOeRuO52drZmofvysaPThXTQ
         i7MsLenRW/ff823ngfJlN73MFFF92lt4KIo2M/UI3iV5DFtQfxsJ9R/IR6nHN+9uimPA
         9UykmwxMY8SBgRRTR/beVvFo1ZTUSkKbJ04JOqu3P4zAC+AQ1ZfJxfTWR5AJOQRoeCGw
         YvRm1kAo5bUiv2EQ7QPzW6LUx3gp3MNJMOiPBpFL6SorYdNhdw2KYqMx9wk6POLcdnL+
         1KUbBGJmZqVucFnbN2EMjvdqECwWUWKnx7BPWJ1t7OcMXgxyaZDyCuUpYeHnWU2wcEqv
         y6tA==
X-Forwarded-Encrypted: i=1; AJvYcCVDXjQ3emRxWiKXxVGOXooUkRI99kSYUgYv1LkYm7hRuNbO7m8kqFnI57ag3PrciBu/w2rNBTm0JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72X7aOAmD1ShiUWPBXDX3lPLiCyDUCfACYpWLQGe4E9wjS7GQ
	3XJGmm9B+pL1/0TWPrnrwuO7fjNE1xwFDvnoyONqlAQeJKk//YiAuIJy
X-Gm-Gg: ASbGncv7d6esVO37oyesvS/5keiqBlJixKjN+3W6hT8w4SCd8RcY5s34sr/2Od3BtLL
	kIAoY1mMMrfXNjakA4eeGx6tKwrdxRP11QoQjKOKGgBC5vILsjJ/faA/Wd0YTIZb/EjhXFE2mfy
	ZKbl0XPPZJf9Wba7CIGL8fpjl4UI7TzsxV7vJ30eRvtGe6udWDUt5nc9tvzLhcUnzEvUZexwZbA
	WSoyVPp5/5CG/oegF7fk2+lptCdZrtzYzo20iKQRaV9l89Wuxd2kSc+j6JpuLI8FljnsRXDSTwW
	Nm883ySDuFCmIjRZpfMsd22ZIkt+TytuieguW/31zUcGU4nnNKBxcCIQir3rNRhbpx6KliZ5unZ
	jBUtTO829jQa11nUeAN0Nk7SpDUXASxCaiNnDeF/h4YOma80D+awNdt6Yc/p/NxpfQDiYo9QlAx
	POz2n4+S7IZ+t6MkbTr7PaLTLBq8szHBqS0c4rfDleTJT8CYg1OV4y
X-Google-Smtp-Source: AGHT+IEtzByVDUpfRwdPJhgEZAkt4IcyAqDRpceCKifmprijqsNezKq/3tRdzvxL2j+KRrl1ctujJA==
X-Received: by 2002:a05:600c:8b16:b0:477:9e10:3e63 with SMTP id 5b1f17b1804b1-4792a4c0738mr6652335e9.35.1764702546145;
        Tue, 02 Dec 2025 11:09:06 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792a4bd422sm3406265e9.2.2025.12.02.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:09:05 -0800 (PST)
Date: Tue, 2 Dec 2025 19:09:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Thomas Renninger <trenn@suse.de>, Borislav
 Petkov <bp@suse.de>, Jacob Shin <jacob.shin@amd.com>,
 stable@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: amd_freq_sensitivity: Fix sensitivity clamping
 in amd_powersave_bias_target
Message-ID: <20251202190904.27c9bc06@pumpkin>
In-Reply-To: <20251202124427.418165-2-thorsten.blum@linux.dev>
References: <20251202124427.418165-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 13:44:28 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> The local variable 'sensitivity' was never clamped to 0 or
> POWERSAVE_BIAS_MAX because the return value of clamp() was not used. Fix
> this by assigning the clamped value back to 'sensitivity'.

This actually makes no difference
(assuming od_tuners->powersave_bias <= POWERSAVE_BIAS_MAX).
The only use of 'sensitivity' is the test at the end of the diff.

So I think you could just delete the line.

	David
 
> 
> Cc: stable@vger.kernel.org
> Fixes: 9c5320c8ea8b ("cpufreq: AMD "frequency sensitivity feedback" powersave bias for ondemand governor")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/amd_freq_sensitivity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
> index 13fed4b9e02b..713ccf24c97d 100644
> --- a/drivers/cpufreq/amd_freq_sensitivity.c
> +++ b/drivers/cpufreq/amd_freq_sensitivity.c
> @@ -76,7 +76,7 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
>  	sensitivity = POWERSAVE_BIAS_MAX -
>  		(POWERSAVE_BIAS_MAX * (d_reference - d_actual) / d_reference);
>  
> -	clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
> +	sensitivity = clamp(sensitivity, 0, POWERSAVE_BIAS_MAX);
>  
>  	/* this workload is not CPU bound, so choose a lower freq */
>  	if (sensitivity < od_tuners->powersave_bias) {


