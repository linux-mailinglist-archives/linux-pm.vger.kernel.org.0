Return-Path: <linux-pm+bounces-38515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DAC82D6B
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 026FB34BCBC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA32E764D;
	Mon, 24 Nov 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nU8y+sSB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400B274FF5
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027806; cv=none; b=Aq2gap4klnoolj3lpcgW4G/BzdiEFBZDplqypq1EsMwAni0PtY2cHMG78Lnhad1UBqp4IiASbU7Tnj+5FMW+rMFPz8xgkUJTYuYTjdfP+U5TouSys2UYV3Vuen5gdJCQddYhF3YybHHPzh6g8S9xpgrFcjcuZDCyzpskHhffByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027806; c=relaxed/simple;
	bh=0GnmzL1h+o+i6liQM8CrD5wefDSntZzSj6EmuSiJ1W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BljoVNOctMN496LUpvzqgu2jzHk5yHsvN4ItFywbTgiLKyaRYpoGIQ2UTtH60SVGRsPRCaRJvVtIUVi+U6bAyj3RGAJZU4Eo5QB3AqcPUG2eI+Rlk4ZdWI95LG23MQTyp3/wXIG72jaUkfFWHp0o3m62E5Xp4k3EO712PYC5pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nU8y+sSB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29555b384acso60737705ad.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764027804; x=1764632604; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZmcA4UnelU4Uyw0x3ObtizJbVjq478wDgpSBsRd5ww=;
        b=nU8y+sSBRa+lbatcQ3hd1WggsGdcnjdm8W+1man3lBhQj0uSg4QhxCLijq2ssMZCAu
         H128FoUOZ6LJdWWmHJ7I87vbqqY+FsMcKCnw/AO+d/rZ6kJLcdOGte5gSmfCI5DWhBqZ
         qU4qpq8cMr43c9qCiIkR7Mkrv+QiUIbjkdxiGCHyT1GiYZuPDz+KE7xdD9vc2Co9mHoX
         dSsTEO+qRnUj02oDTUpTv0KoDxBOIfaduCAWRYUzZuWHkVaf6AYX2TXzaNNeGEkWRCfm
         ZHeOBT9DfZtVmCs+XFk1nrXr9/Imvp3nb7rDDSW8Ve5Nje88ROluPQq7xiUXTGJ6jtqw
         YkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027804; x=1764632604;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZmcA4UnelU4Uyw0x3ObtizJbVjq478wDgpSBsRd5ww=;
        b=FPYhBCeFxqu4umUdPGnOKxf6mtOsRvTVfMbAvI3USBtxXZ10mlIayqB+b+qIn1RRJm
         51+lKaAe8mZpfz4EZCv3v/XjfxNZ3XQ5IfHoFQ0uT526x5B/lbqUMDc+BPxv7VHZMBkx
         ZnxLnRNi4C2oxTXep/Ss3IErOExVlbRHASetja53gWm7FpTTvhKgJpTjthMNiN/LB6Y0
         KYRxFpAO7OJ75Wr5J1WOao/GlJK7cohK28H8Nfbd2zQldyzPo3CoN1hCUB13RIHUxkjy
         fGreLk42ovgGSoZ1yfXkmf11GoCjVoM2tyZgliiWV+jfeGleOOpoU9T5JnNqFTmlDy2f
         yibg==
X-Forwarded-Encrypted: i=1; AJvYcCV2DmaGiVhknczuE8Pd3yk1aJcaWM8kHc+AB2Y6UFbpF02P4wbqbJNrOw+8fzSxPEA8ub3/fhCp2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wbkqEaDXZjlswVjVU+tZFWLR86XlA+stEX8nU4+K2KdgvGJy
	sazIX9z1dfuFAISH7y6vic/VK14w6ZSVvljSbBaE9EXUAFDsmnhuwIOmWGUVbgpZXSY=
X-Gm-Gg: ASbGncuf3qrqrPky/zcAEwMv8/+EIPTPHQfvT+EZ2RvjkvSy8QWwjRkYaeXAqz6nvEk
	XHlS5gFsP4F3a0m0SPvRbUCiVgTdrgQ4v0h5iZs8BssKlRkDYR8vC81w/v41eJcchUsRgplZbnR
	lbbHnqiQUmpPf0BlDJ3l8XHDOI6jXarPu0eA7TRptWrsPP11vqcGRInkcOTbn4pJ3HXGC5ix4bk
	Ns0YqN100qwEc8M6kBpIOXKe7EVK0RHOjMxwaGwVoTLpxELH4LOnpNHjO7HVynVN1Ij9hFJOsS5
	/GhFHrZxuqCzgGQ3DfCvzAUtyN04+pvKTBcoRAeiPlXbPciXSFk70RgZoKrZW0k+rcr2sd6tnE4
	yNhFBZaYkiYu3xs7PwHpGfXdSt9jgFNBlB//fdoD2h1Ewh0f0LWsdrO+MCKI29z7kXUf6V0nUMl
	LX1KJYWMIj
X-Google-Smtp-Source: AGHT+IE54CeWlou3/0N68zXQXCzYzwWHDBiUc3WLIubNGQV4eRxSRlBCwcc7GxKyinH/+t/QnN92Og==
X-Received: by 2002:a17:902:d4ca:b0:294:f6e2:cea1 with SMTP id d9443c01a7336-29b6c571f11mr147367015ad.38.1764027803678;
        Mon, 24 Nov 2025 15:43:23 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b29b1c2sm145545895ad.81.2025.11.24.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:43:23 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra
 <peterz@infradead.org>, Pavel Machek <pavel@kernel.org>, Len Brown
 <len.brown@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Maulik
 Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>,
 Dhruva Gole <d-gole@ti.com>, Deepti Jaggi <quic_djaggi@quicinc.com>, Ulf
 Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PM: QoS: Introduce a CPU system wakeup QoS limit
 for s2idle
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
Date: Mon, 24 Nov 2025 15:43:22 -0800
Message-ID: <7hcy57dmjp.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Changes in v3:
> 	- Take new the new QoS limit into account for cpuidle too (Rafael).
> 	- Add a new Kconfig for the new QoS interface (Rafael)
> 	- Improved the documentation (Dhruva) 
> 	- Clarified commit messages and added acks.
>
> Changes in v2:
> 	- Limit the new QoS to CPUs  and make some corresponding renaming of the
> 	functions along with name of the device node for user space.
> 	- Make sure we deal with the failure/error path correctly when there are
> 	no state available for s2idle.
> 	- Add documentation.
>
> Some platforms supports multiple low power states for CPUs that can be used
> when entering system-wide suspend and s2idle in particular. Currently we are
> always selecting the deepest possible state for the CPUs, which can break the
> system wakeup latency constraint that may be required for a use case.
>
> Therefore, this series suggests to introduce a new interface for user space,
> allowing us to specify the CPU system wakeup QoS limit. The QoS limit is then
> taken into account when selecting a suitable low power state for s2idle/cpuidle.

Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>

