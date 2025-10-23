Return-Path: <linux-pm+bounces-36708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D7C00695
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086E218C4ECE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480DD309F1B;
	Thu, 23 Oct 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQv02hUn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D052FABE7
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214481; cv=none; b=jNHO19IJHqEGfD0Q7ALKafLj4A6hn7MmWDE2hi3+Fqvt7ELpYfQ5qfTW6Tyq70UZK3vnq6wfucuahrUMfm1ARMwIhru9Y81d3SJ3VoVJItNu/1H2ySSleVDXTgOC5wfDFOzTAOHvoZcBCmZ7bNYwe56dGAzrmIegLsIOblzcMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214481; c=relaxed/simple;
	bh=kQrwfeK6BSZA4hOjFrz0Ww0qHNVw1EZq9ktgzLRORC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBMqoVPOykAb+C8RMzX6kUQhoRb0362qTQN5wzZbmqwm276bUgk7/06ro1v7WmXTKdTe+F9zX4laK8cIER8toTGVbxdoUR6d0PiHk+T30gyzOl0tolHAgYthv06bXrAFI2qfeSxNYRvFkeRICqsuBy2cTGXaA2hzPq+h3BLrwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQv02hUn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7836853a0d6so11202847b3.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761214478; x=1761819278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AZQqfS0sJXsrrWoD3jAxqDvefJlIC1te8qKEyKPBYp8=;
        b=qQv02hUnOWgbF17fKKNLuwAOsK1zPoKxB2DpguL1WtMx/3+q/1HNjMnHipwDjz4+FJ
         NVvQYX7NWtTg2bLkSsTMYq6wCEY+GMHDYBYX+jj5rsXBSjkqEaIrDZJN0LHcksG7gwPD
         sIs/VoGA6fUlr8F5iGhRqde9rILJUeaskYwddMxj9B9RJZmYpGnSu0ocFlZmRXW/EfVi
         rW6F+2YumXhsn7S/2ZiOaILBiH1ni+nlfDIq7Tm+BWZnsoTYAp8MLd7Xi/rB329pso2g
         jfiAE8yGU/ZUnC6IzzvjBGlGFNPSQazTmzQ8FLnGU/oMkt60zvB7+Rd6JPdFnVDXvotD
         K9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214478; x=1761819278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZQqfS0sJXsrrWoD3jAxqDvefJlIC1te8qKEyKPBYp8=;
        b=URZz8fg8H8aOoIOBGj4ozA9cR5r878KuH4bv0U/iBW261NVpPmgtedW7FQtpy8EhRH
         dIVm5dD3+xRpdB3niGBPzoeGlAxg62s3thu//r7+A6VkYwSaVoZ35UBMMTcbyb3+mdBu
         2n71VTN23+PxadoLy6HmAe4VaszC3fQXCysE9PRUZZC0QJqLpkIRCn9nXbJO9J/jxYYj
         ALCjCqJDKPQqWE1mtCbq3Q1dzGrblIRFnXSg9OQ87cl88sPmzaAwSeG16stSczAegIXQ
         k2V491M4HuOr3aC3YiYuKplB0VJD/g5YVFNNTzo0tGd9fEqmns7Lm41vZnLziU2ftsif
         J96Q==
X-Gm-Message-State: AOJu0Yx5CstwHRY5SdhVLPgO3LYugemAnsnr3yWcNF+y3R822kW2kovz
	RniS9VQDYmlRM/fpslu/WOeb9zI+NVM0W4Ypt+PCUsSdb4UKBbnE3x7qFYnNsu5dE8x5+hzKgh2
	+0DyBbeOXziLVH8t5iovot8iPiJ5F04cf2DOXbrTUUWG6YmKVJ+0C3Ys=
