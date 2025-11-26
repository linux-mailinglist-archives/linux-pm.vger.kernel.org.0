Return-Path: <linux-pm+bounces-38737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09466C8B35C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD273A5CF4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9763E2FF158;
	Wed, 26 Nov 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL/3CFQp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A527A107
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178487; cv=none; b=gY9yyeG8a8/rwF4kUS3FJJallEVGO04KLXKyTVgSZDVGTDoHkzS8Cws2wFspHPkotL4JcEsO88hmb+WFBDqo4kUfDFCtp66zmf13fxzDNs1ycq6OgrD0sVL2jysKPiXr9btya5FPv4UflGzpXOMbS4heU5qSXbWFGq8Wnt5xKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178487; c=relaxed/simple;
	bh=d+5eLHGelfVC6+3ruoOXVL3MYFu4i+Y7T4i8SmirhIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN+c7JcFUdGWFKX7321ScYrTDZR7qZ6Unqa/VEnW5syCXBU5bhkYipC49ZABhScDp9Y+AxPUZyfx9oj9jZyaGH1VihSm3B9G8ozmwTvehk9YyXK731CxSyyoaG55x0BTDs1fTUOYZBjPrecxcMGJHhb2oRhGKPyZWMDs8uSOGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL/3CFQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BE7C4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764178487;
	bh=d+5eLHGelfVC6+3ruoOXVL3MYFu4i+Y7T4i8SmirhIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VL/3CFQpEj76r0fmtd0ZRXp1LOUqgbjJGjjBQfZ1CN8v6o1PNTcRahS9x0WrPKZmy
	 k2hgRlhdEnacCD2zzqO41kdDo1meOZHBJlb+L269b78RiPmbfQQBbdDuWlMvcZjNLB
	 x0yey6FL1x+D3YmyB7XQPTvYissod187Q1XLpvIPJVuBVNs4i13Abf9HTv6rDOsBzW
	 JuQNd/bHPTqOUu78eXEd1cA2ObuxR4BDqPhXZFzqmHaalqBu6qh4YZX4I44zreUKgn
	 qLekwKUvOLgHjLUCfAn6wXyRqFEXx3EAy8jJ7DCrsWpuQ1Bfo3VI8VgfN/IE2uyq5q
	 qEOiijKJo+3fg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c78d30649aso63136a34.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2025 09:34:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfYSRTpYPiZ1OBBsJcUkcI75cXW5hf9xMqCi8cyk7ePn0otKDPfE/yXs8p3Jo1l4SJqs6H1tR31Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOu5Mm9v+yn5oi2pMN/qX4hX218IjxBusVi8V1dHYOOo4bhCY
	f0K+flSe55jIFJPq824eSAju5sDldO+pfSAQelZqBKIwV8R6iOxXWg0dMdTDwwHqHiGaMqdvOs1
	YFay9ukvKjoS6qfU1KwSWYHRmeSpIxis=
X-Google-Smtp-Source: AGHT+IEIBURXGZHKEBbMUkoHCwHsucn4kU4tx8r2Wbyx0cXNG/3XKjH4HKIfEpYz44KNRRiFgV5k7Yvs0MwaO0VP+n0=
X-Received: by 2002:a05:6808:c165:b0:450:ccef:c00c with SMTP id
 5614622812f47-45115b887d2mr6572765b6e.48.1764178486508; Wed, 26 Nov 2025
 09:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <CAJZ5v0jsdsyVd3hPWni1Vj+daQS8PdWJCjboJHHHbBjBMeSxzg@mail.gmail.com>
 <94c6680c-1b86-4cee-8e9c-860daf629b59@acm.org> <CAJZ5v0gbmXKrUi6RzW5jHLedCpDcMwCj=+4zZzq0pXwnFMkDEA@mail.gmail.com>
 <CAJZ5v0g36Ea-XNBmsMSJxkAKz8zZNzWr_HA7AJOtS2NZOqAfEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g36Ea-XNBmsMSJxkAKz8zZNzWr_HA7AJOtS2NZOqAfEA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Nov 2025 18:34:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwKaCDjzgo-AP62DDd=Nww9KbYp6tUxuQQ-Hp11PXMig@mail.gmail.com>
X-Gm-Features: AWmQ_bmyQz1o80LRrXoB8uHkgLpYOP-4vFv5uz2byQWkcx9IpINhYmdilQCISnI
Message-ID: <CAJZ5v0jwKaCDjzgo-AP62DDd=Nww9KbYp6tUxuQQ-Hp11PXMig@mail.gmail.com>
Subject: Re: [PATCH 0/2] PM: runtime: Fix potential I/O hang
To: Bart Van Assche <bvanassche@acm.org>, Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 6:21=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Nov 26, 2025 at 5:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Nov 26, 2025 at 4:48=E2=80=AFPM Bart Van Assche <bvanassche@acm=
.org> wrote:
> > >
> > > On 11/26/25 3:31 AM, Rafael J. Wysocki wrote:
> > > > Please address the issue differently.
> > >
> > > It seems unfortunate to me that __pm_runtime_barrier() can cause pm_r=
equest_resume() to hang.
> >
> > I wouldn't call it a hang.
> >
> > __pm_runtime_barrier() removes the work item queued by
> > pm_request_resume(), but at the time when it is called, which is
> > device_suspend_late(), the work item queued by pm_request_resume()
> > cannot make progress anyway.  It will only be able to make progress
> > when the PM workqueue is unfrozen at the end of the system resume
> > transition.
> >
> > > Would it be safe to remove the
> > > cancel_work_sync() call from __pm_runtime_barrier() since
> > > pm_runtime_work() calls functions that check disable_depth
> > > when processing RPM_REQ_SUSPEND and RPM_REQ_AUTOSUSPEND? Would
> > > this be sufficient to fix the reported deadlock?
> >
> > If you want the resume work item to survive the system suspend/resume
> > cycle, __pm_runtime_disable() may be changed to make that happen, but
> > this still will not allow the work to make progress until the system
> > resume ends.
> >
> > I'm not sure if this would help to address the issue at hand though.
>
> I actually have a better idea: Why don't we resume all devices that
> have runtime resume work items pending at the time when
> device_suspend() is called?
>
> Arguably, somebody wanted them to runtime-resume, so they should be
> resumed before being prepared for system suspend and that will
> eliminate the issue at hand (because devices cannot suspend during
> system suspend/resume).

Wait, there is a pm_runtime_barrier() call in device_suspend() that
does just that and additionally it calls __pm_runtime_barrier(), so
all of the pending runtime PM work items should be cancelled by it.

So it looks like the device in question is runtime-suspended at that
point and only later blk_pm_resume_queue() is called to resume it.
I'm wondering where it is called from.  And maybe pm_runtime_resume()
should be called for it from its ->suspend() callback?

