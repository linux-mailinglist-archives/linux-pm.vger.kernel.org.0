Return-Path: <linux-pm+bounces-8138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D958CFB18
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 10:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440041C20C52
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 08:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B044C9B;
	Mon, 27 May 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kSPol2IA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F193CF73
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797690; cv=none; b=Kt+LTkjOrYKWL7cCZYbDNMM5GuGqfjEorbX8Qt3csCz7bAD8E3oYiSv0dKmfSf8kTgvHJpuqu3GVHgC3Nekf07tfFNVsHJfuPoYcZhe+G2PsqPzas/4jzw6qmqTq1LAErffnoV5w7aDTiO2oAJMduSLaDZD+Yj5Z/ZE5VXmUOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797690; c=relaxed/simple;
	bh=lsx7EwUwBi3NvHqO1utE290g0jz7B/NyZB8DGC2Ks9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZ+x4sQr5Wf3hXPDsP6oZ2I/oFl5jz0DrIiIztXltRraZhDoypDde5WcEYeMdiHlKZG+gwEt4t+iD18xWhPhidN4hDF/ksJCe/FFvmE/ZQp3mff3EdVaRstVIVQgSNMZc/99xzjGnYukhVM9GD27iNnfKvVWHPpKxYbiwCHP2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kSPol2IA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e968e77515so22099861fa.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 01:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716797685; x=1717402485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9TONvTEWThGczkgWTi4O6+TwYpFpcfs3Yxs9Jjw9zo=;
        b=kSPol2IA2xiMjgdGFJhhfMWXFP/aXTGwmOwGXnjbVObp2W5nj48gH9f2ejpCb29crH
         zEEkQoc3E4tdkbeQVIyJcsE75ZZkSwz3mdW7N4Ez48hBnBxm9ExAcGUtPNT+1Gq1ktEw
         S0qRofu48vzmkt3utEjyMXjdmQMhsLWjfi/akKenyyGWMH+pe+belC60EpRcR+Uq0Z6m
         HSIIQ6sFs90QPhuMF1AcT/myDDBowxZ8EvP9z6u4pTRXuSdMjJoDYmYPW+rGspShd8ql
         MjePuEGAFPJPXVwCB+zvq6k48hg2SCw1k97UEx6JPjm2llQ+xPmZgxuuSC6sbzx7w80P
         E44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797685; x=1717402485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9TONvTEWThGczkgWTi4O6+TwYpFpcfs3Yxs9Jjw9zo=;
        b=YmuCIY7nW1d8iOK/e/BXnPE7B/wtgTO2ERRZxPZzCDLt19A9J1MspOjDisPox1QY6m
         WkwrqT1qHzDrv2FsqAv6kvv6Ai7jdy7hgwAqR4L5A3oLNfJWy/5krrnwfFQF6/l18h3d
         QvQnr9A5xvykv7RjJuARUTLSVvFjaEHf8YuSBUBHsomg4uvucFnESeg298W6C34ExEVc
         OkP3jtMlo28fpQOExWwbzXJHGFgb0+Bww5DcS2BlMHGRwrrTRSb1KmIdzn5jarBfeuDE
         AERg3OXEpBnrJoh+ljIzkHZfTi5r00te7qIC7Bf1/qfz3D37vc72ireSlnlE3qCTjlfn
         P4IA==
X-Forwarded-Encrypted: i=1; AJvYcCWtyAGv0AMR14+1fpv2cM+6UIiCs99FDshmqoXWjw+p9Y92u/Zk7mxlFGio8Tg5ZbVTXc8JrDFV3Nih/xf+0YbeWJaCn69jk7Q=
X-Gm-Message-State: AOJu0YyHXh6QgN8WToStKvpwxqBvguILjV9SjVELBsLMEEmAaq5drLTY
	LwMSLxkqZscqsW4b7Dx7pijE7bZef+kEfbSCiElS0/LcWtM+dqpKhaKYoiEWI5o=
X-Google-Smtp-Source: AGHT+IE5hwvA+dnXZp0Ce0d7BlZoXZS8BtrFd0HTMRigsC5U6EqzAEtorNHmX+hus94f/jH5p+ygFg==
X-Received: by 2002:a2e:9819:0:b0:2e9:6d3e:e91f with SMTP id 38308e7fff4ca-2e96d3ee9b2mr28178891fa.52.1716797685169;
        Mon, 27 May 2024 01:14:45 -0700 (PDT)
Received: from [192.168.27.173] ([77.205.21.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896fc8asm100562585e9.13.2024.05.27.01.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:14:44 -0700 (PDT)
Message-ID: <bb07e774-ba80-4fc5-a57e-ad5ef6360c32@baylibre.com>
Date: Mon, 27 May 2024 10:14:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Nicolas Pitre <npitre@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
 <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com>
 <20240524-concerned-fritter-262f5e16293e@spud>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240524-concerned-fritter-262f5e16293e@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 20:24, Conor Dooley wrote:
> On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
>> Use thermal zone names that make more sense.
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> Removing the defines is an ABI break. If these are all the same devices,
> but with more accurate naming, then keep the old defines and add new
> ones. However, the GPU1 define changes in the course of this patch which
> is more problematic.
>
> Why do these names even make more sense? Where did the old names come
> from and where do the new?
>
> Thanks,
> Conor.

Thanks for your comment.

For mt8188, the old name 'soc' came from a document by MTK, which is not
public: MT8188G Functional Specification. This document does not explain
what 'soc' are/do exactly, it just says that some temperature sensors are
located on them.

Then, there was a comment about these 'soc' names:
https://lore.kernel.org/all/ff12e104-da8b-4800-bfbe-a006ffe1b840@collabora.com/

So, I had a discussion with MTK to understand what these 'soc1/2/3'
are/do. The new names comes from this discussion and were given by MTK.

For the other SoC of this series (mt8186), the same kind of document exists
(MT8186G Functional Specification) and explains what 'soc' are/do exactly:
('cam', 'dsp', 'nna'...which are used in 'mt8186.dtsi').
Using the same logic in 'mt8188.dtsi' would be more consistent. Besides,
these names are more explicit.

Julien

>
>> ---
>>   include/dt-bindings/thermal/mediatek,lvts-thermal.h | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> index bf95309d2525..ddc7302a510a 100644
>> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>> @@ -24,7 +24,7 @@
>>   #define MT8186_BIG_CPU1	5
>>   #define MT8186_NNA		6
>>   #define MT8186_ADSP		7
>> -#define MT8186_MFG		8
>> +#define MT8186_GPU		8
>>   
>>   #define MT8188_MCU_LITTLE_CPU0	0
>>   #define MT8188_MCU_LITTLE_CPU1	1
>> @@ -34,11 +34,11 @@
>>   #define MT8188_MCU_BIG_CPU1	5
>>   
>>   #define MT8188_AP_APU		0
>> -#define MT8188_AP_GPU1		1
>> -#define MT8188_AP_GPU2		2
>> -#define MT8188_AP_SOC1		3
>> -#define MT8188_AP_SOC2		4
>> -#define MT8188_AP_SOC3		5
>> +#define MT8188_AP_GPU0		1
>> +#define MT8188_AP_GPU1		2
>> +#define MT8188_AP_ADSP		3
>> +#define MT8188_AP_VDO		4
>> +#define MT8188_AP_INFRA		5
>>   #define MT8188_AP_CAM1		6
>>   #define MT8188_AP_CAM2		7
>>   
>>
>> -- 
>> 2.37.3
>>


