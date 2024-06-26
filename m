Return-Path: <linux-pm+bounces-10024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA73B9179FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 09:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8BD1F21631
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E56E15B97E;
	Wed, 26 Jun 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PFzJch1v"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC331155316;
	Wed, 26 Jun 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387827; cv=none; b=hWHlyxg0lpm66Po/YQQYVaAtQYz2KwbVE0Hqe3QruLeh6YSouV7hSnymHMaewv37TLoTx3f+SCmGU3gkBF+yKHpsHYUP1jDRwxhmsBl5GtqSrkbxaSyr2nRncSHheBKz9FnRbegPKFyZlOh7kVRUWWlzO/qHsIM8aFtg/EwU2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387827; c=relaxed/simple;
	bh=QVwwwwWJMC02wU6Kl7A1QxNTL8rAbcV54YrqF8y2+Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmsNrd4/YBsP2Mj+LSyEUNKEw5oR1x5Ivz+KxC74GBLb15lIv98ZxuVdTjziNG0HW+a5jnYzPUsXGKkAmGj3eh+8WCCmYUr6P8Pqzm3F7HB7qVJp9tlkOihpWqER1KWRqcRschpcV2kH15nBSRw1mAD4ifztmEIIgkou2BwAJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PFzJch1v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719387818;
	bh=QVwwwwWJMC02wU6Kl7A1QxNTL8rAbcV54YrqF8y2+Iw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PFzJch1vLYzrVQ7JPoyPNhbYxtzjzkfkQTYjt7iZJcbUYagAeEd+Jcz+mRS4N4k+C
	 7K44jeaYtTEURxDJMY+W9T2/97ED6LuC6VwGz30ZoH/oLS0ZmalwssH275HWYqMFUn
	 Fef+DZbZCzxpstdzVXYzJxq0IitWai9W+kgOLXK5hFLR4ZGmq5py6Os7DkmP//VEdL
	 039i81SnuMfSn3i/64BU46IYb2OSMqdRrhkDpxWlcnJbEPJnuD5HlS4GwlJ23IYTZL
	 XBgBQ0/nDEEe9QBAKzNoyiJb0DeHS+0eIOQvEmmAwd2jLYFkEC3gt0pVh5v37tcJHw
	 U20c01voSopKw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 571C137821B7;
	Wed, 26 Jun 2024 07:43:37 +0000 (UTC)
Message-ID: <4541415f-0e6d-438f-a7b3-0c29c196e432@collabora.com>
Date: Wed, 26 Jun 2024 09:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and
 Regulator knobs
To: Mark Brown <broonie@kernel.org>, djakov@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, gustavoars@kernel.org,
 henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com, wenst@chromium.org, amergnat@baylibre.com,
 Kees Cook <kees@kernel.org>
References: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
 <171934124556.1173981.12014605377517424760.b4-ty@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <171934124556.1173981.12014605377517424760.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/06/24 20:47, Mark Brown ha scritto:
> On Mon, 10 Jun 2024 10:57:28 +0200, AngeloGioacchino Del Regno wrote:
>> Changes in v6:
>>   - Fixed build with clang (thanks Nathan!)
>>   - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
>>   - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c
>>
>> Changes in v5:
>>   - Fixed Kconfig dependencies in interconnect
>>   - Fixed module build for dvfsrc and interconnect
>>
>> [...]
> 
> Applied to
> 

Thanks Mark, appreciated :-)

Cheers

>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/7] dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
>        commit: b147ae7ae5141cb10c520d372ecabb2c520210c4
> [5/7] regulator: Remove mtk-dvfsrc-regulator.c
>        commit: cd102850e32c145661c6a0640dc6c5feba11af72
> [6/7] regulator: Add refactored mtk-dvfsrc-regulator driver
>        commit: d2ea920a4092b3c0a6a004b93ce198ca37455d90
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 




