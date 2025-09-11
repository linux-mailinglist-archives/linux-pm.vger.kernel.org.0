Return-Path: <linux-pm+bounces-34433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A0EB529BB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800BD56758A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330F26B0BE;
	Thu, 11 Sep 2025 07:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A7214A97
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575126; cv=none; b=D3yEkF90vkwvGm98gFAciyUFR3zYFnkNZfoMgQp5Qg34/6SY/iNNBDnhxUfuEvVw1bCXavngcVH2Ln6+VLXl2L3q4o8hnGHHdE26Dneut6mybv8osRnA3StK9GGvNRnXYnDdwiVoJICTe1vU9eW9Yvzt+VwSOi0K922JqpfDSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575126; c=relaxed/simple;
	bh=BUelSzWkvex/VFMHwxFi0FJy3ipU5VpPMti+oBm/JKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8VKiMpefIBUPi5Hei/LMJ5QUnx5iUKfCy+cIlWvW18YtBKjq2XUP1tGj2NEktEjRgoB7p7biEANNjUIU84BGVMZUwYHhwJO4dx3CiNQC7IUWLQpL2ZdLMnptN1hN6xzzid9tCxgq/tWzhS0kqDagv9z6OT7Lyw0m2m13u4IRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-89e5b87f406so124354241.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 00:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575124; x=1758179924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Xz8T3amYkNV7rSzjipUYMhb6u7hBtXfStQbJ8Sahd0=;
        b=HHKLHdAIPPsbFCjQxIs1mobUhiJ3bcTsJA2A4s46mTSwKAg+xYyf9OyCEhQlnP7VkL
         G1hZQtT8P9vDEjmFidqybmSmh1Fw1A+iF5fZMFlc41SIuE67MlubYbC6iZispNhYRlEs
         ENK3/FN6iCadRI4ZiqAfDrvscxWSPVJno1qQDg8wfMvwczDQzJ3dP8UV/ZE9B288QSLC
         H0aF1FZX2a/yxW/wx9Xohlzahsb2TLemADExmylFjnX0G/Y340B93PMJj8ZlY0MSIdxM
         SS+BxWA+HLP+kQn6VlOM59pvrtS/B4QePXorGb3SUP7dubNidnhsQ9mLGfVVD5RNj+bx
         bjVA==
X-Forwarded-Encrypted: i=1; AJvYcCUalNQTQo09Ple02Br62XFD2qnb4XdAjDn68rMfohnRoY0horuwqt6X2ybMXSfGIgWS0gMoYckGhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6wskNvt2M/RMSDE7E/yaMhDhoLtscLAOMdRVKyRQTH5oLJWL
	D5o49pcqV2VGVAxxZbAZ/vHZ6dn6XgFLjeUZo+IMn6K7/5BqwGqF2kbXuyshfpHq
X-Gm-Gg: ASbGncsK3nQ+i9F39/LVA4rdTrKARW8JEnz11ObfnLQYzPulKlSWMQSKE0681C1k6B8
	o0q1gaZGMAs7taX7PT9UQ5ciEJrKUJ0GgI7hBAB0tp1UFjFSkvia9An4CRk2A0sTQYGy0w+jX5H
	f2GuNvzkGBb400PaieRaJ06aBYcrt7iSNBjXv/zoMHY1jTvFG9yA9oyVVD7qax5xhxxc6P+bygP
	Hac304fbLgQ05H3E/L9wofo4Mndj20i+iDDFG69/0wch4SyvP5TDJ/APUsOopZf3wByNYH2gTAZ
	uVa8tuEZMKso2SZlebL88YSXRs02+ycLlYiYeVGrT81rEIar4G+f2lyoS0tlIwi24HVhnD3VSQK
	pS8+di74MwI/TUiu4AA363ss2DKNLgPOpAjOH6StwOagFYRC5vSl3+fFOUg91
X-Google-Smtp-Source: AGHT+IFgF2zpK2hbAnzBEUiVSCCNQyn5xXZ8AcijerNqJ6GqZ4aijjSey2C7ZXSUOi1EeKqtGK2MRw==
X-Received: by 2002:a05:6102:290e:b0:523:fa25:9dcb with SMTP id ada2fe7eead31-53d0dfbd6bcmr5421430137.8.1757575123854;
        Thu, 11 Sep 2025 00:18:43 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-55370649ff2sm180034137.8.2025.09.11.00.18.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 00:18:43 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-52e6037a484so80813137.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 00:18:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp++26bCydNaQt8lOJNqa7AXT2dL+lEj5jtgN3ApmyhA+BdcH7LXlCc2aOkv/3BnlLPE0Ta31jnA==@vger.kernel.org
X-Received: by 2002:a05:6102:54a9:b0:521:760c:7aa8 with SMTP id
 ada2fe7eead31-53d14d8c892mr5750708137.27.1757575122627; Thu, 11 Sep 2025
 00:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
In-Reply-To: <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 09:18:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
X-Gm-Features: AS18NWAQShHnTB-pHMrvSyt-wwqsfojP53wsm5mwBKc4qvyVjVjagRnbLu_77lI
Message-ID: <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Saravana Kannan <saravanak@google.com>, 
	linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Diederik,

On Wed, 10 Sept 2025 at 21:33, Diederik de Haas <didi.debian@cknow.org> wrote:
> On Tue Sep 9, 2025 at 1:11 PM CEST, Ulf Hansson wrote:
> > Recent changes to genpd prevents those PM domains being powered-on during
> > initialization from being powered-off during the boot sequence. Based upon
> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relies
> > on the sync_state mechanism or the genpd_power_off_unused() (which is a
> > late_initcall_sync), to understand when it's okay to allow these PM domains
> > to be powered-off.
> >
> > This new behaviour in genpd has lead to problems on different platforms [1].
> >
> > In this series, I am therefore suggesting to restore the behavior of
> > genpd_power_off_unused() along with introducing a new genpd config flag,
> > GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the new
> > behaviour.
>
> Is it expected that I'm still seeing this on a Rock64 (rk3328), just
> like before [1]?
>
>   [   17.124202] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff300000.gpu
>   [   17.129799] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff350000.video-codec
>   [   17.140003] rockchip-pm-domain ff100000.syscon:power-controller: sync_state() pending due to ff360000.video-codec

Yes, as the sync state is still blocked on them.
Disabling unused PM Domains is done independently of sync state.

> This is with a 6.17-rc5 kernel with this patch set applied.
> And it also has this patch from Christian Hewitt added, now in v3:
> https://lore.kernel.org/linux-rockchip/20250906120810.1833016-1-christianshewitt@gmail.com/
>
> When I boot into a 6.17-rc5 kernel without any patches applied, I do get
> the 2 for ff350000.video-codec and ff360000.video-codec, but not the
> ff300000.gpu one.
>
> Interestingly:
> ff300000.gpu -> power-domains = <&power RK3328_PD_GPU>;
> ff350000.video-codec -> power-domains = <&power RK3328_PD_VPU>;
> ff360000.video-codec -> power-domains = <&power RK3328_PD_VIDEO>;
>
> I would be surprised if that was a coincidence.

Fw_devlinks ignores the index cell (RK3328_PD_*), hence all links are
created pointing to the pmdomain controller (in case it has a platform
driver) or the first pmdomain (in case it has not). thus blocking the
sync state call and power-down for _all_ pmdomains managed by the
controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

