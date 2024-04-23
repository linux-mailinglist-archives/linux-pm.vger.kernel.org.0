Return-Path: <linux-pm+bounces-6944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7D8AF51A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 19:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50E21F214B3
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE213D88A;
	Tue, 23 Apr 2024 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAv56pZz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0791208A9
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892051; cv=none; b=Cok4s5gOVKvwr8LhQMJsvEsdjQ4LUR2AC+sy2ngm81atowFthNt2MF4YXChivkVn44qnTbewavaVAREd+wpG8EDVcZlOYhXk8EuLVKLu7j+So/UZzcK6/b9VKl2k4wp9srODWEq24vYKPktVXkGCOszOywSFMtMqS2XgXZQUfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892051; c=relaxed/simple;
	bh=OJsYByUD3LNRS3bWHtD41r+NIo7O/sk/Nor9aoUU1Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJusM7HseTAFFRtk4i2jraDksOPGXSw2NdbTCTb9t5Q0fHHhzZSwx8sjpe+HxsxMToBVNCpNAgkAmp0m2dLgaTJw3Vr8Ugt8yYNSoi0LXWRj7FWtH10nYyE4Iexek2G4o2iYC4zwACk+EhFbntIUsz17GmJVCxT9aggQfAwRDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eAv56pZz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a5b68ed4fso19860005e9.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713892048; x=1714496848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Et7uc9uB7/VGTIfESDPlqhtnlO3orPAse6rpYiRLH20=;
        b=eAv56pZzV87y094K8uk0AeO5ZeCnDs3UfQ1rioQmBcdObuNxtcsHAYuipJ0uo+A2TA
         hdnPXLW1XpW3U4fibww5IN4410S7hEZnAo8b/o4hENi5WQd/AaC3NC9rEzO/MoKhnso6
         NQxZzoGaX2eNI0sdN+h+WVumWpz+M+bEC/ko8EQFS22qaaDed1+32dfhUHu9G42LYMHK
         9p9HhEofwKn3aWEyKRdS3jPWJoky6e/48SUozJgmTiBXG7sJ8jxs+w9nNvfrwexx4hbI
         xgMv7ggiyjNl1ihZc1qbRkTcW2uaILlayfeu5H2jj9FueJOHoK5Hcjzr12zUkASVdiGj
         YFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713892048; x=1714496848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Et7uc9uB7/VGTIfESDPlqhtnlO3orPAse6rpYiRLH20=;
        b=UP6NiNSJ+KvEt/HISlw+qz0e08FmAIEiKASNGpReeOPy8i9Zn5GdJ+BW/tLm3foqju
         +Kv8TnPURqw4GZIR+W/0X3cpWK5TS0W8wC/5U/5fNCFTDF8CHBeOYJgXFGTEdyVR+jSh
         0+gHPouz/hNwlK6IP1KAliacMAcSndusD6a9fROx6VxZpw8cGOuT5QLYORsip87knvUA
         j+S++VoBtppjG904OukIV8zWLyVKQMUY9dU59ryHdngJgw7ei/1mVu20yotWELUnIy0Q
         YlxyIutFY9A3boavTBuL3ZfjDTaEQB8bAlcPK5IDHhM0mxNughMgd57Xjvogy9hVifsZ
         vCug==
X-Forwarded-Encrypted: i=1; AJvYcCWhOUkfJVgZCA9/l7LIMnXrg4IHgO2aMQEtSuOa0qaDvnj/DdyHMtFjROGFFNeunYAhiMmhRKpZ/MKuS8LPHXFnw2+tzlbah0Q=
X-Gm-Message-State: AOJu0YzXNHyZ4k8xIiOzJxFAZR8XnIvhe+ImMAxRI3lxeUUwXgyR9Vl9
	HeZKLoYryovKvmJtZ5rZM2y6BNDH0woF/ijaqsj94GH2S2PBIKDPejifFdNomf8=
X-Google-Smtp-Source: AGHT+IGnfx7SGBEG13M62kObr5ltZE6xf2dmLgiuksEZ+GGVGVFtbjr+uO+OJkvSJ2YdUlWWI4rJHA==
X-Received: by 2002:a05:600c:4508:b0:418:a17e:cb47 with SMTP id t8-20020a05600c450800b00418a17ecb47mr10016949wmo.10.1713892048119;
        Tue, 23 Apr 2024 10:07:28 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g9-20020a05600c310900b0041aa79f27a0sm3735054wmo.38.2024.04.23.10.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 10:07:27 -0700 (PDT)
Message-ID: <e1dce3ce-ebb4-413d-bf8f-5faeee5123c5@linaro.org>
Date: Tue, 23 Apr 2024 19:07:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/16] thermal: core: Introduce .manage() callback for
 thermal governors
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <3242862.5fSG56mABF@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3242862.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Introduce a new thermal governor callback called .manage() that will be
> invoked once per thermal zone update after processing all of the trip
> points in the core.
> 
> This will allow governors that look at multiple trip points together
> to check all of them in a consistent configuration, so they don't need
> to play tricks with skipping .throttle() invocations that they are not
> interested in and they can avoid carrying out the same computations for
> multiple times in one cycle.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


