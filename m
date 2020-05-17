Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72E71D676D
	for <lists+linux-pm@lfdr.de>; Sun, 17 May 2020 12:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgEQKc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 May 2020 06:32:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31383 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEQKc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 May 2020 06:32:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589711545; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2Ot+L1wKDGqMcBOo6FkL+oGSqA8tD3Wir6teurhqckc=;
 b=kWKN4SqxCv7x7QImg/AOW3ttonknDfgX7IqTKeN+8RkXZFl0PIvmuY53Au1kpdlG9AFsZWFo
 8by5g+h8sQY3VyBFGnyybHDSi+8JCfKy8LWhnIggqSnFTX9UWWKxUhxUheXlc15KAdyBBvWm
 V+mCu2Ib0exxqRlM45cmIyQfJ1s=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ec112b90404ab4a8dd82d71 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 17 May 2020 10:32:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 870FFC433D2; Sun, 17 May 2020 10:32:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7D50C433F2;
        Sun, 17 May 2020 10:32:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 May 2020 16:02:23 +0530
From:   manafm@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: thermal: tsens: Add zeroc interrupt
 support in yaml
In-Reply-To: <20200505153819.GA19181@bogus>
References: <20200505111204.963-1-manafm@codeaurora.org>
 <20200505111204.963-3-manafm@codeaurora.org> <20200505153819.GA19181@bogus>
Message-ID: <73fa201face9710efa5ce143980f9b9e@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 21:08, Rob Herring wrote:
> On Tue,  5 May 2020 16:42:04 +0530, Manaf Meethalavalappu Pallikunhi 
> wrote:
>> Add 0C (zeroc) interrupt support for tsens in yaml.
>> 
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <manafm@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml:
> thermal-sensor@c263000: interrupt-names: ['uplow', 'critical',
> 'zeroc'] is too long
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/qcom-tsens.example.dt.yaml:
> thermal-sensor@c263000: interrupts: [[0, 506, 4], [0, 508, 4], [0,
> 510, 1]] is too long
> 
> See https://patchwork.ozlabs.org/patch/1283470
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install
> git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
Addressed above errors for 
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml in v2
