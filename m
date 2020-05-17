Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C81D6766
	for <lists+linux-pm@lfdr.de>; Sun, 17 May 2020 12:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEQKa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 May 2020 06:30:59 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31093 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbgEQKa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2020 06:30:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589711459; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kIhXLMdA5ZrfQnPXVidDK3jLUOy9vXelm7icBPUDlwY=;
 b=pufvxTDnbOLLF1nmblqeaAeaX+IkbR9jJWOh4ksawtnppdkhUo9lD5bMZDqJnvps6sJ8vB4u
 s8hTn4zABCim+jMKvd58mih5CJnH9wsctfyDj2FYQgb6nbGUTBmP8iIc6Y+dHzqlZEaxfL4O
 77Bkl4n9QiT5opy6qxETEj4KjCo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec1124b.7fe9c4e59420-smtp-out-n05;
 Sun, 17 May 2020 10:30:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 81F35C44788; Sun, 17 May 2020 10:30:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AA3CC43636;
        Sun, 17 May 2020 10:30:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 May 2020 16:00:33 +0530
From:   manafm@codeaurora.org
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Add 0C (zeorC) interrupt support to tsens driver
In-Reply-To: <CAP245DWxDVBAXU_1uqfA0iuajVCZvZOL4HG4VOOwZ1qMSuuMSA@mail.gmail.com>
References: <20200505111204.963-1-manafm@codeaurora.org>
 <CAP245DWxDVBAXU_1uqfA0iuajVCZvZOL4HG4VOOwZ1qMSuuMSA@mail.gmail.com>
Message-ID: <a6d18a8e0fc1ef813f8100474fc9928b@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 17:42, Amit Kucheria wrote:
> Hi Manaf,
> 
> Thanks for sending this.
> 
> Typo: zeorc in subject line.
Done
> 
> 
> On Tue, May 5, 2020 at 4:42 PM Manaf Meethalavalappu Pallikunhi
> <manafm@codeaurora.org> wrote:
>> 
>> Changes:
>> * Add zeroc interrupt support to tsens driver
>> * Update zeroc interrupt support in yaml
>> 
>> Manaf Meethalavalappu Pallikunhi (2):
>>   drivers: thermal: tsens: Add 0C (zeorC) interrupt support
>>   dt-bindings: thermal: tsens: Add zeroc interrupt support in yaml
>> 
>>  .../bindings/thermal/qcom-tsens.yaml          |  7 +-
>>  drivers/thermal/qcom/tsens-common.c           | 72 
>> ++++++++++++++++++-
>>  drivers/thermal/qcom/tsens-v2.c               |  7 ++
>>  drivers/thermal/qcom/tsens.c                  | 51 +++++++++++--
>>  drivers/thermal/qcom/tsens.h                  | 11 +++
>>  5 files changed, 140 insertions(+), 8 deletions(-)
>> 
>> --
>> 2.26.2
