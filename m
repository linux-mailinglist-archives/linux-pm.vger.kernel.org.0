Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE03D7ED1
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhG0UGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhG0UGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 16:06:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734FC061757
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 13:06:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j1so1540692pjv.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jul 2021 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=PwWl2aSuu6+Di4TaYJklMnkd+oXVKsyMZMTbKM+A+u8=;
        b=GjjTQEx7cmQ4zLT2IsEMp1dHExxHTJJPdNifLGuzeHOyl85uK+W94wFykfmba9pGcz
         0HTKN8p3jjW0tpWPvalpO9Key8qoO6tvnO5OTsjj8leLwAns+o4cT1wdKg8+vwvCaBvN
         usKbb5AzUN4ROfXv/zsx7tqgYkLiBq7BuWrPnedWeiPM1RU8qadLPpgIPPF3bJ8Q8p95
         03iPFN5yl2EPY1etCgOZ/cR2Pcrb+smAA4CV5aYuUYtGqfIM8Q7rd11Qy5QmimU9LPQ3
         mZSqPQkGw8ietikJcSxYZL0LUUER6tPhF0lOUAuJofuQnJLpXM00K1r6Mpi96piZEDeV
         ixwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=PwWl2aSuu6+Di4TaYJklMnkd+oXVKsyMZMTbKM+A+u8=;
        b=f113B/MTXhN4DoQKhYlCBneEGkJQDKIMxUWhFbU8VepLKkBc+UpaW21Hua5tH34eI0
         /8/h0vnTt2WA1qi+/0qVX30kmzWYnxdxVukg4xSa42ZG/VAq4vl+qoucvxW0qH2fds8O
         4K+bMKLY9HRmeqNNC1kCWgESQsyQ+5VG3Fo7B3lKZmd9M0pMGo0CrLUDUrPC7oPwY76f
         7dpo8YRbXSe1N7q9n4KB88XB9OnrOz1NRyKyCwfh5RPqW7AUWzzxZrqlowZyr4/CYvQl
         wzZ3v95F09Y8ezw5aVSLUBiR3p1nX9NlzRT8KgG6wtPezdy8DdOcR93xWp7/iayzPpp7
         JyNw==
X-Gm-Message-State: AOAM532RHThk8aN0HFQq8FIsVKSQD8KsVb63QuNDixwW4SZtLhf0InHz
        jUjJ0eNyCozFrydyoIOVVxtCXg==
X-Google-Smtp-Source: ABdhPJz1eke9REWf5ey8sjMLPlapYCBiZ5nkq2cf+SnoX82CZjudaQlB11GZQciL7Ozt9/omc5RjTA==
X-Received: by 2002:a17:902:b487:b029:12c:4051:a8de with SMTP id y7-20020a170902b487b029012c4051a8demr5298018plr.76.1627416400041;
        Tue, 27 Jul 2021 13:06:40 -0700 (PDT)
Received: from DougS18 ([173.180.45.4])
        by smtp.gmail.com with ESMTPSA id y30sm4205738pfa.220.2021.07.27.13.06.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jul 2021 13:06:39 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <1867445.PYKUYFuaPT@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
Subject: RE: [PATCH v1 0/5] cpuidle: teo: Rework the idle state selection logic
Date:   Tue, 27 Jul 2021 13:06:39 -0700
Message-ID: <000801d78322$e9b94980$bd2bdc80$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJWv5LtWSG8O5a4tG6eLIHdXBOua6pYw/kg
Content-Language: en-ca
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Further to my reply of 2021.07.04  on this, I have
continued to work with and test this patch set.

On 2021.06.02 11:14 Rafael J. Wysocki wrote:

>This series of patches addresses some theoretical shortcoming in the
> TEO (Timer Events Oriented) cpuidle governor by reworking its idle
> state selection logic to some extent.
>
> Patches [1-2/5] are introductory cleanups and the substantial changes =
are
> made in patches [3-4/5] (please refer to the changelogs of these two
> patches for details).  The last patch only deals with documentation.
>
> Even though this work is mostly based on theoretical considerations, =
it
> shows a measurable reduction of the number of cases in which the =
shallowest
> idle state is selected while it would be more beneficial to select a =
deeper
> one or the deepest idle state is selected while it would be more =
beneficial to
> select a shallower one, which should be a noticeable improvement.

I am concentrating in the idle state 0 and 1 area.
When I disable idle state 0, the expectation is its
usage will fall to idle state 1. It doesn't.

Conditions:
CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
HWP: disabled
CPU frequency scaling driver: intel_pstate, active
CPU frequency scaling governor: performance.
Idle configuration: As a COMETLAKE processor, with 4 idle states.
Sample time for below: 1 minute.
Workflow: Cross core named pipe token passing, 12 threads.

Kernel 5.14-rc3: idle: teo governor

All idle states enabled: PASS
Processor: 97 watts
Idle state 0 entries: 811151
Idle state 1 entries: 140300776
Idle state 2 entries: 889
Idle state 3 entries: 8

Idle state 0 disabled: FAIL <<<<<
Processor: 96 watts
Idle state 0 entries: 0
Idle state 1 entries: 65599283
Idle state 2 entries: 364399
Idle state 3 entries: 65112651

Kernel 5.14-rc3: idle: menu governor

All idle states enabled: PASS
Processor: 102 watts
Idle state 0 entries: 169320747
Idle state 1 entries: 1860110
Idle state 2 entries: 14
Idle state 3 entries: 54

Idle state 0 disabled: PASS
Processor: 96.7 watts
Idle state 0 entries: 0
Idle state 1 entries: 141936790
Idle state 2 entries: 0
Idle state 3 entries: 6

Prior to this patch set:
Kernel 5.13: idle: teo governor

All idle states enabled: PASS
Processor: 97 watts
Idle state 0 entries: 446735
Idle state 1 entries: 140903027
Idle state 2 entries: 0
Idle state 3 entries: 0

Idle state 0 disabled: PASS
Processor: 96 watts
Idle state 0 entries: 0
Idle state 1 entries: 139308125
Idle state 2 entries: 0
Idle state 3 entries: 0

I haven't tried to isolate the issue in the code, yet.
Nor have I explored to determine if there might
be other potential idle state disabled issues.

... Doug


