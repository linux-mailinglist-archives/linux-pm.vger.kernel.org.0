Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 384311316CA
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgAFR3Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:29:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37998 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgAFR3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:29:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id i16so48063683edr.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xILTpET5HvTSzruyix3vfVm6CvfCGp/jihwvwllbC3w=;
        b=HlJEyMb8VUi7sQRbOTe70KWZFvO4offX7v6+PJlsTms05KH/5Zk2AcWBD9QwLXKqGT
         ieSHoimZJohktzModRyY8OAzatcq9yauRfiGnkz32G9Ipx/4A49q5YqcD5aPva03h2Gw
         iG/yDXnl2eWu9nK2nKVrfDj721JJZDwkforMU2Jn8MknDcBd+czSHnh1eS8CymkNkqAV
         r9k3nOJs2+i89oIxZFd9w2Yqh4Va+CZT2PGBQCWYuAyQmw47boYD9S7MyfCSZNt3wfn9
         tcKDGcFrzCrm9o/daxrbRT35fhFe4Ez0ffBC1AeUnDlIeJp8mZKfYprbwwzxEAAyBLh/
         A8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xILTpET5HvTSzruyix3vfVm6CvfCGp/jihwvwllbC3w=;
        b=qss30hRYZpTc94P5lxftJeuVEvoeZIngFHNuzwTd232/tSDMiI1DpbQjml00fJJNyo
         YXnoHIcnExW0bDAqh4BrFPcj47d3+jPLL9dPjThuK8/GctOahdpTdts3E2K6meDxXcuS
         TvWdCIMDzvDKXQ1Uf3cIfmQfbKOhm0TSw9T1hamW8h36Ryg+W/9JF2YmLsfutKu1HlMd
         eQleWU+r+dn5RBUN2eGwGuO51AOUs1Bm3LvtalAUVYK1vc1na3YhFLaZh6oYyHXqEpxB
         p+G2l//WyDaY7UkeM9cuUB6SQEuQpmeIDqi57G52mMEHjIirPQQDlh9mmz6Il8Odv8YC
         q74w==
X-Gm-Message-State: APjAAAUz3/1s6kCJCrPZU5QEKWph/fxvl/ilI/vl1d+RQZui5E6tjQVZ
        YEMl2+9MEsfD7n4T8HLFJZohHg==
X-Google-Smtp-Source: APXvYqxEzJZM06OUQohBMr1QHRp1MDY9Ku71gw8Iw1kMg/pbAp8k7JloMdp2qZLjR6txq6yNFFdkFQ==
X-Received: by 2002:a17:906:b301:: with SMTP id n1mr108850634ejz.285.1578331754162;
        Mon, 06 Jan 2020 09:29:14 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id e24sm7403328edy.93.2020.01.06.09.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 09:29:13 -0800 (PST)
Subject: Re: [V2, 3/3] arm64: dts: sc7180: Add interconnect provider DT nodes
To:     Odelu Kukatla <okukatla@codeaurora.org>, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <f144cc82-d4d9-b841-0cdf-41202e11b979@linaro.org>
Date:   Mon, 6 Jan 2020 19:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <1577782737-32068-4-git-send-email-okukatla@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31.12.19 г. 10:58 ч., Odelu Kukatla wrote:
> Add the DT nodes for the network-on-chip interconnect buses found
> on sc7180-based platforms.
> ---
>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 96 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 3676bfd..077b1e5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>   #include <dt-bindings/clock/qcom,rpmh.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interconnect/qcom,sc7180.h>

This should be moved one line up if we want to keep the headers sorted.

>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   
> @@ -1286,6 +1287,10 @@
>   				clock-names = "xo";
>   				#clock-cells = <1>;
>   			};
> +
> +			apps_bcm_voter: bcm_voter {
> +				compatible = "qcom,sc7180-bcm-voter";
> +			};
>   		};
>   
>   		cpufreq_hw: cpufreq@18323000 {
> @@ -1298,6 +1303,97 @@
>   
>   			#freq-domain-cells = <1>;
>   		};
> + > +		config_noc: interconnect@1500000 {

All DT nodes in this file are ordered by their address. Please move these up
to keep it consistent.

Thanks,
Georgi
