Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4EC53BEE2
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jun 2022 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiFBTfq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jun 2022 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiFBTfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2022 15:35:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B4192B9
        for <linux-pm@vger.kernel.org>; Thu,  2 Jun 2022 12:35:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u18so5322889plb.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2022 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cx/w23z3LclUVeD0RGwvqrmhkO0x9NOq8RLmyjTtPOM=;
        b=lYVfR+YOq3qnx85Svvnsb2n7uiC27e2K2siHC/xyiklXI2m0N0FdTE4teMxk2RBxmm
         8ifjjL4B7GGGUjzg261ufFGrAeYN06AC7Np+7rv8QsII/6wMLAcdEcIEGvhQIdMewr4M
         kojvmoOEF9+Nen9ZvBM5a4t7oP6Ly0/7s5G6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cx/w23z3LclUVeD0RGwvqrmhkO0x9NOq8RLmyjTtPOM=;
        b=irIzwA6e8TDF3UA4eO9RZ9l7+3xKxEDS8DStopJnLtTZmQTAqNcBj7PMOPP87oURGS
         lyMTyGzYVtCtY7Zujvy987Wzz2YFiy1axF5MQkB69PRlPVeRgKzZIA6T/kI7pDnXMZ4f
         X0ojRo5bFUb9XAqVPShAP9x1dXKip5XXtnN/IUUi4r/g8JFc9QM4GgEYBqwIkZNqDhgw
         QFzDmSs4cDBJuVtjZ0k14oAoX2T5YjBUIGM//7wnJQdJFuvpi4kDNmYGCpyS1083anzF
         GVAdR3oEmb8/gvX2DOchI0wz8At7Yc+lqtbCkHQHOJ8C/IZmxYAb82lGWeJv+4ktbGD2
         ymyQ==
X-Gm-Message-State: AOAM533TKeohb4y/5+xQuEv0ht4TyUxOt6G7/MP3EUaH0GD3GtXtykEv
        /GLg68e20CZJkP0MLMEgwSA4jQ==
X-Google-Smtp-Source: ABdhPJxE722AkWZmxdhlAA/lfEu+HZH5UVTLDBfMV3ZCHmXDg3l6lmRd50aXEJM5XF73P7Xl/H8gLA==
X-Received: by 2002:a17:902:ed53:b0:166:3e43:7522 with SMTP id y19-20020a170902ed5300b001663e437522mr5530822plb.170.1654198543994;
        Thu, 02 Jun 2022 12:35:43 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:51d0:66d6:2fb5:b395])
        by smtp.gmail.com with UTF8SMTPSA id m12-20020a170902d18c00b001616e19537esm3809964plb.213.2022.06.02.12.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 12:35:43 -0700 (PDT)
Date:   Thu, 2 Jun 2022 12:35:42 -0700
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
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YpkRDi2m7cLaKYEf@google.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krishna,

with this version I see xHCI errors on my SC7180 based system, like
these:

[   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit

[  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout

After resume a downstream hub isn't enumerated again.

So far I didn't see those with v13, but I aso saw the first error with
v16.

I can do some more digging next week.

On Thu, Jun 02, 2022 at 01:54:34PM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Check wakeup-source property for dwc3 core node to set the
> wakeup capability. Drop the device_init_wakeup call from
> runtime suspend and resume.
> 
> If the dwc3 is wakeup capable, don't power down the USB PHY(s).
> The glue drivers are expected to take care of configuring the
> additional wakeup settings if needed based on the dwc3 wakeup
> capability status. In some SOC designs, powering off the PHY is
> resulting in higher leakage, so this patch save power on such boards.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> ---
>  drivers/usb/dwc3/core.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index e027c04..b99d3c2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1787,6 +1787,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dwc);
>  	dwc3_cache_hwparams(dwc);
> +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
>  
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);
> @@ -1948,7 +1949,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>  		dwc3_core_exit(dwc);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> +		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
>  			dwc3_core_exit(dwc);
>  			break;
>  		}
> @@ -2009,7 +2010,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  		break;
>  	case DWC3_GCTL_PRTCAP_HOST:
> -		if (!PMSG_IS_AUTO(msg)) {
> +		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
>  			ret = dwc3_core_init_for_resume(dwc);
>  			if (ret)
>  				return ret;
> @@ -2086,8 +2087,6 @@ static int dwc3_runtime_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	device_init_wakeup(dev, true);
> -
>  	return 0;
>  }
>  
> @@ -2096,8 +2095,6 @@ static int dwc3_runtime_resume(struct device *dev)
>  	struct dwc3     *dwc = dev_get_drvdata(dev);
>  	int		ret;
>  
> -	device_init_wakeup(dev, false);
> -
>  	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>  	if (ret)
>  		return ret;
> -- 
> 2.7.4
> 
