Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CF65B1EE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jan 2023 13:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjABMUw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Jan 2023 07:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjABMUr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2023 07:20:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3F97;
        Mon,  2 Jan 2023 04:20:46 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 173146600366;
        Mon,  2 Jan 2023 12:20:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672662044;
        bh=sVHyMpKuf0CmXqLe4Cs8pBqtliKrHaOFfObz3d6mKJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RhA8nsDFkoKGuknyMlxYDpX324rpUU89peNMM6QGIr56iPHab5m310cfHDXCermZG
         vYBfgRNaAxexyuAf6boCPJBT7t4llWYiIRVELxvqS8XEbb2o5KIVfAtB5MDGJKZFT4
         9h+cAzoXizShWSoz9QpVUordqehmnlVTVi/1dA62VsGZtA19DbZllj7UpYrSTLzt9Z
         xXxrQTnXALS74JDBYMsiYZitR2jIIT9EMtYQ/W/dDh4vkHkbYsIwQG+rsQ+LiUosZk
         I39SB6JdkfMSVOv/53Lj5Oa/2YN2jI7LM/k6WdGCGeERWrw/MLVxKluYyye0hp6uaC
         8e9zTklV5f2CQ==
Message-ID: <404fa369-471b-6ff5-e137-1bf1a2023fcd@collabora.com>
Date:   Mon, 2 Jan 2023 13:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 14/20] thermal/drivers/tsens: Drop single-cell code for
 msm8976/msm8956
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <20230101194034.831222-15-dmitry.baryshkov@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230101194034.831222-15-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 01/01/23 20:40, Dmitry Baryshkov ha scritto:
> There is no dtsi file for msm8976 in the kernel sources. Drop the
> compatibility with unofficial dtsi and remove support for handling the
> single-cell calibration data on msm8976.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


