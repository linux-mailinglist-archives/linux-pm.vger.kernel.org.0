Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C374A27EE04
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI3P4u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 11:56:50 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34638 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3P4t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2020 11:56:49 -0400
Received: by mail-oi1-f171.google.com with SMTP id n2so2231488oij.1;
        Wed, 30 Sep 2020 08:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K445MUiZ3MvMTunnbZsByZJVp7P2xHMbirIlfPgTFHc=;
        b=nh/pUZ4qBdwLwuUr1EGOuexvng9nowP+vKxmB4YCorAA/vpnn5KUvdHfaMKmXymRgA
         l13ZmaAMqU7ICSummyrKletD/6QVB0yRKNAPUYe3zzuZKNrazCvJhritbepsf8wBK2g8
         Lj+Y7msyPyvEKqhvAUYCxuPjggZQIEpiovg4sjYvPUhwmUsKQLby6At9Gjp3V7Jk2NaJ
         MpEP36/5I9rIpFdIik3w69y8deWFTCYjrPV4KOlYgI+pqXxB+SHRbv+S07iegTma38Ej
         5IlKfEKdYqrW69WHxPl+wckZ6/dZLJStcBfn6kxSAbFEYrhsIrNJAMxujZ+QO3Q1xvd4
         jb5Q==
X-Gm-Message-State: AOAM533DlQ8VfTiwwGL/Gk0lG/Zd36kELfNZERPU2Sw4JOM+fYNeFxBj
        aGHH1IMDv2HFG/r5UlOeQKg4v1rWZIp55beJYac=
X-Google-Smtp-Source: ABdhPJxh9Zh19FVFOeo5RgFdxoL1nhEevc1SDmqn8XPmmMkA1+wEo3zRP9ALYwDGGrFL7fTuKpmZVVm3+pVuTA67tCM=
X-Received: by 2002:aca:df84:: with SMTP id w126mr1825361oig.103.1601481409260;
 Wed, 30 Sep 2020 08:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15@epcas1p2.samsung.com>
 <b5d67c59-90c7-6a77-7420-a8783282430f@samsung.com>
In-Reply-To: <b5d67c59-90c7-6a77-7420-a8783282430f@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Sep 2020 17:56:38 +0200
Message-ID: <CAJZ5v0giQRQG+V=XPVMJH4aRcvZo-JQ82bgw-KHAXBGfnEkgpQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.10
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 29, 2020 at 10:56 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.10-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.10

Pulled, thanks!
