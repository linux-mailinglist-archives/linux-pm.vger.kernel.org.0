Return-Path: <linux-pm+bounces-34565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445ADB55650
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0AF7C4C0F
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C37322DA1;
	Fri, 12 Sep 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaePTPzt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FCC18E25
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702234; cv=none; b=Tkwe+1kMeoJcQuH2gP0KKaYUBowYBqXrjNyYSTQq79/AY74wurcsDWx1g02CEp2jBcRTyoW52SKSmY8C1eOomX+g//SIclnufbd6af0eB2KSvaABHjIn9Dq9n6KorVkiRtjEvr1c1ZnFzpwEXHzrj4AhOSJCobyeNC13s4NT9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702234; c=relaxed/simple;
	bh=+uLL73ESbQiAGHCJIihKVzb4SWfooEbOCP6UJcEcy2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1LOfQ9kdlkdPA8xYs3FXT1aborVoIGpP+2IkTi+1mP03b2o1Uy5U0RenmhaAYK0BFpi2xNvta/KD+NWnX4CXyECtiFJzJDwflrRTdzUUD2vj/Y5y4AZp5x+jt1+ZZueZENzQrRM0vOSz6SEchk423CqY13iWHIi1TkpVrQOjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaePTPzt; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-544c620d486so1524525e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757702232; x=1758307032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5LpCqgd6cuTc0c8Co1kvdyn21Z6xUMeh+u0WbfeIVU=;
        b=UaePTPztSeWrg3Sba+DqsU2RM2fVzVF5j+qzJFqS9RY23owhOVHYqKUWin0i+Xj7rv
         TQw9Dfp4LjepuvvIL2opMHwtqANq56feFetX3UtIifOsft68LB4ksFc7Y92dmLOn96ct
         PgRe/BJJIghp8SC31HA2Oo2UxjzhHGZHaKf7E+uHUapnBYL4Dex1NkvjzhPgTAKyQCSi
         i/1QbN7TCX/CS0JJeEs9pEgdQ8BY314Y8xOHiYeSLcTFUTXSWRgiPbWakFWi9cbSwdF/
         vOS8ftCb5LEQJ/uX9j0uiCdNrPdHs2AC8gtL/WH1iAkshl9tGufwTvaPrGe8kbYeSekc
         7/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702232; x=1758307032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5LpCqgd6cuTc0c8Co1kvdyn21Z6xUMeh+u0WbfeIVU=;
        b=QtzlaczyBJFReWpzNG3RZz4oXNTCxyLNOcEs4oxduW3EkzYGExJ8ngQzapy0NjKjLn
         Vh/FF9vfIifL0/CYm/i+eoN0vXcj5/ULz5A9uO+BJRqXHWuHQ3jQH1IcbUFPNeWBhUQL
         dHgIZmauM9qxapv9i/sbFB78Na3Or2af9zJU9YGX1Dpf+yIZ+t7BRK6iCl3W5arzD9Zx
         XWpTPf5a+98Na1yIP9aSSCtIGvcGrvwmkUgeKezCNIuvWj3wEG4hlhuKE9+qTQYYmrNU
         U6PXmZt0Ufwp9G5xcGJ1rygFeZg1nqgTM7SeWz5s3ODNowGgdOIuV5lJVTk2IntX5tui
         XO/A==
X-Forwarded-Encrypted: i=1; AJvYcCXDjbKnisqmyt1xEE/ByLRkn8rqeVjcFa34YZrDn/feeNADyjKGp9ISuThSUMibuZTCYghh6uBN4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxbQgijU5Vgh/UoeL9uHSndo6AlmcFp7yZMqnRSZVc7d6HqbH
	VqrOEsAOUqA6CbffX+SckdAHWSssRDsPItpNSvP84d8mzspzRQrFVSPRru+Y36op31MViADiz+p
	JFJkh7NoVesPDg8LQYgwRcRyq3AO0bNzJHj/2w0Tl
X-Gm-Gg: ASbGncugXe/Bt+El/8BB1mgGhACh0XMr/aWkUlxNdzTaQcv7Y9WAR5O7IvuPkPBRdtO
	RM/JvtAZF/JECxMmL96NwMo7+6OKDiGcfrjM7Nkbr7wNUp5M1wP4wLhM5+/v6sDdrZsQ9I6NW3G
	BkkodHqoiv+sGtaPYKoUMMkDnbDCYJmVvkJGcG+6BTDzsXhwomRy8HqSg5Q2tQ7xoNaYEYS6ZSp
	6gZ2owA0daLZvrDWLwb9O0=
X-Google-Smtp-Source: AGHT+IHUXgE+IihNEnKdjmOQEwLekUUvu3+aWzgDFOUfZi4sULxM7CrV7gKrH879sJaDGgzOnRIOHdgF+J3gqIizJi4=
X-Received: by 2002:a05:6102:3a09:b0:525:3802:c260 with SMTP id
 ada2fe7eead31-55608e9e69cmr2203452137.3.1757702231508; Fri, 12 Sep 2025
 11:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Sep 2025 11:36:35 -0700
X-Gm-Features: AS18NWBJYwHlx6gFzPDiQm-A363FKAFgsm5_uMk29VFYTcWjd5qUP9Ell1HnVXs
Message-ID: <CAGETcx9W5MXyHA2r1kDh9=WJiQWLF1xdPaSCH=jXYeAHqQW60w@mail.gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 4:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Recent changes to genpd prevents those PM domains being powered-on during
> initialization from being powered-off during the boot sequence. Based upo=
n
> whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relie=
s
> on the sync_state mechanism or the genpd_power_off_unused() (which is a
> late_initcall_sync), to understand when it's okay to allow these PM domai=
ns
> to be powered-off.
>
> This new behaviour in genpd has lead to problems on different platforms [=
1].
>
> In this series, I am therefore suggesting to restore the behavior of
> genpd_power_off_unused() along with introducing a new genpd config flag,
> GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the ne=
w
> behaviour.
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.or=
g/
> https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9=
daeb00@collabora.com/

I'm surprised this is happening. The default behavior of sync_state()
is to never turn off a power domain until all the consumers have
probed.

Is there a consumer that's not captured correctly? If so, can we add them?

Also, there are already sync_state related kernel configs, command
line options and sysfs files that should allow people to power off
devices (at different levels of granularity) even if its consumers
haven't probed.

Thanks,
Saravana

>
> Ulf Hansson (5):
>   pmdomain: core: Restore behaviour for disabling unused PM domains
>   pmdomain: rockchip: Fix regulator dependency with
>     GENPD_FLAG_NO_STAY_ON
>   pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
>   pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains
>     powered-on
>   pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains
>     powered-on
>
>  drivers/pmdomain/core.c                   | 20 ++++++++++++++------
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
>  drivers/pmdomain/renesas/rcar-sysc.c      |  1 +
>  drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
>  drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
>  include/linux/pm_domain.h                 |  7 +++++++
>  6 files changed, 26 insertions(+), 8 deletions(-)
>
> --
> 2.43.0
>

