Return-Path: <linux-pm+bounces-4761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDC874934
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 09:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DEB2854EC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Mar 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5963130;
	Thu,  7 Mar 2024 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d81wZiQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F191CD16
	for <linux-pm@vger.kernel.org>; Thu,  7 Mar 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798656; cv=none; b=KpslO4A0w2Qh1ZcO060JFq5N/IwiX0+qqm2So06auH+BEubtiH7Xn/b5mgVM2e3c1eJyW6LLDkoTRmcKdRikQF+mlMd439813R/8OmxfST8hRBQnwxmJtdVIRD/UYxZXKwfpbGE5dbrXYS8bC0yCL/b6IccgiRJNJJfgMMZm3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798656; c=relaxed/simple;
	bh=CYI1kg9L8aJ8tOx8jtLfhBmzrDy6szw6bLUCyE7PD6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyBLleQkM/oVnSEKHW0PAT1Lq1AXJ6x78DnzBTTmm4dry71iVYYsrEknDmwuBHoY11hBwL+NZie+sKZ8I/5pIjQg109fziy84KAhnprVqdWgGGjju66vDX8HT/X7rggzNzCqHFa94KeuB1b4A+RuKfTukm1pXSYPDq1Ebm7GxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d81wZiQn; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28051376eso8159121fa.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Mar 2024 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709798653; x=1710403453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6FHP53ejp69T55VtiKwTInqSB2/riDC1cXIiukRsS4=;
        b=d81wZiQnTxidRkhN8+69UMQ76sfPHW7trSZlxXfVajpxNPSEDwh8yqP7WQdP0EvziC
         hSe32Ndp7QylKG0vT9PU87Ft98QzLpL7up8zMlXBh38YQpKa2Wmen2ToGWagUaJnA5Vw
         wbRKs1IKrOIWMDPbGWsf6uagxK77w3gpvDQi21/f4aUge3Fy+h6e/I4QeOTqWu4VTu2N
         ZtcwH2DtCKqddE8eP5qwN8h25O3KGaQRlIKwMTP4eVKJKf4hEO2MBBGH5RLdlAH4jP6Q
         DrLnP4FSzwYP32F/wcyizrLqUV3+8EYhNtLNM2s+s2OLtpO85rzg6rHWRG/tugF9xWqU
         BWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798653; x=1710403453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6FHP53ejp69T55VtiKwTInqSB2/riDC1cXIiukRsS4=;
        b=aA3IRActEdW9TItYzPAPo8NaoHqD5f9cGsBcROXwnCWEvzRjFF/GRYbPRQIADJ6Smn
         6Yxx2OdUcJNB/PTXC4HVayVmwgVUvb+Ncavd8ixl0QKZWuq/BQzqCyOnUqzVTBFx3UKe
         jGcAlAPSGAMrlPZ37hEikPGuo5pdHs7FwyWC6+2FfPoNp3x41z1AbqwWepvISHWaJcR0
         og9kouFm71CAtsn4wG6HEksnBPFS1jtq3iEcnsY8Ay81x7frG9C2MqErwJHslfK6u5lw
         bQb8QstwXqGTWtCRciotWWlyrC/WP0jPrmBWGGTIqJglRX7bjS0ZOzIYr3IENCaD522h
         EHoA==
X-Gm-Message-State: AOJu0YyxyKYVfK7wDgTMnwC+vZP7mzNK+77BM5AEFMwSf1cwq9jkfSnC
	Lcg2U/SaYZ17GLs7bcR0OKGDjIZL4JmwOYkq/KFiKYIG5DaoZaESkzkmEH6Sdno=
X-Google-Smtp-Source: AGHT+IF/FbZI9V3fnhZxTotkYGe0H7asaBOzfuad3V5808zjeEQw3zi/Mr+nsjYFNjxc1X0/fQUK3w==
X-Received: by 2002:a2e:9a85:0:b0:2d2:ea18:bcc7 with SMTP id p5-20020a2e9a85000000b002d2ea18bcc7mr695660lji.23.1709798653117;
        Thu, 07 Mar 2024 00:04:13 -0800 (PST)
Received: from ?IPV6:2001:14ba:a00e:a300::227? (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id a19-20020a2e9813000000b002d2e419d9besm2796878ljj.65.2024.03.07.00.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:04:12 -0800 (PST)
Message-ID: <af56f728-0e3e-46c2-943b-44fa2d100797@linaro.org>
Date: Thu, 7 Mar 2024 10:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thermal/of: Assume polling-delay(-passive) 0 when
 absent
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
 <20240125-topic-thermal-v1-2-3c9d4dced138@linaro.org>
Content-Language: en-GB
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20240125-topic-thermal-v1-2-3c9d4dced138@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2024 14:11, Konrad Dybcio wrote:
> Currently, thermal zones associated with providers that have interrupts
> for signaling hot/critical trips are required to set a polling-delay
> of 0 to indicate no polling. This feels a bit backwards.
> 
> Change the code such that "no polling delay" also means "no polling".
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/thermal/thermal_of.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


