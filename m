Return-Path: <linux-pm+bounces-39146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7778C9DA69
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 04:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80ECE348CC0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA123EAB5;
	Wed,  3 Dec 2025 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0yVelLG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12022FE0E
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732851; cv=none; b=OgDCI6TOeE4r+CpMygdgBV7TQ8emfpBR0mPgpQFFf7ZYoYjd35yRiJJBZlGQoMoHZOHI+p31pWauZJbMDTv2KeibCc4p6tE4erETsihG5G/dQPELA1KTrRQub+rZoO4XLvxJCfuIikseYBU2RKL57zFbrygqk5oAyo0dHA3g0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732851; c=relaxed/simple;
	bh=JRvYcBYR986xL8Q9QurkwlNYv9CajrHMpz9RKcFgCp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCKavbkUrbluNV+XdtqUPwD1ANH75zCp+9USNn679DwfzymK5iKy16TdapcpjdaKl4uJdGzlqazGXIExkbiJfvF4m3JT7h9m5OUwnBMlRZR2K/g0iYnOVKfyc+IDIbjodNqQwLXihS2XIaXQ/fOV4FUI1VhWbwb3V27ufERsV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0yVelLG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc1f6dfeb3dso3704418a12.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 19:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732849; x=1765337649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrypMwcN4TiTIMcIjUFPxlrx91p/QDVVVhJWJD6ny4I=;
        b=B0yVelLGk1Leg8UDV/KpdMPlLF49FdiQQPblZbzH/9q/RFgtCTQSJCU5v1v+FzumeB
         sN9sZNKjmhTb6McYjJ8imzKu8a2zBAww7kVTjL6ywLl2uSe8FFez1MOeq9fuvaZWdTm6
         Xoj5Uk4rbtcNbyRTikKyWbW2eOh5fMxCbFzM02kXNF/B7RFS3oUcEZUQVEjM/+KDD/Kp
         cOudgezhlB8ksrO9jAaUkwFlxThHgkZEaeOGabohMTcB9Or/yQXg5Hq60cpZ7XANr2wF
         rpfMtgwVikoJFcUBl1Ic8HfNSUkONX5h47jfpwrU9zKdesfaTknJ1eD3DQgn2KJwJ63J
         OaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732849; x=1765337649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YrypMwcN4TiTIMcIjUFPxlrx91p/QDVVVhJWJD6ny4I=;
        b=mQMX9NFJ4nM5gAY9i1xmjulSpIFyGIb7A8WuPHHjSS7Gy5MuzS/e0q0RmAAkr4sas6
         c/lCnSILoQnz0RnpAGsCUvN+iNNon8VvL2EfjYVIbzMnJraTC4R6YIg6NoXiQWeI8kQr
         vsQSTt+sB9KSv0XmoY7wAH0FzEpxhbg/yVHZG3XpNWc7iK0QEOUObr2nLBhOZPDJY1b9
         lUEVG0mrbfNTh9BOkeaz8X9yD5WcdiC12pnJCefOh7/nPT/xgiDjni8lPI9SOCwFBvcf
         2IGpurzsTf59Ms9JuPeBwXLxiIrAkuXllIRbgVgZRdlE5pHK/eC9pLHtaYq64DLbYhuI
         VvFg==
X-Forwarded-Encrypted: i=1; AJvYcCWiVgyx7FzN93rQ8MOjPB/au8ZpbicZbviK3UytQGloecjl2O4FJsnXS20OqBoRrWDw1ws6PJ2brA==@vger.kernel.org
X-Gm-Message-State: AOJu0YynqFx2Z3lF2Wgkd7lVd6LuSIBPPttixjbzGKqYjViRD44TTVnV
	L/vYr0vyLjnHfGgMBL9mb7LC644uzun7Sw56UW6ZYfZzULv7+RNRtzkU
X-Gm-Gg: ASbGncv/FTs/BdyRVoIRbZpsIzQgP1+rTINYZQjL7OoBQ5EhMFKx2bKgBEYzNlA0jkg
	/q1YOzAuxPhxJMP4GJuxyZGMUtzk+tliijluCwJvmnb+qlsa/uNxunbIU1kJBWPeOHJQ1DetZ1b
	nY9upthBsWTNWfQQChX+JIgkdVVZYqrSLrx/QC/l5bcseMVTrpBUYMpoxTkC4m/tiHeB3mbRSYy
	sYMfJheHoJNoJzdulOQEx5x41LMmrieOn0vU7gapl2zqDP3B7ayY9pzyWOMFX2252Drn9NQ+YOf
	8474cWfO69FTP1BCRRzBoKiRjmsekHlorWs7exbJ8HK+/mXLMlFhJboj5sSzW7blbf6cj/Zs1wn
	FAozsbr5RBR9aqvzXHpzN1reQ6Hg9ejIBe7zlo3jgJT/mtlf4+zx7DzEjSHfqrENt2hqx5agqQs
	Yo/JuHSNGiHk5lOyxOZhHc0ok=
X-Google-Smtp-Source: AGHT+IHb2Bm444wTR/SyhoFk/OdfrkP+670oMUjj/BL8tdpSmodPv0u+GrGuSHULggAy1sTlh5P04w==
X-Received: by 2002:a05:7022:f415:b0:11b:9386:a38b with SMTP id a92af1059eb24-11df0c4c8c4mr768810c88.46.1764732849328;
        Tue, 02 Dec 2025 19:34:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm92986328c88.2.2025.12.02.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 2 Dec 2025 19:34:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Subject: Re: [PATCH 1/3] PM: runtime: Stop checking pm_runtime_barrier()
 return code
Message-ID: <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>

On Tue, Dec 02, 2025 at 11:30:24AM -0800, Brian Norris wrote:
> Apparently this test is the only code that checks the return code from
> pm_runtime_barrier(), and it turns out that's for good reason -- it's
> inherently racy, and a bad idea. We're going to make
> pm_runtime_barrier() return void, so prepare for that by dropping any
> return code checks.
> 
> This resolves some test failures seen like the following:
> 
> [   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drivers/base/power/runtime-test.c:177
> [   34.559694]     Expected 1 == pm_runtime_barrier(dev), but
> [   34.559694]         pm_runtime_barrier(dev) == 0 (0x0)
> [   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:1
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

With this series on top of v6.18:

Qemu test results:
	total: 610 pass: 610 fail: 0
Unit test results:
	pass: 666898 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

