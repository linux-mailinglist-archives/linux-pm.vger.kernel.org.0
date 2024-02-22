Return-Path: <linux-pm+bounces-4279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ADA85FCB2
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDD4288008
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3451414F9F6;
	Thu, 22 Feb 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prTh+oj8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162D14C586
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616402; cv=none; b=S46ny/WRAFw1a+BKLICjrmFm4e3Q9R/f5Y8o1TV2aMvGKS3zaIOyvgF9qLcnBOdn8GLBtpJ5DE2/SQyuI9yoCqdQ41ZjfF/gDxVZo6wPEEzapGwnSupdLVwUw6XsLw/OFL+b2wbB0i8iTf1QFGIw3V67laAO5CD8eMPXRfDBj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616402; c=relaxed/simple;
	bh=irUaaTgSHl9McK+IT2Ipld7BjAvthbn+fFnbtiJW/dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOUfecT0Je0pmmlBmM75bKf2tOK1DIAmVPy2Cy4p4u9uC4ICpeMz8plv40hYBvg6BSqoEZ/ab4pVwMSkVjreYW8KfGYUSgYNxiNPgOtO4qCAGasnQDMHEXjO6a5P/KV+YtvzOYuyguU8QAjetXNCgIcIH8d+Rd4JVGU35H390rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prTh+oj8; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so5896073e87.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708616397; x=1709221197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1npCLJELsPSC1JsXp5VaFpN9TsOulzmiEht9MHB0lk=;
        b=prTh+oj83tNb8/rX1g5my1Cv2cx4hoVfk1RyWnVChP8jt0Diog2uFzZDeNQBlpcRHn
         HPbKkYZaBUJWX5vo9k8ay8dW0A1DhGP9PFbuL7iaGv4S6qdWADLvX/aB+T4JtC76HvrE
         OFTxb55rM5Ke1hUpMk/IT1bxs9n+/w/JRqVSF/w9bA3isnW/oifNhomq6uvWWnbQkhU3
         RgY4PNLZ8pNhi785w532Y/9mNcm5zVYmBtVg+dkUFMe48eIHO4ND8yw2gAWk2RTX9r2z
         CruoXDNG5XmOJC30hkNkVR4t4aGAYyZfMVx0JMLUvDS5u/o/KKT7W74lMhMx15P0yGJS
         j1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708616397; x=1709221197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1npCLJELsPSC1JsXp5VaFpN9TsOulzmiEht9MHB0lk=;
        b=mJdP8raFCxh6lzLCpdjiEC17mnOSLdLXI6MDRzpvUrfsW7W8LsIbPHJL3Vvya0WLrk
         q2zoPRZ5fn7JOJnbzVfoLHSeqxDM3X3EVYCaaGMR5mdcw4DtYzYvdbivhnyHcPXGtQd6
         VxRoZcg8ld4qbSgvdJkQrNVfvvRBITEWVdlXNhJ98UkRuTWkswgr3IM9pbxxE+D4Lhgi
         CVO8egcmaIuHbOj54fxJBRACBlMOPOV4sFCKa0dw9Bk3xRUGuYWnt7F/Z06Wqy9eiClo
         gpaoPyYerjzEjuLboashXh1XfmCmQMr8KqR9CRXkT5GrOfvzw5rkY0iMlAwlgIO0GUbx
         F9Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUvGwbyTRuxoGy13yZ8oQQoxpwo2W9xW3CESn8tvpvi7dxuSk2NzzgWmvMzwy7Hs8uE+rZvFUKB19tneWs9a8ZxXrnt+heJFY4=
X-Gm-Message-State: AOJu0YyKvwPT2PuvanEcIFN8A1IIsfJ0C0s+2sPC8zLfgDQmkgHQWiLp
	dKzrz2tMYCZzEnwITdjtTxgfYRRh+4A+1QOw7SUzH8WYutpUcvJpT1Y1nlGwWT0=
X-Google-Smtp-Source: AGHT+IF5oA+zj1hJdLGm59l4SglX5mVSDyz7ZtNxq7Z4/wQ0vArID2KuXJIuLjHr2LPtjtbbTxicyw==
X-Received: by 2002:a05:6512:3d8d:b0:512:be44:656f with SMTP id k13-20020a0565123d8d00b00512be44656fmr8689020lfv.63.1708616397318;
        Thu, 22 Feb 2024 07:39:57 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u11-20020a5d468b000000b0033d4adb3ebbsm14270878wrq.26.2024.02.22.07.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:39:56 -0800 (PST)
Message-ID: <4eda4893-8db5-47f0-8566-ecf379e987c7@linaro.org>
Date: Thu, 22 Feb 2024 16:39:55 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.2 1/6] thermal: core: Store zone trips table in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
 <12406375.O9o76ZdvQC@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12406375.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 14:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code expects thermal zone creators to pass a pointer to a
> writable trips table to thermal_zone_device_register_with_trips() and
> that trips table is then used by the thermal core going forward.
> 
> Consequently, the callers of thermal_zone_device_register_with_trips()
> are required to hold on to the trips table passed to it until the given
> thermal zone is unregistered, at which point the trips table can be
> freed, but at the same time they are not expected to access that table
> directly.  This is both error prone and confusing.
> 
> To address it, turn the trips table pointer in struct thermal_zone_device
> into a flex array (counted by its num_trips field), allocate it during
> thermal zone device allocation and copy the contents of the trips table
> supplied by the zone creator (which can be const now) into it, which
> will allow the callers of thermal_zone_device_register_with_trips() to
> drop their trip tables right after the zone registration.
> 
> This requires the imx thermal driver to be adjusted to store the new
> temperature in its internal trips table in imx_set_trip_temp(), because
> it will be separate from the core's trips table now and it has to be
> explicitly kept in sync with the latter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> 
> v2.1 -> v2.2:
>     * Add missing kfree(trips) to thermal_of_zone_register() (Daniel).

OK for me


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


