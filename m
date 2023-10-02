Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED47B55F1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 17:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjJBOwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 10:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjJBOwx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 10:52:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC48F9D;
        Mon,  2 Oct 2023 07:52:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C14BC433C8;
        Mon,  2 Oct 2023 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696258370;
        bh=Etqxxf/D+cQv+It0W6UkjfNaCRmxy8NfOCgMspxGg4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsHyhGPdNFcCYSuzntBAkFqGejwIzlUuGDxKha2iPiGz/eh7uaLHH0+6ZGjddbxtD
         b/OQPeDqUsB3GGSGwo0Jr/RlK97mCdMXtv+XaKXXlRYTz7HRtXgwOINlmSJL1uzPNC
         uPOQXNXCufurO8XH4tu3OolpBWCfTbR6Z9DR5kSk7IYosRdvB8yR+oiS2yaqnlA8Si
         VmDpdUCOvmX1yFW20Z34mcHiVH+7tS0tF2UYophMM38N4LgJKoPmcSfodHkncBnHXL
         tZ366z+H33h/kxztAeTRHxfpnAzfJ8miO3TNzZQ6687NGwIFR/qAfhkpKtyWiSll3k
         EK9i13cD9y/PA==
Date:   Mon, 2 Oct 2023 20:22:39 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation
 Device support
Message-ID: <20231002145239.GA12041@thinkpad>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad>
 <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
> 
> 
> On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
> > On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> > > The Thermal Mitigation Device (TMD) Service is a QMI service that runs
> > > on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> > > It exposes various mitigations including passive thermal controls and
> > > rail voltage restrictions.
> > > 
> > > This series introduces support for exposing TMDs as cooling devices
> > > in the kernel through the thermal framework, using the QMI interface.
> > > 
> > > Each TMD client is described as a child of the remoteproc node in
> > > devicetree. With subnodes for each control.
> > > 
> > 
> > Daniel expressed concerns in the past aganist representing TMD driver as a
> > cooling device since it is not tied to thermal zones and the governors cannot
> > use it. Instead he suggested to represent it as a powercap device with thermal
> > constraints.
> 
> Hi Mani,
> 
> Forgive me as I'm not yet super familiar with the thermal subsystem.
> 
> As I understand it, the DT layout here enables each control to be referenced
> under the thermal zones, at least this is the approach taken in CAF 4.9.
> 
> Maybe I don't quite understand what you mean, are you saying that using
> thermal zones is the wrong approach?

Thermal framework expects each thermal zone represented in DT to have atleast
one corresponding thermal sensor defined using "thermal-sensors" property. But
with TMD, there is no thermal sensor AFAIK.

> > 
> > So please look into that approach.
> 
> Any recommended reading? Or drivers I can use as a reference?
> 

drivers/powercap/arm_scmi_powercap.c seems to be a good reference.

- Mani

> Thanks
> > 
> > - Mani
> > 
> > > This series is based on previous work by Bhupesh Sharma which can be
> > > found at [1]. I'm sending this as a fresh series as it has been a
> > > year since the original version and I have rewritten most of the driver.
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
> > > 
> > > ---
> > > Caleb Connolly (4):
> > >        remoteproc: qcom: probe all child devices
> > >        dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
> > >        thermal: qcom: add qmi-cooling driver
> > >        MAINTAINERS: Add entry for Qualcomm Cooling Driver
> > > 
> > >   .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
> > >   .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
> > >   .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++
> > >   MAINTAINERS                                        |   8 +
> > >   drivers/remoteproc/qcom_q6v5.c                     |   4 +
> > >   drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
> > >   drivers/thermal/qcom/Kconfig                       |  13 +
> > >   drivers/thermal/qcom/Makefile                      |   1 +
> > >   drivers/thermal/qcom/qmi-cooling.c                 | 520 +++++++++++++++++++++
> > >   drivers/thermal/qcom/qmi-cooling.h                 | 428 +++++++++++++++++
> > >   10 files changed, 1161 insertions(+), 8 deletions(-)
> > > ---
> > > base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
> > > 
> > > // Caleb (they/them)
> > > 
> > 
> 
> -- 
> // Caleb (they/them)

-- 
மணிவண்ணன் சதாசிவம்
