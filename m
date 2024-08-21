Return-Path: <linux-pm+bounces-12615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C69598E1
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5801F21BAE
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977D21F3775;
	Wed, 21 Aug 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/MFktln"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FB51F3760
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232759; cv=none; b=naugoiBxx8bNHx7Fg+zNfEpNB7AfgyC5GLAMpbLJsbZJzRD+hu3KASRCLM0R1Jeasu93PE9+dVrDi4ktTrmSj0v8v1h/pghchsiJ9ZnWZmwuRgAHzSmfNHIkgnjLBdoe81o4bwbD79Hi7Ci1bWvLbvVuEwJw7srlofjorhCKXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232759; c=relaxed/simple;
	bh=m4FbkAx7v5EUwGK5Pg47fSnJDHHw9WPN5bt92a1OXbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQqrCDd5G2j5yl5sp8XGn8zs9C1kZqGIhezjlPD0PZB71dR7DxATgQmjHmYJu1wXehi1sO78I5S4210Woad/gdyd72iqW0AFCd+iptYNdER4vdpgmp/RDUOTsqlnFXq/NNgpcwCn6wlG6clISu93Fqrp9dB1P4iulXqDuo74L0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/MFktln; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37186c2278bso317731f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724232755; x=1724837555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtW0leC2Dw32/lkesLtRzDO2WQQOzasED8SlJGa2yWo=;
        b=X/MFktlnPU530vpkW+DKmYtxZnB1NN8O83cn82uJ4PVAf7kc4OD4m3lHsvYd8Nbsis
         jNFjExt8aCDJ/xw3LulSl9fyb3bnwCsxq8aTjNNZSyBvf00sVCrXbgNBePDupAL0INQB
         T/9ZeMUHxIdNnh4UcFMQ2L2/qlgBdchXCQK11hGx0JRLCx7h93FmclJVLD83WHQqWxbu
         6GqsqromsYCF9lL//HW7hXk2FlfXyT97Pu4LHyI8bAGdprlRhVZPygpptLb9/LltKqOE
         Fl1/Sn808nhJu2TcY5KagXUO62C1NW7HenvTutjcRkR2s7epcamGGR7YYa6pcBe4/Lxa
         AKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232755; x=1724837555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtW0leC2Dw32/lkesLtRzDO2WQQOzasED8SlJGa2yWo=;
        b=UXCNMgl6TdpdzSJMGK4I+iIeltXGkG77MEzpTYtd2B2ZLm3A+MpP0za26e7YV+LDjV
         HBw8lLjrnfyMdkLm9kQ7kQ2qz2owtl5mR3esjXdomYYNNvvPS8yQm+FyuszH8Hjj+iyR
         OScpI7VC6oi6J66r1vnHe6qgMvozEezjqI89C8L+xfUDRzuouy76LqIjqmOL06rVwLsF
         RoZtZt3YYA+1IWkTMHSvuiukdoi046klfHS2aSQqkVwLrc2NpjmrwwSAFLOWlxCdOevg
         DN0qgEJ26ZrQnRLSNNNd1aAKGRbAUnkL8y2TknSjn+DsJII8bPxGdlPLuKof7K3ZYsOC
         hCuw==
X-Forwarded-Encrypted: i=1; AJvYcCUaI6cFhbAbnP+XT6MSaCp8IjdI5GuenKrrRWAY3e/59y+bnxbUiv8HjwJ4TKkuXrxwkgXm5DKHRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+QiFSSFOSgisr51o2JoV0esSGqycj8+u+ZwMs0o8ELN+c/On
	tmKIqdkgJsYBiUjlEfmhk87yB/NBwoEggYslhlmdZ21qE2O1DG//GPv/QlDTS4A=
X-Google-Smtp-Source: AGHT+IHRIrFfky0Sc1rurltGhfdewiFAC0lajLizHyBq/KheWqYA21VK4dur3rH3z+H8eRRkUFoaeg==
X-Received: by 2002:adf:a344:0:b0:366:ea4a:17ec with SMTP id ffacd0b85a97d-372fdd840demr823919f8f.2.1724232755022;
        Wed, 21 Aug 2024 02:32:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef97f7asm18744355e9.22.2024.08.21.02.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:32:34 -0700 (PDT)
Message-ID: <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org>
Date: Wed, 21 Aug 2024 11:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance
 checks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <10527734.nUPlyArG6x@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10527734.nUPlyArG6x@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:52, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because the trip and cdev pointers are sufficient to identify a thermal
> instance holding them unambiguously, drop the additional thermal zone
> checks from two loops walking the list of thermal instances in a
> thermal zone.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I'm wondering if the thermal_instance 'tz' field could be removed too ?

> ---
> 
> v1 -> v3: No changes
> 
> ---
>   drivers/thermal/thermal_core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -850,7 +850,7 @@ int thermal_bind_cdev_to_trip(struct the
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> -		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> +		if (pos->trip == trip && pos->cdev == cdev) {
>   			result = -EEXIST;
>   			break;
>   		}
> @@ -915,7 +915,7 @@ int thermal_unbind_cdev_from_trip(struct
>   	mutex_lock(&tz->lock);
>   	mutex_lock(&cdev->lock);
>   	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
> -		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
> +		if (pos->trip == trip && pos->cdev == cdev) {
>   			list_del(&pos->tz_node);
>   			list_del(&pos->cdev_node);
>   
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

