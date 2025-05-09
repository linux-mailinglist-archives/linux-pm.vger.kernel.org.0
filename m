Return-Path: <linux-pm+bounces-26951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E6DAB16B4
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B35257FA
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15BA29347C;
	Fri,  9 May 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdgja3N2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEB26FDB9;
	Fri,  9 May 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799287; cv=none; b=pbz76dZ75jVxbBlkY6IJEvj1mden9cy6gWDjtrC/kXBOEb+SVU9rHWb00zZqKUMQkfsT3lg2kKs1YonsdBJmE36buNDM7Uq21gzIDVz3UWQc8u1Eevxs7wi/WuT5J4/L3Lkk79L2iVH1qq9exiOtGTt4XfZEaycCE0veiJ55MRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799287; c=relaxed/simple;
	bh=jO8KBXWmU8/6VvIgK1goX2hP6SkUAmqLsmtFZuhe4PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1BgUM6dj2GK3T2N6mdrS+vDdUj2fimE8JMlw43B19aEAsPtzoL8O4JBavjMnKkhAuC6gUP9a4Avumqf0OZ/fEmAL31hbrD1feoXpPcDA5dyup0jj1aaNNOlaBu2D8yMNZkA6BMtcI61CTR51SJ4q0FR9JgbMDGjM67OYAB3x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdgja3N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2408BC4CEF4;
	Fri,  9 May 2025 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746799287;
	bh=jO8KBXWmU8/6VvIgK1goX2hP6SkUAmqLsmtFZuhe4PU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pdgja3N2Gsjg9zCwKCdPXrW3TR2QK2qUMIHzlmYEEBJ5D8lVDlIs5tBqw7MEk8O1q
	 UMCcqg94ZUcqHOg6l1Hjn1jWxxn/wikLxR/pK853Sb17UC0ozvMXv7yTDr5KE1TRgS
	 F86imxyqlJIpPka5hNL54BrqTeaU0buvPoCPvj9SwG3JSztcPHEK23E/qOee25uRw8
	 DuRltVKUaQuccXZCwANRTfpwtTYzqM/OxiMzev0zpp78Gf+xOnMZC/sZccXvtwvILS
	 LKpvG+o4Ws3CoDQH5s6ytH8NdfTG5huDaA/AVn0VJ4JzUsIu/slXJfgEYzVhLCgDdr
	 wIaQqutdBbztw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-604ad6c4d3dso794774eaf.0;
        Fri, 09 May 2025 07:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu7UUjXdVSId5jU8SoMhQgL1qHhMmPgHcXkQoM6lp8K5WVVDWq0QjiJt7lklFeftj4gYcKQIBH5m0=@vger.kernel.org, AJvYcCVWTT70rAHdtLUu+hn//QjaZFFA68x/BUn2VGgiBCdEoWUTeJS48l29rdbM9pgbsdNOhzJHZNOe0TI=@vger.kernel.org, AJvYcCWeR/LZK9/FdUg8jjuPGz51n69eqH3DyKRqZg9WbYu4ox5xadVS6NEYu1JrsI1AeQqgoQn2tkCNtg2OcCmo@vger.kernel.org
X-Gm-Message-State: AOJu0YxneQiSM+/38b6amaZuxyWC4S8ow2RpbwT9SV8B/7FV/Ni9PZT+
	n9VXPjcdJ9MN+GTt4VzTKAQb4Dzoc8GJ7ozP+GeasrAkjaRnJ0gf85AWTEIIZvpELoeif9Qq6N0
	CicUdXDZ9HSxWSlV0rcKmgFYTiwA=
X-Google-Smtp-Source: AGHT+IHrbI3dnR94H/kI5qrlPphwZvekH/yYIGkE6tHOAq7bmLvqEzrmsJpAS107DuQH1dy/uGKNjuyyxn0QA0x8Cmw=
X-Received: by 2002:a05:6820:983:b0:606:894b:fd23 with SMTP id
 006d021491bc7-6084b651b84mr2066626eaf.4.1746799286373; Fri, 09 May 2025
 07:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507063520.419635-1-zhangzihuan@kylinos.cn> <06bcea82-11d5-4dcf-8331-c073e6d9078f@infradead.org>
In-Reply-To: <06bcea82-11d5-4dcf-8331-c073e6d9078f@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 16:01:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jD7+3ZPBgpw4TTE_XN8fmQuw447cdGZy1pGXta498qLQ@mail.gmail.com>
X-Gm-Features: ATxdqUFZ2K42_K4CL8HMxkBdtWV8A5kWYVlCOpgYCKM0EvxYWuGfLR3QuHXK9KM
Message-ID: <CAJZ5v0jD7+3ZPBgpw4TTE_XN8fmQuw447cdGZy1pGXta498qLQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM / sleep: add configurable delay for pm_test
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Zihuan Zhang <zhangzihuan@kylinos.cn>, corbet@lwn.net, rafael@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, akpm@linux-foundation.org, 
	paulmck@kernel.org, rostedt@goodmis.org, thuth@redhat.com, bp@alien8.de, 
	ardb@kernel.org, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:49=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 5/6/25 11:35 PM, Zihuan Zhang wrote:
> > This patch turns this 5 second delay into a configurable module
> > parameter, so users can determine how long to wait in this
> > pseudo-hibernate state before resuming the system.
> >
> > The configurable delay parameter has been added to suspend and
> > synchronized to hibernation.
> >
> > Example (wait 30 seconds);
> >
> >   # echo 30 > /sys/module/hibernate/parameters/pm_test_delay
> >   # echo core > /sys/power/pm_test
> >
> > Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
>
> Looks good. Thanks.
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 6.16 material, thanks!

