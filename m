Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61F4166422
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgBTRQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 12:16:29 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:37354 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBTRQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 12:16:28 -0500
Received: by mail-il1-f194.google.com with SMTP id v13so24328154iln.4
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGI4ZH0DU8aHO9nNniE5WRLgtSUtlx4p2LoUqqkDqAw=;
        b=o6KBQw3tzkTc6yXRtzpHDxT0cumt02XwKR5Vd6072iHdJXK1ZDzJOol/gBCNv2dexK
         LbHWWGTw/cPo8gHZu9QuP04rQ+TlluDuVN+AFr+vubid7A/+zZvo1yiciSBDjoQIYxV1
         H59P3JVSF4BYYXZANZzZvs/u4pHrhmdvf9HBQmXdgPwk3PuTwITNYV2a7vLn1NAwLfkQ
         PAQVp+pQuAAZ0BUhApNKsCnoWUZg6km0pk3BrhR6eYbQdT0AfiyMEsMsmPNFQzk5pGfC
         imbMIGTMrWpFJdsj89UE6feyHUrA0rbL1cpowr7JVgFkyIBG9MpI1L4dUkxw9amdpCHE
         kgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGI4ZH0DU8aHO9nNniE5WRLgtSUtlx4p2LoUqqkDqAw=;
        b=hM0sJ/B3Tzt50NxZN2inYa7i5Tslsu5JenCRqpi+snh/UrGqn8TmTEtdcTAF8i600r
         iA7DIPwluBEPUO5xk5cbiB/WmaGvTvlaeTzzOQ0OD49KwYImW/9CPRdbv6uqkf/evpJ0
         fVYT6BOXWyVhcx628Y+E6D/3xjgM4gSfUlen1kvMpSX6A0h5EtZL1B7sfZ+4mhzZdUVJ
         CHjE6i6HHxKLI5g6hO0yMycKnlNsJXxYvADmFe0E72Z2s5c/K1qQzyulrN8oJtsoEq8D
         rnYtMF6D9GbIEJdzjJrwILxpvyCaeV15lKwFVP7OeJSjAZ7FimyJRV2PMV588qg6jbyN
         IW3g==
X-Gm-Message-State: APjAAAXwXgIAnMMaFUSfm7KBZsNEmalh63o/4JDIKgHHc5P4l6zpmIga
        M73PSY9aCcA+r1Ircj5CUplBEKjPEHreGwekni6pnw==
X-Google-Smtp-Source: APXvYqxHadhtfe835KKRHQxq80OQhhIBJ6ibIuxbD9uZQd8Hfld9kR1QEQho6ZgOC1h9PYOqkiEgZ46Oq5sIIK8rgjc=
X-Received: by 2002:a92:8dda:: with SMTP id w87mr30073572ill.55.1582218986252;
 Thu, 20 Feb 2020 09:16:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com> <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Thu, 20 Feb 2020 09:16:15 -0800
Message-ID: <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I think this is the right group for the memory issues.

I suspect that the problem with failed allocations (ENOMEM) boils down
to the unreliability of the page allocator.  In my experience, under
pressure (i.e. pages must be swapped out to be reclaimed) allocations
can fail even when in theory they should succeed.  (I wish I were
wrong and that someone would convincingly correct me.)

I have a workaround in which I use memcgroups to free pages before
starting hibernation.  The cgroup request "echo $limit >
.../memory.limit_in_bytes"  blocks until memory usage in the chosen
cgroup is below $limit.  However, I have seen this request fail even
when there is extra available swap space.

The callback for the operation is mem_cgroup_resize_limit() (BTW I am
looking at kernel version 4.3.5) and that code has a loop where
try_to_free_pages() is called up to retry_count, which is at least 5.
Why 5?  One suspects that the writer of that code must have also
realized that the page freeing request is unreliable and it's worth
trying multiple times.

So you could try something similar.  I don't know if there are
interfaces to try_to_free_pages() other than those in cgroups.  If
not, and you aren't using cgroups, one way might be to start several
memory-eating processes (such as "dd if=/dev/zero bs=1G count=1 |
sleep infinity") and monitor allocation, then when they use more than
50% of RAM kill them and immediately hibernate before the freed pages
are reused.  If you can build your custom kernel, maybe it's worth
adding a sysfs entry to invoke try_to_free_pages().  You could also
change the hibernation code to do that, but having the user-level hook
may be more flexible.


On Wed, Feb 19, 2020 at 6:56 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Also, is this the correct list for hibernation/swap discussion? Or linux-pm@?
>
> Thanks,
>
> Chris Murphy
