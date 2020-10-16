Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBF2905A7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395482AbgJPNDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:03:47 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:39085 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395460AbgJPNDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:03:46 -0400
Received: by mail-oo1-f65.google.com with SMTP id c10so593967oon.6;
        Fri, 16 Oct 2020 06:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXOrtHfg3B38qKPYgAV/eWtStCD9CCiRZqglHZ19abA=;
        b=DgIRCPFYHTYlyVbgLkY0Socz2skOgPzEUu4Dvo+tv5H3aOSQDg6yIIyfdH4Oz+Q3/K
         tKSX0hg0os64pC6CHt27motS/NrdqLkSsPs9e1ySpxiYxZl6/tOXXE/YM0II2uzrGSk0
         LPhQ8XfFQ4V4dRM/rZ9QmNCEZj942mYUuPPWfs/hF62q9+wdF4A3ay/v0n1AyT1FOq+f
         Vp/MYfqlji6dy5RaL2RoD340RHFX44mmtqfhSh4iPRcYkf5YEZOYO7HVtBI85jzNNgAy
         3k47q2rqMYnex8OYBnreQ4cdX0mBVVrCFeA8iOrURwL3yf7yFtg2tuz50l4nZkT01wJf
         z2rQ==
X-Gm-Message-State: AOAM533QSLd6E8fVx5xhU6r9laDYt1Q2rJIXlCCgVSVwEUg9TELZBWwr
        kdwDfn2I9E+KOUii0KCJkK2/lRhWSQ+YAw0S6nM=
X-Google-Smtp-Source: ABdhPJzVnEXWjd++qaEPUY44gZIVSiw7vJ0Uq2YVH5ovIdeWVuAdIBZQXhxFV5GCJsTmkl2W59VgSOxYYbkpQfKN+cc=
X-Received: by 2002:a4a:d815:: with SMTP id f21mr2706754oov.44.1602853425858;
 Fri, 16 Oct 2020 06:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201016035109.3952356-1-josephjang@google.com> <20201016090108.GG8871@alley>
In-Reply-To: <20201016090108.GG8871@alley>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 15:03:34 +0200
Message-ID: <CAJZ5v0iCgWaasL_obdYW8eC+wErCRjWCHVuKMizMr7dshTqSvQ@mail.gmail.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
To:     Petr Mladek <pmladek@suse.com>, Joseph Jang <josephjang@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, jonglin@google.com,
        woodylin@google.com, markcheng@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 11:01 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Fri 2020-10-16 11:51:09, Joseph Jang wrote:
> > From: josephjang <josephjang@google.com>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is 30 seconds.
>
> A better solution would be to resume instead of panic().

Well, abort the suspend if it happens during suspend or continue if it
happens during resume,

But we have a suspend watchdog already, don't we?
