Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CBC0C25
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 21:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfI0TlY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 15:41:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44642 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfI0TlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 15:41:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id q11so2747434lfc.11
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJBm3wIiTMlbTLXcMDkNDDL26nbs1uDfiv0ETeeEYjs=;
        b=LeHqucnAee/LJ+EIK96m57dcj0RYG4Sq1r/U0YWxFvxLjIgEJn2YixNR4e9JVnma6W
         VKwPzGZ5r77StAkDCv5si2HCYWY/ODZzp9MHmduXjdZ92v9zTmg6WzWymIOQkYfSWRu/
         BprUHgbX5ryJrKBKijJz2olCNHAIiXNvec7VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJBm3wIiTMlbTLXcMDkNDDL26nbs1uDfiv0ETeeEYjs=;
        b=MgTDdIsh2alitEdNHdpaUp3NhdQH0qUVDOV7UKVoec+jtO1gEXFGQ+aJFGqxv3hT07
         1V3BuhLegTco2o1si3opAFiHHtPOBr7zTE7J+EOq6cub1oTcXvn+yS3I3a6TW6Dvm36K
         wuwGbpFHpy3XjIUn5Z5cqbB5wg9SZDYfr8oszbxHNYLk5JzTBmcbD5pQC87NORd+uoej
         3BVnjOoDzJ2f8MrOBHJHaNpgZfXWH9x0svIH9fT/OI85RK9Qul4IBanOnpwT1yy+U47t
         gYUuY7IEux0yYAKTwCdZTi527ht0wbeahWDvjw5+hGTUwNcxrXkzgP+jbXxZlmDWduur
         /wog==
X-Gm-Message-State: APjAAAXc2Igb4Ggx70SG91Ed0po5k5e3dbxi15DW0Weo0z8eJ654JDEi
        awyA1E/wJpnN32e16OUj8VqX1xQIMME=
X-Google-Smtp-Source: APXvYqyFVy2InULBZaxcyYTdD/NX5kw7kYUvHcFKTe3mGCRdnz/i+R7J9M49tjKIC2CD1HZZcmiXCA==
X-Received: by 2002:a19:f817:: with SMTP id a23mr3960211lff.18.1569613281922;
        Fri, 27 Sep 2019 12:41:21 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w17sm641909lfl.43.2019.09.27.12.41.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 12:41:21 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a22so3644067ljd.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2019 12:41:21 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr4224670ljs.156.1569613280372;
 Fri, 27 Sep 2019 12:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
 <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com> <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
In-Reply-To: <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 12:41:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
Message-ID: <CAHk-=whwYbKX1AqnOvcdT7T2GofRQqnb6xEJJ6+==ZZN1eEYQA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
To:     Doug Ledford <dledford@redhat.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 27, 2019 at 12:29 PM Doug Ledford <dledford@redhat.com> wrote:
>
> Because there are literally thousands of developers working on kernel
> bits here and there, and you're swatting this particular fly one
> developer at a time.

Well, at least these days it's also very clearly spelled out in the
Documentation directory.

And the "don't rebase" does get posted on the mailing lists each time,
and I've mentioned it over the years in my release notes too.

Besides, I actually only work with about a hundred top-level
maintainers, not thousands. Yes, we have thousands of developers, but
doing the stats over the 5.0 releases, there have been "only" 131
people sending me pull requests. Sure, more than a couple, but at the
same time it's not like this is a "every developer" kind of thing,
this is literally subsystem maintainers. We've got a fair number of
them, but it's definitely not about thousands.

I feel like I've sent that email out way more than a hundred times
over the last 15+ years.

.. and I don't think having git warn is right, since rebasing is
perfectly fine as you are doing development.

It's really just that maintainers shouldn't do it for bad reasons and
at bad times.

And "there was a conflict" and "yesterday" is really one of the
absolute worst reasons/times around.

                    Linus
