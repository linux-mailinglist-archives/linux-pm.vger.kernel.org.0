Return-Path: <linux-pm+bounces-16974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214FB9BB9D2
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 17:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980C7B21035
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A21C07F3;
	Mon,  4 Nov 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/hNuSfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0FE1C07E5;
	Mon,  4 Nov 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736430; cv=none; b=hWxEU5RQNnc1PnxxNDjea10O2lg+plXzgMKMzLvdxPW2fmM7J/CT0KtiA1geXJ9qoXcMnICuAJF7q/geI0a0JJAJKSwbDfpIGQLqWldswwkP88/0n7XRSN9sj4lEscloXKD1osbFlsGXMqoPf9XwV4NVNozLQOThz/RfE+b1h4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736430; c=relaxed/simple;
	bh=/A6Rnxu9cU4Iq2CbyQyLuLOySCD0WO6hoD6lwfVCLHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwaiXXShOdnYMjOUtjx4eybE9UMrh0YmbHggmzkFAPoGdG/TfAWvY3bq9NlRIxCQD+wd1P1wDADs1Xt01SiRxYD0LKeu/22Q0hkuVVkNktmNd/IAb/clYsr/oFpKavLUAlxNzk+WEWYe0298J/01Z/CtkaBCf7kKlhULF0t/TTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/hNuSfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0EEC4CED2;
	Mon,  4 Nov 2024 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730736429;
	bh=/A6Rnxu9cU4Iq2CbyQyLuLOySCD0WO6hoD6lwfVCLHo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N/hNuSfrAOHXxTCsUGZpgp1ohw6GcqpaajQaq5Z1cwjuBn6NXKXgV05E55wZO9G7W
	 NbVLC8IPcS4gb9xK9UtHuQ0MJ40a31DWbOM5smKiLSbKSRRgqHLH3FEPqRtka/E2SD
	 W+cbrhHe6PbFiVxxY4N0GB1SzkbJWIJM6A6JBXWZO+xh0iWin+CR4rPp9g3nmoq1no
	 loHxsg6kH7KV6aGzXM0f8GWPnmv6QLvGQSVs3GiLj+HBQPBAYLoeUNgAa2XUU8j7Vg
	 l40uUIaJ/YTYEJ6nCt1befd8+HUYnCKUOqTY/I5Kd4FXeU0aouKV2w8FqgYOfQOgyd
	 4oj41vr2IFoRg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-290d8d5332cso1976929fac.2;
        Mon, 04 Nov 2024 08:07:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSSBfyxfHiF9zLQ9cXaX35nXDaEmHc76n5S6LuhJfmYDy2md/kzo2h3cO3o1lO4KPqiRdAxPmjyfU=@vger.kernel.org, AJvYcCUvBNIsP8Zk/E5CDV+StomVZAZp66qZQVWmEMcPirvm7UQ93gQDNh06JBYES0RZ86jxcJife0Kl9ZAtsU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUwe8xvjLVqpsz2OgnnAgBUCYd3IfAkfASxcOAHb1RP82t9YRr
	NjPVVDAGANSNbcxBcG9tXUeY1PwOhLK/ztUkBHKeHKEeWQWEitTkVKxl4grWLIsoXVK4KgTWHP9
	dgJy2BXHD7zeGOD3H4iIW4nX1xZs=
X-Google-Smtp-Source: AGHT+IGSpR/wx1iz9+3gDfp5pquieAcamLRwnTkNyTfxxB94vz+N03uO6YWi6Rr8lGIOc93Yr/wra6eaoPAqYPMUAeY=
X-Received: by 2002:a05:6870:194e:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-2949edb7144mr8773738fac.14.1730736428908; Mon, 04 Nov 2024
 08:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9133c24d-a425-4c66-ab0d-31876730bfd3@linaro.org>
In-Reply-To: <9133c24d-a425-4c66-ab0d-31876730bfd3@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 17:06:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j-OXYJXt79Cd=__PTmdScXh53nLJB5FG0X2QBUnjN7MA@mail.gmail.com>
Message-ID: <CAJZ5v0j-OXYJXt79Cd=__PTmdScXh53nLJB5FG0X2QBUnjN7MA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v6.12
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Emil Dahl Juhl <emdj@bang-olufsen.dk>, 
	Icenowy Zheng <icenowy@aosc.io>, zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Nov 4, 2024 at 4:47=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
>
> Hi Rafael,
>
> please consider the following fixes for v6.12-rc7.
>
> I wanted to send the PR last week but I've been busy with other tasks,
> sorry for that.
>
> The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf2=
30:
>
>    Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.12-rc7
>
> for you to fetch changes up to 725f31f300e300a9d94976bd8f1db6e746f95f63:
>
>    thermal/of: support thermal zones w/o trips subnode (2024-11-04
> 15:38:29 +0100)
>
> ----------------------------------------------------------------
> - Remove a false lockdep backtrace in the LMh driver (Dmitry
>    Baryshkov)
>
> - Fix sampling handler context ptr in the libthermal (Emil Dahl Juhl)
>
> - Remove the thermal soft link when doing a make clean. The link is
>    created at compilation time (Zhang Jiao)
>
> - Accept thermal zone without trip points as stated in the bindings,
>    otherwise the thermal zone fails to initialize (Icenowy Zheng)
>
> ----------------------------------------------------------------
> Dmitry Baryshkov (1):
>        thermal/drivers/qcom/lmh: Remove false lockdep backtrace
>
> Emil Dahl Juhl (1):
>        tools/lib/thermal: Fix sampling handler context ptr
>
> Icenowy Zheng (1):
>        thermal/of: support thermal zones w/o trips subnode
>
> zhang jiao (1):
>        tools/lib/thermal: Remove the thermal.h soft link when doing make
> clean
>
>   drivers/thermal/qcom/lmh.c   |  7 +++++++
>   drivers/thermal/thermal_of.c | 21 ++++++++++-----------
>   tools/lib/thermal/Makefile   |  4 +++-
>   tools/lib/thermal/sampling.c |  2 ++
>   4 files changed, 22 insertions(+), 12 deletions(-)
>
>
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

