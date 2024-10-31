Return-Path: <linux-pm+bounces-16838-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E99B7FFC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 17:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1363281E55
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDDC1BBBDA;
	Thu, 31 Oct 2024 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t32C6N4s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4122E406;
	Thu, 31 Oct 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391918; cv=none; b=Ghj89MC4ovTQQzYsMrIbF4X0W2QMt1cyeOzFkggCBp4Xy84CFaVz+vCWnycGeFAGtLgj4RQSUBKp8awCfmiSFsFeW+Sg17XL/ZlISdSauN/y9MnGzaYljC1m2CSFEz7JTQTy1GNkiB+VJcd36tnb11TGDbGH+jHwqsQCt/qzPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391918; c=relaxed/simple;
	bh=kOzU4sWaB8Z+MTN4eCgKLw2cHRT9ijWtixUXAnUmrkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bQUE1nA9jwZ/+MdEQ7L64+5sqkPROt2c2OPOm8UjBvbMHPazGzkfTxtgIFm0hQuweJLf78FkVIN4DA4scZzL637DzS0t3YpcP3bCra5FMAx31PmBlTGWQUIjwOumhBp4ltkY85EweZUZrAfrgM9RtSRPWtDleYmZshn5yvqaQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t32C6N4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1296CC4AF64;
	Thu, 31 Oct 2024 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391916;
	bh=kOzU4sWaB8Z+MTN4eCgKLw2cHRT9ijWtixUXAnUmrkU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t32C6N4seQsMZw8/8OYb3lpIsZd1hFHGoeWntGbPiFss9dtTp1gVTsiP2D265EW4Y
	 pFUaQMb9ggqGzl/Hj+1bAwpkBO0TnOgmmaolQCghuoQCKUEbDTLHdj1CaXIIYgeE9T
	 QDN7L6PxJcU6+pYftOuAo6hyt/GPVMe8tquGeGMpEexn8WDeY9/+ciL3RK5gAJwNYw
	 gc7g+Y+RfM/ogalnMFkaLs4INKpK0ECG97OL0ATNRKacfbPor71kKWEu5FYgGd7sHM
	 y1td18RUcsJgC9kzu3t/lABQPwEuFGYMH6kVYMLITxCYJznPIrk8jhzGcQf8/gG1SJ
	 WIayZYm7etZJg==
From: Lee Jones <lee@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 jason-ch chen <Jason-ch.Chen@mediatek.com>, 
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20241018081050.23592-5-y.oudjana@protonmail.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-5-y.oudjana@protonmail.com>
Subject: Re: (subset) [PATCH 4/6] mfd: mt6397: Add initial support for
 MT6328
Message-Id: <173039191181.1807167.5693334391101093863.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 16:25:11 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 18 Oct 2024 11:10:46 +0300, Yassine Oudjana wrote:
> The MT6328 PMIC is commonly used with the MT6735 SoC. Add initial
> support for this PMIC.
> 
> 

Applied, thanks!

[4/6] mfd: mt6397: Add initial support for MT6328
      commit: 6e31bb8d3a63bb2c3efab2fb6bcfccac677a4581

--
Lee Jones [李琼斯]


