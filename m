Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CB45A08D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 11:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhKWKny (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 05:43:54 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53595 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235766AbhKWKns (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 05:43:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id D8FB95806FD;
        Tue, 23 Nov 2021 05:40:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Nov 2021 05:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        jHqBa28rn0MiiSXkTCsCMYCgTGVsLvmpc1gU9q4ZI7w=; b=e/FJypxlBwtIruv1
        giNDF2yNqbdBEmI6S+1VTycjsO7BCKqadvvZDcu4T+GvxQvxrYVFg5JE7CpRrwwW
        5C6dif7cCQjOzYamaoJiFFHNOzrm8oGEsGoLu+vFkb4zey08qQAjITHe2y5GrQXq
        E0bTRQbZUteb9OU5fOnrkIGyhNjVIgA8YKXfUVtI67Wa4omxGp1ue0U4AN1szW8+
        4WFk77bjNwL/F6Blv18qdOuH9s5PEGrUqICtV16Rt4bC3SJAcQAjkNTRa/5lTrQ1
        BMjdQLOP3KI9Hb1iLl0PB6NIYSZpUrrQpLdAlZb/cu0AXJStAeWR2Ky0dsyYLX7F
        7CBrBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jHqBa28rn0MiiSXkTCsCMYCgTGVsLvmpc1gU9q4ZI
        7w=; b=GYzx/cRQg9ot4vBajGs7ecBeuirTIjeqmgZy7XcAkufCuHCeY3bZLC9Mn
        ujwXLhtSvf9feMHeB77HTYy7ZJ4VtTK5Nmp3HUBNWNe25c7FFuPSciMO/WAIB9oC
        zNViUtE2EnyxuzCpFeKqyYJqXvwjE0bQW/TZwpFxNDRxjHmn+Bo2LTOHVM48U+fs
        ZhrfLSknGCiMFs6p6NvEig17sNaekiGqOOrr9Am/3D28HqLPbGoX98J/4QxnTkVz
        qyuoQaDKG53p1Nuz/2ja0733xSmErtc004EwG+KNWkxfPBO2UgTG/KY/DnMU8Cr3
        LRCYFWkiR6y03c+cVR1l7vyLaTy5w==
X-ME-Sender: <xms:J8WcYeQyyBmtsOuPcGH6rWf_WBhTOKhktwq_SLCVOuWIFs7r4JXU6Q>
    <xme:J8WcYTyfHMKYTKwcpaNuJnuq1usu1lpV4HPRAWgaIndZ01Lb5FnzcnAa9I1Lvtri3
    phXEHsy9R_ErqdHrFg>
X-ME-Received: <xmr:J8WcYb0M8CdkGa5JmCSTFxEMYO2Hbsk7n_gjyvXuMKmoKx-_FiXi7X6nXa3-tjw_vuGRlUyqYv5KNdsbseHi_yZsHizM1hLd25Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeigddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfefgeei
    keeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:J8WcYaCmxpX4nNti5EcnJcNIefx-e7R6qCS6BfE0q9MI79AwEyj5vw>
    <xmx:J8WcYXh2DNcgTLCO38RGBYMpDuRJp7YWbu4ehI4JJ9n1eOPfLiYR_w>
    <xmx:J8WcYWrdRIpbprKcdruRSAnRDbeXgRI2uZBt1yQztcSDtGDkAooJJQ>
    <xmx:J8WcYQZOzZhE32lb3QdYaoMKI2YDDHLlDTjt5JOBYuYj2dr91cYXWA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Nov 2021 05:40:39 -0500 (EST)
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
Subject: Re: (subset) [PATCH v3 5/6] arm64: dts: allwinner: a64: Update MBUS node
Date:   Tue, 23 Nov 2021 11:40:28 +0100
Message-Id: <163766402024.90163.13990616546329316010.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118031841.42315-6-samuel@sholland.org>
References: <20211118031841.42315-1-samuel@sholland.org> <20211118031841.42315-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 17 Nov 2021 21:18:40 -0600, Samuel Holland wrote:
> In order to support memory dynamic frequency scaling (MDFS), the MBUS
> binding now requires enumerating more resources. Provide them in the
> device tree.
> 
> 

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
