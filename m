Return-Path: <linux-pm+bounces-8598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56B8FBADA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 19:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EF01F22359
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9014B07C;
	Tue,  4 Jun 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS8LbfmJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F114A08E
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523108; cv=none; b=XWjviMo1Mnc9mFkuTHax3Qdc3vUqiVzpSvVpRh3N7yYnzcywXX33QCZesyPdbc7nNBUcYvCGrJCmUJ94PmsklCaoinU1QPQEUBCPliztLr1YHi7zsL4+ayDtvrIjo8WWrPUGhgFsGHl226S4kIS6hX4sDXjR06jaK1DsXKocAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523108; c=relaxed/simple;
	bh=vc8ZT2GNbFtwqQqhzl5qiHaSZfj03wCMJ+C1x7kZANQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo1QxGnb4DyMbF2rKUAWNKULfs6JlSA0wsmOns/yTzSnyfP7m946zcTvez+4CVAJUa104ZON8FtLNWkaj0rauUD2JtXb7tDIhUupZ+6CyK6ogruZjnKcaAK5Rege2JwrqcYgT5eefe6ROIq/tbRyVFPfln4zDqLPqDBJMOuRUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mS8LbfmJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso16605521fa.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717523104; x=1718127904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ytq0Oo7HEBwVwlcYfKpnL3CTax18r1U5YqO94Iax+L0=;
        b=mS8LbfmJ9svRhOEW7ohc1aatikfScIxPbt2B53PdCru39VaU1Fof1OJyHocNQnfFf5
         hma0AUaD+k75O+IJa7C6JWE1I2dOtIrukQ9uhs5s3AfFDYFqEImE255XnjbEVqtFxAuT
         3gBE9IoEe/xf8SISfykjgrRl1v2bc45pdnxAsEb7h2B30DpqN705FzKKOd7JtAhMwjIu
         7cqS6l1Kop5zlZqhvbcOB06H5++r8exWrdsKlmjmtJcuYo2lScRuNP0RReSsLTKZSvGM
         vKsLrraY5e4KoI/L3Vc7QN8N1xtpQLhycDHCffKUetBPm5tKL8YVi6j7WASiJ17Rp1Bc
         yjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717523104; x=1718127904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytq0Oo7HEBwVwlcYfKpnL3CTax18r1U5YqO94Iax+L0=;
        b=sCXIUWRKJ2v70oa50Q7twmMLeDW78GArjuJk5J7YxDMXviCeCXIh698HMX6QO6CPUS
         xVSdWZRWArPhsOf2hYKOQKwUEt9NuK29gbYbSTK91m5sQwbkguS1AAE/SXf+tEeX+KCW
         T8M/ul0glOB2xPcTzrEnZ/qeTZNLHaGqAIPq6+Qxddzm5/80Ch2OCu2zaNiPwbnSSIYI
         Di0befikQjA3/jhZ1hErCtYHJ5IXmPS1GBsKWX7/93S+Yx2pe7iGng48baPqnBLMCEjX
         0WXQl5SzsLCPjPiz3ZsQOXdk0fuvNBhnKXBGyvh7cgENUA+IBXdKYO6IWBQG3N3Esv34
         HtRA==
X-Gm-Message-State: AOJu0YwMqnAeZp82FP5lC3v4nzKcqyLTf0KdSskpybxGkMlqHHlC1bZF
	NQMdPQnf7GfEaXDYc/NSWoCF/S8AgkET/YIZul88iGYWK39l3YfTqcZayRLpTAAjzDB/sNa6RLu
	ZR6I=
X-Google-Smtp-Source: AGHT+IEEU4GODvXNmuOAaDu40512E0+kzwzk/nx1qRfocHGkyEprhLia63Wonh+Hi1Lwq+VCgrVf2Q==
X-Received: by 2002:a2e:8e7c:0:b0:2e9:841a:814d with SMTP id 38308e7fff4ca-2ea950e9c37mr81938541fa.21.1717523104333;
        Tue, 04 Jun 2024 10:45:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e559:5ee:5c4:82bc? ([2a05:6e02:1041:c10:e559:5ee:5c4:82bc])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4214a4aab93sm21423665e9.0.2024.06.04.10.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:45:03 -0700 (PDT)
Message-ID: <145ba1e5-628c-4e07-bae7-039d1655885d@linaro.org>
Date: Tue, 4 Jun 2024 19:45:03 +0200
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
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/06/2024 18:46, Julien Panis wrote:
> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
> ---

Applied for v6.10-rc3

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


