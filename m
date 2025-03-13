Return-Path: <linux-pm+bounces-24004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B2CA60366
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 22:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B8C3ABA3D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629C01F4CB7;
	Thu, 13 Mar 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPAyuHcT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3451F4CA2
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741901170; cv=none; b=hEF6aiJXZ+94gYaptkgjpqH/IdYDHYqMwZPcFKSsulg4+2KpzG7rKul8wk+yiQhfDWNAfzO3SRN3hbb3WA6LnTrIifvXAICSSRNSBN/uBww/LCLXnbvv5U+vH1Bvw4R8YVJNep6CDyDS72DJ6+9jtc+4rfPEO/g58t7oy9MK/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741901170; c=relaxed/simple;
	bh=UfXACb8VfYItqeVlsi0BGbqMyOFIDyF57IXGiKf6dfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ7MTfmF4E4bEE9P+DoNfli7ij2ZQfmDsHpVQdFwzzO9KLbggfp7qAdQS0BKOk4BPIeRpa6yVFuuWMt3bzJcdKMT5aHcw7EFgeCPLtTngQf0aw9UWEalGRh6PyyQZEN8WpHYSbWVeiiwa3XYt1YEfYVSr8SlDpLcppT+rcCCnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPAyuHcT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54993c68ba0so1611250e87.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741901166; x=1742505966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEvSm/qV/gA4924ww+yiikc6EOcgXf2+Ryx6VfqPSVs=;
        b=DPAyuHcThzY62v6CJT6aaJ+huGprvPxXkR/ZArExmMykVNg+JuOMayLor2+vOPG/Kq
         MtGyyyqh77u2bkTLUF2VfWhEOAA41o+i/r6hRlO1hTrMMY4Mp1SuP2CDBmbcbvIktLDs
         dF5dBHI4SEKRHUGN/qTgMIdbwECQEbV9cquWd2xij9y7k9pY/IyaMlgS6VbcxNktMDHk
         AUZu5A6Rj53LxTnYeq6IgPpauvvl9vHvhfUHjNU6Xg9uzZBC/Exu0gcv91uu9hXPJfsW
         ovj199aneCD4e9MxNShTfWgxt3cRyRYX9G3oqD4YvEc/+oqO7JG3m3hJzDaKQaQwpU2F
         0Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741901166; x=1742505966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEvSm/qV/gA4924ww+yiikc6EOcgXf2+Ryx6VfqPSVs=;
        b=BTyLYDUcodVY1vuFW2DwNYM5RQCmvLUNB2VBO6ibO5YRqiDuWMvquPlNb+txzxgQab
         HbjcQmbzgnAM/V3ivHxrFswH6+ImmnfT+xjS+ABOG88ejQk/6fUZCt6MkMNllS/jPNSJ
         hUjnbD9qL9RNKkrBWL4U2H/+5c43BU0GdGwKIu/vAdbwMS1TKWp5Nn2QiuYPKDzQl9T8
         61pK10CjbgTkHm6OUL3eXtiN515+wSKmdk7rM72iD6FRcqY9KDZ3f5ZTk+xuBeh0c87K
         FuZ+CHYYJH5Geu5i/n3Sv6QG7qNkk6Ij9IORuyYOY1h3drS/IiNICylbiyb+yfwtFVrT
         Sgdw==
X-Gm-Message-State: AOJu0YzjOp1W2Hu6+pjwQRDmmEOkxZpcEI7j30f+trb/MthDeNw8KECQ
	N/9KIwi6huTlj5wt2jyJGSMYkcD/aSCM5U1DVycvYCzXyXWWpAStkSoJkPrbEJqoRNoVv+nVJO7
	CE4aBuWznzvcxrFPf++YRKR911R9n9G06+aFt
