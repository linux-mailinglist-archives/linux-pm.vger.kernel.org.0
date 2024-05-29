Return-Path: <linux-pm+bounces-8343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8A8D30FC
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED311F25348
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C6175551;
	Wed, 29 May 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZTnhcggR"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E0174EE3;
	Wed, 29 May 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970586; cv=none; b=pCslEs4rJNmlXYaKfV0Kf1L6He9SZyWhnVMGeFrhLj3Kx3rVQ/O7kbnLl9A44H/rQEJkffr3CecBj7AyHUGJUuZ94fVAjUvK+M6nCwUUdOh+5CJDoX6s5zuBnn+86mh3u+pdfDLVZtWENZZ86H0EcCg/J83cw8dmK+IIMEsHF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970586; c=relaxed/simple;
	bh=oSk3SYtQaPiocu1KldOp/z0QMNO1CKxus862pBLLiu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqMK79DGwjD3l1sfLzCFwWcHEOgvXZ/sjSaOY5K1XFAYD9KzQQ8nMa7sSJZoaOgqXfgiCCbBQKj8OhKQUKbLE0QU8mm3o82Q3YtzIP4rFmJ6ylIBbqq04SwJmGlFJ5f6GDPI1oFyQ27W1WRcgVJVSI9So33DGX9lfBezq258VPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZTnhcggR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716970583;
	bh=oSk3SYtQaPiocu1KldOp/z0QMNO1CKxus862pBLLiu4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZTnhcggR/aTkIWPr4EjsRN1TLFaejQWIO4UpTDCGoGHQs1uy/kQnRug7VHQjf3JVs
	 A7ZmhZKByBOC/Q0P5zdkuzPoemQCWMFwXLYQttGFP9OwAG5oWGS1UFhDgJaPd64Uv5
	 UrAf8P0KUQ/WXH4lM6VSGxsOJN/DId7v4VO8CRn2mHXhIBzsIrLsNXm/C8VNbx2ucC
	 yi68VzFiq9C1KwM6WcEIbJrE56M/G22g10jD7YkEvxR3iwPrqO6E2gnhfJpRmoHGp0
	 Bc1XH4QvpOm/Grqwa5Dq9Rt3nmRpm618+XYsL8j0kD9UQXBn0iUo34limkL4fAXu7A
	 w3NkUNs9d+mQA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 514F43782162;
	Wed, 29 May 2024 08:16:22 +0000 (UTC)
Message-ID: <dc34429f-a4bc-45dd-87af-a7c31533a845@collabora.com>
Date: Wed, 29 May 2024 10:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] dt-bindings: thermal: mediatek: Fix thermal zone
 definition for MT8186
To: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240529-mtk-thermal-mt818x-dtsi-v6-0-0c71478a9c37@baylibre.com>
 <20240529-mtk-thermal-mt818x-dtsi-v6-1-0c71478a9c37@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240529-mtk-thermal-mt818x-dtsi-v6-1-0c71478a9c37@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/05/24 07:57, Julien Panis ha scritto:
> Fix a thermal zone name for consistency with the other SoCs:
> MFG contains GPU, the latter is more specific and must be used here.
> 
> The naming must be fixed "atomically" so compilation does not break.
> As a result, the change is made in the dt-bindings and in the LVTS
> driver within a single commit, despite the checkpatch warning.
> 
> The definition can be modified safely here because it is used only
> in the LVTS driver, which is modified accordingly.
> 
> Fixes: a2ca202350f9 ("dt-bindings: thermal: mediatek: Add LVTS thermal controller definition for MT8186")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



