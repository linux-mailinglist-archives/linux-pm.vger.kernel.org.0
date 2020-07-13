Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF96A21D73B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgGMNa0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgGMNaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 09:30:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F2C08C5DB
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 06:30:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so13337016wmj.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbYmFCX/Ar69E0IhWMGtfk9Pb1qAWqNwvIoVlNOYA2A=;
        b=AP9wM0piyA/Z0ONPdL/Cr2K6XME27CaBJLTfgYFHac/Exv5jv+xjM4QvDDxvLuKwqN
         zbFaqJU0fQr0RAX8ebtCPhKE3mrD7F0958tJfYqxhO0FpL7porzzwkfhyz50DrXfqz1N
         5rR+8eLA7zHtEQNqTY6WC33QVR+RFhZCYvDDbTlnFscWbxqw+dVsH9C4IyGuuI6KBw6T
         LY+t/qe17lfyFeQLFvJHud9MSVg7p0DSY86PfOnj2sPm9TspmQxmTJy1IzkejP/6n3tt
         Q2Y61lIVydNzmYqu12fKTxtf/XN+sbFKLqwt68WHfwgmDvf+4rCIh8ofcjSltcDqvbym
         lMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbYmFCX/Ar69E0IhWMGtfk9Pb1qAWqNwvIoVlNOYA2A=;
        b=c+m2KxdhUMe1ICvE0AMjipLATV7QcOfmdi487qzz7Tdpyp2ieiI8C5nYU7EQE+Pvth
         ExAGiKCMWWtgP0zPfDy7vm10pvW6X+gHTnBqLgc0/TOniLsmUW7SoeV5fFt88TP3Ldao
         z9jgQTKftdATqApuk2XirPngDlnGuedtCotGvLMbNenn+k5PV01USzBOFdUpRKE45slc
         y9/qRhgzrqwZsBogmwOLvA8bANODbD1CFCBE4r856FemBCJPBb8FLtcH6ue4KdQ3VhA0
         lqNLuga8cqiWe5N1gANcxAbOxdEIWHo+DFLy5c2tHaoFToD/CKLjoJdjogCdAzCxHwrp
         GKHg==
X-Gm-Message-State: AOAM533UKEcIAoo0ThpELs7kTqUP7PhGramUeCnclxTnITNS/desM2PF
        gVC1oyxxSfTBzPeJGS99MgV/2uinY2U=
X-Google-Smtp-Source: ABdhPJyaZSEh5KhM1jhyc45sWKfw/RFe5p0tMtiIA4bhFyomRIulSGzqbOgyFOA6yYTfQ6wqvIyQmQ==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr20431603wml.189.1594647023604;
        Mon, 13 Jul 2020 06:30:23 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m4sm22022713wmi.48.2020.07.13.06.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:30:22 -0700 (PDT)
Subject: Re: [PATCH 4/6] interconnect: qcom: Add SM8250 interconnect provider
 driver
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-5-jonathan@marek.ca>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <5a0eca0e-d496-d8af-ca41-0f07e9a3e01d@linaro.org>
Date:   Mon, 13 Jul 2020 16:30:21 +0300
MIME-Version: 1.0
In-Reply-To: <20200701134259.8055-5-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jonathan,

Thanks for posting these patches!

On 7/1/20 16:42, Jonathan Marek wrote:
> Add driver for the Qualcomm interconnect buses found in SM8250 based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Based on SC7180 driver and generated from downstream dts.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
[..]
> +
> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,sm8250-aggre1-noc",
> +	  .data = &sm8250_aggre1_noc},
> +	{ .compatible = "qcom,sm8250-aggre2-noc",
> +	  .data = &sm8250_aggre2_noc},
> +	{ .compatible = "qcom,sm8250-compute-noc",
> +	  .data = &sm8250_compute_noc},
> +	{ .compatible = "qcom,sm8250-config-noc",
> +	  .data = &sm8250_config_noc},
> +	{ .compatible = "qcom,sm8250-dc-noc",
> +	  .data = &sm8250_dc_noc},
> +	{ .compatible = "qcom,sm8250-gem-noc",
> +	  .data = &sm8250_gem_noc},
> +	{ .compatible = "qcom,sm8250-ipa-virt",
> +	  .data = &sm8250_ipa_virt},
> +	{ .compatible = "qcom,sm8250-mc-virt",
> +	  .data = &sm8250_mc_virt},
> +	{ .compatible = "qcom,sm8250-mmss-noc",
> +	  .data = &sm8250_mmss_noc},
> +	{ .compatible = "qcom,sm8250-npu-noc",
> +	  .data = &sm8250_npu_noc},
> +	{ .compatible = "qcom,sm8250-system-noc",
> +	  .data = &sm8250_system_noc},
> +	{ .compatible = "qcom,sm8250-gem-noc-display",
> +	  .data = &sm8250_gem_noc_display},
> +	{ .compatible = "qcom,sm8250-mc-virt-display",
> +	  .data = &sm8250_mc_virt_display},
> +	{ .compatible = "qcom,sm8250-mmss-noc-display",
> +	  .data = &sm8250_mmss_noc_display},
> +	{ }

My main concern here are the display RSC nodes. We should not add the nodes
for voting on the display RSC, but use the "qcom,bcm-voters" property in DT
to list both "hlos" and "disp" as bcm voters for gem-noc, mc-virt and
mmss-noc.

Thanks,
Georgi
