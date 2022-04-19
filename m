Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF44506740
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiDSI5e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350279AbiDSI50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 04:57:26 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630B2C10F
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650358481; x=1681894481;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bdPMbm9706ziRdrSimD2E/5T9k31DfdaKm/kMNdzDT8=;
  b=Eo7rnlXR7MPPGnEjpsjPAdU2CmWigA3FiT+/eBTunSu15xrmftlHALjI
   74mMnm6j2n2yArzOS35QGZtWaibe/O6FUYOgav1kbBAOYLLsAGAis6AlR
   X5hERcf5AVSM2uXPNseKqGgBAx1yPymejHjOageDH1NyM0DBrLxuj7UlI
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Apr 2022 01:54:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:54:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 01:54:39 -0700
Received: from [10.216.21.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 01:54:35 -0700
Message-ID: <5b82df96-f5cc-4512-de33-d00223b2a489@quicinc.com>
Date:   Tue, 19 Apr 2022 14:24:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] cpuidle: psci: Improve support for suspend-to-ram for
 PSCI OSI mode
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        <linux-pm@vger.kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220401141124.27272-1-ulf.hansson@linaro.org>
 <20220401141124.27272-3-ulf.hansson@linaro.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20220401141124.27272-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/1/2022 7:41 PM, Ulf Hansson wrote:
> When PSCI OSI mode is supported the syscore flag is set for the CPU devices
> that becomes attached to their PM domains (genpds). In the suspend-to-idle
> case, we call dev_pm_genpd_suspend|resume() to allow genpd to properly
> manage the power-off/on operations (pick an idlestate and manage the on/off
> notifications).
>
> For suspend-to-ram, dev_pm_genpd_suspend|resume() is currently not being
> called, which causes a problem that the genpd on/off notifiers do not get
> sent as expected. This prevents the platform-specific operations from being
> executed, typically needed just before/after the boot CPU is being turned
> off/on.
>
> To deal with this problem, let's register a syscore ops for cpuidle-psci
> when PSCI OSI mode is being used and call dev_pm_genpd_suspend|resume()
> from them. In this way, genpd regains control of the PM domain topology and
> then sends the on/off notifications when it's appropriate.
>
> Reported-by: Maulik Shah <quic_mkshah@quicinc.com>
> Suggested-by: Maulik Shah <quic_mkshah@quicinc.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Maulik Shah <quic_mkshah@quicinc.com>

Thanks,
Maulik

