Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7172B25DC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Nov 2020 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKMUu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Nov 2020 15:50:59 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:33041 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgKMUu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2020 15:50:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AA2FE2C7;
        Fri, 13 Nov 2020 15:50:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 15:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=74IkybClz9uGjeMG8qi3WvTKNpt
        GiWLVFERtT4jCPF0=; b=L7/Pq354dBgqlQhF+RIDXHEGRVF1Xyr2VNvx6iY+Tik
        d6jwUu+rOEJCfC2T/9Uzb9rHiERqm6GLdG9qq8vERjAxwkvnCXCUNCtAa9leDPOx
        g5n9XzVqojd9jjHdnClHFpTnI4nau9UGvAiJG6c38PdsokPmNM0SSAa1GjRzPt6s
        IkSKe9IoqIaQ+2/5PeVHowhEJx1fPd8Cfl8sbox1EnpVujWtSBQGIS4MtlrUrtDI
        tLxncqzSYqeME4R6GTtAyqlaD3quGsDgVj0f8y2z9q8JAFm0JJPhzVzdV9DDsBPO
        N+iUqTztEc/t0tLRoKB2CoI5XsD4mCkBSBx2qdHWw5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=74Ikyb
        Clz9uGjeMG8qi3WvTKNptGiWLVFERtT4jCPF0=; b=NWLEW0Ax5yKT7ckeS6RF+z
        JgfTSrOjJlll0Y3qIPa7tk1g7k+d7/8e9QbuehOiHHI5cg+r8LdJTHOauLqHrkMq
        Ck/n/gcnz2JNQDd8h+HrrssoZW6vFmZ+gx+e1dGAeymKFx6IUJrYvhVUN5C5Jz68
        jd1tKFHD+n/Ruq97BhWPtaBCpvwq1M5M9KJwBOqF6pR/MUeEXAWjuuMK5noRfbPT
        VwUOcxtzACOuwq4OrCPQQRKeJMa7hsl80e2R5UwfPsbccJMeZWZNE03O0ESI87Gf
        h8Rhmezjccgrk1KiCiNRNPkByYOI0qzt1x2jahNb49ZcbrXY9MpInBqVLpuiSPjg
        ==
X-ME-Sender: <xms:sPGuX7jd3BT8Qynwr8D2eaJQEGEgYm8iSzf72n9WowKM3CjzeQAdWQ>
    <xme:sPGuX4DT045-En1pKBCb-pxBPC7dfDn4JuEQRUmfdzt0W5U-ZIwPvYrAgfbiXbs1-
    m96pQBnfALF3vaGgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepudekhfekleeugeevteehleffffejgeelueduleeffeeutdelffeujeff
    hfeuffdunecukfhppeeijedrudeitddrvddujedrvdehtdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:sPGuX7FllhEhuDXhpf3i2q_wR3TNmPFL36EWisQhWZsNm9wQdvI88Q>
    <xmx:sPGuX4S-dR7VCLSeDYQyAJdnDLRUmRlqV632S0TvqVQ6oN-zBEL0FQ>
    <xmx:sPGuX4x6QBfSG_lcW8l4KpHBA8EPBnwIQNGsp9XOprqZEfJx7kFWqA>
    <xmx:sfGuX08HyKxrnm5eJPqGOWalilfjwEIvT7EdzGpzT7X_MjxsozkIdA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id AEE373280065;
        Fri, 13 Nov 2020 15:50:56 -0500 (EST)
Date:   Fri, 13 Nov 2020 12:50:55 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Message-ID: <20201113205055.5vyey2qmkx23rkkg@alap3.anarazel.de>
References: <20200115184415.1726953-1-andres@anarazel.de>
 <2a5e9df32e2df27297149a577512f6b1557de241.camel@linux.intel.com>
 <20200116184250.qlvc3ilx2b42czqk@alap3.anarazel.de>
 <2de70e961f24592d2d157b8586526df2eaf0ae6e.camel@linux.intel.com>
 <20201028202101.2m2jp3tfa6mh3brz@alap3.anarazel.de>
 <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2020-11-12 12:34:08 +0100, Daniel Lezcano wrote:
> It does no longer apply, is it possible to do a respin ?

Yep, sent.

Thanks,

- Andres
