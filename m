Return-Path: <linux-pm+bounces-34437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEDB52ACE
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1181C8191F
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318DB2D0C97;
	Thu, 11 Sep 2025 07:57:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350F2BF3DB;
	Thu, 11 Sep 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577425; cv=none; b=ExKSiu+SD257XAgp+XvSosM0joUdcQaIuppq59KcTG2rMUWL3tM/Qn/8X2PIHousgoZsBnGyZyrauKzeC28/ggYy8QM3zcJsbBrBilWk3k9j0Pkw803INp5hzU5g0YBnYYKF8xW+F7RIv7Nwk/e4OhT6XaqSZTJzPJpRU036+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577425; c=relaxed/simple;
	bh=K19jgcBrR2Y9+vW0QCX5N7p0aZ/+WikGlXHBbrIbX/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSKvBi0MR7gZSFLBrdGpq4k2o7FQlXsoQsucVp8EeFa/wv8PoN2kZyfa3DQk/OsaHy83ybL1m1rhhkGSDnvcAFUy7fJuultatnDdxHO/atMyBS3edgQqdJLgp1eXNj2i7rMk/Ss9SUJAIrFNWu5L3EsGBVpjuKyqF2oOiSR9CUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-54492cc6eb1so258257e0c.2;
        Thu, 11 Sep 2025 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577422; x=1758182222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OM7u0Uj1YJW3iv2n6lyWxvkWnG5a2qj+fgkKwtq326Q=;
        b=rWoulzyAPmSgRCxhRtAH1bKTQxukErbdCDInrMhEbq5KyOeikJypX3taSDQEpKchM5
         mLQOgzofuKu5ottRC2nKDL4UWe3xVTVG0JqtKrTLzuDDnDWnQjZ949m3egdlX78MtglO
         lW4URiktZMyuEq3Dsq/L147dXIWrw1Cd0Gplp1RuqKs1AayHlJna8yZ+U27k7yb52oxE
         dOI/Dm1phq5Yr5r9lDR8iJVsuOcuiojtAfw1+m6Qf64KZd71Pm7y1X54/MCevws4JQ+s
         qoXQAe7qA4zCdc+tEkuD27clGZAH19hI7g1Lgm1OVpPyN2I5B75oAHwvqMxUE3H1wNgY
         WH+A==
X-Forwarded-Encrypted: i=1; AJvYcCUOJgpHt4VDaiZUmx6R73yXod4begNvFvePN1ZIbeTzssO7CKUlTQC4y2zdXWnTgJ8ZJ88mOdIa61ALKlc=@vger.kernel.org, AJvYcCXUQ1VYK15k7EJrUBM3XQhbGyEBCutWzAsT7ylX5trm16tX1rJjHkvLQmjrz8OVOCJwD6HaMP4EauU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyciu6/6DW/Lq+1uJR2xD2XPlHKnxag3yIBCuLilQWZH1XdvEFc
	M0oPYSOw/pfSD8sK9G6cmabJ0wxYC8Qtlm7NuJ5Ds/zosXLVivyYJ4s2OtZM0QGJ
X-Gm-Gg: ASbGnctegfVV2iV9+tTV4S3MMatNJ5ssRbFcOvfjZ/dctdRwagp4tQ6QK/GKy/aQVUr
	JVWkT2AMi/WLItC3aDggfpVIitcedXCHYvdw/+CRa543Ml/VgTzY4hGtoW+bwgG9+V0X7coSUhJ
	bmXCbp5hpudWHM/WuZFMAd/SwMOb13XuYvla+tx40/Qvsojy9YxbAPuNnyWLFog5zRLkL6hKSJO
	LAmoD0Ry5uXO++PCH4dfOzGi+2UbuRCfid3ZkbEv+qMPUlSFt5Fo1ZHlKieghx+LgbUh90p2+fy
	SOaTYxZhdC1oODWHcnTVYQKo/Rf2K/g/yR5QseG83V48AquFsjTfsRfEexS+0rL9r3bFJWHDIql
	DJLb8BY5cAV90JbKNtwlCIiPy9oo+LXPjoB3J7VTsp2Nc4ywYa+Kk90qwwyjpUEaU4gRXQv8=
X-Google-Smtp-Source: AGHT+IGT6D7lR5N+aDFSn3Yp3Ym9WU9SSOC1kmA0KPzcjsl6NLorJcCV+jVoTELEwXzF6/BKL3AEMQ==
X-Received: by 2002:a05:6122:1309:b0:543:e5b7:85c5 with SMTP id 71dfb90a1353d-54737c54231mr6597687e0c.15.1757577422223;
        Thu, 11 Sep 2025 00:57:02 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d424df1sm142916e0c.27.2025.09.11.00.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:57:01 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8b32453d838so260518241.2;
        Thu, 11 Sep 2025 00:57:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6AXEmPZ30dSsJPwSgpWQGl34NgS0nZk2TY9SVjYKGOVzlhJl1bsbp90qz1BeBuk32ynilnjci5EqtL6c=@vger.kernel.org, AJvYcCWcLz6jFaD/w2uc0ixmH+2wdDyAI2ZHWEmHbYheaPPN4p+VSmdS5rhy7F7LaIjt0qwRpSAgW6Fh8aI=@vger.kernel.org
X-Received: by 2002:a05:6102:1612:b0:524:2917:61aa with SMTP id
 ada2fe7eead31-53d2490d7a8mr6761631137.32.1757577420966; Thu, 11 Sep 2025
 00:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-4-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-4-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:56:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWprnV+fAwFg0_zRbtq9JJj2UBLZK5tA4Rjv9L0qrc1XA@mail.gmail.com>
X-Gm-Features: AS18NWBIwzRqk9J7_ivbOFeNxxqUAVJ6xAfIH84kpYPPIAO0BE8jYNFp9s_zvpo
Message-ID: <CAMuHMdWprnV+fAwFg0_zRbtq9JJj2UBLZK5tA4Rjv9L0qrc1XA@mail.gmail.com>
Subject: Re: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM
 domains powered-on
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
> none of them in its current form are a good fit for rcar-sysc PM domains.
>
> Let's therefore opt-out from this behaviour of genpd for now, by using the
> GENPD_FLAG_NO_STAY_ON.
>
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/pmdomain/renesas/rcar-sysc.c | 1 +

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
on R-Car M2-W (koelsch) and R-Car H3 ES2.0 (salvator-xs).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

