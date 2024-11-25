Return-Path: <linux-pm+bounces-18028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D769D7C19
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 08:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2117E2819C8
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C0613D26B;
	Mon, 25 Nov 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4F44KL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D182876
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520599; cv=none; b=O72ZCfUQ38RCJyahrvW7Ci5L3gjP2JJFclxKyQLrudm2Ta9iyMkXNJvjttAucUFGjhK4EVGfQh39qv+My4K4HfZNn3UDYDQwNyAHlAv38vH7Vx1U4aaTltrWvEekwyNhwSk6DZZgNk9KfaLSUBOwpkpA5qVFBEiTexIQfdnyKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520599; c=relaxed/simple;
	bh=E0EKKqn7X4HTlWFZ1RxoZYl6EvAZKtpWxHcFzX64slw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Aq6x7Xtr7QjgSWAZdYr77thPOIpIyGUcIS/e06lZB4UD1CQXAmQ4g1Q7IUwB6Dchtjb1wXW/A0pxzWw2kStBW5u5Iy+ouK7lR+OIj67aj6oT6bAaxIxvjlTQMaZ2+pFsORb9BCi/tqsSyqxjBR73aX7arjg1Est0Rtv/oTcS5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4F44KL2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732520596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VvwUNFaTuVcahX+3INE57hm+fmWfSpcYW0Rn94m+wI=;
	b=d4F44KL2Vj07f8qXpjFg4ap+9oI2DnLey3OzjPQ4N/D2QyQa2HHnkJe4D342rAkwPJ06hS
	8+8D9HBeTDJwK7UYDbx1y0jggov3beAuSOaQLukFCMCcGHJD5qwaA2ZZFaddkousAfIFaR
	OyBfXGrvkY+5fd3JpIuuaCbEsnwPYZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-cKXefjKkNZeMZWVfS-Huag-1; Mon, 25 Nov 2024 02:43:13 -0500
X-MC-Unique: cKXefjKkNZeMZWVfS-Huag-1
X-Mimecast-MFC-AGG-ID: cKXefjKkNZeMZWVfS-Huag
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38236ca50d5so2116768f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 23:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732520592; x=1733125392;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1VvwUNFaTuVcahX+3INE57hm+fmWfSpcYW0Rn94m+wI=;
        b=Gc03Zkdiv/MHwyNx7WCmPe+DgJGYEbBxuhstEh2jzG7+PyU5acam/yh+M0PR2xjz9M
         cab+ECs69AseG8A6c/iTLF1oNFsyyppYDIGnd8/3JyQ9V0D6vhYEyO2/Fgb+FtaIdPee
         Ce8uLVhe+JKooNMCDlE/duAN3lfUv1bpzIroI14S8jwrEMlQ37+4FEEsLbTvY7IX5m7q
         ySOUhSmqio+x1AknHIjIbcUkN7sErtrITge8v7m1m0kEha35so+tN/9A2J5jt0uAq9BU
         gZzbqiruB/jjnSVcV93sBLJ4iwWd1cky+ZPAYuhNRtxQoOKrICvqBIftfgB/AXu4eFLn
         RPpw==
X-Forwarded-Encrypted: i=1; AJvYcCU4HWnkXctJuYNmuq9PwGZgbPcXROyzPm5WsFn7wyCAYIDf71xMbIdLPbsFqOOD2hg5Al54MYl6JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7ojXZGwl6moE8fMcUvpeoUVQAScw8SJ7TBOk1l2B2+CQvDg8
	4kAcKUIPclRrMbVss7/b7N+hHRqObPY67moLs9puVPQqqwSppJHd4OtosId+mEBt+i25lkg1s7y
	M7rViIRLCuMfd/nK2OHQx1zwCpFyuz7QWPS1zWUl13SSAYg699dKqSTYQ
X-Gm-Gg: ASbGncs2dZDfzRge9b66MulGsLN+aji1JwlnrN+kWs0aRNSzxQJhBcYEsfCPF4evgrl
	FVgTeRm5YbftdyYN+BB/hvg8RdsfHXbLvSHaazUhituYRDSNOb5Ji22eqkoDDlHVqclNLXu5TZ4
	RgL4sHF5cNIrPH90hfKsd9O26Hy6S0P30grjxbzuVoR4/nNBrwRGoX1XEGijlO9V+zaZU4GG3Hk
	3F4PNAC0irUixMs/DxSZIm3l56ahawkheu0fx9CU12XQe/ndqgD6kLy23VJsVyayqEeUYvmf20a
	SePLVXHH5DZRdYUNKFuv7+yepGcFuqn4
X-Received: by 2002:a05:6000:389:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38260b581b7mr9918907f8f.21.1732520592729;
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx5A7vcD3V9v7iPsizhu7sDsVC8+0jvon1/O5y5Xd5c24P1QMFk3VXW80fXXQ/RkFDKtko2g==
X-Received: by 2002:a05:6000:389:b0:382:37b2:87ee with SMTP id ffacd0b85a97d-38260b581b7mr9918898f8f.21.1732520592439;
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9be8sm9592069f8f.24.2024.11.24.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 23:43:12 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Radu Rendec <rrendec@redhat.com>, robh@kernel.org, arnd@linaro.org,
 linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, javier@dowhile0.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 andreas@kemnade.info
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241125051504.nvw4lzr4emi2vpf7@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
 <20241125051504.nvw4lzr4emi2vpf7@vireshk-i7>
Date: Mon, 25 Nov 2024 08:43:11 +0100
Message-ID: <87a5dn4v3k.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

Hello Viresh,

> On 22-11-24, 18:09, Javier Martinez Canillas wrote:
>> Agreed with this. Likely (1) is the easiest path and (2) would make the
>> driver more aligned with the rest of the kernel (that have a list of OF
>> device IDs to autoload / match instead of some custom logic).
>> 
>> But I guess that (2) would be riskier, since not adding a platform that
>> uses v2 will cause a regression.
>
> I am inclined to go with (1) here and have applied a patch from Andreas Kemnade,
> which he sent sometime back. I have used your commit log though, since it was
> more descriptive.
>

That sounds good to me, thanks for solving this issue!

> -- 
> viresh
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


