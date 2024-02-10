Return-Path: <linux-pm+bounces-3747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4598505AB
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37B6B21567
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE05CDF8;
	Sat, 10 Feb 2024 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHV/hj3K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9055CDE2
	for <linux-pm@vger.kernel.org>; Sat, 10 Feb 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707585555; cv=none; b=UhBFjyLCQR4YQqVo2sYAQlygsr4L4e1TEihmlC3WSJv12+h+zmj+d8AZr5HfYSZbv/tMy9ju/UoGklAHeWtJJsfWDga6Z4JBTLJr1rtKUr5znb9iSicIwEqEGa3yWZo9v2Xz74z/14efjiKMl2uPRXa7Rc0kRqmHUEKTnLQlMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707585555; c=relaxed/simple;
	bh=NYudsIGjRm27pkmw6NfIzTDAlY58kWaMj/QkAiYov4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnAmR9FikTLfH8DsQg5ipLFblcUNCpBNxnLjBZJIA9ZK+mlGpZnpEthPZ7Evx1L+7QB8Z0IDPqCe1shyS0llAT14QcKZcLGdJEL+zii2WLVynHJPVQ116RWAGilVeaEk5hDY4SJAwa1uEFCSgxsUALQtknJkbV7pdZ8n9CPBb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHV/hj3K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3566c0309fso230581266b.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Feb 2024 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707585551; x=1708190351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPPfoSPtlGq/Vz0zCl0yTdi8JSgrSbydPmzP0jiNjJM=;
        b=FHV/hj3KVFn2TW+vxL0Cb08qRLakb9PQaR5QvIMHACKWybvRnsGtagyk8ShF6Ub0NU
         Pu6wEbWKgYYFJktaUoHe/cVWZubDoCfE4mSEDYMunUWDPuQpvv7f4orxIcgokHNevLAR
         ZOXvXJuyBTdzaALSyEzjANPj+6rLk52dYyoJtLT6e2q0u7KZ1cvsZLMipoCwWv+Qf6T0
         gp/VIYRatSJIizSG54747J9SgMjtNJpKitwMYNUvgPQwYXhazGXA8pGHUPLSi1XzacAp
         fVUTVfkA3SnIcajD2UHzTeGwRqhh0DVHRjKAltlPJW3cTSZPpmef/Hh66l4ZHEHy51lP
         mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707585551; x=1708190351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPPfoSPtlGq/Vz0zCl0yTdi8JSgrSbydPmzP0jiNjJM=;
        b=XdHN6x13caWLfcZ0DQRqPrzXCalooLikRpJkabW/eUEwrCO5MOaBysdVq6qDuicF5I
         TGdCpBOxVMJ4/cdMkxq74iJtlh5s7m3owXHpnEWp7RvTQV3rBwo3kHToaOOheLaiI6kO
         Vj99VTqWjvsIZ/wRphbAjTQfiOygyLCik7I7dUVFAbIc54fAKEIb+k9VegmpDNoAIHWs
         Y3E+zhyWrqTS0GyOFRe/pfeUvfFwQKiF0VB/4mGkwoZZ+pFWoyXaksRlt+hkO7WcFf55
         Whk/jzVE6tk5gzsr0Y76oDgejC+jXZ/plRx9UzbBzAka/zAbTVADRE0dOMnu0FUtGInU
         DGHA==
X-Forwarded-Encrypted: i=1; AJvYcCWte1f71sDazei7gFAh7pshzv7CtX/OasW43bhoW6lOpBqGFpqyQNC27Knl7aurEskEvR4l1XPLundbJC0fYl4uqCC2qjif35E=
X-Gm-Message-State: AOJu0Yz2tDvT3qRp3D/+pU3TvZvxjxOiFsaN12Tg2JrvGjalklSUm/Q/
	UpGB0GIkVmEOWsZEOKvFcPGiuQFYM1i2wMps+Pri4yQjLudufY1EUlOxrynulEQ=
X-Google-Smtp-Source: AGHT+IGf3lJjgMzTBNliFCNzGITS+DH/YyZWIGQY8pBo91UsuBBfHuCnnxy3Ge1cjbhereUEyz6q3w==
X-Received: by 2002:a17:907:9858:b0:a3c:2146:a0be with SMTP id jj24-20020a170907985800b00a3c2146a0bemr1531701ejc.70.1707585550785;
        Sat, 10 Feb 2024 09:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8EHLrQDnCbtgF7aPp4Tys6b9xyplZflPIlITe2JUzkER/f+TZ3YW+1QuqWab1ZqVx1hWI7gDCToCTtN5IveWnTIYJkgjK/tuD7DbIrM+PlbCrnLZb2ZnxXi5br7FA6Ax/fYDYrlQZu9bEpqxG5O0sulZvU/lnBUdb7W1Tn8rqSGvmcLgAj6jYcMvpWcHks1GSDS7Zt83ulZ0qayIbguRXhhwynGXVjfbWcnsGKf40pKXfpjcpUdknyP3YW63EiKCIA5a9HC2soubhCIC4Vt/vWmbkvCl+26UoxHIKYS3bLhfLjNRui/59vNhfCmE4LNF+bPnNy7tuuQstPRFaf1FNnMB+C8muvUhYzK0ZUIQm4PsqHgAb9OTAyEOgDrE5+xBvVCJmRAodWRemSO3U4RYgkSaJv8xpR9XndMFRZf9Hh4CssNMlKU6mEAFaXkX8DY9JvH6oBfVHS8bh5ocXoNJVlRR7LYv6epgKPfXcPQuW2A==
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3c5fa1052csm64186ejb.138.2024.02.10.09.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 09:19:10 -0800 (PST)
Message-ID: <7b1a0b84-4a4a-43a4-8698-d22f883e6318@linaro.org>
Date: Sat, 10 Feb 2024 18:19:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pmdomain: qcom: rpmpd: Add MSM8974PRO+PMA8084
 power domains
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>,
 =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v2-3-595e2ff80ea1@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240210-msm8974-rpmpd-v2-3-595e2ff80ea1@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/24 17:38, Luca Weiss wrote:
> Add the power domains CX & GFX found on MSM8974 devices that use PMA8084
> instead of the standard PM8841+PM8941 combo.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

