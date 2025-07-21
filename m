Return-Path: <linux-pm+bounces-31235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E2B0CB13
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A0C1AA8321
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7E2327A3;
	Mon, 21 Jul 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY2wVsAk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224F230D0E;
	Mon, 21 Jul 2025 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126740; cv=none; b=ozz5N4Q5jD4c1U1qOicZHPcXRVH0QCLS6zd72QkcNujJ9nxUSUkYJjM+BrT4tKPte2fTlHmGD2zOY7nFqDmYM3YTUa4aFQKolutK3wWpNMWQ3VMJt+a4tytLf5VFfomGHNlwJ/gTk/4yON9nxuP5/PuHWp1puPMVsxi7ocr+eQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126740; c=relaxed/simple;
	bh=SGFyd6hkJVVeWAZqZbFqfwOminQzrq2zer8F2GULDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHUDrOCOTtihM7bFWWd8A2mkz7gLFY6x9mOjAialZc5bByybEr3cqCi29kKCjpKeZjfyaDmSpPjTUgCFGuKf2M6hGGYOV8GYsmSvVVslkv/7zqIQxtfkhZ79gNp0dL3DiURMVZfyfdnVz2WiCbjx8UtSErGReFiPAaYso0DGFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY2wVsAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C6FC4CEED;
	Mon, 21 Jul 2025 19:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753126739;
	bh=SGFyd6hkJVVeWAZqZbFqfwOminQzrq2zer8F2GULDmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KY2wVsAkRTi0EX17ch8MEhAuFHc/o5USV46MmwuHYkGm/Bshjyj6fTQXwCULhQBOu
	 KJcPU/36aTPllGhmI5M5fK5yH0SlyeZy0uImuqfcwSdcxpzQCOt5qWcN4k7zb6C4Eh
	 fxBvn8v+Ot9aKcR9oIC0NShorhxK/UTkEoiDCJgKhB+Y57+s5qg1lWK7x+aWSX2a/y
	 ATQ37uSnOghkUjakX1vhK5oQb2I3QL76fAtYOV4To0GZKH3OEHLt0gD95jio6FwkY3
	 5PHu1oOs8x1lCqIVGu89oCCDMFWXQcC3H9VrjIxuoj+lww5xFCgWSqI3jncKlQ/m2F
	 NYkjFLwx4yHpQ==
Date: Mon, 21 Jul 2025 14:38:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: cpufreq: Add
 mediatek,mt8196-cpufreq-hw binding
Message-ID: <175312673842.1140849.10630028189155435330.robh@kernel.org>
References: <20250716-mt8196-cpufreq-v3-0-d440fb810d7e@collabora.com>
 <20250716-mt8196-cpufreq-v3-1-d440fb810d7e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716-mt8196-cpufreq-v3-1-d440fb810d7e@collabora.com>


On Wed, 16 Jul 2025 19:51:22 +0200, Nicolas Frattaroli wrote:
> The MediaTek MT8196 SoC has new cpufreq hardware, with added memory
> register ranges to control Dynamic-Voltage-Frequency-Scaling.
> 
> The DVFS hardware is controlled through a set of registers referred to
> as "FDVFS". They set the target frequency the DVFS hardware should aim
> for for each performance domain.
> 
> Instead of working around the old binding and its already established
> meanings for the reg items, add a new binding. The FDVFS register memory
> region is at the beginning, which allows us to easily expand this
> binding for future SoCs which may have more than 3 performance domains.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  .../cpufreq/mediatek,mt8196-cpufreq-hw.yaml        | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


