Return-Path: <linux-pm+bounces-39063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E24C9B650
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF033348BD2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9782314B6C;
	Tue,  2 Dec 2025 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjpn2l2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703563148D8
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676453; cv=none; b=DWKkIJGIyARK0NNryBJthMV6Gks6jQ4on/NGGUmFEFYu82U68YOYDwiGmX86FcwB2yKrmn+b9u+kj/nqLY23Sczrgm/v3lgbwJC2ucYT3mZh65DLUyMrU+EtCJLtQw+hZ2LB6tmqfYTGXiGpHS93FAv1ehmUctbi5/JmgGv8S5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676453; c=relaxed/simple;
	bh=f604AMXJ8Naj25VU08DctYWWhunFC1FlIAv9VKdF5SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0PpoR6WbsID1eB8Erqo6DRrr04gB9RlQNNI8SDRjblVeGjBDR/BO+11q9eBuOrKfWo2X25YJwCU8MjtjrVNP13LBO5xhlC0nLMLKNnxbb910zUcFoYtSVvu61IpqmjYuxXu+hhw8Qivjoi4L8p8OthX1G7sWjgyj5hNxkvxZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjpn2l2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC57BC19422
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764676450;
	bh=f604AMXJ8Naj25VU08DctYWWhunFC1FlIAv9VKdF5SM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kjpn2l2V3P+VlndZywjoM+rrbhMAZW1aZEDm7IXea343ZwDAu0v4+CVCLowYsB/Y7
	 G/1jwDsoEJFbq+U1LXsaqHnAOu+86nfhJDIqJugbvQ1MFfPdq6TqWOwT0HK6ESAPa3
	 x+aBlZ2vybXWoCPMoAu2eQzIeLzaPziSPONlhM+MwxZ039vr6/+rgDSfZzrrlnJ6pl
	 EJf/sAviX7bohSilj0YS8LrsIhZeC47xGbx2mI97Q3G1QCAOihwM30VpfpQRBGBe/k
	 20lZi+YRu12nxbwSu3nYd9o4YgJp3rC22XrQ0MckB/beCUiCGQPiwH8IXKaNbG/+7w
	 EE/wN7vWqEogA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6da5e3353so3296932a34.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 03:54:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbITiPkm8VvROlKcbAw2044WqVlZ2Nsrb6LksLulceNdj+TeJwy28nsttY7ki0jaoslNtG4Hb1rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Az3rdw/YWVxwUV9M6RoCAQfJzJTQcODrT16kPvqm24Hf8O9S
	Ev3nj4y5Ngix8OvO0H1Vj0g/73vb6Fp8bslFClPOzFH6Rwx1yxubYIKIzg5z3nfP/2jI47smnZk
	zAF60qhqzXkf/Nq9YA4LAGmkB2hYFq2A=
X-Google-Smtp-Source: AGHT+IFkVQ5NafdmHY3yONdDYzVGIPmIcObIxvnz+SiH8b0PWwO7P5SXmydvFrWtbdILchYd8fGZPUW7CW6ppO0AHE4=
X-Received: by 2002:a05:6830:7199:b0:7c7:68d8:f702 with SMTP id
 46e09a7af769-7c7c410c455mr15317350a34.9.1764676450256; Tue, 02 Dec 2025
 03:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <6216669.lOV4Wx5bFT@rafael.j.wysocki> <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
In-Reply-To: <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 12:53:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk1XxDGqeh6Q-AZcLDWvNlGkZ2NsTSirozhZiL0PaXT0_Y3cGigK54YO-M
Message-ID: <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as freezable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 2:06=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 12/1/25 11:58 AM, Rafael J. Wysocki wrote:
> > So I've been testing the patch below for a few days and it will elimina=
te
> > the latter, but even after this patch runtime PM will be disabled in
> > device_suspend_late() and if the problem you are facing is still there
> > after this patch, it will need to dealt with at the driver level.
> >
> > Generally speaking, driver involvement is needed to make runtime PM and
> > system suspend/resume work together in the majority of cases.
>
> Thank you for having developed and shared this patch. Is the following
> quote from the Linux kernel documentation still correct with this patch
> applied or should an update for Documentation/power/runtime_pm.rst
> perhaps be included in this patch?
>
>   "The power management workqueue pm_wq in which bus types and device
> drivers can
>    put their PM-related work items.  It is strongly recommended that
> pm_wq be
>    used for queuing all work items related to runtime PM, because this
> allows
>    them to be synchronized with system-wide power transitions (suspend
> to RAM,
>    hibernation and resume from system sleep states).  pm_wq is declared i=
n
>    include/linux/pm_runtime.h and defined in kernel/power/main.c."

It doesn't say what the synchronization mechanism is in particular and
some synchronization is still provided after this patch, via the
pm_runtime_barrier() in device_suspend(), for example.

