Return-Path: <linux-pm+bounces-40469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911CD040B1
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 16:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FF02310565F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F79934E777;
	Thu,  8 Jan 2026 15:18:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A176318BB7
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885491; cv=none; b=f46OdIUkHRYNKz/GSmep41zQ2UrBzzr5K/RrLWz9FSo4SlS7GP6WQds+N0epRXGOY2bDKvsTK8NptXDyj1dGSpu6n3UyQbDSh9A12MBrV5CwXpRqm99rclN7+/chkgoqQlkI6pQAbqz3TLeTSYzbQ/HIFq4EVG7FQyjqmdegdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885491; c=relaxed/simple;
	bh=VOCoSE33VyqEDpE4ACcKTOqSkK66W3Ph4z6ZWtitcKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFPwhqLQvLr+2MlIIyWTgMdNb/sxvKVMU5iYqGgQ3x9q/rCl/tJMBVThJs3V3wzjpQjKvevef35sqSOIy+kRRa4HQ5LBx+zRn54lT1e5F/qKHkW1o5Ud4A/aja++9pjXsfAIVpy8S5PsUwR36iOm7PSaO8uGqiej2UlmUVma+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ec8781f5c9so1153818137.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885486; x=1768490286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K19XWsL2sU1kQtxYfF0RYQ4zBuQAgGCyhs+nui2BEig=;
        b=btRw5rzup/WsRzN96iTU9hGGcRKLKSb+06lFralYiWnyveQ8JR221ZZvEH1Tsw09Ia
         PVWST4QRyC6YTo3Gq6DSnp3PP4ZyOrF7aElQWyThKq8h5Ph4DeL4BC84s29rUxeaUVFz
         t/088VTKCIDPggYPItaxy+GxFnFf6I7kpMoEwNba3xyIMXEBpGfMrC4LaMaiq0SutvBn
         /rMgG1nVo9dpdAxdqHiL64dThaCEwMWJohv7yX+2V0tbkggP2PIaJklaxP1pJ5aOBzCi
         qw64swBuDZt/xuF5n0Lx3oiZ46hx6oajsz3xQGoQbBv6tyDYMmxuK9VkfBGqbCnoNSGN
         684Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIX8v/kyepNtcoXu7Z6AmIcNcQ2NlC7KInrncQXWuDb/gCgQfgbtgUiX/mtgbOZjzLUaHcNMlxqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUKEvP9s9ekewm/pVUucqYI0ng6bOGgdpS/wAyPC8dgPwvcFI
	XHqgxiLxrgkFHw/NUcyAQWFD9Mxnc9EoTxbQlr6w07l+H+/zIxDqC4LoV3myRaVt
X-Gm-Gg: AY/fxX7Mmt2Wh9rd0gDpC+rtNRTzHXGeiiYdoEhLa481wpMAaf8Hki9tdOr0HhG7lq+
	FL4Np0LRPlMAxZKRxsXcU6CYs5FWerg/tq2Sv4bsqk919Ua2GyFV3GGGGeUR2DC4UfUIYaMLkvO
	6GzzOclvdPADk/bYygOTw5es+n+gCPCl7rxvuOzVspPITc2y77GDB4ChzMwXcBQUIjuOC9nI0s2
	nDJNBlvc6aoQM1bgcUhQmNMUvQftoXIcgaj5vLpJ8+XMJDwHn8qooxtsS+1pPbfHgBomiEdkjcI
	AjlTXXmrvEczkaJ+Co836LayQa+YqyUH9Nko++Fj5mdKDREpuQkrKjnICpbSYsZepCaZCIsRk8+
	8zxCNoFOUKDuDapvijcUdTx7/2qGqeoHNFOb1svz8qN2UPQgYXWhcobN+cV/ZZCI4vlUeDzhAiv
	KtoB/ta53eNrpkR9cDc2L9hzSDIoJdQojZzf1YYLWzLX91QZec8HQI3nz4Wbk=
X-Google-Smtp-Source: AGHT+IEi7FQX+UKtPACL7ZzuEQir34XOluQNHOka7PN6/s7lF+//oJaok9f48lPQfLPFO4ynX4MOUQ==
X-Received: by 2002:a05:6102:3053:b0:5ed:e4c:e144 with SMTP id ada2fe7eead31-5ed0e4ce2f6mr1823252137.40.1767885485644;
        Thu, 08 Jan 2026 07:18:05 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944124a3386sm6088208241.11.2026.01.08.07.18.05
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:18:05 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dfd380cd9eso2133631137.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 07:18:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdug19y4Zf8ln2NrnbzSLFTcP/FAtb6vJ08Dfd2VueAH1QWat+SFnH7+u5opcpuRSBiRnE10QKwQ==@vger.kernel.org
X-Received: by 2002:a05:6102:441c:b0:5df:af0f:308c with SMTP id
 ada2fe7eead31-5ecb692dc87mr2494543137.38.1767885484850; Thu, 08 Jan 2026
 07:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251126130356.2768625-2-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251126130356.2768625-2-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Jan 2026 16:17:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV9jwRL4=hAKgakymVY1fyUHG5ALg3Dd19aKeCNTC+ZtQ@mail.gmail.com>
X-Gm-Features: AQt7F2rGh841rSfsaYiGZnB2YxsDi_NtDLARw02BQ55fscjhbxfqeMGfvtv6Y0A
Message-ID: <CAMuHMdV9jwRL4=hAKgakymVY1fyUHG5ALg3Dd19aKeCNTC+ZtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] thermal: renesas: rzg3e: make reset optional
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
> The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
> reset line.
>
> Prepare for them by making it optional.
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

