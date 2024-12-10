Return-Path: <linux-pm+bounces-18910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A759EB293
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 15:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F87F188B131
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D971AA1D4;
	Tue, 10 Dec 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXSG+Dbv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA90319DF9A
	for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839344; cv=none; b=rZ42KKrS5ZhqYtwOPie7KZ0Vzss4AN7K7jtDu5ouAtYwctkuGmCuJ8NaFkwecx9e8OIJaxGWbIrbWfE0+nHMoEzJu4NAOvwa+o9Ev78zw/rMImKpuioh5YnLvlJOc+h+T8xVJ8w0QYQ8Jyen3rqEHvQFrkZ7I/xiZyj+9H7A4LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839344; c=relaxed/simple;
	bh=hxA6gBaMkz3RlMJmyAs2nKGpJbjXZ6crp1ZPlqHZMI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2ifj8iyHtnE76aDrlyDkSSGtCdmRK5nXzdINLtf78IaiE+iKrHBM2VRqR88rcds8IIGbwjWTIEDmG+3rX52AfwaWzbX+bzzNwo/AoHeQ2se9Qyyc5ciAaaVEHs1jdcn1rReWfEFIBFNyGUSpIfzGpWM4faRJG+f3QZRmYWwGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NXSG+Dbv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e38938a55e7so5379912276.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2024 06:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839342; x=1734444142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGDjDmjaarnv2LRhR9yI+0cQdlmEnitFOz5zg2VCDVs=;
        b=NXSG+DbvlGbeRq+cDPie+nLVsvP3HRyhJYo8MoTZAZuns8MCUZDR5DoRbN5FwSp0zL
         RIbcgeIPfqSzkuSekFpf6sX3bi/1SJr1QPekxr1IQUaRp18QbAOwXKmbgGl8ugBeJpg/
         SaQHKOhZzT197Itfh6+ruCELjbFpdLjgWgZDsss0z93dMtrPuTH44IRIoun12tyvf0qU
         zTQp3UZ+xCZhDBFrog1peDToCMI4yHZyc8na7ap4utyeXTwhn2ih+pIAdNiRYLgIOD9d
         xjX3dYOuh3paZ4ucOJwcoavlJ+iTrS5htuvaD33YlQ3sGuWALdSu5+5rJ3OE0kWfeLJO
         HBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839342; x=1734444142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGDjDmjaarnv2LRhR9yI+0cQdlmEnitFOz5zg2VCDVs=;
        b=U3+ZyTdAgFpPC4e6x/BAV8l9QH0Jg7FsieQJo7C4A7TyzGKyV5oXpn0TqkcysAt7Bz
         NsW8zmikgnvq3b7E/cmBD+8d3gKOWJqTtcLl8Fsktcy5+/xMOdbhXzZRBIdDkfjNK/Jd
         gbsV6ouFYwiOCd4fZdlXOqzJdgN4M7W5Be78C4V2c5TkjByJwjFoAAk/dwpcQwAYD0/R
         PSjMnKLeGTlxSUsG06ADwQ5qAY7MRMILwvnrZmuZ5s5mTvSYW7e7cQS9DbTR3f2/hmiz
         JhdGbTbgCHq33yS0U6h598zFgaYmjYoPz4+xQvUniJM9UDjuH9oD2FrBFrrooGz3hrsc
         WENg==
X-Forwarded-Encrypted: i=1; AJvYcCWlET1ZHnzwOmoWqd/sL+T1M5Tjml3bN0dLdOguEbL7uzad4iBg3MjIGqWt57JJh06SB+rXt740yw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+al0JW7wm4lBUEUqnYNccQgk8C8/E4turEJ4yMgpbzhATTeaC
	0iJupx3V7h7Qufs+Wln/k1bXZ+/W3boSTF5iv10d8T1hUGPwVRvXa1RWX9dIZVlDY1pn41Xq1MK
	aLFlqsX+kXglQukgmM6DH0ocHIE0CjxjNEpXFZ51LQfFjmGPD
X-Gm-Gg: ASbGncsE3jIJbtQRHCc7DwCTwySu2uhZTft/HOW8zNDUFgKKMtnDg063N+xpH7Im2Iu
	mL8Mlu2zGTSFg5xXjH+3Srr5hcFxit+GX5VOn
X-Google-Smtp-Source: AGHT+IF8ODQGXD7UsXZFA398vKfIghJH5HEH16ZMuk46OLFWyEc2exSc7lgWOZZzJyVLz5Z9bI2L9Yz5Wky7WJz7dOY=
X-Received: by 2002:a05:6902:200b:b0:e39:82aa:45a8 with SMTP id
 3f1490d57ef6-e3a0b527cbcmr14579056276.53.1733839341586; Tue, 10 Dec 2024
 06:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119141827.1.I6129b16ec6b558efc1707861db87e55bf7022f62@changeid>
In-Reply-To: <20241119141827.1.I6129b16ec6b558efc1707861db87e55bf7022f62@changeid>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:01:45 +0100
Message-ID: <CAPDyKFoghwa+x0Dc8RfWWdDpP-mD4qUBZKpXjy4pK0mQwf6gGg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with OSI
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 14:21, Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> Set GENPD_FLAG_ACTIVE_WAKEUP flag for domain psci cpuidle when OSI
> is activated, then when a device is set as the wake-up source using
> device_set_wakeup_path, the PSCI power domain could be retained to allow
> so that the associated device can wake up the system.
>
> With this flag, for S2IDLE system-wide suspend, the wake-up path is
> managed in each device driver and is tested in the power framework:
> a PSCI domain is only turned off when GENPD_FLAG_ACTIVE_WAKEUP is enabled
> and the associated device is not in the wake-up path, so PSCI CPUIdle
> selects the lowest level in the PSCI topology according to the wake-up
> path.
>
> This patch is a preliminary step to support PSCI OSI on the STM32MP25
> platform with the D1 domain (power-domain-cluster) for the A35 cortex
> cluster and for the associated peripherals including EXTI1 which manages
> the wake-up interrupts for domain D1.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Makes perfect sense to me - so applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 146f97068022..5fb5228f6bf1 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -72,6 +72,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>          */
>         if (use_osi) {
>                 pd->power_off = psci_pd_power_off;
> +               pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                         pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>         } else {
> --
> 2.25.1
>

