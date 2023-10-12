Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDC7C6A44
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjJLKAj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjJLKAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 06:00:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FF1FC3;
        Thu, 12 Oct 2023 02:59:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B074D66071A3;
        Thu, 12 Oct 2023 10:59:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697104762;
        bh=Bjtc2IsHhuNt1R9b4VeTXHrfdrv6Dwk49Ui3yKy7CX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NJvCwHq5v6ZRLfDRGRVl6L/Lyd2gwKhmmZAPCo0bBG3MiysD2JsYrIkOTb0zm/2Ja
         95zDBXT9P74qkJC+o51Jn9NpaFMKex5lXG7u1Z9I0DplMRDJnkvDHuzdbKvcMO3f9X
         A2BFWurGuVon3SmRKtHLM3DhEFmt4wRlfc6nW68aXHHHB8LSpX84wUgjck/amfDkCu
         Nd+5hFxevcrhbDCqg8tfx5z2C7cUY+rnlKC6OgkV4i/FlLytFw1E5dUbm2vvGhppB+
         iPfdPSgO7v1PVuD8Bfx8Lw+U3KQ96Ddjt3N2YLKy/q4U2Ceknxxh3DdgsVY0g41L5k
         Nqq6lwM4FaC0w==
Message-ID: <924236b6-23ba-1767-5d18-4e306db35d3a@collabora.com>
Date:   Thu, 12 Oct 2023 11:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] PM / devfreq: mediatek: unlock on error in
 mtk_ccifreq_target()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Mark Tseng <chun-jen.tseng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
References: <1bada9b2-d276-4123-bfdf-03d165569543@moroto.mountain>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1bada9b2-d276-4123-bfdf-03d165569543@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 12/10/23 11:41, Dan Carpenter ha scritto:
> Call mutex_unlock(&drv->reg_lock) before returning the error code.
> 
> Fixes: d2805601988f ("PM / devfreq: mediatek: protect oop in critical session")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

