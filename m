Return-Path: <linux-pm+bounces-23989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4258AA5FCF5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83843BBD3C
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE526A0DB;
	Thu, 13 Mar 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5g9nS0x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D92686B4;
	Thu, 13 Mar 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885338; cv=none; b=uArl241zvUtM0QikzLuiapVfiOEtgObqMtEBCNskPSzEllfXtajJ0/5kAE053Ay0HBRH2XIZkpymEg3yAPV7UDQb705qpPwPuU9vFeUIpXjXnfAMwEgo0GVCRj1ji4CErcBV8z4JsBe9Npx7VByTg42wPRJ0h02s624k9JQCkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885338; c=relaxed/simple;
	bh=THq6mHlOJLV8EKqHAnKoFlUZWn392yIEy47QMjShAlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n/8/SmmvVzeRSWRh8Yzd3oOqDYVZILyRP94z6V7Yd654TCTptle3bXa3WXWTlrbGwLX8lKP6PqEXJ8tGdcVwnn9+xMOC1oRSsnQjZDujLu0NAfiPdawekloDzuiJpb6EihJuVQrPd5T4fvaQ6f+tvQNnQ+oFYPOJ2/aBlXKVLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5g9nS0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE776C4CEDD;
	Thu, 13 Mar 2025 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741885338;
	bh=THq6mHlOJLV8EKqHAnKoFlUZWn392yIEy47QMjShAlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=i5g9nS0xdkkWOO2oyUMVw6JOyWHfOuPKYcRdCeAhlp8NtPFR3V0QhwKDazBHOhspa
	 /hClD780+aGg4tvEKi6dKWcJ1aYELECR7nu8sgVScVYj9sr1RMjeOLuzN9IaMfVk8t
	 Pd+ftQu+RjxikPmqzGIYhjHTy/YntzBKN0hSTXLhACVi89tbCvPFn4S7H3DO+IcuFP
	 MFSE9WUiligV7g2g1NZjGbd7XiBBBSVPWUAMWyDM/1v9seEo34+49mnKqt1ZPoI4jv
	 oHiQZh9XiL9g08aauK8pV+TMQbB+1bhkgkws6TeDQgSIr7qsomMwqxxqr37BlVNo/4
	 etOof65Xcr0Kw==
From: Lee Jones <lee@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Andrew Perepech <andrew.perepech@mediatek.com>
In-Reply-To: <20250305-mt6359-accdet-dts-v4-2-e5ffa5ee9991@collabora.com>
References: <20250305-mt6359-accdet-dts-v4-0-e5ffa5ee9991@collabora.com>
 <20250305-mt6359-accdet-dts-v4-2-e5ffa5ee9991@collabora.com>
Subject: Re: (subset) [PATCH v4 02/19] mfd: mt6397-core: Add mfd_cell for
 mt6359-accdet
Message-Id: <174188533371.3796672.1232285311249129492.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 17:02:13 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 05 Mar 2025 15:58:17 -0300, Nícolas F. R. A. Prado wrote:
> Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
> allow the mt6359-accdet driver to probe.
> 
> 

Applied, thanks!

[02/19] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
        commit: 1b9e922a8df918812aff4090207abf4a8cb5aefa

--
Lee Jones [李琼斯]


