Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC243D10B0
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhGUNZC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 09:25:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42585 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239121AbhGUNY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 09:24:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3AAE558046C;
        Wed, 21 Jul 2021 10:05:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Jul 2021 10:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Uq8dukZV0FjfW
        wNFgyBbCaCvYElCG1N0o/DPMIuV7dc=; b=tiVNMJMBQn/YyRtI+o+265pG1Q2ge
        L1RlIprX0W+boGYM7O/JPajFwni1v3YeCYxAGNRPXbLJqvr/38IsgCEj1acreHJ1
        eQPt1Zwqqzs2w5br+EW+IHDjId0hJLGWm+PwYWQbplTWZl3EkrungG1WX/v/Dz/+
        u4YIBhehlalULWiwMbUmwxhfajkNPy+4fNRo4Zz9ZpVPRKqxfopAH2CoWAn5jRWX
        biCdVvqEI60y4wXVf3rdm2pHM2ief2Ro1QVoXXf//wFZdnS3Rv2DLdkEXeel2p59
        wd/vyYOUbpTS0jkaDiCuFUktwvB5H+RYIUJDdrtOFlUEUJoIzygwUpq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Uq8dukZV0FjfWwNFgyBbCaCvYElCG1N0o/DPMIuV7dc=; b=k395fBlP
        QQcrTDQ762bdF6QdyyrkPN7yrn36MNfXRlQbRcs3P9JtgQAKJhx1y8iWb30xaJ+Q
        p0JhFP63+ZsFKHPnx8OW3vvwVkOcjg+Tp7ePFPXdMqLOtNLeoMye47vaI2pn6rUQ
        F0SEz4MeCVCnjf2oJjqXo6z5Iw95TagsLgxtlXHxNvsU3rrK7OpoHVPfF7kjr5lz
        vKWlkiBilZG7jtv8y/fhj3dhL48N6aVFoRJ4yLs+OnqxuCOyafJQZ5O/t6rvzBTR
        5YbMlOipaAPv1rM8OdU3TeIBSi9zYsKqQ+aBwtsKiYA0ILuetBUHmHqVVNh4IOQF
        xfb863OMI3UsVw==
X-ME-Sender: <xms:ryn4YKP8kN3CPdm2wYElY7fCVHW6nrbVYvrmPAscEDmmCYxu3QNTiw>
    <xme:ryn4YI8f8CEqc-mlBNbFV_e07UL1qeWmfqVfzRVKENddSv096fHf0ue1bzaTVnP2b
    _22Me0i2s9lNKYOldU>
X-ME-Received: <xmr:ryn4YBRCzEBLw1SRUJVhgBK3p2op000Vv1lGR-RwRUOff-ZszmkyODYITmJkoXJLSk3h3NpDeTs34c-MF5VnQc35UknQ9QipGYRX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpedvkeelveefffekjefhffeuleetleefudeifeehuddugffghffhffehveevheeh
    vdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ryn4YKuGqaHsjR5Sk_JaZUWkk2h3vDLvQ_s5aGmRZy1EzpzLUBc1Ow>
    <xmx:ryn4YCe9E9AdYuwsml3_KED1hu2EyVjHC0InJ8v2vpLPsFhjvHn5_Q>
    <xmx:ryn4YO0vMwd_k7O2oGBZ7Cn0EZzAz2RBBuygzm_yQnx7UK-u1Ee4Ag>
    <xmx:sCn4YDXnj-JN9FVhfa2Q_UMFTzWmrmkYIcxn3pk0gah1Li7EMDpM6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jul 2021 10:05:35 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 33/54] dt-bindings: thermal: Make trips node optional
Date:   Wed, 21 Jul 2021 16:04:03 +0200
Message-Id: <20210721140424.725744-34-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721140424.725744-1-maxime@cerno.tech>
References: <20210721140424.725744-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Even though the previous binding made it a required child node, the
implementation in Linux never made it mandatory and just ignored thermal
zones without trip points.

This was even effectively encouraged, since the thermal core wouldn't
allow a thermal sensor to probe without a thermal zone.

In the case where you had a thermal device that had multiple sensors but
with enough knowledge to provide trip points for only a few of them,
this meant that the only way to make that driver probe was to provide a
thermal zone without the trips node required by the binding.

This obviously led to a fair number of device trees doing exactly that,
making the initial binding requirement ineffective.

Let's make it clear by dropping that requirement.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 164f71598c59..a07de5ed0ca6 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -215,7 +215,7 @@ patternProperties:
       - polling-delay
       - polling-delay-passive
       - thermal-sensors
-      - trips
+
     additionalProperties: false
 
 additionalProperties: false
-- 
2.31.1

