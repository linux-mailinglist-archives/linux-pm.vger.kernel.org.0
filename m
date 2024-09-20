Return-Path: <linux-pm+bounces-14502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F098997CF9C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 02:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67E71F257EC
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 00:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AA161;
	Fri, 20 Sep 2024 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYanrSgW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+5pYRI3"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CE23D2
	for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2024 00:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791271; cv=none; b=g/PbKcdzvnIMHCzAFz8k1AeCAazFqUqcDHGbf2YesNeVBEwF4GtK/Uxz2coGiYdoWXsjItqGzaXf7e45Dg7fegDX5lJciUDBthrBUTAnb9Z+HT0yCrLaCkAXuOQpnZQIEc9WpVdkv8Qz6RdyxJrR2M3EtptuNU6fxW1noHTOrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791271; c=relaxed/simple;
	bh=bJay0z8p7NeSNqx26YJHjpsn4uFklt4pSjRJ+ihJz/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Op/dTZnZ784f1OHAvnvOtTkKssu7LDlBW1qyZ2fblKt6QDKdBbz2FPbDH0M5VUxipHo/G9W4/bmhr/sHeF5qs2Ku/opUzEXiSsI7VOvuXLd9BBzj0GyI1+Qp4YVcy0nV4zfVW24L9vD6HOcLiLFobIYQuC45evVglnPXkB3k0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYanrSgW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V+5pYRI3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726791267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJay0z8p7NeSNqx26YJHjpsn4uFklt4pSjRJ+ihJz/s=;
	b=TYanrSgWug8D475ZoA/uyaYTvpbdjNtZhpP3DKGCWG452tzlrWywD3SVB0Q3Ypc0vOy/yX
	E1eVj/JNnA/C8ueaDpIxej0HpK5QUHtcB5dGwwjMrNua3cAf/O2xks2IRxSnXqe/NQFnCf
	wTaZlzx0lHu9+F1bbvE+SffrF+iI4T70tu9S85qcpH3sFGh4h6gBExZFp+8Nnds/J5qn/d
	MF+y0tAMgmhL1glvxg17cZE+2XDE8BrKwoBKzpWNFz4/CMFjaxX6xBWYT6rlhNhJuNpUuu
	aLcss7g/H/PIx9+BXPVApD7poULWgds3jX607sUXqry+BpHpW6vmEGLSrFcK+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726791267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJay0z8p7NeSNqx26YJHjpsn4uFklt4pSjRJ+ihJz/s=;
	b=V+5pYRI3+GnrGsCEkWFr0fFY3xTk0vQlODOG98cNUiBd7e23e//8mVOPZb2w69l0igKQqm
	YoXrv+c1MAwzYiBw==
To: Petr Mladek <pmladek@suse.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
        linux-pm@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Linux fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
In-Reply-To: <ZuvmcclM_HzdZtwP@pathway.suse.cz>
References: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
 <154114fb-276f-45f6-bba0-98133c7c5d4d@molgen.mpg.de>
 <3b600845-77d5-42d3-8556-53cc0b2eab25@molgen.mpg.de>
 <ZuvmcclM_HzdZtwP@pathway.suse.cz>
Date: Fri, 20 Sep 2024 02:20:27 +0206
Message-ID: <84r09fqizg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-09-19, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2024-09-19 10:17:24, Paul Menzel wrote:
>> On the Intel Kaby Lake laptop Dell XPS 13, Linux 6.11.0-04557-
>> g2f27fce67173 (=E2=80=9C6.12-rc0=E2=80=9D) fails to ACPI S3 suspend the =
system. The
>> screen turns black (as expected) and the power button LED stays on.
>>=20
>> Doing
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 echo N | sudo tee /sys/module/printk/parameters=
/console_suspend
>>
>> and on tty2
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 sudo systemctl stop gdm3
>> =C2=A0=C2=A0=C2=A0=C2=A0 sudo systemctl start getty@tty1.service
>>=20
>> and then on tty1
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0 sudo systemctl suspend
>>=20
>> I see some panic messages and traces containing ktime_get or so, but
>> I failed to save the messages. (Hints very much appreciated.)
>
> You might try to enable the kernel crash dump.

Yes, having a crash kernel and then extracting the dmesg buffer from the
previous kernel would work well.

> Or you might try to set some delay in /proc/sys/kernel/printk_delay
> and make a photo of the screen.

If you are seeing the dump but then it disappears too quick, this would
work as well.

> John Ogness told me that there was a trick with a permanent memory.
> But it seems that there is no permanent memory on the laptop.
> Adding John into Cc.

I guess you are referring to [0]. That is not (yet) available.

John Ogness

[0] https://lore.kernel.org/lkml/87h6dhxgel.fsf@jogness.linutronix.de

