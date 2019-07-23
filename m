Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991DC7200C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391604AbfGWTWE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 15:22:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388860AbfGWTWE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 15:22:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0AA1360FEA; Tue, 23 Jul 2019 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563909723;
        bh=bfET2k5xpnZDhEFDAJZolFfmIsNzlqNPLX0+nG24TTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJY3y4jJSJfOXehEeN11f5G5Q74+niajD7c81rIWMX2dfKdROLpyaLfbRKONGKjnh
         W6ayyZRSolnrpqXPJuFk3Mw+Gf0YUXqEJY8vF6mHMIGhWRUCgstLMM6haLCGMwDzWf
         nkCrFpU/Lbbm8ZIfanCEYFlbYfXJscb9n6B7FFRw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2CF0618DC;
        Tue, 23 Jul 2019 19:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563909720;
        bh=bfET2k5xpnZDhEFDAJZolFfmIsNzlqNPLX0+nG24TTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHbrgoKWIZ4I5DlJ2XtJTN6hAqWkfj1OgCvpe7u1bG2bTmW6RJN6jsrXfZDOcQXh0
         B/vAvQtArVZqbfwcbX1yloGPXzmnDuaKWVhPUn9JRT6g8WB+nN5mGGyeVHA0lKIMCO
         BTk5XmSRF9J0lWwoniPbJkqVTGm2tMhGpG6EZ020=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2CF0618DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 23 Jul 2019 13:21:59 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190723192159.GA18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <5d375054.1c69fb81.7ce3f.3591@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d375054.1c69fb81.7ce3f.3591@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23 2019 at 12:22 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-22 14:53:37)
>> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>>
>> The tcs->lock was introduced to serialize access with in TCS group. But,
>> drv->lock is still needed to synchronize core aspects of the
>> communication. This puts the drv->lock in the critical and high latency
>> path of sending a request. drv->lock provides the all necessary
>> synchronization. So remove locking around TCS group and simply use the
>> drv->lock instead.
>
>This doesn't talk about removing the irq saving and restoring though.
You mean for drv->lock? It was not an _irqsave/_irqrestore anyways and
we were only removing the tcs->lock.

>Can you keep irq saving and restoring in this patch and then remove that
>in the next patch with reasoning? It probably isn't safe if the lock is
>taken in interrupt context anyway.
>
Yes, the drv->lock should have been irqsave/irqrestore, but it hasn't
been changed by this patch.

>>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> [ilina: split patch into multiple files, update commit text]
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>
>> diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
>> index a7bbbb67991c..969d5030860e 100644
>> --- a/drivers/soc/qcom/rpmh-internal.h
>> +++ b/drivers/soc/qcom/rpmh-internal.h
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index e278fc11fe5c..5ede8d6de3ad 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -106,26 +106,26 @@ static int tcs_invalidate(struct rsc_drv *drv, int type)
>>  {
>>         int m;
>>         struct tcs_group *tcs;
>> +       int ret = 0;
>>
>>         tcs = get_tcs_of_type(drv, type);
>>
>> -       spin_lock(&tcs->lock);
>> -       if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS)) {
>> -               spin_unlock(&tcs->lock);
>> -               return 0;
>> -       }
>> +       spin_lock(&drv->lock);
>> +       if (bitmap_empty(tcs->slots, MAX_TCS_SLOTS))
>> +               goto done_invalidate;
>>
>>         for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>>                 if (!tcs_is_free(drv, m)) {
>> -                       spin_unlock(&tcs->lock);
>> -                       return -EAGAIN;
>> +                       ret = -EAGAIN;
>> +                       goto done_invalidate;
>>                 }
>>                 write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, m, 0);
>>                 write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
>>         }
>>         bitmap_zero(tcs->slots, MAX_TCS_SLOTS);
>> -       spin_unlock(&tcs->lock);
>>
>> +done_invalidate:
>> +       spin_unlock(&drv->lock);
>>         return 0;
>
>return ret now?
>
Yes, will do.
>>  }
>>
>> @@ -349,41 +349,35 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>  {
>>         struct tcs_group *tcs;
>>         int tcs_id;
>> -       unsigned long flags;
>>         int ret;
>>
>>         tcs = get_tcs_for_msg(drv, msg);
>>         if (IS_ERR(tcs))
>>                 return PTR_ERR(tcs);
>>
>> -       spin_lock_irqsave(&tcs->lock, flags);
>>         spin_lock(&drv->lock);
>>         /*
>>          * The h/w does not like if we send a request to the same address,
>>          * when one is already in-flight or being processed.
>>          */
>>         ret = check_for_req_inflight(drv, tcs, msg);
>> -       if (ret) {
>> -               spin_unlock(&drv->lock);
>> +       if (ret)
>>                 goto done_write;
>> -       }
>>
>>         tcs_id = find_free_tcs(tcs);
>>         if (tcs_id < 0) {
>>                 ret = tcs_id;
>> -               spin_unlock(&drv->lock);
>>                 goto done_write;
>>         }
>>
>>         tcs->req[tcs_id - tcs->offset] = msg;
>>         set_bit(tcs_id, drv->tcs_in_use);
>> -       spin_unlock(&drv->lock);
>>
>>         __tcs_buffer_write(drv, tcs_id, 0, msg);
>>         __tcs_trigger(drv, tcs_id);
>>
>>  done_write:
>> -       spin_unlock_irqrestore(&tcs->lock, flags);
>> +       spin_unlock(&drv->lock);
>>         return ret;
>>  }
>>
>> @@ -481,19 +475,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>  {
>>         struct tcs_group *tcs;
>>         int tcs_id = 0, cmd_id = 0;
>> -       unsigned long flags;
>>         int ret;
>>
>>         tcs = get_tcs_for_msg(drv, msg);
>>         if (IS_ERR(tcs))
>>                 return PTR_ERR(tcs);
>>
>> -       spin_lock_irqsave(&tcs->lock, flags);
>> +       spin_lock(&drv->lock);
>>         /* find the TCS id and the command in the TCS to write to */
>>         ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
>>         if (!ret)
>>                 __tcs_buffer_write(drv, tcs_id, cmd_id, msg);
>> -       spin_unlock_irqrestore(&tcs->lock, flags);
>> +       spin_unlock(&drv->lock);
>>
>
>These ones, just leave them doing the irq save restore for now?
>
drv->lock ??

--Lina

