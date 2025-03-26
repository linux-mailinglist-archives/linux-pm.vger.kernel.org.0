Return-Path: <linux-pm+bounces-24507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54747A715AE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218E73B2498
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1821D8DE0;
	Wed, 26 Mar 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owjI7ujj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070BAEEC3
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988302; cv=none; b=Dwqw4JqzFr7Z/5PoGgtFkRl+EXe5CHCppLKWEARDzDD6X2ncf9LkeyxdQnuinSr3X3xk7z6wT8BFSCwkvzlj/nHMeGcP+0qaK/oeUj1B/wb4loRvHQQaXrqy+wczu5kwssuXQM9qk0ydTaFJIITJWdThNvo6pSouQi35NqMntMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988302; c=relaxed/simple;
	bh=PtOldyJkQTuOrIlrZ0MS2qSdzcnjeTVIRPUO/G6iQWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLIZRYQHZTBevgDUWITlfX5duDJZmB+4tcBARdvkNLxd05TD4ZouuBrQEOQL2Az4UF8j0cAcBx/K94SJDhBLWus5LURi8tHfBIDgicgPKqrwSYNcg03IKMa3seHTrHjn4c6vZB4hC46J+Q4xUsNO1fzJ6gcf5LF3AiheY5/DAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owjI7ujj; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fd80f30ba5so43263337b3.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742988299; x=1743593099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAKfg0qsqFTp3rC4gKRjScpyZGRWGz93JbWST6kAsnA=;
        b=owjI7ujj7JWmWS6SVVsCM7txATPiNOvF3yprKYwoxiSW6Rp7yL5r5cSaQjrmWrz2tF
         tzcgp0wApnTXPa/lCxK3HLlCgRuZVWUozrxLXku69AbUwLU3mx7ydZFpjlP76+5zygxF
         C7ofQyaO+ieEFzkr3Jv88po1SaZFM8pCTxtm/XkwL6MC6BTFPV9DMdT5oLDz3K5AM0sp
         2ea9xPu7bMqnEgVCn/Nja7hvwpje+WjEI0av+drjFY55e+5Awxn+dAyqIqqL3edeKdcl
         SF/lXyJ/znTHi4EV5AUFMPQip/mtkFGW0MLV3ljD/jp5YwloM5dk2iZgVIFsY0c5Wm+W
         D3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742988299; x=1743593099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAKfg0qsqFTp3rC4gKRjScpyZGRWGz93JbWST6kAsnA=;
        b=RJWi02IHlrYOAu/EqwUgPUxVwayC3ksp7YWJ/v0xHe7enY/uSjqqVfHU9jScByEXx4
         YVTdEPm9A3DBUONlCgrBa66PWDBTp53TAmhNfTCXygBuM422XMhSFJa2cIZOhZr+iHLh
         SMHUUI+0sm0b8TgMP/HDRSEhX2s701+VSHeBubQzVqxIyWjPuOa2NF3UZxhyRM1Qf7rq
         Jl7MqvmONMcdzaXy+LXLvKLca4iyTnnE4sGX2dIWqfd8KlIgep1xPVhTQR7wEgkPTX2/
         IMKML41wolqZ2ZSYaFBGNo0UI1q36tkkZjbmd2rA1o2VAjbbsBouJh+cgBumOJ7YDiYi
         UK8A==
X-Forwarded-Encrypted: i=1; AJvYcCUx1Yw8lck7rGYW7WDqD8uqdXA5HgpTT6PMlg6EH+GKbIFJZc5GCu5Vp70DVBqzGLNS4F43/x9H6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnDocDCP/4Wa8SsP1MbNHjGpD9hb/UHW+C0edZiQw6kAl9nCe
	lShzgxiqbk4aNUyVXEe09y6ifXDH8Z/uWFLYDQkZ90/y1JxjUzy2TnUcJfi+HinmarT/wGjOJ/z
	tx8N9Vm9RsRrnSx4rbSpuHnywNmD6H/cFQwnATQ==
X-Gm-Gg: ASbGncsh6roXh43n0H/FX1p/WVVEejhzptXeLDVwNDkViB8CfuD0awqSgquNI4j4myX
	7Ol0mMmNuUAEWaUKEFi7xAhMDUwDmjuhYXKthjRlH27Xz5IkuJxDN8AF2bIeI3Kz83WwNRcF0OJ
	WDz6q5oA9XktuTgrZTVQlvG30PL1ADXLcQygP8D0mG57maThCAdSYOdJ642AI=
