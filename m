Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F77AB3F9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Sep 2023 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjIVOnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Sep 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjIVOnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2023 10:43:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F96197;
        Fri, 22 Sep 2023 07:43:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 67BD85C01A8;
        Fri, 22 Sep 2023 10:43:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 10:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695393794; x=1695480194; bh=cX3BFEpcSwAI2RdCFAWOh+RUcIcSLZQQw+L
        ux7UIf5E=; b=byVnIw0riDP04n+Z8z/RKs8pC9p7MfrSAwZuzyK46OTg2vYywMC
        LckrWBrRWrN7DcJrLn/kJslgl59T+X/O2gubjWaov4OBG1L20byPOAXry6H5Gg1c
        msiJMw5AqV1TzmDf4uNENqnrbN4eoP90hnWFYq5OPtQZCBcgb1QQ1Z0VQ4SyH9dT
        ZO/GhMFAIL57iljL8UmtNM9vTKGXx53iNfAqpQO38w0/xZbx9/dJTJeqqe89FZTF
        oy/FcLL7fV1Gfdp6fGnRt2HId563GMip9XgDtSzHSSYH0WgW4nsKjkCFLxSF3DxS
        ZUw1b/7w8dTtdR/SrFwoOlzCCKlYD77ASpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695393794; x=1695480194; bh=cX3BFEpcSwAI2RdCFAWOh+RUcIcSLZQQw+L
        ux7UIf5E=; b=anUc5YEGEsbPQOjR6H0SbIN+3S+WwzQhj8B2WuwNKGntAArp4q9
        f13HbRek4d+QV9bWqHq/lxH3UnP581s0QHQSj6M0HUYdzNBRpFZ2LISDIPLYvw/0
        JhFInQNt2xyukBUbbTT7hUanvvfos6DcQd7PkGpH1aOj2rWhgr4h9LPCk3V09dqg
        NoFCVkZUHiflLWlVHfWUADJbGEXI8Ujy5+eKbzERP4BjiqJzLZxcgh5EDjhI28+w
        tTesag4GeQF771BCKVEEr21DiNsoGtjorF8Z7SNqvlPxvb3dnbUobZW6WmlvPEFy
        t0rspIHcmRk3OKmmrIVSD3wGxkO8XHAmbow==
X-ME-Sender: <xms:AKgNZZY6RHRwuWC2y8pkz1-CRypBt8bojZXgsVALd2swGQeGiXmYtg>
    <xme:AKgNZQbS7Su86Jlv4dX87tAoQ9pyimlOV1vhU7ZkQ0U2DnZHUVgRMz9xV7bemNhEr
    blajbTDOfR-mBkBl68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekkedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AKgNZb8o3CcQxKVCcRK_Rp3Xs0nd8JPIpwNLwvPjRL0YJWpJxOKiBw>
    <xmx:AKgNZXpfUDyvsH_GXBRUjW7EqrsWFts73MM-cNleiI1Nt9WrVVauIw>
    <xmx:AKgNZUoHvPDmZBhUSsw7yfkqr-zFl-vpZLMwG6Enwtu3I-89hzKmQA>
    <xmx:AqgNZR5XzzbiNWX3fYcKTkSSxS6wDcyiBMw8FGsaxiYYlNBSBqkPpg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 62A8CB60089; Fri, 22 Sep 2023 10:43:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <ea9ee2dd-b71a-4c97-a347-20536d7ad424@app.fastmail.com>
In-Reply-To: <CAAhV-H73kp8zWJD7AKUvknmxow=f_cPBw9jctpmced6o_QCF6w@mail.gmail.com>
References: <cover.1693623752.git.zhoubinbin@loongson.cn>
 <16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn>
 <885eab85-2c11-cf20-9187-55cd647fbe9f@infradead.org>
 <c7604f6c-4da7-47c4-abe9-e626b3efc665@infradead.org>
 <20230919-9ce82588fccdd641574b468c@fedora>
 <CAAhV-H73kp8zWJD7AKUvknmxow=f_cPBw9jctpmced6o_QCF6w@mail.gmail.com>
Date:   Fri, 22 Sep 2023 10:42:51 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>,
        "Conor Dooley" <conor@kernel.org>
Cc:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Binbin Zhou" <zhoubinbin@loongson.cn>,
        "Binbin Zhou" <zhoubb.aaron@gmail.com>,
        "Huacai Chen" <chenhuacai@loongson.cn>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        "WANG Xuerui" <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 1/5] soc: loongson: loongson2_pm: Add dependency for INPUT
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 19, 2023, at 12:15, Huacai Chen wrote:
> On Tue, Sep 19, 2023 at 11:48=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
>> On Tue, Sep 19, 2023 at 08:36:50AM -0700, Randy Dunlap wrote:
>>
>> Seemingly this was sent again in isolation 2 weeks ago, but neither t=
he
>> maintainer (Huacai) nor soc@kernel.org were on cc:
>>
>> https://lore.kernel.org/all/20230905123629.4510-1-zhuyinbo@loongson.c=
n/
> v3 indeed cc-ed soc@kernel.org. :)
>
> Arnd, could you please take this series to the soc tree? And also this=20
> series:
> https://lore.kernel.org/loongarch/cover.1693534134.git.zhoubinbin@loon=
gson.cn/T/#t

Sorry, I have been traveling and not pushed out the tree yet.

Can you confirm that the input dependency is required for 6.6
and the other series can wait until 6.7? When you send patches
to soc@kernel.org, please always mention which tree you intend
them for. I might disagree, but it's better than having to guess.

     Arnd
