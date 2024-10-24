Return-Path: <linux-pm+bounces-16383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352599AE5E1
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2678287FBB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E41DD9D1;
	Thu, 24 Oct 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVY4UZVS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461D1C4A2F;
	Thu, 24 Oct 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775848; cv=none; b=umQf6B6O9kzNnIAdjaP6YP7il6BkAVN2NbyzEHwnhjPGV6JSbgynx4MHssGXmY6jJBgGq43g0/xRclwX5ktFrsYQKR25Wn1gFr/NkS3P6CjlS2tu07wZJ8qipbWa02PtsC7hFwlD991roZkIbMYq7ZQmxTYdnS6cQaQBwmQ91IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775848; c=relaxed/simple;
	bh=NdBE6hbozYmVbY0urVOV+8FTTG4tBXfLh/dW3CeVNlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J82NMPzMWTM2fiF/DGZ81wFDeVWT98nQonxWh6ZkUv6cDHRf3j8WAqP+dIAVSQi9R73it7oM47OCsBkk+g/KrYFiHF6tRj63OKHk9IaNnWUXddl/T3bSmdWU42YhlcDU+91Yfr5rAQQWyt2igfkZt04avEF8M/QwgqYBwqGXg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVY4UZVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DE2C4CEE7;
	Thu, 24 Oct 2024 13:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729775848;
	bh=NdBE6hbozYmVbY0urVOV+8FTTG4tBXfLh/dW3CeVNlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uVY4UZVS/XGjEwVZh0+rWAqiyM0evlWXIvQGxl4+yWkXfh4m5UY97hwbpSvYlago/
	 naEBoMKd+VukWcMq19HItIkTmyeEZh5hJj+7m54r41zAQLAGtQbt6rZrGdiADbR1Oh
	 jgfudmd0w10oqm5MVX/PFynKr9GnGsBTFODNhcr/lDNCKi3tgweBv/PTQtx5/A9Qmc
	 UsY8+9/YTXoESNuUiasX0A8XJo8SGDgmOsLeiiaF9KlnY5aUczpXJ1UFohz/9O8kmw
	 V9pELv4xG0Y4GHO6CTpQJBai6ebg3tSZa1L69MTAlWObBAgYZxNVS6Y+4X+bZEp+E9
	 vcfS9XL3yTeVQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288916b7fceso526495fac.3;
        Thu, 24 Oct 2024 06:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuE948aDqBmRleI0pcV33n+eQeDG8e0QYreg/zsq371hZ882KT7/jzfFI1egfimYhAzOMn0G1XPok=@vger.kernel.org, AJvYcCXjTux9/qpSuhM5cAZ77aPBbM+oGk4YqHwelHi4/MvOLCd50QVlvxY88slPM1g672z/13tGJ3FP9ONPsWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMhNcvs82QZfXEelv8PERRdRhQjkAPyBrTHA03LDshOiY/FYMR
	vQKxu39hY6+DfKKk5rfPeZiw0mV0WOEyThXJQRmB6WWlQgZqAV7fnuXVu4kl6LwX6qMSEzekYs4
	O8scdcOWwhQY3ZLPK+h1Z+1SmI50=
X-Google-Smtp-Source: AGHT+IHhJzeF2bLORj57fVBTkWmlhQufqtQFQVhAi8eTYv4XypBPGFTLKD5/j4RFxF9MTUvo2oVASn28hPwQJLeCJZc=
X-Received: by 2002:a05:6871:68c:b0:27b:5890:bd38 with SMTP id
 586e51a60fabf-28ccb41ea91mr5759461fac.7.1729775847482; Thu, 24 Oct 2024
 06:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024102303.1086147-1-daniel.lezcano@linaro.org> <8b4659f0-5da7-4847-b5de-fad8ea57e967@linaro.org>
In-Reply-To: <8b4659f0-5da7-4847-b5de-fad8ea57e967@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 15:17:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gF=B7NG0ZVCHr4DfSqYaunDLw1Bcpjqcf1NwLBW_jNEw@mail.gmail.com>
Message-ID: <CAJZ5v0gF=B7NG0ZVCHr4DfSqYaunDLw1Bcpjqcf1NwLBW_jNEw@mail.gmail.com>
Subject: Re: [PATCH] thermal/thresholds: Fix thermal lock annotation issue
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:36=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> please note this fix has been written on top of the thermal thresholds
> series, so I don't know how it conflicts if it is applied before

No worries.

Applied (on top of the thresholds series).

> On 24/10/2024 12:23, Daniel Lezcano wrote:
> > When the thermal zone is unregistered (thermal sensor module being
> > unloaded), no lock is held when flushing the thresholds. That results
> > in a WARN when the lockdep validation is set in the kernel config.
> >
> > This has been reported by syzbot.
> >
> > As the thermal zone is in the process of being destroyed, there is no
> > need to send a notification about purging the thresholds to the
> > userspace as this one will receive a thermal zone deletion
> > notification which imply the deletion of all the associated resources
> > like the trip points or the user thresholds.
> >
> > Split the function thermal_thresholds_flush() into a lockless one
> > without notification and its call with the lock annotation followed
> > with the thresholds flushing notification.
> >
> > Please note this scenario is unlikely to happen, as the sensor drivers
> > are usually compiled-in in order to have the thermal framework to be
> > able to kick in at boot time if needed.
> >
> > Link: https://lore.kernel.org/all/67124175.050a0220.10f4f4.0012.GAE@goo=
gle.com
> > Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >   drivers/thermal/thermal_thresholds.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_thresholds.c b/drivers/thermal/the=
rmal_thresholds.c
> > index ea4aa5a2e86c..2888eabd3efe 100644
> > --- a/drivers/thermal/thermal_thresholds.c
> > +++ b/drivers/thermal/thermal_thresholds.c
> > @@ -20,17 +20,22 @@ int thermal_thresholds_init(struct thermal_zone_dev=
ice *tz)
> >       return 0;
> >   }
> >
> > -void thermal_thresholds_flush(struct thermal_zone_device *tz)
> > +static void __thermal_thresholds_flush(struct thermal_zone_device *tz)
> >   {
> >       struct list_head *thresholds =3D &tz->user_thresholds;
> >       struct user_threshold *entry, *tmp;
> >
> > -     lockdep_assert_held(&tz->lock);
> > -
> >       list_for_each_entry_safe(entry, tmp, thresholds, list_node) {
> >               list_del(&entry->list_node);
> >               kfree(entry);
> >       }
> > +}
> > +
> > +void thermal_thresholds_flush(struct thermal_zone_device *tz)
> > +{
> > +     lockdep_assert_held(&tz->lock);
> > +
> > +     __thermal_thresholds_flush(tz);
> >
> >       thermal_notify_threshold_flush(tz);
> >
> > @@ -39,7 +44,7 @@ void thermal_thresholds_flush(struct thermal_zone_dev=
ice *tz)
> >
> >   void thermal_thresholds_exit(struct thermal_zone_device *tz)
> >   {
> > -     thermal_thresholds_flush(tz);
> > +     __thermal_thresholds_flush(tz);
> >   }
> >
> >   static int __thermal_thresholds_cmp(void *data,
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

