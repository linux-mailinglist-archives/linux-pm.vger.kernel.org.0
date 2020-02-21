Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5421678EB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBUJEa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:04:30 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33841 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBUJEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 04:04:30 -0500
Received: by mail-oi1-f174.google.com with SMTP id l136so925687oig.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 01:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwpPp6lpanGdRzDNVryV+TO6Hg6osjyy/RnpORcWq6U=;
        b=c11UPoMBb3mgg3eB8Zu7RgNknZGPwANHi96xPiniC488fS6xTf0C86atNVu3S89wT4
         ZDOZ9whdMdecOhmIyWb216PXd7Jg98YuqTGM+6mNz6pM0l2yiGt24lj8Zz+SeVyRX07W
         fRyHKyai9KYobex8OjnbDr/piQrsv+HalAqWMo6i2w7m79tKWVbQpG18EO6Jsi5SuV/e
         Ke0pzmLp5vMZtUM/cvHZOuUJFec5+FvyFQx+E61fROGehSNQsU7f8Oi3N1sXRj7lRKp+
         jSghKCX6/M+vNTbhpmBDXjuZRtLbEuJ4isKc4DlMU2KLU517jmWps61gHvBE1hWifNqk
         20DQ==
X-Gm-Message-State: APjAAAUkVkXFwTceNssbAPCeCipnBQTRk/aAhHFsdFutQQSUr3DV/nPM
        dfY3L4oePH2wui3E4k+Xawh27wUdDnfldzf3WL4=
X-Google-Smtp-Source: APXvYqyPjCbsWxKosuLTEYbqkVEGs0qaK1f6mfefEZOipNIY4Z8GsHNEpXxSqf1c4k0SZwyQXXRT4CHXrbuQl3UXvys=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr1149149oif.57.1582275869714;
 Fri, 21 Feb 2020 01:04:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com> <20200221084910.GM20509@dhcp22.suse.cz>
In-Reply-To: <20200221084910.GM20509@dhcp22.suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Feb 2020 10:04:18 +0100
Message-ID: <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Luigi Semenzato <semenzato@google.com>,
        Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 9:49 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 20-02-20 09:38:06, Luigi Semenzato wrote:
> > I was forgetting: forcing swap by eating up memory is dangerous
> > because it can lead to unexpected OOM kills
>
> Could you be more specific what you have in mind? swapoff causing the
> OOM killer?
>
> > , but you can mitigate that
> > by giving the memory-eaters a higher OOM kill score.  Still, some way
> > of calling try_to_free_pages() directly from user-level would be
> > preferable.  I wonder if such API has been discussed.
>
> No, there is no API to trigger the global memory reclaim. You could
> start the reclaim by increasing min_free_kbytes but I wouldn't really
> recommend that unless you know exactly what you are doing and also I
> fail to see the point. If s2disk fails due to insufficient swap space
> then how can a pro-active reclaim help in the first place?

My understanding of the problem is that the size of swap is
(theoretically) sufficient, but it is not used as expected during the
preallocation of image memory.

It was stated in one of the previous messages (not in this thread,
cannot find it now) that swap (of the same size as RAM) was activated
(swapon) right before hibernation, so theoretically that should be
sufficient AFAICS.
