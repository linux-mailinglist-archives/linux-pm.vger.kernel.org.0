Return-Path: <linux-pm+bounces-3466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8501084B0C1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 10:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA46B2236F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910BA12CD85;
	Tue,  6 Feb 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBZK2Weg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8412C532
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210434; cv=none; b=Ba0tkvIfOqPI271mNBF7M5G7nnE2fKPk/pzamf69vi8mboUwSBrN7yy2eL37sY8IE1hnK3bL8E86MrUIDucnO2st6yNJ6NOmGBhHriLtnPsjFRdI9hmZccmEzSAOKbK0Ogdp1FNFE7v/3i14wnOIEjU35NcV25poN2hvAvOeumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210434; c=relaxed/simple;
	bh=fnEctsruhnVWmql+TCSz11y0qzJmN4K1EeDPjcx04Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPY2SKr1TVNkLDCqHdkwBrxgyGgE2sTh3miPIkTi0cK57fChbJHmTqlEp/oMjNegeUTKpQOHpende8onIDYNYuSkW7F/FcEdYDZLEwnXIOlYu+kqjPFRn+27y0i9msaYZm8VuiPRPAJoTZiVc/0EqttRt1VP/B+7/eEw3fxY5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBZK2Weg; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-511413e52d4so3486911e87.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Feb 2024 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707210431; x=1707815231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WM+y+UC/O88KwoIvUP7ztF2oIYBeAuZ8I4kYszkol04=;
        b=SBZK2WegSlON9KbJe/eaicM2ZG1ZGJwG6v3Is7z/Y3lNWVy/DUigWr9R0a5/guxSLH
         o9FeA71M266CLNQYKOF4YF9legQYslKW0sx0VtO4ZCo82lsxPFFTbXYXdqfa2guExN2t
         FBM16eSTsMCjFg5n+duvQ9H55Igk6Mqwlja+RZ784kz+QKFVRG/ehZU6+/hcZpGB4/Gb
         0tskeTMoi4ZBquo0kkbzH8Zb3ScVUN769CNKp64WIu7zDCMEx8MVMX+gyxMz7sjsovKI
         IO7asHlDZIbsVK7AkgAWRs2fqK6dzQGqfw3JtlQgB8q6i1MBSzP7lrQjHz/3f6HsxVGd
         WQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210431; x=1707815231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WM+y+UC/O88KwoIvUP7ztF2oIYBeAuZ8I4kYszkol04=;
        b=aV+9cwfoep/bGOIY3Tbl+utFY6lFcrju5NOnrsAXS0HODIVirOChcx5e4K5wbkvNx0
         ALldOp3J5BxWpMDsq66vgTQkuqZUlK2Pyo9EyE9jXp+TFUTjYYOIbonZltQuvEXMl+PW
         ywPSfvEvt2Hx+yDSQqUKog9+rc0T5QBoOmtFP8IebJrlsDYHrolwtvLWbCSz08/Cw8j4
         FMqoicBDvxJo3fVwwXFJ10LW0GfjpNlv0dluUxCbTGZXzrny+DkPR9ZNCWiKdHNPJgoI
         ioQ8HwPDD9XcxfItQgHi50GVcW+UxfknLQyd1i0srAO4uDZjHUPSVE22U80/CyyepS0v
         TKag==
X-Gm-Message-State: AOJu0Yxhj6KyXX7VDMim2M93McXlhlUCydHy5eIF/EU5H8Zux34S5fOQ
	yYsmcRZ+i3QoH2BgNpdaa18bIJ4eRj8fWWjnREBDgIVV4dC8Ez5JMKwKSi1Uhmo=
X-Google-Smtp-Source: AGHT+IEVtfeRspRLdAyLcxvAk3kbxLTxwqNrCZLbrhzZEIgx06XTFt+w7WRDO3WY1hTQdxiW0zJC/w==
X-Received: by 2002:a05:6512:b8c:b0:510:1797:14dc with SMTP id b12-20020a0565120b8c00b00510179714dcmr1667466lfv.10.1707210430685;
        Tue, 06 Feb 2024 01:07:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDy6w5A1fvKBuSP6HcTwk/RZzZolXWXofV2m7S5vm8UINiI5mTxV9ZC0VhTGMIHCiENn328A+ii8rummc2TOQy89Ogc+5iB6YxljMe5ECt6nH0t3KHNEq06or3ZraISdd8DEgTRmdlt01b/Ki255Q9ifXNUA0eDj/q6ARUK+lZp4FYy5dNxDDs42hfwQojg6/2LgtC6VCxyXsmZnHPKi4BWOsjzFzFBGbt81fAfG3eGnHyuAkLbliS6Kj9SryKCs2b3UaL30Daikzqp6CfQU44ETz4YuAkkb8cRpB10UgGFkaS9Jr6H9gw8LiumaL+rjZXBl+kZ6ZaLwWsHfZTj+aogLmXs9bEJsPrqi4qluc8hrhNsoAoxX3yb/AdFuToz+4csCghG60H5XQyixUt
Received: from [172.30.205.88] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 14-20020ac2484e000000b005114a6cbc4dsm187169lfy.4.2024.02.06.01.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:07:10 -0800 (PST)
Message-ID: <8189e50a-290c-494d-af42-a954a5d231ea@linaro.org>
Date: Tue, 6 Feb 2024 10:07:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add support for QoS configuration
To: Odelu Kukatla <quic_okukatla@quicinc.com>, djakov@kernel.org
Cc: rafael@kernel.org, corbet@lwn.net, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_viveka@quicinc.com, peterz@infradead.org, quic_mdtipton@quicinc.com,
 linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org
References: <20240205145606.16936-1-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240205145606.16936-1-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/5/24 15:56, Odelu Kukatla wrote:
> This series adds QoS support for QNOC type device which can be found on
> SC7280 platform. It adds support for programming priority,
> priority forward disable and urgency forwarding. This helps in
> priortizing the traffic originating from different interconnect masters
> at NOC(Network On Chip).
> 
> Changes in v2:
>   - Updated regmap_update to make use GENMASK and FIELD_PREP.
>   - Removed the regmap structure from qcom_icc_node.
>   - Made qcom_icc_rpmh_configure_qos() static
>   - Removed qcom_icc_rpmh_map() API, inlined the code in probe
>     function.
>   - Updated declarations to reverse christmas tree fashion.

You ignored some of my previous review comments without a response.

Konrad

