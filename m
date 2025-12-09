Return-Path: <linux-pm+bounces-39329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8ECAEF4B
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 06:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF0E303D6B7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5028E2FD694;
	Tue,  9 Dec 2025 05:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/PG37q/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B51D86DC
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765258765; cv=none; b=e/4ykbfDevWQaBLwERlYWEwXoakZMuihxFuHEG4dZxXp3biyqDbNcXxmLhu78KNQl++PIfEiBgLkjVfZxSoxy8z2dP+gM3VbFNRQl1EsMdVDJFpclYzCzlyT/ANB7QkqRgiZz9jRdfqsUl+6XKBrsBcpYHquIQj0swfU0MQhCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765258765; c=relaxed/simple;
	bh=TDpxiwIQtWqUSTIOls5U6ycE5noSolkH6Nju68f1DeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDX8Jurt1SGbxFy5eCHhgcNmQKzyVdGPazqtsM5nxXu7NYf1Pbkk3/NyZraih/6odFAmqTDzAiG02jgTwOj2dpq+CUSdkt7Fh3g+F3NFCcf1O+p9IG4Y3HW2Mna8Wb+4kdu1mRMy4VudTZF1b6WlC/2PREDafo92rJ1rWj+Gx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/PG37q/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29806bd47b5so31054825ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 21:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765258763; x=1765863563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QEqxDU0dfsIcFs6PXU/AsyG0511d3r4gqu2CYVDqZZo=;
        b=O/PG37q/3ttjRGnpqVQ0Qx/1KniPVC/qJ0dr4lYABMoJ3ff+T0SyXa2H+kmzvWhA+s
         Xa0HUduYO1No8skXLL29cFRekrBdIwtBjwr4noElruz9FqXYS2AY5Ldyx6P6OBXqzi0Q
         jKhr3qnMhxt7g9Lt8VbAguvDGp+VX6MKpsaO/uxJ6osrvhyPXb4y/FH1XhJIkaPFY4wS
         0jbBqFCpeoE4pdERgkEACWxDe6LLyttb56jrzCkZQgTEOm5K3fw5XYVkPd8K5PJY/q4b
         H6/qF7lYE1ngGt7mTkBvVl6p0dBQdcCsrc/SSAllyngafeHa0eG9fFpBaiY1iZcotHC/
         bHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765258763; x=1765863563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEqxDU0dfsIcFs6PXU/AsyG0511d3r4gqu2CYVDqZZo=;
        b=vFWZRMW9qfnFIt6dnOwjhgQHDQNnBlSPmR6HJuTIeBgvhsSh8egDks/xn0ZgIhOZIc
         TFNBe6ooi41M+OJvq2D3vfGLSLUbDCwjAJc0zuRdbm6DGCZ3N7QwviljOj3Rr0SPnqJq
         texPJ/8F9gR10xgdahA4YNhVetuwn++FaAaEc+Sg+Ou3pBIgRntkgW2pjruVLhjaEzVs
         1mbUg7eZNv7HQDvUmLHUjz8Xue3dmsDOu+y3AekrlZnA1kGXMzlurJyqSREUHSlQWXm/
         ysGYCjyJDhpuyM2vSfF99JHW/3oiC0SQV1Y+RGo/4Sdp+6T2kr3IXla501FMwd/KpDsw
         WI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUr4PWMBLUtnodCrdlq9iTYMTNKUVmnFRy7joPUK7pAN2kdivl1V/7nbg7Ok2tlxO8XXJ02cBspLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+iHPUvLFYEcbeqGLcKcdfbn3j9gXdfCZZOP31oLDkDaCKJhS
	ecmkvDYccuTBYPyxXuKtwuQOR6tTZ4jdNIhDFTxPrBKXJ6XxNJNt5V+EDYDAcuwFsD4=
