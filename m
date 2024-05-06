Return-Path: <linux-pm+bounces-7530-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF98BCC5F
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 12:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BC02851F5
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C2142E83;
	Mon,  6 May 2024 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VpYs5fbR"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018C757EA;
	Mon,  6 May 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992558; cv=none; b=XO+e+UjlVtdu+/4UTKZVDkPn/AoOtcTfPcV/nBM98iwnf/1gRVjVkCzJImD251PNKXL66hIJYmH3YF0HhPy7rO+0STQ/WSW7lNVAiwEGXaMmY7xJlGPA3DIdRvHPerSCaFVwPT1G1ngBYwml/PDcuxlUAahBSb026A4p8XjLMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992558; c=relaxed/simple;
	bh=U/kzEOQ26Mmpd4R1uZMPZjt4NRUfQiwR3IwxIqce6wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVcOadt2JAtwYmgqoIFcBsu9mHnGBqmCdSmxQUnZbwK8LLIqVcgJSWuiLzd9zsisKh26jZavfNx+RLXD38C6WHnW7ZfV1X1uTOarKnxXwgF3y/Owz+KF+G1CZGHHapqjZ5phFsFIqNUjx4+ITxl800bZ/QavSYrsTkqOKAOYqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VpYs5fbR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714992554;
	bh=U/kzEOQ26Mmpd4R1uZMPZjt4NRUfQiwR3IwxIqce6wU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VpYs5fbREURqcme7Xr78ZgTxa1uOFiGGJFgfpkypUbfRzsqB0NG60wqtWLz2zUVQv
	 FtDHq//NVsI3cEYx/O9beRilY7tnxZsyeBTV1SVpi/bhyjkrKb1TrOSw+tRpsDKbOv
	 QU2z9T1v2S95YZHCXr844IYYn/rd/C+RoKPu5He3beolspQH46vcNr5ZrFX8Rex1w7
	 SAJQX5JvoYqWK65hZKHIa4VQRb8B+FhDbDIXVl45UtOBD/NZvpEhMXuPf9QnN7rZtw
	 +FjM7b9ALWq0EAFcJecAn36Hxt584eUcad8d+0AFzDiejz1GUvonm78/dNL79WA/Ft
	 WA2BwAZVJZMeQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8C7E8378020D;
	Mon,  6 May 2024 10:49:13 +0000 (UTC)
Message-ID: <522a4bbb-af1b-418b-b00c-95657222160b@collabora.com>
Date: Mon, 6 May 2024 12:49:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] interconnect: mediatek: Add MediaTek MT8183/8195
 EMI Interconnect driver
To: Georgi Djakov <djakov@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-8-angelogioacchino.delregno@collabora.com>
 <52335ded-43e7-4694-80bf-6ceee7d918d8@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <52335ded-43e7-4694-80bf-6ceee7d918d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 03/05/24 13:53, Georgi Djakov ha scritto:
> Hi Angelo,
> 
> On 24.04.24 12:54, AngeloGioacchino Del Regno wrote:
>> Add an interconnect driver for the External Memory Interface (EMI),
>> voting for bus bandwidth over the Dynamic Voltage and Frequency Scaling
>> Resource Collector (DVFSRC).
>>
>>               ICC provider         ICC Nodes
>>                                ----          ----
>>               ---------       |CPU |   |--- |VPU |
>>      -----   |         |-----  ----    |     ----
>>     |DRAM |--|DRAM     |       ----    |     ----
>>     |     |--|scheduler|----- |GPU |   |--- |DISP|
>>     |     |--|(EMI)    |       ----    |     ----
>>     |     |--|         |       -----   |     ----
>>      -----   |         |----- |MMSYS|--|--- |VDEC|
>>               ---------        -----   |     ----
>>                 /|\                    |     ----
>>                  |change DRAM freq     |--- |VENC|
>>               ----------               |     ----
>>              |  DVFSR   |              |
>>              |          |              |     ----
>>               ----------               |--- |IMG |
>>                                        |     ----
>>                                        |     ----
>>                                        |--- |CAM |
>>                                              ----
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Thank you for working on this! It looks good to me.
> Do we have a plan how to merge all this?
> 

Nothing (regulator, nor interconnect)  will ever get enabled by Kconfig unless
the drivers/soc/mediatek patches are picked (or COMPILE_TEST!).... so I guess
we can just pick per-subsystem and call it a day :-)

As for the bindings, patch [3/7] *depends on* [1/7] and [2/7], but there is no
reverse dependency (so 1-2 can be picked, no warnings).

Otherwise I can pick all bindings, or.... whatever is easier for you :-)

Cheers,
Angelo

> Thanks,
> Georgi
> 
>> ---
>>   drivers/interconnect/Kconfig            |   1 +
>>   drivers/interconnect/Makefile           |   1 +
>>   drivers/interconnect/mediatek/Kconfig   |  29 ++
>>   drivers/interconnect/mediatek/Makefile  |   5 +
>>   drivers/interconnect/mediatek/icc-emi.c | 153 +++++++++++
>>   drivers/interconnect/mediatek/icc-emi.h |  40 +++
>>   drivers/interconnect/mediatek/mt8183.c  | 143 ++++++++++
>>   drivers/interconnect/mediatek/mt8195.c  | 339 ++++++++++++++++++++++++
>>   8 files changed, 711 insertions(+)
>>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>>   create mode 100644 drivers/interconnect/mediatek/Makefile
>>   create mode 100644 drivers/interconnect/mediatek/icc-emi.c
>>   create mode 100644 drivers/interconnect/mediatek/icc-emi.h
>>   create mode 100644 drivers/interconnect/mediatek/mt8183.c
>>   create mode 100644 drivers/interconnect/mediatek/mt8195.c
> 



