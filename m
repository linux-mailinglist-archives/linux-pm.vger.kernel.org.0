Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D940156BED
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2020 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgBISDP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Feb 2020 13:03:15 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49990 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727413AbgBISDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Feb 2020 13:03:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581271394; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CL3PnsZShqKUdhYGdb7AJELv0cdIKL87yH0kp5s8WE0=;
 b=IbMXDc+Ci6pKMPkVQw580uZWRrkuY3LEqFVl9aSpZU8JNlC2l0MSBSjFhUrkeA0ZzAjC7rdf
 zKnGQ3gDYXnlTa7ANftOd8w2F2hwrCkBhDnOPyNqqTy/dMiHz/XoiLPWLYOWtq4M2DlMsHZ8
 ES0gchoGtTiQEekb7P4BAiqvlos=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e404961.7f79e07e3ce0-smtp-out-n02;
 Sun, 09 Feb 2020 18:03:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2D63C4479F; Sun,  9 Feb 2020 18:03:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BF7CC433A2;
        Sun,  9 Feb 2020 18:03:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 09 Feb 2020 23:33:11 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Evan Green <evgreen@google.com>
Cc:     David Dai <daidavid1@codeaurora.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: sdm845: Redefine interconnect provider
 DT nodes
In-Reply-To: <CAE=gft7qtfQjKK-MGgR_sK+Lsi2GmXgPkSsysD-DdUmFW4qMQw@mail.gmail.com>
References: <1578630784-962-1-git-send-email-daidavid1@codeaurora.org>
 <1578630784-962-7-git-send-email-daidavid1@codeaurora.org>
 <CAE=gft7qtfQjKK-MGgR_sK+Lsi2GmXgPkSsysD-DdUmFW4qMQw@mail.gmail.com>
Message-ID: <649c804c30e90088e4f7aa44cee2753e@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-02-04 23:48, Evan Green wrote:
> On Thu, Jan 9, 2020 at 8:33 PM David Dai <daidavid1@codeaurora.org> 
> wrote:
>> 
>> Add the DT nodes for each of the Network-On-Chip interconnect
>> buses found on SDM845 based platform and redefine the rsc_hlos
>> child node as a bcm-voter device to better represent the hardware.
>> 
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 
>> ++++++++++++++++++++++++++++++++++--
>>  1 file changed, 58 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index ddb1f23..7c617a9 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1364,6 +1364,55 @@
>>                         interrupts = <GIC_SPI 582 
>> IRQ_TYPE_LEVEL_HIGH>;
>>                 };
>> 
>> +               mem_noc: interconnect@1380000 {
>> +                       compatible = "qcom,sdm845-mem-noc";
>> +                       reg = <0 0x01380000 0 0x27200>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               dc_noc: interconnect@14e0000 {
>> +                       compatible = "qcom,sdm845-dc-noc";
>> +                       reg = <0 0x014e0000 0 0x400>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               config_noc: interconnect@1500000 {
>> +                       compatible = "qcom,sdm845-config-noc";
>> +                       reg = <0 0x01500000 0 0x5080>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               system_noc: interconnect@1620000 {
>> +                       compatible = "qcom,sdm845-system-noc";
>> +                       reg = <0 0x01620000 0 0x18080>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               aggre1_noc: interconnect@16e0000 {
>> +                       compatible = "qcom,sdm845-aggre1-noc";
>> +                       reg = <0 0x016e0000 0 0xd080>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               aggre2_noc: interconnect@1700000 {
>> +                       compatible = "qcom,sdm845-aggre2-noc";
>> +                       reg = <0 0x01700000 0 0x3b100>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               mmss_noc: interconnect@1740000 {
>> +                       compatible = "qcom,sdm845-mmss-noc";
>> +                       reg = <0 0x01740000 0 0x1c1000>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>>                 ufs_mem_hc: ufshc@1d84000 {
>>                         compatible = "qcom,sdm845-ufshc", 
>> "qcom,ufshc",
>>                                      "jedec,ufs-2.0";
>> @@ -3100,6 +3149,13 @@
>>                         #mbox-cells = <1>;
>>                 };
>> 
>> +               gladiator_noc: interconnect@17900000 {
>> +                       compatible = "qcom,sdm845-gladiator-noc";
>> +                       reg = <0 0x17900000 0 0xd080>;
>> +                       #interconnect-cells = <1>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>>                 apps_rsc: rsc@179c0000 {
>>                         label = "apps_rsc";
>>                         compatible = "qcom,rpmh-rsc";
>> @@ -3174,9 +3230,8 @@
>>                                 };
>>                         };
>> 
>> -                       rsc_hlos: interconnect {
>> -                               compatible = "qcom,sdm845-rsc-hlos";
>> -                               #interconnect-cells = <1>;
> 
> With this reworking of the bindings the examples in these files are now 
> broken:
> Documentation/devicetree/bindings/display/msm/gpu.txt
> Documentation/devicetree/bindings/display/msm/dpu.txt
> 
> It would be nice to fix them up in a subsequent change.

looks like most of them qcom
display bindings are in the
process of getting converted
to yaml, we'll have to make
sure that it gets addressed
then.

> -Evan

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
