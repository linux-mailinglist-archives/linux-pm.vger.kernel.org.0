Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DBE84E5
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 10:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbfJ2Jxr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 05:53:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46232 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbfJ2Jxr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 05:53:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id z22so5960431edr.13
        for <linux-pm@vger.kernel.org>; Tue, 29 Oct 2019 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HGDKIfiK4WqAtiXxg2PaSaV3tKJwX+/+66kephvgEMc=;
        b=snicYa4xa75qBwamypvTLqSPyFkZPl5dVyOqrJzmSnFo9ZWuJnc5ulCdFp8WlWQHOl
         0AuO/24CzCPv7qVgEFhoukv2GFOuJ1bWq1gG2vGzILd3Sn50nx7Fi9m6nayEaiWTNeWY
         ZCadVMAYdVU8FMtX8KFyDOyJIcHoqkuUGtzHURxZSnjPpu6p02UHO+TMXf7o5/0gNxYn
         X+HUMTxEw5ceA3gawdZXe2RtYoL4PpaXATQWnklS4ADEMVGaVtRb2ZGtSlttNdf8qviH
         SrQ8FWJCTqwBRF+wvNq/NxQJiignNV7jT9hOeVxyd31CXmFMEC2a4MK+EqJ4CMbagW3M
         Jqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HGDKIfiK4WqAtiXxg2PaSaV3tKJwX+/+66kephvgEMc=;
        b=mtg8OZYskV/z0TLdNLnZl7rRfMa23FHGG+zXoj28Pl+mvBBIL21LqJevyJOn4ibTV4
         0Hx9+gJnAVwVefvOubiSH58roQIezAWmkZJlOg7SpJ2Oxg4tDaM5I8tRvZiTFFfdyeY/
         6NTx0eskYeal/C+VBjnM9j+VwzND/sSpmjWFYXeGLbi/BoS6spLmT2tU5TgD9rdBDR3f
         PSvnafX3HlE97cLR00vq0Hly9UT/LIOUN/51mfLZoxCm/DIy4pLEtSAOJuzv/+HCixEO
         nhQRmNA/xCmT1eAXcTYvUAA6YCElU+YxC4TKDp54oJQ1TqJPE1k20RnZ69UFNp7rGtyA
         qZvw==
X-Gm-Message-State: APjAAAXOxo/p8bfs33VB2vSuRO+ek536JKQPYqLj2+E/mN3InX9LrcUw
        9sHPOnb9mS1vlv5Avncj0KIFY6GWHPoscg==
X-Google-Smtp-Source: APXvYqyFyb/NYxsK1RWq4WxvayVYls/goH6XAAk9FVVYjH3wL1Zb5+8jNZclhKtCmGdk5NT+7BUT2g==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr23242997edr.244.1572342824719;
        Tue, 29 Oct 2019 02:53:44 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id x6sm664005edc.50.2019.10.29.02.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 02:53:44 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC PATCH 4/4] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
To:     David Dai <daidavid1@codeaurora.org>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <1571278852-8023-1-git-send-email-daidavid1@codeaurora.org>
 <1571278852-8023-5-git-send-email-daidavid1@codeaurora.org>
Openpgp: preference=signencrypt
Message-ID: <9f879f99-527d-50bc-d5ef-5a72d4a65c4d@linaro.org>
Date:   Tue, 29 Oct 2019 11:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <1571278852-8023-5-git-send-email-daidavid1@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi David,

On 17.10.19 г. 5:20 ч., David Dai wrote:
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/interconnect/qcom/sdm845.c | 727 +++++++++++--------------------------
>  1 file changed, 206 insertions(+), 521 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 502a6c2..a731f4d 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
[..]
>  static int qnoc_probe(struct platform_device *pdev)
>  {
> @@ -808,6 +480,12 @@ static int qnoc_probe(struct platform_device *pdev)
>  	qp->bcms = desc->bcms;
>  	qp->num_bcms = desc->num_bcms;
>  
> +	qp->voter = of_bcm_voter_get(qp->dev, NULL);

I assume that we could have a second optional bcm-voter? The
"qcom,bcm-voter-names" DT property is not used anywhere, is it needed? Maybe
give an example in patch 1.

> +	if (IS_ERR(qp->voter)) {
> +		dev_err(&pdev->dev, "bcm_voter err:%d\n", PTR_ERR(qp->voter));

Should be %ld

> +		return PTR_ERR(qp->voter);
> +	}
> +
>  	ret = icc_provider_add(provider);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error adding interconnect provider\n");

Nit: I would also put patch 2/4 at the end of the series.

Thanks,
Georgi