X-Gm-Gg: ASbGnctizTiBlk+FJ4QhZ6C/TV7YO6U9Svo29VDaM9BItdo8VdkIIqUyMF1/PQB35PB
	Ab/0vd5njbvNa2oE9ll9OqdMDkj62HSV5F+WHPTLBnlF7aBQuXs7XdKsiQQdhVW881a5Ram9wUe
	WLbmLjxx9MoD4aDYUoMfuTSFl6UsnMlS7eFImW4iC/ioWi0PRFhz4bUWEA8Ib7ys0=
X-Google-Smtp-Source: AGHT+IEUpl49m15csoisl4xdaOkvHB8pMtPnENRpafG0hTYq79/CSmqGTNA7Wf/Eyj58fOjm/pwvBRSNin5jsVrWKfM=
X-Received: by 2002:a05:6512:ac6:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-549c3989a09mr7738e87.42.1741901166311; Thu, 13 Mar 2025
 14:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12627587.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <12627587.O9o76ZdvQC@rjwysocki.net>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Mar 2025 14:25:29 -0700
X-Gm-Features: AQ5f1Jqh94uLmKYTj2Ojq8OmsbxaVGGM4qAQ2zcuSBghRC-ys5SVAMfqNlmaOJs
Message-ID: <CAGETcx-sydVJcigqin-zO=ANc65kuz5F3X51a8-SnM0X2zKhMw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Fix handling devices with direct_complete
 set on errors
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:00=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> When dpm_suspend() fails, some devices with power.direct_complete set
> may not have been handled by device_suspend() yet, so runtime PM has
> not been disabled for them yet even though power.direct_complete is set.
>
> Since device_resume() expects that runtime PM has been disabled for all
> devices with power.direct_complete set, it will attempt to reenable
> runtime PM for the devices that have not been processed by device_suspend=
()
> which does not make sense.  Had those devices had runtime PM disabled
> before device_suspend() had run, device_resume() would have inadvertently
> enable runtime PM for them, but this is not expected to happen because
> it would require ->prepare() callbacks to return positive values for
> devices with runtime PM disabled, which would be invalid.
>
> In practice, this issue is most likely benign because pm_runtime_enable()
> will not allow the "disable depth" counter to underflow, but it causes a
> warning message to be printed for each affected device.
>
> To allow device_resume() to distinguish the "direct complete" devices
> that have been processed by device_suspend() from those which have not
> been handled by it, make device_suspend() set power.is_suspended for
> "direct complete" devices.
>
> Next, move the power.is_suspended check in device_resume() before the
> power.direct_complete check in it to make it skip the "direct complete"
> devices that have not been handled by device_suspend().
>
> This change is based on a preliminary patch from Saravana Kannan.
>
> Fixes: aae4518b3124 ("PM / sleep: Mechanism to avoid resuming runtime-sus=
pended devices unnecessarily")
> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-2-saravanak=
@google.com/
> Reported-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Saravana Kannan <saravanak@google.com>

> ---
>  drivers/base/power/main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -938,6 +938,9 @@
>         if (dev->power.syscore)
>                 goto Complete;
>
> +       if (!dev->power.is_suspended)
> +               goto Complete;
> +
>         if (dev->power.direct_complete) {
>                 /*
>                  * Allow new children to be added under the device after =
this
> @@ -963,9 +966,6 @@
>          */
>         dev->power.is_prepared =3D false;
>
> -       if (!dev->power.is_suspended)
> -               goto Unlock;
> -
>         if (dev->pm_domain) {
>                 info =3D "power domain ";
>                 callback =3D pm_op(&dev->pm_domain->ops, state);
> @@ -1005,7 +1005,6 @@
>         error =3D dpm_run_callback(callback, dev, state, info);
>         dev->power.is_suspended =3D false;
>
> - Unlock:
>         device_unlock(dev);
>         dpm_watchdog_clear(&wd);
>
> @@ -1669,6 +1668,7 @@
>                         pm_runtime_disable(dev);
>                         if (pm_runtime_status_suspended(dev)) {
>                                 pm_dev_dbg(dev, state, "direct-complete "=
);
> +                               dev->power.is_suspended =3D true;
>                                 goto Complete;
>                         }
>
>
>
>

