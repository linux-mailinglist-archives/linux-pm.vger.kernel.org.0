Return-Path: <linux-pm+bounces-12618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266489598E9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23BD281CB7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4091B1D61;
	Wed, 21 Aug 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzDHNb2C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE11AD5E9
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232979; cv=none; b=jSHC0rcRkRt8jjVBMx7CE/WgoWtFWu+IwpETxOjO9EvD70VAftOCGgyP8Iu1xnYY3YndkNR163nE5O2jmesHGzqIx6chtR14ey+umCXgyELFYHB3Kpe55vnRtDlUt90qHHXZ9Dr8eiBiPDNrE8bgrKAZgujXDjSP4hjzJDGy8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232979; c=relaxed/simple;
	bh=XfBqF97hk+NE8MlrUeFeI+aPBB3RDjCVXfkdAil0/YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4HyRBBqqK344Qpfiv+F3MIm4JiNNwgVgxVV5hMlpcDFtlVl+jjQoGDYsfFCchQCCrdCIOxQ4UyttorusHvD+gELFJ2zqvot+bL0muzoP5leD3OzGU5tYDSv7WfqIgSXxlnsHyUgkKfj5yfQBHXXkM5fTOKW7szcVXhXA+Ov+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LzDHNb2C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42816ca797fso53310285e9.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 02:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724232976; x=1724837776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B20IfwvlnxYHs42JVivrktmNyeiEI5FdhY91AGiu/FQ=;
        b=LzDHNb2Ctnl1mtFI2PdyUub65+qj4kb2Nkh07BhvAg3KhAA/+oBcVRekXytDcn/a5G
         9sW71KLUCGDjekQ4IpEdsA1+1TZxEnHGTusdb9G8C7dpN4FtwIQViVlvgX9b82b2oWzw
         XdveYXoODno9vqXDDcitoDRpM70fTsqre4I5g5AIn4xqglXdNNoGYfGmVUYHuLuzijrY
         fS8kX0MT8LNdQGmitGlkE31wpMowNKJdAa9RrXmlhjsA5uNH4rtoJNw+oE/METdsy2BP
         uO2KVKILu8VoyXP3t7PsnY0o8mRfQ8sSsVX5sGiTQczm8nWW/T71K2VVWpowxZVuW4Cq
         MH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724232976; x=1724837776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B20IfwvlnxYHs42JVivrktmNyeiEI5FdhY91AGiu/FQ=;
        b=tdW6iYyQetmGxzW2CTla35nubq8/I0e+kPIuKRyxzj3BOgsmn2YZVK3WkYj56QGHOs
         M9i0WrxhE+MgNDzzfkSmxs1QFAKAuzjBsvMROOKMspxAbYcyCPpJqcPa4AR1Hwu76JTv
         DYg5HAoSKOfyhQJaZ1nHXbt2LOY1xB8LqFUIn3B3NhtFfyjeD7na9dxWF8R9Y4heRgRV
         9rfy6WOUrSue6sTFQv4DAihDnB0FMDl8DEm1LIPjFJ1OhbHobETZM0CA0HP6SsmUi2oG
         6Lb5Qv4kvHwz0lsxvLTu0bqbqUxbsM8iwT7ELpJFhsf+KzNR0cIVIy6zRNsId9CAVfAf
         Cdtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTUkcjNuDv0ftg1hzjZ23+BNmInXkGzViCS1uMlnNEZLsGj6iIvRu71e7wLArfmy8UPnUr17xF5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmeI8hbpc51Yt0CXcdJU2Azj1Xb+8nI0d3iO+XWob6DomIRi9
	t6CXh25XWdKY4C77Jvp15bsmYELVpY6hNkQDC+IZiUgxjXphgcEGndr3F1fwtAQ8E56UAzaqTYK
	q
X-Google-Smtp-Source: AGHT+IFSGTPeEF9IjqLXI/2eR4OqFuA2MPcjqCJifpSA3FPqCwbfX0IFv/OuM12jqC2JUcagUtMguw==
X-Received: by 2002:a05:600c:5106:b0:426:5416:67de with SMTP id 5b1f17b1804b1-42abd24582cmr12344535e9.30.1724232975338;
        Wed, 21 Aug 2024 02:36:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abefa2362sm18645685e9.34.2024.08.21.02.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 02:36:15 -0700 (PDT)
Message-ID: <d7b76680-bb53-4424-9ada-300ba76848b7@linaro.org>
Date: Wed, 21 Aug 2024 11:36:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] thermal: sysfs: Use the dev argument in
 instance-related show/store
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1987669.PYKUYFuaPT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1987669.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 17:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Two sysfs show/store functions for attributes representing thermal
> instances, trip_point_show() and weight_store(), retrieve the thermal
> zone pointer from the instance object at hand, but they may also get
> it from their dev argument, which is more consistent with what the
> other thermal sysfs functions do, so make them do so.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

