Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4D109542
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 22:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKYVrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 16:47:21 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:43649 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 16:47:20 -0500
Received: by mail-oi1-f171.google.com with SMTP id l20so14605616oie.10
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2019 13:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPHCx/sblkspJQGTIlPXyxa/zo6J9XFw5JrT7MglmcM=;
        b=bPShaGJFZz+kXUyWRLuRwFZ0VWbWAPaLJCXIf4ApRKc02rffyteKVtFUFLQLnEdk2p
         oRYhpj2LhI1pcIFNd5TEtquIPrf+NrhBmFw7qEhhi6aOHyP4kQr1a+6Tmf4lcR5/cqXP
         aCSMRCWPa+3tyFpzPsHO/xWKcSECvvKZBh65XJ3o+4/bRqCXeaChm5rLUKerpnqyLDzg
         bM7HbNPz194FYkSREwCQtcwHPSeUzg75zpb26W22Oa8YIMw9eVq0FHhYer6DNAljRvg+
         uM2uud3hqiLrebIb2Lfuf4TgHhQMqqC5m5U7m3ulx2R4i33KDF8XS2pXrRZvKOocQ6Nb
         lLuQ==
X-Gm-Message-State: APjAAAX/KmNP2PvIx5Ym1vqE8j4r7vbTPsJ/jzr2snn8mEG80CEUbMRH
        OODu/W6VBCybFFkuPi1E9tvs0b97HO4Nctjlrec=
X-Google-Smtp-Source: APXvYqwktxIlZzSWtDhbsbNizq7IHo9PW0gyvx81LrnR4xysTcDI3qo/iAFMdfSaiq9Cgf/i4sVzn7tbEwvy6VQT/tI=
X-Received: by 2002:a05:6808:901:: with SMTP id w1mr849434oih.57.1574718439912;
 Mon, 25 Nov 2019 13:47:19 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <alpine.DEB.2.21.1911241929220.16116@hp-x360n>
 <CAJZ5v0ichG5N+yLyyX1BZhNf+Fk_xrvQ+9q4FeP3XVtxKp7yug@mail.gmail.com>
 <2977390.9qzeJo7xji@kreacher> <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911251019100.12067@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Nov 2019 22:47:08 +0100
Message-ID: <CAJZ5v0jmQcQJ75W0FCod_=+_EBAVADxZiseNXRM+s9McrNnk1Q@mail.gmail.com>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep:
 Simplify suspend-to-idle control flow)
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 7:27 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Mon, 25 Nov 2019, Rafael J. Wysocki wrote:
>
> > > I'll send you a patch to try for that.
>
> > Appended (untested).
>
> This is promising! I've only tested a handful of suspend cycles, but so far:
>
> - Charging events don't wake it up
> - It suspends with the charger connected
> - Suspend current draw consistently gets to the lowest idle point
> - It always comes back from suspend, even after connecting a charger when suspended
>
> ... IOW, everything just seems to work, and better than before. I just
> remembered why I had to use "ec_no_wakeup" (pre suspend-rework) in the first
> place- this is a convertible and accelerometer events would take the laptop
> out of (and immediately back into) suspend and your rework fixed that but then
> I had the issues listed in my original E-mail.
>
> I'll keep testing it (and the best way to get something to break is to proclaim
> it's "fixed" :), but for now I'm pretty happy with the patch.

Well, so with this patch the problem is at least not reproducible
readily it seems?
