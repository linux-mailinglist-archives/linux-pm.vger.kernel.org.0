Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189422B96CE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 16:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgKSPrX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 10:47:23 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:40592 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbgKSPrX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 10:47:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605800842; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ELgx2uYswVqizONE6wXjsqFy6Y7WtmIS7nO1pn1KocE=; b=sw4TIu95wi7CLo1v4O6cESKHvUkEOWPXfVsesthHmWYzbE9AjUIEeCT+XZgtcrdqq0SZt0wO
 1pau/XHlOeaRayql/nP7mGiJ4FEjH+XJzdEEPY1TXeMo89MXPNY27axYcZB+vpGOcB3/+Mdo
 fuiDObfmymH4ebjfRvAvoG6QRJs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fb69384a5a29b56a17343cb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Nov 2020 15:47:16
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F25F9C43464; Thu, 19 Nov 2020 15:47:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF8D9C43465;
        Thu, 19 Nov 2020 15:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF8D9C43465
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 19 Nov 2020 08:47:13 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <X7aTgQrHQmClrEt3@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
 <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org>
 <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
 <X6wRBLmvzztNai4y@codeaurora.org>
 <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
 <X7KhcItlnS+uuqK2@codeaurora.org>
 <CAPDyKFpKookuX2ynBfy44kyfZq48JPaUrEHevetsyoc83=UnsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFpKookuX2ynBfy44kyfZq48JPaUrEHevetsyoc83=UnsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19 2020 at 02:57 -0700, Ulf Hansson wrote:
>On Mon, 16 Nov 2020 at 16:57, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Fri, Nov 13 2020 at 03:34 -0700, Ulf Hansson wrote:
>> >On Wed, 11 Nov 2020 at 17:51, Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
>> >> >On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
>> >> >>
>> >> >> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
>> >> >> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
>> >> >> >>
>> >> >> [...]

>>
>> What you are suggesting is that, we should not power down the domain in
>> such a case. This would be a really hard problem to debug when a device
>> leaves a stale wakeup behind and we no longer power off the domain
>> because of that. Tracking that back to the device will be a monumental
>> effort. Ignoring the next wakeup though might involve a power/perf
>> penalty (no worse than today), but we would not have a difficult problem
>> to solve.
>
>Hmm, you have a good point!
>
>Additionally, I guess it should be a rather seldom situation, as in
>principle the wakeup irq should have been triggered already.
>
>That said, I am okay to stick with your suggested approach.
>
>Although, please add a comment in the code, to make it clear that the
>behaviour is deliberate. Perhaps we should also clarify the function
>description of dev_pm_genpd_set_next_wakeup() (in patch1) to make the
>behaviour more clear for the user.
>
Sure, will update with comments.
>>

Let's revisit the patch again after I repost, to make sure this is what
we want, atleast for now.

Thanks for your review, Ulf.

--Lina

