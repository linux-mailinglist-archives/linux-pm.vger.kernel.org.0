Return-Path: <linux-pm+bounces-34439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08DB52AF9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 10:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F68584B58
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 08:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F52D24A3;
	Thu, 11 Sep 2025 07:58:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D727E05E;
	Thu, 11 Sep 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577507; cv=none; b=t0oBbRlhI96g/NnBypkrUg8v5l9qq0N4G3iMGntAm7zeYV/YYZkP6XB2S0S+WcntEYg6TxtE0KS62a05n7LyF7wFHBJGW/EzvULzzL9JawCwnyMEQWMEAie8JQyaLwCk45qigaeiq/LRSgVhodcEEZCulknC2v/xmrLq4eAbGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577507; c=relaxed/simple;
	bh=S7pxBOEXOOMswhbY/jMJLR+3QN2EKCRwsE9thJL3klQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBXSieziraYOy8KHoW2AN279sgxoqE7zNoiqX9fUx3Ifb7zLB1Ebb6iBZ7LfNCC0GJ1ug6hAg+AYf/6uGkk26v3eGgCJzpLUGWCEveBbze1z12lgGYTMQup2H5AvPFykBooAOnmsvBJD7cwF9LQtMOk5jycXUdy6mHio83BFsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5449cfbc489so303786e0c.1;
        Thu, 11 Sep 2025 00:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757577505; x=1758182305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XT8NMgj5vRzLdW9q9oYiImrawQNd8w2bYyEW9YcOx4=;
        b=GSTfBVS3M3B/+RVU4eiXo6svz7K68VKZu3xw0tLByuseqlYtjfAqtFEQ71hu4QEX43
         MZSj4mtzcpLF7rDekG39EjDfylSY1rrUQNV+6AD6D4/weT65+2VAd3wpD4aCiR6bssvi
         MRCFAPiRylGc8w7ldkXwFO0q1N+DwDZlIiZ3oDkXfqhTXxyrIsbe6n/bDUgULhR9hNuv
         XYprBeLeaJ48FndIHbKO1tFN633eJtpOkYYJXrGOTuPqQxOTVfC8vElbeQoXOEYx7yH6
         pGADGrjnDELLIna32gDSFg/fo+euo1VRx4FZ+DAldF9Tva27K3sn2tiKVSGQDQyUMn70
         wkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMpfmAgUtWR6rxHxxO2m7xiBKhp0MwY/K6XtWz1KGJxLuK6f0EU8PxCC2XvR8k+puwFSjdYZGI3SdpoFM=@vger.kernel.org, AJvYcCWAjdEiitd7PO1cSfcjkXRI0idLKAbENU0tNebkwNFEMvhZ7WQ0h4zfC0DAst4JgIxHlmTcHg+wUxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzljRfMXoaq5pAtHWMFFDOImFU5m06sx0V4zq1V7VSSZwG1WQhb
	ExYWSe7Z0TiJ7V0IV+WzVdMj1VXttkfKNb50JbeB58l507GXO6swuQa7nUpRQiKr
X-Gm-Gg: ASbGncuWnkFWxbL/hskkCtFRNliZ/vE+dx4t2zj43477zW3M9N+2RaSNr/rZCF1YWP3
	moSPE9S1gvMaERuujXrKujyS9Y9HDkePoWZFEA43FT8U2MFlLLm840i9j5zM+3wb7D1a21di01k
	Ggp8A4ukeiREuF75F+X3cpKGzYuZCthQJI+cRf/BM0G5xSkzXfX/Hnuckt++FbYT4d/YjiVoeWO
	M/CJMlyn1NrkrLWBw5zH9SK0G8baaKE1pdlEK0A1lPphbTiRSH+4lZVtNEmbccYW0GpgDFCvA2R
	o9+b6iE9qRXGS4sSk6LS4BOIrbj1enlcDvokIPCYDX8fKwdYFN2axFdMRTlN3w1CXHdWQSujPdX
	Kaq1n4lc7hxuFYT4IyTzqLk77g9qT8IYYR9XmyxcxCDOghGd/xQMEUerb1nJSgzi59jK/lt4=
X-Google-Smtp-Source: AGHT+IGbHlzAvyl8Me1OSUNICuljl4EoRw0r82NaJbzUUWp7T5rL8gW1FYiSJLlroMtn++5n3ep4Pw==
X-Received: by 2002:a05:6122:e011:20b0:539:237c:f95d with SMTP id 71dfb90a1353d-54a095db50amr831337e0c.0.1757577504995;
        Thu, 11 Sep 2025 00:58:24 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8ccc96625b0sm140136241.6.2025.09.11.00.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:58:24 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5369bb49213so750474137.0;
        Thu, 11 Sep 2025 00:58:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzNqt6H69H1WhT+a/H13fneXEve2k2Pr0hWf5sF4GLW5UxLiY56VtPXREWaFa7APkKL2FgRmlQT8c=@vger.kernel.org, AJvYcCXMrV5BE5+6D3ovw1hMhtqls6PZnQIo5FpRjbjSlf6CVUJhetMIQVfiMQ4SasWOS2qn72cs44xzdE4nWwA=@vger.kernel.org
X-Received: by 2002:a05:6102:292c:b0:528:9956:6a3d with SMTP id
 ada2fe7eead31-5520c29c86amr932343137.12.1757577504247; Thu, 11 Sep 2025
 00:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-6-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-6-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:58:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJ3D4DC4ukir-mon7_2unNpE_h9uw84yAdoZ6YmeFxWw@mail.gmail.com>
X-Gm-Features: AS18NWD_t2plr89Vw2try1XwdiXtIzwJE15Ly8pSYFY5EGZZA-yJFymvbXisIAY
Message-ID: <CAMuHMdXJ3D4DC4ukir-mon7_2unNpE_h9uw84yAdoZ6YmeFxWw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pmdomain: renesas: rmobile-sysc: Don't keep unused PM
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
> none of them in its current form are a good fit for rmobile-sysc PM
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
On SH-Mobile AG5 (kzm9g) and R-Mobile A1 (armadillo).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

