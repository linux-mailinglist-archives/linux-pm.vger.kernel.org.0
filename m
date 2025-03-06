Return-Path: <linux-pm+bounces-23530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F65EA53F3C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 01:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB483189373F
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4071B7F4;
	Thu,  6 Mar 2025 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu6cTkdv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37DA17C98;
	Thu,  6 Mar 2025 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221633; cv=none; b=c4r/al0d3JLR6I8dtNr8VPmM/WB2H89YMhjsnDkwgxHHVHy5x3gi9Z0/ZArxVX/pCKrEm+chrlekjlsVZctz0jeOsH7/A8Wk9HYFBNF5K/822xQ4pnxIkf4a4R+vUObcV+cFO7o3VVtro4kIogpwRH3ztlEwUuHGdZGX94BAIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221633; c=relaxed/simple;
	bh=spSyanY6lDrTp4+hUvjUAceIgKiQRFt9KTi6mE0l0WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwBsA4fGJ5+HD9Z5BSitzMzqscgwwSlAa9Gg9h0oC3PCaGVKfAmuwXez8lHtb1aiFJI3RagcBrXCY2SWyUbj4xxP5BasPAT6QzERmVeAD/fwGPo/cZYsx65QoqWnQJ7F/E1nddjG42y/hfMGLKuYki75X9ZELU/FMt6jB21rO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu6cTkdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35A2C4CED1;
	Thu,  6 Mar 2025 00:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741221631;
	bh=spSyanY6lDrTp4+hUvjUAceIgKiQRFt9KTi6mE0l0WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu6cTkdvPoLQBKt2y/ctCltQcUs578ttgYaqT+9P8WCOzeCN+KQAdPooLUq0p7ifC
	 LXmV3wyHRMH73JIqXofxR1Bsr+PbvF6Sk91wUwRr15/yiH1J7d2ZjRXRr9stmi2Y41
	 4YobdTP7NzBS0yyw99givCjWxqJ1++rAgI+lwSStzhUx67Hoxj/mZhsHwAfo2sXKs+
	 pGW3nKBh6LX9/LRrJgYubthnI/vWP4Y+AKYCQkDgkeZE0acWx3++QM6y5eaP/BqdUE
	 ey372jXyHj/pbw+bLkBINGuUvNpxx04Z61baOpcVSAdMFYMT0xN0lixFEhENq9NU8P
	 /fkWuv57Bd+Hw==
Date: Wed, 5 Mar 2025 16:40:29 -0800
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	Andrew Perepech <andrew.perepech@mediatek.com>
Subject: Re: [PATCH v3 03/20] mfd: mt6397-core: Add mfd_cell for mt6359-accdet
Message-ID: <20250306004029.GB8350@google.com>
References: <20250304-mt6359-accdet-dts-v3-0-5b0eafc29f5b@collabora.com>
 <20250304-mt6359-accdet-dts-v3-3-5b0eafc29f5b@collabora.com>
 <a8fbb536-a246-4650-8085-d576652b0301@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8fbb536-a246-4650-8085-d576652b0301@sirena.org.uk>

On Tue, 04 Mar 2025, Mark Brown wrote:

> On Tue, Mar 04, 2025 at 12:15:44PM -0300, Nícolas F. R. A. Prado wrote:
> > From: Andrew Perepech <andrew.perepech@mediatek.com>
> > 
> > Add an mfd_cell for mt6359-accdet and describe its IRQ resources to
> > allow the mt6359-accdet driver to probe.
> 
> Lee, is this OK to merge via ASoC?

Yeah, should be okay.

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

