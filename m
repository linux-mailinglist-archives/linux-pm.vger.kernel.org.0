Return-Path: <linux-pm+bounces-40470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC899D040BA
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FDF0311311D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D24346E43;
	Thu,  8 Jan 2026 15:21:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B11238D54
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885659; cv=none; b=BpfKI59GwUeLHzFgKaYdqiO7DpBok06KlarRMRkhX+QewKDUwSfMgbdUH07DmLtl7Q97vDGOLFF8MSYqhYU4CVLU+6L2v0JtabA7lE5YfpFEUfllcbQ5ynTySuBediB3dJoUXSi/bupiJbniWew8t1jkMcLd/wBTljzrtcjBIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885659; c=relaxed/simple;
	bh=yNc+RZIcdJZsg7frmkaxTdR4O9ZibSMhT8YbzmZaH+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0tb4IZm3bzlekdiGQgbekxLpz0/ygBKnnYSEBHCqNUYQakx2FzKVTcPPhcykC2h4BH35kcB9TrqWRv/0y9XmXRh/F/LxekwD8RKXr8XLcuGJR/gve0PhRFMv92EBZSxmUr1wEhlrHcQ59kMz+qrRqv7hp6gMtGJPJj3Jsi+kPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-563497c549cso1305549e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885651; x=1768490451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4XQkxFWUsqFw5LCWwjeRiyAv5WyIL/g3rRuvVx2lSo=;
        b=d3puK/apCPri1JX0AXkoy/X0nQGq1QK/5ddNq+UKsCnDPjkwtnsW9npZve82V36MGB
         Mm2KktgzGYjFooekKK4y9ylyXPIKH9mU6rg2t4YOKFHy+UPWRjvpV5DiuDdJrAb9L+Wh
         n0aH0EiVn1JRB671UrrETHS2XUklqPmnjDgi4CL/+2jlnrv20/kGlufZUrrb8dr6l8kI
         z4+9o+mOYwIWIfrVvNTmTbb732NFkajrNAGZSQeRzzfGXBlIlESDLopFuqJ070cY4+/r
         Or/NvV7fjd2Uxl9BjicLXh6Jg1bWKcDr7g8cfBueyS2TkM+CJuTzeI3e7+kGtJickE2A
         9L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy6Hp0DzjZkPod95P9DUoC3X9/5x19ZMpbM8Pkf8rIL3pnWu3OVrIhgtCv1wPrNc+yMW9v/VrEMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUoH9U8yIXROLBFutyXor3NB/yGWRCVPt3mIP0pH0nNvBTKvtG
	oCWVPGbSQN/v7kizEmPDHCDEKwDWtKm3x+fZDM0X+dYZBzCE6AgCeF1biU7vPF+t
X-Gm-Gg: AY/fxX6tsjLSHC4CoQMg0CQJhOMcg0nC2I51w4Rt+sExOppChAhGTsoIkLuuqTDtP2C
	GDxq5FxRmvMOIK0St2mCMXSd1Czg002iBdyJDIrIK+K4h80tG61CQvkzV2RdsvfSobWh/CF+Hel
	WoBZjYIzVxC8Ygsqh8Lw1R04w229voS0zdnMM1QOZftLGS34sZHH9izSMZlowWbdezAC0kT9vde
	aw3yE7sUdEueQBt6KrzuTOFEZf1rZ2WJegwhcbUzRnQ29/fcKQZGygARruiMQ42Z/BzjXBoEHEy
	l0PqnglcthfDEMW3rl6SGVeQSz1V0Ct3sV1qSG5W8SwTLtqLWn2k1Kq0Emvu92d+7duPDaDcwGl
	k87X0+dvq/ENq4W/U5LBjyEwO7Qku6+dexjSDn4Rt453KYvA/LKIjqrFyIvHcWnoD2N1Cj/zhtl
	YUH5eLxtsum/9jcJ9rlZbVHMbswCoR7gn0xfBEoMr6zHoZagkp
X-Google-Smtp-Source: AGHT+IFBudezI0/tzgaA+DHql1XACL/9hdWoR3kF6aT1cQeETFcXT9RrVkRYiN38l1T83nv/t84Fsw==
X-Received: by 2002:a05:6102:38ca:b0:5db:e2c2:81a1 with SMTP id ada2fe7eead31-5ecb1eae157mr2676979137.14.1767885650720;
        Thu, 08 Jan 2026 07:20:50 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec772e3300sm6614288137.14.2026.01.08.07.20.50
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:20:50 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5eeaae0289bso7852137.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:20:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkXQ/njkQJiVHA06VBFtkJrb9CR6l/rSL4ucBm9/KqlIMVYv5EnzXCO8Itk9WzXOpZeLymtCq8vw==@vger.kernel.org
X-Received: by 2002:a05:6102:dd3:b0:5ec:848f:7673 with SMTP id
 ada2fe7eead31-5ecb1e8e9ebmr2504240137.6.1767885649941; Thu, 08 Jan 2026
 07:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-3-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-3-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:20:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSJbbRxoY1=U5KeYHm-Ahr8fU_Qzt7B9csfHnSe4UnLA@mail.gmail.com>
X-Gm-Features: AQt7F2q16aDcyNINlNDKVAWHLex5gQZCaSJCRmvbCOMq8H5xzOXqPJrqo2w-sOM
Message-ID: <CAMuHMdWSJbbRxoY1=U5KeYHm-Ahr8fU_Qzt7B9csfHnSe4UnLA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] thermal: renesas: rzg3e: make min and max
 temperature per-chip
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 14:04, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have
> different minimum and maximum temperatures compared to the already
> supported RZ/G3E.
>
> Prepare for them by moving these into a chip-specific struct.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

