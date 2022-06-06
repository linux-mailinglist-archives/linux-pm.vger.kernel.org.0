Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B353F137
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jun 2022 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiFFU5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jun 2022 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiFFU4s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 16:56:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECD8106A71
        for <linux-pm@vger.kernel.org>; Mon,  6 Jun 2022 13:45:54 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u2so13663796pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2022 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1MYgC5T5e5Y+j3sUQDRFkx2mXQdu9/FeqjllZOguTI=;
        b=Nb68eKSk0EqDzcMgyGdZaXPHSOspFn2UrOnyBXqnGbXVO9SyCXhbm4OFKVpLBB21v8
         L+rv1FTctVUSpwHRCj07ceZR/MV0Sv3QT/e3z3OPpnc4FtLUoEIRWUjrFSFqZqVr/KkU
         XIVxbDE2+37Dp4hVlnQ+42fmsnuyM8gOe1LDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1MYgC5T5e5Y+j3sUQDRFkx2mXQdu9/FeqjllZOguTI=;
        b=5yX8yQ0RocyNB4SbL0EbUy+3nhlN6p1PT/Jk0JtZZQmcsdsNCyEQFN0Ird4eZmbxub
         XwuwIuP1SFZTaz0XioAoJdKU7Vbpfly36d7dsDiBAB7/o/qxic0jiEX7fh3cj2+zUaAD
         uFNISulkaJJv6t17+YVgZBedR+7gYFV9Bhh5gvmmRZH0rkA/wapTc80t+05RUduGY0BH
         6yQmjUgbmtJXvWOajmKWtqmmFpWghVIMQO5vB3fNjzxVwid1izfQ4QAi9L2EfB0p28VN
         NYEA0k0S2daH+R8Xc9jVazlIXUyANq+zRLGZf6x+D0CUPJcy9cEWWWGRi+oOD4ITeqbD
         Bj8Q==
X-Gm-Message-State: AOAM5338TPYknzTi5ruLhlb7I6bOA3iezgfS6owBKE452S3t2jeqrPl4
        MLPZST9cgz3sMpOt+wwWy+2GsOjs6S4Jyw==
X-Google-Smtp-Source: ABdhPJwWjV+ZcZBiw7her510xIgFT3A3gR32FqSTa4dJg1oykKnZusf5iQQ2b9OYed3KiAyxFPGanA==
X-Received: by 2002:a05:6a00:1485:b0:518:e601:dffb with SMTP id v5-20020a056a00148500b00518e601dffbmr26087994pfu.38.1654548353983;
        Mon, 06 Jun 2022 13:45:53 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:196:a14c:7344:f6db])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a170902714200b001621cd83e49sm10954415plm.92.2022.06.06.13.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 13:45:53 -0700 (PDT)
Date:   Mon, 6 Jun 2022 13:45:51 -0700
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
Message-ID: <Yp5nf2w8uVZ38/XZ@google.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YpkRDi2m7cLaKYEf@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 02, 2022 at 12:35:42PM -0700, Matthias Kaehlcke wrote:
> Hi Krishna,
> 
> with this version I see xHCI errors on my SC7180 based system, like
> these:
> 
> [   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit
> 
> [  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout
> 
> After resume a downstream hub isn't enumerated again.
> 
> So far I didn't see those with v13, but I aso saw the first error with
> v16.

It also happens with v13, but only when a wakeup capable vUSB <= 2
device is plugged in. Initially I used a wakeup capable USB3 to
Ethernet adapter to trigger the wakeup case, however older versions
of this series that use usb_wakeup_enabled_descendants() to check
for wakeup capable devices didn't actually check for vUSB > 2
devices.

So the case were the controller/PHYs is powered down works, but
the controller is unhappy when the runtime PM path is used during
system suspend.

> On Thu, Jun 02, 2022 at 01:54:34PM +0530, Krishna Kurapati wrote:
> > From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > 
> > Check wakeup-source property for dwc3 core node to set the
> > wakeup capability. Drop the device_init_wakeup call from
> > runtime suspend and resume.
> > 
> > If the dwc3 is wakeup capable, don't power down the USB PHY(s).
> > The glue drivers are expected to take care of configuring the
> > additional wakeup settings if needed based on the dwc3 wakeup
> > capability status. In some SOC designs, powering off the PHY is
> > resulting in higher leakage, so this patch save power on such boards.
> > 
> > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> > ---
> >  drivers/usb/dwc3/core.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index e027c04..b99d3c2 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1787,6 +1787,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, dwc);
> >  	dwc3_cache_hwparams(dwc);
> > +	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> >  
> >  	spin_lock_init(&dwc->lock);
> >  	mutex_init(&dwc->mutex);
> > @@ -1948,7 +1949,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  		dwc3_core_exit(dwc);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg)) {
> > +		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> >  			dwc3_core_exit(dwc);
> >  			break;
> >  		}
> > @@ -2009,7 +2010,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
> >  		spin_unlock_irqrestore(&dwc->lock, flags);
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> > -		if (!PMSG_IS_AUTO(msg)) {
> > +		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
> >  			ret = dwc3_core_init_for_resume(dwc);
> >  			if (ret)
> >  				return ret;
> > @@ -2086,8 +2087,6 @@ static int dwc3_runtime_suspend(struct device *dev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	device_init_wakeup(dev, true);
> > -
> >  	return 0;
> >  }
> >  
> > @@ -2096,8 +2095,6 @@ static int dwc3_runtime_resume(struct device *dev)
> >  	struct dwc3     *dwc = dev_get_drvdata(dev);
> >  	int		ret;
> >  
> > -	device_init_wakeup(dev, false);
> > -
> >  	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
> >  	if (ret)
> >  		return ret;
> > -- 
> > 2.7.4
> > 
