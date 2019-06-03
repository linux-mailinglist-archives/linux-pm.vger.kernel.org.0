Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C77FA33459
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 17:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfFCP4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 11:56:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfFCP4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 11:56:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12B62618F6; Mon,  3 Jun 2019 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559577404;
        bh=EAPG4xulPvqzLmZB0/PxBD6J0ritzVL9IFC2BKLxfxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVVeQ3QZIdvovYMUCz5ZmxIoHTSkss8TNYnjBO0yrrdvyBwBWKRXEejff4S5rxD04
         sMxYEq0oR5ZRGk627ySeJFwyhfScNmzQFmUufGMOl+GNHhS8tk+Xn+T2UanX08uz9o
         dHZGyNqscx0Fb3UpqOzY4GOtl6/S8TAoLQUYhS4o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AB0E618CA;
        Mon,  3 Jun 2019 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559577398;
        bh=EAPG4xulPvqzLmZB0/PxBD6J0ritzVL9IFC2BKLxfxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bvUX7QW75oN+oKUhYcAksvTC2vl1Ulm9OO/i8DdtM438nd6u+jao3xQzHE+Ry873C
         nrGRHqvFkFy0ynOIdCil8+HYBKMRveZcKX+DBSnXqWePV937Np/KtYwACcA/JOOybk
         9pPsq83DrIGpGoQQ+WkAcKNpMFpfdhGMv2RwVyKo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AB0E618CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 3 Jun 2019 09:56:35 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        devicetree@vger.kernel.org, evgreen@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, nm@ti.com,
        rjw@rjwysocki.net, robh+dt@kernel.org, sboyd@kernel.org,
        seansw@qti.qualcomm.com, sibis@codeaurora.org,
        vincent.guittot@linaro.org, vireshk@kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/5] Introduce OPP bandwidth bindings
Message-ID: <20190603155634.GA10741@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Saravana Kannan <saravanak@google.com>,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        bjorn.andersson@linaro.org, daidavid1@codeaurora.org,
        devicetree@vger.kernel.org, evgreen@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, nm@ti.com,
        rjw@rjwysocki.net, robh+dt@kernel.org, sboyd@kernel.org,
        seansw@qti.qualcomm.com, sibis@codeaurora.org,
        vincent.guittot@linaro.org, vireshk@kernel.org,
        kernel-team@android.com
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190601021228.210574-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601021228.210574-1-saravanak@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 31, 2019 at 07:12:28PM -0700, Saravana Kannan wrote:
> I'll have to Nack this series because it's making a couple of wrong assumptions
> about bandwidth voting.
> 
> Firstly, it's mixing up OPP to bandwidth mapping (Eg: CPU freq to CPU<->DDR
> bandwidth mapping) with the bandwidth levels that are actually supported by an
> interconnect path (Eg: CPU<->DDR bandwidth levels). For example, CPU0 might
> decide to vote for a max of 10 GB/s because it's a little CPU and never needs
> anything higher than 10 GB/s even at CPU0's max frequency. But that has no
> bearing on bandwidth level available between CPU<->DDR.

I'm going to just quote this part of the email to avoid forcing people to
scroll too much.

I agree that there is an enormous universe of new and innovative things that can
be done for bandwidth voting. I would love to have smart governors and expansive
connections between different components that are all aware of each other. I
don't think that anybody is discounting that these things are possible.

But as it stands today, as a leaf driver developer my primary concern is that I
need to vote something for the GPU->DDR path. Right now I'm voting the maximum
because that is the bare minimum we need to get working GPU.

Then the next incremental baby step is to allow us to select a minimum
vote based on a GPU frequency level to allow for some sort of very coarse power
savings. It isn't perfect, but better than cranking everything to 11. This is
why we need the OPP bandwidth bindings to allow us to make the association and
tune down the vote. I fully agree that this isn't the optimal solution but
it is the only knob we have right now.

And after that we should go nuts. I'll gladly put the OPP bindings in the
rear-view mirror and turn over all bandwidth to a governor or two or three.
I'll be happy to have nothing to do with it again. But until then we need
a solution for the leaf drivers that lets us provide some modicum of power
control.

Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
