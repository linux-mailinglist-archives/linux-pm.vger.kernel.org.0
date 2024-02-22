Return-Path: <linux-pm+bounces-4225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E485F5AC
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4871C23D65
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58433F9E5;
	Thu, 22 Feb 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/Ki3FuM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64053F9C5
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597634; cv=none; b=e6o8yg8HO+UxEex4xf0JEeZJ8Cw0gzZv0U7/03ZuPI24e2LbEgsSN9g9XAR4GO3twcmOUp36C36qrA5C8/o4tv46ElIATp0zWGc3laogxr1//qEobw8DLpXiEFF+ftIPmPJBW1ZLwjek0ct6W7cRNK25YsUpdD+Fo6V7Mcc3/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597634; c=relaxed/simple;
	bh=AuqW1p0Dy4zpNfbaCup5tl6BSsuquCZ6fqdQhLH0cyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYjKvyIN+fLgOxM4Wq3ngeJonCfyGHj19HDDMcTxRnziqerPgZkIOTys5gLewRNs0T60ceN5BLj9K9RioOTW/918YvGNegArlsCFsCNuWoSBsggGZnqFOC76r24ilW6lgWlnFT/il/CzRaOgT3IOzndf+fSsRtqxkVcI/2S2e+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w/Ki3FuM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d6bd39470so781468f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 02:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708597631; x=1709202431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d925I0YAHDj2GZWLKYoS1jiCNk6oVmkUOHEhEtnAKiU=;
        b=w/Ki3FuMg/jZmgp7/r0B/daomaPDoXojmfhJ6B6Htgi1CHYvf9PrpvzrcvOuvOZxOo
         Af0CGmptWLfPm/JeUmqM29sQ+NJJi2RDZYlZ/+GjoMzF7U6OqR/SVt5ND/+ZHn80NWv0
         RHkeh5y/GdVUgzho0t+HfGCspN2+XrN+LUvZ7QPCI5TUsVECRu4BD6o92BD2DosUvnS9
         9kbt/XEyB2SMJSNxPOyqCGNSgMzo8V47w6x5ZvognLIVyz7v3jj/3yiUOy6pOuSlrDCu
         XW2Xv5jWHGG2nE8SenJY5fhs6APDd7rha1yJ50dFN4aQZ33UBmDK0vexQ1dpwFQ3jPDL
         2GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597631; x=1709202431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d925I0YAHDj2GZWLKYoS1jiCNk6oVmkUOHEhEtnAKiU=;
        b=OpyRm+tFmhEZxn5G7/Zql8tfAh1RE4L7m1OjQBSRxlUR5IHzokKApvpVM4b4A2JFpD
         MhbCe+9mAKZLKtrZdaUtbsEej2zrTje7b8nITEc848pc2NUfsPeaXE/Bm0u05XtlD+gn
         /zxXlmPGVR7SnAJ+J9JoH0OXprcOJQ8ADOD0XyCQSTU7CcA660xIZz+j+/LW4GS2yTMR
         6TShXxZp+jGcHEYMMwka9WknvLsFORD+dwcb7hsLFqPiiDK6DSEbe4PuiAkP4R/OCiov
         QoreSgn+zrt8cMMZ5mp1f80kfEMOt0n1osq9AI2Nph8kl+9JComZdPdLAmhHL6Y5eadz
         0mag==
X-Forwarded-Encrypted: i=1; AJvYcCWbKYdk+6tPySKTqdiniCdssQu5o2gUNh/HVdf5Rp1029zJL27CilVGsD7J1UCNffB2FoRiadW4mUxv1cq8T7Xn3EF4EE7Iv08=
X-Gm-Message-State: AOJu0YwUOA9fA5MhMl8ozgmICL5lAQdHopZkZqWPklyvEXKIct3z3zcF
	eq+Ofyc8ppwHaaccy/566AKXVIIwmKnml1lYNLVVzc7C2xpMqezPL54WjJDSHJ8=
X-Google-Smtp-Source: AGHT+IGuMDYCGGT6GDkqpL1mi1SjjFpTIg6mRvkJHWOw9iNdj4ceP+aZ6XGL6+dTOSdBtUA9rOkHUQ==
X-Received: by 2002:a5d:5487:0:b0:33d:3ee3:cc0a with SMTP id h7-20020a5d5487000000b0033d3ee3cc0amr7845937wrv.0.1708597631025;
        Thu, 22 Feb 2024 02:27:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bx9-20020a5d5b09000000b0033d202abf01sm5124036wrb.28.2024.02.22.02.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:27:10 -0800 (PST)
Message-ID: <79b872a5-4a46-47f8-9b13-010bccb5a80b@linaro.org>
Date: Thu, 22 Feb 2024 11:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] thermal: core: Store zone trips table in struct
 thermal_zone_device
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1883976.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current code expects thermal zone creators to pass a pointer to a
> writable trips table to thermal_zone_device_register_with_trips() and
> that trips table is then used by the thermal core going forward.
> 
> Consequently, the callers of thermal_zone_device_register_with_trips()
> are required to hold on to the trips table passed to it until the given
> thermal zone is unregistered, at which point the trips table can be
> freed, but at the same time they are not expected to access that table
> directly.  This is both error prone and confusing.
> 
> To address it, turn the trips table pointer in struct thermal_zone_device
> into a flex array (counted by its num_trips field), allocate it during
> thermal zone device allocation and copy the contents of the trips table
> supplied by the zone creator (which can be const now) into it, which
> will allow the callers of thermal_zone_device_register_with_trips() to
> drop their trip tables right after the zone registration.
> 
> This requires the imx thermal driver to be adjusted to store the new
> temperature in its internal trips table in imx_set_trip_temp(), because
> it will be separate from the core's trips table now and it has to be
> explicitly kept in sync with the latter.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


