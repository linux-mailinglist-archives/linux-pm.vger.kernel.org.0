Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140151DC91
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443181AbiEFPzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443180AbiEFPzI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 11:55:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A1E59BAD
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 08:51:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso11183436pjb.1
        for <linux-pm@vger.kernel.org>; Fri, 06 May 2022 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QjBqmMkmUcAMteJnBmmBn9QwTnggo7cn/NEd2Zx55+0=;
        b=W4DvYNiShQEw5Df/QqOsE3u6o78JjUjVH4ZFW7H+i08QfF6dpLk3ArQQaZeDmwp1Vf
         iZ5ibY6qjvrAJ6NGXtv/O+5C3FJOM5ebArCvQvUqJhZsldESB/nDcwCMt6uZWBRoj2vg
         Qw/IbW+Dvxo9/3BMiasCzJ1stnKwjTr9O3p1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QjBqmMkmUcAMteJnBmmBn9QwTnggo7cn/NEd2Zx55+0=;
        b=se99Dz1os7H36z/O5C9D8SqftRMnTLBKVmESB+T9UnuRg/0kstkPPgl5Thpaa/cDzq
         56P2NFhxSsqrSdhSTZx2lpisqbn/FG1Eg7kQBHORtctvG1vf1OOzTAuN+/7r3/w9O9XJ
         W1Ev8CCLlXe2Cvf2yWf+WD99IH9FMXkDHKYpX7XUAfTzTKPjjpiN333DMTjFsSuCJlos
         KH6G80YA7IoTI1JNkhiUdWWrvdT6+faxnk5ybEnK/Z46HR3EYz7WmpfNL0ahhJmvos+Z
         9fKszKBr5qsiZiIFhxM+NcwwQjgiS3cQPkOJEKgDUcIKe41DQGcQhSsa7ZGRQ5Eh25Ki
         yDKw==
X-Gm-Message-State: AOAM531c61pSUSczx/ZrAeN040DaNd3/xD8bzsCbqjx3DDdPCrYbpK6x
        yo9feyKqcCm6X1iWL1GzSQtKRA==
X-Google-Smtp-Source: ABdhPJyho+6NNnFxpnW1GNoxoFsMysiiMDWcCS6WEGttMo1EG7E5PizLKyh+VxpCy0upBflJeUKWFg==
X-Received: by 2002:a17:902:c14a:b0:15b:9c29:935a with SMTP id 10-20020a170902c14a00b0015b9c29935amr4306895plj.2.1651852283888;
        Fri, 06 May 2022 08:51:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:5605:d5cd:699b:1b26])
        by smtp.gmail.com with UTF8SMTPSA id e15-20020a17090301cf00b0015e8d4eb24esm2013771plh.152.2022.05.06.08.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 08:51:23 -0700 (PDT)
Date:   Fri, 6 May 2022 08:51:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        linux-pm@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: Re: [v15 3/6] usb: dwc3: core: Host wake up support from system
 suspend
Message-ID: <YnVD+ltiQhKE+jPf@google.com>
References: <1651740973-7944-1-git-send-email-quic_kriskura@quicinc.com>
 <1651740973-7944-4-git-send-email-quic_kriskura@quicinc.com>
 <YnRUPxBZB55TPmf2@google.com>
 <a83dea08-0920-17e6-ec1c-f9d8a490a08d@quicinc.com>
 <20220506051448.GE4640@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220506051448.GE4640@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 06, 2022 at 10:44:48AM +0530, Pavan Kondeti wrote:
