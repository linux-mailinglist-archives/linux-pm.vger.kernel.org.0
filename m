Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDAF7323D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfGXOwz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 10:52:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGXOwz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 10:52:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BEC4260256; Wed, 24 Jul 2019 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563979973;
        bh=GLF+INpUZtE9vDJdCTqRAtCJy5OjjE16gdlqI1ORlT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TdQ7z7+0lgIwRufSCZJ94H9BM6jN6fQ9sh+dDMMS+x8HG0IMGNd15ozl7BCaLj6hB
         +KH9Uj1Fyzee8aIfT0vh3Qb+C8nyVSXMe0c0ffFCPSy1P9dewg4J0RyfcaQ6LGH0B0
         Xqq/UrtOGxhXCOLdi/Pc3U8vY89Kgb5H3hVIvDrc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 840C160256;
        Wed, 24 Jul 2019 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563979972;
        bh=GLF+INpUZtE9vDJdCTqRAtCJy5OjjE16gdlqI1ORlT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QND30vBzpIkaYYFjjvb2CT2OH40UymiL3J86jcesMc7H0XSMHVTiFYVSWQs2rev0K
         yBpfVDzLjBwijs3EiVMX/Qpoy9IfZGOuNUw4JQ4QKelTd3SyskBCaWca/Z2/iEwFSX
         D0YV6YBWte/uye5F+POPV0UZ/pxUV/7ROT8mnjYw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 840C160256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Jul 2019 08:52:51 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the
 interrupt handler
Message-ID: <20190724145251.GB18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <20190722215340.3071-2-ilina@codeaurora.org>
 <5d3769df.1c69fb81.55d03.aa33@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d3769df.1c69fb81.55d03.aa33@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23 2019 at 14:11 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-22 14:53:38)
>> Avoid locking in the interrupt context to improve latency. Since we
>> don't lock in the interrupt context, it is possible that we now could
>> race with the DRV_CONTROL register that writes the enable register and
>> cleared by the interrupt handler. For fire-n-forget requests, the
>> interrupt may be raised as soon as the TCS is triggered and the IRQ
>> handler may clear the enable bit before the DRV_CONTROL is read back.
>>
>> Use the non-sync variant when enabling the TCS register to avoid reading
>> back a value that may been cleared because the interrupt handler ran
>> immediately after triggering the TCS.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>
>I have to read this patch carefully. The commit text isn't convincing me
>that it is actually safe to make this change. It mostly talks about the
>performance improvements and how we need to fix __tcs_trigger(), which
>is good, but I was hoping to be convinced that not grabbing the lock
>here is safe.
>
>How do we ensure that drv->tcs_in_use is cleared before we call
>tcs_write() and try to look for a free bit? Isn't it possible that we'll
>get into a situation where the bitmap is all used up but the hardware
>has just received an interrupt and is going to clear out a bit and then
>an rpmh write fails with -EBUSY?
>
If we have a situation where there are no available free bits, we retry
and that is part of the function. Since we have only 2 TCSes avaialble
to write to the hardware and there could be multiple requests coming in,
it is a very common situation. We try and acquire the drv->lock and if
there are free TCS available and if available mark them busy and send
our requests. If there are none available, we keep retrying.

>>  drivers/soc/qcom/rpmh-rsc.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index 5ede8d6de3ad..694ba881624e 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -242,9 +242,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
>>                 write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
>>                 write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, i, 0);
>>                 write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
>> -               spin_lock(&drv->lock);
>>                 clear_bit(i, drv->tcs_in_use);
>> -               spin_unlock(&drv->lock);
>>                 if (req)
>>                         rpmh_tx_done(req, err);
>>         }
>> @@ -304,7 +302,7 @@ static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
>>         enable = TCS_AMC_MODE_ENABLE;
>>         write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
>>         enable |= TCS_AMC_MODE_TRIGGER;
>> -       write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
>> +       write_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, enable);
>>  }
>>
>>  static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
