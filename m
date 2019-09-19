Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE045B7D07
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfISOij (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:38:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41267 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbfISOij (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:38:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id w17so2885398oiw.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 07:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbOYzUv2g9lngYrGZPsm6IaPxJDDuKGxArHnKKqhMgE=;
        b=cNv+7z3kM/4jIZGXJidviC1eZFnHxOrxVVjgNPkY0X/8kX2pgwjTLkjDOdWHMFoGND
         jLfgyO1il1eLw6nr/iOLSCy11Lqe5hC/gdGVKci4oyTGr6QQv/D0C3EL8cA9TcDdsevu
         QreBEL2YYS65eQzC/TsmDodf2hMsW81sybxS5koTBsuLgUYLnSQyEDWpIiOQPgYby7Ic
         spYvRMldqSzB874j370OQ1rNoxy5ohWOEHXVLT97FZNE1aCUIAAOpxYltTcVLokTDsXB
         Ub24ejggzk7sGo5kCOyYbMyDAuxq1ICJ1tAq22pGHLULgE7No7B6f645YObMjVNkqmUv
         CJTQ==
X-Gm-Message-State: APjAAAVEXVijKKA9RzGxkSrqprUmqTzEcqH+F0CKnFS2FNF1YS9NCq2d
        N3BehOFGlpgTYiM7Mhh1U3vzbID6AHuonqj+Awk=
X-Google-Smtp-Source: APXvYqyFFiYDU5X8xnOjk5ONjTpK8D4TRZ69lVQZe5rmAR3Xur1SrhSxZprKZLK8i2YLu2oolrjLNIggVRxjLZo/R9k=
X-Received: by 2002:aca:db44:: with SMTP id s65mr2537226oig.103.1568903918650;
 Thu, 19 Sep 2019 07:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909181742470.2771@hp-x360n> <CAJZ5v0gYGPkJ0-=HSzFCpMLqky2Q6JN3qnov3c2ZaUAeCeaSag@mail.gmail.com>
 <alpine.DEB.2.21.1909190444190.2973@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1909190444190.2973@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 16:38:26 +0200
Message-ID: <CAJZ5v0hvauVP1NsQq8FTTf0_hk4_KujmCJTAE8ry43gu7wQ-GQ@mail.gmail.com>
Subject: Re: Help me help you debug what seems to be an EC resume issue
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 1:46 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Thu, 19 Sep 2019, Rafael J. Wysocki wrote:
>
> > You may still be able to use S3 on this machine if that's supported by
> > the platform firmware.
>
> It's not; I tried "deep" two days after getting it.
>
> > I would recommend to try 5.4-rc1 when it's out to see if the problems
> > above are still there.
>
> Well, I'm running Linus' master tip right now and pull and run the latest
> bleeding-edge kernel daily;

Specifically, the material I had in mind was merged on Tuesday, so I
guess you're running it by now.

If so, you can try writing 1 into
/sys/module/acpi/parameters/sleep_no_lps0 and see if that makes any
difference (without using ec_no_wakeup).

> does this mean you have further patches coming
> down the line later?

There may be a couple, but not related to the EC.
