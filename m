Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415A66F627B
	for <lists+linux-pm@lfdr.de>; Thu,  4 May 2023 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEDAt7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 May 2023 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDAt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2023 20:49:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8413598;
        Wed,  3 May 2023 17:49:34 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D22F66032D5;
        Thu,  4 May 2023 01:49:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161364;
        bh=4swttQsDPznqEELhw91uW6KmscZSLj6XothN9d4f7l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoSMsAe4WsgkM9g6C/53VENqhWK/84a5GdxZgwPj7xOC2jAkXzZtIKfpJ+dzUYQme
         kX+7U8hgIS73wmtr1JxAguxGhOAbgicvLGnH2raFBckLBgwL3Vcdxni753iIE6VEwd
         0d/umnA0gPY745qPTNJp9Dv+4q3J1X+RKaBFb6Gkwy4TTCAUMFjLmODUXiRUKtNMqq
         Cva3F7JEBvM9k2DSPjbuPU297ga+ju3rAypBoy0I5Br6aEkjGvjzu6MqKqCws+Swe1
         fMt6ls4vGlqM6C4je5sxHpRa/EAY8xz7uHB4m4zWY7ETOQ4e34sRlfLWdN2tHLNCUX
         dixUE7h6CYpQQ==
Date:   Wed, 3 May 2023 20:49:19 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: mediatek: Add LVTS thermal
 controller definition for mt8192
Message-ID: <f3626333-3a8a-4557-9743-c6e65874bf6a@notapiano>
References: <20230425133052.199767-1-bchihi@baylibre.com>
 <20230425133052.199767-3-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-3-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:49PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controller definition for MT8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: N�colas F. R. A. Prado <nfraprado@collabora.com>
