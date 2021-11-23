Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C613845A08B
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhKWKnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:43:53 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57021 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235695AbhKWKnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:43:46 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0D4745806FA;
        Tue, 23 Nov 2021 05:40:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Nov 2021 05:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        ri9AxKMZ0qsSmuA/72NVGfg6k7O8jXADPBV862L6vd8=; b=ZpnmTtpG0YAypvaX
        tUK6fB6LjzI3jmKVdiG/kC2wXMijEUG6XeHYkAMhVhjsDU+qOCjFVzyWrse6SDid
        37AROHbjrMybSQ0H5Xt3emfI6pEO8jXCTLz7he6OAOA8l2GUCIq8+1DhVc8H0ohu
        VVmLCITUAOVOXO7OMrYfJquiAp080PttZNBoa6U8lSdCgpij12+OXGaIfVaOkKm7
        F8rnmYmpsdntHHRrRdhXdTLugayEwPEQ3HhV3ttg/r0nTMtq+kWzYYOChF+qhDn7
        HRqD2TgSpgrjF75oUk4i+64VvM1MIvw5oKPNlmspd4M/Rie2z/3rbZoH5CfbtCbg
        xmNMhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ri9AxKMZ0qsSmuA/72NVGfg6k7O8jXADPBV862L6v
        d8=; b=DaB9u8NnexGyi2U3oprxXFLJVAOZ/rbkE0uNtKcNCOPh5nCZLtOipDWE+
        sD5GZdXdY8TL1FKfjpp8xGWg3PC62Kuy0MHmYP4UH6ygqPj3rb9uQ604BDhQSGeJ
        30Fz/gRMBTXetYSwBvzTSAo4jPkyjZYReXbnicck4bnbBSFQA4XmJGckRcIaSyP1
        Zy3PeV8eKlAL+Rpl6/Ed8M06ezZoIBC1oneqVHTi9jseb1jZ+rkID6hVAxP7SciD
        rXVVdB0X466nVnSW2CXL7xmWaS2MNcVagFrHIJRfIv34iK5wTIiDXrO+4t73jl1d
        IgQMuRB9CIIxy4vpmsCf0DdjKV7kQ==
X-ME-Sender: <xms:JcWcYYiJldPBL3bBFGPtPkh22i21ZaMYLVbbsoYdNRQpv2SlfuG46Q>
    <xme:JcWcYRDbkXE22lDX58fUlNaN1J15x70Z8PvpG36AE-nh8yl5ZCSJz5ZY4CiZlKS5u
    K_iqgRhK20k1oLQrk8>
X-ME-Received: <xmr:JcWcYQH-CjApkAlO31wSMWgAXFWxRo3IRos-LrIY0-_asHwrC0ffkooQQ5qbAWCb2cqQSbGeStKgqdqb0wQk8cWiT8kOWJy0cfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JcWcYZR4sqA5Be3-xtZiIN5q2-_FiF4j79nLGQN15T-f9ZvIQ-C20A>
    <xmx:JcWcYVwTBoEBdPgkmk7Fw2enS8lGnl5AzdgxAFNy57t0pWoF3ywYGg>
    <xmx:JcWcYX6CsYYnp_z0OhIElDlmtYVG4L-HRZBGcNxIYPMFCCHCjCcOMg>
    <xmx:JsWcYYr4sqpbKykUJkn_aVDfGUCtl_e4kQ_0GO5QCXO7qJ4bN9d9MQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:40:37 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 4/6] ARM: dts: sunxi: h3/h5: Update MBUS node
Date:   Tue, 23 Nov 2021 11:40:27 +0100
Message-Id: <163766402024.90163.15927162800323071725.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118031841.42315-5-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:39 -0600, Samuel Holland wrote:
> In order to support memory dynamic frequency scaling (MDFS), the MBUS
> binding now requires enumerating more resources. Provide them in the
> device tree.
> 
> Since the H3 and H5 have different clock divider limits, they need
> separate compatibles.
> 
> [...]

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
