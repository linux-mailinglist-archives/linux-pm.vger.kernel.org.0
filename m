Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC03A315ED9
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 06:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhBJFTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 00:19:11 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:35757 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231284AbhBJFTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2021 00:19:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612934331; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=yA4uPCcjgumhOn0bEUKjVJ4BqtcWpZ83bZnHx4aWj0s=; b=o947b+qH2jIrx5jfQhTDAMINa79ME+Su1MEf+CyMznFUr4Gd8VLIyGvYE7hd68IOX38gmMBw
 U6LaogUMkZq173brQKNOdgX49E9YPgjdqLQDAFWXlbOGAt14yT19Kugri0uXc2GiK6SrVNei
 IrdsQ2CC3EUKe7wEnqJWMGcNLjE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60236c9c8e43a988b781a34c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 05:18:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E7F1C433C6; Wed, 10 Feb 2021 05:18:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8A4AC433C6;
        Wed, 10 Feb 2021 05:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8A4AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Paul McKenney <paulmck@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: WARNING: suspicious RCU usage (5.11.0-rc7+ #1812 Tainted: G)
References: <2578278.ATerS0GEoy@kreacher>
        <YCJyJgEeiQqBRgzL@hirez.programming.kicks-ass.net>
        <877dnhv4lg.fsf@codeaurora.org>
        <CAJZ5v0iX0Bn7qjTB6S8exox_NYujAupUy4XkJAyFVNDjvnnZXg@mail.gmail.com>
Date:   Wed, 10 Feb 2021 07:18:13 +0200
In-Reply-To: <CAJZ5v0iX0Bn7qjTB6S8exox_NYujAupUy4XkJAyFVNDjvnnZXg@mail.gmail.com>
        (Rafael J. Wysocki's message of "Tue, 9 Feb 2021 18:44:21 +0100")
Message-ID: <87pn18tsa2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

>> > AFAICT that's a simple 'use RCU without holding rcu_read_lock' warning.
>> > I've not dug through ath10k to see who should be doing rcu_read_lock,
>> > but the few places I did look at don't seem to have changed recently.
>>
>> Just this morning I applied a patch which should fix this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=2615e3cdbd9c0e864f5906279c952a309871d225
>>
>> Please let me know if it fixes the issue.
>
> The traces are gone after applying this patch, so it does help:
>
> Tested-by: Rafael J. Wysocki <rafael@kernel.org>

Good, thanks for testing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
