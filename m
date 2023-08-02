Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1677076CA4D
	for <lists+linux-pm@lfdr.de>; Wed,  2 Aug 2023 12:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHBKET (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Aug 2023 06:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjHBKED (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2023 06:04:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC34698
        for <linux-pm@vger.kernel.org>; Wed,  2 Aug 2023 03:03:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F30F6607185;
        Wed,  2 Aug 2023 11:03:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690970581;
        bh=QNUoS1nkaqDteBmKu4yeaJCyte/W4BgCT/xXj6oe8+o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TgGj95aKjuqRnIkJVqPQSWhr/2CpazGKqCOROs2+oVooR+e0TBfKwBsKarzLtiwbZ
         r/OQSVMbUT05fa4vzoNhxAZL5ayuCM1aB0yyAAg7OE7czHHeCxGllAPzkhZ1IPWVUS
         yRQn9z8zbYryoKWHN5k+tgONyR2bOSgrJQgVGsRwNtefJ5X05La2JajAzt7nWR/z/C
         aIZpKYdfj3CKjTHjCNlhQH/GGJ+YAGbMVIfb6UQ9uJ2Ws5BN0YIUCvBBClmQaazmOi
         9Vc5cMFqMqFcy9tmsxsd1dbmBd9W0lsYid0D8Lxk8LBhJe6HEbjZElZy7gEjugRqet
         GoHttZIOV4CHg==
Message-ID: <8c0db188-bc71-a5b6-956b-02d451dfa854@collabora.com>
Date:   Wed, 2 Aug 2023 12:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] thermal: Clean up redundant dev_err_probe()
Content-Language: en-US
To:     Chen Jiahao <chenjiahao16@huawei.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, bchihi@baylibre.com, wenst@chromium.org,
        robh@kernel.org, frank.li@vivo.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230802094527.988842-1-chenjiahao16@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230802094527.988842-1-chenjiahao16@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 02/08/23 11:45, Chen Jiahao ha scritto:
> Referring to platform_get_irq()'s definition, the return value has
> already been checked if ret < 0, and printed via dev_err_probe().
> Calling dev_err_probe() one more time outside platform_get_irq()
> is obviously redundant.
> 
> Removing dev_err_probe() outside platform_get_irq() to clean up
> above problem.
> 
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


