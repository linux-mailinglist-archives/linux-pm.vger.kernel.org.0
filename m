Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2175B56BC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiILIwm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiILIwl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 04:52:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CA2AE28;
        Mon, 12 Sep 2022 01:52:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BB0C6601D9A;
        Mon, 12 Sep 2022 09:52:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662972758;
        bh=7f8rv5NrDbI8FzOJIfOFLtaF6m6zncvjLeOxNvrNntY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q4m95uyrF2e5NQf3rgUNndX1tSWmGtbnIfqaD7/3Dnkw9R3I9OBHTiT6frONenwqK
         CM0OJu2Idh9ftssB+g6yY0gX8NakpR3r/tt2HINd3QjsZm3XHYgd1aShlmkE1RRQT2
         Ckfy+HXGYpalVO+apg7X1iBvdVGkk4XTZ1FPuQ8ypW4FYNOhL1CDLg20AaNp83yMJa
         NyDZzmMGWI8VRMyTwFsjww/hyKe14mFzgHjZDrcUTeXAd1VW+f8srUWOGLmtaY1jxE
         60boN+crRAl3ezHnThu6NlIpC4BkFF1RHtRjrq0yqJHmTEhoHDaxPsu5lno13Uxbbd
         Y6jGvMRLwSqzQ==
Message-ID: <4a4f2ea4-eb90-14ce-267d-89cc3034feeb@collabora.com>
Date:   Mon, 12 Sep 2022 10:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH 05/10] thermal/drivers/tsens: drop msm8976-specific
 defines
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
        devicetree@vger.kernel.org
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
 <20220910124701.4060321-6-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220910124701.4060321-6-dmitry.baryshkov@linaro.org>
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
> Drop msm8976-specific defines, which duplicate generic ones.
> 
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

The duplication is useless indeed... However, should you add a Fixes tag here?

0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")

Anyway, for the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
