Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E82EB6EE
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJaSar (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:30:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39491 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfJaSar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:30:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id t12so3059764plo.6
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDLgnjlfCqOct3IUAYiTtJNr4GeoIF5s9l08Zwa0OD8=;
        b=amiQUKxQ8r5QD8yO0TrYXU2yeIQl4u48G7fpD9hounWYf8T9OMfb3TQWB/cnODIHL8
         NAbpSQ9dAfyFoyaN6nK6C9Hi7zr0FGqbnNCZnTWMUn7+PjNm7/4HxiBpO4kBWWSlOB0W
         ofzmOWbTOZmhNHgs/QrMb7j3/jNC5OIzDk5CALHfSoxiJ89gDMWRlnNRVzbuJQHpDwfQ
         IxFUJw/uUkXrFOdwLV95N8K0cGuMo13ZZOpWtQJmaVIZ/1rp+BDaiqEYYr83SRrc18HI
         F4+0pb3zoXOj1AEJbidQlAH6IbD1oCkc/Tn7Z8p1tDlz2ZD/qTAHV9vAM89hz4bjB3d8
         J3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDLgnjlfCqOct3IUAYiTtJNr4GeoIF5s9l08Zwa0OD8=;
        b=XXGuGlm0uWWnVYd6tI2KLFO6Ck5uKk9ET1w+2cF7QyxtDZtbqagICR1iCI/zcN5vxa
         swRVws2xv/SgDcj1HBMBKznY4mGEgtjQrT5EOAYtTUF8ddyazctrHpc68pBcpAVFATy1
         g/n3NkcqWCgYLtDmkitTYchmoWPEcwhTu3jkSP8spyoMJVYaStg3D4VDJtz54rCNaGoz
         3aVZaWtnCwPN/buKBo4jtk2cRF/he9aFbwXdzrz8Pq8I2h5pHq+HbWEaezj4uA8b+ULy
         1qUzPcbLnigm7zg+HqbA3P8RxOjBr/cUJTma7DDt6jkKmPWJ84ZM6/uVxXr5XPHtgOIJ
         FtzQ==
X-Gm-Message-State: APjAAAUpDVzhsm52j5lmjm6d0/rW3odDcC7aolenbMmWH2qp199RVfMD
        9cxfb6hxRhHQ3GugAjTHJ6mbmA==
X-Google-Smtp-Source: APXvYqyvfpgoDyKhy38LVc7UX/Did4CiGoO2WTFO2f+HTSlsF788bmvCRJj5GrHyKgKPxF1mxfcvYQ==
X-Received: by 2002:a17:902:ab89:: with SMTP id f9mr7925359plr.295.1572546646384;
        Thu, 31 Oct 2019 11:30:46 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g9sm5760292pjl.20.2019.10.31.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:30:45 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:30:43 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/2] interconnect: Move interconnect drivers to
 core_initcall
Message-ID: <20191031183043.GL1929@tuxbook-pro>
References: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
 <1572546532-19248-2-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572546532-19248-2-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 31 Oct 11:28 PDT 2019, Jordan Crouse wrote:

> The interconnect drivers are essential to nearly every leaf driver and
> subcomponent in the SoC. Initialize them at the core_initcall level
> so that they are available to their dependent drivers when built in.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
>  drivers/interconnect/qcom/msm8974.c | 14 +++++++++++++-
>  drivers/interconnect/qcom/qcs404.c  | 14 +++++++++++++-
>  drivers/interconnect/qcom/sdm845.c  | 13 ++++++++++++-
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
> index c70ac58..9386d5c 100644
> --- a/drivers/interconnect/qcom/msm8974.c
> +++ b/drivers/interconnect/qcom/msm8974.c
> @@ -778,7 +778,19 @@ static struct platform_driver msm8974_noc_driver = {
>  		.of_match_table = msm8974_noc_of_match,
>  	},
>  };
> -module_platform_driver(msm8974_noc_driver);
> +
> +static int __init msm8974_noc_driver_init(void)
> +{
> +	return platform_driver_register(&msm8974_noc_driver);
> +}
> +core_initcall(msm8974_noc_driver_init);
> +
> +static void __exit msm8974_noc_driver_exit(void)
> +{
> +	platform_driver_unregister(&msm8974_noc_driver);
> +}
> +module_exit(msm8974_noc_driver_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm MSM8974 NoC driver");
>  MODULE_AUTHOR("Brian Masney <masneyb@onstation.org>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
> index b4966d8..7dd3e76 100644
> --- a/drivers/interconnect/qcom/qcs404.c
> +++ b/drivers/interconnect/qcom/qcs404.c
> @@ -535,6 +535,18 @@ static struct platform_driver qcs404_noc_driver = {
>  		.of_match_table = qcs404_noc_of_match,
>  	},
>  };
> -module_platform_driver(qcs404_noc_driver);
> +
> +static int __init qcs404_noc_driver_init(void)
> +{
> +	return platform_driver_register(&qcs404_noc_driver);
> +}
> +core_initcall(qcs404_noc_driver_init);
> +
> +static void __exit qcs404_noc_driver_exit(void)
> +{
> +	platform_driver_unregister(&qcs404_noc_driver);
> +}
> +module_exit(qcs404_noc_driver_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm QCS404 NoC driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> index 502a6c2..4dab92a 100644
> --- a/drivers/interconnect/qcom/sdm845.c
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -892,7 +892,18 @@ static struct platform_driver qnoc_driver = {
>  		.of_match_table = qnoc_of_match,
>  	},
>  };
> -module_platform_driver(qnoc_driver);
> +
> +static int __init qnoc_driver_init(void)
> +{
> +	return platform_driver_register(&qnoc_driver);
> +}
> +core_initcall(qnoc_driver_init);
> +
> +static void __exit qnoc_driver_exit(void)
> +{
> +	platform_driver_unregister(&qnoc_driver);
> +}
> +module_exit(qnoc_driver_exit);
>  
>  MODULE_AUTHOR("David Dai <daidavid1@codeaurora.org>");
>  MODULE_DESCRIPTION("Qualcomm sdm845 NoC driver");
> -- 
> 2.7.4
> 
