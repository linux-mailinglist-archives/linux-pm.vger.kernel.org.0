Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E754B822
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352188AbiFNRxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356922AbiFNRxj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 13:53:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A9286ED
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 10:53:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f8so8346172plo.9
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HYjK3rxh/o4Ln2PasJCrv5tlXw/BblIG4nmWymg4CTU=;
        b=Dmcl6h6O2UsD1cniilERBIHpLI5g0P/K6YyIIZFmCTiO3zfiNP7vsFGI5yW/YR2P0e
         PHMFqa5OgjTuzo535YbgmMqa3WUOyvshljH6QUOuRceA/vRqu3tHJjXAifNq2QD6lIPT
         aH2jUZ1mLLUT+psDLg/ujPik8r4QJQ6H8Rc2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HYjK3rxh/o4Ln2PasJCrv5tlXw/BblIG4nmWymg4CTU=;
        b=RPR/jLLi6tH/UbFMiAxpqosTv344KmSfT9NGFH4VPbRlBHni8a5yZR7u4ZUy8r2quP
         no0vT3mqeDWdqXsJti/75z4tlse1QXr7Rdq2LxYZ/LuMx6KuBE4IKN48K8bhPrNMvp0W
         K2Lxp4fDtGlABnbbH2JdyBOdmiHDoKHcYMGjq8AOqGu4VQoDwpPI0d8NK+06Nlw7uITz
         F6U/JeRgZUuDZV4jXLquWLItVteo/YPDFoUrjzdS+2hPDpYykKBE479UmTLVJGNMRg6q
         Vi6y71cFOlV9b23fIkeXAfEa2S33KAroEM9tI1ifkrQREdiOmMOogD8Ue4PGfWwxcY+C
         6tjw==
X-Gm-Message-State: AJIora+YpHBVj04MiypiDJbx5zKaI3DdEwzcveTNGeFeboe6Nn+f4JPw
        LZEZfRIgAuBMFFKAo6xfJyc3q0ArNzqUrQ==
X-Google-Smtp-Source: AGRyM1tN4d34RCS0aereeUwhiOz9w4OfY8jYpf4mv8FMaFXrXs9yJ1MCFf+jjpM9PjH3Age+3pITZA==
X-Received: by 2002:a17:902:eb92:b0:168:911c:5946 with SMTP id q18-20020a170902eb9200b00168911c5946mr5497583plg.167.1655229217250;
        Tue, 14 Jun 2022 10:53:37 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e2d5:2b03:9fb1:ce40])
        by smtp.gmail.com with UTF8SMTPSA id r29-20020aa7963d000000b0051bc4ed56bcsm7855498pfg.204.2022.06.14.10.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:53:36 -0700 (PDT)
Date:   Tue, 14 Jun 2022 10:53:35 -0700
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
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
Subject: Re: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from
 system suspend
Message-ID: <YqjLHyUVEjf7I3MI@google.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
 <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
 <YpkRDi2m7cLaKYEf@google.com>
 <Yp5nf2w8uVZ38/XZ@google.com>
 <Yqd9IHQEj3Ex+FcF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yqd9IHQEj3Ex+FcF@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 13, 2022 at 11:08:32AM -0700, Matthias Kaehlcke wrote:
> On Mon, Jun 06, 2022 at 01:45:51PM -0700, Matthias Kaehlcke wrote:
> > On Thu, Jun 02, 2022 at 12:35:42PM -0700, Matthias Kaehlcke wrote:
> > > Hi Krishna,
> > > 
> > > with this version I see xHCI errors on my SC7180 based system, like
> > > these:
> > > 
> > > [   65.352605] xhci-hcd xhci-hcd.13.auto: xHC error in resume, USBSTS 0x401, Reinit
> > > 
> > > [  101.307155] xhci-hcd xhci-hcd.13.auto: WARN: xHC CMD_RUN timeout
> > > 
> > > After resume a downstream hub isn't enumerated again.
> > > 
> > > So far I didn't see those with v13, but I aso saw the first error with
> > > v16.
> > 
> > It also happens with v13, but only when a wakeup capable vUSB <= 2
> > device is plugged in. Initially I used a wakeup capable USB3 to
> > Ethernet adapter to trigger the wakeup case, however older versions
> > of this series that use usb_wakeup_enabled_descendants() to check
> > for wakeup capable devices didn't actually check for vUSB > 2
> > devices.
> > 
> > So the case were the controller/PHYs is powered down works, but
> > the controller is unhappy when the runtime PM path is used during
> > system suspend.
> 
> The issue isn't seen on all systems using dwc3-qcom and the problem starts
> during probe(). The expected probe sequence is something like this:
> 
> dwc3_qcom_probe
>   dwc3_qcom_of_register_core
>     dwc3_probe
> 
>   if (device_can_wakeup(&qcom->dwc3->dev))
>     ...
> 
> The important part is that device_can_wakeup() is called after dwc3_probe()
> has completed. That's what I see on a QC SC7280 system, where wakeup is
> generally working with these patches.
> 
> However on a QC SC7180 system dwc3_probe() is deferred and only executed after
> dwc3_qcom_probe(). As a result the device_can_wakeup() call returns false.
> With that the controller/driver ends up in an unhappy state after system
> suspend.
> 
> Probing is deferred on SC7180 because device_links_check_suppliers() finds
> that '88e3000.phy' isn't ready yet.

It seems device links could be used to make sure the dwc3 core is present:

  Another example for an inconsistent state would be a device link that
  represents a driver presence dependency, yet is added from the consumer’s
  ->probe callback while the supplier hasn’t probed yet: Had the driver core
  known about the device link earlier, it wouldn’t have probed the consumer
  in the first place. The onus is thus on the consumer to check presence of
  the supplier after adding the link, and defer probing on non-presence.

  https://www.kernel.org/doc/html/v5.18/driver-api/device_link.html#usage


You could add something like this to dwc3_qcom_of_register_core():


  device_link_add(dev, &qcom->dwc3->dev,
  		  DL_FLAG_AUTOREMOVE_CONSUMER | DL_FLAG_AUTOPROBE_CONSUMER);

  if (qcom->dwc3->dev.links.status != DL_DEV_DRIVER_BOUND)
      ret = -EPROBE_DEFER;


From the doc it isn't clear how the consumer is supposed to check presence
of the supplier, the above check of the link status is also used in
drivers/cpufreq/mediatek-cpufreq.c , but not elsewhere outside of the
driver framework.
