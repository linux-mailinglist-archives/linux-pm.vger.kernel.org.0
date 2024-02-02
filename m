Return-Path: <linux-pm+bounces-3232-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24E846EE4
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5E828600E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BC13DB81;
	Fri,  2 Feb 2024 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/usk+jU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A041386C4
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873390; cv=none; b=nFJtqngueVTIEqoBqhsmEd9pK0sL3Yfh6ewRZEIey2HqvPonZBPYkBJP1owWRoHghPNVwZqVNb1sHrGgeIDTFS2tre2JHJguZi+D5TnEunSM65wu9XAsc4xnvcGbbfoe6aL/yEfJe6XV08yT6XNAZMNV7lpPOD2G3z+y9iWJets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873390; c=relaxed/simple;
	bh=wRaupfdDN5Yzp5ZA3LE137yzB20RBWTUr0WK4RzDf/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gW9dXgskKj+dfSuIDnQJthq+Pf1F+V+bWBjNZ1A1SvWRhcNKQSh/dL9tr7Efbd1LaGoJU2JIGbiXSRooj33qg/lFiiyniwwQagLx/rEbOUUwAOZ5vTMEmwZuHp8FWZ6yZPE+iuyA4fhbLg1mv9ah3Pleg694pSQDCyIlnAKHNog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w/usk+jU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a349ed467d9so254715866b.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2024 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706873387; x=1707478187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=boRIbhIBKZr1wj3BiPtZWLlLPrdzfxqCr9dSkCtVISM=;
        b=w/usk+jUbokAkRjxMZROPVjNqjuW2gvGtyHjKxvECYHF9q1y1o2FHdfpsElMrMuqn+
         C6ztrbl0tGHUszZ/7DZefVm7L1slfyABDyuNhLgI5Nm0GARIt+PAGG7j8XWFmagSt7Ty
         IIBPHQaFxMQPz9Q/is5XAXbSZM8dXwXHyRhPzBRKlEWVeUyvGUVr8FGhOK0bBuIEJMSn
         quFbVptIEsPrwFy3lVWtXbp7sPbUdUrBGIpg+QiHTJAelFfVb1EyRAh2GHiLtWyEc7IF
         iWnDzyu2Yf7suv93W38oVOZXFpkuKMWoPIdbf0QgF3izt8HxrjbXbG2Kg3flgcOvh2do
         rR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873387; x=1707478187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boRIbhIBKZr1wj3BiPtZWLlLPrdzfxqCr9dSkCtVISM=;
        b=s3+neVXn1voxld0VnAP2mdv6hjiWZIJPa95QaveLyvJhNT1H3svRnsfM/Cv7bOhLM4
         h+oVQfJu7CCNielWcXrPwcdtbem7GV6uOuDGdMMyJ6pYiE+YHiyi7NN7PyYB65EGJrtU
         j8xJs+BYBizwa2HAbtuupwIPvstC1eZZmTlbuw/HCUsZBn78toGQHE4yRVtQ98k8keU4
         h6hovM4vBHVClV8R86ylazcXm/2LWiU3BVhA/tW/lK38FDVbMraBPnfAENPFCqoIOqhm
         r4/2M/WTiw6D91j4+6fcuuDo6/pxjaqgY5s6Q5EE4ifSWozhDck/aiRjxsxk33HrgOpR
         YmuA==
X-Gm-Message-State: AOJu0YxbY3Bc9KOK6bgON4sLSYrjU/iactpof4AZ8ZlRnHw4Gxvq74Nc
	6xABTJj2by+WFVsQi9tPTj35mxhu3/NoEBI9qaiDrWdBEhFLqUW758qBbFk+kJk=
X-Google-Smtp-Source: AGHT+IFaBf85L95iWC6OGD2x0GmQ8sAu3Tcsh8+M6Z8daUVOyjZILdT71xKfi+CZ8rdKWZGWt183/Q==
X-Received: by 2002:a17:906:2f03:b0:a30:f60b:5985 with SMTP id v3-20020a1709062f0300b00a30f60b5985mr1353352eji.74.1706873387120;
        Fri, 02 Feb 2024 03:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWjhwtk1FyDJmwG/wH+qlEDizFkwhP7Xe2zXNJE0NagxXsoqGh2bL29LllnSsi2K7luOm3x+CQAxQCQAppB6FdXGhX2uxCZrsoTG9jkWyL48YYnEArNEmnmyp5i8w1NHraluJsSMoOlTEKDb0ysqt0Rbp92FXP5Oprw42BxRjuSE1lC4GG2RrDDha4gKZhXSAY9Jq31WRIeWCaWIVyKuFkQxByxcM/9MsfB9kVdZgpfyawZk/cR35sz5Hk82sIT40XeI8SXlr8qCO4ZAEbeuDzlNgPJKhfnd7e8uvjEpqPoXlvp/qV67OlIUF+VFuSAAlU8bum9XbU=
Received: from [192.168.159.104] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm780317ejm.28.2024.02.02.03.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:29:46 -0800 (PST)
Message-ID: <f1b93fad-42a4-4a8c-8373-be910106a104@linaro.org>
Date: Fri, 2 Feb 2024 12:29:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] interconnect: qcom: sm8650: Use correct ACV
 enable_mask
To: Mike Tipton <quic_mdtipton@quicinc.com>, andersson@kernel.org,
 djakov@kernel.org
Cc: neil.armstrong@linaro.org, quic_rjendra@quicinc.com,
 quic_sibis@quicinc.com, abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
 <20240202014806.7876-2-quic_mdtipton@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240202014806.7876-2-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2.02.2024 02:48, Mike Tipton wrote:
> The ACV enable_mask is historically BIT(3), but it's BIT(0) on this
> target. Fix it.
> 
> Fixes: c062bcab5924 ("interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC")
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---

Downstream agrees

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

