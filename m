Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2619973246
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGXOy4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 10:54:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58300 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXOyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 10:54:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45D0960274; Wed, 24 Jul 2019 14:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563980094;
        bh=yWgNZ+6j27JK6qHT8Wru4w9mCaugWru6Fkq+nAqkWAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pua54TwApd+WIRPxsD62yTuahZGP8CGJFMO1meGOq+qsGoOvSOmuD8rZoi2PbOdIr
         N5PhuA9sZWIncNmhnMPY7faMPWHUiBV7+njNo8sKeXA0WCCJBKgZ6dMnB4xZHAlau4
         wdMqmgHyOt+bgbgMRTWBfED2BqS54Pe7jY0G2ssw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02DBD60256;
        Wed, 24 Jul 2019 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563980093;
        bh=yWgNZ+6j27JK6qHT8Wru4w9mCaugWru6Fkq+nAqkWAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtQ+dy6wZ/clfrH9yDnsfRlopdptwRgUupbLa7Gr/pfpGJeUNO8GKnVx9VEsC6d+y
         Y3v7JFxJsA/veONur0M94ZxBaugCuQjhsLrzVO+b9lZD0ZN6bppvoAkRNzDPPAdvTR
         9TiU9A5DiOirFuxxqLVMqODHyM4jWGK5+CCvsSfg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02DBD60256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Jul 2019 08:54:52 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190724145452.GC18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <5d375054.1c69fb81.7ce3f.3591@mx.google.com>
 <20190723192159.GA18620@codeaurora.org>
 <5d376bb3.1c69fb81.2bb4e.7771@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d376bb3.1c69fb81.2bb4e.7771@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23 2019 at 14:19 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-23 12:21:59)
>> On Tue, Jul 23 2019 at 12:22 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-07-22 14:53:37)
>> >> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>> >>
>> >> The tcs->lock was introduced to serialize access with in TCS group. But,
>> >> drv->lock is still needed to synchronize core aspects of the
>> >> communication. This puts the drv->lock in the critical and high latency
>> >> path of sending a request. drv->lock provides the all necessary
>> >> synchronization. So remove locking around TCS group and simply use the
>> >> drv->lock instead.
>> >
>> >This doesn't talk about removing the irq saving and restoring though.
>> You mean for drv->lock? It was not an _irqsave/_irqrestore anyways and
>> we were only removing the tcs->lock.
>
>Yes drv->lock wasn't an irqsave/restore variant because it was a
>spinlock inside of an obviously already irqsaved region of code because
>the tcs->lock was outside the drv->lock and that was saving the irq
>flags.
>
Oh, right.
>>
>> >Can you keep irq saving and restoring in this patch and then remove that
>> >in the next patch with reasoning? It probably isn't safe if the lock is
>> >taken in interrupt context anyway.
>> >
>> Yes, the drv->lock should have been irqsave/irqrestore, but it hasn't
>> been changed by this patch.
>
>It needs to be changed to maintain the irqsaving/restoring of the code.
>
May be I should club this with the following patch. Instead of adding
irqsave and restore to drv->lock and then remvoing them again in the
following patch.

>> >> @@ -349,41 +349,35 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> >>  {
>> >>         struct tcs_group *tcs;
>> >>         int tcs_id;
>> >> -       unsigned long flags;
>> >>         int ret;
>> >>
>> >>         tcs = get_tcs_for_msg(drv, msg);
>> >>         if (IS_ERR(tcs))
>> >>                 return PTR_ERR(tcs);
>> >>
>> >> -       spin_lock_irqsave(&tcs->lock, flags);
>> >>         spin_lock(&drv->lock);
>> >>         /*
>> >>          * The h/w does not like if we send a request to the same address,
>> >>          * when one is already in-flight or being processed.
>> >>          */
>> >>         ret = check_for_req_inflight(drv, tcs, msg);
>> >> -       if (ret) {
>> >> -               spin_unlock(&drv->lock);
>> >> +       if (ret)
>> >>                 goto done_write;
>> >> -       }
>> >>
>> >>         tcs_id = find_free_tcs(tcs);
>> >>         if (tcs_id < 0) {
>> >>                 ret = tcs_id;
>> >> -               spin_unlock(&drv->lock);
>> >>                 goto done_write;
>> >>         }
>> >>
>> >>         tcs->req[tcs_id - tcs->offset] = msg;
>> >>         set_bit(tcs_id, drv->tcs_in_use);
>> >> -       spin_unlock(&drv->lock);
>> >>
>> >>         __tcs_buffer_write(drv, tcs_id, 0, msg);
>> >>         __tcs_trigger(drv, tcs_id);
>> >>
>> >>  done_write:
>> >> -       spin_unlock_irqrestore(&tcs->lock, flags);
>> >> +       spin_unlock(&drv->lock);
>> >>         return ret;
>> >>  }
>> >>
>> >> @@ -481,19 +475,18 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>> >>  {
>> >>         struct tcs_group *tcs;
>> >>         int tcs_id = 0, cmd_id = 0;
>> >> -       unsigned long flags;
>> >>         int ret;
>> >>
>> >>         tcs = get_tcs_for_msg(drv, msg);
>> >>         if (IS_ERR(tcs))
>> >>                 return PTR_ERR(tcs);
>> >>
>> >> -       spin_lock_irqsave(&tcs->lock, flags);
>> >> +       spin_lock(&drv->lock);
>> >>         /* find the TCS id and the command in the TCS to write to */
>> >>         ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
>> >>         if (!ret)
>> >>                 __tcs_buffer_write(drv, tcs_id, cmd_id, msg);
>> >> -       spin_unlock_irqrestore(&tcs->lock, flags);
>> >> +       spin_unlock(&drv->lock);
>> >>
>> >
>> >These ones, just leave them doing the irq save restore for now?
>> >
>> drv->lock ??
>>
>
>Yes, it should have irq save/restore still.
>
