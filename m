Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2220E1EA1CF
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgFAKYm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 06:24:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26544 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAKYm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 06:24:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591007082; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7kmkBXE1s/B1uijytzBWtDNlmhyb/oC4LuZ3LKjjazI=;
 b=uPXwUztHfnSfON9QBmlZ+LE2RUpVQQN5ZBv8nimUMF7yQeQGP3yg2DR57mJXU8ivV0O2x/G6
 hhXPTCxwhaRncq5tXVB5FY5J703AlGcy7Y+XmZghtPsPGqTl7si/U52KtPaAoK9q1SB5ny3G
 0oW83ggR3DGdByg9Yw9jRWk0WHE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ed4d76942288e951fb11654 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Jun 2020 10:24:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4DAD1C433C9; Mon,  1 Jun 2020 10:24:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C06BC433C6;
        Mon,  1 Jun 2020 10:24:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 15:54:40 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org, linux-arm-msm-owner@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
In-Reply-To: <20200601101528.vcauy5fm5tmzgahs@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
 <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
 <0205034b0ece173a7152a43b016985a7@codeaurora.org>
 <20200601040742.3a4cmhrwgh2ueksy@vireshk-i7>
 <ee51e55bdf518832e4ecb2faf98c6b58@codeaurora.org>
 <20200601071349.gbuyfaasdu27a3bd@vireshk-i7>
 <4258c6b122fa352a6b5cccb07a9b1203@codeaurora.org>
 <20200601101528.vcauy5fm5tmzgahs@vireshk-i7>
Message-ID: <a6ef554ca033444dac80de40ecbd40f7@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-01 15:45, Viresh Kumar wrote:
> On 01-06-20, 15:30, Sibi Sankar wrote:
>> Yeah dev_pm_opp_add/dev_pm_opp_set_clkname
>> or pretty much any api doing a
>> dev_pm_opp_get_opp_table without
>> a opp_table node associated with
>> it will run into this issue.
> 
> Not sure if what you wrote now is correct, the problem shouldn't
> happen from within dev_pm_opp_set_clkname() but only when we try to do
> bw thing.
> 
> Anyway, I have pushed the change already.

cool, thanks!
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
