Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5A45DAE3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 14:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355334AbhKYNXj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 08:23:39 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:25895 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349527AbhKYNVi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 08:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637846307; x=1669382307;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5Kor8T/KOS/W7IRbRf/Canjq2Mk951LWAJIdYI46kA=;
  b=xD7QrchOLzsgTpt0mZk63obTpaIiSdzsoo3oKpfFU9otsq0GtTjc4jFH
   cDZ/cHIsUw8MYrXPNcOkgo22r2HMq3XEhZtlj+p5DThuF6mRqSXXLejMi
   WXGOcGUo0/NZyBVeoKniSBgdaxaqhtrVAy6FIKV4ExAx4D7hDyWQt14Yc
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Nov 2021 05:18:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 05:18:26 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 25 Nov 2021 05:18:26 -0800
Received: from [10.216.32.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 25 Nov
 2021 05:18:22 -0800
Message-ID: <ac35bafa-a57f-e9ea-4dee-9af547de34e2@quicinc.com>
Date:   Thu, 25 Nov 2021 18:48:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/4] Allow cpuidle governors to be compiled as modules
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, <quic_lsrao@quicinc.com>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <CAJZ5v0hhUSjNdHwF4dRUQ1Fgos-jqg1agHBShhhwFUGK6wiedQ@mail.gmail.com>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <CAJZ5v0hhUSjNdHwF4dRUQ1Fgos-jqg1agHBShhhwFUGK6wiedQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 11/25/2021 5:57 PM, Rafael J. Wysocki wrote:
> On Thu, Nov 25, 2021 at 9:55 AM Maulik Shah <quic_mkshah@quicinc.com> wrote:
>> This series makes changes to allow cpuidle governors menu, ladder and teo
>> to compiled as modules when building with allmodconfig.
> What's the purpose of this?

There are two purposes of this series.

1. The series enables cpuidle governors to be allowed to compiled as 
modules.
     This is something similar to what cpufreq/devfreq governors do 
today as they can be be compiled as modules or built-in depending on the 
build config.

2. The series will also enable custom cpuidle governor to be able to 
register with cpuidle framework by using cpuidle_register_governor() API.
     This will be already achieved by (1) since it will export the 
required APIs for menu/ladder/teo governors to be compiled as module.

Thanks,
Maulik

