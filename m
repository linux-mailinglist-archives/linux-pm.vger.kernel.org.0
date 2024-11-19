Return-Path: <linux-pm+bounces-17739-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25D9D20A5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 08:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452851F22861
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 07:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BB14D6F6;
	Tue, 19 Nov 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ko/N0OuS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382598F64
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732000859; cv=none; b=GYbQ/5X7KwR3QG35fzb3oslIHVXBLFRpCfxMByy+U/UCpw51nuVyhz0oqVbo9EGlWVFAKfdXEpMzqK0/Z1uEqPmRO8RpNx0sr79upaAyaf2FPOnQQ12PB7GUMDe0NuvfuGV7kxn4K0RRmaWqxkTwSYc/95S0g0KEwgwR1adhzFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732000859; c=relaxed/simple;
	bh=2ZRr8lALMYsUscyG4KsvCTt+Xlf5CiXCpJlgFF+C5aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGIpEev6MfBvaErq9wKgfePz2EdfMpCtMYhVNgjYP8QqAPXiePnCbpCNQOVqOI/iEl3CNWGv4Mm9FxdwU/LKSbj4j0jfQ26eRZ3+6OBt1cl+jrjEJEGKFkialikzjqljT8x9gduAVaFxs2kzbD8HvWPPdZFr4qHuGD11oDy+GK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ko/N0OuS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211fcadd960so19307205ad.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 23:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732000857; x=1732605657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM2DbdcBJnN3qKXVDRxCLMGFBcFG1GzjS2MYPCy6reQ=;
        b=Ko/N0OuSSDrjM/AJ0WeY121ZI7sk44BpsZ4Eu8rPqBTPuovgiaz7q2uMazLtpNv3rN
         dri6+F7xyoEXHem/di33aM4+5q5iF4peFM5i7YzkQuxdk78B4VD5TOGgyi+p7J6rrLph
         5aKKiGV+nacwsfVlpAje2HLdJhez0YNCSa5jcssi8d7Fch1GsfmcqfGjeS6vnjcekVUx
         SC/7mebL0QSYCXDLNOp2xUQEpWKwDuONWbhic4mLJutbnOmPlGX7yqkhxaD8cqhjJJNF
         oqKW59/r9WfCMb0LqKny/vXjZ8HAPPBwws1DOp5sfbKXzC+r+zUTi0YnTA+d93dPA/Vx
         F63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732000857; x=1732605657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM2DbdcBJnN3qKXVDRxCLMGFBcFG1GzjS2MYPCy6reQ=;
        b=YJU0j+lZqF+ByOLx2k/iuhDa0o9cIo+Zmpql0750g/Q4vqASjcbOKE6Un66tQZfmh8
         vatgGgc/be3ZQ/efY7a6ozoYFFxmbammOxpz6i2fXeF6UCEUDj2qxe0ZIdssHnVNOTqA
         8x8ngUy/HjwXgvtbsXuA7JAJVoBzvXJ+Bp62NcTDgxywVSc1oujBwhpXatTL/GqgvJJw
         fKJuzCLW8qtBnT8sKXS1eM3uTtG+SceSqGcAXOVZ3CeY8UuzXNaYj99uxPIe5cSph/fy
         83y2ZEt/0IT2MTQEwWztvzBljA4IhRPS4lv0D2VXr3zN6ouZYQ2perHodOpl4Hiy/z3y
         cnMw==
X-Forwarded-Encrypted: i=1; AJvYcCVhBeX7ZfT4aIt0xdpVJtoBBTULbNbYznKGMAJIVEYoftm8/axY1Gbla81EUWnMM/L3uz4wZEVW4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12KoXYfo4Wt4HTilEsD3QyXXmoX3cL9FoPIUnAAkdtaZuT6/b
	T0QTGtNBQ0HFVbhNbYb8asX/BLlqWERjLs3OqgB66tPTgpjNQTvIjfFNOoAY89w=
X-Google-Smtp-Source: AGHT+IGR+vAfGVcJemjaVnegG111dXVq7+O24f0BoUFqcpMOC+i8E0jKMN2vIPgmwiDuA+Iuxo17GQ==
X-Received: by 2002:a17:903:2308:b0:20c:c086:4998 with SMTP id d9443c01a7336-211d0edca49mr192758285ad.55.1732000857612;
        Mon, 18 Nov 2024 23:20:57 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f348e4sm66491205ad.125.2024.11.18.23.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 23:20:57 -0800 (PST)
Date: Tue, 19 Nov 2024 12:50:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: Re: [PATCH v2] cpufreq: airoha: Add EN7581 Cpufreq SMC driver
Message-ID: <20241119072054.64hi347qmv7ng3un@vireshk-i7>
References: <20241017190809.16942-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017190809.16942-1-ansuelsmth@gmail.com>

On 17-10-24, 21:07, Christian Marangi wrote:
> Add simple Cpufreq driver for Airoha EN7581 SoC that control CPU
> frequency scaling with SMC APIs.
> 
> All CPU share the same frequency and can't be controlled independently.
> Current shared CPU frequency is returned by the related SMC command.
> 
> Add SoC compatible to cpufreq-dt-plat block list as a dedicated cpufreq
> driver is needed with OPP v2 nodes declared in DTS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Fix kernel bot error with missing slab.h and bitfield.h header
> - Limit COMPILE_TEST to ARM64 due to smcc 1.2

Hi,

Sorry for delay at my side to review this driver.

Now that I looked at it, I don't see a lot of special stuff happening in the
driver. There are many other platforms with similar situation. What we have done
for all them, which rely on OPPs coming from DT, is to add a clk for the CPUs
and do all this magically smcc stuff from clk_get_rate() and clk_set_rate().
Once that is done, you should be able to reuse the cpufreq-dt driver as is.

So a CPU clk is the only missing thing in your case I guess.

-- 
viresh

