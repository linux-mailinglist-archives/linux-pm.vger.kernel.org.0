Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757655A5684
	for <lists+linux-pm@lfdr.de>; Mon, 29 Aug 2022 23:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiH2VwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Aug 2022 17:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiH2VwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2022 17:52:03 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CB9E688
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 14:52:02 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11dca1c9c01so12513502fac.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2022 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bxfy8Zomwh4A69BNWtvxjiLXRoFPJjf2nnflSlK/Tys=;
        b=RaxnAUlK3ZvWqXQBwZk8akYg196Sn0svypA19wVKdxfe64zdGxlul9eVpCbKGd9ri7
         VSqhmO36X8RG4ic9wbWCovIEjIYfm6tp1i7D6N+h/s5WcjfT0yE0PYt7XZqVzo+cdxT1
         JnOAsrsor/hDNazFDw4U2rrZ3c3NQLJNQt1QrtOCmz2tiFYrUXfD8BYu05KGwEcfxxdY
         NkDI5PUwrC0U9IYuklKNOc/oXXiTbPUW2O87i6LsAz5iF6DF5c1aY8vHemjKjedVgMMZ
         7XrSI4BOqlNrr35yXy9SZcpD3vGn2a6SpNwlMH4QDNGfcW2j72EzAbXW54/ANmtAULeX
         Zd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bxfy8Zomwh4A69BNWtvxjiLXRoFPJjf2nnflSlK/Tys=;
        b=vQ/IbuHi/lq/OznFTXaQcDx/a76anX/QXhNrZCoQ3tPU+64tUnBye0X7FefzdXrMgj
         +fPcEtFtsjIwi99DKqDBiiMFRAZGtGYPfOXZk1I0fwcdaaCxenpLhwmdp1A9Lq3CQ9DI
         7mAGTdP+83OUwapuGu8+9WYcVQFtiDrXGqO0TEsQ4DFxHG6crWeqJOiQ/j+FVpRlbbJz
         YOeC8552Z2FjcNTBknl/C5tzo55M+cvu75CVtvbQGwxE8P3mGZeQZIT2vPKdugjDmRR+
         aY58LPQ/EP++GQYfBxcLPPki2piY6kNHKEj9EHbGi5KTY4b5fVABt2+DvJJ0WIyVzfjb
         MHAA==
X-Gm-Message-State: ACgBeo2AByRsKf7o4xGRbid2ZsovboBcUxX1IGF1V7IEjqmhFXcNXOEq
        Iex1UMTgtTg5qJxrROOmnJliTNBEx0hDJxUZLhmgWQ==
X-Google-Smtp-Source: AA6agR4Rn7yklbl82D2fQX/X0qmfMsVoZOpAdKpt0McPV8rfEBijYLWU71oEjyLOIaviUeEC/qVCzsR7eAftQxwMkFY=
X-Received: by 2002:a05:6870:e996:b0:11d:6525:791e with SMTP id
 r22-20020a056870e99600b0011d6525791emr8513997oao.175.1661809921628; Mon, 29
 Aug 2022 14:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.6.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
 <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
In-Reply-To: <deafaf6f-8e79-b193-68bf-3ab01bddd5c2@linux.ibm.com>
From:   Matthew Garrett <mgarrett@aurora.tech>
Date:   Mon, 29 Aug 2022 14:51:50 -0700
Message-ID: <CAHSSk06+CNQLKS8p_jh8JH7acn6=Ck8W3W2DM75rV3paZQ+MbA@mail.gmail.com>
Subject: Re: TPM: hibernate with IMA PCR 10
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        dlunev@google.com, zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 29, 2022 at 2:45 PM Ken Goldman <kgold@linux.ibm.com> wrote:
>
> On 5/4/2022 7:20 PM, Evan Green wrote:
> > Enabling the kernel to be able to do encryption and integrity checks on
> > the hibernate image prevents a malicious userspace from escalating to
> > kernel execution via hibernation resume.  [snip]
>
> I have a related question.
>
> When a TPM powers up from hibernation, PCR 10 is reset.  When a
> hibernate image is restored:
>
> 1. Is there a design for how PCR 10 is restored?

I don't see anything that does that at present.

> 2. How are /sys/kernel/security/ima/[pseudofiles] saved and
> restored?

They're part of the running kernel state, so should re-appear without
any special casing. However, in the absence of anything repopulating
PCR 10, they'll no longer match the in-TPM value.
