Return-Path: <linux-pm+bounces-30378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8261AFCE85
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF8B16FD2B
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED832E0928;
	Tue,  8 Jul 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCxeE7iV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1116B2E0935
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987130; cv=none; b=VM+bm9lr4UMTjjKy56htw1ILfTDiVc93kdAWBjquFBjnc0LwO3sZnhyt/XONEiNrk7ihwmC2OvvnwctSGiu6qdfrW+nM/C1OcFJZIY6VPtT/fNClqkSGjRtm6u6VwGvWidDSRt4tpMsBwLZ+yRdGqCd48ZNXfDxKcb1YtUrIWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987130; c=relaxed/simple;
	bh=BKAEA2rbTjauN4CZf10Bop3hBmw+E3yiNiTQp2bPJVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4XwmfKSVqtOWD23MP8rvdd7jOrQw4OZTGd4WJPLJCJFsh+TBbhwNkPpKtLlMYvLf1om1BvmpJvyKePE/jCHnbmt67vEYGKdyBNPpfRyh5wLpwknW7GZTU/EiJwCfcvyx9dBtn3Ueti82/Unq0oExDMpNKfNR5G6DuL68/MvvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCxeE7iV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-710fe491842so31373177b3.0
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 08:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751987127; x=1752591927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbN9vJsY/mkHEsGghFEQy2rviLOqFLUvl0p6J+/2RvA=;
        b=mCxeE7iVDSfoki+w5FHCuE8wu6pBkGzuNH/NDEu7FVD8wIBtqNJ8zRL1Ar8lE0ZYMA
         wAWiex2OwHfSAVdFXlDELaG/7hDfHO39ycc0CHMn/hDxrf1s1oiFiefsSEJh5LgPzhiT
         srYAavrZuGRVnv1I8n0F0QtlAY9VKqmCKpUoNxjWvxBsmd+QuLI90LMWSw4sxubJWTLA
         OtsvqU7koBYxI9ZA7GHi7w8VnqrM8675x/U5O6/lN82eApWgfEqFJz+pFd0lQv1KZT94
         ajNuXZVHSD0AtEG9aC2QshNor0E0JkXCE7VPvLq+osjtL7uf22mu7hKc6phLmuF7grHt
         1Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987127; x=1752591927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbN9vJsY/mkHEsGghFEQy2rviLOqFLUvl0p6J+/2RvA=;
        b=I6hhW1N201hQMn3/VT1BMKEXTYDhQs0Ed4pPGnsMJs3QUbgmlWRIpplWsb2hncXl+w
         AsdoawWEgpuaovcv+XTtfu8NPCLwMWV28Jw9JNWGMD9VSo9YMJpA/DJokXGK4Nfh+bSp
         SK2qjmADN4k2eVih92xnVSf9gAEuxIqW/+vjqcIW9FUgUcnW+AqoYF9aPAaPgOBBeFuM
         2JIawDHT1nknTiCOTMsnb5J6SGqd5jdZ8/1iJnQSA7u6diqWMmS9K6xc1ekvipcOJV7x
         84FwaewRYlT4mpAOZHB7vTjiiPeqF0pi0oVbjFkWs0xkzV83ehxrxQCV50aW0Yd0vrVF
         yd1g==
X-Forwarded-Encrypted: i=1; AJvYcCXA95V8YnmPoNvPRRq4O/rgNXxgXfe/RGZpxNocg9zaOTJxemQJ4ngZE3Fn0CyPtWeKd2bmCvDcYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGrkI1WlxlelDZfys/D5UnzFSE/iw+QkNNCLdicrEHP3kuhjx
	Aa2sdg/tljDmh8CNNItpSeiqYFbCFTFKLeC0Z0RdCq/Zu2sHLWoga9HvYxY4RkCijnVNrY7pcoP
	uqMPuoTk/A8TRZWwOjTz5cxoFX/Xx0T3UFWkXddF1ag==
X-Gm-Gg: ASbGnctipXX8x+PDt59ZDpgbCYB0Sgps/ouxVezVwimc+aI16fm7RdFMQ0ehZJ5qAat
	ZQu8b+2kWK1WQYOfdLZ/jHTf1TdCei7m/X7HZVYIPyBwv1LMQaNvl9K30IlOnc5pnBxb+PVgufm
	PZty1voKwH2MPfcMhYb+/mbwF+0uMTwEhRGyW9o6PI32JC
X-Google-Smtp-Source: AGHT+IHBtCLoH5+e5H6LltUDB7e8LY/seAM2AxugJI15zrEUc8YzJfSv/mbx//NgSFS3ANi+4dqcSKaKRPubRavB9Bw=
X-Received: by 2002:a05:690c:45c9:b0:708:16b0:59c3 with SMTP id
 00721157ae682-717a046193fmr41621337b3.33.1751987126648; Tue, 08 Jul 2025
 08:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250707105605.98248-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Jul 2025 17:04:50 +0200
