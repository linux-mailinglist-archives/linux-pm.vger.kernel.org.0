Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7D2672A3D
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjARVRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjARVRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:17:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684542DC3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:17:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l8so123305wms.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yp3Dt9lKmFGZTgXGb5JVMPRjo+R/T7VLFs6hv9pOX2A=;
        b=yh8YdH04bzl7JVeNUmTlrr59QCswChNwCik/mWRUVEOtEIBdLRqlDbJfGYv7KDvdgB
         EQmlbBpkbCToI8DRXujABEJP37cNFB/C30lNHYd2xfzD8EGx2rTSQH2uGe2/1t98glum
         KdUgWiHvFDFxz/fhsFsQ5iJpCpYaYfA0FxEaPh+UtqDNiDLTnNwXHkrSTUea4AM8J9H7
         qbak28LX8xwAV5M1c9ZEghx8FVk/HkwyBISDsKvSuGQM2H3l8BBLaq7w2hRQKQqrOD5o
         WJNgn1emWJhLFi/yCwaHxTPgylkbtZIVl9jVdWxPWWgZpfLJsJDdbL9G2bismT88DgYL
         6DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp3Dt9lKmFGZTgXGb5JVMPRjo+R/T7VLFs6hv9pOX2A=;
        b=W41W3d3985IJCxuK/lQu7jyqUavxND3kL2BxinJ+m2vrAcY3MVBhuOkFZ02pwbWacx
         S03tJNKN2oRvUmZiICCM8bZMdm7KkFnFOZqvjUWkEqeneiNo3biZ0GLNqKVughfFsNwi
         K/mmL47VvAJPlCIkBe7SlQlf1Cvrf59E5om3hBPQ2MF7iZJ6G1Jkj70bdK9uVG8cO46T
         AlNHiBXeAqvo8VRwrHy5FrH9oAeiDiNRRQpO4qwxZ+p324cA5PaQMNpQkq9Y/ag/BQk6
         HuQMpxf3A3tE+McYK0f4KiUxEq7Dbch7Zl02EP2joffFrcVjJm+HCKB1vEwTIDR/1ZAo
         dpsw==
X-Gm-Message-State: AFqh2kquFCYyPLG72vrfm7Ti55mbiWJxm34awrq57VkETOqVrOe9tCaT
        C8hkAk3n1VpmUfHZB4qFGeke0A==
X-Google-Smtp-Source: AMrXdXsO04FKiFKnM3AMPe41NlEaZKV2ZPZQuDtAMUDtnhTF3O5zKAO6zbZbtnqjHq1LOZa6LuA7Og==
X-Received: by 2002:a05:600c:2206:b0:3d2:2a72:2577 with SMTP id z6-20020a05600c220600b003d22a722577mr7974908wml.27.1674076666699;
        Wed, 18 Jan 2023 13:17:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c2-20020a05600c0a4200b003daf6e3bc2fsm3994395wmq.1.2023.01.18.13.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:17:46 -0800 (PST)
Message-ID: <acf8c867-0188-727f-e633-52cd94203a74@linaro.org>
Date:   Wed, 18 Jan 2023 22:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/bcm2835=3a_Use=c2=a0dev?=
 =?UTF-8?Q?m=5fplatform=5fget=5fand=5fioremap=5fresource=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202301181636223863583@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181636223863583@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:36, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

