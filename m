Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84C0DB5C3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 20:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441277AbfJQSTr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 14:19:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438684AbfJQSTq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 14:19:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30A02612DA; Thu, 17 Oct 2019 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571336385;
        bh=ISREP9AdfrC/XBTqeSZtr9AtlAJSpsRIKnn3uhj7a2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NoQk3EY5Fi3RTLyfxJOP0YdSkLMj09IBDDHT862HNhCev/CM7BYuZu92TW0xZV4pK
         2BDNC8zCQ9VcQHkR3QwSVmTnVSd1rh/Bw+c4EoWiFepOONBJS9gFt2srWcbD2CgOwv
         Ihgw43nljE9JOKjFt/cqBmLbho7kAur3D/kvemmY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.160.38] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCD09612DA;
        Thu, 17 Oct 2019 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571336382;
        bh=ISREP9AdfrC/XBTqeSZtr9AtlAJSpsRIKnn3uhj7a2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jGm5emnd+w0KN6atBSypyQEio+9ce3SGjLMnDCAeH6Pk8Z5TViJY2V0Cn2BnNxBbz
         beCJk/IvQyZT/qXEdu7QGXiwxeMdz1oLal6a6x6PPLzp687bW7GpthfQK3E/npbBV6
         mNaErygg/uHN9RRnwWbxUm5Udny085SyvEDSbmSU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCD09612DA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v3 6/6] cpufreq: qcom-hw: Move driver initialisation
 earlier
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, swboyd@chromium.org,
        ilina@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
References: <cover.1571314830.git.amit.kucheria@linaro.org>
 <3468b8cf9c764ea139296ee149d33cd7a9d79e3e.1571314830.git.amit.kucheria@linaro.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <b7f7061b-6dc3-eb3e-c6bf-fe582c2c2e3b@codeaurora.org>
Date:   Thu, 17 Oct 2019 23:49:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3468b8cf9c764ea139296ee149d33cd7a9d79e3e.1571314830.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/17/2019 5:57 PM, Amit Kucheria wrote:
> Allow qcom-hw driver to initialise right after the cpufreq and thermal
> subsystems are initialised in core_initcall so we get earlier access to
> thermal mitigation.
> 
> Signed-off-by: Amit Kucheria<amit.kucheria@linaro.org>
> Acked-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> ---

Acked-by: Taniya Das<tdas@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
