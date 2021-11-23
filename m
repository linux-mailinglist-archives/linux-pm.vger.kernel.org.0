Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F248145A089
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbhKWKnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:43:50 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37795 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235743AbhKWKnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:43:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D5D3E5806F4;
        Tue, 23 Nov 2021 05:40:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Nov 2021 05:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        miDrV82J0ZsN0PQaRMwRlbgH8WiXcgAP1TpGLhAS3pg=; b=OTfa0K0azWXXhJFW
        tmK/EtGED+HqhMEeAWNQluEOBFVRvyrFllTpQLPFIB4pTxbxwVSYwU88nlHf4eZi
        TgxopEddekq8fWNkI1DPQ0yK2LEGv1v6AwtqQnOZa59z6M+reJTBzR5GQeCaXQk6
        +nRnx0aSC3eAjSzQE6R7j4rkeMR0TDJw2Ne3vydXBtTCm0W71On24loYvfMCYK0q
        cJzi5O/Zm24V2h8pxLJri0jQC6hjms8lGfmo5UKoa9IwZDZ3IimAVvpr4IreV4zd
        IeYaJPfajwHFgxzjWgQIYDs1pYbgPa+TJjipKL0hanhPG7l8fsjmcgjaZqXP+KcE
        vBaXgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=miDrV82J0ZsN0PQaRMwRlbgH8WiXcgAP1TpGLhAS3
        pg=; b=mLx//qyfCZ2AETQRAQMHa7XOQe8419W2rz6Qeqjv1KODTYhdIIY4YmFGq
        0l03/rvFo6+0kJFAKmYP31g3LAsvogRpdPEONT01eMhk1MrasP2l875rQhSLi1hf
        VoXXNaJvPCi/+fGWAFLB4s8fo4SEm21JPiWuVTK3NG6SlXCzYOf30Kl4rf0JOWnL
        z5UWcIk9lDxsbupfCNqo+joFF12kTMeSHhmckPYdorgAS1mKYsDXWGjCwoYEjsME
        zTUw9/MYDiBuE1c6nLZ261879LUdjN1DNGzUf2YKvaADdFC7zx0gpmdsmgZKMwli
        kGOKIQ6uyAqQiTMLf6sUm0srEoKBg==
X-ME-Sender: <xms:H8WcYTQekQs51UCPQsW8Dc8xBvCuwy6LF92qQf24pnM-HMaoM1ID-Q>
    <xme:H8WcYUyw0oVce9d7cU4D5rWozUGBkFNPYBfmVRxmDb7ze-uXl9CBVVzftg8-IuI4H
    XhzyB75rfH1UmabZKg>
X-ME-Received: <xmr:H8WcYY2wiarXNtoU-GrnzZlNeLTL4XPYlj_WgNRJ3ZYp5RLhf8zLMNu4fMchh7TKp6hCXyTuG-eXF3iim4zj_IRGK89B-cMDdHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:H8WcYTBGHp6RL0ItdpFNIOkyB-JtiBaDKgcKuosya3JOFg3-_Q_PMA>
    <xmx:H8WcYcjGdhYkRPkzmXUuvrUhgvWKFslXIX22Fx0pevc0y6PTEEZssw>
    <xmx:H8WcYXrvcHhcqXED5qGBwooirw7yzQDB4bsGNtiYwACvUEzx0blyaQ>
    <xmx:H8WcYbRkiKFow8Yrz5Obj0j4reTWMuRYZLWLCXZ8_x8MlO093CTGfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:40:30 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/6] dt-bindings: clock: sunxi: Export CLK_DRAM for devfreq
Date:   Tue, 23 Nov 2021 11:40:24 +0100
Message-Id: <163766402024.90163.1862786187476595781.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118031841.42315-2-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:36 -0600, Samuel Holland wrote:
> The MBUS node needs to reference the CLK_DRAM clock, as the MBUS
> hardware implements memory dynamic frequency scaling using this clock.
> 
> Export this clock for SoCs which will be getting a devfreq driver.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
