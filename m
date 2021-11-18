Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09D455354
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 04:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhKRDVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 22:21:48 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42353 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242262AbhKRDVq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 22:21:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 75DDF5808B0;
        Wed, 17 Nov 2021 22:18:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 17 Nov 2021 22:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=yFFSo5uv49zxa
        5hC88M515gyJ/oG+1Jk6SsXGi9oHhg=; b=V5zf08xr2j0HiqV05V2U6Q7kDmZ6W
        BVa7KxSeTquZIE8jhkMHtjYG+W/5860vu7yZ1VP5OaIdDhxaa8qEjcLYoN+YfblA
        lvyr1ZKA2I/LxiSVpuBGXjPWb/ukxt7TAkkmARNGaTACc1oL0c1CqKmELhKLsGwR
        8yp3WA1Dn6lKUCuu1FKV+m2MY6DF5ID/Ac9zQEyHxhSyly6bNoFehIV78uBXpg79
        nAVWMmfcHKvGYmR+I7DXgIxP8tD+IJ9rrzy4iVBGxBPVblVVNT/Ew63c6K3tSDIz
        Zcz5rY5IBloPxr94lCw6H+rJZ4T7qhje30hempsolSuqs9+5rn2HTCqoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=yFFSo5uv49zxa5hC88M515gyJ/oG+1Jk6SsXGi9oHhg=; b=VmOBWnXY
        8O07HYQ5r3V6SkJEsF8XXbfq3NPLBvBO8pzDAJZG/X9FZJTILFagPxydwt4PlxeI
        /SeVvcmReLkGCVdmTl7U1WE1s4nimqkiT8fKVQmlR2vwxKTueUnCwQOhsYu4LeCz
        sSgRqrCKuaeZdd3D+pNx/R7GcYdZuR4Cmi/vtSMnHbdGfZrjSQ4OzyCwz3yvrsu/
        OUEfaGxPjvwEC6PTTBMa3dPZ1yV8J2waj0dBx8SJUncCgljZkEvKUgRJtJghg9uG
        NcHOTdiMVeYMZDn0wXUN7ifPHKwWuNyI54dN4EDhnDA3KiOVWmFF7X3qBrkGAruf
        8SynCWHHcqfVug==
X-ME-Sender: <xms:FsaVYXdP3tVxvZLSRqtUQvUOwirALhdEPqjuQxbYWohMdXIzUTMXng>
    <xme:FsaVYdPbtoZwhW3M7sIH0DnuW-XEkeW9VfYMXtUcdGdAa0w7MmSNfLd4sxxKR05mD
    aPUgPqM0d1qWunW6A>
X-ME-Received: <xmr:FsaVYQiDPz36v7i1xdM-Q-HNFpN7dwxuWaN_p_QdBUi5GxPd7-MJjTlgjcYzmlKZXqUB1UcSIFqHxwAzlXw5GAlprkOMZWju39-4bHD4u3OfJG0NUUAwczDpPWs1JkcbDz9MCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:FsaVYY9mBySY_AjWfzerO-LuNqt02n4q3QcJIVh8KVEfSEnvsIwyew>
    <xmx:FsaVYTvpYscfxoq0XbhffoPGEop9qYOizth3_Ymek-aw0zuykkCqMw>
    <xmx:FsaVYXHs8m9xK-wj_J44gOpf0zpIQaAY2hXgypT7I7bi9AxqX4dj1Q>
    <xmx:FsaVYcHyJfWfCZ_eqvTj8m_LHn1Rj8tyDxpAfXotX7Rr3QXl8OeZvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 22:18:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/6] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Date:   Wed, 17 Nov 2021 21:18:38 -0600
Message-Id: <20211118031841.42315-4-samuel@sholland.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118031841.42315-1-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The H5 SoC has a MBUS very similar to the H3 SoC, but it has a smaller
MDFS divider range (1-4 instead of 1-16). Add a separate compatible for
this variant.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
index 2b3829e0e240..8eee312c2e6f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
@@ -32,6 +32,7 @@ properties:
       - allwinner,sun8i-h3-mbus
       - allwinner,sun8i-r40-mbus
       - allwinner,sun50i-a64-mbus
+      - allwinner,sun50i-h5-mbus
 
   reg:
     minItems: 1
@@ -86,6 +87,7 @@ if:
         enum:
           - allwinner,sun8i-h3-mbus
           - allwinner,sun50i-a64-mbus
+          - allwinner,sun50i-h5-mbus
 
 then:
   properties:
-- 
2.32.0

