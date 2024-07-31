Return-Path: <linux-pm+bounces-11761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A76943370
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 17:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0154DB23208
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CA1B3F1A;
	Wed, 31 Jul 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U9KVVQHD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEE1AE874
	for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440090; cv=none; b=u607ENWQFQwRG93uXkRKMSP+d1aGobYsyR5SVuPSGh/rZBVI0DXIkoxPLdQ5aoh5omBrEq9FzHMvrhXPCD/YueJF6Nt7X+x3gb7AJx3bxEw05WTX+vh7h8wA360xD+a2tN4vCbxBX5PAKxp1TU2z3imh5HgbZKexWbs0ESsHxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440090; c=relaxed/simple;
	bh=YkCUk3rJA5psymhigZShdr5asCljrDpO4/UbuFKnuR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEjIJ3yNrtcgfqRe9cI6yNEebUgMQ/IKUump2juPhumdoW+469KctBoq0bt//NifTEG/gjtIvRIJuhu907xnbc93IrEniQSWvTiwxJdTtivUgdh968wi9R/37gn32QXrYYZw4DD/m4s4VwkVl68Z3gn+e3RQbh66tBYWtgFanOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U9KVVQHD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a15692b6f6so9181156a12.0
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2024 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722440085; x=1723044885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0haZW6xREx05oo/OttdLfNmKhaLURqoiJ3M1lL9b6hs=;
        b=U9KVVQHDu/R3rCO81m969mIznEZ5sPHSal5IzGgtfgIAyrdoZ+XEPPg/EGE3+tq5wM
         AOnO8GH0tf+6ukCj2Unh0G1zQdxWuvpTSC8qT1MZDY3sobj7dwl5MVQ1y31xO2C41Zoq
         WOvBta3RvU1sLFpgPPRIFduqslbXyoqTXJm1TOv4aJSEidz8iXD9p/dcHMvhQjIiWJOk
         KyngORTLk3Yz7thFR24QK5x41ebJoCHOvKoosXcGw+lMBy+9OHx6o9DNMt7JNCkzYEjH
         poAw7nfSBxCFfIn1YRdzhrWYPwC8ZnTQv8xB89p90pmE1r2Yv1iWtxpKCX+wUbllxV7f
         001Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440085; x=1723044885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0haZW6xREx05oo/OttdLfNmKhaLURqoiJ3M1lL9b6hs=;
        b=wYuX7eZpZEP6cEnljsV0ZjM04DV7DdLo7dd5VA9LvSF9xzh4/VIiytiiggRSETFaOo
         VFMQBhS14MFh1f/L+dZ0rty2I2z2PWTQDuxZFEhO/Aw3d9A5tJ3fv8muKJbiQR15rpGM
         QJSYUsmcJP/p0BfE/ogXm3HM76VRUTOMLmrxZTDmLLhM1zaNxZqnlyTJZEAceOElQvtG
         7/+uKHQQeHtNVuF/wnncO/gOhh9Vne0JhnqKUHe7CwiuSMCrpORBURHzS8JShuQ3MUv6
         ArdgpIjXOiMEq06NETkXvFTO2q4ayhbaZYxz/2OWx3Hpvhd4sjCeupB6ZiwS4/i4TeK3
         7Avg==
X-Forwarded-Encrypted: i=1; AJvYcCUVWksauhhWuhnWnnyE8uzHd7wVnMYdOYps/QP34KFEA+Np5KLFOk+gNdOUKdvPg8QGaS6IZ0VRO5a21K8n51lytM65ltolqLs=
X-Gm-Message-State: AOJu0YwPdhD5OP/kQdTJ2vH6WJlRQEkUoj849gwWPoU35VXGrnPXSKRo
	F6FcUepAhthlk8zfVIZGg3RUeEKXhV24dZ9+ibNBy5QeQLD90iGmMCHDvIJ2X60=
X-Google-Smtp-Source: AGHT+IGEPSvbY32kvTP+Dedi5GlwS7ioq6a9GjXU2i8Z1P0SOaRgOy+7IlOcspRR43306XeEquyROQ==
X-Received: by 2002:a17:907:7286:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a7d3fffb6f5mr1155473266b.18.1722440085443;
        Wed, 31 Jul 2024 08:34:45 -0700 (PDT)
Received: from [192.168.1.68] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22bfdsm782913866b.34.2024.07.31.08.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 08:34:44 -0700 (PDT)
Message-ID: <abefa449-c0bc-4b58-89b8-d4272f7774f6@baylibre.com>
Date: Wed, 31 Jul 2024 17:34:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v7 0/6] Mediatek thermal sensor driver support
 for MT8186 and MT8188
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240603-mtk-thermal-mt818x-dtsi-v7-0-8c8e3c7a3643@baylibre.com>
 <171826604410.51825.14935271158174620262.b4-ty@collabora.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <171826604410.51825.14935271158174620262.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 10:07, AngeloGioacchino Del Regno wrote:
> On Mon, 03 Jun 2024 12:50:47 +0200, Julien Panis wrote:
>> This is a bunch of patches to support the MT8186 and MT8188 thermal
>> sensor configurations.
>>
>> Since the patches of v3 were applied except those related to the SoC
>> device trees, this series includes mainly patches for 'mt8186.dtsi'
>> and 'mt8188.dtsi'. Due to some thermal zone renaming in these 2 device
>> trees, the related definitions were also renamed in the dt-bindings and
>> in the driver.
>>
>> [...]
> Applied to v6.10-next/dts64, thanks!
>
> [3/6] arm64: dts: mediatek: mt8186: add lvts definitions
>        commit: 0c598e50e6c823c1057ddad17c546e368a415d6a
> [4/6] arm64: dts: mediatek: mt8186: add default thermal zones
>        commit: d7c1bde38bf37a59551cfd52cfdb5bd974b17431
> [5/6] arm64: dts: mediatek: mt8188: add lvts definitions
>        commit: 7e3e18f2ed40ea9018590b4533fa148954a725bc
> [6/6] arm64: dts: mediatek: mt8188: add default thermal zones
>        commit: 2f950510411a33d98eea28c22d7880eeb48adb61
>
> Cheers,
> Angelo
>

Hello Angelo,

About this series, the DT patches were initially applied, but removed
due to missing dt-bindings in linux-next[1].

But now the dt-bindings patches are applied in mainline[2].

Would it be possible to re-apply the dts patches please ?

[1] https://lore.kernel.org/all/ZnBn-vSj-ssrJFr2@sirena.org.uk/

[2] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
4262b8d782a7 ("dt-bindings: thermal: mediatek: Fix thermal zone definition for MT8186")
744ca11f52e5 ("dt-bindings: thermal: mediatek: Fix thermal zone definitions for MT8188")

Julien

