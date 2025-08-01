Return-Path: <linux-pm+bounces-31768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E21B1865C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 19:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94E17ACA91
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B71DE3C8;
	Fri,  1 Aug 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZ+UU+Kj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5B19C546
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068375; cv=none; b=kscNwylSnwKm8Yth0U0RfL7KmKx6znuH2wJ4qaWT1cZNMXMfJANGGRXfrR5DVHOIEhyVwfvaK15aOoxqBCgtIgp0MLUAs0Ddyrte4G4PIUPs5ERnxtKJyjNjTSkwUhkDZhYiMA3y+aDouPf2YplcCDh8ht8cTharmpZnG7bWBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068375; c=relaxed/simple;
	bh=A/j4Ifuce0u9/jL3Ix+TUiyIc4jO4+FIGeZc4i+1OBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPsrhVIGaJnrSB2XTuMmzPdvCt5g3pEC4LPNn490ArNHjBbhJlbdYI7RHQDaU6OaKFM357A60hIGSXU6xXygQWqdZIP6WeKNM3UOmUWREXq9iUCbalomm18heGrzIhyxVqB1xyNQl2fVD9od4HqxDbjyz36/R5ZZVP4vauXx3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZ+UU+Kj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b788feab29so1143727f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754068371; x=1754673171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpFchoVzlzh0jyiCYJs375yN6Y3U3tX4URylglb/9mE=;
        b=pZ+UU+KjpF78OXkM1ZjNKUhEWL+nnXhILA+Q6TrdxLt8ENMx93QLGHOKfo1oeD7ui6
         ODIszvaWE5N7jOc10SZa0V8svwhtCt1Jxist2lJ1WKcbWK3dmUVaMX7xZnrQ7g0bd9Ud
         HxjItJ/vJZ2vKAj1GomHhcH2klvLINiOF+13e3ETP7gGKVnd7a4a4SSY0YuklYu5v6Gg
         Fi8YlAHwhMLgHD5cbG2ivMARQOuVhq03PzkI6dUb+K+kswrNCqye/Ym5SJRVhlRILMHZ
         vh23IQqO44zMbEG6du4sT6ezkBY8PrF9NchrBfhF/YCprldtxBarDX7Vops21Mh69jdI
         qS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068371; x=1754673171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpFchoVzlzh0jyiCYJs375yN6Y3U3tX4URylglb/9mE=;
        b=RMyj2hrTv/EasbNMpgPl+UK28BKP7SORtAUolYsoE5AwOWHTU9OHnF+lVnHVIAUPL+
         BA60HUKu6z03WX2jMsWeYPOoWqgQgoSiuumzjjtQbKHYZpC4BuvxxRjM4Zr01gzFhyl6
         UPZs79XoBN2++G3DPekt8U1jaq4zblBNgFyXRPldKhKUDSpEcSu/zQl9yXHjNVgyBZQ4
         8EiHpL41JyN6OC4tCdBkkT4venFIpaAdRdB6ZqprHdksVbtQ1BtpI7+ViXmpzA3seJN3
         cm02nfTvV7mj74NR0RYaqlnAJjJlZmyY6Qe4MgWxHPdiSXtvx0hYr/yjmkZZYj07mBsU
         liCw==
X-Forwarded-Encrypted: i=1; AJvYcCXkUH2FFUWB1EAr8Jgshkd9wnYs7R5H/GqZV+BgrgwKW9qsi3LCqCuWm+kXDb15ZM48IVqH3Fxz7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0n6rFzVQ7He6Onr56Qut2AXYJrSrWI0SKKn99Z3KgjsLtZiE
	tE8Ums/CUTYLpp31O6Gg9Wc3+Ca+BeWGOhgYH3VU6iEcPfziX8PIXUMTPM9XpuxY7XG5vKgI4QN
	IXxS8
X-Gm-Gg: ASbGncvVLHzEZPVaGLKtcfsk4j5lNHdAD5LNzL4HquYcQjW0XsK1bNYJjZsuuzcBHgf
	kHtZps5vI40uuLZzynJOseMJ7EFgUCRW04n2rmQtnKoGF0+0KBWxNkHUztUyVL7dIH1+TWzbWtq
	65aUgIctRZcm6CCjpVWmj/49mzrXAv8+9T27Df2gODnxre2v78qrTkYhUMJTsth11Oc9+shVjpl
	AOlYZqr9eHqzGv1tYEB5z96Sj1/LwopaBDIEiG6cYCJkFPzlWpCOtEhLR+oI6D2CH4sr6lnf3pN
	RAw9UL2QSa2py2QlGFQ3fPs9Zcpvi6rogpwUD00y3bqnVJMxyP4+o+mve3dLv1Vr+LO1+58aD/7
	FtVWlfqpawDjk6xH7O4j6mt03VMlBcDCEuXf3+2JI3GS0ajYWwmSrHX8wNKN8ag==
X-Google-Smtp-Source: AGHT+IG8FK5nU3TfGOcq2jwE4t/LH9fg3G6zA6CPhqrXPHAhHe8RghP9OG9d+H/XSEzhyijEnqWbyA==
X-Received: by 2002:a05:6000:26ca:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b8d94ca582mr522194f8f.56.1754068371489;
        Fri, 01 Aug 2025 10:12:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm6360936f8f.57.2025.08.01.10.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:12:50 -0700 (PDT)
Message-ID: <8e9f462c-872b-4fac-bcd6-aefbb3bd9493@linaro.org>
Date: Fri, 1 Aug 2025 19:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] thermal/drivers/mediatek/lvts_thermal: remove
 unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20250801063540.2959610-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250801063540.2959610-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 08:35, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./drivers/thermal/mediatek/lvts_thermal.c:642:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23244
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

