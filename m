Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD137B487C
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjJAP5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 11:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjJAP5X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 11:57:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAF3D3;
        Sun,  1 Oct 2023 08:57:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE8AC433C7;
        Sun,  1 Oct 2023 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696175838;
        bh=sCovQZwExo44oQAqhqDPGoISPRpG+C8reMc7OEyCOXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtKEt3E76UzpTLf5SYgOHMPnuM9hGikPj+SBjDplOal6PvPDG61/dZuoKnIWIfcV/
         c7Gn7oRXGV0CTPji+zy/KVq5ZTTbUurFzpfWNJeNiANrTSci1FC8LOSNztr67HQG8f
         zxkXb2FUW0G3w+2lzDgISRAWAcsOPU9c0/mirdUcUpbByuPiYJU7K+QbSALwqHXJfH
         CM+IDcbEpvke6eVjQ5ojcVqaCwFRsNhP15XcPQCIejj5b2xutWZu5fgsMsSZP739GJ
         Z64PuthHnxiacO7qE5fJPjC/GfK734diyZa8NP13R6BjodgAmtTyGfe/kiE+Rwc5Y2
         7RfFb9TXs9RAQ==
Date:   Sun, 1 Oct 2023 21:27:01 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
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
        Manivannan Sadhasivam <mani@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation
 Device support
Message-ID: <20231001155701.GA53767@thinkpad>
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
> The Thermal Mitigation Device (TMD) Service is a QMI service that runs
> on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
> It exposes various mitigations including passive thermal controls and
> rail voltage restrictions.
> 
> This series introduces support for exposing TMDs as cooling devices
> in the kernel through the thermal framework, using the QMI interface.
> 
> Each TMD client is described as a child of the remoteproc node in
> devicetree. With subnodes for each control.
> 

Daniel expressed concerns in the past aganist representing TMD driver as a
cooling device since it is not tied to thermal zones and the governors cannot
use it. Instead he suggested to represent it as a powercap device with thermal
constraints.

So please look into that approach.

- Mani

> This series is based on previous work by Bhupesh Sharma which can be
> found at [1]. I'm sending this as a fresh series as it has been a
> year since the original version and I have rewritten most of the driver.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
> 
> ---
> Caleb Connolly (4):
>       remoteproc: qcom: probe all child devices
>       dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>       thermal: qcom: add qmi-cooling driver
>       MAINTAINERS: Add entry for Qualcomm Cooling Driver
> 
>  .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
>  .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
>  .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++
>  MAINTAINERS                                        |   8 +
>  drivers/remoteproc/qcom_q6v5.c                     |   4 +
>  drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
>  drivers/thermal/qcom/Kconfig                       |  13 +
>  drivers/thermal/qcom/Makefile                      |   1 +
>  drivers/thermal/qcom/qmi-cooling.c                 | 520 +++++++++++++++++++++
>  drivers/thermal/qcom/qmi-cooling.h                 | 428 +++++++++++++++++
>  10 files changed, 1161 insertions(+), 8 deletions(-)
> ---
> base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
> 
> // Caleb (they/them)
> 

-- 
மணிவண்ணன் சதாசிவம்
