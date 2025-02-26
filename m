Return-Path: <linux-pm+bounces-23019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B055A46997
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 19:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A36A1736BC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 18:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED71238D5B;
	Wed, 26 Feb 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnxcBT5Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627072356B2;
	Wed, 26 Feb 2025 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593921; cv=none; b=X5j2yHLIbn0J7NGK3KhpGx7nJ9RM/ONE6FplTip9u7K6HpjoFid8h8RJRfakRex3e8cG6twmU3pOweZ4WlmMmBUmQX/Th161t+S3OUhheHJfh31M+l8mwSzaSrq3ukfBbfba5eVxR4npd8W1ESywx1cstaIQK5oFZB7Zp/CSNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593921; c=relaxed/simple;
	bh=I6uZ3dubqopcXOEdZGEs1cSZizLSjhh+Xzs4+YI0Z9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRpBVEbnnCwWIrECD9FBUCw+TvjTeRacD/Eein8jpFTVU/bcEN6TC4f6of+jMDcYrufmOtAh7wso1anDFS8ZYoNYqTUm5K8XeT6cWLOlQvgW1ouQQMq8qer8LLOjeubB5ZA+GDNJj5gz5mXd7N7ypjMrwMznemUZ5FsXS2wtDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnxcBT5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D858BC4CEEC;
	Wed, 26 Feb 2025 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593920;
	bh=I6uZ3dubqopcXOEdZGEs1cSZizLSjhh+Xzs4+YI0Z9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VnxcBT5YS33uu66ssViE3OsbbOU+0Gwfa83ZtM9wbsnoE25Ejv19v4XNyvl623rcR
	 8mC5MHmEGFTYaSh0DbrH0A4EQGLndlkKvMaPNjxfpXTExkmHsanJaAFy7kciZhpWH0
	 3DjQJrZhD+A5aZJLce7NxcbgtTKrGL8Nl0yexYVg5wH61Smd3d7Bhwspp7ILBWj6rf
	 ZMM44qEWCnZ7VaoYQnAOUmUBD2hEboPd6MUP9wHVmbqRwlBqFXOXkKonMRfGQAJFgF
	 spdZ4qXxELo8CAGh1p8a6NjR/elqkZcXwbvd0eWfhky6e8MhUxCy4vyWJIxnKwxl+u
	 /5o3wdft5xbDA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso112359fac.1;
        Wed, 26 Feb 2025 10:18:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3gw2mX7+Vxbd4uBjAIUW3b+afuzzRGWE3I+/vqAEHT+wOIDP8+GolL3WwX8xiy1vzw/8MZQk5Y/ggqM8=@vger.kernel.org, AJvYcCXUDNR93+7zk20c19AgfAqKzmoWmQW2JBLdZ4tFPW9OcaP+ZEcy6QwzdydEHiLeEbt+GcDS+ZnDhTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wvHHLNO45rvuoYWlE9xaRF3bBsKd7OBfYGgfZBXbQh8h5DjP
	irgkLeZ0K7VR4sMpbEE6UsMMuPfkhc3G6QLpL2BL+FJbSFaHGTvZ3VorpMCskk3PTf6BFVysab/
	X5TUpGi1DOnMFpADpTde6iIyEoo0=
X-Google-Smtp-Source: AGHT+IE2kmXQsWSG7myXgUfM51bmNQDYKRwO4hv8qqCQ4cQ+cPJk5SEUokPYyteIO5x0nzk/onRfjaO32NpiFjty/X4=
X-Received: by 2002:a05:6870:a10d:b0:2b7:ecaf:59d4 with SMTP id
 586e51a60fabf-2bd5185ac3dmr15454643fac.38.1740593920019; Wed, 26 Feb 2025
 10:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CF154B5C3C8E7E64+20250224074357.673094-1-wangyuli@uniontech.com>
 <CAJZ5v0iigAB97mGBe6Uvr0v0spjqDKan-0O9XGObt5b4ZBvM7A@mail.gmail.com> <tencent_18C611757FED8D54331785FA@qq.com>
In-Reply-To: <tencent_18C611757FED8D54331785FA@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 19:18:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jqEPMQ1rLpeH0ZV8DcsJMOXdyoYPwwRkr=2vUBCADjVQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoGe9ZXilDP7_kh_pdoEO1ILfk23DI97JFXc7XPNsuzaQey6zCxvHz8cvo
Message-ID: <CAJZ5v0jqEPMQ1rLpeH0ZV8DcsJMOXdyoYPwwRkr=2vUBCADjVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86 / hibernate: Eliminate the redundant
 smp_ops.play_dead assignment
To: Wentao Guan <guanwentao@uniontech.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?B?546L5pix5Yqb?= <wangyuli@uniontech.com>, 
	pavel <pavel@kernel.org>, tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>, 
	bp <bp@alien8.de>, "dave.hansen" <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>, 
	hpa <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?5Y2g5L+K?= <zhanjun@uniontech.com>, 
	=?UTF-8?B?6IGC6K+a?= <niecheng1@uniontech.com>, 
	=?UTF-8?B?6ZmI6bqf6L2p?= <chenlinxuan@uniontech.com>, 
	Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:08=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Hello,
>
> Thanks for your reply.
>
> In my opinion, the only logic different before the patch is delete smp_op=
s.play_dead
> save and restore, as the comment "the resumed kernel will decide itself" =
and same
> logic as which in arch/arm64/kernel/hibernate.c, the ok path will work as=
 expect.

Yes, the OK path will work as expected so long as smp_ops.play_dead is
switched over to resume_play_dead before calling
freeze_secondary_cpus().

> When discussing the error path and ret value that we not restore play_dea=
d,
> I will try to analyze the difference between native_play_dead and resume_=
play_dead,
> and sev_es_play_dead [the all possiable three value], and I see some mwai=
t and hlt
> way difference.[maybe it happens as disable the cpu failed and goes to En=
able_cpus
> path in func:resume_target_kernel in hibernate.c? ] Is that it desgin to =
do and we can
> move it to a common place in hibernate.c and left some comments ?

Why not leave it as is?

