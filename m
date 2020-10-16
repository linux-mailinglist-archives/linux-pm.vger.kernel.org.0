Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB92907EC
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395303AbgJPPDz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 11:03:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44099 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394520AbgJPPDz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 11:03:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id x62so2730001oix.11
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 08:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvKNDh6I4BKSJihzujhmJmygiJ14PFvVW4+XgyhLFnM=;
        b=Oj+7GulhE9Ojf3KU+VACQWCNrmJbNFH/+h4uKVnyeTd3gwfrTiU4P7Hd1O2nTjwra1
         gwjUJeLfjmsdJNoEdDrxj+6VMqt7xd3IKTuvHADMANW5SatQ4uK9wKJqglOkNbQpcwDz
         20SaEW/UygGkaeO4dX75eajoXxaDzgZtOh/wZguxQriZNrDZtiHRakn3cz20IYIh4KBE
         25V3uuPOipGOeOzql20aYtABynZYr5Ww+d8VEhaii/qiAWuVA9xyURMz7BiX+lNXYV8f
         7NWRnJZMLwa53vbiOmgtuwYWk9Ny1TvSbbNmgElfdxS5uM7IUfT5JOOBXAL6m51oE7Ko
         n0Jw==
X-Gm-Message-State: AOAM5332iWC7og0IVxOjusVzbDGuJEKOD6ew4nTG+E5PiFNPc1Agnd1d
        mOPzGO6jo3zcBfvi3BzIe/+PZziByW7XG9j2oh1qc321
X-Google-Smtp-Source: ABdhPJzjsJmyDxB9GaIVaKc/9qnmTHJX2ZkZrnUvsFrMJDOBVe51LG5zlUwxU969/bjO35sqi8CCsxGIZerF6mODCKE=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2776696oii.69.1602860634890;
 Fri, 16 Oct 2020 08:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201001092852.124740-1-ulf.hansson@linaro.org> <20201009125512.v5dx4lrlpjv55awe@bogus>
In-Reply-To: <20201009125512.v5dx4lrlpjv55awe@bogus>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 17:03:43 +0200
Message-ID: <CAJZ5v0htiOE1Dwqwxf1gNs+QYm2We71sF9Hu3aUNK5WCf8YUaA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for cpuidle-psci PM domain
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 9, 2020 at 2:55 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Oct 01, 2020 at 11:28:52AM +0200, Ulf Hansson wrote:
> > The cpuidle-psci-domain.c is not listed in the section for the cpuidle
> > driver for ARM PSCI. From discussions at LKML, Lorenzo and Sudeep prefer
> > that we add a separate section for it, so let's do that and add myself as
> > the maintainer for this part.
> >
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as 5.10-rc material with the ACKs and some edits in the
changelog, thanks!
