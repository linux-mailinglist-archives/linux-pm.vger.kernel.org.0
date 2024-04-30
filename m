Return-Path: <linux-pm+bounces-7349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB88B73DB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACD81F22502
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2024 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CE12D768;
	Tue, 30 Apr 2024 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wteN+2xH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBAF12C805
	for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476242; cv=none; b=T4L31nF6IvSNCzxqkWAuiWg7DBYxNIDylGFbiMouUfnmxXQq6vVvvpQmq94qCvzwlMZLHOXbeT41/AeCV+wButNv4kNAZ0V2HvniVBxwaZYXosQ0PG0fXYYZF6tXgngBiwkppq8q0RsHI9D+S0RtPIxxvbddDaQ07HA1JjG4Piw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476242; c=relaxed/simple;
	bh=Xc/E1muDcRTkULpV7kIzSbWB3pDGQ/49fUGW3LpDLU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BN7p0sn70b9N4AKio0XA3cr7La122Tx+MErUNOo41mS03o2ZXuJ4KBnuvCRqC9n6dqdpXieBHjLH4hbX7qCH7qdY2M4PItH3bwK/1/ab582gd5/QJoSzt/z9gZIVEYVyt3YXf70pOW8YgAYFYyJz/e5/DN6tjyBLQjufeyNONxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wteN+2xH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a587831809eso664657766b.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2024 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714476238; x=1715081038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWLp1lMkRn/z9F/qb1rRBcveVv86YGGLdJozbQqO3w4=;
        b=wteN+2xHbalmfFAhfIYncc9nUNXG3OakploFfLqKyDj5sYIQ/2o1lJju8YtzVrq67t
         yqG33atk6u7e9dj0XNA6S8yyN1dmmHtHJs2+HCrhMdn7AaU/LyleeU7FuSbNB8oJVmKS
         8D8fpVzAscJEJPQpjk5gIu1u91kG3vEcdru2OtPicMawjpa85Tspdcm8WlgtLaYwNwx6
         DobvZb7fQVrb+gp161Hu3EB9fmKTvNr7/LdXzWXMDdWdu0Kgw9QLL5bs1TGQJ83Wfknn
         v1XUTx4gnMI/z/sx1+XpIN1Gi09NE1qFN7jbvY9a6COHxwYG3PtnMf2WyXfOoQiRvbV6
         vODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714476238; x=1715081038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWLp1lMkRn/z9F/qb1rRBcveVv86YGGLdJozbQqO3w4=;
        b=swyk593fZB8iXvyJH3WF+49kMOHWLR1/1XrKeHbTTEtlgKSoa/PHMNzKNotZzhQyMj
         TSSEfoQtVn5PUhjxJrksNPhaduTXA6VU6+NZLPoR6J7LDliMLWCqpFECawfRaU+0WUed
         9rKzI0Kq83+13ZgSUR/+k7PwEXrX3UtVyOM0fyr9TDm7f68r/ky1ocPnyhCP2bgYxg/n
         2kfHTNBIwy50umdJefxG5jRit9Cfr8QOSlClECKTgjy0zgEN7CJ1P297GmumjHhdtJdC
         BYnH7rZB0HUD/pGwmIsp8COt9AbYr9/bum6AV6iDgY9q/i9pX3izmnGTCk20mnRdh3WZ
         zqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkcXTOjW3kI3yOgW1EFerrN9A3LIZ3pS6dOXCiUZ8TJyM0aOIxEdTIyw1x29+EJa0UAGoEtJ3O9uu5lvBs7ADYuMBQpaH2IrY=
X-Gm-Message-State: AOJu0YxOPVSynMtfoxK5GXChnQx662jOiTtQv3lrhOSqOPOJsOnJmprU
	6j2i5w2JlHsHP6TtWgnxEMU5XC0701z3564R700u1geGGPxF4gnYfnIBf0W7bOE=
X-Google-Smtp-Source: AGHT+IEDXRI6x5rnf8Dk6QVa3UjpA/rv05QLyf2+PdfnSyuNQlVzzUXFdifCUi0+BsM1CU66n5It8w==
X-Received: by 2002:a17:906:1113:b0:a55:b7b2:2d42 with SMTP id h19-20020a170906111300b00a55b7b22d42mr8852366eja.24.1714476238348;
        Tue, 30 Apr 2024 04:23:58 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906110600b00a5827d2f6f4sm9482718eja.115.2024.04.30.04.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 04:23:57 -0700 (PDT)
Message-ID: <95760e2b-ec38-4f04-8f86-e4f935d24a83@linaro.org>
Date: Tue, 30 Apr 2024 13:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] sched: Rename arch_update_thermal_pressure into
 arch_update_hw_pressure
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
 andersson@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com,
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
 corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Qais Yousef <qyousef@layalina.io>, Bjorn Andersson
 <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
 <20240326091616.3696851-5-vincent.guittot@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326091616.3696851-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 10:16 AM, Vincent Guittot wrote:
> Now that cpufreq provides a pressure value to the scheduler, rename
> arch_update_thermal_pressure into HW pressure to reflect that it returns
> a pressure applied by HW (i.e. with a high frequency change) and not
> always related to thermal mitigation but also generated by max current
> limitation as an example. Such high frequency signal needs filtering to be
> smoothed and provide an value that reflects the average available capacity
> into the scheduler time scale.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

Hi, I'm not quite sure how, but this commit specifically breaks booting
on Qualcomm platforms with EAS..

https://pastebin.com/raw/1Uh7u81x

Konrad

