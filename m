Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E99398DDF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhFBPH2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 11:07:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50297 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232027AbhFBPH1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Jun 2021 11:07:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622646344; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b58AXVipv2czeTZD7vN1C4eQotA0VCcV+WTBefkUG/M=;
 b=oeR47NnF59XTdihDlQNZjLaGibNX6xzi3umvSWKgrBi829CQsX9cyJ5O8wvcSegxJ9RI539X
 2tqiqUMTqHRcgZY1B6F5vZfSgRZEwE5tpejRJqiSNVZhWKNxuviD0DZdpJS0myBDdJWGk98h
 Ejb+Mp6Ax0JDMHLqxXYkCYksebE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60b79e36e570c05619dc46bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Jun 2021 15:05:26
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3041C4338A; Wed,  2 Jun 2021 15:05:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52809C433F1;
        Wed,  2 Jun 2021 15:05:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jun 2021 20:35:23 +0530
From:   okukatla@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     elder@linaro.org, bjorn.andersson@linaro.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, sboyd@kernel.org,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        evgreen@google.com, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [V2 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
In-Reply-To: <1621392491.220233.1905257.nullmailer@robh.at.kernel.org>
References: <1621359242-18641-1-git-send-email-okukatla@codeaurora.org>
 <1621359242-18641-2-git-send-email-okukatla@codeaurora.org>
 <1621392491.220233.1905257.nullmailer@robh.at.kernel.org>
Message-ID: <115d8e912d8c986c5a9689c080dfbe3d@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-05-19 08:18, Rob Herring wrote:
> On Tue, 18 May 2021 23:04:00 +0530, Odelu Kukatla wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
>> SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  3 
>> ++-
>>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 
>> +++++++++-
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.example.dt.yaml:
> interconnect@17d41000: reg: [[399773696, 5120]] is too short
> 	From schema:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> 
> See https://patchwork.ozlabs.org/patch/1480367
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
Thanks Rob!.
I will address this in next revision.
