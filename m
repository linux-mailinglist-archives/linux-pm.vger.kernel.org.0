Return-Path: <linux-pm+bounces-8632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33B28FC9A4
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C81F21672
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26016191481;
	Wed,  5 Jun 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K6C2/xpd"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985618C34B;
	Wed,  5 Jun 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585492; cv=none; b=iqKAUIO6QuuWzpoGeTTEw2aLPlPoFPgaZTZ6VUpkVLKDZkk0RwFdgpwkTOQe9yvPsqtldzwO0+nnEib6aSCXyLK5ynkvbUVtUguPfM1joIECLk0xVQIFo5Bto6YisC3kEkIxCcOIhQJr8cochS53jTZLUrcEqjg2GN5f1FXcPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585492; c=relaxed/simple;
	bh=2hjwVFmRoFTS6oZrCvJYjFdWpPR5DTpzZ9n/nHhVnwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWgIOwC+ElMp1fDLG9icLTGCwUan+ueNaGx/QB/hIHgEr+qP9Kz95G+vE9h8FvN3ZyWN4BNPUkKrphbg1XRrxioB5xF7IRwswJxUwlAQkvEfj8YLchpvVQkRTQfhwj1xL+vw6KRHXTZTTz4Z2rjFo5dzbKt8YSX9VdLRptanaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K6C2/xpd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717585488;
	bh=2hjwVFmRoFTS6oZrCvJYjFdWpPR5DTpzZ9n/nHhVnwY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K6C2/xpdswwfBcJ8pX0D/sIOIMtdjmRjwYmn35v/F8f0QIDfOZcoqicTE54jQQWgZ
	 AY/FakYDMcM+W+0L00enXMR5z/k9QQcZ0f9wRUqU5v2OjDnXzBGsOuybbAzYxTT5PU
	 z9pxSfHjs61kj98JKzuE/b9Fgap9ekEkRdhK5ja9jSN5dIOnRrMiNNvYGcbNLoMUgl
	 QUhKYTrAkR3RFY5+90iNHLJ1I5Vn6o4ijxdlvti8wGzcwQbolMp+d2gcoK4KXxGbAR
	 /Mta48PsVYCfMWCdQ/t2AiikgaDoMqRr8oy0S1BFdr/IB1oN5wWy1P//6Dv1bAXX4H
	 a3WALSnj1I7hQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DA8DE37808FA;
	Wed,  5 Jun 2024 11:04:47 +0000 (UTC)
Message-ID: <c7162cb8-6a80-44c7-9dcd-830e5c8331e6@collabora.com>
Date: Wed, 5 Jun 2024 13:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/06/24 18:46, Julien Panis ha scritto:
> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


