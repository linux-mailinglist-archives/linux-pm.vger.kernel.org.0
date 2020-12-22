Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B882E0E6F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLVSxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 13:53:16 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:36583 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVSxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 13:53:15 -0500
Received: by mail-oi1-f177.google.com with SMTP id 9so15783071oiq.3;
        Tue, 22 Dec 2020 10:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnzMKZJC9bjmZCXHwrKg45wf6KEcS3z4p+ec+cH91Dw=;
        b=HxK/6uszxbaZJoY7jfNDA16c+cz8ywuQj+0z92TQmChmrCmuynusOv74uOpYFO6rA0
         H+qp8FViX2Zyvs32jJysRnDZhBU5o9ymUKfLVVCaVKV/hgb+EUSUeL4Bjgw/Ql72z3SX
         QmzgEbx/2u6J/d8Tz/HAKkAf3iXCHeNPQ+AbPHiCBykYvQgbI9v+lCz7sdy7oJ0N3f6p
         Rt05ks7aLIc2UBe8EOTZNbKJzpdt+0ZUhUAdff4tBn/1NpzmXcVRMz52Q8/dGJHUkoag
         4X2+IZSQ21eNULRoJChSAzcBFeG81E7gkfiKibFVqN0j6Sm09+5AzDNO+0gSM5C63U1z
         K5MQ==
X-Gm-Message-State: AOAM533vP6Donms7QqTv7/7elq0nlEHyTMGOjOXxgOXCGzQglTdSwYq8
        r3krXpI9D9s/mEAA5AJGuaoqZx/CyIBEm5BpD5g=
X-Google-Smtp-Source: ABdhPJxjWgb5pJscChw+dwHpPJh4tqUnL7YSqZoAH5vteR69kMzD7osewkitWsChGn+9x1GzV4byYoYRESE7mPhiZqM=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr15794217oie.157.1608663155070;
 Tue, 22 Dec 2020 10:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
 <ba9c6f75-3964-3ee9-c849-17db5ae51501@linaro.org> <CAJZ5v0infKumCmn77nzAN80G4bmF+_ZzgGkdaeMvczC_VyjyGg@mail.gmail.com>
In-Reply-To: <CAJZ5v0infKumCmn77nzAN80G4bmF+_ZzgGkdaeMvczC_VyjyGg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Dec 2020 19:52:24 +0100
Message-ID: <CAJZ5v0hbeeVHPAhm01W4NKNBNQo1xS0Dqa6C2h=zoo4hCjGPew@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 11, 2020 at 8:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Dec 11, 2020 at 11:41 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > I believe I took into account all the comments, do you think it is
> > possible to merge this series ?
>
> It should be, unless more changes are requested.
>
> I will be taking care of it next week and, if all goes well, it should
> be possible to push it during the second half of the merge window.

Applied as 5.11-rc material now, sorry for the delay.

Thanks!
