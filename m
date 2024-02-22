Return-Path: <linux-pm+bounces-4239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1185F678
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 12:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590711F27E99
	for <lists+linux-pm@lfdr.de>; Thu, 22 Feb 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6C3FB31;
	Thu, 22 Feb 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poKh/tGv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356083FB17
	for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599978; cv=none; b=r3pDDljR8YcQ8Ff6OHN4jzWuTE4Fv5/d++hH/BNy80CkBRzQQ9Iagp3J++fZTz6Zwq9gIt8Ix3F02NcL5rODOGUQDdWxqP1CypmCeaEY+YjIinQa4JyMLMLVxRv3J3PfqPyg8nA1kIkW7jmPPpNuiny8yqoNIe4cyX5ackRAPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599978; c=relaxed/simple;
	bh=eUO2pULCAOjDoFdOGE3rfjqQB4Mduld03rcv2+usukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzsG/sVIWgf4ko0WS4Dy1+wluZcldXsoSULEkEFkXvOCCxxnbkUE1u2HZbUgIbUnsmzmaaau/ipY7dDgQuDlM4ztWoTpbmxySF+6Za5kaml1FtR4homAI1cJ0vteEeQnPsGB3/KPNi+8PSCaAkgzFlcKJViDtDIhHGGAFARr8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=poKh/tGv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so24298391fa.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Feb 2024 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599974; x=1709204774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=poKh/tGvzzPbXLXnVfTfwH+Z/8KfF3n9tNdhaKqE0Yc/3ffMfGrBhakNh9ujnrWHgV
         3cfsThy0YIWiPvdjOS/jB8t2ITESXQIVGoGW7hTrjXyFLtxQE0Wf+qY7oxUxDCoOqxRi
         Gss0QbYe+3uEOvs4uQ4+CkGFHKF7jxth9BNSWCMPb7VsFOoazLrKIXg/65K3yFl6+Hvg
         1rtb/iOIT2EmlKRF/Ies+61J1MgUreuwi9hG+3rRGEIYuUslR+1ldlwkuvG0M2vSip6b
         z/g38Hu+x30h1EL+wOqZcg64/r4ar6GZsqcyHA9/EwcPzuvnpvxiSpJ6vvpmCb9gbY8c
         4f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599974; x=1709204774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=djpIdnLHxnzVIFH/w+Uwlv5069zYtIwPbR46F/Ndwk2wLiHppfxEtbe+Y3FVPA41e3
         L+ETeKzRIi0XP8btvIygfOm+j7OrijELPc3HGv9wriuLOr/3RMOi2aP/yOCxo+l8tjWz
         OBz7QI+FO16AmagwvRFPfwmexw+BR6xriBYm6VvlxrQpYYLP/SfgMoArBQcxqxw/H3P9
         7oNHdAIK73OI0EWniijctuTq0ohJqHFJaqUX3V8DJKDCMUaVSC6Qq1ypJf0EAl0j6Iuo
         VrQi1G1II/tVFIYgPgsLbyQPBM3xDoeSBhiCo/aIb3gQ9Qj1XwN2wJEEbMFdiIbkYVbh
         jeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpDMRi0Zz++ZP/MsJeBurSUS9ZTJSZ2Uwb9V8zt0qct30PolBnTIfyXDVvZNtlp3PwLnZkvHiaeLrCqsrzB3kfeJaOmU/gDX4=
X-Gm-Message-State: AOJu0YwToRjJiiJYl3bo84lfKOUUr60MKE3rQr3KHRKofTMKvUSJ3GDp
	HszSM9F77d1stv3Ysywij1MiwVCsseKqVtOTjzWuk+i+wLH1ERwKAsAqGf3F2GM=
X-Google-Smtp-Source: AGHT+IHiLSfsaDdgn2k5rjMUiJNduHZR3YSa1xmVy7cLP8thmp4ILrPRdvUpIp7j6hHay03gDR5OLg==
X-Received: by 2002:a2e:92ce:0:b0:2d0:b27e:2437 with SMTP id k14-20020a2e92ce000000b002d0b27e2437mr13380930ljh.39.1708599974326;
        Thu, 22 Feb 2024 03:06:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm19978761wro.11.2024.02.22.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:06:13 -0800 (PST)
Message-ID: <4dc3ee0d-ca11-4574-a47d-8d9aed83e31c@linaro.org>
Date: Thu, 22 Feb 2024 12:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] thermal: intel: Adjust ops handling during thermal
 zone registration
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
References: <4551531.LvFx2qVVIh@kreacher> <3213551.5fSG56mABF@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3213551.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, thermal zone creators can discard the operations
> structure after the zone registration is complete, or it can be made
> read-only.
> 
> Accordingly, make int340x_thermal_zone_add() use a local variable to
> represent thermal zone operations, so it is freed automatically upon the
> function exit, and make the other Intel thermal drivers use const zone
> operations structures.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


