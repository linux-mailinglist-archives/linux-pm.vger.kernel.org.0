Return-Path: <linux-pm+bounces-27590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E9AC264E
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66BC69E472E
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD97021B9E5;
	Fri, 23 May 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOnlrfNc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE32063F0;
	Fri, 23 May 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013588; cv=none; b=SE8w20XNf9BIC63tJqfgNUrenq1jYGYQi/G4mkpUsczk+TVFW+K5I9W01yDqDyPoxwg7i4K1xxODifXuf1gyoyryvtlh6mPoqWPt+dZrsOl8GpiSv5RY7+xS0UdPEyyN556TIikzwxY4HNHs0vTVJiBFiIUbQrZHJjJBCKc21zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013588; c=relaxed/simple;
	bh=GsrKYlRnFo2LgPBmqPloVglZHVpw1rjgUueyKeKx75I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNp9XSWq1M6NNM1vhjw0yblQhHa+1GCAvopgCaed++c0SdXMiExhxv7fh3gSahKFH+CoQg5St81RY2ySQOOyyTsHG9EI1J/RaWNny5UGGT+x/xWkapu3W4iMj8D6XRcgvSuW0LZNUU6VI0DT8nIc2baZAQJ01ZU3lxj1PVZR6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOnlrfNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E4CC4CEF0;
	Fri, 23 May 2025 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748013588;
	bh=GsrKYlRnFo2LgPBmqPloVglZHVpw1rjgUueyKeKx75I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOnlrfNc+76cTq0dBfzsuD0pkdpgqjmuJUSVLNUzA955tkvO3c8ydXTbbj8B7g64H
	 HjN4XJpUj6OHiILOzQCY0O8Yjz9Z7jkBF8QH+B0GiltMA5xzVGe9yVDLCwd8pr7LAA
	 3jYRtepTqt/unBbLfQZcjRbf+GjLELTZFi8Cn0JysRmDCqT4bVVAyWKn+npbAXw+Xf
	 S9UYkBU2UXQzqNwsHR2Oog4LsJKb/MCX3BFB/DFGYeWRyHZg4L4C+mwhHqzrL+RK3Y
	 GVSJHQlX4/E5TZZUDvx2Cvua39VJ/CLyYbLfh2mJBV4vbH1ieY8+cT3FeC0KcJ6Oqz
	 OfjdnmaDERkEw==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40356cb3352so32132b6e.1;
        Fri, 23 May 2025 08:19:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPqmirtyqSlEnL97kBVGs7bOYK/PEwf254kYB/pOAAK49wlVaLomf6ImHtoE8QJPsQxHjA0JTpAAajpoI=@vger.kernel.org, AJvYcCXoOv+VWi1KnmpGsG+rhgbdOPdoUuHCHg8SsFpeEGhZgrqOSfF5DNLHhHRoTZ/T4x7jGYDoLKAxJjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCeBQ5o62E4HKjghFepCVrJ6PL9HdIuYS3WUSLDCu9TDKORWC
	YoX1qHi9iw8T385kN17a3fPZLdD9xbgzKigKsQP9osFrVOD5aVcwKNHgKBJervqy4H3GujQ5eU7
	RnoBOhQqEEyGk82s+92buO7GnwZqL1CY=
X-Google-Smtp-Source: AGHT+IHPmjFpjw3qKgfuzcY4WQBFbM52qXPB23Fn5HqrUimRCc2YddbQvsr03GtL7MMXd2LDTWME+N+xi40SrKF9BoY=
X-Received: by 2002:a05:6808:4244:b0:406:44c9:480 with SMTP id
 5614622812f47-40644c90565mr373451b6e.5.1748013587516; Fri, 23 May 2025
 08:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522021649.55228-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250522021649.55228-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 17:19:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iT66HGuXG7G78G1=44DOTFgZvH=53ghsYWXyj1Pd+dHA@mail.gmail.com>
X-Gm-Features: AX0GCFsYMVPLEr3Yd3TzyKAFGj_GtVfcUDjZ5M_y4NEQ7SGcMofyOTApUte5dHE
Message-ID: <CAJZ5v0iT66HGuXG7G78G1=44DOTFgZvH=53ghsYWXyj1Pd+dHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PM / Sleep: Introduce and use system sleep lock helpers
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, tzungbi@kernel.org, a.fatoum@pengutronix.de, 
	jani.nikula@intel.com, joel.granados@kernel.org, paulmck@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 4:35=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> This patch series introduces wrapper functions for locking
> system_transition_mutex used in system sleep (suspend/hibernate) code,
> and refactors the existing usage in kernel/power to improve maintainabili=
ty,
> readability, and future extensibility.
>
> Currently, mutex_lock/unlock(&system_transition_mutex) is used directly
> in multiple places in the suspend and hibernation paths. This results in
> boilerplate repetition and makes it harder to change the locking mechanis=
m
> later if needed (e.g., for debugging, tracing, or replacing the mutex
> with another primitive).
>
> Summary:
>
> - Patch 1 replaces mutex_lock with lock_system_sleep.
>
> - Patch 2 adds a non-blocking `try_lock_system_sleep()` for code paths th=
at
>   should proceed only if the lock is immediately available.
>
> - Patch 3 replaces remaining uses of `system_transition_mutex` in
>   `kernel/power/` with the new helper functions.
>
> This change brings all system sleep transition locking behind well-named
> abstractions, preparing the code for future evolution while simplifying
> reasoning and avoiding repeated direct mutex usage.
>
> change log:
>     V2:
>     Fix PF_NOFREEZE leakage on try_lock_system_sleep() failure.
>
> Zihuan Zhang (3):
>   PM / Sleep: Replace mutex_[un]lock(&system_transition_mutex) with
>     [un]lock_system_sleep()
>   PM / Sleep:  Introduce try_lock_system_sleep()
>   PM / Sleep: Replace mutex_trylock(&system_transition_mutex) with
>     try_lock_system_sleep()
>
>  include/linux/suspend.h  |  2 ++
>  kernel/power/hibernate.c | 11 +++++++----
>  kernel/power/main.c      | 14 ++++++++++++++
>  kernel/power/suspend.c   |  7 +++++--
>  kernel/power/user.c      |  6 ++++--
>  kernel/reboot.c          |  5 +++--
>  6 files changed, 35 insertions(+), 10 deletions(-)
>
> --

This is a bit too late for 6.16, please resubmit when 6.16-rc1 is out.

Thanks!

