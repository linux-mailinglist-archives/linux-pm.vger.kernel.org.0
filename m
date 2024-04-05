Return-Path: <linux-pm+bounces-5948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6898997C2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8E41C21537
	for <lists+linux-pm@lfdr.de>; Fri,  5 Apr 2024 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE91474A5;
	Fri,  5 Apr 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2q+Ygvu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4AE145FE2
	for <linux-pm@vger.kernel.org>; Fri,  5 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305604; cv=none; b=ej9GPrDTjuIPwyBv9WKJT6dqREJe+zkE5F1FzkDpgkeiJ4Tca4pvCivwoofeQqzbOsOtYDPkdmCHtAC1Ho2opHmVACzobZNE6fzniR6SGU06VGjdFDqCTmZ6XUcvBn5R/0NlbZK9KKkjaFh3kAL6PdZ26I3GwuB1mFOa+5CMN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305604; c=relaxed/simple;
	bh=L3+wBybU/jlATwmfU1ei974S+uS9/ZbUPBAkmJxl36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efl8yiW6NvXnGHc66Cc9DvMXGLDPj2ctuH+Mdzycl9wJJjvo4b+YszPFv5OUJevmXjFzBPxA/UXESvfQ4GFBrAafQRlEeYa9IM8ohM2Ay6ejvWaiSNDO9ntmAgdfgv43+r8wmbdf5Xb99ucIqm4BA1wo106AzI1h+teVu3aqVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2q+Ygvu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4163181a7ceso1258835e9.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Apr 2024 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712305600; x=1712910400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMjODkcesgwF+DXMkkxfajgQj8hEAB2u1kWBMt4YYhk=;
        b=w2q+YgvuP4wH5mxYf18z27IELilPV/Hi7B7zX52WBQ5ynamySMYnwG726cxxtIS+l/
         6ULSYmSrYCXKOF2tJZE/1+s9nmnkumTiHSBXs+oNVizBKlV+wy1IuEhvKC956cx5T55L
         dfcd5ebZFQcnCPX/bitir+SoszM9AGNIi2UpPdpdDcYPoVovMzCo3woafpEzlHGceqgA
         dIEOaLmMDQogQguPZJM4yaRbHy26olTVnDUunPpuaRFuZXc3uWFJRky4b7PezGnurli9
         YvULVBKovgJSEFWCVhUM/U7/EWfBetMF0ec4oXf+F6L+6NBOYruaTr92j780VFg2mTUk
         nE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712305600; x=1712910400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMjODkcesgwF+DXMkkxfajgQj8hEAB2u1kWBMt4YYhk=;
        b=D49Ju6BOyb+cJWSwNA7xojKALILK2QeUYc9++6fLYB6PtA97SMVwCshtmLePnm+lec
         wGZWNJAodSuwANX9FRUGLZl3GTx2nh+Iw6F2wHsg9yelbt7uQCNK65Jh/qTTFD64Cf3U
         QApFp/4oUby2BnsYNuG9x/yDzdECIW3FdGLA4vzNackL7APwWMN2cYQfbB8G+9nSq9Uf
         3zyqk/WG808ZZv2BrNqYtQUcAFxrVHHgCb+l4KhCCyOutZb+leaAglIJAJvPGdCbmBi+
         A8urIbfu7ftvIgwnAEQsaTs/CcsJIHsM8HF+4qGaNrGbKWVFPPwBfChGMtXwDhVIHX7M
         EzUw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKXM895zZXw0Fsl/uRqqF7ONu0xKUY8DzLYW21OFQvjtz7HHgkO9oRRdiKnF+Hax7pLPiXK6o9pRL3bUqwh5eihNsnrWzi3Y=
X-Gm-Message-State: AOJu0Yw23RPYMUv9FbUd/z+I2TbeYfIoPgjM9a0/UlB5wa8g5CmbY9+g
	hh8Uvmhxc6KGnowmfb4LZDClFErkT93zYkZF9+rTkZjMnoRft2F+2eLO0SkxPS8=
X-Google-Smtp-Source: AGHT+IEAq5BdFMSMX/Ole/iMCesB1OKC5AMXlen0BR/i7xf2nNdPFCeW9dVpnVYgKxCCzFVBTSndOA==
X-Received: by 2002:a05:600c:3d98:b0:416:1c9f:4b9a with SMTP id bi24-20020a05600c3d9800b004161c9f4b9amr550749wmb.38.1712305599630;
        Fri, 05 Apr 2024 01:26:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u22-20020a05600c139600b004162b4c6366sm2064107wmf.20.2024.04.05.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:26:39 -0700 (PDT)
Message-ID: <feec4f19-4d47-40a2-b921-c027d4379e65@linaro.org>
Date: Fri, 5 Apr 2024 10:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: core: Make struct thermal_zone_device
 definition internal
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <13485814.uLZWGnKmhe@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13485814.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2024 20:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the definitions of struct thermal_trip_desc and struct
> thermal_zone_device to an internal header file in the thermal core,
> as they don't need to be accessible to any code other than the thermal
> core and so they don't need to be present in a global header.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


