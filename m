Return-Path: <linux-pm+bounces-4432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2F5868B6B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 09:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C5FB22B55
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C02132C17;
	Tue, 27 Feb 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTwnlPNy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0157BAE7
	for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024202; cv=none; b=MBM77iF8pQlUHXv7aOT6RawnrH31HABf4E8dC6LGdosSyvlj42gpKAvzPQbzW1ppMVxW4AFQhexO0qDHBwXwH8nmVm9Zgxxgz1rOoaRl3bRGGxsw+X1WWK3jqDUbBateFFzYdZ+xYoqK1Z1tj78JNHyfKc5lPhMin2s7pdJexn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024202; c=relaxed/simple;
	bh=53omt5jEIdwTl9xhFqn0ez1SbwdixDR3P28VJ6K+SYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSKYaergln0gKmQIbkDyaZKrzVa1jZMA3MZSoVCswknAEIDQNRvpCpEUOBD+pM/x7kLnXMcxzwU2P9kXmSjMwqnGc3KfJu3p6yyj4oIFYJMwqVyggGw+/Lu4pwFF35y7seS67a9c8YqPuI4m27oMXT85F9E1KiYBeeQu1e9P0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTwnlPNy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5130166b31cso1557e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 00:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709024199; x=1709628999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ky9wQvkdGUKNyCVZuhuPCWbq/t59roSlceuaG570uVQ=;
        b=QTwnlPNy3vv/f1TMGOPKXUZNgaGIeLsrfjINs3Xs3QUi3ph5h4Mtdgs5YWnq55aU19
         3okxbomzGYcufGWTyzEojPN0J2//is24y+wGEWhidYqM2p+bDNhxpWbDd8VPxtvugQL5
         sgXLPkeBRQqAeFyn5vGtWOTQER9Qa4kbo/y09POicE9Uxvp3c3MDpnZXyIYbDiPI8cl3
         7WP8d319hZFJ0DWjaNntTGnbqUFJlZRuGXe+ssukL9o0coYLjrh7Z2hCUS0DXJptUIs/
         MYbn+EY6oRLfizWgQ2jFYjJ0hjslEQCFnQ43EN4jWlaabHp/cdfw7UQSuFV7EyRnBcg5
         oDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024199; x=1709628999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ky9wQvkdGUKNyCVZuhuPCWbq/t59roSlceuaG570uVQ=;
        b=N15GHegX2lSCVNbw3ir20xrODhhosOTU2+f6yG50qlzRcVld7O1aBNK5ALbhooyaor
         pqRZ67B8PzDGR7mmVy+/NuLzZeYdsmWdT1pMXGMhnSqJqIi/V8DcsEiKaPiqvl05CQBu
         3rCqM995bqAPBEX3WsejVIfGxgSgklXuprRsE+h1ckE2vMI7/eKXu70r4p3QVOkJ/Ajt
         cBZwusCanMSNhc5mqKtIncJ7kUcHBV3My6Ad41bn7edqn8MMVkvuumuvC69PdDPELVSs
         o0vjNepiQV1lPwaAbGdITLwW8aKsddagN831QonZJb3zbDoNNatDNJlDM72vy6egMRwo
         7q6w==
X-Forwarded-Encrypted: i=1; AJvYcCVYz9ckQIuhEWLPGlRlc/Qj2yXyMyWZ1y9PaK9Gv/q7VMkZGfaDhjLe2yvP7c++X030msWPNbYJVK/MWfNEf50/IDkskTey5e4=
X-Gm-Message-State: AOJu0YwXa+YP6yHjyfUceZG4EgSTaZIuUksbNsrbOzpcr7LJvUMmFZLV
	ikJjrN1LyyJ1cQ5tO8ZawbFDzPWTpOGp+uMs7uWmTQV1FBomOkiqzKZ/LLff8w+dd3b/LFdZGp+
	4ZNNrwMcbpQg5vzXYwvOST4h70QSphRRKPmVw
X-Google-Smtp-Source: AGHT+IHKyiGlVKc9EMSd5FL30+6tfYqUuRP7ea9HHWuG2gjEgFZdxXlRD2RcJ6j5pqzEW1r0JVmvC3gfdD+rS2w25NY=
X-Received: by 2002:a05:6512:b94:b0:513:ed7:c656 with SMTP id
 b20-20020a0565120b9400b005130ed7c656mr36903lfv.2.1709024198656; Tue, 27 Feb
 2024 00:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com> <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
In-Reply-To: <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Tue, 27 Feb 2024 16:56:00 +0800
Message-ID: <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:40=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/26/24 02:28, Guan-Yu Lin wrote:
> > On Sat, Feb 24, 2024 at 2:20=E2=80=AFAM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> >>
> >> On 2/23/24 06:38, Guan-Yu Lin wrote:
> >>> In systems with a main processor and a co-processor, asynchronous
> >>> controller management can lead to conflicts.  One example is the main
> >>> processor attempting to suspend a device while the co-processor is
> >>> actively using it. To address this, we introduce a new sysfs entry
> >>> called "conditional_skip". This entry allows the system to selectivel=
y
> >>> skip certain device power management state transitions. To use this
> >>> feature, set the value in "conditional_skip" to indicate the type of
> >>> state transition you want to avoid.  Please review /Documentation/ABI=
/
> >>> testing/sysfs-devices-power for more detailed information.
> >>
> >> This looks like a poor way of dealing with a lack of adequate resource
> >> tracking from Linux on behalf of the co-processor(s) and I really do n=
ot
> >> understand how someone is supposed to use that in a way that works.
> >>
> >> Cannot you use a HW maintained spinlock between your host processor an=
d
> >> the co-processor such that they can each claim exclusive access to the
> >> hardware and you can busy-wait until one or the other is done using th=
e
> >> device? How is your partitioning between host processor owned blocks a=
nd
> >> co-processor(s) owned blocks? Is it static or is it dynamic?
> >> --
> >> Florian
> >>
> >
> > This patch enables devices to selectively participate in system power
> > transitions. This is crucial when multiple processors, managed by
> > different operating system kernels, share the same controller. One
> > processor shouldn't enforce the same power transition procedures on
> > the controller =E2=80=93 another processor might be using it at that mo=
ment.
> > While a spinlock is necessary for synchronizing controller access, we
> > still need to add the flexibility to dynamically customize power
> > transition behavior for each device. And that's what this patch is
> > trying to do.
> > In our use case, the host processor and co-processor are managed by
> > separate operating system kernels. This arrangement is static.
>
> OK, so now the question is whether the peripheral is entirely visible to
> Linux, or is it entirely owned by the co-processor, or is there a
> combination of both and the usage of the said device driver is dynamic
> between Linux and your co-processor?
>
> A sysfs entry does not seem like the appropriate way to described which
> states need to be skipped and which ones can remain under control of
> Linux, you would have to use your firmware's description for that (ACPI,
> Device Tree, etc.) such that you have a more comprehensive solution that
> can span a bigger scope.
> --
> Florian
>

We anticipate that control of the peripheral (e.g., controller) will
be shared between operating system kernels. Each kernel will need its
own driver for peripheral communication. To accommodate different
tasks, the operating system managing the peripheral can change
dynamically at runtime.

We dynamically select the operating system kernel controlling the
target peripheral based on the task at hand, which looks more like a
software behavior rather than hardware behavior to me. I agree that we
might need a firmware description for "whether another operating
system exists for this peripheral", but we also need to store the
information about "whether another operating system is actively using
this peripheral". To me, the latter one looks more like a sysfs entry
rather than a firmware description as it's not determined statically.

