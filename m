Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22B70546
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfGVQUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 12:20:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfGVQUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 12:20:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6BB4560E5A; Mon, 22 Jul 2019 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563812415;
        bh=/fTWdA5sK7R3GGTlX+WLaXG3NYMeNG9JlI3aAlgldjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CySoueQwWigAYEYnvtzBGVgk9F96erpDnj5JV7N2WtyjvYAVCX/m6wi1g4A7hGkdU
         s9xipgdbvkoIGMVabaPWOwWDGUbwZ+nPls8aOgy2x0h003dINia/pg97VWNlcl2B8N
         +Q/r+iEaFrVt/mD5CW82YAwvgxp9TGoFdyG8ewNk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CABA160E3E;
        Mon, 22 Jul 2019 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563812414;
        bh=/fTWdA5sK7R3GGTlX+WLaXG3NYMeNG9JlI3aAlgldjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEwyS6U6SlafnSt6kmH0x8jwQ/v432h6vBEf/3yQ7zf2EMnY79/AabqlpE/UAjecy
         qOcVd87lIt3E8emNLUGt7NiEo/ZbMEZcMmRd8QHCgvczIyELbWS2woZ41WdzjhQrY1
         mN39p+0S/ycTTM2xHeDLQj74GqC3VLS9RQ5kyeIk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CABA160E3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 22 Jul 2019 10:20:03 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH 1/2] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190722162003.GG25567@codeaurora.org>
References: <20190701152907.16407-1-ilina@codeaurora.org>
 <5d3209e7.1c69fb81.5ef1.5195@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d3209e7.1c69fb81.5ef1.5195@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 19 2019 at 12:20 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-01 08:29:06)
>> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>>
>> tcs->lock was introduced to serialize access with in TCS group. But
>> even without tcs->lock, drv->lock is serving the same purpose. So
>> use a single drv->lock.
>
>Isn't the downside now that we're going to be serializing access to the
>different TCSes when two are being written in parallel or waited on? I
>thought that was the whole point of splitting the lock into a TCS lock
>and a general "driver" lock that protects the global driver state vs.
>the specific TCS state.
>
Yes but we were holding the drv->lock as well as tcs->lock for the most
critical of the path anyways (writing to TCS). The added complexity
doesn't seem to help reduce the latency that it expected to reduce.
>>
>> Other optimizations include -
>>  - Remove locking around clear_bit() in IRQ handler. clear_bit() is
>>    atomic.
>>  - Remove redundant read of TCS registers.
>>  - Use spin_lock instead of _irq variants as the locks are not held
>>    in interrupt context.
>
>Can you please split this patch up into 3 or 4 different patches? I'm
>not sure why any of these patches are marked with Fixes either. It's an
>optimization patch, not a fix patch, unless the optimization is really
>large somehow?
>
Okay. I will try that.
>>
>> Fixes: 658628 ("drivers: qcom: rpmh-rsc: add RPMH controller for QCOM
>> SoCs")
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/soc/qcom/rpmh-internal.h |  2 --
>>  drivers/soc/qcom/rpmh-rsc.c      | 37 +++++++++++---------------------
>>  drivers/soc/qcom/rpmh.c          | 20 +++++++----------
>>  3 files changed, 21 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index a7bbbb67991c..969d5030860e 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index e278fc11fe5c..92461311aef3 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -93,8 +93,7 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
>>
>>  static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>>  {
>> -       return !test_bit(tcs_id, drv->tcs_in_use) &&
>> -              read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
>> +       return !test_bit(tcs_id, drv->tcs_in_use);
>
>This can be a diffedjusted rent patch. Why is reading the tcs register
>redundant? Please put that information in the commit text.
>
The tcs_in_use, is adjusted along with the DRV_STS and reading the
tcs_in_use should be enough.

Thanks for your review Stephen.

--Lina
