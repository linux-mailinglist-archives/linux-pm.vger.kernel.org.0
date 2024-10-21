Return-Path: <linux-pm+bounces-16099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBF29A6A09
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82722817E8
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDBD1F4FAE;
	Mon, 21 Oct 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QkH5yNv+"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834F1F427D;
	Mon, 21 Oct 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517095; cv=none; b=ev59y3WnnhRU67o0QWGGb7Y3vc7iCahIF+5/Qindly+oNrstGqXhBMssKat/Zo85iw9rusfRb1HBxl+OChoZso8SHJRpoX9eHswpHdwgVNlSuPRcs2gKcLO3VQNuMI1lcSZRaSLM+FKninOGfw7Ih4PaP+63e50adEKjjqV+Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517095; c=relaxed/simple;
	bh=rV80u/k3jOFu4yEbtYLRmEDMmculFGX04fxA7xDWrDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhnpxF0kxrfkUc2jlYC5HxOqkzuS7PgzZQb6KFEWOzqxXVbNfjzGfgjMuKfpWtNgFbFJY/TUDppw/KretWeBivIm8z08NxCCGXGLzLOgWOuJvNosGk7/p04j0ynQgVbwTycDqTfEo0kGwnRIhXKYvpM5EN7QBBOd8pqChn42BCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QkH5yNv+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729517091;
	bh=rV80u/k3jOFu4yEbtYLRmEDMmculFGX04fxA7xDWrDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QkH5yNv+zWr45ie1/RbYl8VSty1fYMUxHfvI3d1i9SQ9926R/L36aSBkdIXw+mpZC
	 eA/QXlfzhA7ultJn5U6zlHtjjmYFrsxa0Go7qZjWy9hQNKON0U9wfsH1JHXWVWrrAO
	 Nioy0UR6Nhdc9StYFcim4XfxkKkFe+m90OmLf8c2V0yq3Bwf5zajynwQWLE2uJ3HfH
	 qmDazi7CK/KErpIAaG/5Ow61Mz8nB1qdyGa2feF2j5iou7z6xPmnDBicPZJj9Qz3Td
	 DMMAiBs1eoKllORIYdCSor0tljhNmCl0968vTNR1f1wMGgQ1w7s1Wm5IPRXsW3TSAh
	 oXWGMDKL2AubA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EE1017E3616;
	Mon, 21 Oct 2024 15:24:50 +0200 (CEST)
Message-ID: <88b78bd6-2333-494b-909b-9fa73cffff75@collabora.com>
Date: Mon, 21 Oct 2024 15:24:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] Input: mtk-pmic-keys - Add support for MT6328
To: Yassine Oudjana <yassine.oudjana@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 jason-ch chen <Jason-ch.Chen@mediatek.com>,
 Chen Zhong <chen.zhong@mediatek.com>, Flora Fu <flora.fu@mediatek.com>,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241018081050.23592-1-y.oudjana@protonmail.com>
 <20241018081050.23592-7-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241018081050.23592-7-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/10/24 10:10, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a compatible string and related data for the PMIC keys on the
> MT6328 PMIC.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



