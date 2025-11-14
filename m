Return-Path: <linux-pm+bounces-38051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01CC5E582
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 17:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7BCF350282
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61230267B94;
	Fri, 14 Nov 2025 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcdgLKE7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915D2638BA
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136764; cv=none; b=DqPJGGGlKVUdms5q5ZmFEcDzoff5vzdFVEaeSAxfiDMJH2+1A8s+UKopctsF5Ij8s5tA0482GkdGdCTF/Z5IxcprXO+nyq0TYZzz2IbKhmzJuxDAVvybsSvDI5BOIkSL7FhVwcH7lqqKdCbVTxeo7eXUVzdhAvuinmNAslDm1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136764; c=relaxed/simple;
	bh=bs2i0H0jlQ8HsZ+KnPKsgYngEWs21g4qYocSJoUifgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9c3WGNjbQQjwdzUF9nLPZQ0+cPN9DslcY4yeMVyCDFQvcbHWPb8IbQewQb9IT+BCBiOkOtzOfY+knPizuKx8w0Zc2p049SK3TlUBOoDRIUihrh6czwuUkvhVLvYZB8g7Y0lP+v6yL7SU4XkScVUK0eqUojC73cZ/dkA5kGns9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcdgLKE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B4EC4CEFB
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763136763;
	bh=bs2i0H0jlQ8HsZ+KnPKsgYngEWs21g4qYocSJoUifgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gcdgLKE7lEaIaFEb+rmrx9CGkbzColvzRmwy9I/t+fRKTKCq04IFa9kiUI31SjNlz
	 Mr+e1rJ222bDqpOxWKOBXj4EisN1IZXEj8xkHqYL3ljbOBueb5az8mSELKJqWT9CTp
	 GHeFs47leEaxQYMOlkDmHDnNce4cWltI1kSfQi55nbLYPUAAd5tPj0kmmS40SzIyyw
	 hnDZbtThKaVOGEwnIDRrY3UwF+FA9VYbetAETXs6nvviMsMVoPvOPp6Dglmvudn4Il
	 cVr6kr2xxOmU9yF3CbzVksAUl25oXYbvTb50UBQ5asGZk1+aXatQjVYl2QpW3VILHq
	 uWN2B9jIN0JSQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4507605e19aso1026409b6e.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 08:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdAGrzcFVDJbfjRrRtu+oFSc421u6RP/0AqLY35AZ/10JhuH9xCptMMDmEA2bxsE7NjmbaSJjG8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxildhHH0CGKm2MjtMqX5OAAnQt2UkgOCrcGZlT/voS+aW6rFNf
	Zx02kse/kU32CkDGJOAo7OpguxZrdUC4j6U89EkwbO+PFSGiGpUqBGHZgBqqiN3+9Jt/QTgmPuW
	lBndkzEPgUEY3QE6g19Z4QTQvwYvFliM=
X-Google-Smtp-Source: AGHT+IEgmPDZF6MbpSeY+SWnu4uKD6OSs6x6OPLIYCl/Q/zRfCT5orZNrCRl2BOirXPI/vN/QwqjEs+I2p6W5zFGVuA=
X-Received: by 2002:a05:6808:5283:b0:450:3823:b5ef with SMTP id
 5614622812f47-4509757eb23mr1966391b6e.34.1763136763085; Fri, 14 Nov 2025
 08:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112224025.2051702-1-superm1@kernel.org>
In-Reply-To: <20251112224025.2051702-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 17:12:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i8RR_o-DmLrBUg_xLZxoNpUqLhudvPphgv7fmW=qZ9kw@mail.gmail.com>
X-Gm-Features: AWmQ_blCfef8qy6eK5xND1HxM5r1qHEqftrJk62QA5sKUfq8A3gWPEwT79AHjN8
Message-ID: <CAJZ5v0i8RR_o-DmLrBUg_xLZxoNpUqLhudvPphgv7fmW=qZ9kw@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Introduce and plumb PMSG_POWEROFF
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:40=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> I've been working on a series that uses the hibernate flows (S4)
> during shutdown (S5) [1], but it's a bit risky because it has changes
> all around the kernel.  To mitigate risk Rafael suggested [2] to split
> the series into at least 3 parts across different kernel cycles.
>
> Here is the first part, which just introduces a PMSG_POWEROFF event
> and uses it in any driver that manipulates PM events.
>
> There are no functional changes for these changes and this series is
> intended for 6.19.
>
> v10:
>  * Drop resume_event changes
>  * Drop patch 4 (will come in later phase)
>
> Mario Limonciello (AMD) (3):
>   PM: Introduce new PMSG_POWEROFF event
>   scsi: Add PM_EVENT_POWEROFF into suspend callbacks
>   usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
>
>  drivers/base/power/main.c    | 5 +++++
>  drivers/scsi/mesh.c          | 1 +
>  drivers/scsi/stex.c          | 1 +
>  drivers/usb/host/sl811-hcd.c | 1 +
>  include/linux/pm.h           | 3 +++
>  include/trace/events/power.h | 3 ++-
>  6 files changed, 13 insertions(+), 1 deletion(-)
>
> --

All 3 patches applied as 6.19 material, thanks!

