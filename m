Return-Path: <linux-pm+bounces-34438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282DEB52AED
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61C27B4F59
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAE22C029A;
	Thu, 11 Sep 2025 07:57:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2B2C0264;
	Thu, 11 Sep 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577468; cv=none; b=FgzQ0aC/xPf5w89YmRfTGPHW8mY8txgOoSty3w/96vGDFIhFxfogFmTRgmQQLIzaZ6UD0vhR1WdHSDqppwAGQbFS+peBaNrWZzO3M9BeyLETrqDtXCoL9kdwMJFphFZaxjY+6rwdkzMUoL41ixiGyGBj6LrbQIT+TrqSta7HkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577468; c=relaxed/simple;
	bh=tmwJwaZUiX8grRkWScOchFbKAaa5aKjQCl/6fsKg/E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCIznPOHwb0oCCWNaeiI8luB/60JO2CRJELfuFbxRUDISnWtLeAhtH8PgKztHOKvXjdXg4brWOxH2aiqOPT1aO1TZky5KmEoZtB0olRS6UmkvfjpxU9HMlhAtav1wiM4nunFfkskpTK29ibSXuygPaXARiaMjfnGyA5lp6KKeiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5449432a9d7so231513e0c.3;
        Thu, 11 Sep 2025 00:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577465; x=1758182265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aEqSU2P1b2CIto9Lv4/l3FD+TkgDRrCyIli94hbcAg=;
        b=nGCskf7p0u+B9Xm8ZzBvAQVOR2pNnq/dB1S+14kw/aLNbMUtQNCxXY5/gff/dfaQ7v
         ljPs1Q+2C4k5Tkrdq6XqIEIgCO6gJ0ygDqouiT3nQapLAAzai3wx/M9cU3DAc/yjLKKl
         GBd+sDIOIiig6rOrzeTlM3RS3upJYTo0Iboe7CgR47Shv6d93NVlDYD9KK75M/wirTJX
         pGaTuYcwTwtRd7xAeTcLOKE9M2FEoEJNJginjpF1qHqx7ftBUCoTd7gvaddA8bREMJvO
         DRJrRoaXQ3bBGcvGdd5mD8ZHreaFeq6dFdpg6UaseStDLM6cagmbBBCKb0FUUqfO7Qns
         YBsg==
X-Forwarded-Encrypted: i=1; AJvYcCVMQPDkAmaW/7gNBwidcPU+Ew3M6/ynI56/Z7HRraROt42ppRY1uIqY8Y7J/WMO1m82IMSpw3bCqoIguCA=@vger.kernel.org, AJvYcCWeQuEgiv4MYHubmQ7Gc76w1ulRfpiLIjg9kbDhu5PzQhJpgmThSdV8FuP6qw1NTPlF7y8O/hjgugY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCd9sA7+uSp2oktGvPximpBZnVNby8lmfspKBwqI+dzwz/YgFe
	tL8AijQh3kL9jJvwZPLW6nBXdEaGdXptZb8R8oTYlhBLrNoX+BMoN1nvWoG7LPLv
X-Gm-Gg: ASbGncsaEQwAAHzTMXFFKQhZf5UDgxdaGlmlSBG/nE6m8yx//DIByrlv8ZrSJeU2lsF
	xoYGMVxUqW1+GLbi3x8cx1k/DZBxvqhHchUcTpbgwe8nQYJyVh5vRGHhLdVqSZay6orYMf20106
	RuMahOwTZU8bsTVuQJyO4J8FvRjZqFA8pwHI9aYzTrzFwiWknlQxHk4tQVr9K656zjfr9eO8Nk/
	+ssTas+EX2b9LQP+7kZ6byplJdE9hFSwovqEy160ulrgX/eAlqxJKn2SGxIF/S0Fsn9nLosCRGC
	Ie9Ady+wSKoW6ZliypVohuzDgdx9Sw2J/YLbpafk9cK43pyKZSyvH85pY37GE1+o8K77aG/zO4B
	GZ9gqEWLz9LQFO1WKf+pafYDvnc9GihUM6U5bFc3asFrjlIHMDSIMgpayE2I8
X-Google-Smtp-Source: AGHT+IEJlBrR6LWhuCZddoggasoRZP6p0SMB4NzSLIwc/GfWBtcRPIi3yApGSD3s5Qu7TU1OjrAbIw==
X-Received: by 2002:a05:6122:2a0e:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-5473a6b5e5dmr5343376e0c.2.1757577465569;
        Thu, 11 Sep 2025 00:57:45 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d0a5292sm156817e0c.0.2025.09.11.00.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:57:45 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8972e215df9so102257241.1;
        Thu, 11 Sep 2025 00:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPJ0PfLaWyquZbvEeelblh/Y6+ElssUr9M9U9D2Tyg6FgEMbdFowAXfSLwEvtIC82LYczd1CXsk0tYxTM=@vger.kernel.org, AJvYcCX2gcyVKqKj42HuB9XKvv3xPG++2g1YCuoqwe3FLFc5MFUYkTpGea+wTegfvhLFv+RhTqwzntRQ8wY=@vger.kernel.org
X-Received: by 2002:a05:6102:f0f:b0:4f9:d929:8558 with SMTP id
 ada2fe7eead31-53d0dbe8691mr5573431137.10.1757577465161; Thu, 11 Sep 2025
 00:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-5-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-5-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:57:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5JoLtWXMyKuAUCZJ9eHNmwq+9tgxoZp_tra5EsR0MNw@mail.gmail.com>
X-Gm-Features: AS18NWAlFWRiIXmkD3SV5tWbWJm99eVB1ztGinHkPJ8EYIv22Z3s-pOOeozKf5M
Message-ID: <CAMuHMdV5JoLtWXMyKuAUCZJ9eHNmwq+9tgxoZp_tra5EsR0MNw@mail.gmail.com>
Subject: Re: [PATCH 4/5] pmdomain: renesas: rcar-gen4-sysc: Don't keep unused
 PM domains powered-on
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
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

On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The recent changes to genpd makes a genpd OF provider that is powered-on at
> initialization to stay powered-on, until the ->sync_state() callback is
> invoked for it.
>
> This may not happen at all, if we wait for a consumer device to be probed,
> leading to wasting energy. There are ways to enforce the ->sync_state()
> callback to be invoked, through sysfs or via the probe-defer-timeout, but
> none of them in its current form are a good fit for rcar-gen4-sysc PM
> domains.
>
> Let's therefore opt-out from this behaviour of genpd for now, by using the
> GENPD_FLAG_NO_STAY_ON.
>
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
on R-Car V4M (gray hawk single).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

