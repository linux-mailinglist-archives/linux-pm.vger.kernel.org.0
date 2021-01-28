Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755533072BE
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhA1JaK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 04:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhA1JVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 04:21:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA6C06174A
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:20:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y1so5366408ybe.11
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=l4n1xGeB/eoQiZW4Rl2+W2lroCXDsC966iYB8CktLob4be++3n5yoo46mRyZGQvoYv
         EsUb1dKaBq/WyMAdxFHxrgw/zhEBxM0Nhdy9cm603K0uTyvAYGZWGXd95O3gPAAwVdln
         /sAOyqLJvA9lpcXUBI5UoWaNBsSp6c/3JaliIvXrFSfwOqvTCteXIsyYVEeYJRga9CKe
         fnwgL72GlgGF6uyW1ogczZuRdBZwxDgaDseJwiYl5nyA2iphg6IS1tXImaRDYlTNndwh
         HvlRFzdgvNCth/4beW2fVcMyFyzqz4J/thk2l8VABszV+zfk570aLP4OYr7GTic4HvwJ
         XUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=wIBUTVGHIg6gXpFBoxosuSvN89uYeSslgY6GnwvtvqM=;
        b=b2Kx5NmsmdA8zOlI0K6voR/rWjGNmK+sC66wSZDA6v5xAxoTkVW7Wngr2YuspQYtJ8
         4aZeJR9HQYjJxRCwPk8bnEcEREiWQiA0ur5zFJSfyak8e53ghkuWGDWoOw+OauiWOrbj
         Qcdbxlcj6jQEMUVKQ5YxFR33GwYVzmgMbowzEEr1aAWrmtJCRyuFGi4Edyej8/pGB1jd
         5EbxduC+Qt9geJAAFsbyezfnah9VSJ2hZkj0bmfAiYIF4+mP9WDHVmNVeJCHdDLDoGNJ
         Q5OsgdkAYC4/c4vzsMf1dEWzN9naZ1eyQNYLIWpXdRv+g4YcsPCENDhHDh4hikUCw18z
         QKxw==
X-Gm-Message-State: AOAM533YZNPVcOBWtSmN9CUSDnIdyEstjrYeJTg9610UO9eorUIGjKLO
        pasMXGEaubLEvbF2rR89qwSeqc6PRVNgD6wE
X-Google-Smtp-Source: ABdhPJxbJKpHaIGLM5sTBziB2LVTSPNFQiF62M8WYFgVzhWb2ClelrvzQ63o1Vq/IRA66SVLZ1VCg16IE1l8BU5H
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:a5e2:e68a:ef67:8128])
 (user=josephjang job=sendgmr) by 2002:a25:ea09:: with SMTP id
 p9mr22326987ybd.109.1611825628799; Thu, 28 Jan 2021 01:20:28 -0800 (PST)
Message-ID: <0000000000000bebf105b9f266eb@google.com>
Date:   Thu, 28 Jan 2021 09:20:28 +0000
Subject: Re: [PATCH v4] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
From:   <josephjang@google.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 867157311dc8..ecd988b4a838 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7788,6 +7788,8 @@ F:        include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> The kernel/power/ file entry already covers all files in that
> directory, including suspend_watchdog.[ch].

> So, why do you think you need to add these two further entries explicitly  
> here?

> >  HID CORE LAYER
> >  M:     Jiri Kosina <jikos@kernel.org>
> > @@ -16630,6 +16632,8 @@ F:      include/linux/freezer.h
> >  F:     include/linux/pm.h
> >  F:     include/linux/suspend.h
> >  F:     kernel/power/
> > +F:     kernel/power/suspend_watchdog.c
> > +F:     kernel/power/suspend_watchdog.h
> >

> Same here.

> I think you can simply drop the changes in MAINTAINERS in this patch.

Sure~
I will drop the changes in MAINTAINERS and send PATCH#6 again.

Thank you,
Joseph.
