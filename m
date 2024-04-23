Return-Path: <linux-pm+bounces-6933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD18AE728
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 14:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C01F26191
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A512C480;
	Tue, 23 Apr 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STZkVB2x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1B86AC2
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877127; cv=none; b=WRIOyGlLCfKvLq4n2WW+Yumum2QfljZYOSEkODY8DMrmgZCW4gZrjEEagucL0N7hF4laiE4CoCaEsw1XHUOiAssBKGHXVLNtLI8swkadCy8yXtoYSlK/1iTHsm3YmTVIFrc4b5YAr1wcdT0QytE2lfl50Z5yuyc3sBkzpRMrGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877127; c=relaxed/simple;
	bh=C38jNkPQIY9PbuFlXsBJRUbs0C33ZReaOCMWgYaSpZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=beOFliTPMdH5ni+eYPt6ccFAr6Sh6dQxTBQYMp5a/bQsTzJUx1pcohBY5CyKUmeR0lnTfPEfrIJEbjEskn4PnPOsOGoxpSwfPAJXZ2GJIbv96iO4pxW+XQdWhLVbTtSBHdJVJpza3KoonMwuPh6z6rwCJ4zzw+WfLWPdqsslcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STZkVB2x; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5194cebd6caso6761382e87.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713877124; x=1714481924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfWMwHQIpw4zS3iFGNbv1FwxyBMpqPbqqndAtgdwOvo=;
        b=STZkVB2xoG0zGbe9KBS4l7UH0vv9pJ3uqHQVktFP/nzt+wghIG27zyNGC56W9J9hmI
         43DRQKtRQuosG2bct4YVMylVhh9nwYUWGUHEjKysZqPw/UHR0Uv92W6WkJ0VXYuc6Smt
         BWaYwKmgUQqEtvxBpoVKqlqkHVk+h6/R8Wcg5q3JKvCZrO7Dt2NG9E9C1VGhlsxgHqtW
         eM8gSV9mnZX/Wo+t5Y5LkTyZh04tvNZkxqBRol+vp/On7hTRtDhbhRnZ9Adk0t5xzTLP
         eZCtyJhWnyfGsrra6IeeNbX8ocQs3AxL5W99M3RJo9TCZvLiWJFcoiJoH2DrkgU89iNR
         HNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877124; x=1714481924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfWMwHQIpw4zS3iFGNbv1FwxyBMpqPbqqndAtgdwOvo=;
        b=gIRuDozwZHTamVUcJlyt8j7m5ytY167CgKwOiXM+eIrrUEZI3CntCSWmeCK4CXU94v
         /X/AhdccrSVUyesJQaMggkjC3D0fU5gvjr5Z5vMSjroCWPethtjmO6nf8g3MVNc4wLXI
         e6iI+5bEuYNlmioCfh/mcF4EtkGoGS88JCoBDNsFTV6x8zd2tQlrQygYZTrIUhW/Whpl
         n6H1T07yYQP2KHVn4Noe1DgKkIkNNB/PE8vjTrw6IdKogACynOwAfu/jI+GDj/hbCKLx
         JmJavdp2iqcnbwlAqB4x9JkZPYjEYByEBWY2d1+8uNYCw5mF6mE28jRjPxVmp6otv2A0
         THew==
X-Forwarded-Encrypted: i=1; AJvYcCWBvVngr0sD8jUAebVi6uivIWOHvrayibaYjHnW3PGvs33rvh8lpMVXLdlCeV2Lf35kVM1T1IwjsZiiYoDeN41jFCAaowsrhaM=
X-Gm-Message-State: AOJu0YzScWIbG+kYIvWA96yMlav2VRlR8IOsN1k2mb57hKSEwKT3ik5E
	XTFVBrQGRy6Aq/5K1Kklmz2HsojFFhBwDUCicNUQOzUrafPNm6YPz7qAIGJ51+Q=
X-Google-Smtp-Source: AGHT+IHFPonFyfwcyDEJAcAqUSp9XGi8YlceLjdGzBOHf719wJg692YC5McvPpN7AvR2TgPu+w13Xw==
X-Received: by 2002:a05:6512:3712:b0:516:c8e5:964e with SMTP id z18-20020a056512371200b00516c8e5964emr6801237lfr.21.1713877123745;
        Tue, 23 Apr 2024 05:58:43 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c12-20020ac2414c000000b0051ae53e9afbsm1148796lfi.92.2024.04.23.05.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:58:43 -0700 (PDT)
Message-ID: <a7194edd-a2c8-46fc-bea1-f26b0960e535@linaro.org>
Date: Tue, 23 Apr 2024 14:58:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] arm64: dts: qcom: ipq9574: Add icc provider
 ability to gcc
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, djakov@kernel.org,
 dmitry.baryshkov@linaro.org, quic_anusha@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240418092305.2337429-1-quic_varada@quicinc.com>
 <20240418092305.2337429-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240418092305.2337429-7-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/24 11:23, Varadarajan Narayanan wrote:
> IPQ SoCs dont involve RPM in managing NoC related clocks and
> there is no NoC scaling. Linux itself handles these clocks.
> However, these should not be exposed as just clocks and align
> with other Qualcomm SoCs that handle these clocks from a
> interconnect provider.
> 
> Hence include icc provider capability to the gcc node so that
> peripherals can use the interconnect facility to enable these
> clocks.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

If this is all you do to enable interconnect (which is not the case,
as this patch only satisfies the bindings checker, the meaningful
change happens in the previous patch) and nothing explodes, this is
an apparent sign of your driver doing nothing.

The expected reaction to "enabling interconnect" without defining the
required paths for your hardware would be a crash-on-sync_state, as all
unused (from Linux's POV) resources ought to be shut down.

Because you lack sync_state, the interconnects silently retain the state
that they were left in (which is not deterministic), and that's precisely
what we want to avoid.

Konrad

