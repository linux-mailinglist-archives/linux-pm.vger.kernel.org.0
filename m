Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91A279E869
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 14:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbjIMMzy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 13 Sep 2023 08:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjIMMzy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 08:55:54 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308D619B6
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 05:55:50 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a889485117so529418b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 05:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609749; x=1695214549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZqioEnj+HwVq8NN+2zhL9c1JfZfQIaXtHhNr7vienk=;
        b=FKH6o8N9A1f2iGXDpxQdr8tW//Zt+cwNYVynU59/jCRi1LLfzHU9mREve9GV77o8t1
         +T4HvGc8AZZkHpBAk8IZFqBhigAS93icHmgLp25lmMDsDJ4cYUEfrBmKdjnykoNEEoEf
         mUOW6W1ryLQBgzuQdVADzJsZSOmiXPMeNQBiUyRDZ1mzbmMi339K40EPkPgjH5Aev3Q9
         BuP5+eIJixr+0bL+62uKP/94lTwDXeT4IOv/d0eL2m21vrCI/VM6WnKiK0r2cszonGDc
         WcqBJiW8voeAV9X6YLNfILo/aQnlmIDeNs8wK9AqRh8Al0pcQSMx6MFJIdk0i7wrspV3
         okng==
X-Gm-Message-State: AOJu0YzSHakYlxZd4aZ4oVvnZ9JVfBGeb/bfuRmy7Zm+8JMrLZUNDynW
        lCAaudVPwo1xRU2FNPwS0udb/chTw4OoVUEb7fk=
X-Google-Smtp-Source: AGHT+IGMimonfWNwyAsTAGguZNu2dwiT0U2QJ4hptAdCME8YHhDTrFKubFqt9M+q+d15JSAvjBQdpqne1E7SoZpdyro=
X-Received: by 2002:a05:6870:501:b0:1d5:bda7:1317 with SMTP id
 j1-20020a056870050100b001d5bda71317mr2578452oao.5.1694609749501; Wed, 13 Sep
 2023 05:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230710093100.918337-1-dedekind1@gmail.com> <52419d763dbd93e91499084c2bf4c04b199857a3.camel@gmail.com>
 <33af8e4b992f766b14b3b42939f5ae7701837847.camel@gmail.com>
 <CAJZ5v0jzJTjOE4zbVnVuhegXC7+n0eu0v9vEsSVTFc37-p29zw@mail.gmail.com> <81abd4de9da3a8e93c80ef67127323e03cf779a0.camel@gmail.com>
In-Reply-To: <81abd4de9da3a8e93c80ef67127323e03cf779a0.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Sep 2023 14:55:38 +0200
Message-ID: <CAJZ5v0j2UF+UbHuYiSaemHRHgyWkvom5m=JQPwNTgkzdxpUcMg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 13, 2023 at 2:49 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Wed, 2023-09-13 at 14:34 +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 13, 2023 at 1:37 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > >
> > > On Mon, 2023-08-28 at 19:43 +0300, Artem Bityutskiy wrote:
> > > > Hi,
> > > >
> > > > On Mon, 2023-07-10 at 12:30 +0300, Artem Bityutskiy wrote:
> > > >
> > > > > Artem Bityutskiy (4):
> > > > >   x86/umwait: use 'IS_ENABLED()'
> > > > >   x86/mwait: Add support for idle via umwait
> > > >
> > > > If these 2 patches are OK now, is there a chance to get them merged?
> > >
> > > Hi, I wonder if these 2 patches have any chances to get merged?
> > >
> > > May be there is something I am expected to do have not done? If so, please,
> > > accept my apologies and give me a direction.
> >
> > I think that they were based on the Arjan\s changes that got dropped.
> > If so, they need to be rebased and resent.
>
> The above quoted 2 patches are x86 bits, they introduce the basic umwait
> primitives. They are not based on Arjan's patches. They still apply cleanly, and
> do not need a refresh, as far as I can see.
>
> I was hoping to get arch/x86 bits merged.

This is up to the x86 maintainers, then.

> Then I would send the refreshed version of the intel_idle patches.

Well, if the x86 changes are only needed because of the subsequent
intel_idle changes, it may be still better to send a new version of
the whole patchset.
