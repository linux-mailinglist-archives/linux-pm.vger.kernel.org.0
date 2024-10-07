Return-Path: <linux-pm+bounces-15277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BA9931EA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53B9281039
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63C1D9695;
	Mon,  7 Oct 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k601a1in"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E11D95BA;
	Mon,  7 Oct 2024 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315995; cv=none; b=btVNsoJtBa7rmRkPnhCc079fg42rCGZ+IcbbQG+Ip5V+FuxKfpU9qLISJntowEkb4WO63Zcv94zimtKxugmM1MLUMEgQKi08dnj7mDILWZYdVPbjiXH5PSSufq5S10QmmuXy+cP4WeOZlJO/ZCNqI1sFhTzOBhImeS+LFiJn5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315995; c=relaxed/simple;
	bh=pJyM3vKd+1wtEQVXEtJy+8R+UUj+RCJPn+31MBo9MUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oulks8ygsinUNfxeDsnJV7sezsR0+bxnEGXlLU6C2bv6p0nvxmVj3rOhjN7TK4w1i1lukxiXVfKh+kjouu+ywTajq5thlqis/S+GdftWb4toWDQFdFluux5lh4pTsyjPGld4JUFhO+b6DOGJkWeP8J9LL1jPGUEJYKF1UYgzP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k601a1in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F830C4CEC7;
	Mon,  7 Oct 2024 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315995;
	bh=pJyM3vKd+1wtEQVXEtJy+8R+UUj+RCJPn+31MBo9MUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k601a1inC2MEhWmWposbEH1MqiBGUjZZhJFRXh7nj+nS9NcsKAqvQeuCnUF7vLnYk
	 i/OwMSdn5zwU0nySdz6t+gCpIxw8oRvzL2D/qk+o/2goY4+hIwL53ZjO29vrSHWwb4
	 QF56OSJV/QuqHzlT7Kr13s9m8CfcPOszvJQ7Rx+w3qEijNkd7eFJOuyZE/kZhqbQLR
	 1j4C7DdFgSp77KAGFu3yayAoL3WQRUJTEUtGyVI29WaB7nsw/O7QGPWpVahmqbRsev
	 K9zps2mVnTXw52MuOHql56L6U49FJmNtMLU65ErFO49nnOG/T4JHnIXnpWxnuejJuR
	 WA71Lbl0kZh9w==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-712422564aaso2697378a34.0;
        Mon, 07 Oct 2024 08:46:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOQ0dyLcW6VPgLRBNS7998K1Bogc7P6P/sD9AXbFC3bF+bAxuoKgMVpOR77bN/FnoNmkWA57z4UfU=@vger.kernel.org, AJvYcCXinJgjoLye4cWXLyNW2dS4aXwFT+FlHVkNMu4hi3XyJX9s+GoRyF6lDH+iD6wV4NBc8iLwJNbq4Sx7kQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcg3DLMypKcT7g4mIONhzPdu9vQrihmZ7o+W3smAyU5Ua0Zwb
	HTrk066KyFN4pKVtpJ7ZOuPEJP/vqoK5n7UMRnQ9ZG8jGwIYztE77IBk4ZUH1JGBZ1Y7oZQxZ85
	Ei/6rqJQcZZSNd/o2/L+dNmZ5QO4=
X-Google-Smtp-Source: AGHT+IF4P5Dpy4e2qcOZY01OHsdvc/SJQMXdDJvMpYopTQOtlHoLdcVlToff/Q1t75jastspcNbr2ipvqQmYGo2nmHY=
X-Received: by 2002:a05:6808:4482:b0:3e3:af13:e90 with SMTP id
 5614622812f47-3e3db597ffemr31282b6e.3.1728315994327; Mon, 07 Oct 2024
 08:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com> <CAJZ5v0hoiPo6Q=K=q-EoCNsunr0zLGPJgK39LwnjsSr=btmjOw@mail.gmail.com>
 <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com>
In-Reply-To: <ac6aab6d-51d8-47e8-8508-8cc52aba227b@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 17:46:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
Message-ID: <CAJZ5v0iKOQkAUuZaHf1Zcm5sO6xD-dYkeTg8nyC3EuMmY0qDqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	ray.huang@amd.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 7, 2024 at 6:40=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
>
> Hello Rafael,
>
> On 10/4/2024 11:47 PM, Rafael J. Wysocki wrote:
> > On Thu, Oct 3, 2024 at 10:44=E2=80=AFAM Dhananjay Ugwekar
> > <Dhananjay.Ugwekar@amd.com> wrote:
> >>
> >> Currently, there is no proper way to update the initial lower frequenc=
y
> >> limit from cpufreq drivers.
> >
> > Why do you want to do it?
>
> We want to set the initial lower frequency limit at a more efficient leve=
l
> (lowest_nonlinear_freq) than the lowest frequency, which helps save power=
 in
> some idle scenarios, and also improves benchmark results in some scenario=
s.
> At the same time, we want to allow the user to set the lower limit back t=
o
> the inefficient lowest frequency.

So you want the default value of scaling_min_freq to be greater than
the total floor.

I have to say that I'm not particularly fond of this approach because
it is adding a new meaning to scaling_min_freq: Setting it below the
default would not cause the driver to use inefficient frequencies
which user space may not be aware of.  Moreover, it would tell the
driver how far it could go with that.

IMV it would be bettwr to have a separate interface for this kind of tuning=
.

