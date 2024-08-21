Return-Path: <linux-pm+bounces-12620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE46D959946
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C8FB25C86
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32D1CDFA0;
	Wed, 21 Aug 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUSCZApj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4622049FC
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233601; cv=none; b=dh3G1XbI2v4J0t8sHG6NtqLY1LA2eQgE8X2EarbqUuue6kQEooEUqhlXAT/xuCQ4G39xf0GtVakksWsP+aDc/X2iCZwhUHBXmaRTqL5ERco1ALi5hrgdUP60S2HnGaBaEFqUOsciQ2XQNz0CpzVyqzKY+p/XSfaIdDXzBHsg7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233601; c=relaxed/simple;
	bh=BeUoU194BZUhvcq1kg/E3j+ujWEBXrWE0L6BlKD9NrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MORlt1pA/ul2begvEtSYD1EFlRIcMtSHeqgysflvNSdWweFUA3aZnrGicmDOnPcJQCqFEefkVMZ8C8VqzTEn8FVhBD9mjSXnA4tJUqGuQpaBFdkFU+X7sZxXUpZtDA1XNERZkSJ+y7vzEmMEFdiCFr3buOqBi8Wp8fHp6Iqqogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUSCZApj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3719398eafcso3398435f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724233598; x=1724838398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dc6gXl7afmiTMHEcwYKOq3h83oQ7HnViCn1ZWHpe8CI=;
        b=EUSCZApj/3+rHNDsg/cdL+EFl+ApZuH0a6fL737JGX1LU3BmfeXYsLALGMeqZPdm8c
         xPSmd3tqj0ERSl4Xh1hJd8GDwZes1a8zRpmHb2IfXucG0OnansrjArSD7IwXnJR39t/t
         msLwXe2NcuJrnm0LhnR6vig1GParesgYuF8FpMTIIjE4QNQ4MFPqzxDbbGUj9LSgMRzf
         RiP1n7WhAbCR6HOgcc1aEd1gngL7RGI4nKavGOHzEEl/cE00nqejtl/U+KA/bq7hT1b8
         ML4MFUJME2WQz1oSfF/K8iFILHF2FPYu1s8s/0Usgo/8XU16u4v6gQ5elO5GwToZ+RUy
         yujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724233598; x=1724838398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dc6gXl7afmiTMHEcwYKOq3h83oQ7HnViCn1ZWHpe8CI=;
        b=WPqhF+Mqu9cz0vReXxnGmKvQe7ZO9KGJN8Hsb4WK3dce9AttcbIXd3EEttNHNnRE+z
         kIMSZyAXgxURWP6QIte8Be29FVtRFT6Z2CfhwacWcZigrp002f84yIfvoe1tBm9VCAJZ
         t93WIyzL5WocO10zNi7tn29gn7q49xu19FCb3yQJzl9uWy+MxQCYNNkMr0FKg/CsUNun
         HUpA1Q5YqjV0/PXF/J7uf6i0AOPTl2/vSvDVlitKJGQ5Zf2XH1mLHtP1V399C6hZhfCb
         cCbDTax5rr59jNUXXNf1jVmI0AXpm8y8kM1AhiXl4q5glcs9xVMTT8QOJhhi4YUkvBj6
         ap/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpFjS+z89NUgPVzU5n+tKsSSHAFSNRkwAWbs5tiDm+Vljtly5LgrGmZ0zDp8UvEHEeeRD1aeEUGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdT5E5Ngxjc/XQIq3lYleZCSBVivT6olxJ1XnOwplIIh+2b8GY
	Ldl0aNWyOPZwweOuiPTL3P0W71iiItN+aNjttfmT2siNW4nOnNoQdR1apND73JA=
X-Google-Smtp-Source: AGHT+IF+Gf25/pZkkWXOobGnXP58MOyKd9peUCyMEC1yOv70kxFdseHl6o0ZoJalCfu73J0VdYKV0w==
X-Received: by 2002:a5d:5263:0:b0:34d:ae98:4e7 with SMTP id ffacd0b85a97d-372fd71deedmr984879f8f.41.1724233598029;
        Wed, 21 Aug 2024 02:46:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-371898aac62sm15128026f8f.101.2024.08.21.02.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:46:37 -0700 (PDT)
Message-ID: <da144002-f1bf-4463-a626-00a97615990c@linaro.org>
Date: Wed, 21 Aug 2024 11:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3837835.kQq0lBPeGt@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3837835.kQq0lBPeGt@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> acquire the thermal zone lock, the locking rules for their callers get
> complicated.  In particular, the thermal zone lock cannot be acquired
> in any code path leading to one of these functions even though it might
> be useful to do so.
> 
> To address this, remove the thermal zone locking from both these
> functions, add lockdep assertions for the thermal zone lock to both
> of them and make their callers acquire the thermal zone lock instead.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

