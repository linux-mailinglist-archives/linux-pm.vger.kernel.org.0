Return-Path: <linux-pm+bounces-5191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A6885F5C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E4B1C21970
	for <lists+linux-pm@lfdr.de>; Thu, 21 Mar 2024 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADC14293;
	Thu, 21 Mar 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJ7ErXh6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5B79C8
	for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041220; cv=none; b=KwxgclvF2kcbWUYpPwVw1rBvJg9EWRFtcAZQYIqFkrvneTH/rwoU4HOyOzhOeyfmshWpHzAVByV36WV+9FJBdAZN4ShBPBJQ6q1U4ThwqfhC6L4XyfPvXfiNiKUbO26d2APL7fwfxDUnw3jj/Q9x6qWkZg5M5WCPAbY4qYhF8Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041220; c=relaxed/simple;
	bh=nbLcX62cPthMQX4Qi4FmqBnPbdHTCG4g5NU9t5wEUeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGu1GZgFzi8jOGAM6ta+V7iGaRoEJ0+JiMlJ7KuM/FuALeM3GrAFWN3KLwPeIxY5DVEBw7AP/bfrAZ98ufPlDewPZNqTvimawOIw1ltqesaqc2nulOJx5bl9kV9yL8ZMx7w+1w7FF8xqd6BI4l2rkPKq7vAt9+eInLsimxfwx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJ7ErXh6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4146a1ac117so7771545e9.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2024 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711041217; x=1711646017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAz3OstpG6j9xCZCUuIzQog7xNqfGHCkZ9dDarEe+q0=;
        b=AJ7ErXh6cSJIYH8Yr0OqwxsjlbmfuG4C1SqbkpwdemXscpFLLPoDRUTkzjrdax/3RG
         fJd8aQzyk08uLY/zZB1OpU3235R2KhPdmr6MgDA2zTg9LjOuvdnDdn+sbbFlOZzktLuH
         dingCteuY6BEdKqaq8bMe2q3p2z/G633fCOXYo7qauhubHbZ6s8aK6/hRyhs8K7yWk4m
         HK64c/297leBYCeo7wN/WBQKf4hdskzzMU6R4L6gG0u7REuimOk+ed7XwD1WEENEMmuA
         3wGvkvwjOixHsD0YxoSNVM7OdyudFz1muwqq4HsBJzi8C75yHZIKLB3FHgQzKdExV16J
         QCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041217; x=1711646017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAz3OstpG6j9xCZCUuIzQog7xNqfGHCkZ9dDarEe+q0=;
        b=YqxvrF3ObQKjh9E7XoTBPBoe2Lc0waFGSY7WgfqwJsMtzKWGeuuWFDtXc5guGAWzNT
         QDWOAvDtxgtatfq2u+QVjvxC7G2xNi6PytZjgeJGMRMGFF8XWejZHUDbT1dHrb6cAgay
         Ih3QqMkOaCk/p4Rsbm8LxMhh/a3NrNw5AaDuv7y9zRgvu21x3+nMDjSrHkmg6uuqXATo
         6Jr5NhdsWKQS8yxElkCinkda0Wftn/yvMIzhw9P9Ff6SDs7gcWSUkqk5Ck6+sqETIicF
         L6K+3hqC93BRDRv5a+sGkdM7Qh6JW/oqPxgEN4xidfIvoDqpNdpqWSERbYqnxEgUmfM0
         RjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5uZmVU0p4RojYzc1xqucAVwSsj8N7Aos1rpDrIkHjtCcVUpHZTNXI2tm5mb37qCTw68f338EsF2Ji5o2S54wD5ulGIJES6Pc=
X-Gm-Message-State: AOJu0YxNbhsLR9GUyG4o30oSMeyN3d6ssdscS0+ygQvW4lTLH3GClpCk
	DctcuOHiNLtgVSGCyyy1fnl+029q6xq1t4pCzfRokVFBH3QKCzevQpObjrChf0k=
X-Google-Smtp-Source: AGHT+IHGLNLL349BXnrL+pVbNZJoZvK0Ey2jr8uASOGhJYzP7p+CqXSref151LDcL3zidgrF3XTzLw==
X-Received: by 2002:a05:600c:4f84:b0:414:61d9:d1f5 with SMTP id n4-20020a05600c4f8400b0041461d9d1f5mr152054wmq.10.1711041216934;
        Thu, 21 Mar 2024 10:13:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c470900b0041409db0349sm333276wmo.48.2024.03.21.10.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:13:36 -0700 (PDT)
Message-ID: <9d9fbf45-296c-4571-8c13-6b9b1cc37d14@linaro.org>
Date: Thu, 21 Mar 2024 18:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: lmh: Add QCM2290 compatible
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <20240308-topic-rb1_lmh-v2-1-bac3914b0fe3@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v2-1-bac3914b0fe3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/03/2024 14:15, Konrad Dybcio wrote:
> Document the QCM2290 LMH.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


