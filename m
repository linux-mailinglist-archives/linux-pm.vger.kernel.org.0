Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51EF41E5E5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 03:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351337AbhJABr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 21:47:27 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:34825 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351220AbhJABr1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 21:47:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E17062B00262;
        Thu, 30 Sep 2021 21:45:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Sep 2021 21:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=v
        Odoat0J6oK40pz/pIFwU3UMSzNN+QQ5EnZGqlGFHak=; b=gQmCA3rjtz3PfoW/C
        hQUSW3jnbYvySDgW/Ltfhsf2zmDcf7sbSkGHDLOnHgd8CNRKe7Q5/MOV48arJvfZ
        bnmnOolkxCVlSoWvGgi7hldvleOjJWxqbBb9FlQYbWp+dLPQcAwuIuSgyyaEQ7HU
        Omzbl65IxjvsT/lm0jt3KK3tGcTK2ZDVMIouCq1Q1pa4LVRnOYfgB2AcHGmY7F06
        4QcvlcrYFi2mDmBlMSKtEmAB7BN+p6DhRBdwl3KhZiA0bWDwWYcu8rMpIUIklptf
        Lzk8YD0Kwhl5oEXBEbOFq/o781In3cw6DXV+tc4FD1Pjx4pTgn10Qh6SayOrcHq7
        qcK8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=vOdoat0J6oK40pz/pIFwU3UMSzNN+QQ5EnZGqlGFH
        ak=; b=HEdTYRJg1zvGFpz6zaSCEe6OCgmzV/sA1VVSbHtFk+YJkPNcGVDSnzv/D
        yNU5UvgKCIVH7XMpnRReUFK09bSv2HD6eT153H/Ch8p5lO5wyWIHGNFIe3kUaW3A
        DenQF9S5xZvpkYLPKCsfIdLWIsLr4h34b6A9DtBGgk1tFfJseU70k4kAMS3TdZGc
        i3gzGfuAQl1IjvQdGY2br5s7c5INeyhQHLa70yChBjpbnq3Dc6oLZxg66YmobVFb
        Bwxe31mozgSTUBiWZVDNm++iVzBS5FoT+YGtr6jIYlNaT4OgqZpctWrohfWw+ekv
        q6PrwYQ71fjxUCzqiCfg2PqMMJs9w==
X-ME-Sender: <xms:PmhWYW9OJw--v2S7uTeaW79I5cR7EPEvhXtRRG7aF1hUTTX28HNs6Q>
    <xme:PmhWYWs7fpyTfn6y6nVzcm-KXRRSC94ceD5dzhMKq4Dxs3zVSIBdY2pVQ3RvvUwq7
    DEuBzEAymUzQWCkUw>
X-ME-Received: <xmr:PmhWYcDGJZO1U5jFhTGD8xmuoMBYMrnWxJlOQpP46gWffRHx3TD75gePirtl3blegvMYCEuWBEcs9tKsDMzHX4wm5CuOQh9AksqGM7tbaosmnChzPlp7mnun1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudekhedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:PmhWYeeLiZXNuVD2lpq0yxKJ8J9uLWC355Fsph91MlOMjtvnqQ4B2g>
    <xmx:PmhWYbPfecYLCy0nl1sbKttiYZuw9nXgavNjQQzJhx6574fT2ZiqHA>
    <xmx:PmhWYYmtyfQMLcLKbY9CAXQ-e4urY1ei955rIM9usKtSMih-lZMgPA>
    <xmx:P2hWYfn3EWh6bdaEVD3VXdoJSDwos5r0cgtapU5ip4qzynLI4zjIHrWTo44>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Sep 2021 21:45:33 -0400 (EDT)
Subject: Re: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
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
 <d0a2c36b-4019-2f52-13f0-be76db5a48ec@sholland.org>
 <7d404f89-6567-61e6-7964-d2ca578ed652@samsung.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7107eea6-f2ca-fb7c-5975-569066ba21a7@sholland.org>
