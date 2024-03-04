Return-Path: <linux-pm+bounces-4634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF186FA86
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 08:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D810F282F2B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Mar 2024 07:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F593134BE;
	Mon,  4 Mar 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5QUBIbs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A012E76
	for <linux-pm@vger.kernel.org>; Mon,  4 Mar 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536347; cv=none; b=M3qZJL84at3I6O6MsScJPBl3qByo604+uYXKFLTyCR9xuWwXKOhniDcR9om7NtDvO2CFrFEFkaek2xXc6SnARHHE8oEOoK3fI4NMrWHoLYmsdDCaEXjgK8ZyZUY/RLlxtoGz9FHMo5wrqg0xcK9Jv2bIopKdJ0QU3Rv6T+JPApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536347; c=relaxed/simple;
	bh=TtMszT60sJFiCKPawS7iBjv7Fz74IxMlNkB/u4C38Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCXMKajaZsIwh7aE7X9/saT1oAJOW3llH1KkG7M7UYcJg4bxZYbaqxkS+HQ1D03TemZuqFPXbM3n1crdXAOWE9m1yvYMWH7oWyiNE51Li0mAVUpnpFZCOQed2HWPSpzE7cV+VgFUMACnbO1OIwcEl6GRA+gKK8IpwNGLWkgE1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J5QUBIbs; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so2398344b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2024 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709536345; x=1710141145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDcki6wWn44JwR9ywq+CgLT/BHDzHDzpseujJ9jCJpo=;
        b=J5QUBIbsPGjkqYN55GvlFrmdvqCslluBTbSnJNmLcc/HE8+VCiHvUtjl4jrI4zfg//
         CKvCMB9f9qODaGh9Q9TB6XjRkgF3vHPE2bGFfzIZKx1+kXGu4wJWE+//ByxDSroWmFhj
         Mf/IQixkUmSlklnelnTwHI97pgYIpKSseGRbCIRCF11syrK33K5LZdNqcMTTlfLLPtvx
         j1o+cf8w2d1SUfTqUv7tmAw2+66JYlSuVltzI1N4wBX1y3PmaDcqwK8EZKdnufjZM+nD
         fNz5mIY9ZHHnWywEJUkJwwiBOZDFhLlvs4YdxsHPWZmWUxxC1nCvX5ZFvToEUM/yg3fZ
         ntOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709536345; x=1710141145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDcki6wWn44JwR9ywq+CgLT/BHDzHDzpseujJ9jCJpo=;
        b=NmVz+s105VcTF/9JJzbSxyVbZQHJN6rAhwPf68OFIdAazYY6vHr5vwDe3EqZwbOSNG
         Znx8I9MuTlGVVIXAuoTw9h/lx4MASutPGIvdK1hF4jT/cUF5duFoMu8PwwnhVy04YL25
         wJNlBc9hshgE4RSTuKPrn6DhJad602GdJstrmt+IAjMEJ2A2ZKCEyUnnOXD48ARuBpWz
         R3W6+NvDSWIjp+9JAZKrrTbTE+b8DPreeGrW+WSvfY2eeixREwxR383JJBhyjGzAn/nl
         kyR4pY83KW/GwxXTba4FGob+IGRMqQDAScugNS03BXzeG+qq7z4ej4wwrcYM7JYmL5w8
         rfGA==
X-Forwarded-Encrypted: i=1; AJvYcCWnfxA7tw6+MPWZyvkFdrUSnO02H9wHxsUqploIFaQaDdUiRyriC4HBKk+ThEI2Ov1zAiSdYueB7tHQHBiTmOM2lr2wo7k05HA=
X-Gm-Message-State: AOJu0YyFU9ty/IRCe1UB4ixpiRNKbEctqDLe69gckblPxA9expkIm6l6
	WfJbbIqJ9n2blNJ66l888/1Nh5WdTyVia0drnuLILuPwddvLZmAZtj3weyITNto=
X-Google-Smtp-Source: AGHT+IGRGLtypkqvltDU7f+SWiJXwZCuN3YSRC97dF/QpzFqcFscjmL/DzIb/6HX7bsAuMTqJl3d7g==
X-Received: by 2002:a05:6a00:22d5:b0:6e4:c102:8065 with SMTP id f21-20020a056a0022d500b006e4c1028065mr11204883pfj.5.1709536344783;
        Sun, 03 Mar 2024 23:12:24 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a000bd700b006e04553a4c5sm6604551pfu.52.2024.03.03.23.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:12:24 -0800 (PST)
Date: Mon, 4 Mar 2024 12:42:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Message-ID: <20240304071222.cx3s37mphddk23bv@vireshk-i7>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
 <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>

On 28-02-24, 20:21, Kathiravan Thirumoorthy wrote:
> Like all other SoCs in IPQ5332 family, cpufreq for IPQ5321 is also
> determined by the eFuse, with the maximum limit of 1.1GHz. Add support
> for the same.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index ea05d9d67490..0a46b5d49d32 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -191,6 +191,7 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  	case QCOM_ID_IPQ5312:
>  	case QCOM_ID_IPQ5302:
>  	case QCOM_ID_IPQ5300:
> +	case QCOM_ID_IPQ5321:
>  	case QCOM_ID_IPQ9514:
>  	case QCOM_ID_IPQ9550:
>  	case QCOM_ID_IPQ9554:

Applied. Thanks.

-- 
viresh