X-Gm-Gg: ASbGncsAe+2RFMA43YMk0EYYAqKTU8Ut2459p/DQbs8gZRYOTMSJdRxo0wk9VeDjP50
	qPvzNo4L8JmTVtY3b7223nwTiint5Wm0L3iTYySBW/u/2so4sgTiuUgcGD95l65mnvVGTurTs5H
	arqfWqvHlDaNnXaQZqvnDYD9KWbstRJc4XI41SgbUttJ+1y82j/izYQAAUozNud3bzRqndP+aQn
	QUvWgcxdblxy/QP59APL8WBxUd9wQmgO7gbkEyL/yuGdYgV7QdN75it9SEC3Q==
X-Google-Smtp-Source: AGHT+IE7F/EI00x9DCeoo6JjaSCckVXgt3lm3I3JUeeNyWCvGlZ8hc/01NO1U+wDGY7gJh59/bcsowIiquTugxt+G6A=
X-Received: by 2002:a05:690c:6c86:b0:780:fbb5:3949 with SMTP id
 00721157ae682-785c4ac5b36mr40059377b3.10.1761214478430; Thu, 23 Oct 2025
 03:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12780841.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12780841.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Oct 2025 12:14:02 +0200
X-Gm-Features: AS18NWBFfpQda-vC9Ku8F43VMzpQMQKxoF0wFz8lChxmuKsGpDxi34MwYlv4jSI
Message-ID: <CAPDyKFoYZXRM2nG7gxNn0HAyEGeQQDUzzUxc2=3ue+5dqM4TPg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: docs: Update pm_runtime_allow/forbid() documentation
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 22:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Drop confusing descriptions of pm_runtime_allow() and pm_runtime_forbid()
> from Documentation/power/runtime_pm.rst and update the kerneldoc comments
> of these functions to better explain their purpose.
>
> Link: https://lore.kernel.org/linux-pm/08976178-298f-79d9-1d63-cff5a4e56cc3@linux.intel.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/power/runtime_pm.rst |   10 ----------
>  drivers/base/power/runtime.c       |   17 +++++++++++++----
>  2 files changed, 13 insertions(+), 14 deletions(-)
>
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -480,16 +480,6 @@ drivers/base/power/runtime.c and include
>    `bool pm_runtime_status_suspended(struct device *dev);`
>      - return true if the device's runtime PM status is 'suspended'
>
> -  `void pm_runtime_allow(struct device *dev);`
> -    - set the power.runtime_auto flag for the device and decrease its usage
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively allow the device to be power managed at run time)
> -
> -  `void pm_runtime_forbid(struct device *dev);`
> -    - unset the power.runtime_auto flag for the device and increase its usage
> -      counter (used by the /sys/devices/.../power/control interface to
> -      effectively prevent the device from being power managed at run time)
> -
>    `void pm_runtime_no_callbacks(struct device *dev);`
>      - set the power.no_callbacks flag for the device and remove the runtime
>        PM attributes from /sys/devices/.../power (or prevent them from being
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1664,9 +1664,12 @@ EXPORT_SYMBOL_GPL(devm_pm_runtime_get_no
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Increase the device's usage count and clear its power.runtime_auto flag,
> - * so that it cannot be suspended at run time until pm_runtime_allow() is called
> - * for it.
> + * Resume @dev if already suspended and block runtime suspend of @dev in such
> + * a way that it can be unblocked via the /sys/devices/.../power/control
> + * interface, or otherwise by calling pm_runtime_allow().
> + *
> + * Calling this function many times in a row has the same effect as calling it
> + * once.
>   */
>  void pm_runtime_forbid(struct device *dev)
>  {
> @@ -1687,7 +1690,13 @@ EXPORT_SYMBOL_GPL(pm_runtime_forbid);
>   * pm_runtime_allow - Unblock runtime PM of a device.
>   * @dev: Device to handle.
>   *
> - * Decrease the device's usage count and set its power.runtime_auto flag.
> + * Unblock runtime suspend of @dev after it has been blocked by
> + * pm_runtime_forbid() (for instance, if it has been blocked via the
> + * /sys/devices/.../power/control interface), check if @dev can be
> + * suspended and suspend it in that case.
> + *
> + * Calling this function many times in a row has the same effect as calling it
> + * once.
>   */
>  void pm_runtime_allow(struct device *dev)
>  {
>
>
>

