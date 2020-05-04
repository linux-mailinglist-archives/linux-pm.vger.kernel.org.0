Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFDA1C4886
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDUrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:47:40 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60476 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgEDUrk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:47:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588625259; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Iof0Sqf40QZr6rxYchOOH4uFMrtf83OoP/dCtGny2y8=;
 b=AmvAc2GocGIxGsSemQSxjxejmVMGW5lXvIoNVBIn8l5vzTzZi7BaVJcbztEeKEiLJOrl1DXr
 7KWyzCYbEBZgQovhLpSPTmuwTn5IJVPeUECabi7NEzr5Hvg6HzhhKw+xyKCAnqcz4Hr8OWyc
 TnWPGnBjAZy1VGdisFrvyWr7og8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07f64.7f5e99265df8-smtp-out-n02;
 Mon, 04 May 2020 20:47:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8ECCC43637; Mon,  4 May 2020 20:47:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1F25C433CB;
        Mon,  4 May 2020 20:47:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:17:29 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v7 5/7] OPP: Add sanity checks in _read_opp_key()
In-Reply-To: <20200424155404.10746-6-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-6-georgi.djakov@linaro.org>
Message-ID: <e007032f6125e8a226d0b43f54287b40@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-24 21:24, Georgi Djakov wrote:
> When we read the OPP keys, it would be nice to do some sanity checks
> of the values we get from DT and see if they match with the information
> that is populated in the OPP table. Let's pass a pointer of the table,
> so that we can do some validation.
> 

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> New patch.
> 
...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
