Return-Path: <linux-pm+bounces-13758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8096EC29
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 09:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EA91F258E3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A99154C19;
	Fri,  6 Sep 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB0wo8oG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93D1537D4
	for <linux-pm@vger.kernel.org>; Fri,  6 Sep 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608343; cv=none; b=fu2Oi11azWXP3cm9zqWxf8sTkOcBjLlQKPWI0pZfmHLNDRYTdHLYlTWkeQQWsEd6MlbwST3OsAATd3odN13fgGGDFU+4UPlTJR3txUlztDGHFiglc460bxTcaZGv5j50fa9VP9dynQkcGiQGpZ3xga/A4uiyVB4qFMBzeC4nXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608343; c=relaxed/simple;
	bh=/VfN5TZBKFESX0ktdJnLpkP+3s1XJrbvW7+e2JjstSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMghxj7WmLQtA8pb2S+INt3F1Zm52tNx32j1kIropDG1Obe/y9f+CQ3alpnLBOlHtQXgd1ls9Bf0i0PxToiWvytTWY6vFngXyHg5U/WeIgpM1TuSqUmN2Yqqil8o2dsvuhKhaBbCL+/QvmWnYZ4TYtui9zImLt8jm9R+jos7Eio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cB0wo8oG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374ca65cafdso895983f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2024 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608339; x=1726213139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=cB0wo8oGQ4gkqzsJUvwKF2bKsP3JPyJcvK8bOlIjlrk+jEwF2DTaekiQ5x9nIxU/UZ
         HaCsFa7RX/okxuGsDJAAUa9wIbIqORlQfJwHEEqjhATDZFBZXnh4K0gjB8TM9nBNytTH
         Lpx4ZaujIBV1Y4PChxe/m+H3cnhkvFDulli0meNFfyNDTGKB6IYEnbfb+WZVDITwgwyf
         Mtg9oW5A2dL3K3TxhVhVOTy8lY0hnWAOlVabsmGFF1FagxFC2iQ5AdRCVdjFdzQ4DQI1
         aRafG/lG6ZWwZAaCW2b0/DfSRhZ0jDCKGlajtSZAp+/RjNDaPd4p0xjNgqps9c0zsTCp
         8UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608339; x=1726213139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=UsvaFIX+CCRX/JN8XoLDplPNHKf2v2T3OsApJp7qz4vi3ZXFP3UikYTEv04x5mFD1L
         uRzWEsN/tcAYhDkS0ov6iRfdt0pm1fN6WF8D7q82L2d2QDWNGNXe6vtQoPnxUTVVRPqD
         x65HdOMR+aXOplIBicAon5GyddgcFTFI87p8CWMoBPh/CzkQCEJu7uxpzcjIUXN67D0K
         Ii01D4nB1f8rXK1/uS2s9raKTDe1Lm0pnzWwVmq8Psml6EvhCC3ZuCLef7sIZQqPj+2v
         kMGEx9DQkNtC61HodHGk7kjSLUm7WsH4OWicV6zbbnkG/JjZOG4bDB6GVnL+T9F1t1H+
         SOVw==
X-Forwarded-Encrypted: i=1; AJvYcCW37otE+jz3JrBcf0KcEdxKECgD8JxkqjC3rGjl1/PovidaCNElCX1JQiounaDNAmhd2LTqljBpfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P+PVcJb+b5Py+XIWTUJAg5SiG4WgcUeIrwfnD+PFVXgAinc/
	NGul+Q+cM1U/veR6mmG792d9F4UJF1Kvr6h7YTFHpfHC39jrVkmszy3uZdz4cXQ=
X-Google-Smtp-Source: AGHT+IGFHwFQ99mHOKHLLsrCtuLnOv+VrrxaTcWgKFCATGwuZhLv7Zk5Z474pGF9RhYDinH0QTPZug==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr16000044f8f.22.1725608338871;
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21002351f8f.62.2024.09.06.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Message-ID: <64758ccf-7ad4-4490-b938-864ade9ae74c@linaro.org>
Date: Fri, 6 Sep 2024 09:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] dt-bindings: thermal: tsens: document support on
 SA8255p
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org,
 cristian.marussi@arm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 wim@linux-watchdog.org, linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 kernel@quicinc.com, quic_psodagud@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2024 00:02, Nikunj Kela wrote:
> Add compatible for sensors representing support on SA8255p.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

