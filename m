Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4A4B38BC
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiBMABj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:01:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMABi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:01:38 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB365FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:01:34 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 124so7622357ybn.11
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSFO9KA7oP/rdS/HtR9Re6zMcPyr3b4xZD+Jwn9kCIg=;
        b=gcuaybPoSPGOpZXeEA5Gp5heGB3zgbG4ywo1GhciiO+xQmLmI8A/INDTKpIXP8sBfn
         qUEkkmP4QW1T7SyukQ7nDlT0sm4oGcP33bya29oWcI/+m+ZBSrJQ5BZgP7EHr6A5ssAm
         YsBByFWHkmX+wt4xWUr5lNU/cEKA+B0TYHgBrRrgwSs1uAJigd92nDBS6urx7keW1J8/
         /8LcZxyxvLcIffQLry7udLkj4emD349ML9EsTdP2Xbq+cp4kKyfFh+yx9T6Z6pWr433P
         +SFHFyIiFKbH6jshxX//IzmoMJOSVbMLiVHosIRPnzuPU75Z/MkufM+AS/CFV48CWv1R
         P/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSFO9KA7oP/rdS/HtR9Re6zMcPyr3b4xZD+Jwn9kCIg=;
        b=03XLEFtZisJFvnvxXoEdvLTin8KEdNldW75dRk/TURXMGaLu8Y0g31LIdC4dU4Pv0a
         0im5s4LLKCduRViimXohPxoS8wXLpULescK3laSHYp+51Q66F5aFuvJimqTv1OGvfwOA
         GEzvyLF5i4yyVzZ7/5bDfNgaA+SlABEnSraIAQMYj8ZB4L0SnoKsOlLrDZj/5DKtsftK
         KyOmsLmgJSvdzYiswDN0wDhPD7cqW5NZskE8AGT7ENpF4vAzubXy3cmq2OkZ+2VSAKYC
         pMqlsK9m+lzUQSy9R4V67V0L4qez0XZaekbaBkbDGjI64pfTNRTZB2GbuifYXbniz1PE
         oP6g==
X-Gm-Message-State: AOAM531Sa6nlpAi8Cp7l3R+W4MHPGg89WxRlQ/5U8FQiNUKqtfc0EDrh
        qlKc9yqMCG2VyO+o5mhU46rbFPXWDi3Iq2MWYQjFJwRmsCvUJg==
X-Google-Smtp-Source: ABdhPJxFzm++Jar6MieR3zB7p6v+t8PywKcUUeL2Dedc6G8Fy/4y+mhFq5/5gHVSqWAAdS6XMcB5D4ZRSWUxoXqFP0o=
X-Received: by 2002:a25:5143:: with SMTP id f64mr7630165ybb.520.1644710493375;
 Sat, 12 Feb 2022 16:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20220203171633.183828-1-linus.walleij@linaro.org>
 <20220203171633.183828-3-linus.walleij@linaro.org> <8f77b653-529e-4c9b-2fc2-ed49a7f53433@fi.rohmeurope.com>
In-Reply-To: <8f77b653-529e-4c9b-2fc2-ed49a7f53433@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 13 Feb 2022 01:01:22 +0100
Message-ID: <CACRpkdYcpR0br84dY29kzKUKX5csF=nPoC+_pnfvDOj5UGPATw@mail.gmail.com>
Subject: Re: [PATCH 2/6] power: supply: ab8500: Standardize alert mode charging
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
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

On Fri, Feb 4, 2022 at 3:49 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I am just wondering if we might have cases where the 'mitigation action'
> should be different for low and high temperature alerts? As this is
> going to the DT it'd be nice to be prepared for different cases. I am
> definitely not an expert here but I could imagine that in some case
> increasing charge current at low temperature could warm-up the battery
> allowing charging for few more minutes(?) May be I am not making any
> sense here so please just ignore me if this sounds like nonsense - I
> keep often talking more and faster than thinking.

It makes perfect sense of course.

I augmented the patch to account for this, and also augmented the
AB8500 charging algorithm to support the two cases, sadly I don't have
corresponding battery data from Samsung so the currents and voltages
will be the same in my static data, but it makes a lot of sense
so let's do it like this.

Yours,
Linus Walleij
