Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951FA373866
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEEKMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 06:12:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44489 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232272AbhEEKMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 06:12:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620209494; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=eCTOUvt1cwy7BNyNIjIIqYkFgnO9gbRzCYmN9NBDc30=;
 b=KvoQHCubjNewsPtF2+7+9qrFjmDwozjFNQAqsscLrrQizB8rftQJWSr2GT/f4zRLVQ6NlTST
 b9gHoQwweRg3TfcEAG0akrvKyR1UPRkcfn8h2LSPXI3OQO9K7Rb03UMoy9jnbFsn0618U986
 o05xigliUk9YMaLe5GjEO+lRrA8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60926f4e2cbba889804a0024 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 10:11:26
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A711C433F1; Wed,  5 May 2021 10:11:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E564CC433F1;
        Wed,  5 May 2021 10:11:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 15:41:23 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
In-Reply-To: <CAD=FV=Vng40b05F2_i7qqXC+yN=ZBgRXsio-86sBA+QdoMMGaw@mail.gmail.com>
References: <1620111510-31455-1-git-send-email-sibis@codeaurora.org>
 <1620111510-31455-3-git-send-email-sibis@codeaurora.org>
 <CAD=FV=Vng40b05F2_i7qqXC+yN=ZBgRXsio-86sBA+QdoMMGaw@mail.gmail.com>
Message-ID: <418a64429a9f0b3138a72b9321e832dd@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Doug,

Thanks for the review!

On 2021-05-05 01:32, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 3, 2021 at 11:59 PM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> +       cpu0_opp_table: cpu0_opp_table {
>> +               compatible = "operating-points-v2";
>> +               opp-shared;
>> +
>> +               cpu0_opp1: opp-300000000 {
> 
> It seems like it might be nicer to give the node labels a less
> arbitrary name. How about?
> 
> cpu0_opp_300mhz: opp-300000000
> 
> That has advantes:
> 
> * If, for some reason, you have to mess with some operating point in
> another dts it'll be less fragile.
> 
> * It'll make diffing easier between SoCs.
> 
> * If you end up putting a new operating point in the middle you don't
> need to rename everything below.

sure makes sense, will fix it in v3.

> 
> Other than that, I can't say that I'm a huge expert on the
> interconnect stuff and whether those make sense, but I'm still OK
> with:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
