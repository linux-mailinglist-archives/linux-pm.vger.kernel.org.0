Return-Path: <linux-pm+bounces-20951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC7A1C38F
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6779E3A5157
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F3320897B;
	Sat, 25 Jan 2025 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSNeCLH9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD61E87B
	for <linux-pm@vger.kernel.org>; Sat, 25 Jan 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737810300; cv=none; b=Nfk5OL+XPQCCuXGwN/NxPK9CYNBAXxWwRXqdrh3+tmojJ/n+TBNXKqZZGfOf961uZ1HJQSY3uGNjR5925gTk6M0z7Q/r+R6WvviJwuQjlisaWPefP2weq+x0D3fdGzbQv40Xohd8YjkWZh+yxDlOYrgFhW6fUz2vWGDIoYSJE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737810300; c=relaxed/simple;
	bh=fF0AHv0s3S+dBIkriG8rfycx3SWlry9DEa+eTSo1+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ew1Aefv9xZeHY9zQhfyJ38e/1dbzCvWYtiMm5QL8YlQET6z1p5EqOaQWkzyEt9jRBlgxAhJpIxggpkEmeZ3WMLR5688ZfUusLHYe2YcolHEZrfb5nXOvzgH1GaTnUeiAUMNtsQVRqhOzc/OAAdh7WwNFPQuYOi/Bky9Pf3iOtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSNeCLH9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so19099925e9.1
        for <linux-pm@vger.kernel.org>; Sat, 25 Jan 2025 05:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737810296; x=1738415096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=YSNeCLH94OQrQQEBh9OAQx6JHTw5s+Zb3FJ14YicrfjPIvSc90IfCDXZwp8Lb+sD6N
         L1OlKwdS6S+U2pEwNT3YDf9kFYkgqUCqQ+uHT1BwSAJFtUV+WIb08mEzjPq2X6mIx+UR
         uencJywzXu7pCrGvqU7Ln30xzlppJjs8DUbDG2E5qJDy01aZ8B2gAE0Z92HXMP4zNlFU
         JgY4wPtDIK06fLiqN2QMYCx3Tr2XYSmUylH3H2B8rO4OUgyPgLjxc3mor6cWsMRVbWP6
         Q73YJC9A8Ra+voAn6KXWcs6b8ktLjQvtZfeoIbB4Kd14vG0MyuoeUw7C+6AOzVFqd52T
         kuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737810296; x=1738415096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=wPX02GpA4QS7zTnqn9eC1DMwptcB2vwVbYbLKyfPq11/Q+fqdWxm5fwBYmCzV7/gza
         +m7sY4enfFGQNfEybc38Y0icoaKOEVWNErigVT28lPqtvKa2VJBGNPykdgA6QESmqM9T
         wMS1gcIDKdT4SiCu+QsAXGUqNBIqucqrKgLusdIJbT+wniUY0WMbdehxpYc2agpJ9S3P
         UmOdBq9XJxWfyc2hOO9WIOOSPy5ZG7ALbEVGnwG0N80hGWIO7zc+zOlK2yjMQPr4EytB
         ww7lpzrRxi0gmE4p7ThCPWggmj1qI9IW+AlqG8m4khbyvaSi387GbVLkjIookMa/ySUN
         nXvA==
X-Forwarded-Encrypted: i=1; AJvYcCV6HNcG87i9YRMYXwawgl0B6Vx32peDfxlqsfyety0bZL2Bnmffhox1sjXwm+AUCXCriYD/6mJJgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuG3UwLTtncI+gByYKTRaT7Fuqr8FGXbzjBMA/rLRLScnG9P20
	4AdppMObkL/jVu49x1+n8PvjdTsrGjPwEagL/qh9tVOanG6lKaWB4c8jOZtu5ab53m8MQjcWko1
	O
X-Gm-Gg: ASbGncvtiMKP0tAUByyf4rrvsb6Y9BlHT5fjGgufhULSka/RHIpgkQ+iFQgXpHGXtlW
	6nI7mi4Z+ve1DI4nzkuXcyhDpmd9lV4062kMPmuAxkE9VdkybUfl+KzvYXO2hWfJgti6f6fRwxA
	K3ybDQGQ0gz2+CNlLzW9bQW9/gDOliXkSDXdF1FSBhZcSXTTlMEKngoVuLZGQnLEMxUy+z1gTq4
	GMcT0W9p8zuX+W+FCXofPiFtuYM0qZpO3WiGykKkgzkXHz9xXKgOCNnZ2KFgP+Wi0T5Ikgxw3t/
	ENQABwzdkg==
X-Google-Smtp-Source: AGHT+IEaOVgzG6Qtw0HZT4iWc73ce/VOtEgJOp3dSxRw2PlxaNl3qvT2R0XWbkFb0aXpK24XwpEiwA==
X-Received: by 2002:a05:600c:5486:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-438913cae48mr287922225e9.9.1737810296292;
        Sat, 25 Jan 2025 05:04:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d3dbcsm61443145e9.40.2025.01.25.05.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 05:04:55 -0800 (PST)
Date: Sat, 25 Jan 2025 16:04:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zuoqian <zuoqian113@gmail.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	viresh.kumar@linaro.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scpi: compare kHz instead of Hz
Message-ID: <967a5b3e-197a-4b90-9fe3-9b10782d677c@stanley.mountain>
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


