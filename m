Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0871284A48
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 12:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJFKZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 06:25:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43798 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFKZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 06:25:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id l85so12068210oih.10;
        Tue, 06 Oct 2020 03:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=APNL8sIy0ozc5Oyn2Cryq8fb7C/LIEhMjOf2WGIBcb8=;
        b=qtRwgx4cJYlp7ZTBdhnI8DFGblkPlBxJgMOSaanTcmp2i3oLujbwBYfCfw1po3hkB5
         ai+3yTfFyLSM/OtYwd06RujAoukKj8QhqjJMPdzLKUbY5nHjT5PD3X0zO1jYCJPyjNyL
         MuTbjHn+wRo0stLcvDk/8i1BuhuX6xrX/bxvJ26mln4Op29L1CzZbHI6G6Ve8LxcAE4C
         20Ck7o9qAjiWYjqtzSmb9/bg7W1wZRtLD/HoaW2RXM/AoES+1MXiEJO9ZNsjs1Pyj5fC
         3PbIrGHHXVSE9KsZrPi2tdMgVmeVpm8vPq6ZeGPoJ5ns0ZZauikhoF4o4fSP3PBgaPyt
         ohjg==
X-Gm-Message-State: AOAM533uxt5JCes+l5Q9ZDnGSDv5zhV1mpKpcbz7yvTBFPUk/Ge/Qm2Q
        KvdsGGAQZu+5fpXPJepRf3dC2yVVj/Wo1jKHGZY=
X-Google-Smtp-Source: ABdhPJzzhpC3gHLcrFC6FgWQgU2t7pcLFRSSME5NqApT10Yu/Dhhx8vlrcTmCtZEKVT9oY5rBALop96EY1SYlT3GO6w=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2285283oic.157.1601979936223;
 Tue, 06 Oct 2020 03:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15@epcas1p2.samsung.com>
 <b5d67c59-90c7-6a77-7420-a8783282430f@samsung.com> <CAJZ5v0giQRQG+V=XPVMJH4aRcvZo-JQ82bgw-KHAXBGfnEkgpQ@mail.gmail.com>
 <da43236a-b44e-d4d7-97c5-37ce3c447c95@samsung.com>
In-Reply-To: <da43236a-b44e-d4d7-97c5-37ce3c447c95@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Oct 2020 12:25:24 +0200
Message-ID: <CAJZ5v0h5uQh8iK+PDdW05ATn40NtX+8H0JGZK7R+TFtBwL7igw@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.10
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 6, 2020 at 9:57 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> On 10/1/20 12:56 AM, Rafael J. Wysocki wrote:
> > On Tue, Sep 29, 2020 at 10:56 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> >>
> >> Dear Rafael,
> >>
> >> This is devfreq-next pull request for v5.10-rc1. I add detailed description of
> >> this pull request on the following tag. Please pull devfreq with following updates.
> >> - tag name : devfreq-next-for-5.10
> >
> > Pulled, thanks!
>
> Thanks for pulled the request. But, I tried to check on linux-pm.git,
> I cannot find the pull request of devfreq patches for v5.10-rc1.

That's because they were not merged back into my linux-next branch and
they should be there now.

Thanks!
