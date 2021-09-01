Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECBE3FDE2B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbhIAPCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 11:02:02 -0400
Received: from m-r1.th.seeweb.it ([5.144.164.170]:48469 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhIAPCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 11:02:02 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 12D801FA14;
        Wed,  1 Sep 2021 17:01:04 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm630: Add missing a2noc qos
 clocks
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-4-shawn.guo@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <62712062-d639-a30f-92fe-de9bf8a272fe@somainline.org>
Date:   Wed, 1 Sep 2021 17:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210824043435.23190-4-shawn.guo@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 24/08/21 06:34, Shawn Guo ha scritto:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
