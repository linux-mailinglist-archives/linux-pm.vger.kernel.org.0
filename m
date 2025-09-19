Return-Path: <linux-pm+bounces-35022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6F3B892A0
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71E358355F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634B309EF9;
	Fri, 19 Sep 2025 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQc1KjTX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB08275B12
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279477; cv=none; b=orYRb8EbvTwrj6LQFeeSnOBPBrHN9LtLOuVVvttQjRe8q279jTJGSxolC1De4nmW+z60OGAJHy+xk7NPjtCKXopiWmwGfrk5kTh05l09srli3eowoxVE0uZomHYjwPL6QWo0lfWUUddHOko9h9HaRZK/DCB0Wh5YyziNeDZ6/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279477; c=relaxed/simple;
	bh=dyaK275FFJPRupwFOZJFha2dT0/fk+JjTVNxDnrMlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L41G0GljbAt3MQsPljP9HvyEwbLjiKX0ai76ozUPushcHzL2Y14K8kYPoKDvXL6J34EhxOFDpUGCdLmqLeqGlRHg3do0p/O23cRq7Bya98FjlY+AFpmohDiYDalsStM8YUvgSRe6GZqVE20G174nuQCj3tukoDigicZZkwjzPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQc1KjTX; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea9d7bf38a4so678807276.1
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 03:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758279475; x=1758884275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDlYVh7GTbh+tgCNXodsPOOiwVHg3s+VohI00r8zodg=;
        b=iQc1KjTXf8JoNrSb288v6J2dQSYz6GvN1IkiNl69ZFrWTU0M9B7Bkzj0YoowY9cqID
         zv4Kj7ye3oQr91neZafkuqC6w9E/u7StHPl3qPly/et8m76JdhF9kfXDKGR7XQdbVKQD
         ACAy21unPgvnMQblE/ulpGbANsqSe7wJXmajmyohsHbY7GIf6El7LjX1FTdh5OemO67b
         tVk+L4CXs6e47CZqmTh8NRvyQbvlvPWIX/Gnkube/Cv7Mvf0sDI26MvRjyfNs7TpF6mb
         PJ36codXRLqBlUY2WLQudA6jEU8gotBIOlg/eAsa/ohyVfxRTmcc1jLQ5Hdl7kT7CCPe
         VOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279475; x=1758884275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDlYVh7GTbh+tgCNXodsPOOiwVHg3s+VohI00r8zodg=;
        b=fd6/jOhaqqFl6tRe6m411HPyWGKApNKKZVE3QYwzhJxTa+Fe/JlZfbNwUj6oYDYnZr
         /Cj9xsKbgEvJMvk0cHOIY4iSoQIRuh4aD5feyZtFeOUKoFKEaSSOo2nrFLI/ecBxZHNG
         K8pFOiKktAXIhYWfIPoQx+wypwpSkZrtluQvhFrVMwWMq8ULNruwxJErOVFh4CUm/Z8K
         OghERQRnCV3L8szSSYP8qd1Tbpyq7oACCukpvfdgAm1yS4CoKjpBMFmKK6NyusSwqTqn
         EnnB2owzUO+UpwHcQ/1bNCNw9WZdG4lmmI0dfAdo6w/pO8v6iSrusFIpanypa5ms3Zik
         Anag==
X-Forwarded-Encrypted: i=1; AJvYcCX+rgM0iXNGlbqgbvVnP0B8e/ni1FMaSRLUT1HGpGYLkDhQFmsBzzk5aaIaiYyIhX2TH6kyzMILJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeypdQ9HmARTNjpAEVQPow+KJvxVJx3CCO8JGp5hCT7rcYkAW5
	ySDdlRl+DksMuONSI3G3l1yQUumSr87Z1SU2TFhvxkpj3s1MEIawBANeSArT9QjfAvzMm3ILnjf
	K0SPl2LyDhJyTmrcOLiteyrdrRPdhAgmxaxTeo0bMKg==
X-Gm-Gg: ASbGncsyIoqIwXdD99scumEvlct/lqbVhb1cAX64Zd2a/rT0CuDfEzBeNfefoWkUMPU
	m8Q83oPym3XndBfGljLn5kPvzHhmGXiFbNtBwASX3KoOg3iLZ6Pf1zgX3mHYWCh6DEfXDphtbs0
	JZRqhfMtGp2gi+a3JJgYdp/BK+3e5vLbxVRcvDAN6GK+lXJwGVnT6wNF3OODyPsOzyd7lMaIZpn
	wepIkYs
X-Google-Smtp-Source: AGHT+IErTnWgZxsd2J1EC6Faj4gYfD5qobVd3VLWos0tsTxFU2Dylts0CyodcC1JPhxZlPN7R/LgecNfJDI31clkpQc=
X-Received: by 2002:a53:cf0b:0:b0:5fb:cf0:9151 with SMTP id
 956f58d0204a3-63477703065mr1941255d50.11.1758279474618; Fri, 19 Sep 2025
 03:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918173323.340738-1-uwu@icenowy.me>
In-Reply-To: <20250918173323.340738-1-uwu@icenowy.me>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Sep 2025 12:57:18 +0200
X-Gm-Features: AS18NWDfr4pqweeSDolF_LptT5gjyy5EtVR79t2lNhAD5snr7qdfOv4ibHayFqg
Message-ID: <CAPDyKFrGyDiPZk7BZYAon+xG7S83SPvp59TNMjyXWX7Okhp=Jg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Poweroff/reboot support for TH1520 via AON
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 19:33, Icenowy Zheng <uwu@icenowy.me> wrote:
>
> This patchset tries to add support for poweroff/reboot on T-Head TH1520
> SoC by calling the AON firmware.
>
> The first patch creates an auxiliary driver for this, and the second
> patch makes the driver currently matching thead,th1520-aon create an
> auxiliary device.
>
> Icenowy Zheng (2):
>   driver: reset: th1520-aon: add driver for poweroff/reboot via AON FW
>   pmdomain: thead: create auxiliary device for rebooting
>
>  MAINTAINERS                                |  1 +
>  drivers/pmdomain/thead/th1520-pm-domains.c | 14 ++++
>  drivers/power/reset/Kconfig                |  7 ++
>  drivers/power/reset/Makefile               |  1 +
>  drivers/power/reset/th1520-aon-reboot.c    | 98 ++++++++++++++++++++++
>  5 files changed, 121 insertions(+)
>  create mode 100644 drivers/power/reset/th1520-aon-reboot.c
>

Applied for next, thanks!

Kind regards
Uffe

