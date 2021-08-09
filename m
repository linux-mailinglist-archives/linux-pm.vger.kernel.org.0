Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE83E4A0C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhHIQdD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 12:33:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21648 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhHIQck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 12:32:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628526739; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ScGC4Wqnf3TqhG3D0GIJYJnUSJr2rvY61q05HrRAX9w=;
 b=H9N68soig5d/rDUY0O/p5lywgUQJKucNaKPqkNTCIeA7EtdkDGXFMC9pN48/NVk9iuw0aZHP
 mEDmEZBVnxFglMq/EkZ++ZCH/azrnUq1k+8kTUiaeRgc7gkA9ST4iqBAZkZHv/hdAdwxRtyP
 wGA2AIayoaMdD1VzEFHfK0hpXDM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61115873f746c298d974aec5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 16:31:47
 GMT
Sender: okukatla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80F2BC43144; Mon,  9 Aug 2021 16:31:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: okukatla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1736C43460;
        Mon,  9 Aug 2021 16:31:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Aug 2021 22:01:46 +0530
From:   okukatla@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, evgreen@google.com,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V4 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
In-Reply-To: <CAE-0n51btkt9ehEFrm+WucP90ZufKw1PEQqzNGVDRy51jByXkw@mail.gmail.com>
References: <1624015734-16778-1-git-send-email-okukatla@codeaurora.org>
 <1624015734-16778-2-git-send-email-okukatla@codeaurora.org>
 <CAE-0n51btkt9ehEFrm+WucP90ZufKw1PEQqzNGVDRy51jByXkw@mail.gmail.com>
Message-ID: <618b3a664b3556718a867e815e94578f@codeaurora.org>
X-Sender: okukatla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks Stephen for the reviews!

On 2021-07-09 04:52, Stephen Boyd wrote:
> Quoting Odelu Kukatla (2021-06-18 04:28:52)
>> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
>> SoCs.
>> 
>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
>> ---
>>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  9 
>> ++++++++-
>>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 
>> +++++++++-
>>  2 files changed, 17 insertions(+), 2 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml 
>> b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> index d6a95c3..9f67c8e 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
>> @@ -18,12 +18,19 @@ properties:
>>    compatible:
>>      enum:
>>        - qcom,sc7180-osm-l3
>> +      - qcom,sc7280-epss-l3
>>        - qcom,sdm845-osm-l3
>>        - qcom,sm8150-osm-l3
>>        - qcom,sm8250-epss-l3
>> 
>>    reg:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 4
> 
> Can we base this on the compatible string so that only sc7280-epss-l3
> requires 4 items? and then the others require 1 reg property?
> 
Done, Addressing this in new revision.
>> +    items:
>> +      - description: OSM clock domain-0 base address and size
>> +      - description: OSM clock domain-1 base address and size
>> +      - description: OSM clock domain-2 base address and size
>> +      - description: OSM clock domain-3 base address and size
>> 
>>    clocks:
>>      items:
