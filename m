Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8334687934
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 10:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBBJm5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 04:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjBBJmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 04:42:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C0188CE8;
        Thu,  2 Feb 2023 01:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2C161A5A;
        Thu,  2 Feb 2023 09:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6326C433EF;
        Thu,  2 Feb 2023 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675330963;
        bh=EpEsPXHTfq1Trd1poTYciPyNaom4IpT1mjFpseZa2j4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j5Je/kWAazMx/2WlJdMFb2OQ+5jS4s0LYDAFQ5zX348ono7CplwCNNx9YOG5gEBkd
         VZRBeDE2TY1sYZoaEDvzWIwt3MwzGFIQP4A4Q3JWR1x7d9kDSSWMBeSIZwzIZKsH0O
         6VFBuux01Ew1mFjfnJIkZbNZkOwOURMqzc+I7dRrHzESJlT0Cm38Zb0pfOpe1xymzS
         3tpitAS6mvRVRcfdi3RwWdaG99y28XmSe4gTCSn3AL92fhPNku/I3cAvMZeRY1p1ri
         tBCjZl8MxqPYFUW/JlCnnFe4itbLFwwYtkScZcbBqB0Pd7qPYCD5kVAQVLUlozT4hY
         XtfuWWDu+SWgw==
Message-ID: <957f2bd0-d249-169b-04cc-242b9fcf8c6b@kernel.org>
Date:   Thu, 2 Feb 2023 10:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI
 dt-bindings
Content-Language: en-US
To:     Jun Nie <jun.nie@linaro.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <9ab7383b-f3ed-3e48-d275-3c8933be5f2f@kernel.org>
 <CABymUCNKvm9+_ascdcWAgA1xGYKPhyO5C97-+rTTK739v+UEew@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CABymUCNKvm9+_ascdcWAgA1xGYKPhyO5C97-+rTTK739v+UEew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/02/2023 10:29, Jun Nie wrote:
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,msm8939-cci
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  operating-points-v2: true
>>> +  opp-table:
>>> +    type: object
>>> +
>>> +required:
>>> +  - compatible
>>> +  - clocks
>>> +  - operating-points-v2
>>> +  - nvmem-cells
>>
>> ?? You cannot require properties which are not present.
>>
>>> +  - power-domains
>>
>> Same here.
>>
> 
> So the properties should be added later, after cpr and fuse nodes are
> available in mainline, right?

No, binding should be complete, so why would you skip some properties? I
don't see here dependency on other bindings. Unless I missed here
something and there is a dependency? But then what kind? Do you
reference other schema?

Best regards,
Krzysztof

