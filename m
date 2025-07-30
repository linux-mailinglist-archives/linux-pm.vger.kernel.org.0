Return-Path: <linux-pm+bounces-31645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B5B1697C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 01:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FF21AA18E5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 23:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D72367AF;
	Wed, 30 Jul 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSOLHC+2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0ED376;
	Wed, 30 Jul 2025 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919692; cv=none; b=Ncgn/DIyzL8jIRY8F1q8XLdbvyLti2p4v1s4QqLy8i/EgdFvSbIVogt2XSUyl+reSkD92HXuDJIYSfdYdPvj/Y4ehaCMqTU2ZXWCUqesbFUzE/+9umuqWlaIkHIsyBNbCR+jVKt8Pz4gS3wflYZmFQ6hHQH+eRMJlvt5AqGaTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919692; c=relaxed/simple;
	bh=ksTAo89B5tD8/lmoPdu3reTp6aOUnIluUg9OleY9U14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0fboJH/x9TS5jqeAsOYaaCDxyyVL+zbZe2KdzTk/gfNlA6Ua/Z+92Awv0tV5sjvvpDwHlCDWmFSfHQWY81aiXzPu5QjcFyOniX/aqu2bNHvC8Dzn16AYmdsNMPNniIJlU68J8GlxgQ3St7iDI5OATBZNpPSBBIi+OVgSgzoKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSOLHC+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9603DC4CEE3;
	Wed, 30 Jul 2025 23:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753919691;
	bh=ksTAo89B5tD8/lmoPdu3reTp6aOUnIluUg9OleY9U14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSOLHC+2xcUclev5lMKl8YTnHqCnmu2FR84Qb5kWKtyZbtzmti1Wa3KT7HXqwee7d
	 XyCHLZKJitXDKtefOZDI+zCGWDIYnT2BBDuM56ofl267HDMSbr7C/g0Unv4i5o9lzr
	 tmAheYiFoK07Q/mv54PpuwelfzTTj6EE11VYCTTKAk5GARLbO5mfhdsEWg5eKsQey9
	 9pAfbmqhy4FU1ayoYWBiirB4O8w2dqVtwxIQzJPn+hG9CMAhqwAjXvFuxbJxA/Nott
	 Cfy12vaqHhWQHW/c0fjk8to667+B5u6m9hNT0st8d2NJUjvNyTM5PD6c9XYGj/JhLz
	 JveiUKPWniMQw==
Date: Wed, 30 Jul 2025 18:54:51 -0500
From: Rob Herring <robh@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, wenst@chromium.org,
	nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 9/9] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8196
Message-ID: <20250730235451.GA1911689-robh@kernel.org>
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-10-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730152128.311109-10-laura.nao@collabora.com>

On Wed, Jul 30, 2025 at 05:21:28PM +0200, Laura Nao wrote:
> The MT8196 eFuse layout is compatible with MT8186 and shares the same
> decoding scheme for the gpu-speedbin cell.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index 4dc0d42df3e6..455b96c1e1f4 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -25,6 +25,7 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> +          - const: mediatek,mt8196-efuse
>            - const: mediatek,mt8188-efuse
>            - const: mediatek,mt8186-efuse

You just broke mt8188 as it had 2 entries and now has 3. I think 
(based on the commit msg) you want to change 8188 entry to an enum with 
mediatek,mt8196-efuse and mediatek,mt8188-efuse.

>        - const: mediatek,mt8186-efuse
> -- 
> 2.39.5
> 

