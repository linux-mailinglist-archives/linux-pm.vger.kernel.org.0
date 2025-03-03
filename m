Return-Path: <linux-pm+bounces-23295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5EA4BF15
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86993A595A
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187C1FF1D5;
	Mon,  3 Mar 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK5kaHtU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16B1FF1D0
	for <linux-pm@vger.kernel.org>; Mon,  3 Mar 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001837; cv=none; b=HS+nyInijMz9AuXc/JOEYBwrxmoBhEqjIx4PnQepsTdbA3gdP/fBhYHgGWPG/GNJUCVCMcFMnRoKL+4EpvzHUezrzCxPI/726JZJnDQt+eALiV5/T8pAhdrUAxoq+RIuJZsx6xFU9wVHo67g+Z+HDmlLrha3nQT75XEVWZ4vBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001837; c=relaxed/simple;
	bh=gSmqjl48I2bftmg98TgvWKfCxzYiI8y99YYV12eiWM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSsoLjvVWdhcfeTlErDMMDnGQaMBilxD8v94Gigi0q8tKRmADqXv4BHlvVukWoC58Ww0kBsPUgkzXWJ3LgkUVhZeBppzKuYbrwuBcnTMIdsdQOA5ZsAn6tgaf+pT/JEfd83u7wdCN+BIqwP46PEXpOgr+Y5fgCE3HS33BlP+RB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GK5kaHtU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f74b78df93so38028687b3.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Mar 2025 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741001835; x=1741606635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZdcPlKGwSUQ1/c/x0IEBqiGcJoStRQT2SaVJ9Y6HOg=;
        b=GK5kaHtUi355ItY4ZtFQZHjzfQM9dQ/O8+wFfAlJtSJtfA+6d504PRieJb7idYbzIw
         WaKxOnqCHKib9Xo1vw3S5hQ8KFtiTaNi9ydDkMvAoTJjaTFJWvM6YeooujfMT0hu0TxE
         RFsxE8bXf9Xbiy1S5qMDCpjRUlyruwjM6iK3ZdpWuW5hp8eUjVw738BJErki1eWHztbw
         BzOvM+sxwJZeLQyyJB4ZArWpAsxcJWaUYeafzJ5RBXFZDAW5qjrdlzVNtJLgzbTNJPdJ
         dJkretoVTEUgbUjvdDKMwhmZziScCtnsmMO+1K//AmCMRCnN1SdKbEQSjoQVwtAlV7Ie
         xBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001835; x=1741606635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZdcPlKGwSUQ1/c/x0IEBqiGcJoStRQT2SaVJ9Y6HOg=;
        b=iMtnDbqf1fe3ZqXg7gOniwX9/IJag4WiowioaMo/Aq5AN5ioiSdAo2kZ+ybDO0C6zi
         CvrcRUCZQiQ28wcm5xvneRGLnMyrt+S8JtKn/GTSPAGfqg5M4u+9ob1fWOCnKk225UcZ
         ETYgkifohczzM7WwUrh29NRtbjGzg7bLUzXpusj34rOTQGQRV85NBhX1HHSj96FJ4v/e
         CiokMwkmcmPZsMZu1OLWkNpv1xVtMFv6AdB7kQvK7v9MDBaUJiOJn9VPrsf2Bdw9uEdp
         Urj2S+IqsYCW/CGKakkL9Nr9Kgv9s8Godsaer5YbW621uAvPXZZhRR6gkm4ZRSMDr+Py
         pF7A==
X-Gm-Message-State: AOJu0YwC+TnUROPKK4FXVCZ5U2vnZGTvdeeNTsO7EFI53lyO3EDs/voI
	pwy1BS9w9bt5OumPveyT0RxmSATne0iWxQxObL2VLhiCb5Y8cbkI4rakSloL8jFXGwO7LVj7mx/
	Q6ZDvQflvr8UWQjQoyQQyxbs7Lv/WD+1V2BRnFA==
