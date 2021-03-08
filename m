Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C77331307
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCHQKj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhCHQK2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 11:10:28 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52107C06174A;
        Mon,  8 Mar 2021 08:10:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w34so5625195pga.8;
        Mon, 08 Mar 2021 08:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLihrFP9ef1intAZ6HuUoGTvydum2h7Yfm6pyCMQ/Kc=;
        b=G8LMTF5NbwNMrQ4dIzlJFLr2P681NNL8dsdxSPUw94bm5nyHoSFoOyb793Ivhr/qjL
         rzDFg5GntR3fQgwgeLWoPy1P/rOWIri7EAW5ERwdr0nZOU8roWBvzYmO7xRYAJE8Scf4
         32D1seigYgZi6xv/whMWo5yTlSomF95QOhtab3RoYYNYJwAXybaANKA81V895VY3clBv
         ZhfsSqg/5euJQfiLa6xryXtabc4L+wob7A2zKqYx1SMdn3SwykxRwESq5p4hk1YpMj4Y
         Pbvvlay1A9d8b3zg27f8/fSbw841CYffWWf9HNhwaULl3F+3AGqhJbHZ5CVTSfyVHlid
         ViGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLihrFP9ef1intAZ6HuUoGTvydum2h7Yfm6pyCMQ/Kc=;
        b=PVGlVIjvKA05yOCqkkdvteGALPh0BQcKsYzbqOsvEJkZfd2aJzcZGRVwtXWF/Tdl0W
         pfrXrbGwZSupLlJZrZ8ioyFdYwyv/xuP1Td29EmE3WazDyJetRUcy9A837qw1s4m7RXb
         T8QZvvhJ3Ptzbah7c8v7RD1Iz6HCksC8AJVZRwALgFQNo9+QtOOjin13FNnlo3BbRBpA
         Kxuj4Z6Lz4hvj3NsoetE7heulQjsssBRhNT12SqLQ5lHseuDqHZvHLORkHeV0TCEQS5j
         MU0AlyTFHP7G6m78HXJlM2iPEZoOXT8jj9x+XjjQM/85PPWxXfcfVB1AxEksAc04bidr
         QtIw==
X-Gm-Message-State: AOAM530BBiASKuNePFxBK8VIDT9Igsj+MyChQ1IBQj5serbCLHk3w7kP
        GeRmY29qHOm+/AHhmIWU6hPhSWRUJuDW9fJwNhY=
X-Google-Smtp-Source: ABdhPJynIPsr6KzP+Tw3Jc7eZEkg8opYtFCVOE/lnnQs4Nquj9YZ5DuYXQ4VIaD3QOBtuRvHr5QXeGjZLwJBRhdvQk8=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr6108239pfb.7.1615219827872; Mon, 08
 Mar 2021 08:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20210308152935.2263935-1-arnd@kernel.org> <CAHp75VcMAWFCOFEXizuOvDZs=qDSYndH=Y9RhgLdjb9547Op+Q@mail.gmail.com>
In-Reply-To: <CAHp75VcMAWFCOFEXizuOvDZs=qDSYndH=Y9RhgLdjb9547Op+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Mar 2021 18:10:11 +0200
Message-ID: <CAHp75Vc0dgD0m12BRzjv=Ldn0hxxY3geR8HswgwoMeYBz_fVFA@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 6:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 8, 2021 at 5:29 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > -       depends on EXTCON || !EXTCON
>
> I stumbled over this.
> What is the point of having this line at all?
> What magic trick does it serve for?

Okay, it seems I can answer my question: it requires extcon to be
built-in when the driver is built-in. I often saw similar written
slightly differently.



-- 
With Best Regards,
Andy Shevchenko
