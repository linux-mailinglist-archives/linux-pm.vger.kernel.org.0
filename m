Return-Path: <linux-pm+bounces-42870-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Oa6AWL/lmmItQIAu9opvQ
	(envelope-from <linux-pm+bounces-42870-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 13:17:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF115E8A7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECA2D3006120
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 12:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D202716F0FE;
	Thu, 19 Feb 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO5Pbf8l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CD3EBF27
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771503455; cv=none; b=TmnJXhCJBvvnrRasioOhbUToUXRVFxQt54gvji5rUIPAu2/NcwpeACqDRRyDOwSZYvbko82Orjd/g/Ba1USG2HJwLBwHHoISKtbQvdeorjEuzFQA6CW4ZKkXSpLTazlHZj+B9FS/genX9TzusxdBV+WXmkr308Vh/CjHdVINKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771503455; c=relaxed/simple;
	bh=C4KzRkTcBH31IsqtKSX383Oj11njptac/ptWZhF+oPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrx2Uj2Dn4YdZcxwi7QAyXBjQnPcWHqK0se5f3JS6W70YVPewnPpapJ7rvJUFvN6xjvNcXMMpPHrGfcq222tWviM3qqRxE3yqNIkAOZwrRRJlaEaUwwBPcPec87ykIShY69JnlRp4G2w6onYjqqEkJ37+iH/sF4wte2RAT3QIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO5Pbf8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C3EC4CEF7
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771503455;
	bh=C4KzRkTcBH31IsqtKSX383Oj11njptac/ptWZhF+oPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pO5Pbf8lZEFQSWb+CuA2qbCMJbv06jp2hX3tQoPBGo/xp5r5GpXDeXhqGZooAu4wf
	 v72vftxbLJ4uVEgBgw9Z5x2Srm7NRcKNFNT+fw+uIv7TobVIXXFvTex9Ko9vh8mimq
	 7ERFTJ9VoHEYwhLzjGID2AFLTCAl81ceC/1K+2DaUmOE7gWgrk8iHyOoMo8VY/zMyU
	 3yxdcc8/8/2ykhJZkk5B/d+q1ntRPNTXpTuGmtPUP9yiHAJz+mouCFAkI8H2v663GG
	 3gTNfG2p3gMC4TX4VsZLem2KXCZ6Fmj+IrsssE56K4fonFLn6ZOfjRDusSbxxyYX4W
	 64txl0spE5KQg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-676815e1446so345178eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 04:17:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzvGCtPMZc2SqM9qzU+KBpe+/t8aJqX5DPokJunBdkSjPO5lGVr
	zgEeZrTELbUV2kPqENWxV9zqvGp/2xLfkfRkw2BBnpkg2AYghjbNFGU/a+hJmDo7EeDhsxHsECc
	FpnSKZLJj0XF1/r74pyKMQ60i1mD5W/U=
X-Received: by 2002:a05:6820:3081:b0:662:b70c:a414 with SMTP id
 006d021491bc7-679aeebd4acmr1400578eaf.14.1771503454360; Thu, 19 Feb 2026
 04:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209124757.554032-1-ulf.hansson@linaro.org>
In-Reply-To: <20260209124757.554032-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Feb 2026 13:17:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZ0YS+JTMWAzmdUihgO3C5VT6Ch0UwzftskzaUqkzQ6Q@mail.gmail.com>
X-Gm-Features: AaiRm51677YHs6izjDM-jQfipCbwSf4hwjJ-gqyFq210a2M4TZy38ftFhPxZ6UE
Message-ID: <CAJZ5v0iZ0YS+JTMWAzmdUihgO3C5VT6Ch0UwzftskzaUqkzQ6Q@mail.gmail.com>
Subject: Re: [GIT PULL] pmdomain updates for v7.0
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42870-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8EAF115E8A7
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 1:48=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Hi Linus,
>
> Here's the pull-request with pmdomain updates for v7.0. Details about the
> highlights are as usual found in the signed tag.
>
> Please pull this in!

This hasn't been merged so far AFAICS, so I'm wondering if it has
fallen through cracks.

My particular vested interest in it is that it updates the last piece
of code preventing pm_runtime_put() from being turned into a void
function.

> The following changes since commit e2c4c5b2bbd4f688a0f9f6da26cdf6d723c534=
78:
>
>   pmdomain: imx8mp-blk-ctrl: Keep usb phy power domain on for system wake=
up (2026-02-05 11:33:30 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pm=
domain-v7.0
>
> for you to fetch changes up to 1fca2a4426aac222a724770a56c71e6bb3cf96f2:
>
>   pmdomain: Merge branch fixes into next (2026-02-05 11:52:19 +0100)
>
> ----------------------------------------------------------------
> pmdomain core:
>  - Extend debugfs support for domain idle states
>
> pmdomain providers:
>  - imx: Add suppport for child nodes for imx93-blk-ctrl power domains
>  - marvell: Add support for the audio power island for Marvell PXA1908
>  - mediatek: Add support for the MT7622 audio power domain
>  - mediatek: Expose shader_present as nvmem cell for mt8196-gpufreq
>  - mediatek: Add support for the the MT8189 SoC
>  - ti: Handle wakeup constraint for out-of-band wakeup for ti_sci domains
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (2):
>       dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
>       pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy=
 driver
>
> Dmitry Baryshkov (1):
>       pmdomain: de-constify fields struct dev_pm_domain_attach_data
>
> Felix Gu (2):
>       pmdomain: ti: omap_prm: Fix a reference leak on device node
>       pmdomain: imx: scu-pd: Fix device_node reference leak during ->prob=
e()
>
> Gabor Juhos (1):
>       pmdomain: qcom: rpmpd: drop stray semicolon
>
> Irving-CH Lin (3):
>       dt-bindings: power: Add MediaTek MT8189 power domain
>       pmdomain: mediatek: Add bus protect control flow for MT8189
>       pmdomain: mediatek: Add power domain driver for MT8189 SoC
>
> Karel Balej (2):
>       dt-bindings: power: define ID for Marvell PXA1908 audio domain
>       pmdomain: add audio power island for Marvell PXA1908 SoC
>
> Kendall Willis (1):
>       pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup
>
> Krzysztof Kozlowski (1):
>       pmdomain: mediatek: Simplify with scoped for each OF child loop
>
> Marco Felsch (3):
>       pmdomain: imx93-blk-ctrl: cleanup error path
>       pmdomain: imx93-blk-ctrl: convert to devm_* only
>       pmdomain: imx93-blk-ctrl: add support for optional subnodes
>
> Nicolas Frattaroli (2):
>       dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
>       pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell
>
> Rafael J. Wysocki (1):
>       pmdomain: imx: gpcv2: Discard pm_runtime_put() return value
>
> Ulf Hansson (13):
>       pmdomain: Merge branch dt into next
>       pmdomain: Merge branch fixes into next
>       pmdomain: Merge branch fixes into next
>       pmdomain: Merge branch fixes into next
>       pmdomain: Merge branch dt into next
>       pmdomain: core: Restructure domain idle states data for genpd in de=
bugfs
>       pmdomain: core: Show latency/residency for domain idle states in de=
bugfs
>       pmdomain: core: Extend statistics for domain idle states with s2idl=
e data
>       pmdomain: Merge branch fixes into next
>       pmdomain: Merge branch fixes into next
>       pmdomain: Merge branch dt into next
>       pmdomain: Merge branch core into next
>       pmdomain: Merge branch fixes into next
>
>  .../bindings/power/mediatek,mt8196-gpufreq.yaml    |  13 +
>  .../bindings/power/mediatek,power-controller.yaml  |   1 +
>  drivers/pmdomain/core.c                            |  59 ++-
>  drivers/pmdomain/imx/gpcv2.c                       |   4 +-
>  drivers/pmdomain/imx/imx93-blk-ctrl.c              |  77 ++--
>  drivers/pmdomain/imx/scu-pd.c                      |   1 +
>  .../pmdomain/marvell/pxa1908-power-controller.c    |  39 +-
>  drivers/pmdomain/mediatek/mt8189-pm-domains.h      | 485 +++++++++++++++=
++++++
>  drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       |  59 +++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c         |  44 +-
>  drivers/pmdomain/mediatek/mtk-pm-domains.h         |   5 +
>  drivers/pmdomain/mediatek/mtk-scpsys.c             |  10 +
>  drivers/pmdomain/qcom/rpmpd.c                      |   2 +-
>  drivers/pmdomain/ti/omap_prm.c                     |   1 +
>  drivers/pmdomain/ti/ti_sci_pm_domains.c            |   5 +-
>  include/dt-bindings/power/marvell,pxa1908-power.h  |   1 +
>  include/dt-bindings/power/mediatek,mt8189-power.h  |  38 ++
>  include/dt-bindings/power/mt7622-power.h           |   1 +
>  include/linux/pm_domain.h                          |   5 +-
>  19 files changed, 779 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
>

