Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1A85257F6
	for <lists+linux-pm@lfdr.de>; Fri, 13 May 2022 00:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359275AbiELWqk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354944AbiELWqj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 18:46:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE64B85C
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 15:46:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i17so6248671pla.10
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w7xRYGEEgLlcfSNhLyiae2Suom2+oKJoUELtHjnH1l4=;
        b=JcxyzS2/X+CTAkdqnryxhc1CdjvPBZ6DX7dJAB08YX/K61V5t4vhFW0BZn/hQ+cbUE
         4Dju2qWnEnZm4o7CahLxVzBOo6nqKavIFCjlMbGVer+y5zrTtDFDHDrWav+llnze2g0x
         5x7Jv1JJulg7CUH5L4GwG+2yXJOQ0+bFjF5gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7xRYGEEgLlcfSNhLyiae2Suom2+oKJoUELtHjnH1l4=;
        b=NZkt6o3fDS7/weobI2icfrXlccdkJXUUgcjfTPboxy2YD4M74urjAID6FONz8/qvzM
         7/VJ3iV5qrMRaeRcg1/XKvrsuMqyNx0r7vk6lVP2EYPKHRFuOzvFIbBJK/yrEMT7yITQ
         PQ2H6xIrA5XzIqvKR0u/sE+670b83p/0FO8+F0iLyav3JKUZArN008lDIKQHIKTlluTf
         GOxVCi5qL+Dy03MY+anU5wKne/cVnUPEYzOjrqK3QJ/Ffo5dONXCgk8B6O3h0uoCQ/cj
         XYb+sl4tkF/26DoQ6LrgD5f7wM8sRUm3HsDJuLc+7woUkD7tSAUbz8s95Vo+r42N5r2M
         VUQg==
X-Gm-Message-State: AOAM5339DOtr7dsgQYvWtiRkcQcrN/Ycrzwitfo3T/LFcQTKNNGwskJq
        ZbI4M4nlnqQqfNfCSP2e69YD6A==
X-Google-Smtp-Source: ABdhPJxLdQopQQB82M4oh6IUbuLnZifJOaY3RgFRN8NvEkSNVuq88W7hpERHgcLZHkvW2a9p6vFsBw==
X-Received: by 2002:a17:902:7891:b0:15e:f845:b816 with SMTP id q17-20020a170902789100b0015ef845b816mr1640183pll.60.1652395598075;
        Thu, 12 May 2022 15:46:38 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id 2-20020a17090a19c200b001d5c571f487sm306302pjj.25.2022.05.12.15.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:46:37 -0700 (PDT)
Date:   Thu, 12 May 2022 15:46:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v16 5/5] usb: dwc3: qcom: Keep power domain on to retain
 controller status
Message-ID: <Yn2OTOF07A5jhYSF@google.com>
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
 <1652379802-8318-6-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652379802-8318-6-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 12, 2022 at 11:53:22PM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Keep the power domain always on during runtime suspend or if the
> controller supports wakeup in order to retain controller status
> and to support wakeup from devices.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 9804a19..1f9589a 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pm_domain.h>
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> @@ -718,12 +719,13 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
>  
>  static int dwc3_qcom_probe(struct platform_device *pdev)
>  {
> -	struct device_node	*np = pdev->dev.of_node;
> -	struct device		*dev = &pdev->dev;
> -	struct dwc3_qcom	*qcom;
> -	struct resource		*res, *parent_res = NULL;
> -	int			ret, i;
> -	bool			ignore_pipe_clk;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct dwc3_qcom *qcom;
> +	struct resource	*res, *parent_res = NULL;
> +	int ret, i;
> +	bool ignore_pipe_clk;
> +	struct generic_pm_domain *genpd;
>  
>  	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>  	if (!qcom)
> @@ -732,6 +734,8 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, qcom);
>  	qcom->dev = &pdev->dev;
>  
> +	genpd = pd_to_genpd(qcom->dev->pm_domain);
> +
>  	if (has_acpi_companion(dev)) {
>  		qcom->acpi_pdata = acpi_device_get_match_data(dev);
>  		if (!qcom->acpi_pdata) {
> @@ -839,7 +843,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto interconnect_exit;
>  
> -	device_init_wakeup(&pdev->dev, 1);
> +	genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> +
> +	if (device_may_wakeup(&qcom->dwc3->dev)) {

This should probably be device_can_wakeup(), otherwise you'll have to set/clear
the flag before suspending (the wakeup policy might change after the device is
probed). Also I'm not sure if switching the domain off can impact the power
consumption of some connected peripherals, as is observed when the PHYs are
powered off (I could confirm this if needed).

> +		genpd->flags |= GENPD_FLAG_ALWAYS_ON;
> +		device_init_wakeup(&pdev->dev, true);
> +	}
>  	qcom->is_suspended = false;
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -- 
> 2.7.4
> 
