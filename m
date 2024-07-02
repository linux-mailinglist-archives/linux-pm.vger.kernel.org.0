Return-Path: <linux-pm+bounces-10369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E839244FF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17772858E1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3E1BE23D;
	Tue,  2 Jul 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lmQHjknD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199C31B5814
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940620; cv=none; b=WbCIwfPs66D1HVeiB7NuIKNdutn+PJ0KJ74bhgBrnC0e4s97D/E+/Vje3cKjlGJL8yalOTOzJE0HOFsD70yWeL0VaEsXchwmhprJ455/wRdtQLYSPwiUai1j/kpwH7PZWAvoUOPg5ifpTNB+Az/fYt4kSrXQ0ZDO0CsQdyyg1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940620; c=relaxed/simple;
	bh=Qd+9FCBX5hfWZQ5KFpMTQfddQGI9s3Xv+vB2p6WPZBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP03tGsQcuv504+emjPmtD+eb7eWdhoYD//8a5zPQZwhDFIxcddcxstRG7cWyplDTAMPMxt65OSd6kE4NAKGC0m1Ocfb/VgceCpTwLMJi8HK0YVfwHbumeHU1H2WLvWS4bR8xuJ0p21oZ1EU96YD8j6KC3D1QEzSHvtxAjGjQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lmQHjknD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36743a79dceso3209630f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719940617; x=1720545417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMxjNF73xEehfmLmhKwg3pjkqI+cYmjdSdGZcjJzAQY=;
        b=lmQHjknDNO5eFESHHD0posluOABZKtvEgYhW8eMsTcRO1gN5niXJ9NdYCJ7fo7YIpL
         iHl2LGnJCxMdInO6NFko1VCAUDMskmg9mlicJkSg/vv50gtbI3jUF9AzBltt7G7Josw1
         XJHkY74SGNJQs/fGJvBf2LVXk04di1/+snlEwpf8imunxyuJ2uAtMH1ZU08KoTVq7oWe
         GNwi8P7akn9IcRa7mOLdJkSe8DsIPnF1bB+cVU/CNmJgp4BTmmCv+qqoTqO0zpmwpBAF
         PKsOHroS3eWwz9mVL0wIZxGYJjLqLDnGq/4DS9ccmb3edZjz70W+FmiYUV7FMW8BRQKj
         OaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940617; x=1720545417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMxjNF73xEehfmLmhKwg3pjkqI+cYmjdSdGZcjJzAQY=;
        b=a0fKmbIg5nPToOjl2jQTiA6xdM7g691CVeXqJrOy3DVsUfxq7OKnXg/b/Ul3EuD1zr
         WuTyKGt5qf0+/W6iKUZyw5f6bnkoqxInL2OgQCl5Cr6sdiW1VYIVkstx1hOlEsi49cE2
         gQ4O2xQ31kp9ChB60rHDD+J0rHACT+79wZcKmV0v9rLZmqeWOtBGZlAjuVcc0C2KJsVt
         OnVuZ+Rto1d4JZQ4Df32FEW7dOQjfyc8+EqgPvDpZk5c62IFicFQmXfyQu5tlzlch9Pi
         XhdOwH6km4QSm4LnS+P6V0OMpVLDuXM1i715btwS04vvOOY5QBnaOdz0OMhnFs42+SGH
         71aw==
X-Forwarded-Encrypted: i=1; AJvYcCWCBURTOoxSEF5Yl5Ux+iVX/i0DgQvMGpZKjjuw+TgltGWDmsChTrwIzE/6g4IcXxii1NgVjpEXRhuVo2IDLawqmWm8I2i3pVs=
X-Gm-Message-State: AOJu0YzZYuE3zHM51zZtfpZNB/rqxtizUOuxyts6VvMExmM1aYCklqHX
	1+pwfu5XudyKn6ge4NK4Cw1H+57mYDRZwT7ImbhVXGHXkto69QV+26A8gGlOrQg=
X-Google-Smtp-Source: AGHT+IHt/P0ua15wXj9zZu7YMLDV20uxy+PQFqpcA+vAHPimqKTS72Y/7YzGoy4cdhn7YTh0hbVksQ==
X-Received: by 2002:a5d:5983:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-36774f899ffmr9542381f8f.28.1719940617271;
        Tue, 02 Jul 2024 10:16:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-36789fd7a0esm2004822f8f.104.2024.07.02.10.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 10:16:56 -0700 (PDT)
Message-ID: <7a198549-df42-4fb1-97cd-116e1bd96903@linaro.org>
Date: Tue, 2 Jul 2024 19:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Provide default
 calibration data
To: Chen-Yu Tsai <wenst@chromium.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nicolas Pitre <npitre@baylibre.com>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Julien Panis <jpanis@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>,
 Frank Wunderlich <frank-w@public-files.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240620092306.2352606-1-wenst@chromium.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240620092306.2352606-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/06/2024 11:23, Chen-Yu Tsai wrote:
> On some pre-production hardware, the SoCs do not contain calibration
> data for the thermal sensors. The downstream drivers provide default
> values that sort of work, instead of having the thermal sensors not
> work at all.
> 
> Port the default values to the upstream driver. These values are from
> the ChromeOS kernels, which sadly do not cover the MT7988.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


