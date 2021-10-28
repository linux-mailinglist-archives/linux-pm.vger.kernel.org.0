Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410A43EA11
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ1VP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1VP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 17:15:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DAC061570;
        Thu, 28 Oct 2021 14:12:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j2so16371832lfg.3;
        Thu, 28 Oct 2021 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XF91eiN0iC14ROr83KuAgnnKSRf4eWRTqZgrNJQJHx0=;
        b=MJLJ1AGyaa1L9ChiUkSb6VfqZe8YaY3CS6pAwhJiIYR2JksscthTc8Gds4kcvEgq5z
         iaXlIyw2x7pOt0JM/CDAk4Wd4SyMPiGAAgaoaDMmXAmbK6TARMEtB9Zg1McAJtPiZoqz
         wwBP0fbXEEAdA+KcSKF0uw61NpdynZN57FJSU6ZvnDhgdeLbbmEskxQkf6vz7tURKaYN
         PyPF5E3sQ4cCgQGQiCCYgapxmuSls7lGhgf1ajVTGlns4ftmM5nR7u3FpydAUzYPW4YI
         90H/+Hn3UABOsu2zc/lsU0BhrRRY3kKVWNnK2mSN65VN4JxFjut5jWgeesTxQzco4/xQ
         ZUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XF91eiN0iC14ROr83KuAgnnKSRf4eWRTqZgrNJQJHx0=;
        b=oZBUw36gkR0O3k9DNLt8rLX0HX/V0nwhRd8SB3rHJrTTrbm9/gST4bi0rolVRNLZGX
         05RYxjJEwkW4LhR6zou4vM2i3Vq0+eFDq746o/9xoXapnb5GonxEz1O+vrJUAZgqQu8I
         XMsui+bJmf7LGoHNFLKn7a2mcAg1Gar+vg2WO6cQV/zFfrbKXg5csLx9KKzo4jJc3biA
         u/VSd3KFiJmvAUcMQTIwGSDu/wdHoi0z8QYEMSa/QoGF5mH6AXYsV6R+5YS8IvnnvbnF
         8YFEbm268MZMlADD+9pXgttD21SwWPxJbe+FRlBJh5OgdTSNVaqUAUmu/cYxc5Ag+Ypj
         0akw==
X-Gm-Message-State: AOAM532gur5cIDctlOEkkT5yF9G0Z61kQrUcggcnleLNMoQwDA6YLiNT
        ZKQZ8GWB5bRnjqsQTGNKw1FQX9LqW50=
X-Google-Smtp-Source: ABdhPJzpUYdLt7duRUCUwabBB4f1hRQD4mkQHJIUDsTOvz/3bmV500KcyoTuhXUeDLXD6gGjzb6rlQ==
X-Received: by 2002:a05:6512:21b1:: with SMTP id c17mr6717508lft.266.1635455578160;
        Thu, 28 Oct 2021 14:12:58 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru. [46.138.44.18])
        by smtp.googlemail.com with ESMTPSA id o21sm422349lfu.77.2021.10.28.14.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 14:12:57 -0700 (PDT)
Subject: Re: [PATCH v3] dt-bindings: opp: Allow multi-worded OPP entry names
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nishanth Menon <nm@ti.com>, David Heidelberg <david@ixit.cz>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20211024215718.28969-1-digetx@gmail.com>
 <YXnCW1KSg2RBIdDy@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c880012e-2986-aa42-6549-f47aa4bb1dde@gmail.com>
Date:   Fri, 29 Oct 2021 00:12:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXnCW1KSg2RBIdDy@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.10.2021 00:19, Rob Herring пишет:
> On Mon, Oct 25, 2021 at 12:57:18AM +0300, Dmitry Osipenko wrote:
>> Not all OPP entries fit into a single word. In particular NVIDIA Tegra OPP
>> tables use multi-word names where first part is freq and second voltage
>> because different hardware versions use different voltages for the same
>> freqs. Allow OPP entry to have multi-worded name separated by hyphen.
>> This silences DT checker warnings about wrong naming scheme.
>>
>> Reviewed-by: David Heidelberg <david@ixit.cz>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v3: - Viresh Kumar suggested that we shouldn't support postfix variant.
>>       I dropped variant with postfix naming scheme and multi-wording
>>       support of table names.
>>
>> v2: - In addition to a multi-wording support, support of the postfix
>>       *-opp-table naming scheme is added to the updated pattern.
>>
>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> index ae3ae4d39843..f79343960539 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> @@ -33,7 +33,7 @@ properties:
>>      type: boolean
>>  
>>  patternProperties:
>> -  '^opp-?[0-9]+$':
>> +  '^opp(-[0-9]+)*$':
> 
> This drops support for cases like 'opp1' which there are a ton of. It 
> should be '^opp(-?[0-9]+)*$' if we want to keep that support.
> 
> I'd love to be stricter, but trying to find a balance.

Good catch, let me make v4.
