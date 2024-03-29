Return-Path: <linux-pm+bounces-5699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C41892182
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 17:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BA21F25CC9
	for <lists+linux-pm@lfdr.de>; Fri, 29 Mar 2024 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BF6A8D2;
	Fri, 29 Mar 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyunFQHw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFD285654
	for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729244; cv=none; b=qZyWGuA7sMbZ07NMPYjnLSHwp2ow31KAdUkEpze6onCgjcMzS7PLnw+8SqhU07SEhYzsRfHzYChduTP2lCNtcHChQBRMj60xuhZJA260HfkGP0HtBSPpEdqmPjOWLxy8ROrCK+6bhjmn5xIHMQD10OIS4BOPd70m02qeOmHXxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729244; c=relaxed/simple;
	bh=aNV9rU7rNrtAHY4j9cGg2iNrlDQzSv+NWW6nridB+o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBhGVmkoq785tkoaknOjCHYI8o2bSbvXj8BOdpfEdLcTxDASBE2GCQhnOHBT94X3Oujuhk5NRxNYnKP/iK18+0ly3PGwpX7Yy9kReAZkjAs1F0+DrAt0GLXqiIknNh19YOYXXerM7IQVlJlHvpo8L7YJyKWpo4pP1dsBPBr1A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyunFQHw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so24349071fa.3
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2024 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711729241; x=1712334041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nv3nKG3kt1KExo6n8MktRZ2ubBO2o5feKCsd61d5ipk=;
        b=nyunFQHwBy0+TCKUoThhWMuGSOkvKrgYWjmJKo70EsExNouwEVj0aGjD8CfFDPt7Qv
         /dE3ql2uUNCVAQWmJhGiasfTx2i9t5sgaEUhehcQzEOE0sMuig40bp4XaHxDbRTMQksQ
         p4aRcNq5b6xXLpG5foe2Td7Vh4Opey44p0IKHT5sxFBnfeGPUFosJRaHm2w0l41/BHa2
         LEWBTw5OYmsL9JzpSRL5ZEF/e4o8rDlTNNoaFH4DArKzWv0rvqKw8v0fgB4HRcpLWf3I
         N395qSRmpKa9QYVzrtgl5eewTxVS056hZqTMcQrm3c5SbZfKGh1mn5sdQic5eiAbX65E
         mL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729241; x=1712334041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv3nKG3kt1KExo6n8MktRZ2ubBO2o5feKCsd61d5ipk=;
        b=aKdOaGxFLVyEfTtVeURQpxNLUpnfXLRDTPC6v1xBTFct+snOdUxvl1ly4g5nOW3v/8
         t1CfKi6sC3iK6I3wzk/OHk9tcfD4caDvTinKSpiDtly/9LqXYNBbz5nVoFmkfVUKeXWd
         Qcc/A+Fj68s1P2rqH6rUY9E2AL8cnmBmjoMQF6uiVhDKmZXT9ME3PMICI1UhbOK2Tkl+
         UESpaFPzUF6ZkTcEKl88XfSp5SUvSHg5oHwDjNDG9hMRHbHB9Vfl6CSRR8jj/HTchFCc
         iRP3AM4hn9vUAtYDDs0PuP9oiOHvp6tq8CXoeusvsv9aTSa3LxkdLWfoIQrf0IrF8+GR
         UW1w==
X-Forwarded-Encrypted: i=1; AJvYcCUjPmf7W8f63PJmCRFEQa2VJKgWptP16X41GVQztAEL9XpWcIu7V+F2VpkvVyucD0y7MpUclhhXxbShK6H8r0k7SeruzSPYICE=
X-Gm-Message-State: AOJu0Yyd0HeC2c3PtJi2deI7Ceg5kZulJu+xll8jv35b5G7OvvCKznlf
	CbzeQPYAoZev8Mny3PJe/jDdB1rc0Dm1GSHLQoI8d4L35fS5DESc39/vyyCWU+0=
X-Google-Smtp-Source: AGHT+IFkqPrhomWaxduOdYh034fYe2OmWOQleSdfiah9gsEO+++4wFQjI0nbDJP5t3PvIV15vROuyQ==
X-Received: by 2002:a2e:3c12:0:b0:2d7:1731:191d with SMTP id j18-20020a2e3c12000000b002d71731191dmr1357519lja.3.1711729240746;
        Fri, 29 Mar 2024 09:20:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm5964877wmq.3.2024.03.29.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 09:20:40 -0700 (PDT)
Message-ID: <16999076-4ec6-4193-8a90-40a3f530a0b5@linaro.org>
Date: Fri, 29 Mar 2024 17:20:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_manafm@quicinc.com
References: <20240328050230.31770-1-quic_priyjain@quicinc.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240328050230.31770-1-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/03/2024 06:02, Priyansh Jain wrote:
> As part of suspend to RAM, tsens hardware will be turned off.
> While resume callback, re-initialize tsens hardware.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


