Return-Path: <linux-pm+bounces-11035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DA92FA25
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 14:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8775F1F22739
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2024 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4416DEC3;
	Fri, 12 Jul 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcZbaPI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9816DC1A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787051; cv=none; b=TkYcfAp6hYcrEtwB0Zgl0U3A6N1imJBPXdgXKfAh5Pr8OuOYRe2SeY1jm44QFLx/iwBqqYaahiZyTwMHqT/ngbocT7zbPctHurwLkzSBVsYtCY1IprIGPjoOBe7VNeOopeRaOC3jN0NdMwlsTynz703Rix5kV06LxnAEEpTRKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787051; c=relaxed/simple;
	bh=QyEmNN4AEqFnaHNf1Wwg6goRlvTSRSnvlJB0pGKxdSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m8s/ltt3RBwxGehTZJOHvspwNaZTqOkk+RzF70xA+C4uRPk1h6dFnMA+xxIY5bRHIhmfWDJ5/pR1Z07ibEZsOxf0v5UelgRDPJj54/Gt3BobNdBbvor0gPqiRQx1UfuK8MxwX9SaT0O6A6CpNZNV5vylt3IVf7zrFI/2kgAwp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wcZbaPI5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38028so2631583a12.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2024 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720787048; x=1721391848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sO8jCqwZ4RChvpT0860QNMWyEhO72qkm6POxb+tKwbY=;
        b=wcZbaPI5YSubtti4mUyCjhxZF1DATAGVkfwR7zU3FEqImJm8l0242Lm7u5pCowraRZ
         mRrd/iMMfzdsSsX1+eFv7mdIXhp4I0C29+XmSqq9g/6yK5z5jAIXAdnFP8z+1JyaZYmg
         T4CSVTkotDPAjAGon1097yVqdx10IrpsLCLw8qp2hLjrBhfPh/sT58MzyakCpYbDjgB+
         qiGJradIJn1zF+qzHXfgjIZViOLLJ3SwufyVZarOr3XsZPbl2GWknypsYMXIzAp35raQ
         5Mfzyrmiq68RyJeqHyd1xxHvjYV7LaqELqlZphuzmy12dg0tiEvtMJxsBJ5RJGFXj/H7
         Y8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720787048; x=1721391848;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO8jCqwZ4RChvpT0860QNMWyEhO72qkm6POxb+tKwbY=;
        b=fP3SWSBi0eRQaLAfut5K1STkXRFRIFeNuIInSj3Co1kTuLxQrWPbG29vV7eqthIKEZ
         MRjg/n+rsulg9wQ5NzNPzogSptBGFpi/1snxwTuHiLOvunkkGYDzQWl6/0HILQJIyjfA
         elUlPsHfZ2P2Em7FE7t4XT63h7RWXvxQf75qp/eeokW/eqF6tCNib/RAbzYsRJItcvpm
         yubvNxIjARtunBuKoiOOkCRPUEkWnhyohQ34sJm0PuRBFj54NKNhbqMlLnf+zqbyTD8g
         8rS8DV6x4sPR+bcOF3SiWxE7AC7P5ADzq/HxJ/iJQTRKlMXp963wCTrJqprHULsDKah8
         u3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUt4l8MosGFmXdVd+qjFEwyBIeGKNitmJT6l1E6X/9nBhiDCmdQKGLQffVgWUNfinFWrko8bP2QEEWleA8D3fbOSftF/nceA7A=
X-Gm-Message-State: AOJu0YyB+NGUGVQeVGo5PzQ1qf+25Pe+sv/zEek/TaSFohJgu4fqPMAx
	wL9vvnQ04JcXUxwVR6n1CDn9AEimYr4DYQ3ZeT4eDK8GyNxbRC0F+oUmHPn6b2A=
X-Google-Smtp-Source: AGHT+IEaqNLcI9GqkydB15ejgstg0OVseWKf8FuXbdcqYCGrpDu3M5TxEXE6v4kbl3T6SKDzmMY5zg==
X-Received: by 2002:aa7:ca4b:0:b0:58b:e192:3632 with SMTP id 4fb4d7f45d1cf-594bb86ad0cmr6704536a12.27.1720787047642;
        Fri, 12 Jul 2024 05:24:07 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc7c8a39sm4537568a12.55.2024.07.12.05.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 05:24:07 -0700 (PDT)
Message-ID: <a9a69afa-3d50-4b83-ba9e-90fa650fe8ad@linaro.org>
Date: Fri, 12 Jul 2024 14:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] clk: qcom: ipq5332: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
 djakov@kernel.org, quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
 <20240711113239.3063546-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240711113239.3063546-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.07.2024 1:32 PM, Varadarajan Narayanan wrote:
> Use the icc-clk framework to enable few clocks to be able to
> create paths and use the peripherals connected on those NoCs.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

