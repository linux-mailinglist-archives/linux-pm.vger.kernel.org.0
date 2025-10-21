Return-Path: <linux-pm+bounces-36603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46B5BF8AE5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 22:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004D55850BD
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 20:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905827CB35;
	Tue, 21 Oct 2025 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTbySJRF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141A279918
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077634; cv=none; b=oTdKFqARodl1fgj9oE2RgqCbza2tFRlrXkyCpQu2+UwTXJQzcNdRdrzigFqL+A4zKTLj9Nsi8yGQxFg6ZJ7Ep9luhl4WwNBE2KQU4UdArSLBPYaVKXPo2a+l+Oco15iuOwhZhBun93IP65sqphqiiXNSfuXlhgvQ+kvnSfIu0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077634; c=relaxed/simple;
	bh=4J0OjdwLHiQReJHal9jW/12h5Mk9FoHm68ukURUqSXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOz1ih8IRP16uvYciX/bQwQGlZSIrHgm9zhTrut7EnTbVPq3EwQBgGBcrqs4gzEd9YRgXDsmdUbP7UvlwvP+LGsht1yO+HWjlbxXWwX+hQjg0gkYDpq5QKrV3/7Aaw9fDh1Hgyx3VCF6tWAbjiiIVOEheExmuxixPyTLtk4aNSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTbySJRF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591c98ebe90so6656779e87.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761077631; x=1761682431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKxOWgYUPXY6dMbHVZSr2oXiuYnahXqeB8QRh2XeD1U=;
        b=BTbySJRFPV8RtG0oHZeNnw7Qrsg7TrZrdY5F3E+uYFwwedsAdqbsDJBhqzhI5Mv2eK
         XejAvf7e3j0M/EU5TpOVMlryhyrfdM0hPhwOSC9Z5XO9S2o/OcntE3zqeOkM9G5mAmX5
         wmKNH16m13ELztaFyvpC2Vf+5yLKxoE5x0veoVaURx5BHvD+Q2prw6XSLxSbyCMjZaXp
         5Hp8Vy3tEWiZ3qOA3VyZF+FBi3tjZq6/A8ou6Pne37yZS0nZpoI161O7j0aXclV0ZxA+
         W6nCKh/a9T7Uhvi43fkLewuWSdjmhyfP7VUPBcxdnsZQMEDnTLXfT7mQGDh6t1DTpDG3
         ATGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077631; x=1761682431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKxOWgYUPXY6dMbHVZSr2oXiuYnahXqeB8QRh2XeD1U=;
        b=ZxHgL9P/INzFLgDJhKOHOnjpPBOpPkVmiokdqRPHoti+VHQKgUgxuBC8z1ZeZoc1ya
         gGa/dJ84XMi6nBlfGLf527N4hhBLNbYomVGE6PMoM16IRDaRiZB3YioeD4lArbMUNSuH
         ZJf4dEUOST4nYG71u24PXIc9Fma+seby2NXAb5fjOeLB/5X45oiKkiisxHMUFZxpHuaD
         OPiMYOmvi56x0m/dHZYArri1+nWJSQFuWkAohc1lM7pDJABvcryQxKu7qr74axUSP8J7
         97ysHeNfROI3oJiFhSkJYtHp3I/AMve9gXAbH2jGDK9FuDV04HpGOz9gjwkbpHESrZRg
         UHwg==
X-Forwarded-Encrypted: i=1; AJvYcCVRaBTF3s1YQrJbOGMHoHoDyJ1bJEdSnpmnYnzj0RsOyPG2XyDOZrakxlxQ1HbM/uujT/WPLlUdpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2luMFJUjJcrOT7dIfjbs36yhv7tje1DYXbaMDKs/RzS0NFF77
	twf0GSF9ltBsXFYlTYKp7xEd6mIwf9uPAjwhx4xcpe5eWyq+3/xixQY6aRAl4YEYfi/urMPoHWI
	K6GPCq0hi+qvdx9MjBgqKzoOulQmEdDZJemBOHqI4
