Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE81C515458
	for <lists+linux-pm@lfdr.de>; Fri, 29 Apr 2022 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380265AbiD2TWp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Apr 2022 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiD2TWo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2022 15:22:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC288C74BA
        for <linux-pm@vger.kernel.org>; Fri, 29 Apr 2022 12:19:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so11345848pju.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Apr 2022 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nbl1l94NSe3Fek2fXmDdi1dWs+tZMPUUMy0P2EiLPLg=;
        b=e+923uX3L34JoxH8inI2ZslZuVikT2P6I5OcFSRPPg8PWVOj34lfOUIuKdw5y2eIN+
         vGUUvNtdpS7vGCww/uqb2kGFOd9R/L99ldLU+nWZITJlCqJONw41uN3MQZD3uQ2//N+M
         crhXv+T8QnJFSY/NAUSKR1o4ahHUVk7dBVY18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nbl1l94NSe3Fek2fXmDdi1dWs+tZMPUUMy0P2EiLPLg=;
        b=BGquUAG88BxT7/PfNL2ZYjJUNh1PdyNh+lLlljR4cFYGV/4mflhFkSc0qUbxppkZZY
         PzzADkI4safQ1AEI037ZJ/7zF4btUOQJ6k/l/WUi+cJPs/lK9mYBtwd7xKaHh/36YmeB
         IhJfzMkK44vOtoWO0dcLCcm8MY8mFmxBdSHnLW9fNMSE3ppWlLH5/Ph3UpL4sc5WS1ay
         mxSoUtFodHW910WFHVW00jBlpOHKvDAdcBtVh7pe2Reip+GoASoExlu4bo/xLtAMRT1G
         jmYa1CN8nAa8zxpWvcAXBLzaKbTkVzaUP+X9P9u6Wb9dLFS6gKkhFa9H+OE58bxSjjyv
         Rm7Q==
X-Gm-Message-State: AOAM530IXyk7BBTFGKddsaNjTJc4J5caFn6vPpfqf8DPJrLOhJ8jt76i
        4O6NN5qWncAO+68u2XZXNdLTpg==
X-Google-Smtp-Source: ABdhPJx5izOWf80ef6ldgjmrgWzIUTHlyiEV4R/ZZm5TorJpza0hZq8zsUWD1pcGPG5bzvzzP3PbRg==
X-Received: by 2002:a17:90b:4a09:b0:1d2:de49:9be8 with SMTP id kk9-20020a17090b4a0900b001d2de499be8mr5668726pjb.68.1651259965279;
        Fri, 29 Apr 2022 12:19:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7d14:5f45:9377:9b6a])
        by smtp.gmail.com with UTF8SMTPSA id m8-20020a17090a414800b001d81a30c437sm11380455pjg.50.2022.04.29.12.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 12:19:24 -0700 (PDT)
Date:   Fri, 29 Apr 2022 12:19:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        quic_ppratap@quicinc.com, quic_kriskura@quicinc.com,
        quic_vpulyala@quicinc.com
Subject: Re: [PATCH v14 2/7] PM / wakeup: Add device_children_wakeup_capable()
Message-ID: <Ymw6Og/qhg3D0mx+@google.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
 <CAJZ5v0h2ZKPN6SERPnASPywZfeOWXWncJgNZ1WZa80+=M4DCiQ@mail.gmail.com>
 <YmL3lMaR79wPMEfY@google.com>
 <20220425130303.GA16319@hu-pkondeti-hyd.qualcomm.com>
 <20220429125956.GD16319@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220429125956.GD16319@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavan,

On Fri, Apr 29, 2022 at 06:29:56PM +0530, Pavan Kondeti wrote:
> Hi Matthias,
> 
> On Mon, Apr 25, 2022 at 06:33:03PM +0530, Pavan Kondeti wrote:
> > Hi Matthias,
> > 
> > On Fri, Apr 22, 2022 at 11:44:36AM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Apr 22, 2022 at 01:57:17PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Apr 19, 2022 at 9:11 PM Sandeep Maheswaram
> > > > <quic_c_sanm@quicinc.com> wrote:
> > > > >
> > > > > From: Matthias Kaehlcke <mka@chromium.org>
> > > > >
> > > > > Add device_children_wakeup_capable() which checks whether the device itself
> > > > > or one if its descendants is wakeup capable.
> > > > 
> > > > device_wakeup_path() exists for a very similar purpose.
> > > > 
> > > > Is it not usable for whatever you need the new function introduced here?
> > > 
> > > I wasn't aware of it's function, there are no doc comments and the
> > > name isn't really self explanatory.
> > > 
> > > In a quick test device_wakeup_path() returned inconsistent values for the
> > > root hub, sometimes true, others false when a wakeup capable USB device was
> > > connected.
> > 
> > We will also test the same to double confirm the behavior of
> > device_wakeup_path(). I am assuming that you checked device_wakeup_path()
> > only during system suspend path.
> > 
> > Here is what I understood by looking at __device_suspend(). Please share
> > your thoughts on this.
> > 
> > power.wakeup_path is set to true for the parent *after* a wakeup capable
> > device is suspended. This means when the root hub(s) is suspended, it is
> > propagated to xhci-plat and when xhci-plat is suspended, it is propagated
> > to dwc3. bottom up propgation during system suspend.
> > 
> > I believe we can directly check something like this in the dwc3 driver
> > instead of having another wrapper like device_children_wakeup_capable().
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 1170b80..a783257 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1878,8 +1878,14 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> >  		break;
> >  	case DWC3_GCTL_PRTCAP_HOST:
> >  		if (!PMSG_IS_AUTO(msg)) {
> > +			/*
> > +			 * Don't kill the host when dwc3 is wakeup capable and
> > +			 * its children needs wakeup.
> > +			 */
> > +			if (device_may_wakeup(dwc->dev) && device_wakeup_path(dwc->dev))
> > +				handle_it();
> > +		} else {
> >  			dwc3_core_exit(dwc);
> > -			break;
> >  		}
> >  
> >  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > 
> 
> device_wakeup_path(dwc->dev) is returning true all the time irrespective of
> the wakeup capability (and enabled status) of the connected USB devices. That
> is because xhci-plat device is configured to wakeup all the time. Since the
> child is wakeup capable, its parent i.e dwc3 has device_wakeup_path() set.
> device_children_wakeup_capable() will also suffer the problem. However,
> 
> device_children_wakeup_capable(&hcd->self.root_hub->dev) is what Sandeep's
> patch is using. That is not correct. we have two root hubs (HS and SS) associated
> with a USB3 controller and calling it on one root hub is incorrect. 
> device_children_wakeup_capable() must be called on xhci-plat so that it covers
> both HS and SS root hubs

Thanks for pointing that out!

> I am thinking of dynamically enabling/disabling xhci-plat wakeup capability so
> that the wakeup path is correctly propagated to dwc3. something like below.
> Does it make sense to you?
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 649ffd8..be0c55b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -412,6 +412,9 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
>  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
>  	int ret;
>  
> +	if (!device_wakeup_path(dev))
> +		device_wakeup_disable(dev);
> +
>  	if (pm_runtime_suspended(dev))
>  		pm_runtime_resume(dev);
>  
> @@ -443,6 +446,8 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
>  
> +	device_wakeup_enable(dev);

I think this also needs to be done conditionally, otherwise it would
create a new wake source on every resume when wakeup is already
enabled.

Other than that this seems to do the trick and keeps the USB layer out of
the dwc3 code.
