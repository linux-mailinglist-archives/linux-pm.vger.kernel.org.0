Return-Path: <linux-pm+bounces-16837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3BD9B7FD9
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01AD1C21998
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E291BC9FE;
	Thu, 31 Oct 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsnDtzRR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE061A7065;
	Thu, 31 Oct 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391555; cv=none; b=tXo/vi7AYBgKWJPTU8ZO7NDpJrSSq1mb9YPU/DQEvXJJLJazkfsgvyqwk8qnP7buDBZiDJXcwO4i9qBkTnR5uTVonUeI9wtVIMBWYeX9DRJm1Y88Rs716Nl8RYDbE6fmVlYUo1uLYrMT3dMhS0H4OWtxrCAkFhz+YF8dAVmqgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391555; c=relaxed/simple;
	bh=ruV57zycALUYqXq7sbjMoyguiyhwCg4fRE28NR5VSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvv+3MFC5qfiOdV0v2te1U47HeYnnTDo0W5mj5ynBj0gErjyq0w8X9XFFh5AGQYFkIJ2v1oKsiZf+nGsWu6kjQFqqO4r5hC/Pk7iR5qU196Od4L+YSEPkkhiTABPC0cKZnJjzDfEocM94e2/nwC+CgrgcqvBfK9CHpCoH+Dp5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsnDtzRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBDC4FEF0;
	Thu, 31 Oct 2024 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730391553;
	bh=ruV57zycALUYqXq7sbjMoyguiyhwCg4fRE28NR5VSPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsnDtzRRfxlfOkFUaj6rZqBLg+p2gcnjAvRPw4V6CrDB8wT2BrWE3euDB/8iZ0aAR
	 On2Y7EGfqwG/IV8Z3QKnIrCZ6Fzrz7Rc0LsNS2z0hism7t5QggS4JKgLnHEn2fMFXl
	 /Ire5a5Mubh/y81nD6qOiNSUugtDFmrrypFh1hVLy64ji7m5hD76o8iggNHvCx/zG8
	 eamtz2EJOg1VfqvU38OquRYZ+bxgWIQAvONv0fwJHOdzY4jIhAEFXmq71qTZZT447/
	 0zSpgYYnJy012F6HjA7/VEjc+eJmIreGQE/BdvA+oNGcmjuAiNkrOcDZguQH7u3KsY
	 QSsPeoW2emTlw==
Date: Thu, 31 Oct 2024 16:19:06 +0000
From: Lee Jones <lee@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/6] dt-bindings: mfd: mediatek: mt6397: Add bindings for
 MT6328
Message-ID: <20241031161906.GL10824@google.com>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-3-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018081050.23592-3-y.oudjana@protonmail.com>

On Fri, 18 Oct 2024, Yassine Oudjana wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add compatible strings for the MT6328 PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml      | 2 ++

Doesn't seem to apply cleanly.

Please rebase and resubmit.

-- 
Lee Jones [李琼斯]

