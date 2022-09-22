Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737F5E5C54
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 09:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIVHZQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 03:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIVHZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 03:25:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BB5D0F1
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 00:25:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29EB96601A43;
        Thu, 22 Sep 2022 08:25:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663831510;
        bh=KWphtaFojHC1LO0kVmsxuJ57Y28jan/tm0HeYuklWDE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MV/qHivnH6SHgT2+yfCnLT+HI3kYQMDRRfyUQAXm/Bq2woN6g3mIKo4FBd1vsjmVc
         D4bB9ZzHUp89cCQilxkA7fU8v/lYvQpFH424iOziuOYlFp4qFponusugn8raUhrCyl
         38FHuM/egLkUiuM0QglIbgIEYIIDhzXiYJ0sIrnXbH6TrjqZqeIcvkW1ygTRH4C1Uj
         ioOvGqbz9LeOz9iJJHbK2HJvfT01ZRwm14QVQj+nazOsJJeu28qTf1X4Sh9I3Xil//
         J4BK0V0Oji6YpLXoxtttI/jT+Pv7C/YsG1nWVmiLyFCoQ18E2IWXzJIeo3bF31ie7K
         1NS85lFoXjdvQ==
Message-ID: <eb797605-0310-1c8b-28ae-eabc17901e65@collabora.com>
Date:   Thu, 22 Sep 2022 09:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] power: supply: mt6370: Fix return value check in
 mt6370_chg_probe()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     sre@kernel.org, chiaen_wu@richtek.com
References: <20220921152915.1506767-1-yangyingliang@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220921152915.1506767-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 21/09/22 17:29, Yang Yingliang ha scritto:
> If create_singlethread_workqueue() fails, it returns a null pointer,
> replace IS_ERR() check with NULL pointer check.
> 
> Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


