Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315E68901F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Feb 2023 08:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBCHGW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Feb 2023 02:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBCHGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 02:06:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E130F8;
        Thu,  2 Feb 2023 23:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BB5961DA4;
        Fri,  3 Feb 2023 07:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F15C433D2;
        Fri,  3 Feb 2023 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675407979;
        bh=KXmmvj9TMKpfjwzMXsQf9r4+Pnolpsn1ylx8jVAqHq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SlMchVuj9lWinpQEd6uO7qvFe1o5sSoHew8GZICqzzXxU3AnDyQ1PtbIKzKDJnQtN
         SaBTH8JpX2O3W9fmxl86ZQjMElhe31oy0HpHwUN9YaunGdw3brSE2UBQ5B0vfX5HpT
         5ZBXF2BBjNvXz12w8zBEIzhTLHcZzeKMGU1MrP+O38ryVNA8IJyxhv7ZHFG3GWrlUA
         hy9VFw62KaTgN67NnjwZC7+KgRMSF+mdLCMGvMrPOCinIAoevmR91CH+SG7Gb2EO1s
         TnNstzKrasg/8qyIme/sOgJ6fIYOjoSDKmrC4C9gU2FR+m5+ai4TVVGqQOgs+ZQH03
         qGzzpD9JaJq0Q==
Message-ID: <b71bd201-81ec-ffa0-f7ff-4a63795beb28@kernel.org>
Date:   Fri, 3 Feb 2023 08:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm CCI
 dt-bindings
To:     Jun Nie <jun.nie@linaro.org>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, bryan.odonoghue@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <9ab7383b-f3ed-3e48-d275-3c8933be5f2f@kernel.org>
 <CABymUCNKvm9+_ascdcWAgA1xGYKPhyO5C97-+rTTK739v+UEew@mail.gmail.com>
 <957f2bd0-d249-169b-04cc-242b9fcf8c6b@kernel.org>
 <CABymUCMA9fxGjKAxLhpnSxr92t-oFDfe=mOSiLWb4Jjbzs=n8g@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CABymUCMA9fxGjKAxLhpnSxr92t-oFDfe=mOSiLWb4Jjbzs=n8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/02/2023 04:45, Jun Nie wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 于2023年2月2日周四 17:42写道：
>>
>> On 02/02/2023 10:29, Jun Nie wrote:
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - qcom,msm8939-cci
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  operating-points-v2: true
>>>>> +  opp-table:
>>>>> +    type: object
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - clocks
>>>>> +  - operating-points-v2
>>>>> +  - nvmem-cells
>>>>
>>>> ?? You cannot require properties which are not present.
>>>>
>>>>> +  - power-domains
>>>>
>>>> Same here.
>>>>
>>>
>>> So the properties should be added later, after cpr and fuse nodes are
>>> available in mainline, right?
>>
>> No, binding should be complete, so why would you skip some properties? I
>> don't see here dependency on other bindings. Unless I missed here
>> something and there is a dependency? But then what kind? Do you
>> reference other schema?
>>
>> Best regards,
>> Krzysztof
>>
> Sorry, it is a copy/modified error with overlooking some added properties.
> 
> +        cci_opp3: opp-cpr14-400000000 {
> +            opp-hz = /bits/ 64 <400000000>;
> +            opp-supported-hw = <0x1>;
> +            required-opps = <&cpr_opp14>;
> +        };
> +
> +        cci_opp4: opp-cpr15-400000000 {

This does not answer my concerns at all. Please include all relevant
properties in your bindings.

> Documentation/devicetree/bindings/interconnect/qcom,cci.example.dtb:
> opp-table-cci: Unevaluated properties are not allowed
> ('opp-cpr14-400000000', 'opp-cpr15-400000000' were unexpected)
> 
> Do you know how to fix this dts check warning?

Don't add properties which are not allowed or do not name properties in
a way it is not allowed.

> The cci_opp3 and cci_opp4 have the same frequency but with different
> requirements to

So you used the same node names... how do you expect such code to
compile? In current form bindings do not allow such setup. If you think
that OS should allow and support it, then change the bindings.


Best regards,
Krzysztof

