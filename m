Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D465149649
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2020 16:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgAYPgb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jan 2020 10:36:31 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:26487 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgAYPgb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jan 2020 10:36:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579966590; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ZishNxIYOars2iJxl3ot5DDo7EJhr+VfSTqCJaW0wP0=; b=GJoXW9Kzh1rKkrzad+p949HMi73B8Bt5NvxMDeLhPH7xp9f4FbnRO8EyM8mcr/53C54SegV6
 q5BcEpVmCDbkTuX46JHj5sh5+jNOuNzvSM26aDeWcy7TfWTJLtxOH3hbbwM4T+dElloAKyRZ
 qIGAMXalLp2nIj2Fy8UwdB8TUFg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2c607d.7f605d9f9308-smtp-out-n01;
 Sat, 25 Jan 2020 15:36:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1452CC447A1; Sat, 25 Jan 2020 15:36:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.43.137] (unknown [106.209.170.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90669C433CB;
        Sat, 25 Jan 2020 15:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90669C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v2 0/6] Add RSC power domain support
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org
References: <20190823081703.17325-1-mkshah@codeaurora.org>
 <20200121190521.GT89495@google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <49df6ec5-311e-43d9-9244-aaf35cc721bb@codeaurora.org>
Date:   Sat, 25 Jan 2020 21:06:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121190521.GT89495@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

Yes i will soon post a v3 series addressing outstanding comments.

Thanks,

Maulik

On 1/22/2020 12:35 AM, Matthias Kaehlcke wrote:
> Hi Maulik,
>
> What is the status of this series? It seems it hasn't been updated since
> you sent it in August last year. Do you plan to send a v3 in the near future
> to address the outstanding comments?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
