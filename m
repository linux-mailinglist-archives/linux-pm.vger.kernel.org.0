Return-Path: <linux-pm+bounces-38536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F9C841E8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83FA3A7CC9
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871D25A359;
	Tue, 25 Nov 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDuuYrk3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61B185E4A
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764061255; cv=none; b=PFJUYlWTKo/TD5CAzKovU0ZqEo5M5VYOSw1UbiQiieX+mHTVJy/+afm3K2FNPI8exPIoeuRRWX1RE3MAE3DXTIidTvpl0/8Cx8RDXoX3yJdW/KQ+5JCG8YmDkJKVZuVlJO/vtNVmH8NTwqPqzxJRR36PTMSL/k/0NsxnzRByIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764061255; c=relaxed/simple;
	bh=dk6nkfYiFAmcasODS1YyCKH+/FBpW7aSup38ZdC9cew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxIu+85M6hwpDHRNRG0WHRWdPKtDkAcaSddWy8PxY0ZwSQr7acy3epKJHEo6tpTdsFPMzbRvgEmq3HsYVqyoNHtHKMMjf3+W+H8+cl1YazUEG9LYS2SyOBS6Bh1DF+gu8am1mu7CnzwCwJ+3CQYZpJFAeqiJsRqLmMqu8lwB8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDuuYrk3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b31507ed8so4417117f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 01:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764061252; x=1764666052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TCEDitzChtc1KTVtUsK8wzF8EeuAz+wThYhGWzqzcE4=;
        b=NDuuYrk3CKWxeK64juOTZ2WelvfZUAAnFV6v3O/OXF6jZIAMiHVwQYybjWU/ar8ADn
         iEuW2Ztby3+JcrbVLNEBOfMEUI/0K3Lrl0CW2Som1qZMIkewzSb4tle22kyauXJ/Pjhs
         7Uzmg4sSlljxlGn5tmYzJ7rMqCSPnKXXcOx/PgVoCGAKottvf886+SvvlBrGXxZuI8kX
         5gv62IQUJgapQRFq0WHyiwr+aKPQjoLHn8Vymz8PbMr7txuydwDKckL6h8Flc9Xwx2+6
         TFXKWA4EH11p/hjifHHSx37/Qygb/xxwfbulef4WR0R6tm8XH+cGnXcs/TmKqbQBXqg9
         xLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764061252; x=1764666052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCEDitzChtc1KTVtUsK8wzF8EeuAz+wThYhGWzqzcE4=;
        b=L2352BsDucbd6kvad3L3k2Ph7pi66z1Txjye2unc+tQOroULXHMGB4TxrcvQn3j7B5
         LzyZ2NrjFAR11bjMVR/pq3+LvyB4pLGqX9Lbc2mBNtAS8m4UV+U70ob09NahbaKt44OY
         XrSYtLeW8WUDAIxtaSbqSRSFHSnBwEi+yscn/Cd4VD9zr4gF062GcBho/YIkMPVvMXjt
         M9X/la1q9IkebXguYAYE+CmbIJo61/SvIeYmRX0UmSUlHgr7HmputU65cA2SNJMKqV6M
         RvxHXgzHaNR+xFoIl24IvISjgOj3gM4M+xM6eN7Gj3isFk2Xrz6mI3xVE/DqI8mQCY/w
         8Qtg==
X-Forwarded-Encrypted: i=1; AJvYcCV1fg1Le0koLp1OIWJArhFSf+8KOOyr9oDL7oBiW/GFkCrOWBppkxmcS7d29Jp4azJ62AwSmYPjNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrS7vFMGvizY+5cMHqAKtQO8C46CihQN7gMsw/OhlxupUbu6Fu
	XJNOG7kK/+f888jYkrLhR8IUUJLt/ZyYuHO8EUgQGwcHmYIzZgbNBWHLqQvTca4iS/Q=
X-Gm-Gg: ASbGncuBMwaq8JBP2GmkLnzuVLzg6wO2C7hHwf47I8oJzGYPRskJ3J8yGUntohazKxw
	4gbCMvR8NORS5bFQRf5GhjXKv2+fyKE3opTegyIMIdl/jJMcgmQ+3Ic1mYdawF2NzWtUwH51IJd
	dZn+t6+lqWp21q5c/U45A+XuDhJmmBMb3tdVsI4AOTRODG1a9ViOybptAZofpf08LuG0jooro91
	u5xjlh6vVeEZ15zQAZ5Qv8Cg2sRwRj8XPCeMCRysKulY+aGwQwkvbHZxshPD+dBthT6mbd/WCcs
	ktlnOIEMj4D16o4VqbPKRcB4/Yj5f9j6lBR/4ytDgw9EV+5aYeyZYmyV3KfP7OUXV3mObuQg3xh
	4TNq2wM/4hvmlzc71F4Oj9/EMvV2LhaowVm43n4sYatDEfPHUHyBSmPo1cO3M8QU91dWVs/9/zn
	qFIGePkEyzTbGz0d86PxIqNel+tqQgmuiBGglziLvt5KJSgYia94kW4fviPM4KYphHnRSyBm0Tp
	6rW
X-Google-Smtp-Source: AGHT+IEDZw8Pg29oAjYeXO9i7AFpBJlOFkIHHzqN0kQJFDAhwljS32TNpCpkBZUG4s7krs4HSu3QfA==
X-Received: by 2002:a05:6000:1845:b0:429:92d8:3371 with SMTP id ffacd0b85a97d-42e0f1fd01fmr1916943f8f.11.1764061252074;
        Tue, 25 Nov 2025 01:00:52 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1d9d:2362:4539:c68d? ([2a05:6e02:1041:c10:1d9d:2362:4539:c68d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9022sm33018480f8f.36.2025.11.25.01.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 01:00:51 -0800 (PST)
Message-ID: <d53b5b10-00b6-48bb-8d69-660cbf757ec2@linaro.org>
Date: Tue, 25 Nov 2025 10:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/thermal/thermal-engine: Fix format string bug in
 thermal-engine
To: Malaya Kumar Rout <mrout@redhat.com>, linux-kernel@vger.kernel.org
Cc: malayarout91@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org
References: <20251124104401.374856-1-mrout@redhat.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251124104401.374856-1-mrout@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/25 11:43, Malaya Kumar Rout wrote:
> The error message in the daemon() failure path uses %p format specifier
> without providing a corresponding pointer argument, resulting in undefined
> behavior and printing garbage values.
> 
> Replace %p with %m to properly print the errno error message, which is
> the intended behavior when daemon() fails.
> 
> This fix ensures proper error reporting when daemonization fails.
> 
> Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

