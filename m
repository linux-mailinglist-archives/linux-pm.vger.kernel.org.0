Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73D840C70E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhIOOHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 10:07:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52813 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhIOOHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 10:07:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631714777; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=SK3Coo+erOQWaBCCktW6N7DgBlpVbT1G6s0O7MEhplU=; b=k/Ho2D79wWaotor3eanuGtd8pB68ArtK2q+dmnAnCmaF6nwY7WB///jM8h0iBTqYvlGE0Wwo
 qrU39FNWuGws2MbE8yr+lcgccbAQYg0L9TVv8ON9YTKpP0F68Ci0BSiL++yNgHTMKp8cpjgU
 0H3KEY+9QNr2COB9gTS1xhmw7pU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6141fdadec62f57c9a0dd7a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Sep 2021 14:05:33
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D2AE9C43616; Wed, 15 Sep 2021 14:05:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EE79C4338F;
        Wed, 15 Sep 2021 14:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3EE79C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Date:   Wed, 15 Sep 2021 19:35:24 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v8 6/6] usb: dwc3: qcom: Keep power domain on to support
 wakeup
Message-ID: <20210915140524.GB6787@codeaurora.org>
References: <1624882097-23265-1-git-send-email-sanm@codeaurora.org>
 <1624882097-23265-7-git-send-email-sanm@codeaurora.org>
 <YNo97HQXmYjUNz/C@google.com>
 <87fswjzx52.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fswjzx52.fsf@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+linux-pm and Rafael

Hi Balbi,

On Mon, Jul 12, 2021 at 12:42:17PM +0300, Felipe Balbi wrote:
> 
> >> @@ -355,9 +356,15 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom)
> >>  	u32 val;
> >>  	int i, ret;
> >>  
> >> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> >> +	struct generic_pm_domain *genpd = pd_to_genpd(qcom->dev->pm_domain);
> >> +
> >>  	if (qcom->is_suspended)
> >>  		return 0;
> >>  
> >> +	if (!dwc->phy_power_off && dwc->xhci)
> >> +		genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
> >> +
> >>  	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> >>  	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> >>  		dev_err(qcom->dev, "HS-PHY not in L2\n");
> >> @@ -382,9 +389,15 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom)
> >>  	int ret;
> >>  	int i;
> >>  
> >> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> >> +	struct generic_pm_domain *genpd = pd_to_genpd(qcom->dev->pm_domain);
> >> +
> >>  	if (!qcom->is_suspended)
> >>  		return 0;
> >>  
> >> +	if (dwc->xhci)
> >> +		genpd->flags &= ~GENPD_FLAG_ACTIVE_WAKEUP;
> >> +
> >>  	if (device_may_wakeup(qcom->dev))
> >>  		dwc3_qcom_disable_interrupts(qcom);
> >>  
> >
> > This is essentially the same as v7, which Felipe NAKed
> > (https://patchwork.kernel.org/project/linux-arm-msm/patch/1619586716-8687-6-git-send-email-sanm@codeaurora.org/)
> >
> > I think Felipe wants to see the handling of the power domain in the
> > xhci-plat driver. One problem here is that the power domain is owned
> 
> this is not exactly what I meant to say, though. I want drivers to be
> self-contained. I.e. dwc3 doesn't modify xhci data and vice-versa. There
> are a few assummpmtions that we can make, though. The structure is
> usually like this:
> 
> glue {
>   dwc3 {
>     xhci
>   };
> };
> 
> This means that in order for glue_suspend() to run, dwc3 has to suspend
> first and xhci has to suspend before dwc3.
> 
> For example, in the suspend call above, qcom (the glue) is directly
> accessing dwc3 core data, which is incorrect. It looks like we want to
> know if the PHY is not powered off and if it isn't, then we want to
> change the power domain ACTIVE_WAKEUP flag. Now, phy_power_off is false
> whenever any of xHCI's children enable USB wakeup.
> 
> It seems like we need to way to generically propagate that knowledge up
> the parent tree. I.e., a parent needs to know if its child is wakeup
> capable, then dwc3 could, in its suspend routine:
> 
> static int dwc3_suspend(struct device *dev)
> {
> 	/* ... */
> 
> 	if (device_children_wakeup_capable(dev))
>         	device_enable_wakeup(dev);
> 
> 	/* ... */
> }
> 
> and similarly for qcom glue:
> 
> static int dwc3_qcom_suspend(struct device *dev)
> {
> 	/* ... */
> 
> 	if (device_children_wakeup_capable(dev)) {
>         	device_enable_wakeup(dev);
> 		genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>         }
> 
> 	/* ... */
> }
> 
> It also seems plausible that this could be done at driver core and
> completely hidden away from drivers.
> 

device_children_wakeup_capable() idea sounds good. Added linux-pm and Rafael
for more inputs on this.

AFAICT, device wakeup settings are NOT propagated to the parent. Ideally one
expects the parent to be wake up capable and enabled when any of its children
is enabling the wakeup. If that had been propagated, we could simply check
device_may_wakeup() and take an action. I am sure there are good reason why
and how this propgation may not work as we expect it to work for all devices.

Can we make something like below to make sure that DWC3 core respects its
child wakeup setting? This is inline with your suggestion of propagating it
through layers. we should probably enable wakeup on dwc3 dev so that the
glue drivers can take the action appropriately.


diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 172dfd2..9c43d37 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1749,7 +1749,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
                dwc3_core_exit(dwc);
                break;
        case DWC3_GCTL_PRTCAP_HOST:
-               if (!PMSG_IS_AUTO(msg)) {
+               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
                        dwc3_core_exit(dwc);
                        break;
                }
@@ -1810,7 +1810,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
                spin_unlock_irqrestore(&dwc->lock, flags);
                break;
        case DWC3_GCTL_PRTCAP_HOST:
-               if (!PMSG_IS_AUTO(msg)) {
+               if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(&dwc->xhci->dev)) {
                        ret = dwc3_core_init_for_resume(dwc);
                        if (ret)
                                return ret;


Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