X-Gm-Features: Ac12FXwX-NP6E6P2Q56_QdBCypnbJ4xWnF08vZN6p09NHmwLlHzcTOT7bmz8Wbg
Message-ID: <CAPDyKFrDytmrkd6SsJc6W=k7Ayijfadu5jTOyTGn9rJS1osQBg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] pmdomain: Partial refactor, support modem and RTFF
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, y.oudjana@protonmail.com, 
	fshao@chromium.org, wenst@chromium.org, lihongbo22@huawei.com, 
	mandyjh.liu@mediatek.com, mbrugger@suse.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 12:56, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v2:
>  - Added #access-controller-cells allowance for MT8188/95 infracfg_ao
>
> This series is a subset of [1], leaving out the Hardware Voter specific
> bits for MT8196 until the discussion around it reaches a conclusion.
>
> Even though the proposed code was born as a preparation to support the
> MT8196/MT6991 SoCs power domain controllers, it is a necessary cleanup
> for all power domain controllers of all of the currently supported SoCs
> from MediaTek.
>
> You may also notice the addition of support for modem power sequences:
> this was brought up 6 months ago (or more) by community contributors
> (mainly Yassine Oudjana) that were trying to upstream the MediaTek
> MT6735 Smartphone SoC and needed support to provide power to the MD
> subsystem - so, even though in this specific series the code for the
> modem power sequence is not yet triggered by any SoC, please please
> please, let it in.
> Besides, "a bunch" of upstream supported SoCs do have the MD power
> domain even though it wasn't added to their drivers (because if there
> was no support in the driver, it would just crash the system); the
> addition is something that I plan to do at some point, but definitely
> not now as I have no bandwidth for that (bar MT8196, which will have
> this domain).
>
> Compared to v1 in [1]:
>  - Changed mediatek,bus-protection to access-controllers
>    as suggested by Rob (thanks!)
>  - Added commits to document #access-controller-cells on all of
>    the access control providers

The series looks good to me! I can pick patch 1->9, but I am awaiting
an ack from some of the DT maintainers for patch 1->3 first.

Kind regards
Uffe



>
> In the meanwhile.... relevant excerpt from the old series:
>
> This series refactors the bus protection regmaps retrieval to avoid
> searching in all power domain devicetree subnodes for vendor properties
> to get syscons for different busses, and adds a new property which is
> located in the power controller root node containing handles to the same.
>
> Retrocompatibility is retained and was tested on multiple SoCs in the
> Collabora lab - specifically, on Genio 350/510/700/1200, and manually
> on MT6795 Helio (Xperia M5 Smartphone), MT8186, MT8192 and MT8195
> Chromebooks.
>
> This was tested *three times*:
>  - Before the per-SoC conversion in drivers/pmdomain/mediatek
>  - With per-SoC conversion code but with *legacy* devicetree
>  - With per-SoC conversion code and with *new* devicetree conversion
>
> All of those tests were successful on all of the aforementioned SoCs.
>
> This also adds support for:
>  - Modem power domain for both old and new MediaTek SoCs, useful for
>    bringing up the GSM/3G/4G/5G modem for both laptop and smartphone use
>  - RTFF MCU HW, as found in MT8196 Chromebooks and MT6991 Dimensity 9400
>
> ...and prepares the pmdomain code to accomodate only the directly
> controlled power domains for MT8196 (HW Voter support was left out).
>
> [1] https://lore.kernel.org/all/20250623120154.109429-1-angelogioacchino.delregno@collabora.com
>
> AngeloGioacchino Del Regno (10):
>   dt-bindings: memory: mtk-smi: Document #access-controller-cells
>   dt-bindings: clock: mediatek: Document #access-controller-cells
>   dt-bindings: power: mediatek: Document access-controllers property
>   pmdomain: mediatek: Refactor bus protection regmaps retrieval
>   pmdomain: mediatek: Handle SoCs with inverted SRAM power-down bits
>   pmdomain: mediatek: Move ctl sequences out of power_on/off functions
>   pmdomain: mediatek: Add support for modem power sequences
>   pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991
>   pmdomain: mediatek: Convert all SoCs to new style regmap retrieval
>   arm64: dts: mediatek: Convert all SoCs to use access-controllers
>
>  .../bindings/clock/mediatek,infracfg.yaml     |   3 +
>  .../clock/mediatek,mt8186-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8188-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8192-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8195-sys-clock.yaml      |  15 +
>  .../clock/mediatek,mt8365-sys-clock.yaml      |  15 +
>  .../mediatek,smi-common.yaml                  |  16 +
>  .../power/mediatek,power-controller.yaml      |  39 ++
>  arch/arm64/boot/dts/mediatek/mt6795.dtsi      |   5 +-
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi      |   6 +-
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |   4 +-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  17 +-
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  12 +-
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  23 +-
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  13 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  20 +-
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  16 +-
>  drivers/pmdomain/mediatek/mt6795-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8167-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8173-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8183-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8186-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8188-pm-domains.h |   6 +
>  drivers/pmdomain/mediatek/mt8192-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8195-pm-domains.h |   5 +
>  drivers/pmdomain/mediatek/mt8365-pm-domains.h |  14 +-
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    | 399 +++++++++++++++---
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  74 +++-
>  28 files changed, 596 insertions(+), 181 deletions(-)
>
> --
> 2.49.0
>

