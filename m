Return-Path: <linux-pm+bounces-30858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF0B0590A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 13:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697923A42D0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90E275873;
	Tue, 15 Jul 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfNp4uZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E423D2A4
	for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579574; cv=none; b=UkunSYf6BuhHEdT0UQEqzCxGTk9MnUkk9nIjmVgNCserntFUkUIgfBoAohYpL5Ug4qJPx+dCqD4P06Kn/5p3/PCO8BnwkVokZ8eFAHzJkkzs+BP9Bk3czneDGPJDLY4pCUrKcKJkIoFAIByu7a17fohVTO7rbc7au2HB91tlWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579574; c=relaxed/simple;
	bh=w1brcsbdt0tlcESNSyTMgCKbPvuMt9idpFuroZNU/gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIp31OOjThqCOM/jXcNfYsCtt97vOvWUQLTYjRTq+3f24JQ3Caw3zRet96cQMR6rh/gWEz2iUd6rpxR3qkq/WukoIFJDQs12LJ1HlCbvlHsDKGfRWHGOe9TI2Xx6RRhqAwAvY5kRHN4V8S61xOUQm96kueeeCWWqLYYPXQ96HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfNp4uZI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bb626b1ecso542196276.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Jul 2025 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752579571; x=1753184371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RhdF9Yv+ocxCNpwigI26KHR6mp6iXHv5oflRqdQCh5E=;
        b=TfNp4uZIpH2IyjijQksyW5A9K0dSo1n6xC7Us0Lz68JBlQwlntmgzMn6E5BA7a84Um
         21Ll0eqp5kj8a+iP6LrD2Rn1QWPveocGR+Mmz53Mpv3VMkdB3WfYd1nv+/t2/c+8FZXP
         oXAPn4DLTDmONjzyf/ugdRTWpLwzT3/gWRRHvWNhoDYks193Sgz8zHufyKI5hUZExxtR
         /6WxULY0CQ3tEM1w2AHJoCndBtMRK6LnDIM+5sNVJGyq68TecxGusmEi87yl/49cIqkQ
         T3G6p2Ys1jLNh1IE+ZRPO2BukQ6qLOVssCk6jji7KWiuKyyJ0fFIOwzETkaj+alaMTJk
         /5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752579571; x=1753184371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhdF9Yv+ocxCNpwigI26KHR6mp6iXHv5oflRqdQCh5E=;
        b=Hu9is103HsXWigXyIKfqwY5KN/OKzV36JCDw70RKebySrihI2CBq7XGElkCQAsVgBa
         X7Ug34dfIN62eKfrrgaEwx3xPslspRXrnTzd1rGt0rFUOy8A61tQX6RW0CvIVknLDnwt
         +Mu028JXua5QSyYergyUGC5X7xvbQVghReKc0NPs+CD3x57AoUqw2sHjUnzaDfkT93dR
         CONW3L3wRj7fHriiJtBV5FpaW2LHncJL55LPu7VBe0OE1INgrCWRHR/RQ9CZiWD++1q7
         5lp090AI/c/Jbkmx1ttPV1tVQqrNuYqWCLdv9bv2Anx2u7OgaQucMKFg1V7K8NapBi09
         tp0g==
X-Gm-Message-State: AOJu0Yx2cTmp+c0+G/ry2LyAKKXf94jR+pJnsgPQM0m4Hkjbt/FPkm5r
	ixH1uUzTsxX4ysvUL8w52y0EoVSrlPQTPVIS8RB+XKl6FmhDJcFy2FxGWoiulBmzg36kJoBSnR6
	3T4rBqEBvGLdWp3dd8KsrPNXi9FNJDctAzEAwNxOWE6aQ3ECTw53q
X-Gm-Gg: ASbGncvoi7IQQLp31hkedSzWIZYUqkOplgtAcYb9cjx9fpQkmb0JjlPRr6cR/yTkgWC
	CaAdBi9YSrQ1x+N0WGgnNEeHyHrdrtfXSpYnGzKq+UVIGMVsiDxQ6Sq4s0jI6XddvBSpTuulQqS
	iXz4QLr1a7EVXAdkJzxt1UzJ43mW+XpdiwzmFU2BUt16hlxT3V7+GKq5v4V675Sz0Xp3NtWeu6V
	X537iNu
X-Google-Smtp-Source: AGHT+IFpNo6m2jKxrLFJywmpCePiEHAB4ueqq//e+oIfr6dzryrMEq4r1A4fQMLYQFve8ARlc7cumyRBk5kOl2ibfIA=
X-Received: by 2002:a05:690c:a99:b0:70f:8883:eb1a with SMTP id
 00721157ae682-717d78af82amr271581787b3.6.1752579571263; Tue, 15 Jul 2025
 04:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191258.lOV4Wx5bFT@rjwysocki.net>
In-Reply-To: <6191258.lOV4Wx5bFT@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 13:38:55 +0200
X-Gm-Features: Ac12FXxlQ6Rul8fpbADmy4e_n9zSxErO-V3JMyWSuQQY3mrQaNd2GM_CLg-atE4
Message-ID: <CAPDyKFqs4-TZy8Vj72TwRUjoUp9V=yXGDUksRe7FhKVVwnvAuw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Update power.completion for all devices on errors
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 19:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
> suspending children"), the following scenario is possible:
>
>  1. Device A is async and it depends on device B that is sync.
>  2. Async suspend is scheduled for A before the processing of B is
>     started.
>  3. A is waiting for B.
>  4. In the meantime, an unrelated device fails to suspend and returns
>     an error.
>  5. The processing of B doesn't start at all and its power.completion is
>     not updated.
>  6. A is still waiting for B when async_synchronize_full() is called.
>  7. Deadlock ensues.
>
> To prevent this from happening, update power.completion for all devices
> on errors in all suspend phases, but do not do it directly for devices
> that are already being processed or are waiting for the processing to
> start because in those cases it may be necessary to wait for the
> processing to actually complete before updating power.completion for
> the device.
>
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Closes: https://lore.kernel.org/linux-pm/e13740a0-88f3-4a6f-920f-15805071a7d6@linaro.org/
> Reported-and-tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1323,6 +1323,22 @@
>         device_links_read_unlock(idx);
>  }
>
> +static void dpm_async_suspend_complete_all(struct list_head *device_list)
> +{
> +       struct device *dev;
> +
> +       guard(mutex)(&async_wip_mtx);
> +
> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
> +               /*
> +                * In case the device is being waited for and async processing
> +                * has not started for it yet, let the waiters make progress.
> +                */
> +               if (!dev->power.work_in_progress)
> +                       complete_all(&dev->power.completion);
> +       }
> +}
> +
>  /**
>   * resume_event - Return a "resume" message for given "suspend" sleep state.
>   * @sleep_state: PM message representing a sleep state.
> @@ -1499,6 +1515,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
> @@ -1701,6 +1718,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_suspended_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
> @@ -1994,6 +2012,7 @@
>                 mutex_lock(&dpm_list_mtx);
>
>                 if (error || async_error) {
> +                       dpm_async_suspend_complete_all(&dpm_prepared_list);
>                         /*
>                          * Move all devices to the target list to resume them
>                          * properly.
>
>
>

