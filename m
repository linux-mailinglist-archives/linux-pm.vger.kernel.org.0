Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC2C4B4211
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 07:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiBNGol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 01:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiBNGol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 01:44:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021C56C32
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 22:44:33 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3AE673F1CA
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 06:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644821072;
        bh=szUlu+QoiSpTo5flvrlczEK9xVnb6wy7sDmM3cvCZ3g=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=k/LaTa/waGbm/jHObtNdWEJfezjOQH0Bi/DGeJA0GW7QFntUPg6to3QGBCc3FsAHw
         pMKxoX8xsJyeWnc9uDNAXeGybmxx49nU0o5zrKXt539BpGvncYy9VnFFVP3G6i/6YN
         TICxW7uiLPLcqWzF3mOylAQ/RnXMBnzV9cgaCFlZiiApfeE49IMowP6B2z/0jTmm2d
         ti3QjjO/JqVAR6HMX4zioIqXwCTuW074uYmbu4lC4i5H9BfeLaaI+BtdSHwwlv1RUI
         62O3OIhgdXDLIaRKXrH7vIQ0wBzPbtoVm247yAH7sTP6/uwHNPRNM4zGbyYkUInDzI
         E9BNmtKearBZg==
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so2360015edh.9
        for <linux-pm@vger.kernel.org>; Sun, 13 Feb 2022 22:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=szUlu+QoiSpTo5flvrlczEK9xVnb6wy7sDmM3cvCZ3g=;
        b=Jey6cvJ7vmSSI5wPa8bDlliEJ3yAWC1Kc1XNqzA7EiyBJsoPY61bWkBeBYn155itRK
         35JiNUvW67/FzuQpfH5UO0nSWOOYQxx3O8rm/vZ0IIACh6NbU/TYkTUA1QgTBt2MNtLm
         ZDcoQyKCaPoUM+ZRoNpdxVFbosBi+HzqFflCi76RrTMbDYevT6xiJuyonjpI5MdH2nIk
         S6QS0JNz7KFQBoUmOhnigMUxg7jf/Yg4b+nIm1xMH+7Cf1LVoj3eaxp8irVUFXCpC8VG
         RChWJ+XeLdZsDMKbGW+fYVyaVPgrJu11o5Mj4hFxjc8fTajRSwOY87PIrt6FyJdr88q5
         +7rA==
X-Gm-Message-State: AOAM5339lzJp5WOMDyB+Xlm1xbPJ46TDIn2gJ92pRJA7bQOiBskwShcy
        647eP5MmE1uklH9JGugKfBLbC9YD3y9PqjGHPvRL9lnLBeQcTTP47Xr24PjKHFefPgmKrAVePql
        RRtfETzE0XDJAUy6m5J0em7latjbJQV604JfR
X-Received: by 2002:a17:906:4789:: with SMTP id cw9mr10461462ejc.97.1644821071935;
        Sun, 13 Feb 2022 22:44:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxupdkKcE3OpLuicXYosj+2o84uiRyIMaqb7dvs2AANYuzjXzjRY3ZfyTbVdDs4t5g8sYrSKw==
X-Received: by 2002:a17:906:4789:: with SMTP id cw9mr10461449ejc.97.1644821071725;
        Sun, 13 Feb 2022 22:44:31 -0800 (PST)
Received: from [192.168.0.103] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g16sm800256ejf.218.2022.02.13.22.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 22:44:31 -0800 (PST)
Message-ID: <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
Date:   Mon, 14 Feb 2022 07:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Content-Language: en-US
To:     =?UTF-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/02/2022 03:55, Edwin Chiu 邱垂峰 wrote:
> Hi Krzysztof:
> 
> Please see below answer.
> 
>>> +static struct cpuidle_driver sp7021_idle_driver = {
>>> +	.name = "sp7021_idle",
>>> +	.owner = THIS_MODULE,
>>> +	/*
>>> +	 * State at index 0 is standby wfi and considered standard
>>> +	 * on all ARM platforms. If in some platforms simple wfi
>>> +	 * can't be used as "state 0", DT bindings must be implemented
>>> +	 * to work around this issue and allow installing a special
>>> +	 * handler for idle state index 0.
>>> +	 */
>>> +	.states[0] = {
>>> +		.enter                  = sp7021_enter_idle_state,
>>> +		.exit_latency           = 1,
>>> +		.target_residency       = 1,
>>> +		.power_usage		= UINT_MAX,
>>> +		.name                   = "WFI",
>>> +		.desc                   = "ARM WFI",
>>
>> I have impression that there is no point in having custom driver with WFI...
>>
>> Still the main question from Daniel and Sudeep stays: why do you need this? You copied exactly
>> cpuildle-arm driver, there is nothing different here. At least I could not spot differences. Maybe except
>> that you use cpu_v7_do_idle explicitly.
>>
>> Unfortunately I cannot understand the explanation here:
>> https://lore.kernel.org/all/0812c44f777d4026b79df2e3698294be@sphcmbx02.sunplus.com.tw/
>> Why exactly cpuidle-arm does not work in your case?
>>
> Edwin=> I mean cpuidle-arm driver can't directly use with no modified.
>        If someone want to use cpuidle-arm driver, below modification seems necessary.
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        Static int sp7021_cpuidle_suspend_enter(unsigned long index) {~}
>        Static int __init sp7021_cpuidle_init(struct device_node *cpu_node, int cpu) {~}
>        Static const struct cpuidle_ops sc_smp_ops __initconst = {
>             .suspend = sp7021_cpuidle_suspend_enter,
>             .init = sp7021_cpuidle_init,
>        };
>        CPUIDLE_METHOD_OF_DECLARE(sc_smp, "sunplus,sc-smp", &sc_smp_ops); //declare enable method
>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        
>        But change cpuilde-arm.c for sunplus driver seems not reasonable.
>        That is why I want to submit cpuidle-sunplus.c
>        Althought sunplus cpuidle only come in WFI, but it can complete the cpuidle framework.

I don't think it is correct. You can use cpuidle-arm, because it is
being always initialized with device_initcall(). You either use
appropriate compatible in DT or add your compatible to cpuidle-arm.

Even if this did not work, then the solution is to use common parts, not
to duplicate entire driver. Duplicating is not acceptable.

Best regards,
Krzysztof
