Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877242D4537
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLIPTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 10:19:24 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:31817 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgLIPTW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 10:19:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607527136; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=nk2LdvOUPXoWK1/EktFM/brqUSemntfMxA6Fzq9tCOE=; b=t+TlxJ2KS4Le7RqJNoqAb+R57b3LWvMH0acnV7Kkikt2QiupseGDgNyWD1jLwIIxRk63imms
 Iyfl5eryxe7YVQgwcjMYkJVWrTyYkK9M1VCQQ2oYrz9Hoda2JW6AWKTsHczc+zcoys/gXLo+
 uEXlXRZTfRIwEtCoK2fVkEXgPJQ=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fd0eabed5b4c78a8ff87eea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 15:18:22
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E2C5C43462; Wed,  9 Dec 2020 15:18:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA69FC433C6;
        Wed,  9 Dec 2020 15:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA69FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 9 Dec 2020 08:18:19 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] Better domain idle from device wakeup patterns
Message-ID: <X9Dqu1QjURikO3jM@codeaurora.org>
References: <20201130225039.15981-1-ilina@codeaurora.org>
 <CAJZ5v0g+nK+jV+Gy+BKEALRtsXDK0HnDbz07Nv3KPK5L3V3OKg@mail.gmail.com>
 <CAPDyKFpD6L0r=YBEEjfjc85gx_7p5cVw20fwUxecpQp2dNU-0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFpD6L0r=YBEEjfjc85gx_7p5cVw20fwUxecpQp2dNU-0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 09 2020 at 03:37 -0700, Ulf Hansson wrote:
>On Tue, 8 Dec 2020 at 18:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Nov 30, 2020 at 11:51 PM Lina Iyer <ilina@codeaurora.org> wrote:
>> >
>> > Hi,
>> >
>> > The v5[1] of the series brought out some interesting discussions. The
>> > most important being is it worth adding the additional expense to all PM
>> > domains even if no wakeup pattern is available. It seems like
>> > maintaining a domain specific flag that the governor could check is a
>> > generic enough option. That should disable additional overhead for
>> > domains that do not need this feature.
>> >
>> > Ulf suggested that we could allow wakeups only if any of the domain idle
>> > state specifies a residency. However, we don't want to check for next
>> > wakeup everytime the domain enters idle just because the domain
>> > specifies an idle state with residency. This is also not desired.
>> >
>> > Also, if the domain checks for next wakeup, should the parent domains of
>> > the domain also check for next wakeup? And when do we set that up? These
>> > are questions that we don't know the answers yet. So, let's enable the
>> > domain governor only if the domain sets up the flag or when the device
>> > in the domain specifies the next wakeup.
>> >
>> > The previous post of the series explaining why this is a useful feature
>> > is v5[1]. Please let me know what you think.
>>
>> Ulf had comments on the previous versions, so waiting for him to
>> respond here, thanks!
>
>Yes, I will have a look, but please allow me some more time - it's a
>busy period for me.
>
Thank you.

-- Lina
