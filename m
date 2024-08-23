Return-Path: <linux-pm+bounces-12796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154395C667
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531561C21A2E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B3E13A88A;
	Fri, 23 Aug 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHqMEpQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE6312C484
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397467; cv=none; b=Vbf6AEqQSHnKLxMpWBGqU+xjSUr+20XJehk0lpxxo5p0BidESI3rHFe6aG/pFGDTNSeIWIL5WeiiAMe1xsHivIJdYoOnQ74s4jsBtqEOz0+JW3lyARQRtIGx+qRLl98Sa09TZqlkeP/W+PNX3sbMf8N0z2C0nfmlBVAOI7q7tWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397467; c=relaxed/simple;
	bh=LJ0KJvMFyuvw8bV7vipXkuvUrD+xaAKMYI3SnUDG7GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eqn0tzioT1yrqR8DvimLd3rvn4uqmmxlBSDSoiWiMccB8KngDFpTeUo+KasGW7XalGSiJ0qxjn+km/rIcs1ODZmsQHo6m2RbW4we41nZ/ItW4gbP8eUBJNak7eozTrw2/kPgHIk55bBDTIdCSgZ1jTxETegn9ZkcXRhUXVOUx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHqMEpQv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso12593895e9.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724397464; x=1725002264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZVKzUZkaZNCPxzRfFzdPnaeJ1DHoiKq0SGUFi/n2eQ=;
        b=FHqMEpQvHHu2UqoNUWcPKyhVmjcrkZjLOKKqYQiikSdKLpSWFPLj8HzBj+ahMJdvlV
         GxuxUoWfn15+wFWrq6HN9SBCdBCi9L8tPEO5KBaKH8KRqYY6/MOyRZoZiFxVG8JV8R4w
         BHjmKRvF+OEgEkOltOIoxyuFQmUNPd97WHz/Hb27JyATapSE2eZRWbNAXaJq5zwZddf2
         Exp9AvYElqjo2i/vyta9hoRuDVbXZbn2bjVGKw6X0iElfkg79sq54NXDO+smeZ5WJdyo
         FXPbidL2L8Z4yH4rrC3E83Q/QZWmiwROD9zh09c3j+cx8i/ow0OndkS7jmbdIhLkWzPT
         1mXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724397464; x=1725002264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZVKzUZkaZNCPxzRfFzdPnaeJ1DHoiKq0SGUFi/n2eQ=;
        b=I/TNEtXNi0fwHoUGCJT/Xk+EOtvqOWlIu/tXthG1DuXKjnAiCZDfOtVmngEJ3Lq5lC
         GPnsV/v8rWqcc5dHWRtMs1LUpSKIodUOV5NbnIhyy1laW9/JXVyfYKSwXMsNFRo2Ur4M
         5h1ngKu7OaYtmrKH8Vu4JEaHitS7HcpbOP15wgNdZ+jYg7B1BmVZWcTtYHEhJ+ZL5USq
         8YXrXZxw/rirJC1V/uLMVKlr15CCF/Bx+dGHCTBmgcXlCPcmOjmvQp/w2EaZz23s+fo1
         4S3PZEJOncRrYsP2MzMfRD1xV4j3OK6wI+kg/X0i0Et8FH5BTP9Exfxb1RAc1ILU1emw
         74jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHYoCrWoy5X8NAsmiITdzVnIo3rv1VXkG81mGBcFibCcWohBGcky1/O1n45SjNFK624O94VI0Ipg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz514SaLonCSATVinNOioBAnmWjXryCgOn+5y3dP17xAtOvsGr4
	RuXk9DeHY+R5Mx9op0yJQLSZwvI84XbPTILZEPmZDwEo9CL5t7eIFGjIB1IpKIPSAXd/XSM+nSC
	d
X-Google-Smtp-Source: AGHT+IFiJTaKGwfcLGJNOi9ZNAmc7yJAixc9OfrYq8lKMC0x6ZszpF9QXeEbB0rdWls6DHaRpnd5Yw==
X-Received: by 2002:a05:6000:142:b0:367:f281:260e with SMTP id ffacd0b85a97d-373118878demr844589f8f.3.1724397463770;
        Fri, 23 Aug 2024 00:17:43 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3730826196bsm3439871f8f.102.2024.08.23.00.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 00:17:43 -0700 (PDT)
Message-ID: <9a90bbe1-bf05-44a7-8e7b-4ff5d968056d@linaro.org>
Date: Fri, 23 Aug 2024 09:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: core: Drop tz field from struct
 thermal_instance
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Huisong Li <lihuisong@huawei.com>
References: <12516814.O9o76ZdvQC@rjwysocki.net>
 <4934182.GXAFRqVoOG@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4934182.GXAFRqVoOG@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 21:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, it is only used for printing a debug message
> in __thermal_cdev_update() which arguably is not worth preserving.
> 
> Drop it along with the dev_dbg() statement using it.
> 
> Link: https://lore.kernel.org/linux-pm/4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

