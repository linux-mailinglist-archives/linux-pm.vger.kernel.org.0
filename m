Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8FD517B9D
	for <lists+linux-pm@lfdr.de>; Tue,  3 May 2022 03:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiECBTh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 21:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiECBT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 21:19:28 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC2A7
        for <linux-pm@vger.kernel.org>; Mon,  2 May 2022 18:15:57 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5e433d66dso15923058fac.5
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2022 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J67hCTMUSeaGPBCalr+a5sKpexZV8EhEsJdHelQjXVI=;
        b=Wxik6QIgF8vn2rRuO2T+saWcOy6xHdSOM0DOBcaOym6CYXCKFr2W0cdwKLqFBz542M
         FbTYz9FTStGR+cSQNoQZs38M1hsyPoig2qUqkRGiaglB71l/0yxHgrivIxEy0MbdVBR4
         UoEWzAP5QCUHNSctCZq0k2KM/R0krl6aEBt9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J67hCTMUSeaGPBCalr+a5sKpexZV8EhEsJdHelQjXVI=;
        b=zpCt+BF4tb3J+7lknsT8bUHuyQ2VEdN6695H2IOaOb8TzzznYDAHY1z6nvDJVtoBzD
         uzytYJHX02r5Rl80gFAanx2eoRuH+HpwWIBXerPDeHGrPtCoRcuVLvRJZr+Oojn/0WnX
         4ydIPZcuBngLDrnsAbhLNmPLfy7z0WH9jxh2lWwjdSiwaeHd8YNeZx6cSHf/ihReLYyi
         jQYySFzIompyKm/AWjhQaV0E6mArbRtCGXF+JS3BxGGwLFz8wIZZaloIy6Ka0sTHhuCi
         i5hX9PKQHr38wp3Yg4yAyq5Zy2Ntw4KyqRXsmG1FRBkWlX3Tpz/cicNzYuMPHuo13Ihw
         aZkQ==
X-Gm-Message-State: AOAM531slEc6ilSFU4hUbTVq2X1F8ElqRLjlcGSmiJ1reXHrCc2Tf8xB
        v28YmOiTrP1kf9q9mmXyDiioc9Kh3VXHIA==
X-Google-Smtp-Source: ABdhPJzhwaYb+Lw7ewxwO+ThJeqEp0Ndm8o2FfTV+9qwaSeSPak30MukVHhjdKIGtmyV/wnkmw1VRg==
X-Received: by 2002:a17:90a:4a95:b0:1d8:2918:7065 with SMTP id f21-20020a17090a4a9500b001d829187065mr2010761pjh.117.1651539457581;
        Mon, 02 May 2022 17:57:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1e1a:955c:a9ca:e550])
        by smtp.gmail.com with UTF8SMTPSA id n23-20020aa78a57000000b0050dc76281a6sm5289698pfa.128.2022.05.02.17.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 17:57:36 -0700 (PDT)
Date:   Mon, 2 May 2022 17:57:35 -0700
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
Message-ID: <YnB9/0NbQImdUObf@google.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
 <1650395470-31333-3-git-send-email-quic_c_sanm@quicinc.com>
 <CAJZ5v0h2ZKPN6SERPnASPywZfeOWXWncJgNZ1WZa80+=M4DCiQ@mail.gmail.com>
 <YmL3lMaR79wPMEfY@google.com>
 <20220425130303.GA16319@hu-pkondeti-hyd.qualcomm.com>
 <20220429125956.GD16319@hu-pkondeti-hyd.qualcomm.com>
 <Ymw6Og/qhg3D0mx+@google.com>
 <20220430031130.GE16319@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220430031130.GE16319@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pavan,

