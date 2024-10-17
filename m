Return-Path: <linux-pm+bounces-15855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB29A1F92
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 12:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B528BF6A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2024 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027A1D935E;
	Thu, 17 Oct 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SZv7EJsE"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4179E1714B4;
	Thu, 17 Oct 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160205; cv=none; b=jQ70GenZi0ROcZdBPKFRPuk/I2I5e6tBOmoM9a6jZF4nnILUrQ8YGuPzCf90NSCGydW283wkGzi+F0YtB3w1NunGN3Semaijm+omn72lpr0fuy8iXQsioDALQKuxido5gBfL5yZt13rz6Gjvg6m5+7ck+y0Z4MuCSCG8MI0pess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160205; c=relaxed/simple;
	bh=RwqIFfRGEqyQW9D+vcB52y+EorSTxslTKNQrItVQj8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMt039J9nDiniowfgEuoQqupEfaHQ3SInwkpm2ec7i9HwJTX/aJuHMogWk8OBHW7Gcg1AjjiPA5CQXg/rCYstLPm2Loaui5QVrg2bGwgdKg7k6ZARZbgfUqgbl1umXJtxT9xPiCDkQSYv0YDlZk5YDWUvtE3v5sAflQ+fNqWESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SZv7EJsE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729160194;
	bh=RwqIFfRGEqyQW9D+vcB52y+EorSTxslTKNQrItVQj8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZv7EJsEYTOyLVOmgPHOkmX/FgACtcDz4NaZtZYGRAjThR7/05LMATp3LlgAkoFn5
	 KDaX5qqWC5o7jP8Su4IXglFwEgCD8gMzue6evaLee2QCty3JudlV2bIDMntsJFzhs7
	 Hmk8FO67Aik9t4tO+Sa+qcIus2mX0/iurdq6CuvO9IJYfIMZqtEjwedVFjnG2mLV7V
	 8BJ9IsKmfqw1jK1QLi6+4mko79ZgNKWqqXi3q5b8r3S7n5w6lc50cVaGCZHgdD9QYa
	 JypAIBjqHInbR3YLCOD/gDkhPy8Uqwv4mo6erep/YhIcYjTSgHzqGNgaUShss3D+fR
	 Wyv+v9tuQXfag==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BEBF217E137D;
	Thu, 17 Oct 2024 12:16:33 +0200 (CEST)
Message-ID: <d775bf60-f876-475e-8db0-511e87667a19@collabora.com>
Date: Thu, 17 Oct 2024 12:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: power: Add binding for MediaTek
 MT6735 power controller
To: Yassine Oudjana <yassine.oudjana@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Alexandre Bailon <abailon@baylibre.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241017085136.68053-1-y.oudjana@protonmail.com>
 <20241017085136.68053-2-y.oudjana@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241017085136.68053-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/10/24 10:51, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT binding for MediaTek MT6735 SCPSYS power controller.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../bindings/power/mediatek,power-controller.yaml  |  1 +
>   .../devicetree/bindings/soc/mediatek/scpsys.txt    |  1 +
>   .../power/mediatek,mt6735-power-controller.h       | 14 ++++++++++++++
>   3 files changed, 16 insertions(+)
>   create mode 100644 include/dt-bindings/power/mediatek,mt6735-power-controller.h

Reviewed-by: AngeloGioacchino Del Regno <angelogiaocchino.delregno@collabora.com>



