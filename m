Return-Path: <linux-pm+bounces-12640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DAA959E8D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F93B20F65
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909EC19343E;
	Wed, 21 Aug 2024 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfrDonly"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D81531F7
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246555; cv=none; b=BSNzxaLzDA9znFD1z0AP3cDn7ccPOcWDtatpt3BVnQIPLjnANoLmX+UhS9+/PVPrL2wHfpYZqcjnzrYsv8VARznyVNwrg/hs2d8uVv4eSbIKYtTj3FdBqsXVbCtezPe3yHvUdk8mLKeAPopgAhmsICdjN2w03lyyi5nT1H6eSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246555; c=relaxed/simple;
	bh=TPIZRcu+1FDUv3Ul2N3eIPWOpU5oGmTbG9vbLHMbQqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7C4Wy3Lyh+b4cwHOsjTvldBcyzISy0Ytmq1xTxf3k0bH+XJOBeAD+LmE7BSI3EMSLNE64RsGxKmY4iyeLizDSQYs6E94Aja2DFKfWRxZCDm+Bo2Oy15nHVRWOcaMGmv990vkDFypUFopSn8wnoGfg3uO3hyQX8lA4s1UrHiR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfrDonly; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3718eaf4046so4416789f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 06:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246552; x=1724851352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49UiUbvVhlmPKCF9ngIeL/BHGCxk0mo/GSe6nh6O9fI=;
        b=UfrDonlyk9pxMLMmamwNf6LwjcY9Dmv7pRr3A7wPM8pQ2W4TywLx6T4IWS7gis1T0E
         E6Cw4uOCrMBDPm9zYsiH+3rh/FadoxKDFtI569SuH/n1ldVJaTIoUMOTJvmCqWe/X49i
         qi35ONJnSuFPUsn0K7sQT1bRqPYOWLUqfIexO6IBrfy0UZo2eTtYlTvXHt6SWSIzbOyr
         vsfPoRGF6QPRoBRy8m7U/iZB9W4Zj+p25F5QhR+aetsZRnqA5Zn/tbIBIPvfDP1TEwG5
         vRgSPM4rO0UkHBy7ULJebEIoQyvWOXetUa8xj0uhstkBobOCcL15aPqFel0ZOPEzJIfo
         s/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246552; x=1724851352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49UiUbvVhlmPKCF9ngIeL/BHGCxk0mo/GSe6nh6O9fI=;
        b=Zvl3HB2BVCSZVbV7BFCiEUN2lUiYn+RLaewtvrYc1I8RKkUhAcRdbqHxx2AM3wmiN6
         MxtdBP+YFCgrRg3/qddF2ZjPW9HToBHin/dothazRpvezbQTNRoWeRH9gvOAH0S6jrfY
         3KyKQ7u8RahxaTa7laDDgO4OwzqZ1lm4f+Bb9/1yXfUzF7U2RXIFs4lTJ+sgGnwhEZU0
         2NZbpeWvompAKcIb/0VgS/99tT0agd6ZingYDGgcWh9TCFo61Nuk0xVXNuwLrStFu1yq
         lCyXknkvt3ByL4xEzsXGEaOevrWpZG/q+4gykVRW1xGg/74IVM2BEK9APiQPc3/FG3uL
         npzA==
X-Forwarded-Encrypted: i=1; AJvYcCUINZi5+VkfU8AyhQTgALoiBNuX4mItBj7Kh77+r1bEwj/mK8cfmmktJ44q35TSC4PtQAXwz+XyCw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyln/uC3Z+nN9W+7zeWqI/bKlB+j0sFVV47byHKVk9lL3hgNODO
	ZQ3WRMw035JBTDvRXTbZuIeaxyKXQanziNP3HYDb35FXq5St9XMhxraiRTKvo0g=
X-Google-Smtp-Source: AGHT+IHG7+vM9Jjhm+SZ59KowPRMF+Lu0+jqEwVmKXC+1BaBKyuHAHW4qDwd2+EqRcY9Jrb4XySpHA==
X-Received: by 2002:adf:e387:0:b0:368:6f64:307c with SMTP id ffacd0b85a97d-372fd590e6dmr1905547f8f.15.1724246551577;
        Wed, 21 Aug 2024 06:22:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718985d9d6sm15682828f8f.64.2024.08.21.06.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:22:30 -0700 (PDT)
Message-ID: <6e8b9166-c1bb-4adc-92f8-ecc06d838c72@linaro.org>
Date: Wed, 21 Aug 2024 15:22:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] thermal: ACPI: Use the .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1812827.VLH7GnMWUR@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1812827.VLH7GnMWUR@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:02, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the ACPI thermal zone driver use the .should_bind() thermal zone
> callback to provide the thermal core with the information on whether or
> not to bind the given cooling device to the given trip point in the
> given thermal zone.  If it returns 'true', the thermal core will bind
> the cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> This replaces the .bind() and .unbind() thermal zone callbacks which
> allows the code to be simplified quite significantly while providing
> the same functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Nice !

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

