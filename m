Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72BA1679B0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 10:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBUJrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 04:47:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgBUJrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 04:47:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so1217128wrq.10
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iThJ2IqXIL3xfKQBGqdwkNTDMnV6nWu1wNuJBy3C2yA=;
        b=cqap6/WfWMnCEnkhHmZmkagcfjvNYNyFShE3gD4elanhFQa3ZJ18KHndFZ1SNIca8i
         1m2/ZTDoRDe2K8Y9RXXAOCQHkuJ/IqgFIJUe3I3WBgA6OqX218zpWiUMioei7hsk+JB7
         O6G5mYbEYFAFL1hBcxU84i3c/oMzKRtzX8mssXGCIguaZDPbpDo4dpKj0tkubxvCXVCl
         U0zUZ+8eZY2ZhPG5hr20uSgeNd3DP3HSTGJpzHFvKDAUO8pj+F5fq8+JlnIE93cpB18C
         AfDM2rTvncFLyVMmz/uGQdfE0r59pSocWGTYibMdnWGtcUf+PZq88MwcicBJZa6ZEvZ6
         0DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iThJ2IqXIL3xfKQBGqdwkNTDMnV6nWu1wNuJBy3C2yA=;
        b=q+420+/6XHVcvdpLjUbAt8Tbupc2OLSm9xQ24kB+VGLLqryog8gj8MdcKZ7GS6e+jU
         mWGeF3hv0eV17cdk7CvvBdAt9AxXUlFWFFdF+ThTsXt0LFsA5yXgSw+f/ZNTriI57LqV
         1WolQTm5lQy3aSfRcxbCGzMXhol8nBYceTsAH2gIcFXAkCRrRMkhScvdMw1niGfGY0pz
         vQjsOi2Phzy4FcP1+082fyi8Z8nFZX31DEwoQeCx3ckomzHjF94QbFAixRPUkbeTPWYp
         i3E8qevBuPHFJuBrNcj0QDUbyuGOkM+YUAN5Mnh8dr/2T0/cSUb55h2e1lHL3akQbDC9
         5rSw==
X-Gm-Message-State: APjAAAV5tlFhbC1TASDE6E2YThZI7ptGoyKNULX0P6mFEg1e4FHJUD9p
        uhZs4XbdrRwIOC3vtRb73vdrSE5cEBPfwqoGBhZ6ZQ==
X-Google-Smtp-Source: APXvYqw0SbueTOfivperUQxsM70eayKJ8KOMv1BZWQPaWv8uZB7Ikvrrl4u6etBH7HmFzINwCm4AukPxAoxEyFaCrLo=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr47066785wrr.65.1582278427240;
 Fri, 21 Feb 2020 01:47:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTPSC8666h5fuW=iSaVvuRq9to731W2-sAT6xUuESAzsw@mail.gmail.com>
 <CAA25o9TvFMEJnF45NFVqAfdxzKy5umzHHVDs+SCxrChGSKczTw@mail.gmail.com>
 <CAJCQCtQw7EJwREM8Fy_PWCwy3E7Jc=kLTRo_kgLNwNhYA32ABA@mail.gmail.com>
 <CAJCQCtQkK+J-6eoadBLr+CkJ6CLf3Kt+6CeTJANRiU+M7A9CNQ@mail.gmail.com>
 <CAA25o9T2wwqoopoNRySdZoYkD+vtqRPsB1YPnag=TkOp5D9sYA@mail.gmail.com>
 <CAA25o9SCanFH3nV52BwN=7EuSUFjX=Jrd+FCiV=6ThW=beKKMw@mail.gmail.com>
 <20200221084910.GM20509@dhcp22.suse.cz> <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5MnpK9YjO+Z7_M1Cj8tup4qPriALx-EHt4ypbmCWfUw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 21 Feb 2020 02:46:51 -0700
Message-ID: <CAJCQCtQ1FrAZpBbXPXcJwb4eTaCH5j9+gCStrX_hKwAEoLSK-g@mail.gmail.com>
Subject: Re: is hibernation usable?
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Luigi Semenzato <semenzato@google.com>,
        Chris Murphy <lists@colorremedies.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 2:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> My understanding of the problem is that the size of swap is
> (theoretically) sufficient, but it is not used as expected during the
> preallocation of image memory.

Right. I have no idea how locality of pages is determined in the swap
device. But if it's sufficiently fragmented such that contiguous free
space for a hibernation image is not sufficient, then hibernation
could fail.

> It was stated in one of the previous messages (not in this thread,
> cannot find it now) that swap (of the same size as RAM) was activated
> (swapon) right before hibernation, so theoretically that should be
> sufficient AFAICS.

I mentioned it as an idea floated by systemd developers. I'm not sure
if it's mentioned elsewhere. Some folks wonder if such functionality
could be prone to racing.
https://lore.kernel.org/linux-mm/CAJCQCtSx0FOX7q0p=9XgDLJ6O0+hF_vc-wU4KL=c9xoSGGkstA@mail.gmail.com/T/#m4d47d127da493f998b232d42d81621335358aee1

Another idea that's been suggested for a while is formally separating
hibernation and paging into separate files (or partitions).
a. Guarantees hibernation image has the necessary contiguous free space.
b. Might be easier to create (or even obviate) a sane interface for
hibernation images in swapfiles; that is, if it were a dedicated
hibernationfile rather than being inserted in a swapfile. Right now
that interface doesn't exist, so e.g. on Btrfs while it can support
swapfiles and hibernation images, the offset has to be figured out
manually so resume can succeed.
https://github.com/systemd/systemd/issues/11939#issuecomment-471684411





--
Chris Murphy
