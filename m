Return-Path: <linux-pm+bounces-40460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B034D0444B
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 189B63139D17
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E73314C1;
	Thu,  8 Jan 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utJiWtVK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A1274B42
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881228; cv=none; b=GlxZR0aROpbcRg3y6JaIjiDESktw6ah0iGRP8lx73PZAkGVMsHSYePc/wz8Kay32wZ231SHEbHtgrIyVjwkTBzQ6V271I4/+xvnGbA739IxXAuBMfRWk3XCAeB54okrdLCglXEreWNPFu58C4xbCnoBiKFE5hoxadN3xZuuCxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881228; c=relaxed/simple;
	bh=rur/eFIPFwsjnt7rsZv39PcFC9AOyQANaNtWSJe8sXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMfK21dHNOxuzIb5jYVxCTTW2BgyQWYf6vLqozzfCBxX2naxfmfN7v4IIBEDH0w+cTszr4Sw5z31vzoLPRtQFmxpbQapIeHK/E3VD2OpeqXpWUiz5vDCVGQmwaK82s5og6OKstvX/knPpE4A+PsTlU8lsbC612ypYwDOZ08jGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utJiWtVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABABC19424
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 14:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767881228;
	bh=rur/eFIPFwsjnt7rsZv39PcFC9AOyQANaNtWSJe8sXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=utJiWtVKt82v18WXPXSLXOyaxp1Eu3HKgBHdzASLKAEf6FGSSmAD05sAFe7ezApd1
	 ygcsxrPwl8JEOKcW5Az25I7Ly4meqldaavx4K9PhgynTEwHhaxZVzY7W1tPwRV76ao
	 w50APrGdUaVhLeFHoVbsJRAjBjW1RfEOCRxZ4rhYReVLuNjB6joenvGiq66KfBLXj+
	 Byx5ZWW8+gvLUcpJcgDcaVQfSKLR581nIXBx9OIBxYkMo22EoN9ngHmTwRLVH0uz/3
	 afgWWjgboY9Do0w1SwELSgZmko8gS2wWcGYWEo2kMIX6Q3pHby2nrBjBN8f8Tr1mIN
	 gePmy5VsUVcfg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65cfbc56a29so2164845eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 06:07:08 -0800 (PST)
X-Gm-Message-State: AOJu0YxA3QV7O3ZHmGp7btfCySuvBHXcR9IPyPnRw+xToHjEYzjP1spk
	a6SULPd8C/+L9FtXbYyZagHw1SrPY962G4M/Q3dZwuAwdPRT4PS974t0Bxyapf+GmPRu510XYxJ
	KvSsKt8jhl+MW/IENE19/qI8laO4Zytc=
X-Google-Smtp-Source: AGHT+IGiPG3we/G7gqGAVUfEGYc/MX4SFKJU91JLPhCIbBNtzaJzMd+r3u8tZWz0BzQhoH/VrpQ7/+HJdI7NM9Tt2lw=
X-Received: by 2002:a05:6820:2283:b0:659:7c9a:942d with SMTP id
 006d021491bc7-65f54e717d0mr2586755eaf.0.1767881227241; Thu, 08 Jan 2026
 06:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2816529.mvXUDI8C0e@rafael.j.wysocki>
In-Reply-To: <2816529.mvXUDI8C0e@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 15:06:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ifehCqCdC=rE9eUAe7p2jx=QOv8K=HXo3n9D0WefVMUw@mail.gmail.com>
X-Gm-Features: AQt7F2ql4dsJ5nNrNXN_XQXzBdZ5i2rjEWr2rh7CMUz2vPUerTQkosZ3m3_QUgE
Message-ID: <CAJZ5v0ifehCqCdC=rE9eUAe7p2jx=QOv8K=HXo3n9D0WefVMUw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 0/3] net: Discard pm_runtime_put() return value
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:37=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi All,
>
> This is a resend of
>
> https://lore.kernel.org/linux-pm/5973090.DvuYhMxLoT@rafael.j.wysocki/
>
> which mostly was a resend of patches [10-12/23] from:
>
> https://lore.kernel.org/linux-pm/6245770.lOV4Wx5bFT@rafael.j.wysocki/
>
> as requested by Jakub, except for the last patch that has been fixed
> while at it and so the version has been bumped up.
>
> The patches are independent of each other and they are all requisite
> for converting pm_runtime_put() into a void function.

Any news on this or do I need to resend it again?

