Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A913233E
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2019 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFBMU2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jun 2019 08:20:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34515 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFBMU2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jun 2019 08:20:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so932374lfa.1
        for <linux-pm@vger.kernel.org>; Sun, 02 Jun 2019 05:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8XJjbcSeHXWyfrm0lZNaxFevNGN/ntRWhil7kOzvQw=;
        b=cpm9Wahqojbpp4VkjWfrSzKQi0a2ao6+Snhc7Rw0Q7G2cnlWl4NN+SpMBNDiynHStQ
         e+MwKcJW+v+aBPTP2CMVHQ+2Z75W4hXURUexykVjLm+sx6J//Q5pTVNwqTtc92n26m9x
         wUI8z1LDwo3dz8mT0g1ckf93t0vtaHtsUBp88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8XJjbcSeHXWyfrm0lZNaxFevNGN/ntRWhil7kOzvQw=;
        b=gaH6oAM4ljzcuGQscnAsK8P3Fpm7C6dibJXiB6Wl5f8AOnBXeOuketODn8S/ZpkbyM
         ncMGu0rbBoK3/L08SnE5nBJmzcnYWv+N4a3/AN1IAo2CEh7mb+VHjLUwr/BCTz6Njwzw
         pDtWpuCIKshIp1crc83TtFO+o7nH5Thqu0FANPWMwmvgOEx1LGaD8Q3Prr+uynulYiug
         ZqkrZyoa5fuA6f/3LLsHHFR6iuuh2CQr3AQshmACXslTn5XNb5t+LwgwcphXWgRb8FHZ
         gGxTbp2oQ6xeTU7/ajyVKRLSIxGKdOJWmlYQrGNxitNvHYEYyyGlKHqOEXfsvbckDTE7
         W3Tw==
X-Gm-Message-State: APjAAAWUzq1DfDnwYD968Uh2u6hQTlFVLcKqogaAtwE3DYPaV/pwLeP3
        cb0n5jpal+P55p4RlG7Fy1Cu4ehaki+vg+TN4bsxJw==
X-Google-Smtp-Source: APXvYqxoUeTRSI6CtltHxEsRlYpiPonozfm3ENUzJsZRTMHK2FWCrZ71nbqlV68IH4IhR7parmAXCyudOrYXvzl+KNs=
X-Received: by 2002:ac2:4544:: with SMTP id j4mr10895112lfm.176.1559478026242;
 Sun, 02 Jun 2019 05:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190601222738.6856-1-joel@joelfernandes.org> <20190601222738.6856-3-joel@joelfernandes.org>
 <20190602070014.GA543@amd>
In-Reply-To: <20190602070014.GA543@amd>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 2 Jun 2019 08:20:15 -0400
Message-ID: <CAEXW_YT3t4Hb6wKsjXPGng+YbA5rhNRa7OSdZwdN4AKGfVkX3g@mail.gmail.com>
Subject: Re: [RFC 2/6] ipv4: add lockdep condition to fix for_each_entry
To:     Pavel Machek <pavel@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neil Brown <neilb@suse.com>, netdev <netdev@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 2, 2019 at 3:00 AM Pavel Machek <pavel@denx.de> wrote:
>
> On Sat 2019-06-01 18:27:34, Joel Fernandes (Google) wrote:
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> This really needs to be merged to previous patch, you can't break
> compilation in middle of series...
>
> Or probably you need hlist_for_each_entry_rcu_lockdep() macro with
> additional argument, and switch users to it.

Good point. I can also just add a temporary transition macro, and then
remove it in the last patch. That way no new macro is needed.

Thanks!