X-Gm-Gg: ASbGncvl6I1lXc7kSSTr4fw9t9uYIGcpGWY8SkUIepiXENIFGGfN0epr6OzQcXroL1b
	7MG717ltMnE3jjMtiV0ZlidCyZod2xRAsxTT3LaE4LLDi7kIURnTKKEUs7XYV8s5Ot5F0S9g1IB
	ifjtpYBbKvYEq8A7E+Agtt7UIbLUU=
X-Google-Smtp-Source: AGHT+IHrccx3eeYx7Ph57lcw3jkpDa9UoiqwNC12MOXPb6LaFAIEcFkZzSIkizPiqpdEw1ZhtDOIw4oKutTggiYjUA4=
X-Received: by 2002:a05:690c:3001:b0:6fd:44a5:5b68 with SMTP id
 00721157ae682-6fd4a100420mr180752197b3.35.1741001835219; Mon, 03 Mar 2025
 03:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12620037.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12620037.O9o76ZdvQC@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:36:39 +0100
X-Gm-Features: AQ5f1JoM9bXFkjeEORxBmtsj4iFuLmWabqtiwT-NoP3RpdVWmI2bcHKAnUHgW7Q
Message-ID: <CAPDyKFqdD760Tn5nHghXK1DgSQ6K=hv7D32m9w0-jgi+nA7-gw@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Unify error handling during suspend and resume
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Brian Norris <briannorris@google.com>, 
	Raag Jadav <raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is a confusing difference in error handling between rpm_suspend()
> and rpm_resume() related to the special way in which -EAGAIN and -EBUSY
> error values are treated by the former.  Also, converting -EACCES coming
> from the callback to I/O error, which it quite likely is not, may
> confuse runtime PM users.
>
> To address the above, modify rpm_callback() to convert -EACCES coming
> from the driver to -EAGAIN and to set power.runtime_error only if the
> return value is not -EAGAIN or -EBUSY.
>
> This will cause the error handling in rpm_resume() and rpm_suspend() to
> work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> special case from the latter and make it retry autosuspend if
> power.runtime_error is unset.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems reasonable to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>
> v1 -> v2: Add comment explaining the -EACCES error code conversion (Raag)
>
> ---
>  drivers/base/power/runtime.c |   40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -448,8 +448,19 @@
>                 retval = __rpm_callback(cb, dev);
>         }
>
> -       dev->power.runtime_error = retval;
> -       return retval != -EACCES ? retval : -EIO;
> +       /*
> +        * Since -EACCES means that runtime PM is disabled for the given device,
> +        * it should not be returned by runtime PM callbacks.  If it is returned
> +        * nevertheless, assume it to be a transient error and convert it to
> +        * -EAGAIN.
> +        */
> +       if (retval == -EACCES)
> +               retval = -EAGAIN;
> +
> +       if (retval != -EAGAIN && retval != -EBUSY)
> +               dev->power.runtime_error = retval;
> +
> +       return retval;
>  }
>
>  /**
> @@ -725,21 +736,18 @@
>         dev->power.deferred_resume = false;
>         wake_up_all(&dev->power.wait_queue);
>
> -       if (retval == -EAGAIN || retval == -EBUSY) {
> -               dev->power.runtime_error = 0;
> +       /*
> +        * On transient errors, if the callback routine failed an autosuspend,
> +        * and if the last_busy time has been updated so that there is a new
> +        * autosuspend expiration time, automatically reschedule another
> +        * autosuspend.
> +        */
> +       if (!dev->power.runtime_error && (rpmflags & RPM_AUTO) &&
> +           pm_runtime_autosuspend_expiration(dev) != 0)
> +               goto repeat;
> +
> +       pm_runtime_cancel_pending(dev);
>
> -               /*
> -                * If the callback routine failed an autosuspend, and
> -                * if the last_busy time has been updated so that there
> -                * is a new autosuspend expiration time, automatically
> -                * reschedule another autosuspend.
> -                */
> -               if ((rpmflags & RPM_AUTO) &&
> -                   pm_runtime_autosuspend_expiration(dev) != 0)
> -                       goto repeat;
> -       } else {
> -               pm_runtime_cancel_pending(dev);
> -       }
>         goto out;
>  }
>
>
>
>

