Return-Path: <linux-pm+bounces-11837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB78945F1B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 16:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77E9281719
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 14:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA51E3CB8;
	Fri,  2 Aug 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWYA0KwF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848761E2126;
	Fri,  2 Aug 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607535; cv=none; b=u5Cs1Fl41b/9p2vpQoEJl2XutKAZvxPoKMY7RM64Csxl5TWXr1X3F6a3Ft4/WnnPFUs9NVTpqXXO1iUVZNGf3eFkboyj9ESjIDdJTTSbnPYuJEcu3H4c2zSYvLDlXHhnrH81t+Fea902z6KewTzT6UQz5kPqXldtraPMjXuFy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607535; c=relaxed/simple;
	bh=kwwZP5ESPlumTxf/S7quu4UkcZpMlvUMW+wn7/uQpfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLlevI9La1CovpiXfhzpyHMERByDNmjQPL0F7/7ur87mqybLsSBJHaoU9Krj++6PT8r5PfnQ6pT0b65wjUaTQ09BtN4l9PIgizlLEvwzFlLNXvIOjSo5rlVfo0KtYVDANkvIpcqNKo4w2CbZQH9D7ZJ/ovD5Smdn18dx6fd4JL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWYA0KwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3288DC4AF0A;
	Fri,  2 Aug 2024 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722607535;
	bh=kwwZP5ESPlumTxf/S7quu4UkcZpMlvUMW+wn7/uQpfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZWYA0KwF6gM3n3MpfmrB2fSeEJYxxakkcT0R9nlqO08tgrtNPjORYjx6S0L89aPHa
	 WVlIadgKJallDMSy4EcGQDk/tBmV79bBSp5b+8earJ/szWYt+cfG3fAg8PErKrBMJq
	 CuJRVc2uy49JOTOZV9spynsbGwK+h8XkNhQYZVTTEhwMiKrqXJFl7K12bAw9GzVTrp
	 6xT2IhacEJNMRnywU4QYI8nvDjsTvHNteMvR6UUe1byCgzbfjHWUOvZ5An32aEIwGO
	 t/xg4iCtRrHHsJATWe7hlyU0i0DtlaTaBFkjyJdByRM4L8iI0El0HyGLCSIqHwm7E2
	 izrZWlWvjDW6g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so1238346fac.0;
        Fri, 02 Aug 2024 07:05:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNX3MUuIBqAsm0M5yC7KBR6+FJ/LmOjJdRkUqql1K22vyKwa5MCNBq4JL6bkXU37ORDA4w4Y3UdpI=@vger.kernel.org, AJvYcCXHm9Cu8Fe4vulJhRVPrOTKc8t8VxxzgcDnZeNFUm5esFf2vfV/CpuZ1dadrW3jO1MJZMeLSyjgR9tiIPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35H1XDfar2tri+Vf/jTt2RgIjcvGL87LSt9Kr5OAcHzoOBvMs
	88DtxlRrJ4mtcaeD3zclRUY1XkSVOlb1QW87MQ7UD0Q9IMl8G0GElIxzZKDdKlzSGj2FXiBHAOW
	vJQX1oH6vwiFqKWCLEN0Gm8R7cDI=
X-Google-Smtp-Source: AGHT+IF2Ar9DcSKIvdudkHg4NP7QuJvb/SOSOO18t0NXpaUexBP5uj9vEvw552Q+cxmYQw+oPmvTATEfjqFurinwxKg=
X-Received: by 2002:a05:6870:610f:b0:260:f1c6:2584 with SMTP id
 586e51a60fabf-26891f0b20fmr2453764fac.8.1722607534518; Fri, 02 Aug 2024
 07:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
In-Reply-To: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 16:05:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gCSiQaPQD05w-QKQiNuWeh14XAVfx3=MGi24j3XjV6Mg@mail.gmail.com>
Message-ID: <CAJZ5v0gCSiQaPQD05w-QKQiNuWeh14XAVfx3=MGi24j3XjV6Mg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Use sysfs_emit() and sysfs_emit_at() in "show" functions
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, xiongxin@kylinos.cn, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:32=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
>
> No functional change intended.
>
> v3: Changed code style as suggested by Rafael J. Wysockid, thanks!
>
> v2: Adopted Christophe's suggestions as follows:
> - Fixed some formatting
> - Fixed logic errors in mem_sleep_show, pm_test_show, state_show function=
s
> Thanks!
>
> Xueqin Luo (2):
>   PM: hibernate: Use sysfs_emit() and sysfs_emit_at() in "show"
>     functions
>   PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
>
>  kernel/power/hibernate.c | 22 +++++------
>  kernel/power/main.c      | 82 ++++++++++++++++++++++------------------
>  2 files changed, 56 insertions(+), 48 deletions(-)
>
> --

Both patches applied as 6.12 material, thanks!

