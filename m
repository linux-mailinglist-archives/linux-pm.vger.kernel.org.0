Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1F732C4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 17:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfGXPbE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 11:31:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfGXPbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 11:31:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so32252381lfm.10
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w04TwcBlrwE0OA2QepWCIyollMUBH4W0M6LcA4jtxc4=;
        b=AjM19knBV84Dn1ZuV7wNvmsmmirz1UY6xC79pbJYVejpy1o6FJZS/OOfMvWLILrYRI
         KgCiUyz3E+DJLovwOe2ERKXIcw1Gf04vpzKyUS7E9m0aoUwRb8vVLufVFNZJl46ULvZG
         T9wQyXEzEETSWc+CzxB4t1aV4BBiC2S2RUl9Ie5q2Q3rawXi+CAQj9USLYUsyGCjdDkc
         4IrpjUX5adig8IFh5u2LmPQH/M+zWLJ6T2VFuF4bXaV1XJ4ZAQetoVjtQJgmKLesbJGJ
         ql2ydeAfHrPkE7C3b51d3j8VAIlhrNQ1ymJAn1uh0WWgg9mXQXZyeG3w5mZvaDij0fIE
         Un3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w04TwcBlrwE0OA2QepWCIyollMUBH4W0M6LcA4jtxc4=;
        b=WauTxRS+Lv5cHsYQMCm0ntcx25yEfqqyw2ititY6Vdocn6QNbx1S04O4kKepHAM1Ta
         W1zsqspchz7uQ07EGfJt6J6SUSLvQtehOKnCKxCFuTvZsC7kdN5/f3JLyX139a3G8s+l
         l/IZMlIJLavb/XdIPghUxppQSzCixXej50gvFL/xaxmXGKw3KprMp8UMJXqsY7JIPvXO
         FlBUk+VNEjpPK+UnwsoEUjmm5xt/t2C5jg259quD+5dxVO4wSUQo/8otYKp0xoqZ3yX5
         5Jo2c5cHLK4nwsVknHLuX4Tw/p8D3wI7vm8eOy3jZsvSdMmHyGcAobPsz+GUzbILeqZA
         owJQ==
X-Gm-Message-State: APjAAAVeOLeEfSF4ek7Kfj7xLCPmMJ3LJGXo3uPY5bzra99pO4dnZcqZ
        v4YQHa7ZtWxvcAl+mlIXlq510g==
X-Google-Smtp-Source: APXvYqwZaetBqiZkU3WyKGnWXjAjS11aiAKWTs8GvtiBVKZJwmURwRiQwY55D2YKhy42HTE67eo63g==
X-Received: by 2002:a05:6512:1d2:: with SMTP id f18mr37896536lfp.173.1563982260973;
        Wed, 24 Jul 2019 08:31:00 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id q4sm9720175lje.99.2019.07.24.08.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 08:31:00 -0700 (PDT)
Subject: Re: [PATCH] qcom: Add BCM vote macro to TCS header
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     ilina@codeaurora.org, bjorn.andersson@linaro.org,
        linux-pm@vger.kernel.org,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
References: <1563378793-22023-1-git-send-email-jcrouse@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <31e9d2c6-edcd-11b8-4c4b-d51ed2d8f7b7@linaro.org>
Date:   Wed, 24 Jul 2019 18:30:58 +0300
MIME-Version: 1.0
In-Reply-To: <1563378793-22023-1-git-send-email-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jordan,

On 7/17/19 18:53, Jordan Crouse wrote:
> The A6XX family of Adreno GPUs use a microcontroller to control the
> GPU clock independently. The microcontroller also has the capability
> to vote for the bus but doesn't currently do so except for one initial
> vote that is hard coded [1].
> 
> Currently there is no good way to construct a valid TCS command outside
> of the inner workings of the QCOM interconnect driver which is something
> that will need to be addressed for the next generation of GPU drivers.
> 
> To start the process, this change moves the TCS command macros from the
> sdm845 interconnect driver into a soc specific header to make it available
> for future efforts into this area.

I agree that we should move the TCS macros into tsc.h. There is also a similar
macro in drivers/clk/qcom/clk-rpmh.c. Maybe we can replace both with a common one?

Thanks,
Georgi

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/msm/adreno/a6xx_hfi.c#n219
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/interconnect/qcom/sdm845.c | 17 -----------------
>  include/soc/qcom/tcs.h             | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 4915b78..79b6f01 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -20,23 +20,6 @@
>  #include <soc/qcom/rpmh.h>
>  #include <soc/qcom/tcs.h>
>  
> -#define BCM_TCS_CMD_COMMIT_SHFT		30
> -#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
> -#define BCM_TCS_CMD_VALID_SHFT		29
> -#define BCM_TCS_CMD_VALID_MASK		0x20000000
> -#define BCM_TCS_CMD_VOTE_X_SHFT		14
> -#define BCM_TCS_CMD_VOTE_MASK		0x3fff
> -#define BCM_TCS_CMD_VOTE_Y_SHFT		0
> -#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
> -
> -#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
> -	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
> -	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
> -	((cpu_to_le32(vote_x) &					\
> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
> -	((cpu_to_le32(vote_y) &					\
> -	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> -
>  #define to_qcom_provider(_provider) \
>  	container_of(_provider, struct qcom_icc_provider, provider)
>  
> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
> index 262876a..6012a9e 100644
> --- a/include/soc/qcom/tcs.h
> +++ b/include/soc/qcom/tcs.h
> @@ -53,4 +53,21 @@ struct tcs_request {
>  	struct tcs_cmd *cmds;
>  };
>  
> +#define BCM_TCS_CMD_COMMIT_SHFT		30
> +#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
> +#define BCM_TCS_CMD_VALID_SHFT		29
> +#define BCM_TCS_CMD_VALID_MASK		0x20000000
> +#define BCM_TCS_CMD_VOTE_X_SHFT		14
> +#define BCM_TCS_CMD_VOTE_MASK		0x3fff
> +#define BCM_TCS_CMD_VOTE_Y_SHFT		0
> +#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
> +
> +#define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
> +	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
> +	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
> +	((cpu_to_le32(vote_x) &					\
> +	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
> +	((cpu_to_le32(vote_y) &					\
> +	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> +
>  #endif /* __SOC_QCOM_TCS_H__ */
> 