Date:   Thu, 30 Sep 2021 20:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7d404f89-6567-61e6-7964-d2ca578ed652@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/30/21 8:59 PM, Chanwoo Choi wrote:
> On 9/30/21 8:37 PM, Samuel Holland wrote:
>> On 9/29/21 11:19 PM, Chanwoo Choi wrote:
>>> Hi Samuel,
>>>
>>>
>>> On 9/29/21 1:42 PM, Samuel Holland wrote:
>>>> Since commit ea572f816032 ("PM / devfreq: Change return type of
>>>> devfreq_set_freq_table()"), all devfreq devices are required to have a
>>>> valid freq_table. If freq_table is not provided by the driver, it will
>>>> be filled in by set_freq_table() from the OPPs; if that fails,
>>>> devfreq_add_device() will return an error.
>>>>
>>>> However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
>>>> adding the devfreq device"), devfreq devices are _also_ required to have
>>>> an OPP table, even if they provide freq_table. devfreq_add_device()
>>>> requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
>>>> return successfully, specifically to initialize scaling_min/max_freq.
>>>>
>>>> Not all drivers need an OPP table. For example, a driver where all
>>>> frequencies are determined dynamically could work by filling out only
>>>> freq_table. But with the current code it must call dev_pm_opp_add() on
>>>> every freq_table entry to probe successfully.
>>>
>>> As you commented, if device has no opp table, it should call dev_pm_opp_add().
>>> The devfreq have to use OPP for controlling the frequency/regulator.
>>>
>>> Actually, I want that all devfreq driver uses the OPP as default way.
>>
>> The current code/documentation implies that an OPP table is intended to
>> be optional. For example:
>>
>>  * struct devfreq - Device devfreq structure
>> ...
>>  * @opp_table:  Reference to OPP table of dev.parent, if one exists.
>>
>> So this should be updated if an OPP table is no longer optional.
> 
> Right. Need to update it.
> 
>>
>>> Are there any reason why don't use the OPP table?
>>
>> dev_pm_opp_add() takes a voltage, and assumes the existence of some
>> voltage regulator, but there is none involved here. The only way to have
>> an OPP table without regulators is to use a static table in the
>> devicetree. But that also doesn't make much sense, because the OPPs
>> aren't actually customizable; they are integer dividers from a fixed
>> base clock.
> 
> You can use OPP for only clock control without regulator. OPP already
> provides them. OPP already provides the helpful function which
> implement the functions to handle the clock/regulator or power doamin.
> It is useful framework to control clock/regulator. 
> 
> If the standard framework in Linux kernel, it is best to use
> this framework in order to remove the duplicate codes on multiple
> device drivers. It is one of advantage of Linux kernel. 
> 
> Also, if OPP doesn't support the some requirement of you,
> you can contribute and update the OPP.
> 
>  And adding a fixed OPP table to each board would be a lot of
>> work to replace a trivial loop in the driver. So it seems to be the
>> wrong abstraction.
> 
> I don't understand. As I commented for patch 10, you can add
> the OPP entry of the clock without the fixed OPP table in devicetree.
> 
>>
>> Using an OPP table adds extra complexity (memory allocations, error
>> cases), just to duplicate the list of frequencies that already has to
>> exist in freq_table. And the driver works fine without any of that.
> 
> 'freq_table' of devfreq was developed before of adding OPP interface to Linux kernel as I knew. Actually, I prefer to use the OPP interface
> instead of initializing the freq_table directly by device driver.
> I just keep the 'freq_table' for preventing the build/working issue
> for older device driver. I think OPP is enough to control frequency/voltage
> and it provides the various helper funcitons for user of OPP.

Thanks for the explanation. I will convert the driver to use
dev_pm_opp_add(), and I will drop patches 2 and 4. I think patch 3 is
still worth considering.

Regards,
Samuel
