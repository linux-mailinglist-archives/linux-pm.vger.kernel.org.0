Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F626A0942
	for <lists+linux-pm@lfdr.de>; Thu, 23 Feb 2023 14:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjBWNBw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Feb 2023 08:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWNBv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2023 08:01:51 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162951F87
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 05:01:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so2680706wms.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Feb 2023 05:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYKvz6v9Qm8RLR69Xi3HrSQtP4/hBiOz+pHwtiihWek=;
        b=fdaxwdnhQRFFJCHjvavAmCGo9MnR53LbDA48v59Lcuvcj1KHNtYWQDHDSI5ngl5D7a
         bFx1WzhqFFPjiKX1k7m9BUMFc9xlchygSpNu2Sa09GpKJ4bNRlXpBii0066PGIybYxxX
         TA0f2qI9yGZrVEE7E+QJG0qFZZsVunbz5TS8NNsnHSRo8G0+T06fiUxkuN36gUk2mg+e
         naIpIll0oThras1TXYi0lPX6Hme/sZZ/Rqz5WpK9sMh1JCn9gc6iIoO6JNtElMdH0LXn
         RwbRcA2n4Hd0OYEGt6y9+7g6bUx3k4v2Ezh2Sn5AkLB+oUhafK4EUJMRJuEVDmDxE8MN
         FK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYKvz6v9Qm8RLR69Xi3HrSQtP4/hBiOz+pHwtiihWek=;
        b=xm+IhfwYBTTHHnXxGjk+MEn6Kp09sPfPkPEeV+roMAvG2/tJUwwim8x9uM0+XK0UBM
         3BtrY+JEde2WxldGtav2sEDjWlg9lHgYYhLT4mvXOPWYYsdpyLHfI90dK6opQVz/khaG
         /kq2wjbNuSVc28qekmbU4s1sO/xVYtN0ADh89XCRGjWsmzGXMDEYxD8+bKK3iY6et3DE
         CJ5rmlsnNS5/mtgqCKpM/zClysbwo9IrsLMKifC2stHO76N08fdHFmtEU7i157jrFOkX
         wS7s6VKRn5r3ffWlMk8DS6ipka6HtWRZkfMDbjfQdM2VDFAf0mok/sfqTHiWlK6hOvb5
         +pTQ==
X-Gm-Message-State: AO0yUKU+TTdihk9rqCPESPjO6Pjus2q8edUDczSR6YmJTRimH/taZZCO
        hjP1cB6JKsTfy7Qlx0kXSHS/sg==
X-Google-Smtp-Source: AK7set9V9rB0bZriA9L42bB5ZP5rCGPgvKUs1rwY98EgeGW7v5LfM3FhfNh0iPZLf49lH88jj5D5rA==
X-Received: by 2002:a05:600c:2cd8:b0:3ea:d610:f062 with SMTP id l24-20020a05600c2cd800b003ead610f062mr226629wmc.30.1677157306679;
        Thu, 23 Feb 2023 05:01:46 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003e209b45f6bsm9372002wmc.29.2023.02.23.05.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:01:46 -0800 (PST)
Message-ID: <449cdcb1-c2f9-7800-9451-cb2dc289b108@linaro.org>
Date:   Thu, 23 Feb 2023 13:01:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v5 01/10] interconnect: qcom: rpm: make QoS INVALID
 default, separate out driver data
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
 <20230217-topic-icc-fixes-v5-v5-1-c9a550f9fdb9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230217-topic-icc-fixes-v5-v5-1-c9a550f9fdb9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/02/2023 10:46, Konrad Dybcio wrote:

I find this commit log difficult to understand.

Could you reduce it down ?

> Currently, NOC_QOS_MODE_FIXED is defined as 0x0, which makes it the
> "default" option (as that's what uninitialized members of partially
> initialized structs are set to), which should really have been
> NOC_QOS_MODE_INVALID, and that's what people (wrongly) assumed was
> the case when .qos.qos_mode was not defined and what really makes
> the most sense..

"Currently NOC_QOS_MODE_FIXED is defined as 0x0 which makes it the 
default option. The default option however should be NOC_QOS_MODE_INVALID"

> That resulted in {port 0, prio 0, areq_prio 0, urg_fwd = false, rpm-voted}
> QoS being always voted for, because the code flow assumed "hey, it's fixed
> QoS, so let's just roll with whatever parameters are set" [again, set by
> partial struct initialization, as these fields were left unfilled by the
> developers]. That is of course incorrect, and on many of these platforms
> port 0 is MAS_APPS_PROC, which 9/10 times is supposed to be handled by
> the ap_owned path, not to mention the rest of the parameters may differ.
> Arguably, the APPS node is the most important one, next to EBI0..

This paragraph in particular is difficult to decipher, at least for me 
with my native Dublinese


> The modes are defined as preprocessor constants. They are not used
> anywhere outside the driver or sent to any remote processor outside
> qcom_icc_set_noc_qos(), which is easily worked around.
> Separate the type specified in driver data from the value sent to msmbus.
> Make the former an enum for better mainainability.
> 
> This is an implicit fix for every SMD RPM ICC driver that didn't
> explicitly specify NOC_QOS_MODE_INVALID on non-AP_owned nodes that
> don't have QoS settings.

It would be nice to reduce the commit log down to say three paragraphs 
of no more than three sentences each.

---
bod
