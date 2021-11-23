Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1345A091
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhKWKnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:43:55 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51317 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235763AbhKWKno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:43:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 374825806F5;
        Tue, 23 Nov 2021 05:40:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Nov 2021 05:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        Aw7iT/6kjCk4adthVZ5Jj9aBnaB16c1yy2Up9qTRJW0=; b=BC8Mb4Uz+oUn/yuC
        n0leNskVfQ3Va5ziqA0NDLkeSJMETYY8uv9o8N+DF3bBXEuzg+J7PVZKXRr9fHC1
        cmsFwhJL7kyY5xPwmRSDmEh1o2gbXLGGB9SkJs74wBucIk1ATZ7p/ej2Q4Q1Gq48
        dGCud+6q5dpHXO9OUio48D7cGsXEcfQVMHMVPhNuBjMB9ti2WZh8KlU3VqKm6m2U
        3IuAWIJMxZQ/KgK+vm2DL4U1V34Pl1pSBiJi1NL8U6vKzy8kqVwvpUh+8SPFNeNH
        uT7oprR01+mmxeI9/D5OHKWnzgSApxypx10zLTZ00B0Del6WCam/4NiuLcm1UG/3
        HS/Trw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Aw7iT/6kjCk4adthVZ5Jj9aBnaB16c1yy2Up9qTRJ
        W0=; b=Adi8fRRn9vN7FZTLi23krvhT8WA0NLorQ/8faOguPNf9pymDUMFBcjLwO
        LyBrx27+oicXzoN3jo9xU2SnIdYEAznPNFuS2Nr1rTyGgsiyiULBwfQ75bJ0Hmwd
        FUQYb15rp3cmerA1F2uzdiBU9eiZEfTAusNtFwcNqw3cj8vXcJTvbtUbMsrBt9nn
        fh1GsR9f1EG3EjC1JhnBosfPgHy134INdyk+yfkdeZa3eWQ79j39ETxVIxoEcegs
        bWWt1zrZqOzTTgGyta50n0h6kHRB9Q7X3HJdX9lXK0wFsEFngoDvIDU45U7RiWkY
        0h7zhmDM0bfYexcC8l/MsGj8yoVdg==
X-ME-Sender: <xms:JMWcYayLpIY1lvqRUOiBXR0LS0j35bZ6oWKy2X_fx7_Zp2cNBBeHuw>
    <xme:JMWcYWQcElzM0ChMrGeQ3oJFcXfCTFwhoYNtMdYbsT0ZDY7gef7qZZtviP8sB6L84
    ZPsE34AsgqFRRuwPlg>
X-ME-Received: <xmr:JMWcYcVGyFQ5qy9d05SmEQN31ehdQoFv0hwP65QV9JWMe-irIiJS5l_x843__Ad270OhQpFU7zU9nfuFumRUStE5gC-ZLc9kYmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JMWcYQiMWmG29lvDQAjLIWVR-QS1FTnWnrs2yf28MGLMxvcMjUqjwg>
    <xmx:JMWcYcCTABFMuW8wg8bc1eRQ_JnpH5_EfIlrM1KpxnplMNw6wQDxtA>
    <xmx:JMWcYRIF5PdvRBXITNTCyTJZOohdf_vRkKfay_GaoZ_08RLFV_QTBg>
    <xmx:JMWcYQy2_R2xK9WXYkO-FT6ZVn3XSAUhZWvCV_K539nuT-KSASPCCQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:40:35 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 3/6] dt-bindings: arm: sunxi: Add H5 MBUS compatible
Date:   Tue, 23 Nov 2021 11:40:26 +0100
Message-Id: <163766402024.90163.3209718802910434311.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118031841.42315-4-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:38 -0600, Samuel Holland wrote:
> The H5 SoC has a MBUS very similar to the H3 SoC, but it has a smaller
> MDFS divider range (1-4 instead of 1-16). Add a separate compatible for
> this variant.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
