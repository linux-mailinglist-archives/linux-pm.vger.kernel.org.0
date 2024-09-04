Return-Path: <linux-pm+bounces-13596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72B96C0F8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA66B24E6A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185241DA61C;
	Wed,  4 Sep 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV053TDa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE91DA103;
	Wed,  4 Sep 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460952; cv=none; b=ZBN8YI+/8SWE7gGOjvM46IDsP0g55ckaYcITNo4jCwM9ab9iqhCcqrF6sODoWuKMybalTcIfBhYh2iOAOKHO5pavbxY8lImDKKLPEf0Sf0UoAw5MJ69fQ52eJYQjVr/fyIZPjHxpkwOYB0Qekv/EUdWbcnvynS32nRmXrHcdPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460952; c=relaxed/simple;
	bh=hhL0OtxX8wMZuIFOQHm658p4tDBq4xMRmY8AMIyD7wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2hm8fb7QGFalwVRhpYYewYqFU8eHOJTbUBhrJWP5EaUCov27+f/yXO20ByZIALIOVWHQTy3NhTdAi1QiogT7zLXRV4//QKC/eqo6hn8Ic54Zl7mV+fJnZ9ZA9D8/bu3YsCVRsa2Q5yDXB+v5Xr2IJei8tJUYxa9kKTPXQbbT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV053TDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E78BC4CEC2;
	Wed,  4 Sep 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725460951;
	bh=hhL0OtxX8wMZuIFOQHm658p4tDBq4xMRmY8AMIyD7wg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OV053TDaaSWJpZ6umPBa2hdXCkpR/mk0LVyP4Fy9JzNVM25zG98w3Sr3rPcwktoMO
	 cw28jqIp6RG3Gc8Q2C+fS5vvkHsTVO98iFLhFNz0pFqrlFBRp1rlVfhtms7+usXUIg
	 4x34UdI0fcDcWBYlRQSK0Jf/eIYVsnbFQFmFaH4cMPovgdHco2A6NFSZgwh8cWlrmN
	 NZglhgEg5EGGLc00e+8YGmYrUoEs6N8RD4K6NZDPuNX1tzXutEYhsCnMa341Yz1cxi
	 9mzAcWcTIQO/n4LcbMRjBLsGLIz2zNDC2wr1kvGRVt/14Q/hajy3Rq5DGHZt4rktu4
	 VceRyUSgxgm0g==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5eec95a74so3847570eaf.1;
        Wed, 04 Sep 2024 07:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXifQ/hf+m5167MAgoQePYWFSpqt1LBeFs6gKxWKIsShfjqaKZPqbiLrjPiYtvy/HWgJwdLPYJQGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIuEshNF2lArBgxY+/AvESWULD3ZjiH2SKGpKewz9vvtusj+g
	ggyKrqV7gdwOFv7HBzn8Z4CKO9diLLbZN//8PVHzVOU5NJO1xm7+32dpfy8195za+8+t96bxY7q
	MA2BblVjkfRyl+xqEuPq/CsjKyic=
X-Google-Smtp-Source: AGHT+IH759wCdEgJSA6uYS7z2vHPRICDwsG8IWP9sPxFNpKNilyJK6zWWKMhd2w/Onp+OzelvmHGlHrQm9SnJMk5NRE=
X-Received: by 2002:a05:6820:1c9b:b0:5dc:cdf8:21c8 with SMTP id
 006d021491bc7-5dfacfd626dmr19388712eaf.4.1725460950683; Wed, 04 Sep 2024
 07:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819154259.215504-1-axboe@kernel.dk> <20240904142841.GL4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240904142841.GL4723@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Sep 2024 16:42:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
Message-ID: <CAJZ5v0iZqKGG+wCZYrA1t7mXvrW6Fo-Zb3d17Bofg3NSb2kPEg@mail.gmail.com>
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:28=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
> > Hi,
> >
> > This is v6 of the patchset where the current in_iowait state is split
> > into two parts:
> >
> > 1) The "task is sleeping waiting on IO", and would like cpufreq goodnes=
s
> >    in terms of sleep and wakeup latencies.
> > 2) The above, and also accounted as such in the iowait stats.
> >
> > The current ->in_iowait covers both, this series splits it into two typ=
es
> > of state so that each can be controlled seperately.
>
> Yeah, but *WHY* !?!? I have some vague memories from last time around,
> but patches should really keep this information.
>
> > Patches 1..3 are prep patches, changing the type of
> > task_struct->nr_iowait and adding helpers to manipulate the iowait coun=
ts.
> >
> > Patch 4 does the actual splitting.
> >
> > This has been sitting for a while, would be nice to get this queued up
> > for 6.12. Comments welcome!
>
> Ufff, and all this because menu-governor does something insane :-(
>
> Rafael, why can't we simply remove this from menu?

Same reason as before: people use it and refuse to stop.

But this is mostly about the schedutil cpufreq governor that uses
iowait boosting.

