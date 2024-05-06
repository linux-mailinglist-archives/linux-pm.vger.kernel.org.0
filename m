Return-Path: <linux-pm+bounces-7518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F08BC8A0
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422451F21C7D
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CA714038A;
	Mon,  6 May 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pOMpUPYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375B2942A;
	Mon,  6 May 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981959; cv=none; b=ivFuTak7jgr35M6gEzPy2yfy9vNqmawQQMGpXSV1YUXkI+FY3EuSXJIChqPMUNAChyH0528LldQe+5NML5fth7HL+e8TjkTV8KSewulmG3Ch2nsiY6glvLSqqpdM7rZ4QbJ/3zjuHwqMLhJfnOx5mf2doF8ynGioRbKNwax2pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981959; c=relaxed/simple;
	bh=LGT1GNDXYrrJBQ1nZQhic5aSHxR+NTF02wCTRXYawjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQhdmO2WdrycDHX21c84rLVBAHDuUXi4GeNoYKLvemdaXt4puBIWdJ+zhfBw/GaPrWItgUahdE4oYICYqp/3rLbJGJxv+RETK7mWv7nh42NetWP/A9H7806u/8Awh5YCIH2+iebUqpxRqCvG4ecJj1svLcc/cuHK3yUz/YD+g3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pOMpUPYI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714981955;
	bh=LGT1GNDXYrrJBQ1nZQhic5aSHxR+NTF02wCTRXYawjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pOMpUPYIx6ugk94aVsKsSUUjQjgWcLQaZyiiTc48yfdNdzKx3/JzwVdfi+oRxyTx0
	 +NGyRTLhOjhYEfkkGE238s3cjK4wbZOPxKnBRtGfe0qLjf4RIGi6219qCe+lb7JnXJ
	 yVrdanYcKnnDR02Fh4IiSBeXdiYViceGfjI6P1xAZYtyyMSuCU2QKLKrrkzNS/fhfS
	 1YN/RbnokpHFYMM1JdFxnbJvQY7dH7j85JDT22/mrjzsQIWFNh14dlJulU0T2vo9o5
	 DhQzlPbFtPhk0yGSnMlSNBh6eKkJ4J3uQKyHyjtaAxQ2JxIlu0gTfyKBxukTwUF9/o
	 Y0p2ygABicXxg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6950937820D0;
	Mon,  6 May 2024 07:52:34 +0000 (UTC)
Message-ID: <c41fd846-1738-4f19-b1ae-bd2113503e2f@collabora.com>
Date: Mon, 6 May 2024 09:52:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Fix wrong
 lvts_ctrl index
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/05/24 17:35, Julien Panis ha scritto:
> In 'lvts_should_update_thresh()' and 'lvts_ctrl_start()' functions,
> the parameter passed to 'lvts_for_each_valid_sensor()' macro is always
> 'lvts_ctrl->lvts_data->lvts_ctrl'. In other words, the array index 0
> is systematically passed as 'struct lvts_ctrl_data' type item, even
> when another item should be consumed instead.
> 
> Hence, the 'valid_sensor_mask' value which is selected can be wrong
> because unrelated to the 'struct lvts_ctrl_data' type item that should
> be used. Hence, some thermal zone can be registered for a sensor 'i'
> that does not actually exist. Because of the invalid address used
> as 'lvts_sensor[i].msr', this situation ends up with a crash in
> 'lvts_get_temp()' function, where this 'msr' pointer is passed to
> 'readl_poll_timeout()' function. The following message is output:
> "Unable to handle kernel NULL pointer dereference at virtual
> address <msr>", with <msr> = 0.
> 
> This patch fixes the issue.
> 
> Fixes: 11e6f4c31447 ("thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



