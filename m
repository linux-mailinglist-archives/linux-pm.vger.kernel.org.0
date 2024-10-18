Return-Path: <linux-pm+bounces-15917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB109A3532
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 08:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E481C23460
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 06:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EB3161320;
	Fri, 18 Oct 2024 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnfp2lxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FFA2D;
	Fri, 18 Oct 2024 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232132; cv=none; b=W8OkfE4fvg+cshNRRCzAqSxjYgFXl+Tpf3qc2/kMTFPT8HHN7GG9cWvGMxh2oWwBlLhp8elIfy1i8jywN8Ir4Ycx4XQuvdwmQRTI5d6MgxC0dsxn2198QYyHEK8byspe/uGo9Zxmc6TbHyGpPvAkK+ehkXkFfkiC//HB7I8nacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232132; c=relaxed/simple;
	bh=6M6kNuQkv1KZSwfaWc/t2QEfSgBi8V5I8EBEhHPPuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwl0ZBlMkX2h1I4P1J0kkUy4tPlz42ILE3/jh/Z/mSlp730024l/Mu3wmWc6AoNapt8bF0Ae4Gcl1MAspkv7AXGxJfNTdi0Q3N96hVxXs8b0it1HC6R5yOTgFCx49IwUxRw5GpKjjQYhPJ7PHl+x+XDPiQ2iiqduidEp/ycYKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnfp2lxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC74C4CEC3;
	Fri, 18 Oct 2024 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729232131;
	bh=6M6kNuQkv1KZSwfaWc/t2QEfSgBi8V5I8EBEhHPPuXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cnfp2lxzmyhGDgkVgPNqX/zLvY1I51HXCYPPhcmDv0eJIgeoUEyF0OUefj46Vk+S2
	 jMV+hXgMKzqJwtzDtgIwWntIiyr0wgIBjd7Bd544Czk7g9o8ppK3rEkbiDSJycpQyI
	 Ae5nmI9mAjbtPp3h3ZDHPge5LSFXd1YPCUfZ54mlijNySG6iioyUyNBhWlrPJ6Ty6C
	 7ZCbgJW4/Wlic4ven3lc7pcceHjTxXNuq27romS1yHsUiWJ6OGg7jDdoxGSRtyQINi
	 xwdXJBD+ncPuillu4R6x5euP7g568dI9r9ACYYfI7BKMw4V/svtGp6F/vbIB5Wrmy6
	 zr2CYpva1F2UA==
Date: Fri, 18 Oct 2024 08:15:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alexandre Mergnat <amergnat@baylibre.com>, 
	Fabien Parent <fparent@baylibre.com>, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Alexandre Bailon <abailon@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	Eugen Hristev <eugen.hristev@collabora.com>, MandyJH Liu <mandyjh.liu@mediatek.com>, 
	Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add binding for MediaTek
 MT6735 power controller
Message-ID: <gdksnrs34k5ypuvdxp6vecqakhxrjcswkxjmfwnbiyi24m42ix@4aekpbfy56pt>
References: <20241017085136.68053-1-y.oudjana@protonmail.com>
 <20241017085136.68053-2-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017085136.68053-2-y.oudjana@protonmail.com>

On Thu, Oct 17, 2024 at 11:51:34AM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT binding for MediaTek MT6735 SCPSYS power controller.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


