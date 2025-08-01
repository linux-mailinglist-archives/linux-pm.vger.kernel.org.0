Return-Path: <linux-pm+bounces-31770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA3B186CD
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C91A1C839FE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8CF28D85A;
	Fri,  1 Aug 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOBkt2Mc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990228C5C0
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069930; cv=none; b=j+rQA83rOqRts8B8pKW9uL8k09yzhuOSr2hQjLlAU6GhriCFRoIoooVqBpADtc9FBvO0jLjPNk8Zu4f+ogx05mSDDBFwA4jTq2T/MICioEDiKqdp7eWT/NLNmx2m2/qe+6ogvfZJPezBuBHqeObP1ykujEPkb6NVq9B2MuqYL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069930; c=relaxed/simple;
	bh=aQYBObWgzoPj+il0GZKSY+WiA7phu3h4hRG7IyoJstM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F57b1frvI8V2OpRjjGP5T+uRl2FYAQRY5W2uCOzm4szzswm65QLj030ba38uMYnPnh9Yc8gG54diMmipI9j41/xRHnGoKUi451yU9Y5rt8BkkrUxPFnH6q6amyojGnpzXIIyrUYlpB7tJ7BWJ5aOu5TWrRUwan2nVlYs/+pxusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOBkt2Mc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-456108bf94bso7103205e9.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754069927; x=1754674727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR778IDq2awUud7Ws1UQmVLj5RKdygQyf3jIFUrFC9w=;
        b=cOBkt2McV/03IDW9+r4hKBtcHGpg7/f9aR+Td/bQ15YmXGLK2X0B7wWJMRWx+gcXSy
         hUIu1olZvX/KgamkBdk2Ld1r1Js5yJnpvUeiC5FymPy9BE4KtBegaMOZqQcv//6EApQQ
         V/SirSArym273C/r09UcuK2XSUGS14+dq2OI22ZEb2iD4w/l7bDA96w/Aq7sHcmoy+rG
         dM/c5TBwaAA1Xg5dOnylHlxveDUJiiGG1v6k5LUKfz8P8RyRr9iN7L/ENWHWTztwwOTY
         GMqC86Bg8ZWUYjDy8F25xJSXmdTdFUypQzjZ0Rcho5bzaiRnoQ1C0dKV9mLbxZ8czXhS
         MPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754069927; x=1754674727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR778IDq2awUud7Ws1UQmVLj5RKdygQyf3jIFUrFC9w=;
        b=qijQ1Byy9dWygw02/KzVHbENrVpGGf7Z0LG4M8b3/tkWWitQyCwbXeZHtP/MMDhMF1
         dIwbjbiVTn2gRhk8FE58xDqu9iItnmGEVxiESVdj+4IW+METgQfqRsiNYx/rbE5jdeic
         F8roECT1SYoYYSmAGHO3+wV+uwfBP/g6rOxB9Eb296Lizd6Uwno/Rjidr+EjH4XZQisQ
         sWq1/Fr4tVYLuPlimmy0GJBs31J2q7wD8bkIno6LjuPqWT519q685TWMLuQH3GYXrwgk
         4Op7RjkKMBBoH9wYhO/0jmIEywEaHjb+Gb/fbNya7erxDCuQ8bFCaFxI3OMf/f1x/Zzs
         IUIw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Xwabv5VViHTOXF2Q10O6KvTyusqTuYK7zdM2ulDByWnOeE5EavO9AJff+BccMkduH759toFqZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNj9LLJeC2VlyKfqG1Xu1Bu1HAxs55KzVpBdDidzg6UEKZho+u
	D8GoKFTNkM19T34O0tmfB3slownWUH4EfQ4mk3NUGcJSuT3yrfNQFdEeMSuDqGN4vDWhLoQ9mpM
	3mZUq
X-Gm-Gg: ASbGncuzQ6BbtFIq39zdjv9DbBLzFXECaJQS5oQWj42Tn9fFCDFQ9vt7TyWgTFoyOWB
	KIzqgwJsPg6oQ3f4VnIwm/TopABtNBXuz8+B6/1SkdAiSo3TgqNroJrPDFrnbNiBRLNSqWN7iTL
	Pn5yw0laK0/a5v0X9ZWYp7uJhnsJa+TVUq5LNm7nepe9dCxd+F3M01y0CF4M1xPeKRmzNMylKdg
	hTRrFlM5Q8PCu4gVn2TT1QJU9G1myLiq9gLzuiapzDtN6bhS7r+YW/c34ms0PuEtTi8tTfabb29
	fC6P+oKKV4+g6M9ZXHmL7p7X2mkXXzjS41Vkf+Mse2ODSX0eSPeRA0Rrm6pUXWE1M2dV41O/bRI
	vnUzDAynYVOCCQus+WjIjqbuatGRPDGkk6nAw/su15+5w8l1d38PU4Dm0jFkIcA==
X-Google-Smtp-Source: AGHT+IFSgI7ynQO05ITDIMMGNQuV0NhyoU+S80DP5VZti0Les4bHUCSN7kHUohJoYSqboUd/PkGLIQ==
X-Received: by 2002:a05:600c:1554:b0:458:7005:2ac3 with SMTP id 5b1f17b1804b1-458b6b34cb7mr1416375e9.21.1754069926804;
        Fri, 01 Aug 2025 10:38:46 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4589edfcdf4sm72965545e9.11.2025.08.01.10.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:38:46 -0700 (PDT)
Message-ID: <9e4db85c-83bf-463e-9c6d-bc31e5889574@linaro.org>
Date: Fri, 1 Aug 2025 19:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] thermal: qcom: lmh: enable COMPILE_TEST testing
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/07/2025 14:18, Dmitry Baryshkov wrote:
> Rework Kconfig dependencies and make LMH driver subject to the
> COMPILE_TEST testing.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

