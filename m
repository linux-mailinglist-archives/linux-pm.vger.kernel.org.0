Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574393D10AB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbhGUNYw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 09:24:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36271 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239112AbhGUNYw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 09:24:52 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A23A5C0218;
        Wed, 21 Jul 2021 10:05:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Jul 2021 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=zYuA2M4rBawW8
        FUuNfU5GsMrh+ZCJMMT3FTCk0b+r4Q=; b=R/z/Ey1VHbswaV7KTUusVX1BLmK8p
        lzc6P2iuAzQfkFmhsI8+vtT65EUuxUmKqQIbSuYb2+djhCX/73YsOn56jbeDej9m
        vPAw4+lxpxf5/6yx33ywvBgWYjEfmICCFdU7Z4m3HK/Vv9otx7ekzEUDfPP8l5NI
        zIMeEQ0ejEur6gtom3fAzE9lRxX1TE7ylduc2AvEtDJhsSh+iyCsKF9UDeA467KL
        wFX6f0VxldD6qeObb504bFM+NLm4DlTwL9iYkDr1XG3yR7cmBh9sA9itgeWvdm4i
        OTv3LEuxoOnfRepX2JZBJwOSzCTDqKtXn1wiy77I8nf0n+euIn4r+N6yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=zYuA2M4rBawW8FUuNfU5GsMrh+ZCJMMT3FTCk0b+r4Q=; b=KOzbPF/b
        FJMvElaa6zMJOAOnXlJDJGdfvCUC0xbmCTgBZJh73niBm7oyK49CSw7gRKnXSk29
        mtITmlYUiZSkMU4J6j7AI+VL5MokrcitRtdNo5ful3uiQfhfraQdLUAoBjHBTvqM
        fAn1LDTWez4ELmKuWYb50poBDdj+56OWdrZC0jOJYp2LFsYL2XotpUf7TJRCvbru
        V4MUv15bysJTsXfLU1gXsBQe53XrVqqPSZycBdZf/2Kty1yn9ZDTNqkmoJ9UZ4lj
        YSp9DV/Juk54SW40rrPH5qIDZJ6Au4pr1w8ExQn+Eo6jDdKcgHs72DfLt4/kggPD
        ru/g95GVVP/4KA==
X-ME-Sender: <xms:pyn4YJW8fjKCPauzK7M3tMfHDHZffqx95Ob5TfmyuMbGWRJTHE81Bg>
    <xme:pyn4YJlFtrRETcu40bcqx1BfKs5QpOkzIEU3Gwg1MU3ETzsj8iwx5RCNHuWVz96C0
    rdD7kGTyvwX6PtMxEU>
X-ME-Received: <xmr:pyn4YFZwj4LEReeNuLT2gkWeT0ZRWGp_5NxCrt61X7NeeaBJCPY7cChqMnyhS7hxOuyrks5Bwyz77STWlFikV5ziMN5YAKaWw1KD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pyn4YMWEK95NqEuamtjl9BoN9nZZt86rjlZQiOCPQ_4tLV_HWgqddQ>
    <xmx:pyn4YDlKsCmLv3lRpyF8ymXnOdTDU0SCc8TaL3lNS3LLyyieB9RUKA>
    <xmx:pyn4YJdsMX7k03qyok-zzHhmGmvl5X5gHfmXIeFYMidk9cOTJyUh-w>
    <xmx:qCn4YF4a86NrlVEwzJ4ziJsDo-jUvpNt1T-mLacwMGY938LrkbBYgw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:05:27 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 29/54] dt-bindings: power: supply: axp20x-battery: Add AXP209 compatible
Date:   Wed, 21 Jul 2021 16:03:59 +0200
Message-Id: <20210721140424.725744-30-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721140424.725744-1-maxime@cerno.tech>
References: <20210721140424.725744-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AXP209 compatible was used in Device Trees and the driver, but it
was never documented.

Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index d1f0df123a5a..d055428ae39f 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     oneOf:
       - const: x-powers,axp202-battery-power-supply
+      - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
       - items:
           - const: x-powers,axp803-battery-power-supply
-- 
2.31.1

