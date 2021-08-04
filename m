Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368D13E0764
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbhHDSPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:15:54 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36658 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240248AbhHDSPs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628100936; x=1659636936;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LhVQs7dCWrgwFdOxLpiGTe+GnZxOOqEk+PkwvX2jWGQ=;
  b=xGbWWlmO6c7IYSMgulUpdxuUniQhmVIoU7lYI+JHUGysVTqd6qMo55vi
   NdRxSxptlfxJg3oRSQFU6BF2iHHhiwPbmi6pFBs7oYCt8CYmSuMaxcDSX
   Ud9H0Oj2ZzYo8RrUIknKsOuLJ1QUynah3Sx+D/E/LZVlzeLUQjWS1Lo5u
   g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Aug 2021 11:15:34 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Aug 2021 11:15:34 -0700
Received: from [10.110.10.146] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 4 Aug
 2021 11:15:34 -0700
Subject: Re: [PATCH] cpufreq: blacklist Qualcomm sm8150 in cpufreq-dt-platdev
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
CC:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20210804133451.2503674-1-thara.gopinath@linaro.org>
 <YQq1c8UYb78qJjxm@builder.lan>
From:   Trilok Soni <quic_tsoni@quicinc.com>
Message-ID: <6ab747fe-3183-bc46-7968-9959a1168659@quicinc.com>
Date:   Wed, 4 Aug 2021 11:15:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQq1c8UYb78qJjxm@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03h.na.qualcomm.com (10.85.0.50) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/4/2021 8:42 AM, Bjorn Andersson wrote:
> On Wed 04 Aug 08:34 CDT 2021, Thara Gopinath wrote:
> 
>> The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
>> add it to the cpufreq-dt-platdev driver's blocklist.

Thara, please use "blocklist" as well in your subject line of the patch.

---Trilok Soni
