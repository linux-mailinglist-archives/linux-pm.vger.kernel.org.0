Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835585D9D3
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfGCAyn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 20:54:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41569 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfGCAyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:54:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so583784oia.8
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 17:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUV6aBfjqbRS3F7Eux3ldFh5Ld81cVPiv/AtHs/3DBk=;
        b=pNW6m4e8SsQExVtE6f2iYS5aFbN2q3B6d/7/NbCg7nFl4WgXHAfbbTz8DVdNaXFuJE
         5Hlkkuo/xkXQxwQ1XECNyRiBD/QEsGTrMqba+eWvff1iTTXF3pqIzIvbuvMXEhRxuH8s
         yntlu+qZXG/wcNQjXh+U75uKLkGe4UCT0FqahFsZ9nNJ5MfBcUQVEctktbXsBRKXJjLn
         oxFvdZS5jZO+t7pOUPRXJg9QkWDGpviWcfP4EKPUAvXbfVugfVeYNZrq8/eiSbectnrl
         ASb6nIHjKBDfIQOMrarT2LPgW5RHh0bsqCNK3TSfO51RyzPELrIBMy5pdxCCOiIc7ONu
         xg8A==
X-Gm-Message-State: APjAAAWWqMP49YdpYkw2flXiNYb8WL4bC2o1mPuIuuVK7csLcMGqdHqt
        IxQp7poNxpXrkK094nuOfmtxYD/c2U+BSA1/z+olbQ==
X-Google-Smtp-Source: APXvYqwX2NueahugFw7FOEvK1NddU40Kilw8hzMxjwXkSj0m3CfuRBSyqhe/M0on85aXctqrmM1krqe2ZXo8bTtAVXc=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr4435522oih.103.1562104901778;
 Tue, 02 Jul 2019 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561701029-3415-1-git-send-email-rui.zhang@intel.com> <1561701029-3415-4-git-send-email-rui.zhang@intel.com>
In-Reply-To: <1561701029-3415-4-git-send-email-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 00:01:30 +0200
Message-ID: <CAJZ5v0hmfUtaQGgkf0p4_xWca+unKDUTsUb-BPXGr-1f4hCWaQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] intel_rapl: introduce intel_rapl.h
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 28, 2019 at 7:50 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Create a new header file for the common definitions that might be used
> by different RAPL Interface.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/powercap/intel_rapl.c | 101 +------------------------------------
>  include/linux/intel_rapl.h    | 113 ++++++++++++++++++++++++++++++++++++++++++

Does the header need to go into include/linux?

That is, what is there in addition to the code under drivers/powercap/
that will need that header file?
