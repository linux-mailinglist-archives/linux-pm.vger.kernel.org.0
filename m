Return-Path: <linux-pm+bounces-15559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D575199AE8E
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 00:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263E0B23A54
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 22:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB41D1753;
	Fri, 11 Oct 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zjn5h6bx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58E1CFEAD;
	Fri, 11 Oct 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684921; cv=none; b=Cq0lHPdPTSkM2aAQWzyfyUOfpWFyMHFaGW7RnFNrsWWe8Irtq+U5fS61YGmXK7HwSacqvkOUsInP987oGDlUMuTQsgGdUQyoyyTGjmfpb6+PyZJtyFeLNgvTVdoEGgwCWbfKge7ERqOKldY5Pev1pZj2VCR5DHcoJzFIaPEgy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684921; c=relaxed/simple;
	bh=ELP8L478B16ztqydobuxgj5YxtYig7+S68KIYDDeqLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0mjjmxaSFpYrpWnpcrdgGN7kYDXJk2Zect1MV3t04vinv1Be8mFQg8edwiT6pcQabhxfm+bpXmDPeLgF8KG+dFxrsDivHSC0/bBt+Ikl+X2+O9yCHylW7PM8LrhRHIALTt79tbwxLok7Vy/ePOR+ai2hPEvaJGpbQKeuHn6inc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zjn5h6bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A234EC4CED1;
	Fri, 11 Oct 2024 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728684920;
	bh=ELP8L478B16ztqydobuxgj5YxtYig7+S68KIYDDeqLY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zjn5h6bxsTfHdSjmsw3xZzC9NnFt9LLBRiL1gLEZ9MPe2rHf2VFBr3wdq0x0zPlO0
	 TmhfWnV4qr9xzLDdO5oFi0dQ6r4vsHF1GbotmtsS9f6GJnv3zfyZjIYQMMSDn3hp/k
	 ZboIwLveYUg8zUwlImOW81JC2JSKpOSm/2gYCnynXm1r+f2phrg1TsIprInpBGxCPB
	 R9rql6nRINUG7I0zAG+4AGCkXnwhltA2nz9nxglxlbuAmvCQ6nLY3wH+i3IvS7SFZC
	 SoDq2bzKlC+4Cl/Ax8NoWbkJJTUKciau9ofuJsTa7IxaEekYlkjnQAc2CejxazXYkv
	 F3I91Ig4z+ckA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53997328633so4197849e87.3;
        Fri, 11 Oct 2024 15:15:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdCah1OpgQ2TVUBFQi3EpDKlJ+FEP2mAGM2omC5jcZib74QWcWxh0aUDM8vkryju/Jn0Hl7LMdr1UR@vger.kernel.org, AJvYcCWSiGZY5NwjixB38Ext7ntheO5Ee3QO+FLn9cS9+CHYT6Je7nkCKRP0d/bNSPdepyhKSTAEIJjiiURmqPMU@vger.kernel.org, AJvYcCXBDjbNe03uHnw96GQEPjxPuH3EbEXNqi0+otuTzotfphoR5AqkRsjEaOj1y9Prj11L4IF7IUzqlXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2fVTImkw0BjrZk/Se8s7CrHKVwt3UYVseznhm5cWLhUwcUtVQ
	UAYc+6XWifq9VrgD5jeWptEb9ZOjPsR/eXJsgzIyHaSIvMJPIk1hSD0xypOfcHaeTurv1bT2gDx
	QNrQY2zMKc9D/zjbwF5xBFCY62w==
X-Google-Smtp-Source: AGHT+IGF99XBUxkOenEdwmIQtOgExe7ME91mPqvFEk96liE+RiiXVBhJMUT6h/UsrdC6DJPbt++sPunoF7UITTYb8zQ=
X-Received: by 2002:a05:6512:e9d:b0:535:6a34:b8c3 with SMTP id
 2adb3069b0e04-539e54d772bmr770312e87.5.1728684918931; Fri, 11 Oct 2024
 15:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Oct 2024 17:15:05 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+F_pwhVLD1HF7=sYLp2w5kpc53UmzzffxyKzwh8WZthw@mail.gmail.com>
