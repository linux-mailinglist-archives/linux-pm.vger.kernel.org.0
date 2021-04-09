Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0797D359FFD
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 15:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDINjO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 09:39:14 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25764 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhDINjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 09:39:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617975541; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nCLKJ3txbssGA/MS9THnoJcM1/EpV+VVOtQ0VWZ6Umc=;
 b=AmcL94NG7Ck1xkGZlwlWfi/r3pf526qZKsLyVMdw1xxqxcRsva9Lqh4znvfyB/gDqYqekUOH
 I9SSXN2h7DsoEsRjzPknCaC6p7hH7Gcs+mvoWQE9XwEZdza4TUtaNfFYVbFv/OMvLRLWYGkj
 C52tz8yeAvioAStsGGO+xuTaEQY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 607058ec8807bcde1de095c9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 13:38:52
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D8B1C43462; Fri,  9 Apr 2021 13:38:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99624C43461;
        Fri,  9 Apr 2021 13:38:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Apr 2021 19:08:51 +0530
From:   skakit@codeaurora.org
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
In-Reply-To: <20210409115748.xfxukqgoyvscgpln@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
 <20210409115748.xfxukqgoyvscgpln@earth.universe>
Message-ID: <ad5d04c2a806213e9922834e996da15a@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-04-09 17:27, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 09, 2021 at 01:48:58PM +0530, skakit@codeaurora.org wrote:
>>> Please do not drop the example :)
>> 
>> As per my understanding on Rob's comments [1] I have added one 
>> complete
>> example in qcom,pm8941-pwrkey.yaml (see patch 4/4) and dropped it 
>> here.
>> 
>> [1] https://lore.kernel.org/patchwork/patch/1390062/#1588027
> 
> Ok, please add a note about this in the commit message.
> Something like:
> 
> The example has been removed in favour of full example being
> available in the qcom,pm8941-pwrkey binding.
> 

Okay.

> Thanks,
> 
> -- Sebastian
