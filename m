Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF0F533346
	for <lists+linux-pm@lfdr.de>; Wed, 25 May 2022 00:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbiEXWK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 May 2022 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiEXWK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2022 18:10:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A5819AC
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 15:10:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3409004pjq.2
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2022 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y7QkV8r/KLZMiTae8DdBEkpYYSnvZxhbdkPijh+HR0w=;
        b=WGePzYWOS0TR2PwNiWKrPbOkDbWSJFzcli09MrtLdjM6gINy9pwQ7ML+/MSYlyfsfN
         wj+piMgpir2ZDOJVYO3mHg1qZMUqIv+RAdIgb/vcFZgdejrhpZUpht2+viWpIsEuOb4h
         5LyFFA3gByMPURP66ILdd8t9aYw4zEjxlEELk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y7QkV8r/KLZMiTae8DdBEkpYYSnvZxhbdkPijh+HR0w=;
        b=Bhui2TmEVKNWDTYMVyJ8XF27gNUAjOPxz1ajETRUOYufETggttz6vTOB/lbWvdNCi3
         eqaWhVqkGLKYabfZljxgQQI8PQb1EpTb8eDXnEDjPdGtKSMjf2O8rTlcwA8R4G6EcCX4
         sMbEdynEntPIadhrze2plc28OdVWjb3HcvQapZbhqs0LLBdGszuNGDTN15L/2vhqDzym
         LuxHWXNA8s4DUqOc7meLj1SU+pGy3Ys/njw8kppEV2B4D8hUcLxALBZoo13q0KvEJbEe
         IubB0N7dh8r1hHlvipfVf5a2clEfEmt/LRHZGOvfo5J3k9tG86NCwDU30jHY/INYoXh4
         A8CQ==
X-Gm-Message-State: AOAM531FL6ogiwmiq/+8NC2Ae9Z+JRKf7znYvsbL15JT4kvxcnKIgXQQ
        bZIVqDJX0gDTlU8hTHkJESYc2Q==
X-Google-Smtp-Source: ABdhPJwwFaSFsAx87UW6m4AZL2Z81scAqlljR5FX8fSUBRTjAd0skm5/+NQYrCW4zuduzXs90Pblmw==
X-Received: by 2002:a17:903:10c:b0:161:f1fb:fb18 with SMTP id y12-20020a170903010c00b00161f1fbfb18mr23230070plc.78.1653430224770;
        Tue, 24 May 2022 15:10:24 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:4d83:f549:9abd:427])
        by smtp.gmail.com with UTF8SMTPSA id k6-20020a170902d58600b0015ea95948ebsm7683120plh.134.2022.05.24.15.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:10:24 -0700 (PDT)
Date:   Tue, 24 May 2022 15:10:22 -0700
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
Subject: Re: [PATCH v17 4/5] usb: dwc3: qcom: Configure wakeup interrupts
 during suspend
Message-ID: <Yo1XzhTTxzRiNN8O@google.com>
References: <1653387228-28110-1-git-send-email-quic_kriskura@quicinc.com>
 <1653387228-28110-5-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653387228-28110-5-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 24, 2022 at 03:43:47PM +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Configure DP/DM line interrupts based on the USB2 device attached to
> the root hub port. When HS/FS device is connected, configure the DP line
> as falling edge to detect both disconnect and remote wakeup scenarios. When
> LS device is connected, configure DM line as falling edge to detect both
> disconnect and remote wakeup. When no device is connected, configure both
> DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

With the addition of dwc3_qcom_update_usb2_speed() the patch has changed a
bit since my review, I'm generally on board with the direction this is going,
but please remove my R-B tag for now.

> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 74 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7352124..5d5db62 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -20,7 +20,8 @@
>  #include <linux/usb/of.h>
>  #include <linux/reset.h>
>  #include <linux/iopoll.h>
> -
> +#include <linux/usb/hcd.h>
> +#include <linux/usb.h>
>  #include "core.h"
>  
>  /* USB QSCRATCH Hardware registers */
> @@ -296,11 +297,37 @@ static void dwc3_qcom_interconnect_exit(struct dwc3_qcom *qcom)
>  	icc_put(qcom->icc_path_apps);
>  }
>  
> -static void dwc3_qcom_enable_wakeup_irq(int irq)
> +enum usb_device_speed dwc3_qcom_update_usb2_speed(struct dwc3_qcom *qcom)
> +{
> +	struct dwc3	*dwc = platform_get_drvdata(qcom->dwc3);
> +	struct usb_hcd	*hcd = platform_get_drvdata(dwc->xhci);
> +	struct usb_device *udev;
> +	enum usb_device_speed usb2_speed;

nit: dwc and hcd are indented to align, udev and usb2_speed not. Either align
the indentation or not, but don't be inconsistent. My vote goes for removing
the alignment.

> +
> +	/*
> +	 * It is possible to query the speed of all children of
> +	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
> +	 * currently supports only 1 port per controller. So
> +	 * this is sufficient.
> +	 */
> +	udev = usb_hub_find_child(hcd->self.root_hub, 1);
> +
> +	if (udev)
> +		usb2_speed = udev->speed;
> +	else
> +		usb2_speed = USB_SPEED_UNKNOWN;
> +
> +	return usb2_speed;

nit: you could get away without 'usb2_speed':

	if (!udev)
		return USB_SPEED_UNKNOWN;

	return udev->speed;