X-Google-Smtp-Source: AGHT+IG0bRqZ7yucLkko4jSBCBt6Lj/LtcXgRGGRXa8ZXxRF/rWOCdZbLtb/q8iP+odXXLa6ynfR6bWujWIchPutkxQ=
X-Received: by 2002:a05:690c:f86:b0:6f9:7921:480e with SMTP id
 00721157ae682-700babfd2d6mr231478087b3.5.1742988298731; Wed, 26 Mar 2025
 04:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
 <CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com>
 <20250303143629.400583-5-m.wilczynski@samsung.com> <de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>
 <4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com> <aacd03a071dce7b340d7170eae59d662d58f23b1.camel@pengutronix.de>
 <e90a0c77-61a0-49db-86ba-bac253f8ec53@samsung.com> <38d9650fc11a674c8b689d6bab937acf@kernel.org>
In-Reply-To: <38d9650fc11a674c8b689d6bab937acf@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 26 Mar 2025 12:24:22 +0100
X-Gm-Features: AQ5f1Jr_9rY3NEgVW4bBC1NZ3qSkcNWvCh-D1oUbC5XKRCPzJhBOl8lQH97_HVA
Message-ID: <CAPDyKFqsJaTrF0tBSY-TjpqdVt5=6aPQHYfnDebtphfRZSU=-Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with CLKGEN
 reset support
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>, alex@ghiti.fr, 
	aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	jszhang@kernel.org, krzk+dt@kernel.org, m.szyprowski@samsung.com, 
	mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robh@kernel.org, wefu@redhat.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 23:40, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Michal Wilczynski (2025-03-19 02:22:11)