X-Gm-Gg: ASbGnctW+KINv4k+qNggp81GyZVl2vOFX/1vKMGPpm4hzhaEiD1cAyLZcttafc8UaXB
	/v1sh21XYKN/KmGxBqmOLLoe7FLDDGslgb2OXq99pz5JLTYVbvb8MbCQqK1FKGBNo+yYgPXxcuw
	Z4z5z4mU3kjz630F06Nw89+EwMgOZOF9Jggq8ZvwSQRVfdgkxfrSfXhTicciZcmWSJqHkY+wKFk
	izCOvPh3yQ7ayF9gqD6+W49zrjwTEvNA95mEKiQ6Y5SNFlyX0hd0ctXa5iaDDexEjZmS/YKgDR4
	qYUEVEMNIsG0QZGueDkezuJWksqweE4pvH6KpnCC56W1uTcoizVWsLi70WzhXOi9pGf/OxNtypS
	rs1tfQWbexbLqLZTIjpLcrBd3ckJTbzboPJWzZwB6lQTtOIiOv1iMxJNpEW1Mb5ukYrumujagkb
	DJDUDM3eOniqw=
X-Google-Smtp-Source: AGHT+IGT3oMcVOs+F6k1LlPLHUsCh5RzpH6dL4N9qgZXqJ+kF+/r8njiQKrM/A9ykOA/khY1iOm5mw==
X-Received: by 2002:a17:902:e94e:b0:29e:1415:df95 with SMTP id d9443c01a7336-29e1415e02fmr63991035ad.51.1765258762675;
        Mon, 08 Dec 2025 21:39:22 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f179sm143271875ad.64.2025.12.08.21.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 21:39:22 -0800 (PST)
Date: Tue, 9 Dec 2025 11:09:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Michal Simek <michal.simek@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, Pavel Hronek <hronepa1@fel.cvut.cz>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: arm:xlnx,zynq-7000: missing CPU freq in /sys after
 6.18.0-g8f7aa3d3c732 from 2025-12-04
Message-ID: <rx7rom2s4elunr2zntnoodlxtcw3qbaxmol534u2gndavlsue7@v5zu3k5l236j>
References: <202512081758.02574.pisa@fel.cvut.cz>
 <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz>

Fix Krzysztof's email address.

On 09-12-25, 11:07, Viresh Kumar wrote:
> On 08-12-25, 17:58, Pavel Pisa wrote:
> > Dear maintainers and developers,
> > 
> > we are running CAN/CAN FD subsystem daily correct function
> > and latency evaluation on Zynq platform with our CAN FD IPs
> > on mainline and RT kernels for years already
> > 
> >   https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing
> > 
> > and we experience problem that attempt to set performance
> > scaling governor though
> > 
> >   /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> >   /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
> > 
> > started to fail on mainline kernels. The last day
> > when setting worked has been 2025-12-04 with
> > 6.18.0-g8f7aa3d3c732 kernel. Then the cpufreq
> > /sys interface seems to be missing.
> > 
> > I have checked boot even with latest DTB and the
> > intreface is missing still. The driver seems to be
> > present
> > 
> >   /sys/bus/platform/drivers/cpufreq-dt
> > 
> > the code builds cpufreq-dt-platdev.o which contains
> > "xlnx,zynq-7000". The directory
> > 
> >   /sys/devices/system/cpu/cpufreq
> > 
> > is present, but it is empty. The module is present and
> > linked into kernel
> > 
> >   /sys/module/cpufreq
> > 
> > The next config options are set
> > 
> >   CONFIG_CPUFREQ_DT=y
> >   CONFIG_CPUFREQ_DT_PLATDEV=y
> > 
> > The whole kernel configuration is attached.
> > 
> > Please, have you some idea what could be a problem?
> > Is it necessary to update something or is something missing
> > in the device tree?
> > 
> > I can try to bisect to exact commit or add some debugging
> > printks into kernel to obtain more information,
> > but it would take some time. What else do you suggest?
> 
> Try reverting:
> 
> commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")
> 
> Also if you can provide your boot logs, it could be useful. Either the probing
> of the cpufreq driver isn't attempted, or it just fails somewhere now.

-- 
viresh

