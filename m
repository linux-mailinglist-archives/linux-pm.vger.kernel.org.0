Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1B73EB4
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389121AbfGXTgf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 15:36:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389113AbfGXTgf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:36:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDEC76063F; Wed, 24 Jul 2019 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563996993;
        bh=6rZFV4H+AtnrEFItZHF83yeAsV8YoILKdR1b4gFLTD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYm1pUYmMQEqee4K2snbkxIwLdZKMKnU2ZPM69OR5lDW8bIH6IWxr9WdInRQP7O6C
         4vLRSH0pHNFexcI4nBZzmGds23jHKFQuAmVMsYZiTihczGihsZszaEMIrbcowJqY2b
         wuLsVCY2Rsqf+tc+hrcB5J2vDnVK/0dsnRb9wuPo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3921A605A0;
        Wed, 24 Jul 2019 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563996991;
        bh=6rZFV4H+AtnrEFItZHF83yeAsV8YoILKdR1b4gFLTD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmBT2s8++wGXxO4N8+Dyj8Hi+INE6p4Lu/FR8W5b5iZt0AoxuGShf0IA8G6tdjdJC
         QRNS+TEllVKYDkuDDbyoZPZtulDxLwreq5FoKvQ7aDNKs7rQjkOrDKIoLNQAkPjbFI
         cyS92Zs4FeRn3XJ2Tw5Y4IotnQVbkKBpK0fDKKRI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3921A605A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Jul 2019 13:36:30 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: Re: [PATCH V2 1/4] drivers: qcom: rpmh-rsc: simplify TCS locking
Message-ID: <20190724193630.GD18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <5d375054.1c69fb81.7ce3f.3591@mx.google.com>
 <20190723192159.GA18620@codeaurora.org>
 <5d376bb3.1c69fb81.2bb4e.7771@mx.google.com>
 <20190724145452.GC18620@codeaurora.org>
 <5d38a430.1c69fb81.6e696.9e6f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d38a430.1c69fb81.6e696.9e6f@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 24 2019 at 12:32 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-24 07:54:52)
>> On Tue, Jul 23 2019 at 14:19 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-07-23 12:21:59)
>> >> On Tue, Jul 23 2019 at 12:22 -0600, Stephen Boyd wrote:
>> >> >Can you keep irq saving and restoring in this patch and then remove that
>> >> >in the next patch with reasoning? It probably isn't safe if the lock is
>> >> >taken in interrupt context anyway.
>> >> >
>> >> Yes, the drv->lock should have been irqsave/irqrestore, but it hasn't
>> >> been changed by this patch.
>> >
>> >It needs to be changed to maintain the irqsaving/restoring of the code.
>> >
>> May be I should club this with the following patch. Instead of adding
>> irqsave and restore to drv->lock and then remvoing them again in the
>> following patch.
>>
>
>I suspect that gets us back to v1 of this patch series? I'd prefer you
>just keep the save/restore of irqs in this patch and then remove them
>later. Or if the order can be the other way, where we remove grabbing
>the lock in irq context comes first and then consolidate the locks into
>one it might work.
>
Patches 1 and 3 need not be bundled. We can keep them separate to help
understand the change better.
This patch order - #2, #1, #3, #4 would work.

--Lina

