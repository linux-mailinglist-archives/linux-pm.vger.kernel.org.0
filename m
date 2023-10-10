Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6227BFB4D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjJJMZI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjJJMZH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 08:25:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D99D;
        Tue, 10 Oct 2023 05:25:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A470C433C7;
        Tue, 10 Oct 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696940705;
        bh=omFIqKia3wy7Xbwqgl3lEDlQS0jMr0mlUIHVa8ZY/jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB9t1Xi6C6UY8MEAUWcmpc14/Xjsaa4NraUXJX6ziZ6S77LJRYcw5jPz1uuO9fARo
         r+70AQEjYZjsYmbjTpHHdqjp8Q80rxgQpZNdtZkrZKZcaUuCSZhzMFM0MMNJLrc6OO
         35nHg0XtxoELdzajsUHQF2HW6wg85SteBC9WdymQikpsZTy+65jjOvwVI54Sdk2amZ
         Lkqar4AL7Hfzm2z7jAXAIytZOxyGCV9QxKa26KqGzt8mWu84II+BDaG6/plyWnLrtv
         7QZeOUeSd0dC8DTMW1o2gSOzVWOCJq+FICgRYyiBeTUz9OvqK6CGJZ9BvKe7kn7HHm
         aWmLRQoVsbMDg==
Date:   Tue, 10 Oct 2023 17:54:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
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
Message-ID: <20231010122447.GJ4884@thinkpad>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad>
 <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
 <20231002145239.GA12041@thinkpad>
 <CAA8EJppn-f6R3ObGvagqkg1_KtXGgtNAgRn-LQiN3ORSHQY3-Q@mail.gmail.com>
 <20231002155814.GB12041@thinkpad>
 <CAA8EJpowGjnecOjr9h4r3=UXSrE4VdptoLADpQq3gDv_W9D3OQ@mail.gmail.com>
 <20231002161308.GC12041@thinkpad>
 <20231005023658.GE3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231005023658.GE3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 04, 2023 at 07:36:58PM -0700, Bjorn Andersson wrote:
> On Mon, Oct 02, 2023 at 09:43:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Oct 02, 2023 at 07:00:27PM +0300, Dmitry Baryshkov wrote:
> > > On Mon, 2 Oct 2023 at 18:58, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 02, 2023 at 06:00:37PM +0300, Dmitry Baryshkov wrote:
> > > > > On Mon, 2 Oct 2023 at 17:52, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
> > > > > > > > On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> > > > > > > > > The Thermal Mitigation Device (TMD) Service is a QMI service that runs
> > > > > > > > > on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> > > > > > > > > It exposes various mitigations including passive thermal controls and
> > > > > > > > > rail voltage restrictions.
> > > > > > > > >
> > > > > > > > > This series introduces support for exposing TMDs as cooling devices
> > > > > > > > > in the kernel through the thermal framework, using the QMI interface.
> > > > > > > > >
> > > > > > > > > Each TMD client is described as a child of the remoteproc node in
> > > > > > > > > devicetree. With subnodes for each control.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Daniel expressed concerns in the past aganist representing TMD driver as a
> > > > > > > > cooling device since it is not tied to thermal zones and the governors cannot
> > > > > > > > use it. Instead he suggested to represent it as a powercap device with thermal
> > > > > > > > constraints.
> > > > > > >
> > > > > > > Hi Mani,
> > > > > > >
> > > > > > > Forgive me as I'm not yet super familiar with the thermal subsystem.
> > > > > > >
> > > > > > > As I understand it, the DT layout here enables each control to be referenced
> > > > > > > under the thermal zones, at least this is the approach taken in CAF 4.9.
> > > > > > >
> > > > > > > Maybe I don't quite understand what you mean, are you saying that using
> > > > > > > thermal zones is the wrong approach?
> > > > > >
> > > > > > Thermal framework expects each thermal zone represented in DT to have atleast
> > > > > > one corresponding thermal sensor defined using "thermal-sensors" property. But
> > > > > > with TMD, there is no thermal sensor AFAIK.
> > > > >
> > > > > As far as I understand, no. It is perfectly fine to have 'cooling'
> > > > > devices, which react to external thermal monitoring events. I might be
> > > > > mistaken, but I think that is the case here, isn't it?
> > > > >
> > > >
> > > > Yes it is represented as cooling device(s). But I do not see any cognizant way
> > > > to plug it with thermal zones i.e., unless TMD itself reports temperature of the
> > > > modem, using it as a cooling device for external temperature events doesn't
> > > > sound good to me.
> > > 
> > > Why? We have compute, q6, wlan tsens sensors. So it seems natural to
> > > tell CDSP to slow down if compute sensor reports overheating.
> > > 
> > 
> > TMD is for external devices such as PCIe modems as well. Is there a temperature
> > sensor for that?
> > 
> 
> According to the schematics for the SC8280XP CRD sys_therm5 would be the
> sensor you're looking for.
> 

Hmm, then it seems fine from my end as long we have the correct sensor data to
hook up these cooling devices.

- Mani

> Regards,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
