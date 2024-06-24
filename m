Return-Path: <linux-pm+bounces-9913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A391562C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 20:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491A91C219EC
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651419F474;
	Mon, 24 Jun 2024 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjhuXzNk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC19B5BD
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252240; cv=none; b=jkwmt3haG3Vmwsf5mkA9AsylPsz7nPFfwOra85l5ZWgDaCoXqTvIzK7K8W1Y2XBDopuUldKDf5WBIeJDkxsosi6pvzaFSCzk7HsVvAQ3+oLVWQc2uPooFvsltSgPa5p2sLvObacLLb4WAam2tmyFSycg+uFu/tQAxPa3eV73Uyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252240; c=relaxed/simple;
	bh=WzGhfsAP4XzqaIdBWpKUm18+TeenjF6Blc7M4ECnYSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMZXo9o9nN2Nrob85eiIGzTCJXx/Oe/q2XWempJLcXrZ3l0Pet8PmMOqdpuEdKbtLisz8Z0sN2oU9f8/hfs3oDRyWTnGCoFxfo87uPq9RZl43FUuq+HcdZUrNsxxq1XjulcS8mu8fLUjAMXptuEffFXE4R39YhmfbXLaD4B1IPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjhuXzNk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424997177bbso6345e9.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719252237; x=1719857037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF029z/jflx/kP7IEmWTDP0ob8VJPp9a2/waRUF4Abs=;
        b=IjhuXzNke5DP+Cu0dwInvzsJM/bZVeMJTHFWlXANeFjpYYPAg30WJSPB35lEYJjPyU
         rPpTr5d7dkzulOXw7+Vzs7b0XUxt6it8E689w7ToFf0p/IvCgRuBKredYy/yqVbMIDrt
         StnVxzcdqN/TuYZvZoNd5Lo57F+09mjV/Fp6gTaRPoxKc7/4/f4xsAXS5LaelZsi4ZC8
         rFpjSiJ1fFaEY72ntsmFfI8e46J7rfkNOe27Imy8s0M6wQTSsepbcFZj9+Lh9q4qoNwu
         8Q37Bl1Z7Rxy29CHeMpD0eF3yLhaDzAnjWW7ck8nJvTPRL7IdAgL3+q/0Kdmo/c7jYtu
         zWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252237; x=1719857037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF029z/jflx/kP7IEmWTDP0ob8VJPp9a2/waRUF4Abs=;
        b=OQd4gBXn1RaFZJg3ozF9p0rPM2wI+Od77xHiKEJWLsK2ROo5IJuc1ujS2P7VAYCQ+B
         cVKlmFRSQwK+9NWEcVPJ5wIgSkT8KTBJOAhzkzXqAjZnDj/OFyO+Uodr7BbvCwU7TYqv
         3W87UOoyR69DSOQQb2trupV1mWiBLqdw5Q74JXGN/kHVSuV+u+1ZJEU0W+RObl1Wny1E
         w4iCZDvFgqzjeZBmsyLyDoJ7qE1Tjd5MEFlN47dcXK2Xk8Oy1H4TEgUOtpULcFUMksm2
         I4145O2Dxs4cIIu1nR9kS3pcnpwIwgAe+vuy5c8Uat1SGvk98oI6t22yKWa7zbdcly6J
         zKbg==
X-Forwarded-Encrypted: i=1; AJvYcCUkqJAMmzlN9tf8PsmNo//Tb3QREdexcOEZw2dRlhynzqDR5wtzXlHtkWgNxfx/azPKYEFFQiGpDgowTGi2U/VKVWTY7sPOAFA=
X-Gm-Message-State: AOJu0Yxp/kA/tmBf3QYqEeI3ysICzfJR41NdlxzNICH+wjEiFJXxNRfa
	A+RMRXfImWbqy7RGsHOMmAA9i1Wyc/8Q1RHSrUTPZoK3LuesFgqW6sAd8/170O0EM9rbBS94Q7e
	gTb0GGGuKypRUQ51ur8TUQLPGYbPiOS1gwnE=
X-Google-Smtp-Source: AGHT+IHrfNrvNgINjPFhE00IuMHWGEQ90pK8W7zqvkgYI7i48VPmX8HyZ3EqYScnHj5vTszY2D2Ge/7ppzdCu9YCrBk=
X-Received: by 2002:a05:600c:4e0d:b0:424:8b0c:156a with SMTP id
 5b1f17b1804b1-4249a1b913fmr129515e9.2.1719252236758; Mon, 24 Jun 2024
 11:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606172813.2755930-1-isaacmanjarres@google.com>
In-Reply-To: <20240606172813.2755930-1-isaacmanjarres@google.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 24 Jun 2024 11:03:43 -0700
Message-ID: <CANDhNCqhJRLgvhAong-5zjsfwk2sL7pNbK0EqWsPcaA+AuzxDQ@mail.gmail.com>
Subject: Re: [PATCH v5] fs: Improve eventpoll logging to stop indicting timerfd
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	saravanak@google.com, Manish Varma <varmam@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:28=E2=80=AFAM 'Isaac J. Manjarres' via kernel-tea=
m
<kernel-team@android.com> wrote:
>
> From: Manish Varma <varmam@google.com>
>
> timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> it names them after the underlying file descriptor, and since all
> timerfd file descriptors are named "[timerfd]" (which saves memory on
> systems like desktops with potentially many timerfd instances), all
> wakesources created as a result of using the eventpoll-on-timerfd idiom
> are called... "[timerfd]".
>
> However, it becomes impossible to tell which "[timerfd]" wakesource is
> affliated with which process and hence troubleshooting is difficult.

Thanks for sending this out!

My apologies, as this is really meta-commentary (which I'm sure isn't
what you're looking for), but as you've gotten limited feedback maybe
it might help?

While your explanation above is understandable, I feel like it might
benefit from a more concrete example to show why this is problematic?
It feels like the description gets into the weeds pretty quickly and
makes it hard to understand the importance of the change.

> This change addresses this problem by changing the way eventpoll
> wakesources are named:
>
> 1) the top-level per-process eventpoll wakesource is now named
> "epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
> and P is the PID of the creating process.
> 2) individual per-underlying-file descriptor eventpoll wakesources are
> now named "epollitemN:P.F", where N is a unique ID token and P is PID
> of the creating process and F is the name of the underlying file
> descriptor.

Again the N:P.F mapping is clear, but maybe including a specific
before and after example would help?

Additionally, once you have this better named wakesource, can you
provide a specific example to illustrate a bit on how this
specifically helps the troubleshooting that was difficult before?

thanks
-john

