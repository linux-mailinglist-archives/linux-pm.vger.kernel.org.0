Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE51980D2
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC3QSz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 12:18:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35846 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgC3QSy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 12:18:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so16178107oib.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 09:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfE74zLiZg+xrx3FvqZ/j+HBsHlEv6O/xxR+I/7ZTsE=;
        b=Q4k0qN1sIOzhhsBRr7bwQjw7SDD6NKuoqcjleBHKUIxC9/P59aC8Pus7VEVtq0eslL
         FqMIg9NNzTEerskeyFSxlOy7jlnQckLv0Cg0StkTZEuBO56Ojd+wQhQTID5Q7htHaMzc
         KMkjAMGGmQSJz9YpIJ5VuTayuC3moeGoem1XhiwCRHMFhtq1f/HTT0ipARtl+O+rMPVJ
         6FooPPK5HGe0JrpRa8Xl+kN0mbU7MV701vh0YFmqmzkbfvQfWvTyn7i+Rf4k2MMl3hsO
         4CxDJo5Sv9d4b3oHOSQHvlseMX6NPXmzKjwYQd4WMfsC1Obt4TUZ7UDAwP+tkOBvZlLD
         BBFQ==
X-Gm-Message-State: ANhLgQ2hHxqIvb70NBAR5g3SQ+fQSdeZuSf02zaJds688H2ySsEQnQxa
        hC48DiKjaPIiAJMJxjiT0BbXI24GfFcLGDvL9Qk=
X-Google-Smtp-Source: ADFU+vsxC68jKwGAYQHNv/eComvYxUYuQVtTiALDOtrzH8GQ+5Q4bUpiC2X4ti3M8iKiycljzMU3JwFHujO/vJO9IFY=
X-Received: by 2002:aca:5155:: with SMTP id f82mr47894oib.103.1585585133940;
 Mon, 30 Mar 2020 09:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-Ga+e+LYW42jR3nGt+p8mxwT92Q1EwJvSrJpXHWbNA=shiaA@mail.gmail.com>
In-Reply-To: <CA+-Ga+e+LYW42jR3nGt+p8mxwT92Q1EwJvSrJpXHWbNA=shiaA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Mar 2020 18:18:42 +0200
Message-ID: <CAJZ5v0jdf_Scdnm=WT0Q3swZ1QA-BbBzc_=dndSe5y3Js59-=Q@mail.gmail.com>
Subject: Re: suspend to ram order of operations
To:     pdev embedded <pdev.embedded@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 30, 2020 at 11:16 AM pdev embedded <pdev.embedded@gmail.com> wrote:
>
> In reading through the archives, I found the discussion of sys_sync()
> and making the call optional, but I am still searching for a discussion
> of why the operations are ordered the way they are.
> 1.) (optionally) sys_sync
> 2.) freeze user space
> 3.) freeze kernel threads
>
> On an embedded system running Android where there are user space
> processes (not under wakelock control) that generate a lot of IO,
> freezing user space first helps reduce the time taken by sys_sync().
> I believe this is because buffers are no longer being continually dirtied.
>
> What was the rationale for the ordering of operations when suspending to ram?

The freezing of user space and the freezing of kernel threads were one
operation to start with and filesystems could not be frozen before
that.

IIRC, nobody argued for an ordering change, so it stayed the way it had been.

> If there is a lot of user-space filesystem activity, would
> it not result in fewer dirty filesystem pages if enter_state()
> ordered the operations as:
> 1.) freeze user space
> 2.) sys_sync
> 3.) freeze kernel threads
>
> What am I missing?

Probably the fact that you don't need the sync at all if suspend is
reliable enough.

Or if you want to be extra safe, it is better to trigger the sync from
user space on a regular basis IMO.
