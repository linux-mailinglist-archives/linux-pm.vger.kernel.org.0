Return-Path: <linux-pm+bounces-35228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7EB965BB
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 16:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DF170B22
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947E246764;
	Tue, 23 Sep 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANjomnT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A14A32;
	Tue, 23 Sep 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638344; cv=none; b=LSe/7dx9NRn84uAQ9Xmo+pmGEMcSYVGUGGqmzCBWp+UAwZfoL6MSXTAZVBlDkiYsJdvwx1Fd1H9iXBBfHZ0iZuMsVWggTaS2P3EDCWrYWOvQEmmImkRq0CZaCuzsmMxDmzsby2Baod2RRny+yg6peSH0egTuMCUjAa5V8DHVkp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638344; c=relaxed/simple;
	bh=7y7/yuACkZLW79g5K5sIcU1j82Ksu2UcLf91irlmAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+zMwr26xYEGlIH2yeI2sizZCeGOgTZcIXHRDdvHioi8c4/JY57qGd01Orfzg9bwlyFJIUaxKn77dq7FcMg2ctfUZwWmJEMeHtdAigQd005WSvvinvxuN8MEGqRSl3Wye4A21FSkPyiqytexF3xOS77fzW/UVYU/QwBLXgQ09SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANjomnT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B57EC113CF;
	Tue, 23 Sep 2025 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638344;
	bh=7y7/yuACkZLW79g5K5sIcU1j82Ksu2UcLf91irlmAcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANjomnT7tvAlSvx7jeHkZqzpLc2fb96iYwhxRZrRaCXSqjMjrkqllXf6P0ALKVP0y
	 s3nI2y2MQxTpYk9losq0G3Q33MJWvh5B0X+KRd15ayCOGw7tSLWqycG7rpRmiscHYX
	 QeM2U4ZvQ00/Atfe6dDO8CRnKqR57PwxmPEmDfdrX6VAQ3dFDl6CpmKGZVf3+4nu6F
	 SHU/jZjtyWZrtTpXbmECEy7ut43ONk0H6gbinCYk4DvAIeTuqKZBRgRYXNP+lKDiXW
	 qmBk652g99F7+dxUQaGQfWmNpJA7bUnqgJtqSukaC24NAlPfYv9fwAoLjwl/MnpwOi
	 nbQ5VWDe9aXpg==
Date: Tue, 23 Sep 2025 09:39:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
	Simona Vetter <simona@ffwll.ch>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chia-I Wu <olvaffe@gmail.com>, Steven Price <steven.price@arm.com>,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, Kees Cook <kees@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	David Airlie <airlied@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 4/8] dt-bindings: mailbox: Add MT8196 GPUEB Mailbox
Message-ID: <175863834028.3197589.1266826496329321064.robh@kernel.org>
References: <20250923-mt8196-gpufreq-v4-0-6cd63ade73d6@collabora.com>
 <20250923-mt8196-gpufreq-v4-4-6cd63ade73d6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-mt8196-gpufreq-v4-4-6cd63ade73d6@collabora.com>


On Tue, 23 Sep 2025 13:39:57 +0200, Nicolas Frattaroli wrote:
> The MediaTek MT8196 SoC includes an embedded MCU referred to as "GPUEB",
> acting as glue logic to control power and frequency of the Mali GPU.
> This MCU runs special-purpose firmware for this use, and the main
> application processor communicates with it through a mailbox.
> 
> Add a binding that describes this mailbox.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../mailbox/mediatek,mt8196-gpueb-mbox.yaml        | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


