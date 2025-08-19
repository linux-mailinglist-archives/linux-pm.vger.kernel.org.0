Return-Path: <linux-pm+bounces-32623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26177B2BFB0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A575A34C4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B072322DC5;
	Tue, 19 Aug 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/YUhGLy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9D322DA6
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601171; cv=none; b=Q4VY9VgWUoQFyCJY3YXx09meWvoCdETZUAc7hNmua8RUPpUhzGC6ZWRnlqSQWpf0lYXPJaNAN8GoMv6vsDaAKE3RgbKo+vIobFCNd/QFjhhEUOBv81vaKJBTKGX46aLQJTm468SBjkgO4l0rSzbN7ZbAznKXPpEx9j30qMhMOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601171; c=relaxed/simple;
	bh=KAFaqRiE6nzXS+LKL0cxSMUTq0bKgyZWfJfaI8+aWgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRrJExtZcs4IbKk8ngJ90DadQprEdD/SutXIeYKmfWahvYs9Z0GuCYm+cAlmWLFO9VW0DRY7P8uQvSgKHl6yC7LjwZOboVIVl8ZEp5ILi6Z99cRAlaMCcdLDXjjSwoTIRpKMSmKxqCpdEIPg8V8pR+i64cel5TLpNCee5Q+FtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/YUhGLy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32326789e06so4177918a91.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 03:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755601168; x=1756205968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=arvz5a88RitPQG105vjnEOt0s5EixJi2rrNrtSKMeTQ=;
        b=S/YUhGLyC5EPRg1nckw192LHJQoUVOQQ3oC8afbIyJU+iYtken5CTdLRf/ARPutVkV
         oVcQ0LEaHY8+mqwXswzdIK0IU6hnyr9Uuwbei31nu/6gVdzsJCjHQQF/nud30P1/EQQL
         RPLq0tUJWhj0CvsyiJTdg5GRbR4NWgrlsOQLwMqBRRRVoJlJMgRFTsXmuPIGPGyjISYp
         p5DF7X6sCd3YSR6y97wJqaohwRh7mI5Txo3nCbQT38I+2tAVgaaLJMMHlLJnTfPmwp3z
         brMsPznj4zJRbuFYTtBJ7LhO3f+NWzRzTldiVJbW4o0gQhBCTp7aUhBwK9dvWrTMjaV2
         /bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601168; x=1756205968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arvz5a88RitPQG105vjnEOt0s5EixJi2rrNrtSKMeTQ=;
        b=YyfmEITb38SjUwviW0LqUryxbiDqjeGuuFy0yRIkiz+6RzNuAmCnjBsDvhSG0gGtgl
         U7ipi575BXY/qG1YHE8mXs2HapSxhNS7UsGo+Ktl2q1u6kkJqEuLjmvD/eTMbXS2KDqI
         LUgXo0dO+9WXN2dBMZUYOfp0uMEQLmJ05JwgVYlQ1ovfo2AMgRaHVvP2PVZn5xEBadwq
         nLS5+hIgsXJP0lZ4VFBW8TPfKDoO+CIfCbt5Lo8h55rtQ2fNTCIn5LK0RToKGgMFqm/V
         kaMwxyMG4BQzNQDvRHS0d/DLOL/ww8FQmBrtf1sgPrH/zBnOyBb+n6sJxMXO/7rpO3OQ
         KjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn5l7IzfrCpOfGqGOp4uzacuVbOCIceXuQzKuJf29D0ik0gvu/8VbXGPXsPTWrIsHk8qhz7pi5Cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUiOjahEwGUM8MmeyzxOVqZVp3l41OAhgexhaVFXZwcgqkuK+S
	fSZBMciTaZ7xd9jSNwo1ya9wiYYVAlJcoa4gUtc8daqddkL5vov9dLfcyEvUPAFEjkc=
X-Gm-Gg: ASbGncvbr+x22wrdXJCi9t26RcnrWIsP2O8AdmSSH3beBWJBtT6V03Ki4y2cAR6iY2t
	gmPWSNL9Kg9JG9AIZmmEl2I/oD2Fp1tZIvyqixFf49ViOxFYqRQPbqXPbIdVhIz5N0vbwNvTbSI
	PTj5UUIBHiYwovtagR0vMAbiJcktKbHqdRw/NZmW32QOOgc8UCCokZGdLpJJfmQqa4oHxjxErIv
	ACwOkwvwvNUZj9b5EGoEAaxr0Y8NtlGSkfStlewdN5JdtBXqKjAPF+UYqMbdMHsCc/RX3vYYQDF
	EEe6m80wdoeWYzJptRqBeLdqfslG1kUKSuZbSg+JAZiCmy/bYdTrh6SAIF3jY/WLW0Fjp9CLaEU
	8xxgRedP8vQ2I30lWhOy7HkCd
X-Google-Smtp-Source: AGHT+IHZoCtAtUE9HPPvtVCogZL2oXfh8LTo7Si136WDL03ocU1HMP0CuJhciYnWxrYvmwQ36mxi5w==
X-Received: by 2002:a17:90b:1f83:b0:31e:d9f0:9b92 with SMTP id 98e67ed59e1d1-3245e594983mr2850492a91.14.1755601168469;
        Tue, 19 Aug 2025 03:59:28 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b475028dcffsm2716166a12.23.2025.08.19.03.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:59:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:29:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: simplify cpufreq_set_policy() interface
Message-ID: <20250819105925.34o5f5attd5rboh7@vireshk-i7>
References: <20250819103940.342774-1-zhangzihuan@kylinos.cn>
 <20250819103940.342774-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103940.342774-3-zhangzihuan@kylinos.cn>

On 19-08-25, 18:39, Zihuan Zhang wrote:
>  static int cpufreq_set_policy(struct cpufreq_policy *policy,
> -			      struct cpufreq_governor *new_gov,
> -			      unsigned int new_pol);
> +			      struct cpufreq_governor *new_gov);

A driver will either support the policy or the governor. If we are
keeping `new_gov` around, I don't see why `new_pol` should be dropped.
And changing the policy for a `setpolicy` driver should happen from
within cpufreq_set_policy() instead of the caller. Also there is at
least one case (verify()) where we may end up returning early, before
changing the policy.

-- 
viresh

