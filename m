Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB277DE8F
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbjHPKW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbjHPKW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:22:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C377198E
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:22:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9c0391749so101903361fa.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181374; x=1692786174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWHFLpACxZAO5/ZoA3f4AeikGCdINKirvAi2Jpp8WUE=;
        b=II2uKBleK/4gTU+nn5aaPHK+Xfd0GGliyk8uNjSpoyP5aa5cqWCjxCPXT/D+dUO7gY
         jLqdY8nzm76BhCCrBaiKoF44M0gxpj21vX9AR3U8k3TqE70Jov8Dp5sTqoL/DzUIXYSc
         X5bHlK6lU/6QbNr8I0nADXMvN8IUAIiIXfQ37CdUfdxx3OuaIbK4NHJznQCJU8IKkXJw
         rJ/P488BpGNWw3LVxhSvAiakmo2cdZE6WZXouRhXCYGavwdE5Zn7fFyovL42E3Cvj3la
         l/nGPhhf91JTlYV/6M4BWpQLF2SFH0yF0Exu6dsnNWboySHPYO4JbzZGiQK1GcmN1pC2
         SeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181374; x=1692786174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWHFLpACxZAO5/ZoA3f4AeikGCdINKirvAi2Jpp8WUE=;
        b=kstNqpuRWJ3dEvoeVWAeL8MXknVwPKvP4441nazvLXeAcMfE3Ts36ANutTgIxtCIjv
         3N1cCJlfdepCzn/B2Xgt1bgwNPtwy4G/9KYtOM+ihdE4A6ZFeoBZ2NhsLYzaNnAIKl2R
         fMeunpc1Y2VbPJJxhHKAQ2Nn7xgO2Z0kGU4fgm6U+ulUTmgEfM2LnmGvHLlcZZyQrVka
         KRBD4E/TQ21LzhNgRBS1EpCS5NHHupNRKSV8tI5HNsGD39iNSA3f36lWB04RKd9+I9CT
         gLhHG8t/2dqNukpHTzPs6yXhmGtNm4JU/4PE9uvBvVAq9igMdDg4HO0q6VEyZhS+bUMH
         LtOA==
X-Gm-Message-State: AOJu0Yw3maqu3MNchp0aC9zn7eVO44yHFvfvOGZ8vKT/LwJq3j0GIVI+
        LE20O+0vNjs+s5GCiZbycGnWww==
X-Google-Smtp-Source: AGHT+IHiWxnoQTvo7u/msmmG/NFhPvc/EXHDwTOdk68TPp3iwoXFjedqMVn/RcTvGg+Vkr7JIYUKYw==
X-Received: by 2002:a2e:9a83:0:b0:2bb:9a28:972b with SMTP id p3-20020a2e9a83000000b002bb9a28972bmr701956lji.7.1692181374507;
        Wed, 16 Aug 2023 03:22:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1c7719000000b003fe4ca8decdsm23667389wmi.31.2023.08.16.03.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:22:54 -0700 (PDT)
Message-ID: <e47476f6-fb6d-4881-b4ac-86dc3247d80a@linaro.org>
Date:   Wed, 16 Aug 2023 12:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: broadcom: brcstb_thermal: removed unneeded
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     florian.fainelli@broadcom.com, rui.zhang@intel.com,
        amitk@kernel.org, rafael@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, mmayer@broadcom.com,
        alex@shruggie.ro
References: <20230809154813.16033-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230809154813.16033-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/08/2023 17:48, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

