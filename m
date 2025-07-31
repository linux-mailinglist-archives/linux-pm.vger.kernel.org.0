Return-Path: <linux-pm+bounces-31663-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10112B16CB5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 09:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0047D3ACD6F
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8B29C328;
	Thu, 31 Jul 2025 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dBBNP2Px"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB31E2858;
	Thu, 31 Jul 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946775; cv=none; b=pDCSc3v+zhMniMus10N7MzrNE6Rbz/HIyWg53DcrJpKx9sfi1q3SIx1shP6tXK5UHtFGCEPmquQ1qQEK8MWeOCiY52hwRyT7BsvNe9wfJkGMQoIv+XlGyEWGxPu35kGreeMaK9Z/0kpf1igx3Q+gfaVJHhCotTVvLfLKAlLE91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946775; c=relaxed/simple;
	bh=xLDZ92NZiZGURqy1KihB6GBNQMXzkiyFkWW7HUN2XkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oiZR+hGWGhwlWnlsaXqVYuCOoyCd6+RfQ1WJ3WJ6ftWUhgw+zBtY2It/vwehDfAO+fYI6MBZsjtXbAC1gbaoLqTYt438pR8VLNBNfb6GL6/7bliMtBCeMtkoZYMbCyXNmrd72CHZbGYK8sdKuHHnWNCN6Ywyhl8l2fvpDp5xxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dBBNP2Px; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753946771;
	bh=xLDZ92NZiZGURqy1KihB6GBNQMXzkiyFkWW7HUN2XkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dBBNP2PxvhWmV9tpMlbU84kK3XubH6TLRhjv3KHB1DpnXq+DRkLRBkGGApHzeBGF2
	 sTEhUbXPFchJLu56c0oKNH6eAp4lSM50LfL+wypuKg4YRYAmlUwR7GD4GrFWyoO1fV
	 4NRMY9UCGpOtURK0ZfneIbMtJTHaUlfvUi1tqx0YdWwfU+Jbzl9EMs8EG4qYNR7fpf
	 IOWLvNw6VvuUD1eo+L8SiMOFfou3UdyNaMffn6NYbcyrUQMB6JZ2X2QeLWdE1p7U/I
	 RunxdJii1uHH/gX5fM0AbdaQ9HsHcyWOCplLnb/Nosqqs7A5H/Efph6l+u25nxcgdE
	 6u7dq3oTnRlww==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5136617E088C;
	Thu, 31 Jul 2025 09:26:10 +0200 (CEST)
Message-ID: <10fd2758-4ad2-4f5e-97d7-0dcdeefd15c0@collabora.com>
Date: Thu, 31 Jul 2025 09:26:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8196
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com
Cc: wenst@chromium.org, nfraprado@collabora.com, arnd@arndb.de,
 colin.i.king@gmail.com, u.kleine-koenig@baylibre.com,
 andrew-ct.chen@mediatek.com, lala.lin@mediatek.com, bchihi@baylibre.com,
 frank-w@public-files.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20250730152128.311109-1-laura.nao@collabora.com>
 <20250730152128.311109-10-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250730152128.311109-10-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/07/25 17:21, Laura Nao ha scritto:
> The MT8196 eFuse layout is compatible with MT8186 and shares the same
> decoding scheme for the gpu-speedbin cell.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



