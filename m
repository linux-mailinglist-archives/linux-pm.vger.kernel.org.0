Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D814530496
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 00:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfE3WGU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 18:06:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39838 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3WGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 18:06:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id k24so2077564otn.6;
        Thu, 30 May 2019 15:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mS/ULbrvznIqIBah+sjqhJbkEnUKlNTyCEQKdcPdFxU=;
        b=J5d/aCCaD5Cghrm6JPfOau+A0FzAzaM61fAOljfhHfMbD5eNg5hge6arUigcOsZ+Dm
         yuh+DLlhxli4wIy4t9MoiFpVVTIw2dmP/iloPvyCSNE3w4n6yBoUSJ6jtjLyYczTuMYs
         rWaqerrbtMjNXHc71ie4u9wdqx/CrregswVDCa5hwyxMOeoayNpYuOpP4vWlrGjfRK9p
         Qo5N/THuwrHTK9KrhzjHUHUhgxSbe7RUVzAgYkoWtt3uG2khOwW+1+H2NAsPoTZ1gSAL
         C7ZcgHYHdHTt9bL5yv0tJ77NdHtHY1OSjnYkBsCgppSCMXIBdoi6HEq7jTSLD3/TgUcG
         H17w==
X-Gm-Message-State: APjAAAUSgoba/dqTgJRrt+QixzrrLmkrTGSYncb+FtxWPRJNdzsobifT
        St+bvcCP/hpdxLTVjfeL+F+veIwzn1qhFEJf3iS0eQ==
X-Google-Smtp-Source: APXvYqwNTMv7O+pOK5bKS1YKsS1yWwjHs1FZ2Z/zSggvLAm+F6SvH5rvjMNqRjMo0cR0/tATH5zm1wW4v46N/ECPnyY=
X-Received: by 2002:a9d:3285:: with SMTP id u5mr4582299otb.266.1559252343151;
 Thu, 30 May 2019 14:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1905282326360.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905300007470.1962@cbobk.fhfr.pm> <CAJZ5v0ja5sQ73zMvUtV+w79LC_d+g6UdomL36rV-EpVDxEzbhA@mail.gmail.com>
 <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1905301425330.2265@nanos.tec.linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 May 2019 23:38:51 +0200
Message-ID: <CAJZ5v0go1g9KhE=mc19VCFrBuEERzFZCoRD4xt=tF=EnMjfH=A@mail.gmail.com>
Subject: Re: [PATCH v4] x86/power: Fix 'nosmt' vs. hibernation triple fault
 during resume
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 11:27 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 30 May 2019, Rafael J. Wysocki wrote:
> > >
> > > Cc: stable@vger.kernel.org # v4.19+
> > > Debugged-by: Thomas Gleixner <tglx@linutronix.de>
> > > Fixes: 0cc3cd21657b ("cpu/hotplug: Boot HT siblings at least once")
> > > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> >
> > LGTM
> >
> > And I would prefer this one to go in through the PM tree due to the
> > hibernate core changes,
>
> Ok.
>
> > so can I get an ACK from the x86 arch side here, please?
>
> No. Is the following good enough?
>
>     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Yes, it is, thanks!
