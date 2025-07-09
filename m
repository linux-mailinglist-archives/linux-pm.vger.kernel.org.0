Return-Path: <linux-pm+bounces-30476-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA6AFE82D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1391606EC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7692D780E;
	Wed,  9 Jul 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+qeOHKx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730A32E06D7
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061620; cv=none; b=GInfEJUWe9RrfeVI1YF2zpNilZemVXflBWStQLufK+L59vJC2k19Ebl52w8pXYxM4WeiLLn92H74oC8Htu58hPeEmaMCxWw6TSbc92lO5tI1uTFkYhsSYxnhzIyqiFIgmqJPrH7GsNmGPC08C/qdgiI4lZzyn0b52ImY1guW3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061620; c=relaxed/simple;
	bh=jyvsJyczQaLf282vmFZnv+xAwrXzu341mqa655zSiTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTkdPotzm1ho6Nl47NNWJBk8LRNVEiN84cP9YV+WaGahftkdF6FAcQihyRn8u6q4oKOiUgpKKsQXJcrX/SFkEC8GZbnDmEWe0TQY+98znag92pk9V9atuFZQzFrnaYjT2pC2ZEKoRX5ZQMD8AwS6PnZLsi739lgUyJxQ7jFe+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+qeOHKx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-711a3dda147so52164597b3.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752061617; x=1752666417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s8WkrJdPByInIrgC1CCzpZsAnkTo8xBFpZM0PRv7l78=;
        b=I+qeOHKxwp0YiGbsp3UG7Rtk/KebW075KTQjyQ+N2/uL6Wyy3GGCL0f40WpITW2+Jz
         nnaLWvvytyxfQhKrcK0qvHnc3S/WGoubiduSLKulst7oNZxhCI0rJakZsvj0CQL/cF9d
         Aqrkgv6x9Wjesj4lWMiiM6SXdQtcxNx2laXfV613vIYeM3ZP7v5hpuOfdIr+BoBqTHbi
         VTCviLawpyi3vtEQ8tQyBTLGwqKouijnDbbJW+mE7OSmEQ6My1ZwLDoad5L5891WQ5be
         Tptby5hnN6I6FToG6PbaM7UzElgBICV90++FVC+oQjMDFm4F1eBUZl5/Me8Pqp/DY3r4
         chjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061617; x=1752666417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8WkrJdPByInIrgC1CCzpZsAnkTo8xBFpZM0PRv7l78=;
        b=HNrjXIoQ3DAl5KN757RLMawVfSgrQUAJyK5M/qSnXHoYLAkoQAl7VquwMuahUl84Om
         1kpvjFjZvgRuq2p2YBNTCWyHIhgh21Y1IOorixChoSLLkcJ9JukawGTyx2yjoVJ44Zqg
         ib57PfFfLSBHzuUGqzNtSITNDJYVGGQTobOnb40hJ5JNzow0u6iu6zA27vollKn4vbEk
         qr0ILDBsK8trYT1r7e4VBSEbFbd2b+xArBc82a4Pl8Almaw9xQhT8DPp/0XhztmXHmt9
         ycPBMK1Cfh2KM7N/CeotK1QPPf8BQIzfkRyhELxPXcJVLArSxv8BHGA73vcGZLV/VkUj
         FP1Q==
X-Gm-Message-State: AOJu0YxjjUTwq+REpnUWE4GYzx2zsnX+EvXCVhqgi5lrBgbhldrNipf2
	M2YoUY5QZY1Uar8dWkqrto8uM/scAOVCcMi7HPLpohs0nX5E7IGGVfMr/vTTYBST6aLIFmHSVxQ
	ay5NBD0lvu0ttYXg8fRemIeW1e87xQCHZ/WIYB+Rwbw==
