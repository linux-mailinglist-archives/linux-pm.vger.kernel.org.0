Return-Path: <linux-pm+bounces-17547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44159C84AD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE53283618
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1531F6668;
	Thu, 14 Nov 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zI13vuEY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCD1F5846
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572033; cv=none; b=MyHukFRBY0FXRfs5+t4f9zIXN73urK8c0FapUb5m0wUPkbBgBoIIpEb+u2hvYlR8S23EGsXRW1zBhrvaZgL5rBV5ZsbS+9lXGHNhZ8AcEyeTr4bvRXQRw9ELngFLO5YD3/pK5xvyG53qzgL/oQ4flCpNJ7EbShWLShP2V1FtpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572033; c=relaxed/simple;
	bh=MadLihmtT+/tw3ljmGzSM/wiUVn3wKnphVnIrCjKz8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bICRqzEwFNfIWsk8Dqjml3ewawBaow1UnLud+ZYht3AELsHUIiUXZsDXG7AGfMsSCeEqAuAOa80YPalK66JcliBMmcDPDIk1Nf3mZMYKx+2Yhm2HcFzF9zoSI5QvugeV3gcXf/vwK3l2JIE/RkHgZGyx5hb5/BfpZpsfwKOg9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zI13vuEY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d51055097so218911f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 00:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731572030; x=1732176830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbnV33FhcFC7/cGoyMMFFLq5a4Zv2Ee9N0Kjjcgq5eo=;
        b=zI13vuEYkW5Y0duUTfRzY7FrhGcRF9edmis2m+qXYF10nQIuHpNkOT0vEYkXZm6yiF
         OXX09vdwo7oDo7p7OYjPI8DRRBSGS4oq9MqVkNUOlDjTZQ63AozTS+ssQWH2KzO8SGLI
         Y6u7/x3d94CwzqeioH0HiRf97BHpeVA4+7rrSFYVXE9O674yLiUJcjCw6nJsjDEzrKug
         de3bOYuqa0Tbm+wmNJDk159F9uPWMhNSGGClyb+WRRndpmXa3Qm5gw3A4FVJf9mcpUUA
         OFBFTs6H4xXRUmGU5/8EFkOOmaN2pDvIiDm+8+0TZzWhF1HlAO5iz/w+mI4C8WIxYwUl
         RkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731572030; x=1732176830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbnV33FhcFC7/cGoyMMFFLq5a4Zv2Ee9N0Kjjcgq5eo=;
        b=vgydjUynAmSBtdvlSESPc0/Idv7GnNhTAlG6HDQRxjqhO8rcFNHOGNECXLrjXdNLlE
         tYov9SRSgdeX/q99WAG+Mg4FHJydLxsfuRctRCj/C6Ufh7T4OSMQ5KVICmfK7ikj7vEQ
         EaJmqKlnenWys/GAse1tSU8oZbWs2WT3giy0lkF3ODEOOrY89e04tmn/gt/B2vkLXWgv
         LAX4MS9DlgiAajIh5GCdI2khHABE1msDBgss/uswwspsJ2CFsXMYjIU8F/NeURXnH/yb
         ref3ndhULuql25UPABxAnyy97N0s3zCgoB7ClIJFZUT6/JWATQ2jE7Ln9pju/iHLGcTi
         XhmA==
X-Gm-Message-State: AOJu0Yxf0kz6+T6kGEcXL68kt6CBXmOcRnR/oi2YeEpB6vibyO0Ppf+y
	nqED1lFYuAV7AZ29+unbq4Pq111wViHOZk244EnWx22PJivR4P+8E1seaNfSb5g=
X-Google-Smtp-Source: AGHT+IFFoxrNuaonAlRHjVX4wkH6xAAN6jsZ9Y/Av/d6Vo1BPZjRFjen1gyTOIm6baYSxW8QIjmFGQ==
X-Received: by 2002:a5d:5f46:0:b0:382:d79:842c with SMTP id ffacd0b85a97d-38218502c87mr829097f8f.13.1731572030308;
        Thu, 14 Nov 2024 00:13:50 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3821ada3e7bsm788452f8f.7.2024.11.14.00.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 00:13:49 -0800 (PST)
Message-ID: <02bbfb8c-817c-447a-92b9-bd03d76b66b1@linaro.org>
Date: Thu, 14 Nov 2024 09:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Switch to
 IMMEDIATE_MODE
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241108-lvts-v1-1-eee339c6ca20@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/11/2024 07:46, Hsin-Te Yuan wrote:
> Currently, MT8192 cannot suspend with FILTERED_MODE. Switch to
> IMMEDIATE_MODE will fix this.

Given the comments and the different changes related to the filtered and 
immediate modes, I won't apply the patch until this is clearly sorted out.

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1997e91bb3be94a3059db619238aa5787edc7675..daad52f14fc03d0c4131f2ffdf3eb6b49a4a43d0 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1541,7 +1541,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 0, 0),
>   		.offset = 0x0,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1552,7 +1551,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 0, 0),
>   		.offset = 0x100,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	},
>   	{
>   		.lvts_sensor = {
> @@ -1567,7 +1565,6 @@ static const struct lvts_ctrl_data mt8192_lvts_mcu_data_ctrl[] = {
>   		},
>   		VALID_SENSOR_MAP(1, 1, 1, 1),
>   		.offset = 0x200,
> -		.mode = LVTS_MSR_FILTERED_MODE,
>   	}
>   };
>   
> 
> ---
> base-commit: 906bd684e4b1e517dd424a354744c5b0aebef8af
> change-id: 20241108-lvts-f7beb36efc59
> 
> Best regards,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

