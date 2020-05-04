Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084B11C48AA
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgEDU6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:58:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14626 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgEDU6S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:58:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588625898; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=iRA1j0cpPzrrwMyfFTKlyVe7b5cyvyMgcrcJqrCEUlE=;
 b=eErEZ3tyk64tej0ZUo1DpPrsbuXKfLY8LgGiz3/apyWp93UPYIOR3YE87zKyoAzp5fSDW2PD
 P1sg3qHMIzgdH4zRmvujdhuIUh1+IZtMRBKjuqGyxyQMOl06Y4UnoTIqeH/peeAQTI7raP8Y
 fbsyi5IM22NEV+CIt4jtdmGYhiU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb081de.7f7d590c1810-smtp-out-n01;
 Mon, 04 May 2020 20:58:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8EB4C433D2; Mon,  4 May 2020 20:58:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CF22C433CB;
        Mon,  4 May 2020 20:58:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:28:04 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v7 3/7] interconnect: Add of_icc_get_by_index() helper
 function
In-Reply-To: <20200424155404.10746-4-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-4-georgi.djakov@linaro.org>
Message-ID: <446a62e63e387de9c687631738f4af4c@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-24 21:24, Georgi Djakov wrote:
> This is the same as the traditional of_icc_get() function, but the
> difference is that it takes index as an argument, instead of name.
> 

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * Addressed review comments from Sibi.
> * Re-based patch.
> 
> v2: 
> https://lore.kernel.org/r/20190423132823.7915-3-georgi.djakov@linaro.org
> 
>  drivers/interconnect/core.c  | 68 +++++++++++++++++++++++++++---------
>  include/linux/interconnect.h |  6 ++++
>  2 files changed, 58 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 2c6515e3ecf1..648237f4de49 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -351,9 +351,9 @@ static struct icc_node
...


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
