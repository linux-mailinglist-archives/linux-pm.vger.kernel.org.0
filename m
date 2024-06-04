Return-Path: <linux-pm+bounces-8582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365B8FB8DB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 18:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B0928264E
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F9148314;
	Tue,  4 Jun 2024 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khSw4mWj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FA33F6
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518397; cv=none; b=ekAWAZIgXno+3cQAPQTCHzxGJehxGc50FhR7o8zfaQUKljh+s7JCI4TDpkx7R+2P4Zu478Yym0LYVEQocp4sCWwktWt7Gvp59YtgO/HUaUgjQWc3HPPPA7egwQmXYSsPx8SBv99KweGjUC7lUmptNmjlc4/YOUs8Vx06udsxnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518397; c=relaxed/simple;
	bh=iQ2gF2aw3EqtVz6mXx/ihGp7xrtcrjNwJoL3Ih+kJYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GM03Oq3ep0xkWEGmfn7BKMyVGpXNf8aIOj6UVbdpsLjHf/rkmcJTzXyjRQi8P/1JoYz/VBF6Cx7IaUNyonsMDM+T5yQeApjg/D2au1UwaHay0vjFpY6+4dxz+Y4PVnbItjSd1UXjL3uLQpwzaxWJMh3sQfAAvFknRhIxrr72xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khSw4mWj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35e0f4e1821so3888154f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717518394; x=1718123194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yUCeKEvxZz0HcOYxIJIcV5v8P469mjR1k6zX1etfeFc=;
        b=khSw4mWjDBSa6XWHjGJRXbZx+V0WWgRLYRcVLBHg2HVjwwUO76gOvKh7yFtOZyQtDi
         etn8AH/PzNrCUkSplpYsgArXNe5EjzuLXv55dO3sImXpL8J2WFL6+bF07CchOxusy5OQ
         zV8BxjUDLYTpWLfgccVm6XIi5fdVhvxzp6otnExDCp/HoNpFYiui2e4AWIWAj3Nba6Zm
         /7e3CLZGoWXp4LWQUJUEpAZvBuQU1KtGTstDpnFg12kJMmFXRvFLZ/iDJaxGBOcoHIX4
         DyCZRScZ/oNJSJUll7+H1pbcfTwaKmzsBfq4H6iwMS0RsDFTzVPc6Y6UYgdWgT44Gnih
         hDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518394; x=1718123194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCeKEvxZz0HcOYxIJIcV5v8P469mjR1k6zX1etfeFc=;
        b=nALoN4xtyvuydnOW3++urgXVo3DT12eEghLx5Q2ztn3Hpl9fQ0fTJCSj+ih1wp/b54
         cv8iqTaR646qS91+GHEXsAtA+aa/ys6JL8y/p1t+Az2nG+Sz0HqxGkaO/67cVFY+aiQ7
         bsyyYizWiI5v8MDIK27Lj4Er5LvGQwgjHmtdauXWWi5X5VXuI1WeJNEgMK32JRtCj7pT
         x5c9My9SGRTCrp1HO+TFqrKgk1Rv52RqaQMaVKGnRmEMVP8L/iz8hpFl5fG2BrBM5AOY
         v9MkYnaILAvFRB7B47ywoEIcmWt+By3v1Ohbcj3Vmxin4+34g0sNj6a9dlv2JgUnsatS
         mNgg==
X-Gm-Message-State: AOJu0YyCZnEWC+N5S8C9MJgCqZiz05W40TuIiJmG3cApPfrkffYpzFql
	gIIJSRbMRuC9WOEMUVjj5cwm96Gn05cGGrbv4f+jhK+mHi7z8y7mDTteqyuBTCc=
X-Google-Smtp-Source: AGHT+IGK57QEvZAxhgQzPqjoqwkElo9aa4K3ynD1xAtn0P8/VrG1nhjr5im/3WDHATMN2L5PdEq7og==
X-Received: by 2002:a05:6000:b90:b0:359:b737:51e4 with SMTP id ffacd0b85a97d-35e0f2599f2mr11664148f8f.2.1717518394363;
        Tue, 04 Jun 2024 09:26:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e559:5ee:5c4:82bc? ([2a05:6e02:1041:c10:e559:5ee:5c4:82bc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd064dfd1sm12164509f8f.108.2024.06.04.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 09:26:34 -0700 (PDT)
Message-ID: <246f3565-8d54-4569-a9b0-164b653b3f81@linaro.org>
Date: Tue, 4 Jun 2024 18:26:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/06/2024 14:06, Julien Panis wrote:
> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


