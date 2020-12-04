Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA6D2CF770
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 00:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLDX2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 18:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgLDX17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 18:27:59 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794AC0613D1
        for <linux-pm@vger.kernel.org>; Fri,  4 Dec 2020 15:27:13 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id y24so6930612otk.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Dec 2020 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLc7/3okPvFxP0Z5cS+hPwJjhxGd6v5dEl0jnqjK1K0=;
        b=xQwJageZbIycG4kTT8ShqMD3nUbwD7r8wUnxsVIIr+DgCBye6qng9WoGeVERzlid29
         k/ObBybIk//OMjj5X5o6YZ0k0F4YAbF832KqRuemDPxAcGvpXGz4INpWkjsvJ/5BU8zJ
         Qf7/ZZlvvJbUKw/nn1qkD3DgSqL7BZqwgj4xqzlmiG/PCX2A4z4QX3GYSWBzdNtfezVv
         hbrkMNgU0Ogaga1hWbEu58REJxvLrJ/YyXTVkcispMWDJKH07SatPkBvKuiG1UyvjT6f
         uRrkVoAcABjtKNGxhr6n3YqlTzMBrQLIw1cXMB8i991kgSJJhcPVqWsPcFOQd3eQ+uR4
         TsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLc7/3okPvFxP0Z5cS+hPwJjhxGd6v5dEl0jnqjK1K0=;
        b=q168E/WNi3DMtWIIVj7S2lnxf8UPoiVk1n7zOmYr5lve2aCnU/7o8qXfv/P6yg+hqk
         y8sGXwYJFD7zt34XyVH0h42mgD17jWLFXtD96laQPwTHYr3c0cECQCTblyAPut/Inp5/
         aKE2F/EY5D3wTAT1n3G4W+DgDCffn15373ARTq8mzl3ZiMkahzvr8mR1s9jnQPRRadjw
         Ak0s+TtxozfTNlXudhG2BCO6WQuatFLADZxvJfrTDZC+TuF/rVSQmZT5+41shXcnpbZ2
         6qbTC7UbF5gr2fr0X+a2J8iBg1prkDHix+MQfds4JG5b3OhzCg+/CqO3T9kAMoy7SE9j
         u/Cw==
X-Gm-Message-State: AOAM53191G8dv5yD2Yuuxn/Ia/hFYu8phmu4M2woX9unFbugGoSgQ/c7
        jpz4gmdaqUS/yqDce1TGf0YyIQ==
X-Google-Smtp-Source: ABdhPJx/5ojyUAiGu0IYqd4XJaPj3ZSo9l52l1eGs5DI9MrJXP8DByhPu8SeKg2BBP6DoIR4XpMftA==
X-Received: by 2002:a9d:7401:: with SMTP id n1mr5323426otk.21.1607124433014;
        Fri, 04 Dec 2020 15:27:13 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k1sm949788ood.4.2020.12.04.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:27:12 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:27:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sibi Sankar <sibis@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: fix rpmh link failures
Message-ID: <X8rFzqURIVHeH4SL@builder.lan>
References: <20201204165030.3747484-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204165030.3747484-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 04 Dec 10:50 CST 2020, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_COMPILE_TEST is set, it is possible to build some
> of the interconnect drivers into the kernel while their dependencies
> are loadable modules, which is bad:
> 
> arm-linux-gnueabi-ld: drivers/interconnect/qcom/bcm-voter.o: in function `qcom_icc_bcm_voter_commit':
> (.text+0x1f8): undefined reference to `rpmh_invalidate'
> arm-linux-gnueabi-ld: (.text+0x20c): undefined reference to `rpmh_write_batch'
> arm-linux-gnueabi-ld: (.text+0x2b0): undefined reference to `rpmh_write_batch'
> arm-linux-gnueabi-ld: (.text+0x2e8): undefined reference to `rpmh_write_batch'
> arm-linux-gnueabi-ld: drivers/interconnect/qcom/icc-rpmh.o: in function `qcom_icc_bcm_init':
> (.text+0x2ac): undefined reference to `cmd_db_read_addr'
> arm-linux-gnueabi-ld: (.text+0x2c8): undefined reference to `cmd_db_read_aux_data'
> 
> The exact dependencies are a bit complicated, so split them out into a
> hidden Kconfig symbol that all drivers can in turn depend on to get it
> right.
> 
> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Your patch looks correct to me, so:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>


But we're going to have to sprinkle a handful of these throughout the
tree and we're not a lot of people who "understand" what it does (and at
least I keep getting them wrong...)

Perhaps it would be more reasonable to maintain this long term if we
drop the possibility of compile testing these drivers independently of
rpmh and command db? (I.e. drop the function stubs and rely on
RPMH/COMMAND_DB to enable building under COMPILE_TEST)?


And just to make it clear, I think we should merge your patch to fix
v5.11; then consider to simplify this past that.

Regards,
Bjorn

> ---
>  drivers/interconnect/qcom/Kconfig | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index a8f93ba265f8..b3fb5b02bcf1 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -42,13 +42,23 @@ config INTERCONNECT_QCOM_QCS404
>  	  This is a driver for the Qualcomm Network-on-Chip on qcs404-based
>  	  platforms.
>  
> +config INTERCONNECT_QCOM_RPMH_POSSIBLE
> +	tristate
> +	default INTERCONNECT_QCOM
> +	depends on QCOM_RPMH || (COMPILE_TEST && !QCOM_RPMH)
> +	depends on QCOM_COMMAND_DB || (COMPILE_TEST && !QCOM_COMMAND_DB)
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Compile-testing RPMH drivers is possible on other platforms,
> +	  but in order to avoid link failures, drivers must not be built-in
> +	  when QCOM_RPMH or QCOM_COMMAND_DB are loadable modules
> +
>  config INTERCONNECT_QCOM_RPMH
>  	tristate
>  
>  config INTERCONNECT_QCOM_SC7180
>  	tristate "Qualcomm SC7180 interconnect driver"
> -	depends on INTERCONNECT_QCOM
> -	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>  	select INTERCONNECT_QCOM_RPMH
>  	select INTERCONNECT_QCOM_BCM_VOTER
>  	help
> @@ -57,8 +67,7 @@ config INTERCONNECT_QCOM_SC7180
>  
>  config INTERCONNECT_QCOM_SDM845
>  	tristate "Qualcomm SDM845 interconnect driver"
> -	depends on INTERCONNECT_QCOM
> -	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>  	select INTERCONNECT_QCOM_RPMH
>  	select INTERCONNECT_QCOM_BCM_VOTER
>  	help
> @@ -67,8 +76,7 @@ config INTERCONNECT_QCOM_SDM845
>  
>  config INTERCONNECT_QCOM_SM8150
>  	tristate "Qualcomm SM8150 interconnect driver"
> -	depends on INTERCONNECT_QCOM
> -	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>  	select INTERCONNECT_QCOM_RPMH
>  	select INTERCONNECT_QCOM_BCM_VOTER
>  	help
> @@ -77,8 +85,7 @@ config INTERCONNECT_QCOM_SM8150
>  
>  config INTERCONNECT_QCOM_SM8250
>  	tristate "Qualcomm SM8250 interconnect driver"
> -	depends on INTERCONNECT_QCOM
> -	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
>  	select INTERCONNECT_QCOM_RPMH
>  	select INTERCONNECT_QCOM_BCM_VOTER
>  	help
> -- 
> 2.27.0
> 
