Return-Path: <linux-pm+bounces-39076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54550C9B98B
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2B9B34838A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16CB31578F;
	Tue,  2 Dec 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1BXZmM6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3EA314D36
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682203; cv=none; b=IqmsZb+HwK5TZ9/rhf2afy3R3hDnUB4xJY4OYjyWzUsBVBT0ykKYbvN8mIrVHHOkNp2XQtA5iKV7mIU9K4YMEZjInfVLgZyYWxSTEZn9ozh/SGEGGAKmGXIHTvO6Fj0DuADTPPYFbo3bgXCENGkbXlnO5hIBH8GvxxDG8yCzRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682203; c=relaxed/simple;
	bh=TS4r+qjprUed/M1R7jCn4HKF//CDYXUigfSbXpKk5gM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POIoka2A0p0BLjxCynzmAxC4ogTB73Cwg8Vp6I5r+DFRMkIoIRDo1xYnWP7a6gxdZqaoz5Cex2tFApXNVS3gvWX500T8yIRyS6Why2GSn6XYnHjjDHM8OKImXVi7B6kBYnp4oltoo/0N75wySBdxs+H7BUXjAQ4P4lHe26uMj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1BXZmM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEECC113D0
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764682203;
	bh=TS4r+qjprUed/M1R7jCn4HKF//CDYXUigfSbXpKk5gM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1BXZmM6ln+hR0TRjcDyh7zuWHsHdtv4X36PwD0AWr4w9/RbYSsT1ivvrVFQpQsUf
	 z7uvdXtjVhiuq8Hiyh16fxhAXh1Nj4e7D4fy6MdaMHMdBjvpb71MlZabLiN62pt5/q
	 wrnqyTI5k+J6q4Hw2lNxbKHtJZ+y7qU2SorCdCe7RY0+wfuXmDFYiA7fF5QvU7bzSA
	 fzsj3tjBEeDa6gN3610zh4uzpEOoNe2PZBT/3c0Sk41yGqqzyHPUncTy3kqUENbUnz
	 0N7WEkb1IlJlTfOaZ2ff50IRMGMoKV0KjCif+stbg6p51qOcxs4YPMPQBogpovjgBC
	 AwRVkp2SY21Sg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6dbdaced8so3681937a34.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 05:30:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX27GNLQm9ZZBXHR/R/kj0l4vOxAbYLILHIms7ZTsO6uX0wBs7gl1qlWiwxr1YzEo7mfjdfBL82SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AV2uDUux9P4spEZNTWMzdSSA1Hssnx3Nh/O/QLYhQKmnO+Rs
	aZDcQPuks0pKUq2TqoO6zq/uilJAmotRUf2X19mZxVCaXpvnOMLTkckwJDX3I65I7EORAmWqSp3
	3s4u7sZiqTCcv+nXK/jXVLXeAfdUaRwg=
X-Google-Smtp-Source: AGHT+IF3yHoW2CVTJCfN9++rhwnnOq/mOV/84E7HmhnO1NEI0oNASrxDzkiHFFKvEYxqO7tXjcuUCGmqOqQRdi445oA=
X-Received: by 2002:a05:6830:440e:b0:7c6:e92f:41ca with SMTP id
 46e09a7af769-7c7c42a837fmr21459327a34.8.1764682202512; Tue, 02 Dec 2025
 05:30:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <6216669.lOV4Wx5bFT@rafael.j.wysocki> <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
 <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 14:29:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iNGq-O9pbKaGGiqiY-xD7qndXkJ8oCdTxkuWE8CxLQ=w@mail.gmail.com>
X-Gm-Features: AWmQ_bnFbEwf3mTy_EZR8Kp-QEspdSrFnxUC-99gc4UoW0TwogPKtkTVVVn0XEk
Message-ID: <CAJZ5v0iNGq-O9pbKaGGiqiY-xD7qndXkJ8oCdTxkuWE8CxLQ=w@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as freezable
To: Bart Van Assche <bvanassche@acm.org>
Cc: YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 12:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Dec 2, 2025 at 2:06=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
> >
> > On 12/1/25 11:58 AM, Rafael J. Wysocki wrote:
> > > So I've been testing the patch below for a few days and it will elimi=
nate
> > > the latter, but even after this patch runtime PM will be disabled in
> > > device_suspend_late() and if the problem you are facing is still ther=
e
> > > after this patch, it will need to dealt with at the driver level.
> > >
> > > Generally speaking, driver involvement is needed to make runtime PM a=
nd
> > > system suspend/resume work together in the majority of cases.
> >
> > Thank you for having developed and shared this patch. Is the following
> > quote from the Linux kernel documentation still correct with this patch
> > applied or should an update for Documentation/power/runtime_pm.rst
> > perhaps be included in this patch?
> >
> >   "The power management workqueue pm_wq in which bus types and device
> > drivers can
> >    put their PM-related work items.  It is strongly recommended that
> > pm_wq be
> >    used for queuing all work items related to runtime PM, because this
> > allows
> >    them to be synchronized with system-wide power transitions (suspend
> > to RAM,
> >    hibernation and resume from system sleep states).  pm_wq is declared=
 in
> >    include/linux/pm_runtime.h and defined in kernel/power/main.c."
>
> It doesn't say what the synchronization mechanism is in particular and
> some synchronization is still provided after this patch, via the
> pm_runtime_barrier() in device_suspend(), for example.

Though there is another piece of documentation that needs updating to
reflect the changes in this patch, so I'll send a v2 at one point.

