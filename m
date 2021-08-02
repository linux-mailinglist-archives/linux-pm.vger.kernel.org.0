Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D703DCEEA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 05:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhHBD22 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Aug 2021 23:28:28 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44603 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhHBD21 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 23:28:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627874899; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JCB8vVm40Ygev3lb2qOV67F7cVZ3peAJ9oCE0yR1aSk=;
 b=TcTkiLfAW7p/lk3jQVgXe07DZxTkB7yNLdnAvv1YUmFF65LW9zcxBMGymJSpaZCdBSma9IQl
 zHWBsFvVPF+7P3G4YhxSmkvSKKF5MGHm/BrgyKV02xWcJa8UsfxtxocCfZ8AUVJMtYhKsy62
 N6i+hTvjy3xQId5/O/4We4mWJzM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 610766529771b05b24beec4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Aug 2021 03:28:18
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3CF53C43460; Mon,  2 Aug 2021 03:28:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BC38C433F1;
        Mon,  2 Aug 2021 03:28:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Aug 2021 08:58:17 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
In-Reply-To: <CAD=FV=VfvW1PqJiR7Lh5RNyR6EQ1E8JK0N+KqJiB8DK49oUZ4A@mail.gmail.com>
References: <1620807083-5451-1-git-send-email-sibis@codeaurora.org>
 <1620807083-5451-3-git-send-email-sibis@codeaurora.org>
 <CAD=FV=VfvW1PqJiR7Lh5RNyR6EQ1E8JK0N+KqJiB8DK49oUZ4A@mail.gmail.com>
Message-ID: <db28cb8d8f3057958bb2e059b8ac90ba@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-07-31 03:50, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 12, 2021 at 1:11 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add OPP tables required to scale DDR/L3 per freq-domain on SC7280 
>> SoCs.
>> 
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>> 
>> V3:
>>  * Rename cpu opp table nodes [Matthias]
>>  * Rename opp phandles [Doug]
>> 
>> Depends on the following patch series:
>> L3 Provider Support: 
>> https://lore.kernel.org/lkml/1618556290-28303-1-git-send-email-okukatla@codeaurora.org/
>> CPUfreq Support: 
>> https://lore.kernel.org/lkml/1618020280-5470-2-git-send-email-tdas@codeaurora.org/
>> RPMH Provider Support: 
>> https://lore.kernel.org/lkml/1619517059-12109-1-git-send-email-okukatla@codeaurora.org/
>> 

Doug,

2 of the above 3 dependencies have
landed. L3 provider still needs a
re-spin.

https://patchwork.kernel.org/project/linux-arm-msm/cover/1627581885-32165-1-git-send-email-sibis@codeaurora.org/

We also have a new series ^^ on the
list which will affect #2 merge.


>> It also depends on L3 and cpufreq dt nodes from the ^^ series to not 
>> have
>> overlapping memory regions.
>> 
>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 215 
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 215 insertions(+)
> 
> I see patch #1 in mainline now. Does that mean it's time to land patch
> #2 in the Qualcomm tree now? ...or maybe it needs to be re-posted?
> 

> -Doug

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
