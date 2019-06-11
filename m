Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C85A3D436
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 19:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406167AbfFKRb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 13:31:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38461 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406313AbfFKRb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 13:31:28 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so9583356oie.5
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2019 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onSxjW8NTTwxP5NQ7rSvYJbGq68gJmKN12jMDLgrnNg=;
        b=ZETIN52RFdLuQ+alygewukdj5SI5ByxHUuicAy/O9Ggca8TKrfuJB2dYxm90NHhYCs
         VJidK42y/qEtqHsUk8MxzxHmONQszRC6NW4NUqb7vgX/grHgMEjZkYztryUv4g3BFOYA
         SFbBvwEa0sMMkeeb9pjnB0HAeZkvoIVWu6czrBBdpFgZWvz0A821qkHUpfxMguGUfA6A
         tiaFWKsQ1nt4LMTWBxsuEZB9GnD7Jp8gnInnH+v1rOorYeL34u5oSk/f3/cE3AnTD5Eb
         x60s/4UNJfTntT6G21Ps0lzg2D7+jnCPPtktYcJUlHDr5+G6wa0uxcgci32pmCBAsILB
         hdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onSxjW8NTTwxP5NQ7rSvYJbGq68gJmKN12jMDLgrnNg=;
        b=E0KSEZLvgi29TTe84vFGfK1r6oQuPADZLssvWsSsXGfIKS0bf9EqLy0nUqJ7atetPC
         vTtvUsEqseswzh9k75MsRXPtyXhE9xELdmySlJ9+hikrJN8AHUr7XzGky0YutT9PPZti
         7nt1QxcJOixXgPqaB3pPDpQVFp5NrAKw4TELnmw9mcdEIQYdWUysmkxTRdk94GQ49xnc
         2+d6LqI0lVvmgQ1BSKRVnyMZaxASuD4Hm522vKOTKQBf7JkmE7abkiCsToR9KzhJe+s1
         Qwsk2LA+mtZxPFNgeolkKWvYQYkfm1DpTe//J9jdx7nvvAwYdbu7IYLnu4PRWEjOZKtj
         ULJw==
X-Gm-Message-State: APjAAAWLyRx9WdsgnScI9Kjn+xwn8xRaEtv9gBHRI9O8JWPzTKp7dMT5
        VIuKztR905YJ2Uz7/I7TKmyt3xN200gU96PA3CFfmw==
X-Google-Smtp-Source: APXvYqyzH3BD08OV6iyCS/eTfgt2LadFZq8VlER+5qqSWj3k991GUsVyyUcnqJrf2SvnFEZcBibn1Qj6fZVA7nVU+EU=
X-Received: by 2002:aca:5f84:: with SMTP id t126mr16612374oib.18.1560274287559;
 Tue, 11 Jun 2019 10:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
In-Reply-To: <CANA+-vCThdRivg7nrMK5QoFu8SGUzEVSvSyp0H2CPyy9==Tqog@mail.gmail.com>
From:   Tri Vo <trong@android.com>
Date:   Tue, 11 Jun 2019 10:31:16 -0700
Message-ID: <CANA+-vARQ9Ao=W1oEArrAQ0sqh757orq=-=kytdVPhstm-3E9w@mail.gmail.com>
Subject: Re: Alternatives to /sys/kernel/debug/wakeup_sources
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     Hridya Valsaraju <hridya@google.com>, linux-pm@vger.kernel.org,
        kernel-team@android.com, Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 4, 2019 at 5:23 PM Tri Vo <trong@android.com> wrote:
>
> Hello Rafael,
>
> Currently, Android reads wakeup sources statistics from
> /sys/kernel/debug/wakeup_sources in production environment. This
> information is used, for example, to report which wake lock prevents
> the device from suspending.
>
> Android userspace reading wakeup_sources is not ideal because:
> - Debugfs API is not stable, i.e. Android tools built on top of it are
> not guaranteed to be backward/forward compatible.
> - This file requires debugfs to be mounted, which itself is
> undesirable for security reasons.
>
> To address these problems, we want to contribute a way to expose these
> statistics that doesn't depend on debugfs.
>
> Some initial thoughts/questions: Should we expose the stats in sysfs?
> Or maybe implement eBPF-based solution? What do you think?
>
CC'ing some more folks.

> Thanks,
> Tri