> On Fri, May 06, 2022 at 10:41:01AM +0530, Krishna Kurapati PSSNV wrote:
> > 
> > On 5/6/2022 4:18 AM, Matthias Kaehlcke wrote:
> > >On Thu, May 05, 2022 at 02:26:10PM +0530, Krishna Kurapati wrote:
> > >>From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > >>
> > >>During suspend read the status of all port and set hs phy mode
> > >>based on current speed. Use this hs phy mode to configure wakeup
> > >>interrupts in qcom glue driver.
> > >>
> > >>Check wakeup-source property for dwc3 core node to set the
> > >>wakeup capability. Drop the device_init_wakeup call from
> > >>runtime suspend and resume.
> > >>
> > >>Also check during suspend if any wakeup capable devices are
> > >>connected to the controller (directly or through hubs), if there
> > >>are none set a flag to indicate that the PHY is powered
> > >>down during suspend.
> > >>
> > >>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > >>Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > >>---
> > >>  drivers/usb/dwc3/core.c | 33 ++++++++++++++++++++-------------
> > >>  drivers/usb/dwc3/core.h |  4 ++++
> > >>  drivers/usb/dwc3/host.c | 24 ++++++++++++++++++++++++
> > >>  3 files changed, 48 insertions(+), 13 deletions(-)
> > >>
> > >>diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > >>index 950e238..cf377f5 100644
> > >>--- a/drivers/usb/dwc3/core.c
> > >>+++ b/drivers/usb/dwc3/core.c
> > >>@@ -33,6 +33,7 @@
> > >>  #include <linux/usb/gadget.h>
> > >>  #include <linux/usb/of.h>
> > >>  #include <linux/usb/otg.h>
> > >>+#include <linux/usb/hcd.h>
> > >This is not needed anymore
> > >
> > >>  #include "core.h"
> > >>  #include "gadget.h"
> > >>@@ -1787,6 +1788,7 @@ static int dwc3_probe(struct platform_device *pdev)
> > >>  	platform_set_drvdata(pdev, dwc);
> > >>  	dwc3_cache_hwparams(dwc);
> > >>+	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
> > >>  	spin_lock_init(&dwc->lock);
> > >>  	mutex_init(&dwc->mutex);
> > >>@@ -1936,6 +1938,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  {
> > >>  	unsigned long	flags;
> > >>  	u32 reg;
> > >>+	struct usb_hcd  *hcd = platform_get_drvdata(dwc->xhci);
> > >This isn't used anymore, delete it
> > My bad, Will fix this in next version.
> > >>  	switch (dwc->current_dr_role) {
> > >>  	case DWC3_GCTL_PRTCAP_DEVICE:
> > >>@@ -1948,10 +1951,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  		dwc3_core_exit(dwc);
> > >>  		break;
> > >>  	case DWC3_GCTL_PRTCAP_HOST:
> > >>-		if (!PMSG_IS_AUTO(msg)) {
> > >>-			dwc3_core_exit(dwc);
> > >>-			break;
> > >>-		}
> > >>+		dwc3_check_phy_speed_mode(dwc);
> > >>  		/* Let controller to suspend HSPHY before PHY driver suspends */
> > >>  		if (dwc->dis_u2_susphy_quirk ||
> > >>@@ -1967,6 +1967,16 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
> > >>  		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
> > >>  		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
> > >>+
> > >>+		if (!PMSG_IS_AUTO(msg)) {
> > >>+			if (device_may_wakeup(dwc->dev) &&
> > >>+					device_wakeup_path(dwc->dev)) {
> > >nit: the indentation is odd, align it with device_may_wakeup()?
> > Sure, Will take care of it.
> > >>+				dwc->phy_power_off = false;
> > >>+			} else {
> > >>+				dwc->phy_power_off = true;
> > >>+				dwc3_core_exit(dwc);
> > >As commented earlier, taking the controller and PHYs completely down causes a
> > >significant power draw in some USB clients. Let's clarify what the specific
> > >benefits are of doing dwc3_core_exit() vs. entering a low power mode.
> > Sure, once we come to a conclusion on this, I will refresh the patches.
> 
> I think, Matthias is asking you to clarify in the commit description. we can
> even quote Matthias observations.

Actually I would like to have a discussion about the benefits of powering down
the controller and PHYs vs. entering a low power state. Maybe there are good
reasons for powering everything down (e.g. significant power savings), but
as we have seen there are also significant downsides, so let's make sure
we understand both.
