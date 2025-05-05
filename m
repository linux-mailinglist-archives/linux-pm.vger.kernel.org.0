Return-Path: <linux-pm+bounces-26633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B5AA8BB6
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 07:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C272E16EEBA
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 05:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85D1ACEAC;
	Mon,  5 May 2025 05:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="usXHinRh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06B13AA53
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423350; cv=none; b=lqAPSEJOrZgfZqgTovg8fUnJySK1qmxd9RSmSdLbc3+vJn4beZNxVaPMLI1KGUqyPEYJ8HtwTabQ9rpSeWolODh4rvfbl6YYiGJJti77MdI7qjCPXIVxgbHWXKD7WhS33kYEc+l3E2rzNpkWt9cdIIDZYHy1DB1I3UIWFBpF6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423350; c=relaxed/simple;
	bh=TrFyW56Y2m5djMks9z2jgPyhCwUwerbPC9JwCgkCr38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1xt3BKHMLV0fPFdToZ/VJLe17s0k2STTmWCJh9jtdQX4isziJ9GBsFNyOH9KCCxqxAMrPps9az5c+R/La4YOH8MIeesFywtoFx6EdBWK8RYO1FcqrjYDQsS9pGHyRC2EBo9CEuH1XH4CQRnVeN5qZPkmeajZ0nEiQmZgJD7E4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=usXHinRh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so3814672f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 04 May 2025 22:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746423346; x=1747028146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtiRpeVXxR9eCvOOBV922sOn/8w2n9LL1EWjuBecP8U=;
        b=usXHinRh1rfgRaTqRd44up2xKkM3JgSi2Q0T03gm8Td5N2pq+Y/zFfVUUGLqW7Eu7L
         xPEpvgVOzd0L8v8a4e0AHPOm0jLS7uW+UWt57GNZaREnq6dubmvlCG4CUTl8+XoR80my
         DUeY+5lBYbe1WCj3fOZm0OcMmowo+J4iASiR30Au9gG25pAeC8N1S89nO99ecicHFrZp
         YMEs12BeULXs6igIWyhUsFWHJv11g08Emcn+F3Z1E2lwsWWqrrSb0jUghu9Eb6PODxSk
         rtxap9Vfg+rATJenhchqBoUvSUMcFY3Rl9I2eIOUsFSegXg/kOFswJqhiRbKCXCQpQzi
         XG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746423346; x=1747028146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtiRpeVXxR9eCvOOBV922sOn/8w2n9LL1EWjuBecP8U=;
        b=gVLN2V3vGdkwZ1xLCOFHLRe7/z7zhQPq896Cr5OXBN4a0HNJ3a2m130EdKsdGjcQet
         ErYQ4YT+C9wzsGiAd97prtlHK0MPgt646nBrPSKyBohRDtmNsmO8pi2AUQVBEwsLLJSv
         tTm0+8riybfmLprFMkVsbrKyMJcMFBS8bxFOSmxIeM/ugjtWYtl7gZga3jxnyT0J316E
         w/0lzq2M7Xzj8mtBprnNzcbgoh18uZOnqU4lYwf5UeGukBQTpQVLSUKAdsAXDk+XHLPs
         k+iuLrTVIYg14X0u7viTorLQd0rGvkePFosWuLkPDS5mPCpnXO4LRStBYRGdhImsY73o
         +03A==
X-Forwarded-Encrypted: i=1; AJvYcCUs5rc5VyxZJvDL1VBoJ/bwp+DiDFjeGo4wV8zcNvsQY7tjB8sRyRhXiC7JKNFi69ZfvuWWt5/irA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6uXN0k6UwuR4H32h2veylD1zvnzdP7B2bFPJqPo7C4FK6ozC
	lwk78MphTOPo9e8s0gUfDaWz9xFmxImJlHWq3lB5MPtLIorDe/s49HaEEpuBIN3CbERtk0xrJLW
	Z
X-Gm-Gg: ASbGncv580R67hs+bjFtd4JVCylKEe2jYUyww1YIRQeKIIqYNVrfxxmk7V62TuZApEW
	+s+IyAtLIWrJYoYYDvhDTzJV+MuUqfVi0LPgNHwrNWiUKEUr+Lq0BlMwxueElpMY0os3LbC6c1C
	QybQZNncxFnXgO6qRsqa0bFdOdf1n253ZSZon3ljXkHkWlr6uJ2b4JtGuULt5asA0led+nC0l1w
	rt6zJQpptFEVqBLS2MfOt6TifOatbzjv4vdchSUUmdSHVkmXNCqQvGkpexyMhZvJ03RO5SkeL8l
	oVDdFmsJQbDO9RBKXaAZ4ztxKGj18G2tFvqCbuVdfNGeUQ19QAeuQD/48420g58kJRucqvubZqP
	pQnz+
X-Google-Smtp-Source: AGHT+IF9Cgs7u7g3N65e59enpUAXh9IV5tRS5n72PCqZAt3FK4OAibdOBXfsQEdn8nqmP06W58BwVw==
X-Received: by 2002:a05:6000:4285:b0:39c:16a0:fef4 with SMTP id ffacd0b85a97d-3a09fd770a6mr3798232f8f.24.1746423345714;
        Sun, 04 May 2025 22:35:45 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b172a8sm9361125f8f.91.2025.05.04.22.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 22:35:45 -0700 (PDT)
Message-ID: <c3a3ab95-0129-4cae-9494-817d7e2b49be@linaro.org>
Date: Mon, 5 May 2025 07:35:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts: remove unused
 lvts_debugfs_exit
To: Arnd Bergmann <arnd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Julien Panis <jpanis@baylibre.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>, Colin Ian King
 <colin.i.king@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250505052502.1812867-1-arnd@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250505052502.1812867-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/05/2025 07:24, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When debugfs is disabled, the function has no reference any more:
> 
> drivers/thermal/mediatek/lvts_thermal.c:266:13: error: 'lvts_debugfs_exit' defined but not used [-Werror=unused-function]
>    266 | static void lvts_debugfs_exit(struct lvts_domain *lvts_td) { }
>        |             ^~~~~~~~~~~~~~~~~
> 
> Fixes: ef280c17a840 ("thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

