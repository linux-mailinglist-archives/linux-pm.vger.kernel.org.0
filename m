Return-Path: <linux-pm+bounces-860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5461C80B5C5
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F7F1C208D1
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA8D1944E;
	Sat,  9 Dec 2023 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4xr/Iv6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48511F
	for <linux-pm@vger.kernel.org>; Sat,  9 Dec 2023 09:54:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so4196815a12.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Dec 2023 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702144459; x=1702749259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvHND4P/HoZ0eN5ekFdH68Ldcd5nj6SfIoXhqMddDPY=;
        b=I4xr/Iv6SLgHHpwdkZtQCtK4UjSqyVe1HwfXmM7YRkjlRRrcSunBkhcVCzgj/gQt4c
         ZGxal6YgS+6Y8oPmPvGTSilrUfyQJgD1uHTQ5CtzxLYLH/iBLg77ny/zvSnjSC3XwdaS
         NqTJ1rphqOhZ8449ZshDQLWin1gOejFml1n7SQxBswVY7S145nrkI3hN9JVth6AF8dCh
         RIUzSByM+R2gyiQ473lGLr9AzPmrSLyH1879BpUvsYmWkWvDe33FIhrFi+rUUKQsLlpW
         3UMNvbtXi2Z9x9fmjv0YEzCNKNaw2sOul/2/+TahAdC6MAprQDidhE+hrtLDM/MXoogP
         +aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702144459; x=1702749259;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvHND4P/HoZ0eN5ekFdH68Ldcd5nj6SfIoXhqMddDPY=;
        b=JCrD2ll6cHspwoiIFpkFn8/dayNUxKKzxYf8ed/J0kUnLHCG/+ESv25WHrxWnXul6V
         kD+i8jtUUDXDGiKlkSzP4mNLEt6Mo12es/fMMhWscng387qR0/cDDTdMXwYZdYqOPdl8
         M47Ag1GatVkj3tFHzKzyKrAT3bnrGyjVlOdCmgGZwaJHKiAo4LCJ8Fi2U6wRl8SG5Zlf
         X3nHnaO08xYtuqsw8YlDx+3dPds4UPbR+d3r+4Fpqf5PEOBZVksh+JmpMncbPu6zVO3U
         2Ql/gG3yAWRvI7cqzsqLuFBKY//ZoNWyu2WKEpJsy3RW7LYe8p7IHRappdjp4GteKnoE
         bDPw==
X-Gm-Message-State: AOJu0YwUzyxlXELjSrltLvhA91m6Ph3N++V5ouj/F9t59Vs3VbvXDWoY
	HzT29rc+z8YI0Qtygnj59O8dqRnrE3UvyalBk2A=
X-Google-Smtp-Source: AGHT+IFbUBIScunhp/10BaKOKvxkgMMwaF3LauB+6T2wH4SVYcWBBxfmq1CkdZ3cs0JM9TjOOGO9cQ==
X-Received: by 2002:a17:907:6190:b0:a1f:6761:c8dc with SMTP id mt16-20020a170907619000b00a1f6761c8dcmr796454ejc.124.1702144458937;
        Sat, 09 Dec 2023 09:54:18 -0800 (PST)
Received: from [192.168.36.128] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id rm6-20020a1709076b0600b00a1bec12448csm2457107ejc.150.2023.12.09.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:54:18 -0800 (PST)
Message-ID: <3f921a53-8eac-48e6-be17-43c07a0313d0@linaro.org>
Date: Sat, 9 Dec 2023 18:54:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider
 driver
Content-Language: en-US
To: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>
References: <20231206-icc-msm8909-v1-0-fe0dd632beff@kernkonzept.com>
 <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.12.2023 15:35, Stephan Gerhold wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add driver for interconnect busses found in MSM8909 based platforms.
> The topology consists of three NoCs that are partially controlled by a
> RPM processor.
> 
> In the downstream/vendor kernel from Qualcomm there is an additional
> "mm-snoc". However, it doesn't have a separate RPM clock assigned. It
> looks like this is actually the same NoC in hardware and the "mm-snoc"
> was only defined to assign a different "qcom,util-fact". In mainline we
> can represent this by assigning the equivalent "ab_coeff" to all the
> nodes that are part of "mm-snoc" downstream.
Worth mentioning that snoc_mm used the same clock as snoc, which is not
obvious with some of these older designs:

static DEFINE_CLK_VOTER(snoc_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);
static DEFINE_CLK_VOTER(snoc_mm_msmbus_a_clk,  &snoc_a_clk.c,  LONG_MAX);

[...]

> +
> +static struct platform_driver msm8909_noc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-msm8909",
> +		.of_match_table = msm8909_noc_of_match,
> +		.sync_state = icc_sync_state,
> +	},
> +};
> +module_platform_driver(msm8909_noc_driver);
And you may want this to be a bit higher up in the food chain!

Otherwise I don't see anything obviously wrong, I assume you tested
this without clk/pd_ignore_unused, with rpmcc cleanup and can confirm
the QoS programming went through without angry resets.

Konrad

