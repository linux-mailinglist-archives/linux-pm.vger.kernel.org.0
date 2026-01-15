Return-Path: <linux-pm+bounces-40942-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC8D25B81
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 066A33008150
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8453BB9E9;
	Thu, 15 Jan 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msLNEHfB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD43B9616
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494273; cv=none; b=AdBuhB0NWGi96Nqb0260t0xpVTLPN2MxT981nAMUIBCvLwJtRnkPCVCocRKLPrsAeTapT2PeyiHznlBER8QAauOoGZeQbWtuq3u+5yrkrujlNswWpWVpj9fprLdS76cdzgWyIWNchPyQ+PjkvutK5HRYu+ZHY18pLenjbqXSXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494273; c=relaxed/simple;
	bh=k7lNDE5gCSmeRgbwOBkK/9sHNPAfd5pEa5j5lNfKJws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBuRAmcFL4amAISpfVMkxa2TA1CnZy+jUiJafmPx8j15m48h8TsXn0g1ZpuI+ODRZe775xbQPeMAY2JMrBi8+YTuUrp8GkP1cy6lNMXQedoA8OYCfMRHFwYxpSl8aojXKAc942AoT8AcUyY0DwcXEAKc2YIqSlqBZqYzfqKkoHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=msLNEHfB; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-383010b77b8so8498791fa.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768494268; x=1769099068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UcPjMQs8wlZ69D72bOHJHv8LmpfNACepVb1D7xG/5V4=;
        b=msLNEHfBm8T7z1hOrKA17neRzVkyOrmk1NvuvMcmJqgb+rg+LVvlzR6GMUunQvhcp2
         R5g+ToG8+/rnSm9mBZ56uIklJVmlC75lI8o8dO5VwtE3H7z9nTMOOoGsnDB7jYa/oAZY
         GFsFjxaRxEQUrX0+3GGtrX0jiJOnzgkYNoOu7cjoNvkNkto8RdYLkRN3izHaToxzYmba
         SR44sqUP8z+96LABZSAld9cnxCGlxEGG6VpB/I97EnJqpx0nH9k8vvCMFzKIFCycb93W
         JgDE8fQDzgFfbjE1O6eHsWUPuLKXosjIfoPT9xkewZF9254KNuKNouZol37+lzXabMcG
         LEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494268; x=1769099068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcPjMQs8wlZ69D72bOHJHv8LmpfNACepVb1D7xG/5V4=;
        b=eBTXULcOrriE8WbROx9B0M3Eq2qdXX3qGHrCnt2xg44sbOoyPC6Fksqzb7FCXX1TUR
         oaIP3OcmpoBsU/d3nMz3c5giLzO4osxY4kEi6gcbbMueTQ1KyQgd53SI8bEzrDu0gTF+
         rjZiDlpRJKW+byme7687sA3Frhck83HU7d5W0QgiqeIpd/pjoIbPLpPQcC2Uzg1I3ibM
         F+V758iMpJlbu9tpHgo16ma25td7D68ikabn4A9w/bNYpbb/M1ZG6borKoTUbgihHKfb
         c++AcpgNULjv7wVApXOTA/e1UmfUqE76PnVwupa9Gxff3BkqozjtR74z0PGNNpynZFTY
         Vyag==
X-Forwarded-Encrypted: i=1; AJvYcCVkkFBmtHkLk8qrstdx3GazPEGBXP7l+Z8yKJV/XBo8lUTKnP1myfmGbq/0UWqIjAnreyz1OT+zQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ofS2D6VFgbqlTN99dQj382DbUlqBMauxQQ4hViSlyn8rjS5Z
	uTBB00tIsh2ihQKKdA5de1k8HSSCiZ0/geK3vZaKVQGp6N/DSdPMblXy0Jq7q272hxoTgKB/A9D
	pzunkgihLmsTzIfM5D+ViDTjGzfWeoZuwUQtLFsqs7Q==
X-Gm-Gg: AY/fxX4IRgEmoktD4q8SjCrONxtsILzw0VQSGGFZ18g1JQZKIhlhg+8rQLyi2gVH029
	sCCvVpOrgQLtJdMzAiP3qqlT6mJdYiXC45o+4787dgpglLA4ORV9D4T2gnMnZk7AXU6YiXPGNbr
	wmS/B51jxUo2k7o8Ql4oiaqaE9CyYCxyKts1HaPM57YqwReFoe3lpGJGFfXKii8NB2RjE/Wy/q6
	1MN01JVtWu3nS2Tnjmk0Y7q+LSirQfOk/SC7Yfd26mzxrCb9CoGetH6AHpVECNuQixqqME6
X-Received: by 2002:a2e:3003:0:b0:383:543:66d with SMTP id 38308e7fff4ca-3836f09c3afmr8580341fa.16.1768494267944;
 Thu, 15 Jan 2026 08:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20260113110012.36984-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Jan 2026 17:23:51 +0100
X-Gm-Features: AZwV_Qgstc2v5holxo2-uqRefc6HR54B_5kwg-eT_5uV86kY4RNFn6HUBQ_JID8
Message-ID: <CAPDyKFohjOfdg1vz1o4FAhThm_1CTF46SgrWSJuJYt3mLLJwNA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix dtbs_check warnings for MediaTek MT7622 platform
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	matthias.bgg@gmail.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 12:00, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> This series fixes various dtbs_check warnings happening on the MediaTek
> MT7622 Home Router platforms devicetrees.
>
> Depending on correctness, either the bindings or the devicetree was
> changed as a dtbs_check warning fix.
>
> AngeloGioacchino Del Regno (5):
>   dt-bindings: clock: mediatek,mt7622-pciesys: Remove syscon compatible
>   dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
>   pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy
>     driver
>   arm64: dts: mediatek: mt7622: Add missing clock to audio-controller
>   arm64: dts: mediatek: mt7622: Add missing power domain to afe
>
>  .../bindings/clock/mediatek,mt7622-pciesys.yaml        | 10 ++++------
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi               |  7 +++++--
>  drivers/pmdomain/mediatek/mtk-scpsys.c                 | 10 ++++++++++
>  include/dt-bindings/power/mt7622-power.h               |  1 +
>  4 files changed, 20 insertions(+), 8 deletions(-)
>
> --
> 2.52.0
>

Patch 2 and 3 applied for next, thanks!

Note, the DT patch (patch2) is also available at the immutable dt
branch, for soc maintainers to pull in.

Kind regards
Uffe

