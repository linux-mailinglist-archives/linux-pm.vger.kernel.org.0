Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F094420FD9D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgF3U05 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jun 2020 16:26:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62100 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgF3U05 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jun 2020 16:26:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593548816; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=dqxuWzf6XuS04cq7vFT3rZkwpSupq9TrDFJEIb72eMo=; b=daOedZId6g80b/Ot6N1kAAOBtluJgXajzOIFMyfDYGahVXQgfp4fi5I3l5AjdP+ps2g8EIsZ
 0Ua9OA0WesSQ0fdaiiQ7hTUq0laW27D/kC7O1qXY48kY/ZNuhhSW39JJBxZMDDePmFmdKNCc
 aCKzYpJsCsdp5w87p1wXwv4tNM8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5efb9ffffe1db4db8947a3c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 20:26:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B764AC433CA; Tue, 30 Jun 2020 20:26:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C706C433C8;
        Tue, 30 Jun 2020 20:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C706C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 30 Jun 2020 14:26:38 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpuidle: governor: export cpuidle_register_governor
Message-ID: <20200630202638.GA16096@codeaurora.org>
References: <20200630191308.23611-1-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200630191308.23611-1-ilina@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Please ignore this patch. Will re-send.

Thanks,
Lina

On Tue, Jun 30 2020 at 13:13 -0600, Lina Iyer wrote:
>Commit 83788c0caed3 ("cpuidle: remove unused exports") removed
>capability of registering cpuidle governors. With this change, let's
>bring the capability back to allow cpuidle governors to be registered
>from a module.
>
>Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>---
> drivers/cpuidle/governor.c | 1 +
> include/linux/cpuidle.h    | 1 +
> 2 files changed, 2 insertions(+)
>
>diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
>index 29acaf48e575..480ec58cffa9 100644
>--- a/drivers/cpuidle/governor.c
>+++ b/drivers/cpuidle/governor.c
>@@ -102,6 +102,7 @@ int cpuidle_register_governor(struct cpuidle_governor *gov)
>
> 	return ret;
> }
>+EXPORT_SYMBOL_GPL(cpuidle_register_governor);
>
> /**
>  * cpuidle_governor_latency_req - Compute a latency constraint for CPU
>diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>index ec2ef63771f0..cc02ce7eab6c 100644
>--- a/include/linux/cpuidle.h
>+++ b/include/linux/cpuidle.h
>@@ -264,6 +264,7 @@ struct cpuidle_governor {
> 					bool *stop_tick);
> 	void (*reflect)		(struct cpuidle_device *dev, int index);
> };
>+EXPORT_SYMBOL_GPL(cpuidle_governor);
>
> #ifdef CONFIG_CPU_IDLE
> extern int cpuidle_register_governor(struct cpuidle_governor *gov);
>-- 
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
