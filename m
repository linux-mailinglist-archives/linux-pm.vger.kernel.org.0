Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7332168EF8E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 14:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBHNMR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 08:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBHNMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 08:12:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFE460AF;
        Wed,  8 Feb 2023 05:12:14 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 670BB660209D;
        Wed,  8 Feb 2023 13:12:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675861933;
        bh=UOCZJc3cdFQz7WthuBqxrwG8dtBB60ZKl7NVR8Pqvfo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kyU+9mQdEod0ItgZqYe2WGyoUkGROJ+uKVETSfQgPaNxgTuPD9jNVuf+b/4DU+Xbg
         isKqJj80vNFveMnyV74RA48dg2zUazykij7yww34rdUwhpTwvuboAzhVdUEaPHa8HM
         K+se12Gcx4BL5Pebq6kHLh+hBvacCeGvLfnfXZ4hNEk442X/gFWBeLK+nw8Re/PliP
         /ncMNzw7q9IlUQrFaWIYlrg+3lp8d54W8XbwIDI+ZEo8myUvxDTcIqq8Tt9n0OrcG7
         1sXaFrD0dy1RHdbgcj8M6bGGAwUJYRhXg9WYCkxSkEKF21c9o/xxxh42ON70sHnkVe
         9kO9odKEySRkQ==
Message-ID: <3b421ab5-9b97-4f50-f65e-471a6d09f568@collabora.com>
Date:   Wed, 8 Feb 2023 14:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] cpufreq: Make cpufreq_unregister_driver() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        iresh Kumar <viresh.kumar@linaro.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
References: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 07/02/23 20:59, Uwe Kleine-König ha scritto:
> All but a few drivers ignore the return value of
> cpufreq_unregister_driver(). Those few that don't only call it after
> cpufreq_register_driver() succeeded, in which case the call doesn't
> fail.
> 
> Make the function return no value and add a WARN_ON for the case that
> the function is called in an invalid situation (i.e. without a previous
> successful call to cpufreq_register_driver()).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

For MTK and generic part:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


