Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBB5B56DA
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiILI5q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 04:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiILI5n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 04:57:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D503332AA0;
        Mon, 12 Sep 2022 01:57:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A93D26601DBA;
        Mon, 12 Sep 2022 09:57:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662973054;
        bh=eu03GnWzLNo4vRZEjVN/WGXkVC6p+WV2kak6Eu0LS+E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WNo73xHeEVBFGwmDeJNwVuN00mbscFqQEBjOxHBY/CgAlh64d8ZNiGDp/f2ZZy1H3
         S/uXQzKwwqd3w86LcJppIZ2Ll3mFph27nr86eq0AT5/BWAkUy25rl/bSmPEou+8O8d
         dXUtoR/ozky9zGS2aCjSFQvx0tqs8NVd84FiQpb/wzk2BkcTj3PuliKfWiUwFPlmrp
         1NFY2zpc//tKqQRQS6v3/4RHoS0czO6tzteioEOFWgpMcVrfkcD6RuEBV4/mMUQHb1
         V4v5meuarpUamOstu9kcpFT9Sm6zIIjlLHP3RYCkrI2HSQBZYSGp12GXoQFcYWnre4
         iT0DYRmxQIIzw==
Message-ID: <c397e8e7-3126-c1f9-8d0e-4b3181e5c5e0@collabora.com>
Date:   Mon, 12 Sep 2022 10:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH 06/10] thermal/drivers/tsens: use generic calibration
 routine for msm8976
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
 <20220910124701.4060321-7-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220910124701.4060321-7-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 10/09/22 14:46, Dmitry Baryshkov ha scritto:
> According to msm-3.10, msm8976 uses the same routine for processing
> calibration data as other platforms. Drop the msm8976-specific
> compute_intercept_slope_8976() and use compute_intercept_slope().
> 
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

As far as I remember, at least some MSM8976 versions don't have the slope
fuses populated and/or the values are bad. This is the reason why slopes
are hardcoded.

This commit would break support for MSM8976.
Cc'ing Marijn, as he should be able to re-test this.

Cheers,
Angelo