X-Gm-Gg: ASbGncthr+hKlvCu/PR/Hx5SZgij1xHmgzEU+lyH2umKSsc4HKmAgiSt9c+00eOh9+z
	8C6TMLjJuCbZDbT5aCjTuPixxSPESkOMWzEiVaBtSyvpV/amvdTclO0MKTZkbZFIof2zGqKnW7L
	Z7O3feKs0kHQBW+0nLKbFv2OrglXgD41wEy9B2lpQENNRLSY70lYqtqVZIbOy58T9Oe+No4axo0
	PcQXmaKbz3cuqlKodq1Pb8FJLhsGN6nbQVq9OX4u2celfARSROvYn8V9z3GgWzkmO1kLD5xh10B
	UgedigvDuXH21h0=
X-Google-Smtp-Source: AGHT+IEqXRFdpx8CQbrjYvDVnFkn8J994f91e0LtjYzhGaLWt510eCkAIILvZM/1VmWwOM7eWS/cxOq1TCtRG2ycS50=
X-Received: by 2002:a05:651c:887:b0:372:9bf0:aed6 with SMTP id
 38308e7fff4ca-37797a3dd66mr47608571fa.25.1761077630863; Tue, 21 Oct 2025
 13:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <20251018001715.8621-1-hdanton@sina.com>
In-Reply-To: <20251018001715.8621-1-hdanton@sina.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 21 Oct 2025 13:13:39 -0700
X-Gm-Features: AS18NWCpcTWwPQfzIddHNwywzJiUN6wPBLbqql1bRpm4FhPF577suS0FfEJERho
Message-ID: <CAG2KctpHA+L=xh-VQ8SVDSRcqyL+ch=WMVrKS+pckLmC6uJwvw@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: Hillf Danton <hdanton@sina.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:17=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 17 Oct 2025 23:39:06 +0000 Samuel Wu wrote:
> > +/**
> > + * pm_sleep_fs_sync - Trigger fs_sync with ability to abort
> > + *
> > + * Return 0 on successful file system sync, otherwise returns -EBUSY i=
f file
> > + * system sync was aborted.
> > + */
> > +int pm_sleep_fs_sync(void)
> > +{
> > +     bool need_pm_sleep_fs_sync_requeue;
> > +     unsigned long flags;
> > +
> > +     do {
> > +             spin_lock_irqsave(&pm_sleep_fs_sync_lock, flags);
> > +             reinit_completion(&pm_sleep_fs_sync_complete);
>
> Given difficulty following up here, can you specify why reinit is needed?

There are two possibilities that make reinit_completion() necessary:
1. Suspend abort triggers completion, but is canceled before
pm_wakeup_pending(), so need reinit to restart the
wait_for_completion() process.
2. Handling back-to-back suspend attempts: after a subsequent suspend
attempt finishes waiting for a previous suspend's fs_sync to finish,
we need the reinit to start the wait_for_completion() process of the
subsequent suspend's fs_sync.

> > +             /*
> > +              * Handle the case where a sleep immediately follows a pr=
evious
> > +              * sleep that was aborted during fs_sync. In this case, w=
ait for
> > +              * the previous filesystem sync to finish. Then do anothe=
r
> > +              * filesystem sync so any subsequent filesystem changes a=
re
> > +              * synced before sleeping.
> > +              */
> > +             if (pm_sleep_fs_sync_queued) {
> > +                     need_pm_sleep_fs_sync_requeue =3D true;
> > +             } else {
> > +                     need_pm_sleep_fs_sync_requeue =3D false;
> > +                     pm_sleep_fs_sync_queued =3D true;
> > +                     schedule_work(&sync_filesystems);
> > +             }
> > +             spin_unlock_irqrestore(&pm_sleep_fs_sync_lock, flags);
> > +
> > +             /*
> > +              * Completion is triggered by fs_sync finishing or an abo=
rt sleep
> > +              * signal, whichever comes first
> > +              */
> > +             wait_for_completion(&pm_sleep_fs_sync_complete);
> > +             if (pm_wakeup_pending())
> > +                     return -EBUSY;
> > +     } while (need_pm_sleep_fs_sync_requeue);
> > +
> > +     return 0;
> > +}
> > +

