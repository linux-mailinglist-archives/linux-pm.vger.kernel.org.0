Return-Path: <linux-pm+bounces-25770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F1FA94C4F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918EF189177F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 05:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260B2586C4;
	Mon, 21 Apr 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKDoXdIs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019B2561DA
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745215093; cv=none; b=FYk1d7FGUSH/SrSYLYz2z5XCH10HiLMRjcU12Uu6bXqjN7E++AkRP9NkhF9nhyEFjB4rmjYyZ1psXpTa1hRE/L2jhR7Zrbrq/5t/Pd1uotOGEX/gAaUdQl4FsdkCgyZmiKfiS6ocPCUmIRdqQHUt2nVJXo/umt1a/iWZVPSQ4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745215093; c=relaxed/simple;
	bh=0oE9OFzMBm6elx/Vv+nqc+vDAozrn/qUS97uTf+6q6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAx2mfrv3vHYitT8i4D2MMGZf4bQ/x4qMtbj4jtP4ZVNylFywCUZhxefkFTqqajpSmRb3bHgI5ndhl33dRqeqrMGBNUA3lY3lQQObW52S/rWKVcOzAHQdpdQu+dBq8Fy9IyAbaMG2XsijusMCT2MELFgQ9swYY8KOmAc5wLHvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MKDoXdIs; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2295d78b433so41288705ad.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2025 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745215091; x=1745819891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLmdl7omBx5GUZwRrka7MxtVvlDhA5e/J1YjqrIrVUg=;
        b=MKDoXdIsQ1VB6ETQu/bPkabWkgNWJ6Ume9P/jhVUNbsigmRkzTDMje+Pz/qUnBjXcD
         ETt4lxINFb7g0/i7Ym3h/3/FCfwIdwRyw/eWPphqmxzPZ7qdTDEHIlpACXWez1LhOxXr
         ITMPNsK0wIrj+pVgiJHFnYS4CBeUWtXx+032nHqKbvQNnM6M43Jer74S92pSTTv4j97u
         nEpl/Yo93aaHFZ8YsEvM9v9d0q/pO8a7WAPiIDrgAr9aHyjQTfnVA4KhSz4f0EIl/fJ4
         8tCK9yNf5l6A80bQaO6gLUfIksfiNHEt+rOyrCTJLMuGJSjQr2QZcC9px/id9cdfqp42
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745215091; x=1745819891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLmdl7omBx5GUZwRrka7MxtVvlDhA5e/J1YjqrIrVUg=;
        b=j+QEU0wvptoHsZE4bUO53tfipaTpsUpu8fUxRY4Z77cpGmgXSMx8CpH6k1bc7WIOv6
         jWPqRqtw27EqrY9dGvlN3+T0jkblHqymfbOYxav2DSbQKu0M8xw/1T2HTRJMamWmblyS
         Q6wkvWFfE9g474BQw5HgautW1Q9LFqDhmoGjg4E4jY6rZpnEHBW6E31GpMyGa+fl24Zt
         ftA6UHpLBlBcjxRtrRnyWeu2JBNJQoF1j2gWibaydK2DgByfkh7Bh0V/FYPDy7IyRdtB
         vkxkziWjG2XrPiLWTnyTgNzHzsHSYueG0Gqok7XDhVewC3YnxsCwyD2n12oz8lNNB9pg
         Mfqg==
X-Forwarded-Encrypted: i=1; AJvYcCUt+hhaYMOtR4k7RdgG+DGJBXWedirM6kmH6aSx1JaU7PalSMZ5Hi6oS+PkZYR5yrH0DyJA7JuI9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0chhdIyW7EEqUlLDQyNlJJS0cxTXfn858kBEZQwkwFgcdaMG
	6a0HrloreRNqEj1O3EBFXq6TG7SIhzda63meO0dz1fzlB/PPgq4XSyGO+tde8fM=
X-Gm-Gg: ASbGncvIK2BXvtoMq41ZmvDXDlKYzdMGSWARlWXxW2yvL7+/iwD840UiffIQeZfB387
	2BjfXxGSmgN5wdW9Jfv6qAzv0bZTBrUsND7Yjy5ARzFza5TGZ1ZSchddJPIsw4VhdevVHlDDhJy
	LAWoGL4GzugvhlG9chRCe/iDIyIdyci7lRxKCDsAfkoPXkJ5MT0vZG+q2cdiASLUyH7h1Qu+E21
	D//V/EdKwI/41VMb10Ea0r6uNJ7CYcaV/+D6LXvXDdkaVpMsG9zhrftu/zAzJ3ojMgfHzT70ceB
	t4NJOG/PKchhpthXdHfEbtVjLmLlIJL5+RN7HO4GaQ==
X-Google-Smtp-Source: AGHT+IEY2InDe48NWBZXkKiVwylBh/Sebrc/gEQikw0+OigWJcxwoh1jfGHofwTjCk/KfkXpgp7nXg==
X-Received: by 2002:a17:903:fad:b0:224:c47:cb7 with SMTP id d9443c01a7336-22c530b581fmr160942705ad.0.1745215090770;
        Sun, 20 Apr 2025 22:58:10 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbc9dsm57311465ad.227.2025.04.20.22.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 22:58:10 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:28:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: tegra124: Allow building as a module
Message-ID: <20250421055808.ol4bu3vsdphv4pvs@vireshk-i7>
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
 <20250420-tegra124-cpufreq-v1-2-0a47fe126091@gmail.com>
 <20250421054555.oavale3xjqlrc236@vireshk-i7>
 <CALHNRZ-1XfbN8nOt33Ktsq9z2cjGL8AiWKEZwigXO6OYd64fFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALHNRZ-1XfbN8nOt33Ktsq9z2cjGL8AiWKEZwigXO6OYd64fFw@mail.gmail.com>

On 21-04-25, 00:52, Aaron Kling wrote:
> lsmod lists the module as "[permanent]" and if I try to rmmod the
> module, the command throws 'device or resource busy'.

Ahh, I thought kernel will give error on double insertion instead. But
it looks like we keep some sort of refcount for the devices registered
by the driver and don't let it unload.

Anyway, if you want it to be a module, then it must unload as well I
guess.

You need to do the reverse of tegra_cpufreq_init() from module_exit to
get it working I guess.

-- 
viresh

