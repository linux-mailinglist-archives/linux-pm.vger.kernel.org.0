Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E042845A088
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhKWKnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:43:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:49331 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235659AbhKWKnm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:43:42 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 48E895806F6;
        Tue, 23 Nov 2021 05:40:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 23 Nov 2021 05:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        N0GeWv+SSVyFI2Bbd04l94VO8Ipl0GCHG/xeEKBGPgM=; b=BMTLatmWogetZIwJ
        WcMqDFIMna77Nt+476GW9ovXzie2hyuWCpKuM9KHM1yl24EwNCyBkyJFh5wS0NUt
        WweB4lfLfdJW4mLoNM5DkO5Atiip22q88B6Mg3E35RUbAk0VzdO4XYHroAA6tGAC
        tJmmyglTFV5KZ7YaGN+fr1JVjXzMMpjswyvvxnw4M4EOlocrfCVnxJWQjOOAkp8x
        oWQiziZ7Rrcfe/IXtUHT0pfL6re2yvJGU1CJgY25p2dGME+RH5jjgqzqxTtPex1X
        fFZn+BcOkSRoNS4/u6n3DQ/2v5lkqBjCne8NX+ASUXziDqHOo81UhPc/KEfa/0Jh
        c9BiaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=N0GeWv+SSVyFI2Bbd04l94VO8Ipl0GCHG/xeEKBGP
        gM=; b=FxECt8tSbZaI4qLu3s+aeCpGttIXz46LA1HnPQpEsDC2mRNj6B1yx2YFG
        eNTNl/Q95m1QZSpNDXXU8pRRppLbdTvr/EKbeJNLhAQAL/80FBVvK+tntQMi7dN4
        nyw7w42pibuO8GGw0WctMio3QDajWiQTdkDKg0rT2/W6B72aKlXejtM4ALqvqmRQ
        SLG6inCFKBL8619wFjnyoOxq0+20tow3lJoy6bObDyPF8fOyzlDmzE91T33teDZ3
        JujDtdJp8Xpcc4vjE707/BdLpEm877o6Np4MF4lfPOBUS3L7c69S/+72WuNh9xdt
        yRi11Rc+cSKwXWexLy1s0a4QfYTgg==
X-ME-Sender: <xms:IsWcYfnqaOmt4bkSbeWRd1sqyuDMumzAnnH2IpsUSdsmKKPQS4Wa4A>
    <xme:IsWcYS3eSXh8xgIBS5ZoqdL0-0on6oObxBcR4TzCiLHf0sXVwNGlbxAbSy3nsNy1L
    9vCnCcwXQXd68Vn410>
X-ME-Received: <xmr:IsWcYVpf7GP4NICY6SnOrJQ3Pu15Fqxs9NshAntR9q3XsqhM1CRi3Rbq-II9GqZarX1Ec_y9GejRAmpfaDUJnc4ZLBnVE8Rg39A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IsWcYXnhKiG99ZUjDmcfg_SGOJIGY-nu7KZnwYwe3-o417J0eXE6_g>
    <xmx:IsWcYd16pKtulKrQIhPW2-ePJpw46M4Jxl0ixUPXBm_il048hYjI6w>
    <xmx:IsWcYWt6DUaXj_8JMYnuRMZ8Wv9kCCEt51IvQZof68nUkgjaiC3rOg>
    <xmx:IsWcYbPChefrWENLV1ZS9cvLrkrBtGY3OoBiW5i8t7YBOMk4aaYvQw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:40:33 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/6] dt-bindings: arm: sunxi: Expand MBUS binding
Date:   Tue, 23 Nov 2021 11:40:25 +0100
Message-Id: <163766402024.90163.12275660075897154076.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118031841.42315-3-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:37 -0600, Samuel Holland wrote:
> The MBUS provides more than address translation and bandwidth control.
> It also provides a PMU to measure bandwidth usage by certain masters,
> and it provides notification via IRQ when they are active or idle.
> 
> The MBUS is also tightly integrated with the DRAM controller to provide
> a Memory Dynamic Frequency Scaling (MDFS) feature. In view of this, the
> MBUS binding needs to represent the hardware resources needed for MDFS,
> which include the clocks and MMIO range of the adjacent DRAM controller.
> 
> [...]

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
