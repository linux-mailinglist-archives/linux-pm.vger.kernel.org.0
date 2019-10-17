Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8FDDB115
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbfJQP2V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 11:28:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36982 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391285AbfJQP2V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 11:28:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id u184so2257275qkd.4
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HxxMlxSnOHFXolbR3XOteHFHB5Y0fMxkCzdRoCJf6PE=;
        b=xgGpKj4TXIiDL2Gz1GlKIH2KXJ8E6eseq0BY8b2KgfYyfK58FKJ11SlPKH8K1smi82
         L35ggCBPhbbXjWHssTvzJuk2pRSddXo67qbvFKhD+7P7wfVM9p3w003AYYu8QtKBaLJz
         2SJRD9C4OCcncGkLr7jZ2LP3TOFI8Sp+9Xk2N2oJ+ONxCVLOy74EoTgOEUOE+XXMxYRa
         ISeYQhHPojhyy3MYnhOZ0R3NAvNFbQSY0iurBuFneYei4WRR+xP9dr2kzGnCDdO6RPm7
         XLA9Vf5fWpP8i8KPY1PnpPutVSmCO3oIC/2fxPyaK+tVs2q+0oPxB5/iKp+Q8A+wOtjT
         MxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HxxMlxSnOHFXolbR3XOteHFHB5Y0fMxkCzdRoCJf6PE=;
        b=JLlq+H+IYi9NLm7MHl/dv5AuKRTb1w+h1DzVp6D4iunRO91oph3YioZ9qPqPxOSBrW
         fS/B9VUlcC8panYkLQvyNwv764MoLB7UQz8HnufP6CpvZxt2Oj2mUmmLr0avmUdOJgjQ
         NrXq6Ytkg4Ppm23tsKs1LC1qRp99PVRUoUdYANYw4ApJGJt/usx8pY80CieS+18Ycbxw
         1ACa5PktTUgNtDc1L8oofoNAVcrIRrbS0aYvjMl8JkvT0KL6Cnm6WBqa26Dchu2Kvc1n
         rGCviNN8OLSGtHOGXy21Xq7VfYlc0xyohucwRVMCqB20oMXk2k8XHmIKi3W4j4ZGmJl6
         xcJA==
X-Gm-Message-State: APjAAAWuAKiEVA1BQqcZNbwoJ+lkGChX4Cqg2iJfGxoYqxcBVep0NBcn
        14s/rLPQCL+6L979GBV5OJZ+fA==
X-Google-Smtp-Source: APXvYqyp4wRR1ov3vJ/c6kD326l229dgP5IfCEwdoMk3qpE+kXLbkjhLaTm41gj0At0tLw14+faOlw==
X-Received: by 2002:a37:98c1:: with SMTP id a184mr3628260qke.119.1571326100082;
        Thu, 17 Oct 2019 08:28:20 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id q200sm1230672qke.114.2019.10.17.08.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 08:28:19 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
 <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA88892.5000408@linaro.org>
Date:   Thu, 17 Oct 2019 11:28:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Ulf,
Thanks for the review!

On 10/17/2019 05:04 AM, Ulf Hansson wrote:
> On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> RPMh power controller hosts mx domain that can be used as thermal
>> warming device. Add a sub-node to specify this.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> index eb35b22..fff695d 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
>> @@ -18,6 +18,16 @@ Required Properties:
>>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>>  various OPPs for different platforms as well as Power domain indexes
>>
>> += SUBNODES
>> +RPMh alsp hosts power domains that can behave as thermal warming device.
>> +These are expressed as subnodes of the RPMh. The name of the node is used
>> +to identify the power domain and must therefor be "mx".
>> +
>> +- #cooling-cells:
>> +       Usage: optional
>> +       Value type: <u32>
>> +       Definition: must be 2
>> +
> 
> Just wanted to express a minor thought about this. In general we use
> subnodes of PM domain providers to represent the topology of PM
> domains (subdomains), this is something different, which I guess is
> fine.
> 
> I assume the #cooling-cells is here tells us this is not a PM domain
> provider, but a "cooling device provider"?
Yep.
> 
> Also, I wonder if it would be fine to specify "power-domains" here,
> rather than using "name" as I think that is kind of awkward!?
Do you mean "power-domain-names" ? I am using this to match against the
genpd names defined in the provider driver.

Warm Regards
Thara

