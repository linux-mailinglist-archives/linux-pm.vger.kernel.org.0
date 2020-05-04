Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B41C484F
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgEDUbe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:31:34 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:20477 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgEDUbb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:31:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588624290; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=cqJaYZazg1/VMjB0ocaT64qt21+ld4ZwVZIyw06JsVs=;
 b=AwBgbtH6uIYbXbVBKgXdVChZybIdI1815a5AYFFV6IDoKMZYM+JC5hfaid6CWzR3rq7zDxgX
 5dzYud6gty0ciYg0jXLiQGehv3HhJjrrDL4N3DqTNpQEZ0WIFiRRpYK99kHrikV0yPb1xiWH
 p493MAMrNJBWgOBNOyyC7AkYTQs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb07b9f.7efd131cc3b0-smtp-out-n02;
 Mon, 04 May 2020 20:31:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DE86C43637; Mon,  4 May 2020 20:31:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D4CDC433D2;
        Mon,  4 May 2020 20:31:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 02:01:25 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, rjw@rjwysocki.net, saravanak@google.com,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, jcrouse@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
In-Reply-To: <20200424155404.10746-2-georgi.djakov@linaro.org>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-2-georgi.djakov@linaro.org>
Message-ID: <187f2f21e6ca55a9ab26a026f01dd893@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-04-24 21:23, Georgi Djakov wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> Interconnects often quantify their performance points in terms of
> bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) 
> to
> allow specifying Bandwidth OPP tables in DT.
> 
> opp-peak-kBps is a required property that replaces opp-hz for Bandwidth 
> OPP
> tables.
> 
> opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> tables.
> 

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v7:
> * I have dropped Rob's Reviewed-by, because of the minor change below:
> * In order to store the bandwidth values for multiple paths, the
> opp-peak-kBps and opp-avg-kBps are now defined as arrays of integers,
> instead of just integers.
> * Improved wording (Viresh)
...


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
