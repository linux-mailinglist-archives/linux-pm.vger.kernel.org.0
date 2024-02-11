Return-Path: <linux-pm+bounces-3756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21008508EC
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 13:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173461C21215
	for <lists+linux-pm@lfdr.de>; Sun, 11 Feb 2024 12:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28135A7A3;
	Sun, 11 Feb 2024 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvZkOLVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1335A795
	for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707653877; cv=none; b=bRw8Rboqvs+5WIlkUOX9K0IMGDOKJ9q1r0qnzwznsEmrYn8lSR2kQNk4um6/3tX1bKlFSEs1m/sYfcvNlEKvJxdAPDx7xqzGyIWrC8HyjdB7bn6nS81TMc2avB+1SPLRDbJdnQ7Ckme1RzVk0JRHesKqYQseGZXD0nnZnT7VYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707653877; c=relaxed/simple;
	bh=5lUkj6rY+4oKlNNAcSANf15C69NNpNSgeAy997Khml4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYy+Fw5xzvax56/BxrT3oD44YgDrOwr6dt0/dSsVgogN+7P5dZw6AbKNolBlJ2ViUxSVuowRovBOfd3J4Byu+qGvIu6fH16FnrOywnlB+LQ9FI9oNOjtdEXmMRnhvcFQ6e5MyUaqhSIFMW04R7nVtmx+nAdNCMftX0jQqzWMIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uvZkOLVB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410cb9315f6so986965e9.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Feb 2024 04:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707653873; x=1708258673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d0jW5neqnla//MKmuGLjHvxBXYvbGMfPZLm6LzCSLcQ=;
        b=uvZkOLVBPOZkCLAG0oXJh2VWCC709/tcbvw6MgsXs8b68cjKA/tQ5m/Mrpe+KO0Orq
         B1uRRFzCGcOW68V0oUar3+kEZwIW0MqVxITtOf8ySe6HEbLlcAPW98y7ZEbl72ivKqzf
         Qyd4gLal/h9wc9ONDXHRMHdfKWdTM6KpRCdD9Q288Vj9Zeh/Pn7sFR3BcbvUoEJGF85P
         jlfKMaDruc7c5e0Pl+Ubu5wHRK+IZ8wHx4pVPrKTGHiWtENzF6/lZWCcjlVLJf9hxCpo
         Q9gWWH4G4Om1fmMg9ZCsaUilAXClm2SJOCeZ9b4QbVN8tO110G6XaZH5SNGe0M21XdTU
         0CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707653873; x=1708258673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0jW5neqnla//MKmuGLjHvxBXYvbGMfPZLm6LzCSLcQ=;
        b=kI8e29sUM6mDDeEHAcwIg32wZhBhiQVBRpxP2aanaeHYUUG0nJ08/HjzLHAAiM4arI
         LkFZUU11U6a8ssDVQk0L7+4EhJe7kTKzFRG43IxFfrJhrs8nvjSeK/3TDAWvKWX7Yt3z
         os9Eu/z+2/mMzXtaiPJPOLe8xT7Q8CSOVmfxWFsTYrGvfdtiMayr1Re0opf6yCHmd6b1
         GsZ7PopHRg4A9/MK1C+vFG6Igv/Rx9nWztsrbp/m4Law2osuHukvwhP/8yeD9i5CVnLB
         5MbAT3gVTrcV91u7wivrDdjdiHCjSyVMJrc2nej+ruzDHLkKvqkPihIiEzhnYwSyxDED
         AEiQ==
X-Gm-Message-State: AOJu0YwcyJNyssqp6fp2nXY187HJmbwWL2BtGWE3nNuwXah3n6QECWLc
	a8JLzHsW6Msujo6q6O6S2RtcgfbRMmCC1qu3gDis9twVtCIoSkh0ULKTWx9YKi0=
X-Google-Smtp-Source: AGHT+IEeA2nVbNYHqaeVNvwkjjkpxzwwpgQOqSf2DrcIOVAI0+LTYTzeVtzFtcSuke5Jslqn0LHmfw==
X-Received: by 2002:a05:600c:5011:b0:410:c740:e771 with SMTP id n17-20020a05600c501100b00410c740e771mr712374wmr.7.1707653873238;
        Sun, 11 Feb 2024 04:17:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYtfgL7AXsbqrpN97ONcd13Hg8AxBmdDYH9c0wD3j058Wl9CPEkNZmac1GwOnTISo8siH9LmcBFDKsLrAq6tCh+KXWpv+RXAd0aDf4nZMrEXUtVbVjJG8nydWKiTA5szdsKV771mpPcWUoXN5a1iMAoemJe0fHLF+71LfBx97Gad1lJrx37tRct5CzVPOIrLIOIrx8SJcX0/Uzgwgeo00I/qx06P/m5Fe+5480XS9HXeLRM6cuqXYuh2fHPlpjjlpFsBWhNv69WeOP20B5M0bSK3ulOueUAW+deN1Uy4axMvQu0aZuR3uM+R1TYpPPh2milc5Cn5RFafFHiAsM3sbJ3+iC3z2Od5UrfNnfrjXR81VPWDry3iFG5b8Qf3986dk8+ZGMQIafHnZwc9KCOJUmtpnW+QN3hQAu/60QFA0s6fXHIC+D6SzH4zzOCSMsUNDD5tBR2+KalmQ94+IkdFy5ZXzkJX3bhoW6AdkZVUV4jOTHM59xdM+HVSucyPuNLUqWYCL+in6T3CKV
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm5708021wmb.25.2024.02.11.04.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:17:52 -0800 (PST)
Message-ID: <b81abbef-9612-4137-bc3d-7ddfb7a0cf3d@linaro.org>
Date: Sun, 11 Feb 2024 13:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add MSM8974 power
 domains
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 17:38, Luca Weiss wrote:
> Add the compatibles and indexes for the rpmpd in MSM8974, both with the
> standard PM8841+PM8941 PMICs but also devices found with PMA8084.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


