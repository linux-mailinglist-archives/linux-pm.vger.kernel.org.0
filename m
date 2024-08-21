Return-Path: <linux-pm+bounces-12645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF3959F94
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214751C21D51
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5062F1B1D64;
	Wed, 21 Aug 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhTQWfNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14141AF4D2
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250010; cv=none; b=fxghEmybRYOEphUeoGqdS3EgeQIXWUqI6dTSB4MGxRHNcmH44V/mdtMuE/aIUG5Uo/KX7HXdxSixmKDHZfnZTCwtzwmGVI/kYT7yaZblIa47By6jyOTNnCmnVrXI1lHaPPAjqSEo4MTgUHg2737bvgawM7sZYqHL6vV0vW4CyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250010; c=relaxed/simple;
	bh=D8hNWAUfiiAEWgGZCpoeNqez3UHBZl9ZXmQzIgbTF90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqgrbpjdgwqkXKzt7nBGoaBzwF9IoNIYK+TiIbvViRmqeBO2y8gXzPglTEVXD1b8xeVzoGhOwHuH+6DVwENGqH/l1uDCNxOhCFCe4jiWcYSX1MkxVLCgyt/vDvrSrhQdqf111RakBD+4cXT/4XE9DESF/NItM7WXgOrhYxNViaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhTQWfNz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso19784625e9.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724250005; x=1724854805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4KUJsClreKF8WvZ1fwpBsO2DigriOGc25s3izhKSSF4=;
        b=KhTQWfNz4oT0j5gnyqnod+qJFvnrIRHNFUyZdnhgXqIhiKCorKcOscqkoR4Sn5PGR/
         mZbfXiBv6NZK9uvLQh6exJ1ESHanFD7RgUxd6JSRaYlmN2lswhOOC7REsY1owk96pv/z
         r4bnl2y1IGL94MyJWEy8VCx3E2jvGdSgmK4zDZhSZLdIMzymK6WdQaiuRo8a3hL0kntt
         S3ZtWNe6l5nzYEcsbmiy9raDDf44RHi8zPy67XDLYVW99AfBbjFytPdul/xiaGgtZY1b
         vTTe2AtErykImiWQxIEQE2lSDpVKJFgAxVRkifzExbQmHO5EixLPVfkcDKkO1KlOAgMf
         d2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250005; x=1724854805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KUJsClreKF8WvZ1fwpBsO2DigriOGc25s3izhKSSF4=;
        b=kMPEP3lTvGNLRWybkMKjWHXMmAzmNXgKfUvG17eKN9aHt/YVrSkWRym/5o9IcH7WaQ
         ObhY80GQBuQ2a3Yq0krBbWtVn6Dsw+m6yhkovnANPH4nQ8vqz+D3yttKxMJdYJHw1kAI
         /qHSeCDjAfoapz/rqlLxu0QlPjITHH8UVjERDHLlaFRFO+Oy+1ifEp2+/U5SrteDlGTA
         4m2jBaawRwEg1F5fOzzDHovAl0awNFwl9KhzPCXORWVSYqNYaySH4tgdHQskSffMQVTl
         LTPgzAyxumCcuNORB+RjfjUhWrZ5ienZZyiy+lOcUdEm46XFCDHki/q20fvBbr4oRY2R
         n+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbbhqMw+5Q8B2d4sQitFhCdB+svdDwJ2sPZn3RjOH2+pCLkpumOvsUdazXjFQg/JF9yDfu5KDb7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzejxLsVqa64rHHNiXi5+mUvZnqH+VIMGZi3KXtrWmnXbw0hQfu
	qkjBDDYwJQxyIOVaDoBWCEOyDOEUZK/IsDVy36WwhGbFeKyC4ipm40ncDzSCf2M=
X-Google-Smtp-Source: AGHT+IGHU5jYy5N3jufXXKfJVX09vdAjB+JDPiiN0cJNxmoL0Rr0a1tfVD4DGfk/lt6oxHzyRI5fHQ==
X-Received: by 2002:a05:600c:3c90:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-42abd113618mr25241405e9.8.1724250004245;
        Wed, 21 Aug 2024 07:20:04 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42abef9948bsm27370985e9.26.2024.08.21.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 07:20:03 -0700 (PDT)
Message-ID: <62bb11ea-e489-4d64-b2ef-7105bc544f9a@linaro.org>
Date: Wed, 21 Aug 2024 16:20:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] thermal/of: Use the .should_bind() thermal zone
 callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <2236794.NgBsaNRSFp@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2236794.NgBsaNRSFp@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the thermal_of driver use the .should_bind() thermal zone callback
> to provide the thermal core with the information on whether or not to
> bind the given cooling device to the given trip point in the given
> thermal zone.  If it returns 'true', the thermal core will bind the
> cooling device to the trip and the corresponding unbinding will be
> taken care of automatically by the core on the removal of the involved
> thermal zone or cooling device.
> 
> This replaces the .bind() and .unbind() thermal zone callbacks which
> assumed the same trip points ordering in the driver and in the thermal
> core (that may not be true any more in the future).  The .bind()
> callback would walk the given thermal zone's cooling maps to find all
> of the valid trip point combinations with the given cooling device and
> it would call thermal_zone_bind_cooling_device() for all of them using
> trip point indices reflecting the ordering of the trips in the DT.
> 
> The .should_bind() callback still walks the thermal zone's cooling maps,
> but it can use the trip object passed to it by the thermal core to find
> the trip in question in the first place and then it uses the
> corresponding 'cooling-device' entries to look up the given cooling
> device.  To be able to match the trip object provided by the thermal
> core to a specific device node, the driver sets the 'priv' field of each
> trip to the corresponding device node pointer during initialization.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org> # rk3399-rock960


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