> >
> >
> > On 3/13/25 10:25, Philipp Zabel wrote:
> > > On Do, 2025-03-06 at 17:43 +0100, Michal Wilczynski wrote:
> > >>
> > >> On 3/6/25 00:47, Stephen Boyd wrote:
> > >>> Quoting Michal Wilczynski (2025-03-03 06:36:29)
> > >>>> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
> > >>>> clock gate is marked as "Reserved" in hardware, while core and cfg are
> > >>>> configurable. In order for these clock gates to work properly, the
> > >>>> CLKGEN reset must be managed in a specific sequence.
> > >>>>
> > >>>> Move the CLKGEN reset handling to the clock driver since it's
> > >>>> fundamentally a clock-related workaround [1]. This ensures that clk_enabled
> > >>>> GPU clocks stay physically enabled without external interference from
> > >>>> the reset driver.  The reset is now deasserted only when both core and
> > >>>> cfg clocks are enabled, and asserted when either of them is disabled.
> > >>>>
> > >>>> The mem clock is configured to use nop operations since it cannot be
> > >>>> controlled.
> > >>>>
> > >>>> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]
> > >>>>
> > >>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > >>> [...]
> > >>>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> > >>>> index ea96d007aecd..1dfcde867233 100644
> > >>>> --- a/drivers/clk/thead/clk-th1520-ap.c
> > >>>> +++ b/drivers/clk/thead/clk-th1520-ap.c
> > >>>> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
> > >>> [...]
> > >>>>
> > >>>>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
> > >>>>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
> > >>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
> > >>>> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
> > >>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
> > >>>> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
> > >>>> +
> > >>>> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
> > >>>> +{
> > >>>> +       struct ccu_gate *cg = hw_to_ccu_gate(hw);
> > >>>> +       unsigned long flags;
> > >>>> +
> > >>>> +       spin_lock_irqsave(&gpu_reset_lock, flags);
> > >>>> +
> > >>>> +       ccu_disable_helper(&cg->common, cg->enable);
> > >>>> +
> > >>>> +       if ((cg == &gpu_core_clk &&
> > >>>> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
> > >>>> +           (cg == &gpu_cfg_aclk &&
> > >>>> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
> > >>>> +               reset_control_assert(gpu_reset);
> > >>>
> > >>> Why can't the clk consumer control the reset itself? Doing this here is
> > >>> not ideal because we hold the clk lock when we try to grab the reset
> > >>> lock. These are all spinlocks that should be small in lines of code
> > >>> where the lock is held, but we're calling into an entire other framework
> > >>> under a spinlock. If an (unrelated) reset driver tries to grab the clk
> > >>> lock it will deadlock.
> > >>
> > >> So in our case the clk consumer is the drm/imagination driver. Here is
> > >> the comment from the maintainer for my previous attempt to use a reset
> > >> driver to abstract the GPU init sequence [1]:
> > >>
> > >> "Do you know what this resets? From our side, the GPU only has a single
> > >> reset line (which I assume to be GPU_RESET)."
> > >>
> > >> "I don't love that this procedure appears in the platform reset driver.
> > >> I appreciate it may not be clear from the SoC TRM, but this is the
> > >> standard reset procedure for all IMG Rogue GPUs. The currently
> > >> supported TI SoC handles this in silicon, when power up/down requests
> > >> are sent so we never needed to encode it in the driver before.
> > >>
> > >> Strictly speaking, the 32 cycle delay is required between power and
> > >> clocks being enabled and the reset line being deasserted. If nothing
> > >> here touches power or clocks (which I don't think it should), the delay
> > >> could potentially be lifted to the GPU driver."
> > >>
> > >> From the drm/imagination maintainers point of view their hardware has
> > >> only one reset, the extra CLKGEN reset is SoC specific.
> > >
> > > If I am understanding correctly, the CLKGEN reset doesn't reset
> > > anything in the GPU itself, but holds the GPU clock generator block in
> > > reset, effectively disabling the three GPU clocks as a workaround for
> > > the always-ungated GPU_MEM clock.
> > >
> > >> Also the reset driver maintainer didn't like my way of abstracting two
> > >> resets ("GPU" and and SoC specific"CLKGEN") into one reset
> > >
> > > That is one part of it. The other is that (according to my
> > > understanding as laid out above), the combined GPU+CLKGEN reset would
> > > effectively disable all three GPU clocks for a while, after the GPU
> > > driver has already requested them to be enabled.
> >
> > Thank you for your comments Philipp, it seems like we're on the same
> > page here. I was wondering whether there is anything I can do to move the
> > patches forward.
> >
> > Stephen, if the current patch is a no go from your perspective could you
> > please advise whether there is a way to solve this in a clock that would
> > be acceptable to you.
>
> It looks like the SoC glue makes the interactions between the clk and
> reset frameworks complicated because GPU clks don't work if a reset is
> asserted. You're trying to find a place to coordinate the clk and reset.
> Am I right?
>
> I'd advise managing the clks and resets in a generic power domain that
> is attached to the GPU device. In that power domain, coordinate the clk
> and reset sequencing so that the reset is deasserted before the clks are
> enabled (or whatever the actual requirement is). If the GPU driver
> _must_ have a clk and reset pointer to use, implement one that either
> does nothing or flag to the GPU driver that the power domain is managing
> all this for it so it should just use runtime PM and system PM hooks to
> turn on the clks and take the GPU out of reset.
>
> From what I can tell, the GPU driver maintainer doesn't want to think
> about the wrapper that likely got placed around the hardware block
> shipped by IMG. This wrapper is the SoC glue that needs to go into a
> generic power domain so that the different PM resources, reset, clk,
> etc. can be coordinated based on the GPU device's power state. It's
> either that, or go the dwc3 route and have SoC glue platform drivers
> that manage this stuff and create a child device to represent the hard
> macro shipped by the vendor like Synopsys/Imagination. Doing the parent
> device design isn't as flexible as PM domains because you can only have
> one parent device and the child device state can be ignored vs. many PM
> domains attached in a graph to a device that are more directly
> influenced by the device using runtime PM.
>
> Maybe you'll be heartened to know this problem isn't unique and has
> existed for decades :) I don't know what state the graphics driver is in
> but they'll likely be interested in solving this problem in a way that
> doesn't "pollute" their driver with SoC specific details. It's all a
> question of where you put the code. The reset framework wants to focus
> on resets, the clk framework wants to focus on clks, and the graphics
> driver wants to focus on graphics. BTW, we went through a similar
> discussion with regulators and clks years ago and ended up handling that
> with OPPs and power domains.

Right, power-domain providers are mostly implementing SoC specific code.

In some cases, power-domain providers also handle per device SoC
specific constraints/sequences, which seems what you are discussing
here. For that, genpd has a couple of callbacks that could be
interesting to have a look at, such as:

genpd->attach|detach_dev() - for probe/remove
genpd.dev_ops->start|stop() - for runtime/system PM

That said, maybe just using the regular genpd->power_on|off() callback
is sufficient here, depending on how you decide to model things.

>
> I believe a PM domain is the right place for this kind of stuff, and I
> actually presented on this topic at OSSEU[1], but I don't maintain that
> code. Ulf does.
>
> [1] https://osseu2024.sched.com/event/1ej38/the-case-for-an-soc-power-management-driver-stephen-boyd-google

Kind regards
Uffe