Message-ID: <CAL_Jsq+F_pwhVLD1HF7=sYLp2w5kpc53UmzzffxyKzwh8WZthw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com, wenst@chromium.org, 
	amergnat@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 3:57=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v6:
>  - Fixed build with clang (thanks Nathan!)
>  - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>  - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
>
> Changes in v5:
>  - Fixed Kconfig dependencies in interconnect
>  - Fixed module build for dvfsrc and interconnect
>
> Changes in v4:
>  - Updated patch [3/7] to actually remove address/size cells
>    as the old version got unexpectedly pushed in v3.
>
> Changes in v3:
>  - Removed examples from interconnect and regulator bindings
>    and kept example node with interconnect and regulator in
>    the main DVFSRC binding as suggested
>  - Removed 'reg' from interconnect and regulator, removed both
>    address and size cells from the main DVFSRC binding as that
>    was not really needed
>  - Added anyOf-required entries in the regulator binding as it
>    doesn't make sense to probe it without any regulator subnode
>
> Changes in v2:
>  - Fixed issues with regulator binding about useless quotes and
>    wrong binding path (oops)
>  - Removed useless 'items' from DVFSRC main binding
>  - Allowed address/size cells to DVFSRC main binding to resolve
>    validation issues on the regulator and interconnect bindings
>  - Changed dvfsrc node name to `system-controller`, as the DVFSRC
>    is actually able to control multiple system components.
>  - Added a commit to remove mtk-dvfs-regulator.c before adding the
>    new, refactored regulator driver
>
>
> This series adds support for the MediaTek Dynamic Voltage and Frequency
> Scaling Resource Controller (DVFSRC), found on many MediaTek SoCs.
>
> This hardware collects requests from both software and the various remote
> processors embededd into the SoC, and decides about a minimum operating
> voltage and a minimum DRAM frequency to fulfill those requests, in an
> effort to provide the best achievable performance per watt.
>
> Such hardware IP is capable of transparently performing direct register
> R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
>
> Summarizing how the DVFSRC works for Interconnect:
>
>              ICC provider         ICC Nodes
>                               ----          ----
>              _________       |CPU |   |--- |VPU |
>     _____   |         |-----  ----    |     ----
>    |     |->|  DRAM   |       ----    |     ----
>    |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
>    |     |->|  (EMI)  |       ----    |     ----
>    |_____|->|_________|---.   -----   |     ----
>                /|\         `-|MMSYS|--|--- |VDEC|
>                 |             -----   |     ----
>                 |                     |     ----
>                 | change DRAM freq    |--- |VENC|
>              --------                 |     ----
>     SMC --> | DVFSRC |                |     ----
>              --------                 |--- |IMG |
>                                       |     ----
>                                       |     ----
>                                       |--- |CAM |
>                                             ----
>
> ...and for regulators, it's simply...
>    SMC -> DVFSRC -> Regulator voltage decider -> (vreg) Registers R/W
>
> Please note that this series is based on an old (abandoned) series from
> MediaTek [1], and reuses some parts of the code found in that.
>
> Besides, included in this series, there's also a refactoring of the
> mtk-dvfsrc-regulator driver, which never got compiled at all, and would
> not build anyway because of missing headers and typos: that commit did
> not get any Fixes tag because, well, backporting makes no sense at all
> as the DVFSRC support - which is critical for that driver to work - is
> introduced with *this series*! :-)
>
> P.S.: The DVFSRC regulator is a requirement for the MediaTek UFSHCI
>       controller's crypto boost feature, which is already upstream but
>       lacking the actual regulator to work....... :-)
>
> [1]: https://lore.kernel.org/all/20210812085846.2628-1-dawei.chien@mediat=
ek.com/
>
> AngeloGioacchino Del Regno (7):
>   dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>   dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
>   dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
>   soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver

Looks like the driver got picked up, but not the binding.
mediatek,mt8183-dvfsrc and mediatek,mt8195-dvfsrc show up in next as
undocumented.

Rob

