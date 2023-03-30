Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDF6D0992
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjC3PbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjC3PbR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 11:31:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D25D515
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:30:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v6-20020a05600c470600b003f034269c96so1810821wmo.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6mjtUcThghUsbwg6hgP26FqHa4HFNPgLRW+Curo8kk=;
        b=kqnKTzM86XNR2ARxUIfxqZMXoyG3BfuDNRke9susvkPn940HcRJGTC14Ih4ms9H3pU
         ZQFLWeh8LAZok7GlFi3UZjzZi9vTohFvGP1YTOfgt+DLtnd4GWZBPgyZEayU8x9DBAqI
         Gng8WlI8QKESKy3wCuLzweEk1OmCkW2O9QCBMshVHrfboVpxh//QuDHgD3R8xiZtEqls
         5lQUyCQhXLOIzzQ6LeHcFuWy42DpAf+SNM/rffQ/2+VfiNWvogVCpF8INtZQaX6LCS61
         OCy9a/9Hy1m3dD4fwCIStiwo9CLCFs+z3CJiuhYZ/Ry5K94NWoaJDrpNvfH7CPSMmrPf
         mT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s6mjtUcThghUsbwg6hgP26FqHa4HFNPgLRW+Curo8kk=;
        b=IcyQj1EkEBuufNrfOtfxb/te7C74kyymdW93Y123wJ0GCaTCts5ZTNYPlVgzzfcye7
         lIDm5CtMIgR1PfoAERZ/CWi9VAW3h5vIEvJnLgzPN4gEq3jKC+1A3sgOUvKZMtl2i3rV
         /WUD2d7P1CjKhdi84jobdIevNO8Uw27m50x+0adESv86HYLOlVhtfC5MocwiCCpeaQq2
         dt828IO89WZpQL5kgEMm/Ofr3tnMibgGnN9l42tpQK0y+Xt+Stkfk9i43gj+SzQYX86V
         M4d24ZTPfMnrgbTUhRv7K6znhFh1Mj6n2iv/GIPIl5FPCytJ9rPHOeQ7L6/c6oMdP23Q
         923g==
X-Gm-Message-State: AO0yUKVbLr7evLeqLDHgv5QDznChate9byiVXjPIT9nHCJP6pIrbRPoq
        Y7J7fyoNoCVAmjQapg76zYWcFQ==
X-Google-Smtp-Source: AK7set+NeqsVrowWMDfF6T6rZilc9ifIbSky8N5GLc+lr02wKKZPBRvW4HqMrMLra4qXGjfZz9tTCQ==
X-Received: by 2002:a05:600c:22d6:b0:3ed:e5db:52e1 with SMTP id 22-20020a05600c22d600b003ede5db52e1mr18969810wmg.15.1680190254456;
        Thu, 30 Mar 2023 08:30:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc? ([2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc])
        by smtp.googlemail.com with ESMTPSA id v15-20020a5d590f000000b002cfec8b7f89sm33266449wrd.77.2023.03.30.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:30:53 -0700 (PDT)
Message-ID: <ea42f3b2-ee4b-b13f-22fd-22066d75c408@linaro.org>
Date:   Thu, 30 Mar 2023 17:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/rockchip=3a_use=c2=a0de?=
 =?UTF-8?Q?vm=5freset=5fcontrol=5farray=5fget=5fexclusive=28=29?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, heiko@sntech.de,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202303241108553006227@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202303241108553006227@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/03/2023 04:08, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Switch devm_reset_control_array_get() to
> devm_reset_control_array_get_exclusive().
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

