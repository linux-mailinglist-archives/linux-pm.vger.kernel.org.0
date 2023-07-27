Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0770576509F
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jul 2023 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjG0KLd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jul 2023 06:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjG0KLc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2023 06:11:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36897;
        Thu, 27 Jul 2023 03:11:31 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA056660702D;
        Thu, 27 Jul 2023 11:11:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690452690;
        bh=FyMX1Fm7JT1B1+S2v/xtvGbFc/F+jQacw+dZrBbBQzs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=n/bwER6jg3CkEOmqAapF2bzO1Zp/7N05FVt6SLMUrAM4LmU6PUPX6iU/b8vROvX55
         SXQqIMAXy3vvncho4zdJokepyG3ryPuOGgzZ+P52Tb5zzzVEN32WfM6EaT2cjmAM4Q
         VTcK/qSh/dX1B383PnaVVAysKTok6zyOuuSx2bSVZQ1uHtXr2E0cBUh4hWYOBAuFmt
         l/9JRP7ZWK+LNdT2QffWRvrT5uciVBuMxlF4ByCvXJ9NK5Uw7/cynv5/4QlvgGGHHa
         EwMZujxilUqerbZ7YK8XGIXUj1NZmdmMePkEFLJXlHt5U9KpR0RbDuLhFI3vJ1JRom
         eiYK7gnIUmurQ==
Message-ID: <4ccda73e-760d-243c-d02d-7b79ce7d4890@collabora.com>
Date:   Thu, 27 Jul 2023 12:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] power: supply: Remove redundant dev_err_probe()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, sre@kernel.org,
        matthias.bgg@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20230727082301.741821-1-ruanjinjie@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230727082301.741821-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 27/07/23 10:23, Ruan Jinjie ha scritto:
> There is no need to call the dev_err_probe() function directly to print
> a custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message
> in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

power: supply: Remove redundant dev_err_probe() for platform_get_irq_byname()

After clarifying the commit title,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


