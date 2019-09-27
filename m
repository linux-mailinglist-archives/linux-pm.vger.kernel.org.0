Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D93C0B3E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfI0SfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 14:35:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfI0SfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 14:35:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so3465016ljj.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfo/aCWS6InNpF6+CbMoDQhZTwhAvaIIzwPXAG1ON2k=;
        b=PmjiZGWIuux93oBdsbKTUcDUjOwRzdmDhCW+izQNooViyiY5zi7nNI8gmKybNudXez
         mSBXzQfHIJMk7J54/kR1Q0FTZiLQo2TdURWv9EPGoNG5dafe9qzlnG0ZSVDkNphLEhzj
         OpxYIyiGR1+Yl9vS9XQTRr2D9CYcY+0rTw3LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfo/aCWS6InNpF6+CbMoDQhZTwhAvaIIzwPXAG1ON2k=;
        b=ET5xDCnuWrNZItYnTraW+PMdyqh0mdrwSelhutPxzejVYD96wrBL0/9Kpbn2ThSkk+
         xFd6ZDdDEHU0Bedi/pPnBBtL6ma33vRdZsOGnMVX+ECSoQ3mpQrVmgUmolC9fpIPY716
         KvJlB2KZQwARJxQIwWdvhazyGXc1FVaWAtJbZ0RydpcFEZ78cUtRPv34Mj9hpY15Uunc
         w0BEnQdAr83vnLzSTul+zv16j9hsTcsvl9CDBWmQHLniULwRf1bEVobY/92lK6eRg7Oi
         k68s/wleU8dzpLMzc9kPhprgpvudxBfip137OIuyGDZLj0re47VkBvQtrapOTSuD4kpu
         1KGw==
X-Gm-Message-State: APjAAAV42RpXGUwhv20LgFs0HOVoSTN4MhSW386daquTGf2RTfZaivts
        I0LauKDWj4TxRaG3vAE1vGqrKyRzINI=
X-Google-Smtp-Source: APXvYqxm1ALJIqfDtB270C4+631xISEcSx8ScvGNWWFFDdVhW9tx9pZ+BMyCV9zu1L0iiUM7FtHutg==
X-Received: by 2002:a2e:2bda:: with SMTP id r87mr3867516ljr.3.1569609313896;
        Fri, 27 Sep 2019 11:35:13 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x30sm606611ljd.39.2019.09.27.11.35.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d17so2633152lfa.7
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr3700375lfk.52.1569609312334;
 Fri, 27 Sep 2019 11:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
In-Reply-To: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 11:34:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Message-ID: <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 27, 2019 at 6:08 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> One thing to mention is that, all the patches have been tested in
> linux-next for weeks, but there is a conflict detected, because
> upstream has took commit eaf7b46083a7e34 ("docs: thermal: add it to the
> driver API") from jc-docs tree while I'm keeping a wrong version of the
> patch, so I just rebased my tree to fix this.

Why do I have to say this EVERY single release?

A conflict is not a reason to rebase. Conflicts happen. They happen a
lot. I deal with them, and it's usually trivial.

If you feel it's not trivial, just describe what the resolution is,
rather than rebasing. Really.

Rebasing for a random conflict (particularly in documentation, for
chrissake!) is like using an atomic bomb to swat a fly.  You have all
those downsides, and there are basically _no_ upsides. It only makes
for more work for me because I have to re-write this email for the
millionth time, and that takes longer and is more aggravating than the
conflict would have taken to just sort out.

                   Linus