On Sat, Apr 30, 2022 at 08:41:30AM +0530, Pavan Kondeti wrote:
> Hi Matthias,
> 
> On Fri, Apr 29, 2022 at 12:19:22PM -0700, Matthias Kaehlcke wrote:
> > Hi Pavan,
> > 
> > On Fri, Apr 29, 2022 at 06:29:56PM +0530, Pavan Kondeti wrote:
> > > Hi Matthias,
> > > 
> > > On Mon, Apr 25, 2022 at 06:33:03PM +0530, Pavan Kondeti wrote:
> > > > Hi Matthias,
> > > > 
> > > > On Fri, Apr 22, 2022 at 11:44:36AM -0700, Matthias Kaehlcke wrote:
> > > > > On Fri, Apr 22, 2022 at 01:57:17PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Tue, Apr 19, 2022 at 9:11 PM Sandeep Maheswaram
> > > > > > <quic_c_sanm@quicinc.com> wrote:
> > > > > > >
> > > > > > > From: Matthias Kaehlcke <mka@chromium.org>
> > > > > > >
> > > > > > > Add device_children_wakeup_capable() which checks whether the device itself
> > > > > > > or one if its descendants is wakeup capable.
> > > > > > 
> > > > > > device_wakeup_path() exists for a very similar purpose.
> > > > > > 
> > > > > > Is it not usable for whatever you need the new function introduced here?
> > > > > 
> > > > > I wasn't aware of it's function, there are no doc comments and the
> > > > > name isn't really self explanatory.
> > > > > 
> > > > > In a quick test device_wakeup_path() returned inconsistent values for the
> > > > > root hub, sometimes true, others false when a wakeup capable USB device was
> > > > > connected.
> > > > 
> > > > We will also test the same to double confirm the behavior of
> > > > device_wakeup_path(). I am assuming that you checked device_wakeup_path()
> > > > only during system suspend path.
> > > > 
> > > > Here is what I understood by looking at __device_suspend(). Please share
> > > > your thoughts on this.
> > > > 
> > > > power.wakeup_path is set to true for the parent *after* a wakeup capable
> > > > device is suspended. This means when the root hub(s) is suspended, it is
> > > > propagated to xhci-plat and when xhci-plat is suspended, it is propagated
> > > > to dwc3. bottom up propgation during system suspend.
> > > > 
> > > > I believe we can directly check something like this in the dwc3 driver
> > > > instead of having another wrapper like device_children_wakeup_capable().
> > > > 
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 1170b80..a783257 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1878,8 +1878,14 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > > >  		break;
> > > >  	case DWC3_GCTL_PRTCAP_HOST:
> > > >  		if (!PMSG_IS_AUTO(msg)) {
> > > > +			/*
> > > > +			 * Don't kill the host when dwc3 is wakeup capable and
> > > > +			 * its children needs wakeup.
> > > > +			 */
> > > > +			if (device_may_wakeup(dwc->dev) && device_wakeup_path(dwc->dev))
> > > > +				handle_it();
> > > > +		} else {
> > > >  			dwc3_core_exit(dwc);
> > > > -			break;
> > > >  		}
> > > >  
> > > >  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > > > 
> > > 
> > > device_wakeup_path(dwc->dev) is returning true all the time irrespective of
> > > the wakeup capability (and enabled status) of the connected USB devices. That
> > > is because xhci-plat device is configured to wakeup all the time. Since the
> > > child is wakeup capable, its parent i.e dwc3 has device_wakeup_path() set.
> > > device_children_wakeup_capable() will also suffer the problem. However,
> > > 
> > > device_children_wakeup_capable(&hcd->self.root_hub->dev) is what Sandeep's
> > > patch is using. That is not correct. we have two root hubs (HS and SS) associated
> > > with a USB3 controller and calling it on one root hub is incorrect. 
> > > device_children_wakeup_capable() must be called on xhci-plat so that it covers
> > > both HS and SS root hubs
> > 
> > Thanks for pointing that out!
> > 
> > > I am thinking of dynamically enabling/disabling xhci-plat wakeup capability so
> > > that the wakeup path is correctly propagated to dwc3. something like below.
> > > Does it make sense to you?
> > > 
> > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > index 649ffd8..be0c55b 100644
> > > --- a/drivers/usb/host/xhci-plat.c
> > > +++ b/drivers/usb/host/xhci-plat.c
> > > @@ -412,6 +412,9 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
> > >  	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
> > >  	int ret;
> > >  
> > > +	if (!device_wakeup_path(dev))
> > > +		device_wakeup_disable(dev);
> > > +
> > >  	if (pm_runtime_suspended(dev))
> > >  		pm_runtime_resume(dev);
> > >  
> > > @@ -443,6 +446,8 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
> > >  	pm_runtime_set_active(dev);
> > >  	pm_runtime_enable(dev);
> > >  
> > > +	device_wakeup_enable(dev);
> > 
> > I think this also needs to be done conditionally, otherwise it would
> > create a new wake source on every resume when wakeup is already
> > enabled.
> > 
> Right, this needs to be done conditionally. However, there is a silent
> warning inside device_wakeup_enable() if it is called during system
> transition. Not sure if we really need to worry about that or not.

I guess it's up to the maintainers. Removing and adding the wakeup source on
suspend/resume is a bit of a hack, but it might be acceptable if it addresses
the issue and doesn't have negative side effects.
