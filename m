Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783FA7BC904
	for <lists+linux-pm@lfdr.de>; Sat,  7 Oct 2023 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjJGQM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Oct 2023 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJGQMz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2023 12:12:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F35BA;
        Sat,  7 Oct 2023 09:12:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DF3613200A1B;
        Sat,  7 Oct 2023 12:12:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 07 Oct 2023 12:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696695170; x=1696781570; bh=dF
        Y5rJ9ss5jREpKWCyTg9PCxV3WUDkMb9tB5voCmoG0=; b=S1boMD8Z9oJuyRcCW4
        LU/yIsjhtK9iB7xt0GNQEzT3TRgDaUqXRVrUeECY02XuVFgmimAnPvg07ORRgugn
        lAuyRf+bTXrGc+lO4SngO4VjvJ22NlKzFuTJK3hK42633wIaEJfS+CyeMa0XuoB2
        CZejm+SUusEI1vtqwgxyArfpszS4UA89UmTXR1E6Ez7jG1e52Cj0PrpVSCWCSY3X
        0T0TK/e3WiuL+HP8OdOcv2Z9hByfOlnWZkyzJ3X3XL5h2UV39YsJZnFN4WMMWc/E
        xbx5Q5I53tBDYkzEICHjkGfM7ewLpFNln38hvQSMSUq9U3QouXB8sMN9BVb5hOCs
        W/1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696695170; x=1696781570; bh=dFY5rJ9ss5jRE
        pKWCyTg9PCxV3WUDkMb9tB5voCmoG0=; b=h8lmJgtWkUjaW8sU87IPOMR5cslQd
        sovt+Q+onaWG6sBVGQyGmciGn8fRC0n4JRi/r3EasrFvqgLEkj1e55ywlrmzYh3o
        CL/EYIZ6e9YCngmVGPYayTEMH4Bd02SqtMs7GN5bYeizRnZA7yM4DMKKHVo/6pmn
        8eKFR7WMrzqZEGtbdXGRKv9/uNOlB3FJ810IxhmYG2soaqZ7k2nR3ytqg3T/iwo3
        Has6mDCVD4UcCu26q4h5j4qTaN185a0iLgMirHx14nIgVwAG284ve2k+3dI6mJc5
        s/egJ6YKvVK2/8gSYzFF739eDaCB0rStsUC6Brl9S4sO+RL8Q/dgyT8Fw==
X-ME-Sender: <xms:goMhZc3eks1SdcKfIx2NfB7qJriGEUus_HmJ_ykyMLaHx6Uqen62BQ>
    <xme:goMhZXEnp-4CE2zl8VrfaJxUamLeULh_4yLrjSp6r5ttXnWE3dW42rfT7niRuljQB
    sG_Jz6IG1F85Q>
X-ME-Received: <xmr:goMhZU6pJxxyGaMtDDs1T42lf95ScmhfDv-O3LN3VaCWi3IKN_ybqvLsvbLRB0QsZo-OCqpoCJa3z1utergIzPKqM51u0KLQ-w8CFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:goMhZV2Wypu8vkiYQVco4ynn19GahgT0KofVdArNVAy2ZDaibIHRBQ>
    <xmx:goMhZfFXWdhGQ8Ysi9krchLG2ZEj-e9kVnUijUP5IUgi8Pt_8jT0kg>
    <xmx:goMhZe-TH_RyhNJu7NN6r5Pc1O3GGhLjw4Yr4OpYaf12Wcvmia6mQQ>
    <xmx:goMhZVaBa6T4LP6zy-qxzM7T1NEIFf_1zs8hJqzAXQpxnyKdM981jQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Oct 2023 12:12:49 -0400 (EDT)
Date:   Sat, 7 Oct 2023 18:12:38 +0200
From:   Greg KH <greg@kroah.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     stable@vger.kernel.org, ivan@cloudflare.com,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org
Subject: Re: Backport "cpupower: add Makefile dependencies for install
 targets" to stable
Message-ID: <2023100731-lurk-outsider-4e5e@gregkh>
References: <615ae9bd-f220-4189-aca2-7aa946444043@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615ae9bd-f220-4189-aca2-7aa946444043@hauke-m.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 07, 2023 at 03:38:39PM +0200, Hauke Mehrtens wrote:
> Hi,
> 
> Please backport the following commit back to the Linux stable kernels 5.10
> and older:
> 
> commit fb7791e213a64495ec2336869b868fcd8af14346
> Author: Ivan Babrou <ivan@cloudflare.com>
> Date:   Mon Jan 4 15:57:18 2021 -0800
>     cpupower: add Makefile dependencies for install targets
> 
>     This allows building cpupower in parallel rather than serially.
> 
>     Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
>     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> 
> When I was building cpupower from kernel 5.4 using buildroot I was running
> into this build problem. This patch applied cleanly on top of kernel 5.4.

Now queued up.

thanks,

greg k-h
