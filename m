Return-Path: <linux-pm+bounces-15959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 602009A4022
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BB5282249
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFFE1FF5F7;
	Fri, 18 Oct 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqSA1IK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA61D967B;
	Fri, 18 Oct 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258690; cv=none; b=uJoois6zGP1mXCljlDPeTP6XclkcIr/YCsdUcbC5wP7JXGlEc8moNOYNkVd7C5ES7RZFgj8oev9HarpDgU68nGegOu6vKf+KgF74+x78+pOuVsKOJAVCZCS5sDmzNrKkHQSxFMlY5qslFUNeaOJ1Tzw/pMsnBkBpsIfEt09kXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258690; c=relaxed/simple;
	bh=QKtT8SqW4G954SAR1r9k1USNXcWid4P64fSmJMBOEk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFbF/os79wv64SkO0zu5EUz4a8o05cx/EeFIAxUNcX2laQEQhie3SlRPY5eAMPkzID5vUDbXK4Y83VaNdhjBSrscGipBCwPaRawsR1CBi7CPyuxFyQVa1oxLyw7K9W3WqU90UXw8KioxBxefQ21bLjMmOrUW26YLvSYxbkp0sGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqSA1IK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FCDC4CEC3;
	Fri, 18 Oct 2024 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258690;
	bh=QKtT8SqW4G954SAR1r9k1USNXcWid4P64fSmJMBOEk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqSA1IK2FYPqZDHLAjyARSjdlvij41a6fiIZnJwr8LzuBKGTIXsXPq/U+ssSNLoG+
	 GsX5n+OkCB3CFqtQGKfa0Okpv7+Q+6EImqF/dPBNVLglAxNYBmWghxYEyVtXXgYeex
	 xkXUFdKd1dJjIZ+cs9+KwrXcAAe/4YvYeR5Yahf30OaHhCsGGdmmZDELYs3+yhMMHg
	 oZLp6XZRGZxX18eruSdUqyTA3xuEa63Co355OA5xc+cyR9725zPQW/BVLEoZs7QvXi
	 ClBB1d5xVunhYZCDbiMj7gBz3YYepa0vm7A8LjI/qKWmMtI+aUl179O+mGbX8AIfRr
	 6WHyk7rjAspdA==
Date: Fri, 18 Oct 2024 08:38:08 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Flora Fu <flora.fu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, linux-pm@vger.kernel.org,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, Lee Jones <lee@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>, linux-input@vger.kernel.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org, Sen Chu <sen.chu@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: mediatek: pwrap: Add MT6735 compatible
Message-ID: <172925868847.81189.1460535251820890357.robh@kernel.org>
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-2-y.oudjana@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018081050.23592-2-y.oudjana@protonmail.com>


On Fri, 18 Oct 2024 11:10:43 +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a compatible string for MT6735 PMIC wrapper.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