X-Gm-Gg: ASbGncvrbF1itL55TEymd+I+nG0NrZv5FF2ZRfNO+SHWOs1kgvnrc60rn8w+skOi7Uw
	pbK8lAMQDhy15BF65td2YdKX5ODCucsExaW/Og/+PuWaUrhcHMs8MovtAgJXNKmjLG3U1DZxpVv
	6IM23T3F9nB+BhHKcPWMtv08w6Ml7y4w1dzbTwJvUNpisk
X-Google-Smtp-Source: AGHT+IEjd4Bsp9vhFXwIMeKPCfl0HudeXbCUsQN6dTCUhLN2w08+3I15itDDB7bes0yfdKQ/F5CuA9N1Z410+NhlvkY=
X-Received: by 2002:a05:690c:6811:b0:70f:84c8:3134 with SMTP id
 00721157ae682-717b166ef67mr32767347b3.3.1752061617229; Wed, 09 Jul 2025
 04:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12700973.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12700973.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:46:19 +0200
X-Gm-Features: Ac12FXyHlvbzSF2Gox8nn_8TvDnuzqQLjD-xcSn9yoGLBWebg6XVrtiLyNg_rpQ
Message-ID: <CAPDyKFpGH=ZUyQ0wbkEKVLxknm59hDX6DNm9hXpuqzHCpoe-KQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Take active children into account in pm_runtime_get_if_in_use()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Alex Elder <elder@linaro.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 12:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> For all practical purposes, there is no difference between the situation
> in which a given device is not ignoring children and its active child
> count is nonzero and the situation in which its runtime PM usage counter
> is nonzero.  However, pm_runtime_get_if_in_use() will only increment the
> device's usage counter and return 1 in the latter case.
>
> For consistency, make it do so in the former case either by adjusting
> pm_runtime_get_conditional() and update the related kerneldoc comments
> accordingly.
>
> Fixes: c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1203,10 +1203,12 @@
>   *
>   * Return -EINVAL if runtime PM is disabled for @dev.
>   *
> - * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
> - * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
> - * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
> - * without changing the usage counter.
> + * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
> + * is set, or (2) @dev is not ignoring children and its active child count is
> + * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
> + * the usage counter of @dev and return 1.
> + *
> + * Otherwise, return 0 without changing the usage counter.
>   *
>   * If @ign_usage_count is %true, this function can be used to prevent suspending
>   * the device when its runtime PM status is %RPM_ACTIVE.
> @@ -1228,7 +1230,8 @@
>                 retval = -EINVAL;
>         } else if (dev->power.runtime_status != RPM_ACTIVE) {
>                 retval = 0;
> -       } else if (ign_usage_count) {
> +       } else if (ign_usage_count || (!dev->power.ignore_children &&
> +                  atomic_read(&dev->power.child_count) > 0)) {

I am not sure I understand why this is needed, sorry.

If someone and somehow we have "dev->power.runtime_status ==
RPM_ACTIVE", then the dev's parents/childrens and suppliers/consumers
should have been reference counted correctly already. Otherwise it
should not have been possible to set the runtime_status to RPM_ACTIVE
in the first place, right?

>                 retval = 1;
>                 atomic_inc(&dev->power.usage_count);
>         } else {
> @@ -1261,10 +1264,16 @@
>   * @dev: Target device.
>   *
>   * Increment the runtime PM usage counter of @dev if its runtime PM status is
> - * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
> - * it returns 1. If the device is in a different state or its usage_count is 0,
> - * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
> - * in which case also the usage_count will remain unmodified.
> + * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
> + * ignoring children and its active child count is nonzero.  1 is returned in
> + * this case.
> + *
> + * If @dev is in a different state or it is not in use (that is, its usage
> + * counter is 0, or it is ignoring children, or its active child count is 0),
> + * 0 is returned.
> + *
> + * -EINVAL is returned if runtime PM is disabled for the device, in which case
> + * also the usage counter of @dev is not updated.
>   */
>  int pm_runtime_get_if_in_use(struct device *dev)
>  {
>
>
>

Kind regards
Uffe

