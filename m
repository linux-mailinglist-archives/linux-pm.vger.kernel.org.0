Return-Path: <linux-pm+bounces-7487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A178BB1C3
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 19:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0228288947
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD31581FA;
	Fri,  3 May 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EL5/FoHh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A6157E99
	for <linux-pm@vger.kernel.org>; Fri,  3 May 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756998; cv=none; b=uUEBGw5FpnZs2OXjOz2z5KRtSiOYw42cwT0IU58vTkNd8Qw5i5y+j8zLdxfKUzhuarGIkqnfRB1fE/W4Lc3cX2fPSu2owvfO3yv8gjkInLUgjhdfVZFUxDxYWM14Egh88niBqJKyu+2yHQ9UbI86SyPbpMr6JvC9IaCIN8nwfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756998; c=relaxed/simple;
	bh=BKIB1SmHgO50yZ8teXLHsBvGp/yjJo0D/FQDuulfMCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvrvbLvTsEeG2q31GWVrMp4mrAKR5p0Vu5a/l+NkfwvOMG7XlGAD0lWL/ZL5qKzAfPU/eFTC2yuFqAPvYRmLWFethCxpXKVTFtAwRz2/oAfk8hGm6a54PXrMNijbdhu2o8iuYvdLz6q0gs7vV6iN7YeSdKS1Q8Hl6nn07+MEMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EL5/FoHh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b79451128so56009295e9.0
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714756995; x=1715361795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3CD5UXCVdUAuu9Git8MNtIns8eazGXSqXwABAZaYsE=;
        b=EL5/FoHhOn2fScAuH4OcptPkqSKEUXTZyjhLgj8CKjarAT8Pjjjn4r3RejjCGzPU7V
         Kew6Q3iE/bIEl3sAnkjq6+FplVxZDRKJaoyltBMjJlceljl+p/R9kn6u+CIudh4J/dnn
         bOXRh653zSD0at9R7lQm6qJbpYEPlsvaoMZND9Q/kp/zLcYXaRzx3IntQ2BQbzFvbeno
         M01R5MyngX2WiJiP1Uak/8Zw1RTGgU1cSVCAsQiP6fxDl6x9RUN6BsXRcpcnCHM8ijVu
         NY4IoSG8rtI2x1PqaYR77boDXTFN3IMwcGJW7wXj0Qa/Q85BcxEkMvBHMs4dolC1mfyA
         7ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756995; x=1715361795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3CD5UXCVdUAuu9Git8MNtIns8eazGXSqXwABAZaYsE=;
        b=INgaFBApK5cWgLcU89ac3eLF0J2wHmWj3ou033VfOtlYGz7VlrtIFwGX8sruuTpRNO
         0Incuc2ToLIFAKQX6pieUjYLd/TSC5iJY+zLELVy7pOwfydqDcvDN97HLKv/WOV/6yX6
         MyntojrcQ8y2+s+T8kQ+2gfJwqB+TrmRPqzW/9C7Ug/SVj1/Q1C5sJdhs/uQRCY0fZMs
         7zbMx21QBgglW6jORHVK5FgZgJlz/Hf6oaxMXO7iiDmVLO4BL7RowDcFZF2VSkOMHYZQ
         f55Nm61aU4WbGq5cekcwi2fmw8Xsvuhp8ZB/RIuDNaN3N0MTuqG4Z5C0QuFLfOX6FLwq
         rwXw==
X-Gm-Message-State: AOJu0YyDHNmU/08GBK8/C+wqyQwDBrpEUoAehlIqCZgQtbCN/ELMSsTX
	+YA0LIgqYKnSkWmr/R4kvNfF6+4r+TeFgFI9NG+P+bI0ryP2lbYwGLGgZGuttnU=
X-Google-Smtp-Source: AGHT+IFEowCuCwylixROUmg388nE+53RnlyVy2ckn+NBiq4MgMTwgGq1VkW2j1XllliZ4Dtr1Mh5dA==
X-Received: by 2002:adf:e586:0:b0:34d:2343:b881 with SMTP id l6-20020adfe586000000b0034d2343b881mr2771056wrm.43.1714756994641;
        Fri, 03 May 2024 10:23:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p13-20020a5d638d000000b0034de69bb4bcsm4181590wru.85.2024.05.03.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 10:23:14 -0700 (PDT)
Message-ID: <6f9dc240-277a-4222-a175-18c959269353@linaro.org>
Date: Fri, 3 May 2024 19:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Mediatek lvts_thermal driver: Fix wrong lvts_ctrl
 index
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/05/2024 17:35, Julien Panis wrote:
> PATCH 1/2 is a minor change: it just removes 2 unused members from
> 'struct lvts_ctrl_data'.
> 
> PATCH 2/2 is a major bug fix: it fixes a situation where a wrong
> array index is used as 'struct lvts_ctrl_data' type item.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


