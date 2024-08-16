Return-Path: <linux-pm+bounces-12356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B220295487E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 14:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8181F21AE1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C97319DF42;
	Fri, 16 Aug 2024 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTDOLNQy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8A13AA2B
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809981; cv=none; b=WPNza2NGwwEfZEGvmkcrPfeAO4BUOXHPdasOQxSkH14f0/rORT4Gzh/cEVqtWjRH39ihj4Qc1E9l4rPZpFoUkqql1x7X+K/s+ItE9u4ZlsbrlP0TsLPwNQjDX/5E7DCRxIo/teUactPbZsDNXcCWH+2nEDpUqOUKgev7vbdla98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809981; c=relaxed/simple;
	bh=+jy978DVbAgNjUTYExif6paXYhQzc74P0iAfawuieQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzM0tuJttI0Eyt5qOY1dFiS5S4Wk46ya/Mn6hfx5sNAuraNfw6fXjCJhS6TzF5huHwnMO7VcerF+0ohwWVovSgUirgLdx5UvAJ6JhDzNGOanM4Ss2aJSEq4KCnCubqCiKuCB5FZAGwHX1s6wNjEfDHcILzAlJARywhYa0Qyo1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTDOLNQy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso14256065e9.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 05:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723809978; x=1724414778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRZnt+BENAYNzN1QZ8kN7uJC0OG8kaH7jOXqfIxyOKY=;
        b=iTDOLNQy/zGhZOr77/uUcnqACjfsTIpYAwljxRhREadxhazbS95hQUd7Gxr9nqC8Rn
         9SM16mb8dLuWtleEp5L6sw3w/oaXctZ5gqKnqggeAfMceq8/TXNOibFgq7KyHPTwwuXB
         nn1jMxVc1AKT98WjtB+0WflJzjmJ9h0jEFvsJpmRWw+rTB0t9IR3aLyxikHjgZLg07iS
         I+C1l7G1B/pI59p2+/vArZ6lj/Jhv1d4yPIpNGWoWvekKWuAh1B2shSgbwjnB9IdCpm6
         exFALfYX6mVFN/U56Ajt/WIgLvxZCcAPqwy62TdukuMmhXJqpHt//BonnEUbnNor5PWo
         hjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809978; x=1724414778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRZnt+BENAYNzN1QZ8kN7uJC0OG8kaH7jOXqfIxyOKY=;
        b=T2FM3PYH2hOXAodqeBgHFhZIDNRrQ+SGDu1rdGdPrriTb1IFJMeWKCTTczQY+qo7Vq
         GxQcZMs8DTAwPBr2OdECp6OXZq4fWkgnxRyZCDgy3rnbTaUhC0d8WtPZN3nM3RLAIIjx
         H9U9okEPN5h7w8deei86SY4msDQHBn0IQ07vTIQ8qm5Se94UdKr41Amf8BO1R8gg8+Bu
         sYOaiIXxFIXhZN0Ne/ktn+7qvTwcO+aEGJeVmD04KNxF+JKM+A8x8ksMrvvbmzfXCVMw
         LQen9SxhzRFPyrV/N9nGCgQ6mm87sjf6jGnEppv3mQpxzgXBnrkc3WlYMjCwA0CFdF76
         2SOA==
X-Gm-Message-State: AOJu0YwSDjxBOG7ynGIqexg/RNNMyGWUo6b4qzH3jseV5iaZdg5C9vfn
	wVxENW78k3Sk5IntRmSMBuUtX0zpP7SGgI57p4i4nFF1DZiAbnZkpCUuhBwAi30=
X-Google-Smtp-Source: AGHT+IES9d7EJOFhMJEj9cKV8DMIQDNB45UBU4NlvmbOxUHNAfk8H6f8IFyKYDB31jZIy2U/XUDQIg==
X-Received: by 2002:a05:600c:214f:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42a1946355emr9172835e9.5.1723809977459;
        Fri, 16 Aug 2024 05:06:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded36f55sm74740585e9.26.2024.08.16.05.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 05:06:17 -0700 (PDT)
Message-ID: <5bc4655d-ab7c-48b1-b1b0-443fe0a7bd1b@linaro.org>
Date: Fri, 16 Aug 2024 14:06:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] thermal/core: Compute low and high boundaries in
 thermal_zone_device_update()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-2-daniel.lezcano@linaro.org>
 <CAJZ5v0iS+iJBsURzfeipum2ekPfxDGLKrotEkH10_FQhUKvbiA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iS+iJBsURzfeipum2ekPfxDGLKrotEkH10_FQhUKvbiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/08/2024 13:34, Rafael J. Wysocki wrote:
> On Fri, Aug 16, 2024 at 10:12 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> In order to set the scene for the thresholds support which have to
>> manipulate the low and high temperature boundaries for the interrupt
>> support, we must pass the low and high values to the incoming
>> thresholds routine.
>>
>> The variables are set from the thermal_zone_set_trips() where the
>> function loops the thermal trips to figure out the next and the
>> previous temperatures to set the interrupt to be triggered when they
>> are crossed.
>>
>> These variables will be needed by the function in charge of handling
>> the thresholds in the incoming changes but they are local to the
>> aforementioned function thermal_zone_set_trips().
>>
>> Move the low and high boundaries computation out of the function in
>> thermal_zone_device_update() so they are accessible from there.
>>
>> The positive side effect is they are computed in the same loop as
>> handle_thermal_trip(), so we remove one loop.
>>
>> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Looks good to me and I'd like to apply it earlier separately as I have
> material depending on it in the works.

Sure

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


