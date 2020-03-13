Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797B81848E4
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMOLA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 10:11:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCMOLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 10:11:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so10112359wmc.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTkIuFS+sGaAC8JwXfK5lVK6SYN5Se9MVMEv67XiNyk=;
        b=cJoJ3AzHZmwtZp40v4ICGMZ3Ajp7ofahUeU14HAvuKUqTyvuR8LSLilmLXPz1OKLj0
         eGkjod9Y94A1RJyiwamaaS3MsFttxA2C5yKvxv/GHnNNd84hqPWBF5lGG6mi172kLsRX
         xoPMyIR23wjH7d8/b/SAg23nr+J01v60kuwgQd8mh/eyLss8kCh2b3CNdjrM/G6lCunt
         MsVHqXH1/vRzLjef2+Ob3ISr52uNkYnouj/37RlpMpE63sX5BErPRieM3hXbQy3pnr5d
         ODhCOQfovpDUjXFEa77tR1D9LMpW5jAlBnQrBMI6vbsqV984k1QMVfCt1JVW5wsU1R/D
         wKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTkIuFS+sGaAC8JwXfK5lVK6SYN5Se9MVMEv67XiNyk=;
        b=MaDDafz82+UtDrYuSaabOmsqxImD264gdF1NySka7I61MLa3BCEGQnm4vfNmkipJ69
         CNq+ykak3RkbnlnvRL+UWJaaY3395ZJUN5WlR2S+nQQ6fjBO9ss/JoQbeQbdIENiM5pB
         SeXSPZkgTZPTxrVzi3W8UGX/OhDA//6bzoibHO1LjOssm1IiLFNqiesUh//DXZrE9Y5j
         JuSgUApF1Do3xitKr/Kr6QFXbi/vwYHnc0QKK8uHSJwrCI31Z7DtntMXZcGbu6DqxOMr
         cRDLV8rw1YPH+Zpn2muy2dQOKlZe9NhjsDU5UEr6qHL7RO+tvkNsXRONjxwZuERUJQ6a
         AzrQ==
X-Gm-Message-State: ANhLgQ0gZLxy7LEnmMvB+X+fj3oqCgDrJnP6PKZ4JffBDM995HqhtsOm
        O3RxPEAQ9WHohOjFXPTb2nKcViBt5AxcK+okXN2lcuaQOAA=
X-Google-Smtp-Source: ADFU+vubSgPtN/iCfASN0cO8puw9z3lOn8G/GuxIIUBghEfV9l49vr7BkkAFDcpEp8y0kg+5TTraf7jD1ht6FcmWgnc=
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr10437048wma.29.1584108658739;
 Fri, 13 Mar 2020 07:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000938a57059f7cafe4@google.com> <20200307235437.GW15444@sol.localdomain>
 <20200308032434.GX15444@sol.localdomain> <CAG_fn=X8UkYx5=3ARUtW3+asc+3tEdeBg=1NKS9VzChSCp33Yg@mail.gmail.com>
 <20200309181154.GB1073@sol.localdomain>
In-Reply-To: <20200309181154.GB1073@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 13 Mar 2020 15:10:45 +0100
Message-ID: <CAG_fn=U=ti=YB553DCC-_gmbiHR6=xBG4HQbyc54R3sdGCY=LA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in snapshot_compat_ioctl
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 9, 2020 at 7:11 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 12:53:28PM +0100, 'Alexander Potapenko' via syzkaller-bugs wrote:
> > > > Looks like a KMSAN false positive?  As far as I can tell, the memory is being
> > > > initialized by put_user() called under set_fs(KERNEL_DS).
> >
> > Why? put_user() doesn't write to kernel memory, instead it copies a
> > value to the userspace.
> > That's why KMSAN performs kmsan_check_memory() on it.
> > It would actually be better if KMSAN printed an kernel-infoleak warning instead.
>
> When under set_fs(KERNEL_DS), the userspace access functions like put_user() and
> copy_to_user() can write to kernel memory.  It's discouraged and people have
> been trying to get rid of uses of set_fs(), but a lot still remain, since
> sometimes it's useful to allow code to operate on both user and kernel memory.
> A common example is kernel_read().

Ah, you're right. We can simply check that the target address is in
the userspace before actually reporting the error.
