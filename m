Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839412E33A6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 03:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgL1Cbh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 21:31:37 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:46886 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL1Cbg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 21:31:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609122671; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=fnkZRhsvKBso4eHTrKPAGzTpdKug6mOe3cG9iKaqQJU=; b=vAtSpH+ljDG03VVtCEj6fH7cFnwuwJX1m4RUlQyHtwNNqFHgyd6MVVTLwc48YCadyiWOKNAm
 hv4Qbkq3heTkbtL7bLFctBks6ks5F6dALXjDdOAfOAOAxlMi3uwZskKhhbUBSWywL8cqvHka
 SoPxq/GCVVakquBlVlWmhLh1k10=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fe94351e61d77c971d29047 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Dec 2020 02:30:41
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0173FC433C6; Mon, 28 Dec 2020 02:30:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03BD5C433CA;
        Mon, 28 Dec 2020 02:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03BD5C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Sun, 27 Dec 2020 19:30:39 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] PM / Domains: allow domain idle states to be disabled
Message-ID: <X+lDTxDqTS9ik9TR@codeaurora.org>
References: <20201216175056.19554-1-ilina@codeaurora.org>
 <CAPDyKFrdZTd0mWHYhk13uyNWoxqjkO_iSni_TC5uir-PpgxSpw@mail.gmail.com>
 <X+VBBKZXZ2JW3ZDL@codeaurora.org>
 <CAPDyKFrAV5Af8WVTy==u1-Ak7zrwC+X7bWSRCc_RrwHoTKfVGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFrAV5Af8WVTy==u1-Ak7zrwC+X7bWSRCc_RrwHoTKfVGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 26 2020 at 05:33 -0700, Ulf Hansson wrote:
>On Fri, 25 Dec 2020 at 02:31, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Tue, Dec 22 2020 at 03:16 -0700, Ulf Hansson wrote:
>> >On Wed, 16 Dec 2020 at 18:51, Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> In order to debug critical domain and device power issues, it may be
>> >> necessary to disallow certain idle states at runtime. Let the device
>> >> disallow a domain idle state before suspending.The domain governor shall
>> >> check for the 'disabled' flag while determining the domain idle state.
>> >
>> >For debug purposes, you might as well just set a dev PM Qos latency
>> >request that corresponds to the state you want to disable. This will
>> >then prevent the genpd governor from selecting the state.
>> >
>> True, but it will also disable idle states deeper as well. Would like to
>> avoid that.
>
>I see. In any case, I am not so excited about adding an exported genpd
>interface for this that drivers can call, for example.
>
>Then I would rather see a proper debugfs interface, where userspace
>can both see the available states and choose which one to
>disable/enable. Would that work?
>
Sure, that would work. Any recommendations for existing debugfs node
that we can add this to or something new?

--Lina
