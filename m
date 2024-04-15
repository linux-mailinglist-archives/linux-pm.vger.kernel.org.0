Return-Path: <linux-pm+bounces-6413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E478A54CC
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7841C2227A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Apr 2024 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5978C99;
	Mon, 15 Apr 2024 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSvTwNya"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B278C75
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191849; cv=none; b=hTp2sJjc4VSZYIU5fCwRzZsAjeti4I3kyEgzwIKkwYC7cu9Le3SLEKiqybvjV6DY+1GBLX+yzc8wWSj4E8ytSehXm8euLxiuxFJMFPC9lAx5wlhOLQ9/gdIqAYs/cZSU/CvlsM5ox0hKMIIrzzL0cG8sjDWRP6q6VkSPBCBdVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191849; c=relaxed/simple;
	bh=A2zRiO/Kg2il+nYuvwVB/61gjxdCNSDJU0SE+D2xFPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az+U0kXZWofq7i3TJCJtVqBfMMN0paaf468ixv9PEC3KK0HW4WThhwKwsRfeyeJoZ0xYTsQmG5Q/KcBWRjwylEA7NnxmD+nO7r2RyPct4pVsvt5IDO+6UY15l6/ClKKhHT2M7qGdeGGuWh7LuYO+vT/RTWgNKrvmXe286S/EA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSvTwNya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E73FC2BD10
	for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191849;
	bh=A2zRiO/Kg2il+nYuvwVB/61gjxdCNSDJU0SE+D2xFPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DSvTwNyaobz5EB8cjNyA0BA8V6yj6HgQnxm0bTXMiiQSt9tKqLFvXo7I9RS6/1FJT
	 p4rIq26RLDJJXTIueR46JUkkgnH6Ij2u0JoIMR/dqrvskWDsHvKVqO+ageVHJp6Q+C
	 A2+jqaAIS5Uys+xvIxYIh9QQsXlNUgVAgx7kQsssQZn9odFU8KmcFrw8rZUheGmgWY
	 NaG/S7oXbhcBVgcjFMkvyS4we+e1fe0zObVgKJwwA2neAvRg1DD1Cd5m2DN0ieXEX8
	 y/I+6Oq8qKBNlK/rHbLSgZh+sCYaOPZyxV6K2kyFRWDXuosRVnsnFBKwfO65+tfCfw
	 ZBTpxFoh6v4BA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-22ed9094168so403957fac.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2024 07:37:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxcDwbCj0lXhywmCsLdakbSwkX4BaZvZcv93kA1lyJk830Tb9EV/o+boIW+GATFIDPJaX/CZfllfYRq0eZe9pr14Q3YPSU+q8=
X-Gm-Message-State: AOJu0Ywu/Bon4O1eDChNP1MXimX1N07yMyTTpAAcBTs1POEcyTmZ3lqt
	Eifh5U6eiEFxkiRWoNFGqwf2HK+kaGerSodmiRlseVupXB45vptZs3o9ABWO1tLH4RQg67fOouD
	tHABcvpivu0yqWskXlKWGa6NW6Sw=
X-Google-Smtp-Source: AGHT+IEK7pIpw757rLzhLO+PQtU2KmWksrGgUUvK5+pah5fkJvvMI/PMx79nJwXXDmimeKLffxlUuzo9CxJC7/SEt4E=
X-Received: by 2002:a05:6871:7420:b0:234:5785:bca with SMTP id
 nw32-20020a056871742000b0023457850bcamr5339800oac.3.1713191848953; Mon, 15
 Apr 2024 07:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
 <CAJZ5v0j48UTHj1cFNUR=EUuW1zugYxktX_t_tJFhFG5rNExyWA@mail.gmail.com> <4548dee1-426f-4183-bf6f-4a62d35b9aa1@panix.com>
In-Reply-To: <4548dee1-426f-4183-bf6f-4a62d35b9aa1@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 16:37:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iik=M0DFoLER+ae3PoWb6Mt5rGEK-92i3nCV93Jbkm-A@mail.gmail.com>
Message-ID: <CAJZ5v0iik=M0DFoLER+ae3PoWb6Mt5rGEK-92i3nCV93Jbkm-A@mail.gmail.com>
Subject: Re: Kernels 6.8+ no longer resume fully after a hibernate
To: Kenneth Crudup <kenny@panix.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:28=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
>
> On 4/15/24 06:05, Rafael J. Wysocki wrote:
>
> > Can you please try
> >
> > # echo 0 > /sys/power/pm_async
> >
> > and hibernate after that?
> >
> > If it resumes correctly (and reproducibly), at least one device is
> > resumed too early in the async case.
>
> That worked. Nice, I can use that for a short-term fix.
>
> Later this week I can help figure out which device(s) are the culprit;
> what method should I use to do that?

There is the "async" attribute for every device in sysfs under power/,
for instance

$ cat /sys/devices/pci0000\:00/0000\:00\:02.0/power/async
enabled

Writing "disabled" to this for all devices where it is enabled should
be functionally equivalent to pm_async=3D0.

In principle, you can do a binary search through device using this,
ie. disable it for half of the device.  If this works, the problematic
one likely was in the "disabled" half, so you can divide that set into
two parts.  And so on.

Thanks!

