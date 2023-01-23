Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D46783F4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjAWSCg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 13:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjAWSCg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 13:02:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BE2CFC6
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 10:02:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so11240670wmb.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 10:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yk2fX5q0jXoyVU2uukxJAFScsvm4XeRwSWczxQlKv7c=;
        b=qVg6gV5Bi3EkI4zHTcNGByKaQjGFOvWPkBlorpwTICHLWmVwrLQrcfzy/pakxNgb4Z
         t0obd8NOlg5OQGEGZeM+JLUmnxOFZZmvzHfTkuJpSMMWrGeb5DbHs0A2lbl7xXY0ojAM
         9Jwdo85MZEtuQI+eN5SBsoN6aykHJ4v0sC25XWV55+4Fbzq0ijYWhzsrn4C1JKHyjQe3
         b59kTAt2uuwxE6RgBuqnrjH99UJzmNuHDV/3biLsCEtClktzXNKoenweJq8vmTA2J5jx
         cdsT/4Cn2zZz5M9VW8ZI/OqX67Sc23sU6Hu86Ec3RzdOPCW0n0NncMu0cdgm9iB18XqN
         4F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yk2fX5q0jXoyVU2uukxJAFScsvm4XeRwSWczxQlKv7c=;
        b=1Q/Qs4k3qN02TOXOXC7Xuq1dcxtFe9GEZsmYXmS+Bhfe7trfCUpm2qQ/EIcjzydt82
         OEobQkl01nTctOEusvyaeQk3cfia7n9YZuHH76IUdpxRo5ZsZY0m7zXzvR+RVok+bRTy
         /tqjZe8I5xhI/oocSRaCkwoHFT68VUjXmnlEePYTO6JrX+4zM66c2fW32+jGUWfkdRTn
         phGYl3dVMluB9hZCLM0Z9B6EXCRukI1PNCqudmff2edr49f/7X9DHhXxqifmZhyNagnK
         FBpX6N9tT3jgMIhR209EARctumy9ouLsePbAobTQqcHA/FaCK1yaJCZvli6m4+0QY+XD
         pQcA==
X-Gm-Message-State: AFqh2koTIoE0DcWE801lG3w1Mu43YpGyHguKpVqxLSQdFk4pHzOr4+cj
        CAbY4IQZhb/w1McnihCae6glcA==
X-Google-Smtp-Source: AMrXdXvWK2tDK4Ma8vpazDen+DCctMU1tiawaFCNhCgqr3FDwfsmSpAB9iG7lkjLzjTOIU1xSNynqg==
X-Received: by 2002:a05:600c:4fcb:b0:3db:1919:41b5 with SMTP id o11-20020a05600c4fcb00b003db191941b5mr19016437wmq.21.1674496953315;
        Mon, 23 Jan 2023 10:02:33 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m18-20020a05600c4f5200b003cffd3c3d6csm12116756wmq.12.2023.01.23.10.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:02:32 -0800 (PST)
Message-ID: <7b263423-11f8-d3e8-d040-e045dc2fb74c@linaro.org>
Date:   Mon, 23 Jan 2023 19:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] thermal/drivers/intel: Use generic trip points for
 processor_thermal_device_pci
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-2-daniel.lezcano@linaro.org>
 <e7ab0321e8c655836960295987f69c18d940ae52.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e7ab0321e8c655836960295987f69c18d940ae52.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Srinivas,


On 18/01/2023 20:09, srinivas pandruvada wrote:
> On Wed, 2023-01-18 at 19:16 +0100, Daniel Lezcano wrote:
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops
>> are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them
>> with the
>> thermal zone.
>>
> In this scheme is the assumption is that trip point temperature never
> changes? If firmware updated the trip temperature, what needs to be
> done?

I'm a bit confused about the situation where the firmware can change the 
trip point in the back of the OSPM.

Does the firmware send a notification about the trip change? Or does it 
assume the OSPM will be reading the trip point while monitoring/polling 
the thermal zone ?

Is the question for this particular driver?

If the trip point is changed by the userspace (via sysfs), 
thermal_zone_set_trip() is used which in turn changes the thermal trip 
temperature directly in the generic structure and then calls the back 
set_trip_temp.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

