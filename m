Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D36A1C3516
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgEDI57 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 04:57:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47209 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728165AbgEDI56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 04:57:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588582677; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=rknaC2TCytI0e0UGEz1lxoHb9ILU/Hk1mGxInS5Hx0U=; b=NCun6Kt/o4iVf9XXoiepWcfExYEwAiwOQGyWIDICPploIhYs5AkB/Qdf1FvyXnVufZhngzSG
 bpo9/ZJWzLrb2TSFUHnPmw5YZX66Nvlx/5SwkAnTZQAixy1eixfscTVzutqy1/9GPKlyDhii
 uuTQSAefKkpt7lqRDRj5LxTCFg4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafd90a.7f88f64a42d0-smtp-out-n01;
 Mon, 04 May 2020 08:57:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EA6EC433CB; Mon,  4 May 2020 08:57:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.106] (unknown [27.59.218.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1089FC433BA;
        Mon,  4 May 2020 08:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1089FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH] interconnect: Add helpers for enabling/disabling a path
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org
References: <20200428091650.27669-1-georgi.djakov@linaro.org>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <44cbf83d-f210-97ec-21c2-ebe65b9821c1@codeaurora.org>
Date:   Mon, 4 May 2020 14:27:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428091650.27669-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On 4/28/2020 2:46 PM, Georgi Djakov wrote:
> There is a repeated pattern in multiple drivers where they want to switch
> the bandwidth between zero and some other value. This is happening often
> in the suspend/resume callbacks. Let's add helper functions to enable and
> disable the path, so that callers don't have to take care of remembering
> the bandwidth values and handle this in the framework instead.
>
> With this patch the users can call icc_disable() and icc_enable() to lower
> their bandwidth request to zero and then restore it back to it's previous
> value.

Thanks for this patch.

Are you planning to add bulk versions of icc_enable/disable APIs?

Regards,

Akash

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
