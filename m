Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F091929AA7D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 12:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460281AbgJ0LYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 07:24:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51837 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460304AbgJ0LYt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 07:24:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v5so1011381wmh.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8WNjYrMb3DPWlB1OQ69cZHkYLIkDIqyYLruRZBHgeA=;
        b=GJq/YRZWWUSkhv7p/j+DQm0bIUYVCBAc9XDOU6zD8hbUYwphLwWfLdIJE422/whcB2
         jooKwNaLNRTGT0AO2jF/DL7vBAD6OGQxUlkuOIj3iPtKDDCf/+oVGdGwgdJs/MphoCJV
         mJsxdvVBA2wosfw2xYPZ3+pIBpGiM76v/E1NDGKDNXk8PFyKOKsL91+yMd7LDoPklyxt
         ycFaGFQJfrCRJ735cT7L8T6+Hpe+MOxbbBDMSK7zV2QSTBfqtQ/41IJcLQhPQWJYst5c
         4Bl9zbm9M5n3/H5cvXCfd6OEvc/Yk5jwPvhQudhvQzD+aNbv3LsAe8BH3+Wg8C6BZ/dG
         9LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8WNjYrMb3DPWlB1OQ69cZHkYLIkDIqyYLruRZBHgeA=;
        b=oDVligJjtsnrrwJxfYuzpl2Aox5qjw/NbifEfn9wZ8X7mWWvgsHAQ5DhP1GHm8hcdY
         W4vT8+v8BIl5vQhLkgrIqxtmTduQmf/jpnoGCLOMAUHnvElQHvT5FNz7TRxCV9bIsWGo
         w8L3irY6+mz42BsdlLkJh3p8hHbWdI50dAIfAXXmU2FGgt02kOYTPjg9O1vu/g2TRkBa
         9uRYUNO8OUfyT4LxI+vM3VsTUZOAiPpMhbuuQfmmUpaPPdS2ac9GkpLlpqyAq1+Kjzq0
         46HqsjgG44SCyiiLFEwv7DdYg3kRvJUGmpbGCJEiez6u5jkqQLN92mAWJmAcKuCjXx3S
         GBpQ==
X-Gm-Message-State: AOAM530PaUyva64xfzQfOwzXTaSJ04WAI20gj+tC2Kz8litk+eboRRAl
        AVrrzi52ikvfiBCZW6FpUvQqvm8h86Sa9A==
X-Google-Smtp-Source: ABdhPJxjXh5q7eYJJ+zLXze3N5EZow4mKmya9fN23+aiNtrejYqjmNLgrA92OldULQai49YB9PnS/g==
X-Received: by 2002:a1c:9c41:: with SMTP id f62mr2146938wme.23.1603797884371;
        Tue, 27 Oct 2020 04:24:44 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z6sm1720345wrm.33.2020.10.27.04.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 04:24:43 -0700 (PDT)
Subject: Re: [PATCH] interconnect: qcom: use icc_sync state for sm8[12]50
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20201027102731.951421-1-dmitry.baryshkov@linaro.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <20047ef9-c84e-2923-f878-5f29dc3dda2a@linaro.org>
Date:   Tue, 27 Oct 2020 13:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <20201027102731.951421-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Thanks for the patch!

On 10/27/20 12:27, Dmitry Baryshkov wrote:
> In addition to the rest of Qcom interconnect drivers use icc_sync_state
> for SM8150/SM8250 interconnect drivers to notify the interconnect
> framework when all consumers are probed and there is no need to keep the
> bandwidth set to maximum anymore.

Should we add Fixes: tag?

Thanks,
Georgi

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/interconnect/qcom/sm8150.c | 1 +
>  drivers/interconnect/qcom/sm8250.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
> index 9218efed04a0..30fb6567fe19 100644
> --- a/drivers/interconnect/qcom/sm8150.c
> +++ b/drivers/interconnect/qcom/sm8150.c
> @@ -627,6 +627,7 @@ static struct platform_driver qnoc_driver = {
>  	.driver = {
>  		.name = "qnoc-sm8150",
>  		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>  	},
>  };
>  module_platform_driver(qnoc_driver);
> diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
> index 9b58946f7898..49c5ee2e70f0 100644
> --- a/drivers/interconnect/qcom/sm8250.c
> +++ b/drivers/interconnect/qcom/sm8250.c
> @@ -643,6 +643,7 @@ static struct platform_driver qnoc_driver = {
>  	.driver = {
>  		.name = "qnoc-sm8250",
>  		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,
>  	},
>  };
>  module_platform_driver(qnoc_driver);
> 
