Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7F3653F1F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Dec 2022 12:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiLVLhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Dec 2022 06:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiLVLhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Dec 2022 06:37:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E292828E16
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2022 03:37:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x11so2386326lfn.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Dec 2022 03:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3dFp/oI5Q5dQ5wwd/ulSr6dhNqL6ZqSNPqtr9kld8A=;
        b=Y+Eab9fFOqbuSpMMx9QaFXsViJH309/ale7ipzeUyetsoBLPSNm3BbbrGFKBXdDT/1
         Q8SH2+MEOAoGwVjM40B1iFPFSvDqablZBCL2vEH6tK0GacMdKICAmtrHrdZV5b1lMzUV
         ox/XX271TFp36fjcjjD7yrl/5wD+sU/pFzeQ0dOG2KcM0xoMb78yNS0EGOLcBQaOkTj3
         EyO+14jpPrYyI/RbjV2gg2OOTlBqbmp3GQQ/dqJMwshgqM4DmJWJwYFExYQ6dOKIXLG9
         Vx8JY6snphj8c5KyJGwvzXGpuFvAUGTnoTGHBVwcrPhauiyzvLw9VvU47jghvFh1edav
         B5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3dFp/oI5Q5dQ5wwd/ulSr6dhNqL6ZqSNPqtr9kld8A=;
        b=QuphySiwcWJLFCyA1lkIs1ucd8lkFtVsNayM50P4zJGF+h8GJJ9jGzhBSHjcxZMrUv
         Pi0jGYYk4TCxhkZIYm2j1yDRnU5t2zCoKZYNM33SsS41BXUeiLuYxeW9XFsw1eoCy53L
         Fzt6aGnaileHqmgVcEfefYQ9SSAR41IiRkqJkvwBkzruPvfqAHBtUNRjm6UhSwOJj3CV
         fGtLslJ2Pxlr6oQDp5DJz1d7tjiEsLq573z2wAnFnpye3nbTxp3Cae0CKHDcN8JyanQ/
         45cIisSCdPVAF6P3ShiMlfjxz14MYxC2audq54PHyvwPY4rUaY9+IjS2OnpDtuQLxy92
         ZqyA==
X-Gm-Message-State: AFqh2kpzsnBCjPQ3fK7+1cF4cUIHVFoVQCdBfPcriKT7m+50VJ9urKpZ
        XLFRhm3Ed779/sYA42srhPtN3A==
X-Google-Smtp-Source: AMrXdXu5ipMG9KfK2kHMM5bFqFrJnWNtPxPN+7XKps3+Y9S/13kRFXNoin/6IB1zH/viyyNJ3MbNfQ==
X-Received: by 2002:a05:6512:1115:b0:4aa:e120:b431 with SMTP id l21-20020a056512111500b004aae120b431mr1829201lfg.38.1671709056308;
        Thu, 22 Dec 2022 03:37:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t17-20020ac243b1000000b004ac088fdfd2sm44242lfl.85.2022.12.22.03.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:37:35 -0800 (PST)
Message-ID: <db223161-a424-c4cf-09a8-ff2241fda71a@linaro.org>
Date:   Thu, 22 Dec 2022 12:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 09/10] memory: tegra: get number of enabled mc channels
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-10-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-10-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/12/2022 17:02, Sumit Gupta wrote:
> Get number of MC channels which are actually enabled
> in current boot configuration.

Why? You don't do anything with it. Commit msg should give the reason of
changes.


Best regards,
Krzysztof

