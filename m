Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89E41D8EC
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350453AbhI3LjX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 07:39:23 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:54573 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350447AbhI3LjW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 07:39:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 3CC412B00428;
        Thu, 30 Sep 2021 07:37:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Sep 2021 07:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=F
        TKJqnUNdam3eXYcxKVwRSUv7R/MUB8dw+EeZb2yffI=; b=lZrejGtO9mHZIlKQR
        8OC8F82Zjqs37lcpH1jGd9ppXkzv5qH9en10GS3OWsYPEytqOmoa3+b1IEDQ1xRq
        /SsUwEYZ4g6rVlchuybxJK2dXv80WZA9ethatvW9yo1RBpaFbA82CIhKYbRHpHTV
        AXOvxD/polWDrTn7cDHM0i4qEhbsOU7NPfsQtmR9wKnIlMP7Ym5O95+kyrRsWjc8
        o6Y8+h0rfW4C9WHChuVMciBxQAgwsTb9PEFRcmtGYmFJ/Gg2GovD4osiLHie0OIR
        pRb6cUTnpk3dqnHVyxP5kVhCP32pcwVf9FhXwLRcixvNusvomdsCwuCHE9DmPaDo
        VRo5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=FTKJqnUNdam3eXYcxKVwRSUv7R/MUB8dw+EeZb2yf
        fI=; b=Cp3BiCJd9Si8nSF+L96RumPEjY5qCVwvtwq9CdPm9WRds+9qtTI0ERMGZ
        j1Culz447InBI6CP05DY3qoF+nElBjiUtP6tSo0YR5sqPbPzICcRasc9KQLkLQuk
        XRxnV+N6rjjnFTq+oXQFzgAjGNrqAsoOTOMb3ttJedKFv29o65Nl8pKH59Hlh8bQ
        yDSyXAhSwTLTVjUvkZQPtUhsoQgsGfpbyljfsrBCGWRfKKJTz1BAJqoAW5UGW8/S
        DawHkwxq1B1Dnuj/kgAeCpPkej0Zpz3XahFJI31AOKL8ZWfqGIJhrsvV6zuEncPq
        GtuYSEp9tsTmXGcVYksTtgkAOONKQ==
X-ME-Sender: <xms:gqFVYeWpq4we2qYbs17TlY2CXJLq4qISoSzBnNAhj0pFehaSkHudTQ>
    <xme:gqFVYakwzZznoCRiHCDpykZwBEo8OF3TAUedUCAw02l_k5ZkWoy5ZAjcH_is6kRHC
    8JGlDClJLNr0uDV7A>
X-ME-Received: <xmr:gqFVYSbmQX52drvwkxfnuI-Z2VSyWQdcLx_OIhP6vfNb5pqBADVtzWLJ_BWPU_9Kv0OedUdyLrbQ2phZTx-OSpgN7eeyh6SzIBWLNe2qFYu1cDFFN3Bu-JbPBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekgedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:gqFVYVWOwFqu1wlzzxWfBkncu9fJlmRlw91zm2PCpwbzNtpVIpMW7Q>
    <xmx:gqFVYYm8fMw4_WQz9zCnx8EnI-dRw5ABRhk6HO1LhXrUTQ4zrMHxaw>
    <xmx:gqFVYaf4sT9c4yl6PXsufCPQ9K-VMjJWqsmJzUuFGOTtNTURDVOh7A>
    <xmx:gqFVYT9l8kaFitT5Sm2I2qjMAAaGbZMRwyrVJKDjPWNVBpl66L15p9wURJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 07:37:37 -0400 (EDT)
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20210929044254.38301-1-samuel@sholland.org>
 <CGME20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4@epcas1p4.samsung.com>
 <20210929044254.38301-3-samuel@sholland.org>
 <114afa7e-6218-6b1f-f87e-84690f10029c@samsung.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
Message-ID: <d0a2c36b-4019-2f52-13f0-be76db5a48ec@sholland.org>
Date:   Thu, 30 Sep 2021 06:37:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <114afa7e-6218-6b1f-f87e-84690f10029c@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/29/21 11:19 PM, Chanwoo Choi wrote:
> Hi Samuel,
> 
> 
> On 9/29/21 1:42 PM, Samuel Holland wrote:
>> Since commit ea572f816032 ("PM / devfreq: Change return type of
>> devfreq_set_freq_table()"), all devfreq devices are required to have a
>> valid freq_table. If freq_table is not provided by the driver, it will
>> be filled in by set_freq_table() from the OPPs; if that fails,
>> devfreq_add_device() will return an error.
>>
>> However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
>> adding the devfreq device"), devfreq devices are _also_ required to have
>> an OPP table, even if they provide freq_table. devfreq_add_device()
>> requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
>> return successfully, specifically to initialize scaling_min/max_freq.
>>
>> Not all drivers need an OPP table. For example, a driver where all
>> frequencies are determined dynamically could work by filling out only
>> freq_table. But with the current code it must call dev_pm_opp_add() on
>> every freq_table entry to probe successfully.
> 
> As you commented, if device has no opp table, it should call dev_pm_opp_add().
> The devfreq have to use OPP for controlling the frequency/regulator.
> 
> Actually, I want that all devfreq driver uses the OPP as default way.

The current code/documentation implies that an OPP table is intended to
be optional. For example:

 * struct devfreq - Device devfreq structure
...
 * @opp_table:  Reference to OPP table of dev.parent, if one exists.

So this should be updated if an OPP table is no longer optional.

> Are there any reason why don't use the OPP table?

dev_pm_opp_add() takes a voltage, and assumes the existence of some
voltage regulator, but there is none involved here. The only way to have
an OPP table without regulators is to use a static table in the
devicetree. But that also doesn't make much sense, because the OPPs
aren't actually customizable; they are integer dividers from a fixed
base clock. And adding a fixed OPP table to each board would be a lot of
work to replace a trivial loop in the driver. So it seems to be the
wrong abstraction.

Using an OPP table adds extra complexity (memory allocations, error
cases), just to duplicate the list of frequencies that already has to
exist in freq_table. And the driver works fine without any of that.

Regards,
Samuel
