Return-Path: <linux-pm+bounces-20799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53EDA18FCB
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159401659E2
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2025 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9743E1F8F19;
	Wed, 22 Jan 2025 10:33:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BE4502A;
	Wed, 22 Jan 2025 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737542027; cv=none; b=hhkNLvkxPJS7CHOdaM5P8fRy7i0ksPLcTuLMZKdJHGFI2tlndg3vgu4ciCVMqqPFE/bLCeILhKx9P8KaKnVSoaq9M2G9hxP+/Z8RSnuS9iiMrYnPGlYdZtzE9DZcGoblnLnQDQukm0OkDnJdW3pbK48aSey0PmIkhFDrh3Df+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737542027; c=relaxed/simple;
	bh=5aRUl5Y3R0z6U1a9oiKlFjibBzF+i3VF3vmDyzRPmMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLjIX/s3rT3mX1v2q+JoD3RAPLfgwLP1Xyh/j79TwSKFfFMqOFxht8NGBZ8bcEhuVU/jLjT/xPnRWD9K5Cx9lbn9gnrw9YmSubnYbVXwlDliLYcAKXVWMfgS2ui79/kK2zENGKNr00g87xuh0g3LDOB5ZsYCtxoT+ybFIce48JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5174d53437eso3783240e0c.2;
        Wed, 22 Jan 2025 02:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737542023; x=1738146823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XkI+wm+NB2N9LIlwo90xT0gHZyWpbSFjMquVIxSSJc=;
        b=RfSd0ITSmgsGVm8dNMaGz2AUOUJHGqeHzwLklWFW8Hk76K1Bnc+YeJdtsZVhM1saY3
         c1XnWz4svKHzoTZwsCEgK0zeDYLCcfodpWRpHsaFiPIw6PMURIonF7Vm2PfZs+ovaTrx
         bx8U0CF59gb/iBK0DVB4wF6rDKlUIMw34vFGyFPL8INBuqiJ2mCc80COiBZ8O2ymT1s/
         xkLVzaUNg94hMWGHLNGe17Qo3FnzKBltFckIB96ZUMsxkAQXKHpKcEq1aXZLA6oup7/p
         Mj+3ZRmZitXvEhmTMz01XfTve600Zixxgrt5V5UzBGcC0GoKeMqmvcrZuw3PL01Zanrq
         6WAA==
X-Forwarded-Encrypted: i=1; AJvYcCUcRL+dtigVXb9YDUsbyU292bnBBFBkDzprz6B5XSUED4k/lcl6ROHIq6pOk3LU0o86QsVZLWAYy9Kowf/KiVrFqR0=@vger.kernel.org, AJvYcCWTdkwp2Phho+r26p9ytnpSt9EYVSTl9Yo92gFiqJNsdSkoFpNmvBV1ok5uCbOS4yN9rHWBxLlHPJQ=@vger.kernel.org, AJvYcCWgF8QeQLi4u3L8xKgjKTb9z8g21mI8dG+bGxG2XcwQu9LGr5vDZ2t0l7+eekIn+lFk7+eoGQHQAv82@vger.kernel.org, AJvYcCWqaPne3AVzC7lHFjORl4n73ym7Wx/KSqMiBVcxOsXGmLG6AKGO7SxctkCwVDHdidyWIEs/ZsDiyoEK@vger.kernel.org, AJvYcCX+NNaRUYbAuWLGfdwxiv588nI/vyUxZjmqnNleck3ZJvXrPGU8UtD4RSoQqwmjBJLMKg5NilCjCSKFy5Cd@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgGLoeKd+faVjghjlLZuuSFrcplglWx0FivxGbgW4SO/Zn5Gy
	zUU0xVPldy/lU6Ao256qzPiPW+YV6Y6z20381PTAtYfRE1sO9bCPUOx5Rrhe
X-Gm-Gg: ASbGnctr/rQJFrK4wjho4pOqAMH8G3mR2FtQWBzub9Byp+H9zPTYWGnSgco08VHjbGq
	MP+nlTqxmp+vUB4TPxb8K2bXG+aCygkW7Sd8JKGOOwMVy+UVcrBPzeo9B+if4F4IlmVUG1uWS+B
	xLOjGBLzNb+36gJY8qxO4QECmOdqXjk6xMuRdm+cDYOvIUWUj17l33O+EoMPYtol6Ozr5wsvrpK
	4BSo7Aye1Kr7jmi0Z94UH07Dh+pvYkT7nQU/rQrsxgYygDpJ1CbIcl+dBoWXqApv5feddP0TxGY
	B4GuodnbPZAp0q2QAqcFtAu5hAPvcRie
X-Google-Smtp-Source: AGHT+IEHY4azU4QiXNjgu76uBlPG1uLYhhuc/NN9Ck0UTANS8g6j3GOXZbUSC8B96Zywicmyd5h2ZQ==
X-Received: by 2002:a05:6122:2388:b0:51c:27a0:25b8 with SMTP id 71dfb90a1353d-51d592b4225mr17141409e0c.2.1737542023543;
        Wed, 22 Jan 2025 02:33:43 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf56bd1c6sm2131953e0c.29.2025.01.22.02.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:33:43 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c5a91374cso2954892241.3;
        Wed, 22 Jan 2025 02:33:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwxMMgjKNQiv1JiJ8UKvvleB1HQZOBF5SczK6Gf9A9HCDPs5C/61Wv5LN6vyk2oI+eZw2nbPsddkTJ2YKFD8uieps=@vger.kernel.org, AJvYcCVFmo9b0t3KGAe2uXkiPvzTJmWi8g8mUpWoeWomzWEpIC50ccLyGpcArQMSiRmLpQkQSx0DcXeeQVZ3@vger.kernel.org, AJvYcCVRAMJ4JScuMN7vJQ7Er/i9tqttXgT9RpY+CymGpugKpLMepmiJRMb+VMUGeVZ220qmflG7Ory2wnd1h3Ib@vger.kernel.org, AJvYcCW+zJ4pOqB0/9c8Y7hy21rdo/+iSw0KfPN7jC3tgg4NKjyNxaKg7xwkQ4ZYW1GqnplpE1hcqiDdPn0=@vger.kernel.org, AJvYcCWPwqctWTQoD5Z3ReMdqT5XSjsPWLvNrDE/LFAtIAb12Yj6gn9I7Q5PoZHVV/fnK24uvBaQg8w3y9A9@vger.kernel.org
X-Received: by 2002:a05:6102:3f41:b0:4b2:5ca3:f82a with SMTP id
 ada2fe7eead31-4b690bb6273mr17446848137.7.1737542022886; Wed, 22 Jan 2025
 02:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com> <20250103163805.1775705-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103163805.1775705-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Jan 2025 11:33:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJGWaTAxOnMXr4mCfzON8QZX8yPQn3P=14Qh5OswLYtg@mail.gmail.com>
X-Gm-Features: AWEUYZkJPokStUOT3TcAsrnueI2Vk5EIGp1vwEy5bGWF1hObbHDG-k1nE2SBS9Y
Message-ID: <CAMuHMdXJGWaTAxOnMXr4mCfzON8QZX8yPQn3P=14Qh5OswLYtg@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: defconfig: Enable RZ/G3S thermal
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Queueing in renesas-devel is postponed, pending acceptance of the
driver by the thermal maintainers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

