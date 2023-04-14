Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95DD6E27F4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDNQFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 12:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjDNQFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 12:05:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558C49F3
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 09:04:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 513EB5C0112;
        Fri, 14 Apr 2023 12:04:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1681488296; x=1681574696; bh=a5lNomHpahVlq1sve5nT/0QPm5y/Q+3RTiq
        w7xirtls=; b=ltIyuuLqu537SnXo5+ZiBWcPnjOB5EuuKgSD0G3OItGJ5o9Pmwe
        Ai+qlsXyWbhOw1+RXfXv7M2Luo81jlsX9nE2UYz9H7pfcKqUQUKcmIm9EX1EsUQg
        APdSuIBpgT5pViW73jl3v3ZWrwdnfkqw4t6AtLv3x8/rlZW2HQD9wmYpOXf72H9V
        MIKQ9LMpKHoHmbxRBcxHpbL5bjwlDJl7r4Wm9RPkzS6kEBYNwZPekrbYcujRfOI0
        FIE8+J87rW4mKp+TmTqOGMeockkWcOMflXPuyXBjLeMtjFRfUnFCgPmw0YguDsbd
        OAUpskQ42A9Y45VJ1tTeUggOQYOZhfx31jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681488296; x=1681574696; bh=a5lNomHpahVlq1sve5nT/0QPm5y/Q+3RTiq
        w7xirtls=; b=TmgaXMdc4JWfTWXMuNGPTjDlesdyPxMKYvKfxDdUx1QqSShdy6J
        XCqQ0XGurzF/qFjmGrEfhaUZlzNVY56jWYFXBjJI175IIea8Kl2kel79r8G5FT3J
        gi807VTLK8ky3uaMfK8ZyxtwZTXUGbpCt3vJw/IslYwXSTaCeoinEOpr7okX/W/0
        +UURUDFEn8hZPakloJIYVVGeRo/3uQLtyughs83tJldol5hxEL3AF9iqbjN1Jhbg
        7Bul+nImNkGqKlPpkVwX7SPVUGs5Uvhkj1LTEZe0iyqZ7c5xCABnhbNLTwXa27Kx
        pneX0q3wjQfJHmI8M2cwPsGey12oYpuF2pg==
X-ME-Sender: <xms:p3k5ZEsXVht3ONfqVYSwMIuieyhzRIu__B-JIBaoXDeQicIU1Q-a8w>
    <xme:p3k5ZBdpr8dyzpSkPcGHcQx4ricy4EpUOrxLZItXmx3PikLZEiQE6eHX2eU7SVFQX
    nkPD2fNB2kX_acSG3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p3k5ZPzArmg2z5xHWyDtDCI9MynaX0YitzhfkgrlV1UptnuBZDlFPQ>
    <xmx:p3k5ZHP__Uj_g6M_Zu-dRt_e8yo26HdzViQ_cgdBfKj-6pEO4psdYw>
    <xmx:p3k5ZE_a7rv11TcEz8cLBCuCRkkw6dN8T3XwNw7Cht8rMlQ53kZizA>
    <xmx:qHk5ZIYfYjUDX4t51kR_Y0kfIKwOM5aT2Im4nNkB4rjvFNY8xi4syQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6D8EDB60089; Fri, 14 Apr 2023 12:04:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <cb3e16f0-cdef-42da-8761-8e729578e108@app.fastmail.com>
In-Reply-To: <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
References: <20221012140032.113363-1-u.kleine-koenig@pengutronix.de>
 <20230412142539.brqexyi5kpac5ltr@pengutronix.de>
Date:   Fri, 14 Apr 2023 18:04:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Nishanth Menon" <nm@ti.com>,
        "Santosh Shilimkar" <ssantosh@kernel.org>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: Re: [PATCH] soc: ti: smartreflex: Simplify getting the opam_sr pointer
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 12, 2023, at 16:25, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> [Cc +=3D Tony Lindgren + Arnd Bergmann who did care about the last cha=
nge
> to this driver]
>
> On Wed, Oct 12, 2022 at 04:00:32PM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> The probe function stores the sr_info pointer using
>> platform_set_drvdata(). Use the corresponding platform_get_drvdata() =
to
>> retrieve that pointer in the remove and shutdown functions.
>>=20
>> This simplifies these functions and makes error handling unnecessary.
>> This is a good thing as at least for .remove() returning an error code
>> doesn't have the desired effect.
>>=20
>> This is a preparation for making platform remove callbacks return voi=
d.
>>=20
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> This patch still applies to v6.3-rc1, but I didn't get any feedback
> since 6 months now. I need this change to eventually make
> platform_driver's remove callback return void.

Applied to the soc/drivers branch for 6.4 now.

     Arnd
