Return-Path: <linux-pm+bounces-39978-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F343CCE5246
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E7530000B8
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B22D0C68;
	Sun, 28 Dec 2025 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw2zkI4j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97097238C0A
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766937150; cv=none; b=LgPyXEVVqqu8qs96nFmViRiRLUiX84hjJ25bGzd2MIYh+4w8kEFYNnPDZ9H7MWdeHm7ZulrsBPNiLDQtny3Qd2DPx1BqGJZrY4csBCtjHYwFj34p2tHmCG+LQSmdiDwjoHNHsBR0wFYrNHYalJnidZ9+d/jM57Khuu3fHAsR0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766937150; c=relaxed/simple;
	bh=D3BTfGhNOkQpqAmddCimtqSQsZGfaRXzELFY2GPfEfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyoSHEs9kmuwk7Bovi6VAva4IIpQ2jIMRNWwPzM9RSM5GM0WC44alDLHgwG2HrN4yeLxcTXL7U/tjbtW4Yeep5244eDOtepUarNNRiTUfE8au7TldtvxETfX9y1HuACCQiZuzoyoU6a2DANf8ymD6Zzh9GyZMkhc9e0RwBUdmGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rw2zkI4j; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37fdb95971eso62415871fa.1
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 07:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766937147; x=1767541947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+9QH88NqvmLnutFwACcoA8/TeI8goSVe8os1YBVNYs=;
        b=rw2zkI4jfEddmoBalnLLwto4BlVHKCYbobPLRWfpGLrzbHOKxQTUal5fsLoz8vzvVK
         PZ748vJf4WPRhPH7b1+QDwCLKjce5UHM1PEzm9nw06g33h9Cb2yXFgTt3S5uJI/bvLnF
         lnd4Xdv70RUpGUD6r/ED+kIiz+xdwEIGiIC/LMDJY/ErF4awoPEOcBK8p+Tes55djzV3
         ntXIJUoIfJXP/4TeES2qrxIoIDNl+Emc7rBc/GJ3eCgeCZEI3t07kUMAydmnWes+1HBX
         qbA3+WFHOgrwsqx+SF8Xmw1I5UvgbWfQ6zzW55vsUl/Z4h8eq4dMJyxYCAi/SsSvFhLe
         eMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766937147; x=1767541947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+9QH88NqvmLnutFwACcoA8/TeI8goSVe8os1YBVNYs=;
        b=GNWE0iT9wegZhub5LAGngZkOkpZRzD0bMLvN1Iw/3gMaOGybCjgvh5Ae1p8QgOTjJO
         2Ei0Bj+1ccWwjVJMT1EdHiLc/xurJMAZfr0iubbDp574jzIq0UolESTYe1T6LipWoGab
         KiB2s2lvdCuxD8UCg6KUIkvTVIU7zFYQPV32UWdaFZsRVpqlGFYjPx47BysRlz/Xg4GF
         kMvsHcrqFxJ1/vQeZqKcx2Ps+3kZh2L/JMfW1GLB1XCxiJXJiPoZ7Oi8AF+lnrJGAgaP
         AhxRy6uEkUIcI7MJv+aYF0JFrWSJqHwfYjnpK3LvDVMg0HiKcAT+c5PkWtY4xzs0nCvD
         kwlw==
X-Gm-Message-State: AOJu0YxaZOGu6uZ2Z8vemsI65DQKwcjRmwwcte03A+HyK6Z8p6I5tzyN
	GLEGIUWHHFlC/kt7v95zVha3+X7nMiNhPG5g9zPc8PCegFrYuHGVp7gN5G26dyoUG9G0OIExzan
	qBkkktgzH9AHdTL5M7tfRTvQPmAGlI+GlxDJCEOGpvg==
X-Gm-Gg: AY/fxX7Tu+LUz8DVhuu796yFkliLmZQ9bG94tFjCQTCIS2B8O6oHHXvK/GVmWICEs+i
	9Y47GMO9+owaLBfinHCJJ4LJAm/MjQj2YyjEW8vvAUUGxvswxGsq6pa4VftV0To7+q5d22P9Wqf
	TYzZ30MVQr4eig9O4oLXcj9WN5mjZPx/BnBIS6h4JbNEo0TRRPt6rSErip78jBS7jcY+APqaVYZ
	+DUiusKRWzonvAhTUAcmn/kj6oskQnOF3P9ICJI2MhJPQ3K7oEy/Mth1X5RbEOk90RRmXcL
X-Google-Smtp-Source: AGHT+IHkboUhz4MpFcpNPDucRKiTHtZPvcmMptE2abcSzKMsio0k3sUvHCyVOcpxKLrVsJM+XYlzAWlOXcuRJ/vvJWQ=
X-Received: by 2002:a2e:a595:0:b0:37a:2d23:9e78 with SMTP id
 38308e7fff4ca-381215acfb3mr98463761fa.11.1766937146670; Sun, 28 Dec 2025
 07:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <14387202.RDIVbhacDa@rafael.j.wysocki>
In-Reply-To: <14387202.RDIVbhacDa@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 28 Dec 2025 16:51:50 +0100
X-Gm-Features: AQt7F2piw3weLBheqDGUNczU_ZyGiVLTVUujPuNFAh-asX1hc4qMOZNyOhIXzmk
Message-ID: <CAPDyKFrh0WHN0q2RU3POYLc7mkTdgg-8e8r7KVVmtd3MrUvWJg@mail.gmail.com>
Subject: Re: [PATCH v1 23/23] PM: runtime: Change pm_runtime_put() return type
 to void
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Dec 2025 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The primary role of pm_runtime_put() is to decrement the runtime PM
> usage counter of the given device.  It always does that regardless of
> the value returned by it later.
>
> In addition, if the runtime PM usage counter after decrementation turns
> out to be zero, a work item is queued up to check whether or not the
> device can be suspended.  This is not guaranteed to succeed though and
> even if it is successful, the device may still not be suspended going
> forward.
>
> There are multiple valid reasons why pm_runtime_put() may not decide to
> queue up the work item mentioned above, including, but not limited to,
> the case when user space has written "on" to the device's runtime PM
> "control" file in sysfs.  In all of those cases, pm_runtime_put()
> returns a negative error code (even though the device's runtime PM
> usage counter has been successfully decremented by it) which is very
> confusing.  In fact, its return value should only be used for debug
> purposes and care should be taken when doing it even in that case.
>
> Accordingly, to avoid the confusion mentioned above, change the return
> type of pm_runtime_put() to void.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Nice cleanup!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  include/linux/pm_runtime.h |   16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -545,22 +545,10 @@ static inline int pm_runtime_resume_and_
>   *
>   * Decrement the runtime PM usage counter of @dev and if it turns out to be
>   * equal to 0, queue up a work item for @dev like in pm_request_idle().
> - *
> - * Return:
> - * * 1: Success. Usage counter dropped to zero, but device was already suspended.
> - * * 0: Success.
> - * * -EINVAL: Runtime PM error.
> - * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage counter became non-zero or Runtime PM status
> - *            change ongoing.
> - * * -EBUSY: Runtime PM child_count non-zero.
> - * * -EPERM: Device PM QoS resume latency 0.
> - * * -EINPROGRESS: Suspend already in progress.
> - * * -ENOSYS: CONFIG_PM not enabled.
>   */
> -static inline int pm_runtime_put(struct device *dev)
> +static inline void pm_runtime_put(struct device *dev)
>  {
> -       return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
> +       __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
>  }
>
>  /**
>
>
>

