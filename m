Return-Path: <linux-pm+bounces-19420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293969F6459
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AE216A9D1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FB919CC3C;
	Wed, 18 Dec 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSHeOCFr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13A19939D
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734520213; cv=none; b=dliOo6YuIWnNM0Zwgeji0y2KNzRa9wC5OjrgYlspX6CxNw5/71TmrlwZW0Sj7nAFfdzQGknPFgK+dAkeLvvpFEClR2oU+rJLnJxVt/Y2JTHGNAge7038zs4mLV8HU0qXZBkyBZzfk7lzGREEbPfZ0oPFPFPpdRZH1jRpNsCQ8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734520213; c=relaxed/simple;
	bh=ERypSZr/K+0TmwV+cyxpd4RZs5yy0sp/ZDHqa0hiRS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFBLHZPXz6q6pvmskqM6Tms65swqNLV1HEwo4aA0wVzKBxV6TftDtwt4DkBrlH76oRsUvKkz//iArktMNtW8UIFzhRn6FgqffG/1CJZGUdG3S5W2SzJmG1dEC4VDmUHzqlCCzSY7106jyI0ZmU+8KhhyenLM1HFEbBtbTgucKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSHeOCFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D970C4CECE
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 11:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734520213;
	bh=ERypSZr/K+0TmwV+cyxpd4RZs5yy0sp/ZDHqa0hiRS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DSHeOCFrXtu0w01u8hTLGxqzh94l157jlXfeYUpGD8h65BLClsZIpvQkYNNzWH2HN
	 6Gfmj5UTkhWr0vtGk9UTYyXTyTyAjU4bxeN+nw2Uaai+i0yyt4Ry61kEYnA9MyaJKy
	 2hi3CL1j0Rq7yDVemcWoKEc4GcFdDAGmTqNthD8GFJZX6+gqOaCZIH1EK7PHjMH/EF
	 qr1bISP8uNtvJA0UQ5l+LZR426Z4tfxsysljtV0iQ3GC1jwSqiOn4ey6PeJpPe562H
	 VckWSV8skCLQzlQxED6RMdpE10JnvV2t/X2OWHmoNKBNIL3iOF5uRhA8HOQMoNX6v0
	 b7iSWpU4Rx//g==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e36b27b53so3061381a34.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 03:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOGATUVR6+x2qrqQbl75/uM929dcG+cEu/7+eDShDaFYhsHX4dFJ+0BmKpe0/QwdYa5vEtiToNFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0HfIyWH1Sl7LCs/5B/GYQIYgL3IUGlSVdI/Bi09e9Fng0ol4L
	6f6283/ARjZWl2XBdGY7i7DoqwgDrI4dZUEx9iVhLOPO6fzipxnuiN/isQynu4eFABrmmOiav1v
	BQy7YM5s20K7yD2MIDGEwSXOKS+M=
X-Google-Smtp-Source: AGHT+IHM5Gpwc3BiVeMkYl4H4AJLlhyZJvRAiZJuEwpnqKNEIFznuvevEZTw0T7AYrKPmJURqv5G90oyJColaOcVtWk=
X-Received: by 2002:a05:6808:1a02:b0:3ea:66c3:d066 with SMTP id
 5614622812f47-3eccbf2e273mr1358547b6e.7.1734520212569; Wed, 18 Dec 2024
 03:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214021652.3432500-1-joe@pf.is.s.u-tokyo.ac.jp> <20241216080159.ahpzlioy7l5etn3y@lcpd911>
In-Reply-To: <20241216080159.ahpzlioy7l5etn3y@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 12:10:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKOEU7XCR1G5t2FA8X2q9Y5dWGuMZ0cwTJ6mjfJuCsBg@mail.gmail.com>
Message-ID: <CAJZ5v0hKOEU7XCR1G5t2FA8X2q9Y5dWGuMZ0cwTJ6mjfJuCsBg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: wakeup: implement devm_device_init_wakeup() helper
To: Dhruva Gole <d-gole@ti.com>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	alexandre.belloni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 9:02=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Dec 14, 2024 at 11:16:52 +0900, Joe Hattori wrote:
> > Some drivers that enable device wakeup fail to properly disable it
> > during their cleanup, which results in a memory leak.
> >
> > To address this, introduce devm_device_init_wakeup(), a managed variant
> > of device_init_wakeup(dev, true). With this managed helper, wakeup
> > functionality will be automatically disabled when the device is
> > released, ensuring a more reliable cleanup process.
> >
> > This need for this addition arose during a previous discussion [1].
> >
> > [1]:
> > https://lore.kernel.org/linux-rtc/20241212100403.3799667-1-joe@pf.is.s.=
u-tokyo.ac.jp/
> >
> > Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > ---
> > Changes in V2:
> > - Utilize the device_init_wakeup() function.
>
> You took my suggestion, but forgot to put me in CC I guess :)
>
> [...]
> > +/**
> > + * devm_device_init_wakeup - Resource managed device wakeup initializa=
tion.
> > + * @dev: Device to handle.
> > + *
> > + * This function is the devm managed version of device_init_wakeup(dev=
, true).
> > + */
> > +static inline int devm_device_init_wakeup(struct device *dev)
>
> Rafael, Should I submit a patch series to convert the regular device_init=
_wakeup from int to void?
> This anyway doesn't return anything but 0 today and I can already see
> some drivers using if(device_init_wakeup) which would essentially be
> just dead code. I can try and patch that up as well.
> The fact that this is a return type `int` is quite misleading to it's
> users I guess?

Yes, it would be better to make it void.

