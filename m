Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03A77E1BD6
	for <lists+linux-pm@lfdr.de>; Mon,  6 Nov 2023 09:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjKFIVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Nov 2023 03:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjKFIVP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Nov 2023 03:21:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DEDB
        for <linux-pm@vger.kernel.org>; Mon,  6 Nov 2023 00:21:11 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6AF896607469;
        Mon,  6 Nov 2023 08:21:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699258870;
        bh=pH0YqoYXSZbJwEO/FU3bp+HIJXl6iyffWk+F6C0as+8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AYpqNG2eeNJsLSMOaL6f8lBWsSgDAbaNwT+nwBAEnTuP1kwB+J4GalxPoaZTgdQHs
         +5ImCCjYc+mymB2IcvBU2o+7lzVqunk3shwQ1/WvBvVunVGJQKM0QzzMS+SHYAoMKu
         47zKLcjxwzoqB5I8VbGZtqCApMaHMsiT+kXraoBo8GBI1+ZC1r07rlWB36s5rB37GZ
         Ej8Rlw3MjzdGgQWp3F3Bu1Sp3lxV5dobdy5vsMciMVoA2N2Gg0cK7kubErfoXlf0aL
         cETtjb/JZ/6NHOeWKSmAp3g+PNyfdK56gCOUkw7zhLOJJ/S9pBY8Vmd4ag36akeyd7
         CDEE2jTJlAYcQ==
Message-ID: <a8bc5404-1b49-429f-b695-5b63c25a1157@collabora.com>
Date:   Mon, 6 Nov 2023 09:21:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] power: reset: mt6323-poweroff: Convert to platform
 remove callback returning void
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
 <20231104211501.3676352-24-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231104211501.3676352-24-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 04/11/23 22:15, Uwe Kleine-König ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

