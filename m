Return-Path: <linux-pm+bounces-4399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85896867297
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED53B2ED57
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA5524A7;
	Mon, 26 Feb 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKGIz79v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31D51C2E
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943307; cv=none; b=mtbrLKV+frWhxiJjj/hw3eI0pkLx+tcW1yKIS8aI18LolZY/umwjGS6W8Ed5cFVM2JquvIxjvJOSQsjprHXMnfdwgX/n1l3tz4jSDhNaHqOiUOYtGuYf7f7eELD5+S8XmXdJwAVcV0RJbISwMPlwvVF+aO/OJJqffDHJo6yYsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943307; c=relaxed/simple;
	bh=waWe7OOZqahMFAXntvNTQ2+JkvgINPphRNC6W6LEW2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y47CGJX0A38KSzWJj3lk30mriKbEHmaeCNN+Fg+KZSPvZF4Hhat8MkUTlGMT5AEeBkpIcSz9WrH0B1KzYZkT9SuH8VpyKXEyfWZhXZx4TN+iRHcJLKjKNefmJcfrENXG3228E0OkKMV+ej2RQjTYoK79c5e3Qc+KPpx7BgSQzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKGIz79v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso15332a12.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 02:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708943304; x=1709548104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rfRwBowmUFktKeSXXFXGsqMq0Ukd1jU9ormvR1IvtI=;
        b=cKGIz79vMSfWFtztdJAsvWXoJQgfKaDkcdWPbQqeF6/rVwgDj+SI1+pobg7W55ac5y
         Jx/xDTaV3Yi4KZKhBCpsDI0coyxt+N9e3OFLu2xbtmJTsnJO40yqM8xK6PTTlxoHjWFu
         dRPjMtFbEDe4Ib0+jw1eJjXlpU/T/CcQ7NT3stDE/WVvjjnp83OcHO/rOafHhNYX5C4H
         XQH/xcZ3LVqL2o3hsStG4Tp6Ffz7GDGzDQvvCe4CjwshtKf2RnkaJGJ81K5eoMMf47O7
         gdGAYmdiG8R64Laooiw/olWQVPYGNGWi+1n/65MtahwprUyPHFh2gPPKb1aKLRc54FWx
         dEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708943304; x=1709548104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rfRwBowmUFktKeSXXFXGsqMq0Ukd1jU9ormvR1IvtI=;
        b=viFvNVOlgPMTrzkhZBAh6GAChKJeMAfvRqeNxrnyOOnUgyGQmuNBz8O6T3cv3GL5sc
         /3JBDikr6UqjIGJrZYTMfB78pqKRcLM1V5HR1zqb0g0onKZBTGF1YYh4wmxTohMdsl1A
         sGEatcL+/hx9gOOONTo9xuFmkmfTnDKW9uFuQdbdpLSonWg5ToczNUcB+7YcMxoa38xi
         tXksM1g4diOXQKg3lQMLCPtx6NaSVXkZWry1qi5OjBNfsM5x0HpPEEuNaeXNBXaM4sBX
         El3lQC8fdcm2LgXJv4kHytxo1mPx+7cxVu642Eq1DmdL6yA/y28e6/TOocSKZ8B6I7wc
         eiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWMlece7H1XK+zsWV9ISHduzOcPcjyLpHwmj/vXg/dTYoOzemED9ES9Exdix+kGe08tWCdj4+MZ015weAUkBMN+iREhf6uG+KY=
X-Gm-Message-State: AOJu0YziR6M4BarKpwW+Fkf7RLd9bkZOJZeCEmmdj8V0yVo1hx1HA8Ud
	+me0AvlFtIw2H7UG9JeZZjMvvyZxFEw1KPDW7KVC+A85pyq8Wu/80GjwD03QUTXwOeQemVagCnS
	FCLvlml8bO6JhVz6NgBivVLhNAOQcOL6lnjTQ
X-Google-Smtp-Source: AGHT+IELZ4/+1yceKUOXF1OW2l/m9kzRNhkxpc47HL7wUVrNJOnYJONx4oMWuJfC6Y2/nmM8qzK5lAwpCUs5GN8aJSw=
X-Received: by 2002:a05:6402:2693:b0:565:ad42:b97d with SMTP id
 w19-20020a056402269300b00565ad42b97dmr204645edd.0.1708943303993; Mon, 26 Feb
 2024 02:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com> <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
In-Reply-To: <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Mon, 26 Feb 2024 18:28:00 +0800
Message-ID: <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rdunlap@infradead.org, james@equiv.tech, 
	broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 2:20=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/23/24 06:38, Guan-Yu Lin wrote:
> > In systems with a main processor and a co-processor, asynchronous
> > controller management can lead to conflicts.  One example is the main
> > processor attempting to suspend a device while the co-processor is
> > actively using it. To address this, we introduce a new sysfs entry
> > called "conditional_skip". This entry allows the system to selectively
> > skip certain device power management state transitions. To use this
> > feature, set the value in "conditional_skip" to indicate the type of
> > state transition you want to avoid.  Please review /Documentation/ABI/
> > testing/sysfs-devices-power for more detailed information.
>
> This looks like a poor way of dealing with a lack of adequate resource
> tracking from Linux on behalf of the co-processor(s) and I really do not
> understand how someone is supposed to use that in a way that works.
>
> Cannot you use a HW maintained spinlock between your host processor and
> the co-processor such that they can each claim exclusive access to the
> hardware and you can busy-wait until one or the other is done using the
> device? How is your partitioning between host processor owned blocks and
> co-processor(s) owned blocks? Is it static or is it dynamic?
> --
> Florian
>

This patch enables devices to selectively participate in system power
transitions. This is crucial when multiple processors, managed by
different operating system kernels, share the same controller. One
processor shouldn't enforce the same power transition procedures on
the controller =E2=80=93 another processor might be using it at that moment=
.
While a spinlock is necessary for synchronizing controller access, we
still need to add the flexibility to dynamically customize power
transition behavior for each device. And that's what this patch is
trying to do.
In our use case, the host processor and co-processor are managed by
separate operating system kernels. This arrangement is static.

