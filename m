Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E518257365
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHaFpy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 01:45:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56595 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaFpx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 31 Aug 2020 01:45:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598852751; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Iy+aS17ropB49yr1viRv2PHOc4XtCCzAiTjV0hpucD0=;
 b=p1JxEcI9zwLiaKMteissaxp/AgYcNC/xAx3Xeuo2yBCsrUt3ZoGUjg7uDeyETAOUdKFHHlqk
 pjrfuT2+Ce6QyabfLzHBatCiZ1vzi61y4g9yLL6c78+ssX1z9k6B/B7cW2fG2s3KowsnhQwR
 oXrM6u+AmWtPYpjqEJs2YBf2HYw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4c8e8f2583507e9292f1a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 05:45:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B1961C43395; Mon, 31 Aug 2020 05:45:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24F6DC433CA;
        Mon, 31 Aug 2020 05:45:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 31 Aug 2020 11:15:50 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, vincent.guittot@linaro.org,
        saravanak@google.com, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
In-Reply-To: <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
 <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7>
Message-ID: <b339e01f9d1e955137120daa06d26228@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-24 16:10, Viresh Kumar wrote:
> +Vincent/Saravana/Sibi
> 
> On 21-08-20, 16:00, Ansuel Smith wrote:
>> This adds Krait Cache scaling support using the cpufreq notifier.
>> I have some doubt about where this should be actually placed (clk or 
>> cpufreq)?
>> Also the original idea was to create a dedicated cpufreq driver (like 
>> it's done in
>> the codeaurora qcom repo) by copying the cpufreq-dt driver and adding 
>> the cache
>> scaling logic but i still don't know what is better. Have a very 
>> similar driver or
>> add a dedicated driver only for the cache using the cpufreq notifier 
>> and do the
>> scale on every freq transition.
>> Thanks to everyone who will review or answer these questions.
> 
> Saravana was doing something with devfreq to solve such issues if I
> wasn't mistaken.
> 
> Sibi ?

IIRC the final plan was to create a devfreq device
and devfreq-cpufreq based governor to scale them, this
way one can switch to a different governor if required.
(I don't see if ^^ applies well for l2 though). In the
interim until such a solution is acked on the list we
just scale the resources directly from the cpufreq
driver. On SDM845/SC7180 SoCs, L3 is modeled as a
interconnect provider and is directly scaled from the
cpufreq-hw driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
