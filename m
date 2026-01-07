Return-Path: <linux-pm+bounces-40366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96BCFDBE1
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 13:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D520D3008F9F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D982EAB8E;
	Wed,  7 Jan 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIB5Incq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049928F49
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789722; cv=none; b=NKM9sY6u+fH6curDXa2UTamgdydRYUxr6DkDJKKit+Fz7eQZTjzIl/3xPdRRciH0GQFcLY5DbxwjNA7tSVvqYGPuqzgOiQyesrWiCL44UjVTrV2iF4wzA57FykrT4v9puvwtktU/WnRyHxHEnPnujHGOwO4f20aabEjyXfrr2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789722; c=relaxed/simple;
	bh=J/ai7KFn3Cfpu1PW1raz4q+T7q1x8y/x/f2wv9CjuQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1wJHQaKQDMJoG3h9x3Xsp6Vez6zXZLeV4Arq31aZw+mHkgVG0SZkQ0NVvJ/Y5WjDCD5FKKdhgxV+haxho/CtHCxLOKhVl1XVad7r+8LT0zqxlVZXnIZ0ULRsAUVdZqN7F6uUftYM/81Vtdp+TQmI+6Y8jRKGfevG5npALzbrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIB5Incq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3292C2BCB3
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789721;
	bh=J/ai7KFn3Cfpu1PW1raz4q+T7q1x8y/x/f2wv9CjuQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MIB5IncqfGRfraXbXrmpffxoJsVOEiSMGJIgrDGuW6/2apZe//icEBUJRbplsB6op
	 Kpv+mi5TfGCok3TymLzQmbneF3Dgpo+CNJGa54o6GpyMBZhRT66nzpRpQ1R0HIsISb
	 D0sdULHxxWRCQcOoN1LVa9bQ+ESCEWnsgyo/6WuMp7pN3RDKXCw2F7JrnsH7vhTVPj
	 3Hoq9PKp+888I77inBrP3cbk0aEtdFk8yrVb1c37iD8y5xvVL0Bh04ieYAGAX5Slfw
	 3yTE5MoUYNJfXJAWEtV7Ipya9U9LzPOVPR82pKsncRGimhI/gl34RSve24LKr0Cyky
	 IIelaneajPuLw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6d3676455so1041457a34.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 04:42:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAcvCOf7VfZREdZ0NSAYWPfH6vLynCYGUhE0U8WlYcgdvluYzRyVG5U0JCYO6L6eXHIeIBkrBqYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwjiZWUaNo6843j+1ZzUHf8yWrtIcuFs9Vq6DKbSSBjZri8tO
	dLsMqlyMXwLFt2XVE2+Hd9lpRli5tBbrpABSWQe339zSVMEfclT2EyxpJZL/Hz4NRbcnHKLU1N6
	L6i+2cjr8pqP3x0q0DvvkuJiceiAIbIY=
X-Google-Smtp-Source: AGHT+IHttT1Vk9rgD0sQJMCdtIyBGD9/zZtm4P/TXXzDuDiMnspXnxrq2j/u2sDX/hSmZJXyzknm1Az9AP+wgZaf8WA=
X-Received: by 2002:a05:6820:4ecf:b0:65b:3907:b360 with SMTP id
 006d021491bc7-65f54f71ae0mr681890eaf.62.1767789720832; Wed, 07 Jan 2026
 04:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <5973090.DvuYhMxLoT@rafael.j.wysocki>
 <20260106162905.14df3458@kernel.org>
In-Reply-To: <20260106162905.14df3458@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 13:41:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gE-Nwxe-d-_P_z26fZckGq_nhzZ-qV_PEr85VkrYRCEA@mail.gmail.com>
X-Gm-Features: AQt7F2rB_HX4dMfuGwDb8coml-RQF8Ua6wzXFjSg-QJhRjst_bGvQ5amEWvnNnQ
Message-ID: <CAJZ5v0gE-Nwxe-d-_P_z26fZckGq_nhzZ-qV_PEr85VkrYRCEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] net: Discard pm_runtime_put() return value
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Brian Norris <briannorris@chromium.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 03 Jan 2026 22:23:52 +0100 Rafael J. Wysocki wrote:
> > Subject: [PATCH v2 1/3] net: Discard pm_runtime_put() return value
>
> Sorry for noticing late -- looks like the subject prefix being 1/3
> instead of 0/3 is throwing patchwork off.

No worries.

> Patchwork seems to have
> mis-guessed that these are the first 3 patches of the missing ones
> in your full 23 patch series, instead of treating this as a fresh
> posting:
>
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1035812&sta=
te=3D*
>
> Could you resend one more time with the cover letter subject corrected?

Done:

https://lore.kernel.org/linux-pm/2816529.mvXUDI8C0e@rafael.j.wysocki/

Interestingly enough, the kernel.org Patchwork seems to have got that right=
:

https://patchwork.kernel.org/project/linux-pm/list/?series=3D1038125

