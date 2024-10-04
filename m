Return-Path: <linux-pm+bounces-15134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717798FD75
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2111C2835E7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B37112EBE9;
	Fri,  4 Oct 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUqi5YL3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347935280;
	Fri,  4 Oct 2024 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024286; cv=none; b=XTv5QZPzHzPP83kHJA5pvfQk/8lddcvXUldpkFMYDHCEhBjqxgMXtMvpV7q+ETMG3PTP0PBG2A2PW+DZqL8WjN9r6AkQxYA0V8XxA/kLiFsP6zO7C9tIoFJ5k13wNbn8sseReq53MuNokQNfr5UY/wWFiB6J2WfL+e5qMwYR7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024286; c=relaxed/simple;
	bh=hRRsY7h9P+J+jzsOIjFTtgHQRBKWcW9QYy9H7fPvjcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8VdHhO1Zd5kh7HsAbTqlAAgF+2VkFOezTVsyvNqVk3ikvplaPZoZ/Gbu5ot+7NTtZbqrenx8iJNdeOV7EejMN9H+k6OX8ISi/0NvNtK/q5y87mPnwQYkxCmIZd8FljOvZoWQcgfkZLERbpUyXXoKHcfEqzi/8aejybwMfA3rpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUqi5YL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFABC4CEC6;
	Fri,  4 Oct 2024 06:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728024286;
	bh=hRRsY7h9P+J+jzsOIjFTtgHQRBKWcW9QYy9H7fPvjcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUqi5YL3lSKBvN4bjhPjS+SLBDZ8jGWDCmQWCxSq5AYi5UPM5Az9rmp9cPqiErdyX
	 YwBhNBSc6ypoVIdnemuqglSLoUv6OC7ZWhD5c4RQyXWUfxO57YRoeZFDXhGZpxdqtj
	 YX1YnhTV34zX5M5H/QKiSimqqAL/Zovhymfr6/pYrbRZgLxuT3gDsEtvvMLi6KCULi
	 SVXCkgHkzwTPAhTu1lcOPIYjInr9vyOLJNdjlUkFYnvW4hDEQYdE9wNXEwvp4mN4ZT
	 iFxy8fVbhBO2jzFqsGWFI3VqrJcihsm/b1GzF+cVTcnszDqOCmCHKyw10cIXp62cli
	 zhLwj3i2eHXaw==
Date: Fri, 4 Oct 2024 08:44:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Alexandre Mergnat <amergnat@baylibre.com>, 
	Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: mediatek: mt6397: add adc,
 codec and regulators for mt6359
Message-ID: <cv7icg65qhq52purvfrvlns7akejmqzuqodoujrlgbq4o24jpn@krjzrb3rqmtb>
References: <20241004030148.13366-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004030148.13366-1-macpaul.lin@mediatek.com>

On Fri, Oct 04, 2024 at 11:01:47AM +0800, Macpaul Lin wrote:
> Since MT6359 PMIC has been added as one of the compatibles of
> "mediatek,mt6397.yaml", the sub-device node of "MT6359 PMIC AUXADC",
> "MT6359 Audio Codec"  and "MT6359 PMIC Regulators" should also be
> contained in this DT Schema as well.
> 
> This patch includes:
>  - add 'adc' property and $ref for 'mediatek,mt6359-auxadc'.
>  - add 'mt6359-regulator' to the compatibles of regulators.
>  - add 'mt6359-codec' to the compatibles of audio-codec.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> Changes for v2:
>  - Rebase on top of the DT schema conversion patch V8 (should be final version)
>    without adc, audio-codec, and regulator.
>    [1] https://lore.kernel.org/all/20241001104145.24054-3-macpaul.lin@mediatek.com/
>  - Add 'mt6359-codec' to the compatibles of 'audio-codec' property.
>    Please help to review it again.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


