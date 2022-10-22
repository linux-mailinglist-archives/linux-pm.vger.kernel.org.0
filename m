Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F2608E7A
	for <lists+linux-pm@lfdr.de>; Sat, 22 Oct 2022 18:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJVQ0m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Oct 2022 12:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJVQ0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Oct 2022 12:26:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363161057E0
        for <linux-pm@vger.kernel.org>; Sat, 22 Oct 2022 09:26:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e18so16574023edj.3
        for <linux-pm@vger.kernel.org>; Sat, 22 Oct 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQq1ftIfCawIcZ71Z4vpkzLEmtpaBABYme45VEwy43c=;
        b=l6VzlaOfRk+1vaUxRuG4Y3nWEtyo1rhBSa+uU9NJZP6+BYMRNndbHe4M3uIOYBg4Ql
         NFQSzX+EYfvdnizWUS/j0OXDQQ0Oo+Eoemz/uYypR1gIz7uJ6m39/RGqeWmFQF95q6HT
         SxOUPWD3tHIIWRJhOdI0PhuNHVHRpIJUUOo2k5y/9czjVGBhanlPSmVoiMwwJh/EJxTM
         2iWt91QG9olNOWFMtIaWT2jdrflob8g5f5fivtaOVlsiSoEhBobzor9VzKdEq7GaN/mm
         eLHq0HU2yfCf3vLDTazgktvD1HindtVNZe+ok8b9BuuLtatyHSTFqLk2xjnUOMP7Et2d
         6XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQq1ftIfCawIcZ71Z4vpkzLEmtpaBABYme45VEwy43c=;
        b=rzPcft6HJjwv5SkC6T1NES4nJU0fNdkI+DIzPXWxgGelY1n0EpDQKD2npCdsMaDx/I
         Apt2hadKIT8ejBX3KmzC2ANiJsRb7AxKYhK+G+ASe+LRZZ1R5qUHgGHZN+pCPVl0IPHH
         +tO5S8bH4siQ5I4dZ4NF+sJyRw5D07byzVB8meLDexCQbRNn41u6/vAa/+05tUP4KHXJ
         mR6VWS14EavNXo/9ZVMWGAA4J1VaMNdDc4gcvN7oxPggjbg5K2F8Aa1G5ZHS2tENQDfL
         x9k0A9VwCVMUVQTwU0R97LZDSzKSur4huRyi7Fmd+uJS2wFEUr895xu0jq+tT0jQcrxd
         rPpQ==
X-Gm-Message-State: ACrzQf2CEpuYh4kv44ftJXDY/1OjeEkEoNdIWuNUPRvkdkO5R1o2Y2wX
        X004xXK2Ma1vfowqjZK5K4dsAw==
X-Google-Smtp-Source: AMsMyM7a8uKW10yr4l06GQ3zKCGujmDoYBAOWchkmdpiQajQGty+HAC/UK/YbNYGmz+DCscgm/oDhw==
X-Received: by 2002:a05:6402:2813:b0:461:970e:2ad9 with SMTP id h19-20020a056402281300b00461970e2ad9mr880468ede.405.1666455997697;
        Sat, 22 Oct 2022 09:26:37 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7b1d:c5f2:c85:8976? ([2a05:6e02:1041:c10:7b1d:c5f2:c85:8976])
        by smtp.googlemail.com with ESMTPSA id 16-20020a170906309000b0078d22b0bcf2sm13156619ejv.168.2022.10.22.09.26.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:26:37 -0700 (PDT)
Message-ID: <373309fd-4931-5850-775a-4e4f04b86cff@linaro.org>
Date:   Sat, 22 Oct 2022 18:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/3] thermal: qcom: tsens: small fixup for debugfs
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221022125657.22530-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/10/2022 14:56, Christian Marangi wrote:
> This is a small series to fixup some bug in how tsens init debufs.
> 
> The first patch just handle situation where tsens fails to register and
> debugfs are getting registred anyway. When tsens is tried to reprobe
> debugs will print a warning as the directory are already there.
> 
> The second patch is a fixup for wrong version when the ancient VER_0 is
> used.
> 
> The third patch is a rework of debugfs structure moving version in the
> tsens istance instead of ignoring any other tsens istance if it will
> ever be the case in the future of having multiple tsens instance with
> different version. It's just futureproof on it's own and also removed
> one additional check.
> 
> changes v3:
> - remove extra space from patch 1
> - split patch 2 to 2 different patch
> - patch 3 rework wrong debugfs structure
> changes v2:
> - Changed sob name to new one.
> 
> (the resend was actually v2 but i totally forgot that I sent it as v2 with
> the sob name fixed... but everything should be good now...)
> 
> Christian Marangi (3):
>    thermal: qcom: tsens: init debugfs only with successful probe
>    thermal: qcom: tsens: fix wrong version id dbg_version_show
>    thermal: qcom: tsens: rework debugfs file structure
> 
>   drivers/thermal/qcom/tsens.c | 23 +++++++++--------------
>   1 file changed, 9 insertions(+), 14 deletions(-)

Applied thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
