Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA70B5971AF
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240183AbiHQOiJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbiHQOhg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 10:37:36 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D182D9C1D4
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 07:36:58 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBCE83F043
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660747015;
        bh=9KdPXbbC57q0GCBaNSQ6gpXd4ReJlJskesNZTpBHi7M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lxpnq7SFzEQZi7xIV5jR1G8YoGR17Xp8RMnDb1XoE7+sJ732dG8lGDiU6Eb3nKtJk
         NpmcmXXJJHmMu8Mf4ND4CWfgNI+wIvopbnlb8wUjZtiaiYRoyo1eP09Ozjvlfzqi1y
         vlOfsEavQetadyAlGVuePiPq1DogElbzp0dnRU/K0qEqZUWGP4lx4FwhHJ809Ef/7+
         3T7IguzR1oa1tDdvHE3IJD8T195dhiD5bGxbKFqt1Gisu8Sjfgjup23nfwM6+olzfD
         8ER1Cyo532/N1kd6jlBNYaCGqmQq/Xfcbt0Nmg0xqmdcZWd1Y22nql+XS/fVcUmtXF
         1r9DAP5TzxsbQ==
Received: by mail-oi1-f200.google.com with SMTP id r2-20020acac102000000b0033b5d4ad976so3901674oif.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 07:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9KdPXbbC57q0GCBaNSQ6gpXd4ReJlJskesNZTpBHi7M=;
        b=NNhTViVFYm2NJ59egIdXbltH5cZbppznA8oY0Jfa2BGXAs38J0Sy36xfG6E+u6g0/8
         OWL1AB+eDjqEG9Guv1VyTnY2ncacEzHOaWo/UquPR4J4aX0qRFWp5rjS7gq6cF7eB9cP
         s6gDnaEKz+76FcmAmN9WFBIJTCGi50HhMVqMu/6wgJ6uBENySslXgTzTKrAjc9zvkzLH
         QtCFqRsqvyrX2NY4EjnIpdLu6a8aidc82Qm1PnvNKY3w7GEL1HSKzzk0ynDqXXxYnBNs
         XKwz9EL9118SyUbJ4KNb4DHKbl58PdqSDyzW8jBn5iE0oejke3zFSP29WroiGtKxyV6d
         DxfA==
X-Gm-Message-State: ACgBeo0CuAJXSYWugmel69tnYEY2j38jmCpUHvablJwjiN4JTg0X9yEK
        WUV1Z85NrwA04wDWfdhlr8351NxNUQB+pRUaT3/E45HYTF4bn+GRKEE0UB4fb5bTCh9iToo9aF3
        J0iP9OM4gvmsdoG+8mwDmGKCegY4AZXuXHZkb6Rd19CkzZ5aN/zlc
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id s31-20020a056808209f00b003448f501f29mr1621275oiw.42.1660747014740;
        Wed, 17 Aug 2022 07:36:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70LybnQhtg/je5ePI0+3yljYlHIsZHVIRJ9Ze0L72CL3cthzKqItPDrTddl6bwh51VMW1/BpUUhq/pPE4vJEc=
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id
 s31-20020a056808209f00b003448f501f29mr1621265oiw.42.1660747014461; Wed, 17
 Aug 2022 07:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
 <YvzDNgBgMiMrfc1M@black.fi.intel.com> <CAAd53p7HDYz9b9rG236g4MVHAzksOKEOcDZW+MHYi4MoAbO99w@mail.gmail.com>
 <YvzuhPmTtn74iruB@black.fi.intel.com>
In-Reply-To: <YvzuhPmTtn74iruB@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 17 Aug 2022 22:36:42 +0800
Message-ID: <CAAd53p7GWjtjTOoW=fhPMsU=YEuiJDkrYZyC2jQZzGQc0Kh2zw@mail.gmail.com>
Subject: Re: How to get "wake up reason" for Suspend-to-Idle
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 17, 2022 at 9:34 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Aug 17, 2022 at 08:53:00PM +0800, Kai-Heng Feng wrote:
> > On Wed, Aug 17, 2022 at 6:30 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Aug 17, 2022 at 03:08:18PM +0800, Kai-Heng Feng wrote:
> > > > We are seeing laptops wake up when Thunderbolt dock gets plugged, or
> > > > even wake up on AC plugging.
> > > >
> > > > On Windows these events are logged with "Wakeup Reason", and if the
> > > > wakeup event is from unplugging AC, the system will be put to suspend
> > > > again.
> > > >
> > > > So I wonder if it's possible to get the "Wakeup Reason" under Linux?
> > > >
> > > > '/sys/power/wakeup_count' seems to be insufficient for this purpose.
> > >
> > > I don't know if there is a way but unfortunately several systems (or
> > > their firmware) are expecting Windows style "dark resume" so they pretty
> > > much wake up each time something gets plugged or even unplugged to these
> > > ports. Linux does not have similar mechanism at the moment but I think
> > > at least if you have lid closed it will eventually go back to s2idle.
> >
> > ChromeOS also developed their own version of dark resume [1], which
> > checks  '/sys/power/wakeup_count' to decide if the system should go
> > back to suspend again.
>
> Right.
>
> > However, if there's any spurious wakeup event occurs during s2idle
> > like [2], checking 'wakeup_count' alone will put the system back to
> > suspend, and the system will stuck in a wakeup/suspend loop.
> >
> > So I think it's safer to implement the mechanism in the kernel, by
> > implementing .suspend_again() callback for s2idle just like what S3
> > does.
> > However, to make the right decision on suspend or wakeup we need a
> > concrete "wakeup reason", but I wonder how do we achieve that?
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md
> > [2] https://bugzilla.kernel.org/show_bug.cgi?id=216295
>
> Do we know why the AER event happens in the first place? I think that's
> where we should look first. Perhaps there is something missing int the
> Linux AER implementation that causes this?

The AER happens at Physical Layer as soon as the device hit D3cold, so
I don't know what really happens at such low level.

Here's my proposed solution:
https://lore.kernel.org/linux-pci/20220727013255.269815-1-kai.heng.feng@canonical.com/

Anyway, it's just an example to show why I think it's better to
implement "dark resume" in kernel instead of deferring it to the
userspace.

Kai-Heng
