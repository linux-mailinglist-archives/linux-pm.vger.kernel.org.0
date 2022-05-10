Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B25220D1
	for <lists+linux-pm@lfdr.de>; Tue, 10 May 2022 18:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiEJQOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 May 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347142AbiEJQOS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2022 12:14:18 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8F2734D6
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 09:10:18 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y22-20020a4acb96000000b0035eb01f5b65so3250232ooq.5
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhBW/QZ9WLpe9WezLcn3aKzSucX9nibbJXLdrWe1QD0=;
        b=Q3uO0hvaemzNACMdjxoNJVZBQcjQolZ8coZpTwOBYW9FqQ/lnFZk5spW8h1reJxS9z
         pXwAb97g/kiYfYz4LyN/X7TL+IqLj8ggrJHdGlh1gZ5h734lHFv+tNwBvBXwbe6zD1wN
         PsvUTDvKJgj/fdz7ryNWu4xJ4jfLDHFhoPZGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhBW/QZ9WLpe9WezLcn3aKzSucX9nibbJXLdrWe1QD0=;
        b=1AzVQiBaJqiz+piO2f2eCSO5ywQpouo03D7TA1m6MMBNaJ7KH+FsEIIibcOtzFbNHp
         xaXNn/kdNZm12pCb4+hCd6MOGRLoQYGbmJyRX4h2fHVrMFjF3sNWDDXLNrnPX+/el7ew
         tPvpJT4gdgqAzdobU/r4UYTmM/H2l3dWH9EcpAxJzDxd1x6QgKn9d05MRC3l/i7gsrl2
         5bgwmeAyuX58pfLEC6ycnIzgt7QC4/lgwn7HF7C780R/BuM4bKhF20hNOgGrIHyZ4ELC
         C5T5kfo77fO1T3//VgudUm/9fPnOLdLztlQ2DR/Y/yRZeWJz9RL/7CHOvR/zw2KbZPzq
         OmVg==
X-Gm-Message-State: AOAM533lrEXV69didn71iWeIPr42ZIWmucgz4AYz4dwd6TS8Kdg9U9GQ
        F9n5TdX1FcGdB2pnDzz6cURFfraskYv9iw==
X-Google-Smtp-Source: ABdhPJxvY3dkdGawdd8vTcUA6B8gekmJ65TaWkuZ8AS5qun6a+WHwCSENxeYLM7InKuYZm+YCHMl8g==
X-Received: by 2002:a05:6830:90b:b0:606:3c4b:8efe with SMTP id v11-20020a056830090b00b006063c4b8efemr8102582ott.103.1652199017636;
        Tue, 10 May 2022 09:10:17 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id v29-20020a4a245d000000b0035eb4e5a6b8sm6268690oov.14.2022.05.10.09.10.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 09:10:17 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e656032735so18852055fac.0
        for <linux-pm@vger.kernel.org>; Tue, 10 May 2022 09:10:17 -0700 (PDT)
X-Received: by 2002:a05:6808:238f:b0:326:d4e1:a4b6 with SMTP id
 bp15-20020a056808238f00b00326d4e1a4b6mr373653oib.241.1652198562489; Tue, 10
 May 2022 09:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220504232102.469959-1-evgreen@chromium.org> <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <20220506160820.GB1060@bug> <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
 <20220510122927.GA19328@amd>
In-Reply-To: <20220510122927.GA19328@amd>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 10 May 2022 09:02:06 -0700
X-Gmail-Original-Message-ID: <CAE=gft6rV2LhmXAq-t4B=Cyhc14vYG_yMTiz73kW0eBchkcBKQ@mail.gmail.com>
Message-ID: <CAE=gft6rV2LhmXAq-t4B=Cyhc14vYG_yMTiz73kW0eBchkcBKQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rjw@rjwysocki.net, Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 10, 2022 at 5:29 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > One annoyance of the "preloading" scheme is that hibernate image memory
> > > > is effectively double-allocated: first by the usermode process pulling
> > > > encrypted contents off of disk and holding it, and second by the kernel
> > > > in its giant allocation in prepare_image(). An interesting future
> > > > optimization would be to allow the kernel to accept and store encrypted
> > > > page data before the user key is available. This would remove the
> > > > double allocation problem, as usermode could push the encrypted pages
> > > > loaded from disk immediately without storing them. The kernel could defer
> > > > decryption of the data until the user key is available, while still
> > > > knowing the correct page locations to store the encrypted data in.
> > >
> > > Um. Dunno. Won't you run out of memory? Hibernation images can be quite big...
> > >
> >
> > As you know, with the way the snapshot mechanism works, a hibernation
> > image can be at most 50% of RAM. If the system was using more than
>
> There used to be 50% of RAM limit, but it was removed.

I'm confused. My mental model of the way this works is that to create
the snapshot, we create a copy of every page in use. So if every used
page needs another page for its snapshot copy, isn't the theoretical
max usage at snapshot time 50%? (Plus or minus some wiggle room for
asking the system to shrink a bit, ignoring nosave regions, and
leaving a bit of extra working space).

Setting aside my potential misunderstanding of the max image size,
frontloading as much of the slow I/O work as we can pack into memory
is still useful for us in terms of user experience. I was originally
planning to include this "deferred user keys" patch in the series, but
it started getting a little unpleasant between a) having to keep the
auth tags around somewhere since they aren't consumed yet, and b)
dealing with highmem and the staging area during replay when the keys
finally did come in. So I opted to stop for now and get feedback
before going any deeper.

-Evan
