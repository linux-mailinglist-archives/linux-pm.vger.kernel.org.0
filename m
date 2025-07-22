Return-Path: <linux-pm+bounces-31254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59EBB0D2F0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004F7AA43EF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0622DE1E5;
	Tue, 22 Jul 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRgUNWfn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324E2D3EE5;
	Tue, 22 Jul 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169034; cv=none; b=VWK0SHEhBe4cqwwFAP3WYYjbFKJc4X7jET+sQFE/7Tvb4yEJ7HmGs+v34rOHO03LGtvF+1ozMghBm4jUonfDmd6MX/r8FaXPRtXZDXPzr6kbd2ucoqQ7Q3yiJt2c7AGgUBubxeGevegooflwt1Z+GUKW459X8K0y/mqFJb7Ffts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169034; c=relaxed/simple;
	bh=Lm5AP4aUvSzP6+iS++3IWKYJD1R8/KFmHM7lILbgnv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwlzOHfSS1LiHDsRsnrCxqLHZeRtYIOHmAiaQXuaQBNqm9wOGjAJPi/8MnmWsYatNX9pwJ/+Cmh91C366vF/FOOrZ2CaAO0c8ePJRFbyEiSSw/9K9vACvcx0pQWkOg7/+S6guHU5rSDlnzMN+Wstm/mfVTugRaFTrccFSsS9GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRgUNWfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B02C4CEEB;
	Tue, 22 Jul 2025 07:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753169033;
	bh=Lm5AP4aUvSzP6+iS++3IWKYJD1R8/KFmHM7lILbgnv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRgUNWfnwkSyeqXM1R0sXOHk11H/3/G35igUiJl91PUSWRX5PIM+qX11kf9ftOi1X
	 IIuou7OsliyeLWzOWYy2MjtLrD9rIw0M9wN9zGRpt9sKjQv9cqwxdKlPfTJmqYnfwt
	 5Gck9GgO/uJFmscSLNo4iStQNxg8YQLUUCMVZ5A37p03EoJwkj18/pwi00w97OHkaE
	 zC3CaL8xmtBheJOrIS+Y2FbWfehAm+fMDZu4zWX8fIlenl+fmaxUoKfLGfKkiaHjLZ
	 4KOtQ/TP5lJrq0niQ8jd9+tgOU/ekff1ca/+XjXSKnp+uN1ohjEwXRIZQ29RP7Wfsw
	 T8NOFiyGuy6UA==
Date: Tue, 22 Jul 2025 09:23:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com, 
	u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, 
	bchihi@baylibre.com, frank-w@public-files.de, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 9/9] dt-bindings: nvmem: mediatek: efuse: Add support for
 MT8196
Message-ID: <20250722-laughing-hopping-hare-03edb0@kuoka>
References: <20250721081459.16278-1-laura.nao@collabora.com>
 <20250721081459.16278-10-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721081459.16278-10-laura.nao@collabora.com>

On Mon, Jul 21, 2025 at 10:14:59AM +0200, Laura Nao wrote:
> Add compatible for MT8196 SoC.

This we see from diff. Describe the hardware. Is it compatible with
anything existing? No changes in the driver, so maybe this should use
8195 as fallback?

There are some differences in existing Mediatek efuses, so seeing here
empty commit only raises questions.

Best regards,
Krzysztof


