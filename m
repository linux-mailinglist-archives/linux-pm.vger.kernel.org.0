Return-Path: <linux-pm+bounces-22080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648AA35DBD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62D7188E3E8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3044263F26;
	Fri, 14 Feb 2025 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHygU2Fw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBFD25A627
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536647; cv=none; b=B+tJ/VbMoA6c3yw6BsihS862i0Rbm5SOCtUMOunZFAZk+j5D8hLNmGmPEyVJWJtg3GrJMYBGDU4Hq1Ogy3CdYCcImapGYtM9txbVjjw6gMB1uk18JGm44LpDcsAKQx7KcIC58/qgQsqFj/dDQhIgBMSlhZKmolYnooSgGOd3Lx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536647; c=relaxed/simple;
	bh=JJ+O3NQc7ZRxc/eAygdOLugfRhN3r8KOEi5bbWBrjKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjWJXm8FsF/kFIbKQBmv8PQTfyvv8HWZYIhHGHHd9WGeLi6HoaZSjXvH/CGeQmu3g4ZQ1HmNRb5asxXtYynj8zB5lT8OeM8LiEd78TodwY59/cn1Mcb1UgQe8pJdhxzM9D4l6m5N7CxSfi20rYoiLRVKYLO0j6EbMPl+/Z2Rn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHygU2Fw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5b296611d1so2637771276.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2025 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739536645; x=1740141445; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PJIeOuHK6HT3LfS+Gyhx912FloyWVeSMjTYMVQ61KWs=;
        b=CHygU2Fw89aAA7PSbeojSR2Ch6baGXb07HTqKIVrBhnRue9KCs+2zbAnzRV15LsssT
         sFNHo4IujZgiMvmlSavmMJZN4ftPtGY8cF3wIBIPoAHsy7z0oR6ltc7bltCDbwJYPRyQ
         zmB8+JjWNBnuKMNKe0iW0Z9fZOmt+AF3ZJ50aqRNyjd3S8yw7mWgjGB7EcwnEG8W4W6M
         rbWJlYPi++YvPZAn8+HBgHqQ4sKFqeJMNqTmxPsy/7tgHA4N73nRjLaJyMTkr6P3y4mj
         qZpq3UXy7imUBL60PhdbyoMo7RlpotjmsTpJHjWdl+na6MFtJan3ulP1aAZERZAUhPOW
         IgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536645; x=1740141445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJIeOuHK6HT3LfS+Gyhx912FloyWVeSMjTYMVQ61KWs=;
        b=DxL+GQwQyG/Hdi1Xs50btGO/hueLxermr7Ew+JIeKujpjLuULDJ0skk2nRuV11UDyD
         aPBzWpNxCFQ/Qg3XxKqaeTMuBVpJCq63G+JJahlztmjjW9jljE055g2+5uNZcltOMM5R
         L4V3q1K6RvDeztbqtuDZwhz8i9G/vzFNRCJwUTPjV6Wcjwr8P/WqxSxqCJJCt15F41dz
         G80OCw502BUfO9i07gEEh/HE3FCI9cS4nZWVc+UI+/FwyUo+Idw8OgVVJAY0VzupFG7o
         oeJcWpk9qflSySdqlyesqrNg7QnrOkHVO7BlU5n58HuWR0GHpDo4gfP+NxUK9eXvMRl/
         0qyg==
X-Forwarded-Encrypted: i=1; AJvYcCUQncS6VTQ7APgxeWYb5WKLY8dt3He3sp8m8omOvns1clYzNgoWgcfRKO6G//1w60NX10mUk8uVHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/4Xhy4WtgR+63s7iaNiL6roUC+Wi26bohrUi1PxdYBeeoTP0y
	UBzHu1eRHqjj3xzZoljmUarVFFV6o7UN/XAXUDmFpGixDMRcAx2DUrZUn0h1Abni6x8JWo4D/mc
	CmWu+/Jycfy6M2RcXHi4/ydw02IhFTvO5aIE4zQ==
X-Gm-Gg: ASbGncvesCn6q20tCoKBWIOO6VvMioqL7pAlzGkdMejx/NpJUZ8ue/BWIrhj31fD9jc
	ypIK1Y6500f6hTWepwn+rrgDoC+Owr+vydCoXZ+MDYMfAXQfATSJjZvNHfImHRqjXmJjw1NM45A
	==
X-Google-Smtp-Source: AGHT+IFFUIbAl5XDVgSjeARoAg42VVByccGOmxG3hSULf8SrcrXGHd+9G5Ugv+8hOXmpTF7lxA8JoAU9tHSD43F9q0M=
X-Received: by 2002:a05:6902:1b08:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5daac7a614mr6387024276.16.1739536644605; Fri, 14 Feb 2025
 04:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214102130.3000-1-johan+linaro@kernel.org>
In-Reply-To: <20250214102130.3000-1-johan+linaro@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 14 Feb 2025 13:36:48 +0100
X-Gm-Features: AWEUYZm-GqVQrKsKGZVAfCbeybEf32Dak5WgakPU21UHnEHfkiCIl9P2xjgmigM
Message-ID: <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 11:21, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The simple-pm-bus driver only enables runtime PM for some buses
> ('simple-pm-bus') yet has started calling pm_runtime_force_suspend() and
> pm_runtime_force_resume() during system suspend unconditionally.
>
> This currently works, but that is not obvious and depends on
> implementation details which may change at some point.
>
> Add dedicated system sleep ops and only call pm_runtime_force_suspend()
> and pm_runtime_force_resume() for buses that use runtime PM to avoid any
> future surprises.
>
> Fixes: c45839309c3d ("drivers: bus: simple-pm-bus: Use clocks")

This doesn't look like it is needed to me. It isn't broken, right?

> Cc: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Seems reasonable to me, but I think we need an ack from Geert here too.

Anyway, feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/bus/simple-pm-bus.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index 5dea31769f9a..d8e029e7e53f 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> +static int simple_pm_bus_suspend(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_suspend(dev);
> +}
> +
> +static int simple_pm_bus_resume(struct device *dev)
> +{
> +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> +
> +       if (!bus)
> +               return 0;
> +
> +       return pm_runtime_force_resume(dev);
> +}
> +
>  static const struct dev_pm_ops simple_pm_bus_pm_ops = {
>         RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
> -       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_resume)
>  };
>
>  #define ONLY_BUS       ((void *) 1) /* Match if the device is only a bus. */
> --
> 2.45.3
>

