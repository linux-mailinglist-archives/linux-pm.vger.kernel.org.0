Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AECC0C3F
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfI0Twl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:52:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52624 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0Twk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 15:52:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so7192621wmh.2;
        Fri, 27 Sep 2019 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkNqoPjwgjY6Tt+/Rahv/i1baIBltWJLeHfEIQ9uNuY=;
        b=pIdGmyRtmrj8deGs8b9XvEjDoff7j4nAxZIPxMlCERwQ5HIKAJdzD/T6TPv8kkBjQ8
         8fJLgkIdLurHta/w9T2+bF4PnQxQOHK9ICXvMEiRb4eUS5wEfAPxW/E0vEYubDFePjOo
         MYdIlmHLbZwAWFsURQ6Ij4cLZfn0l41K9htfr0AQq08ngT3CudTBQzv4OYY+HZtRFfVp
         WVxZUA3GqPEC1Lynb3qW4dgVaTtZhwpLThpHRRLcgFYfy9seuEokZ7UyQRGX5FonEuVd
         LS9IMRKQkpsDh5JpQuJtY4rr5B9ayzYzkhtUZKS81+bAIyt3bnRl8Jcq61qCWAxTB2oo
         p9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkNqoPjwgjY6Tt+/Rahv/i1baIBltWJLeHfEIQ9uNuY=;
        b=i/S4fi7robtvve2jV/dy6NCpfu6u2kYeOkI58Oa+ZY4rTAgK3E3p/8z4b2vDrvjwbV
         DYjk5Jn/AO8Bm5fXF6FbkcevyLYyeCoS5b7ppAm1x6xEmQPTktwzYkByzqClELc3B0Kr
         9bi/8pCOsSKlEXAn4BELlpVyKutKhGeZTxJ/UuoImWKzUlnLanEVb195tg8XdYzdmFbN
         idUTDe44Gro7vVvNrcLi3F5xFQicpWYlWJVyqYEmlHFrOXPMmkQB2ShqGwJNYtJYTT7J
         m1B/ya06sIKNu/OavsJGfixVf62WguTeM/C+p37OtvQOnwYk+UEFV87K2hvBlRWI6Jtt
         OcKg==
X-Gm-Message-State: APjAAAXnHqFQGyb2Tc7rFbKfHlpLixcp1T2P5a1jhchXUKU4VqUQxz3v
        fT+bHIsFn5u5bz0j0upqAvJ6CbfbQwIsUq4cg0c=
X-Google-Smtp-Source: APXvYqxevkOb1sjzdjGX8J8c49Tl0KQueZ4du8zN/vMYOLsCk6glXUyJWC631XcDMIClgGupDdjjQ8xidTy5JaxryHM=
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr8400944wmk.137.1569613957236;
 Fri, 27 Sep 2019 12:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
 <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com> <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
In-Reply-To: <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 27 Sep 2019 21:52:25 +0200
Message-ID: <CAFLxGvxm77O7JnVeHjk8xMfAO2_5+PxV7QDkihL5q+86Q1xz6Q@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
To:     Doug Ledford <dledford@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 27, 2019 at 9:30 PM Doug Ledford <dledford@redhat.com> wrote:
> Because there are literally thousands of developers working on kernel
> bits here and there, and you're swatting this particular fly one
> developer at a time.

I strongly disagree. One of the golden rules of kernel development is,
read what Linus writes. Especially during the merge window.

Thanks,
//richard
