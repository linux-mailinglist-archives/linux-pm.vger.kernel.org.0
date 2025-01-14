Return-Path: <linux-pm+bounces-20443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B7DA111DC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FF2168D26
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD820C48C;
	Tue, 14 Jan 2025 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIxa2j7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A120897A;
	Tue, 14 Jan 2025 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886361; cv=none; b=ocUqqrwQjcAaQIwBM+FRliKH/gU68roqJyNXxQa0T0l9ZxcDrRhvjsHqjV0pAP6rNZ1NDNM/PuSmuCkjGycBBhbzb6gXYKz2NCW/vMzuFI9i78d0rE7ysEUS/Ut50jRni2N3CCZOfZX9w4TEzSKkZQRVAKTYb1J8cigb184PIO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886361; c=relaxed/simple;
	bh=XTXkW1aOuwn5YirTF+R52ZGJS+jeLlrbYueGNPXjums=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxH4UAuN2K0S7T1TRQkRwH7zI7oJZmfC8Q65nLBA4DWP9iX+QtcJTRrtoUIDMFiff3be6rIvQ39dk7pjykNtyghyyLFJ/8iugvTG+JRoDo9msKB2+f7Kepzi07BJv3Q3oNfWeiDHMaR2sVqXhqol+X4jqvOuW/Q/+1dImfjaWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIxa2j7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D19C4CEE4;
	Tue, 14 Jan 2025 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736886360;
	bh=XTXkW1aOuwn5YirTF+R52ZGJS+jeLlrbYueGNPXjums=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tIxa2j7E2vAIbybrEwGFyjmNkazrYp0qfTPIwxPb14BYeVilMfQtqawTu/n4IYR8E
	 tEcbWua9KDzoTihOvSajkv9JgAhzh2nprptOuCliCkBOTiMEahkEMM2mIDCpdGvLNr
	 yr8pUd7wwNxqVMHddgey3hQwjK2J+MMXQpGRCfJ17yQ3eWlUdY4Fejf8OWZKEXrMBx
	 fmwMpfc8l6IFZGuMhhfQVAjBxuP/jh0YRex5ZFyC0Wdx7txPAWI6GjoHczof5iz3QH
	 rLRHBqyAQFFl5cLPXp920A6U/y6vDS+DIdmODvymFkPcUwOr3FdKVQrep7NzYCr9oa
	 bCpwGyAp+5JEw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ebb669df2eso85368b6e.1;
        Tue, 14 Jan 2025 12:26:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKqMYWgsM/6Pj6BtZi3YfayyliAkKwroQuqK9hLlMakrW4U5FyJkKR90kkconEr8PfU92BGqH0KT1qOU0=@vger.kernel.org, AJvYcCX081gePkWYxeUL2Nb5O0a3U/mZgYKBLK6PfL6dtkO34g8xA5lxlaGAg0tjQLk8g1URC7vbEUwwy/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UK3ggNH+Zv2gvLNErjss7APvP2rfMucxDtKaAsrfZ7gEJ42x
	yp/DBj7sRvhZiYGvPi1k9oSl5gFDnm9OJgm1XOoDDnzAU1f75wZnmH0lhOiJFCLkm0E+1XUNgFh
	+xOwrbyEyc7y18f2TmOmQIzgf/IQ=
X-Google-Smtp-Source: AGHT+IH9/g+LA9UR5o45GZRkQHJ6J4JTm7//h2RKmrDrBZw0T98HmQHnmpy06UGyMa3SDggqsAHWUcmXcRqQuEp//14=
X-Received: by 2002:a05:6808:e83:b0:3e6:54c8:fad3 with SMTP id
 5614622812f47-3f095b3e60emr288508b6e.19.1736886360126; Tue, 14 Jan 2025
 12:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109125957.v2.1.I4554f931b8da97948f308ecc651b124338ee9603@changeid>
 <CAAFQd5B30=9TT+ipyWaHdB1XMVagvEAJAw8grdU0Vva8+6JqLA@mail.gmail.com>
In-Reply-To: <CAAFQd5B30=9TT+ipyWaHdB1XMVagvEAJAw8grdU0Vva8+6JqLA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 21:25:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hd-OCGuYKxrk8c0NaKHjAEw+7u1RF3xYbyBBLJHXyxiw@mail.gmail.com>
X-Gm-Features: AbW1kvZ1PKJ4LSr-41o84Nl-hlP2n_Y-9eC8bDjHnEl8eK0ndDG4PuR9ZTniTb4
Message-ID: <CAJZ5v0hd-OCGuYKxrk8c0NaKHjAEw+7u1RF3xYbyBBLJHXyxiw@mail.gmail.com>
Subject: Re: [PATCH v2] PM / core: Allow configuring the DPM watchdog to warn
 earlier than panic
To: Tomasz Figa <tfiga@chromium.org>, Douglas Anderson <dianders@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:50=E2=80=AFAM Tomasz Figa <tfiga@chromium.org> wr=
ote:
>
> On Fri, Jan 10, 2025 at 6:01=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > Allow configuring the DPM watchdog to warn about slow suspend/resume
> > functions without causing a system panic(). This allows you to set the
> > DPM_WATCHDOG_WARNING_TIMEOUT to something like 5 or 10 seconds to get
> > warnings about slow suspend/resume functions that eventually succeed.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Print the warning at warn level, not emergency level.
> > - Add help text to DPM_WATCHDOG_WARNING_TIMEOUT.
> >
> >  drivers/base/power/main.c | 24 +++++++++++++++++++-----
> >  kernel/power/Kconfig      | 21 ++++++++++++++++++++-
> >  2 files changed, 39 insertions(+), 6 deletions(-)
> >
>
> Thanks for addressing my comments.
>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Applied as 6.14 material, thanks!

