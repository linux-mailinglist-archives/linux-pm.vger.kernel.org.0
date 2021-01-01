Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B16C2E85A5
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jan 2021 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbhAAVMq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jan 2021 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbhAAVMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2021 16:12:45 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B512C061573
        for <linux-pm@vger.kernel.org>; Fri,  1 Jan 2021 13:12:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h205so50607959lfd.5
        for <linux-pm@vger.kernel.org>; Fri, 01 Jan 2021 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQza3UddYXR6eO4r94ZTkx+KQP8jv7dR2DD0yefFXLQ=;
        b=FVApS46Ywo/T+y6oD79x3UdQ65VYtCz6bTRsGKsfB807UgbgL+RxmIAZzL/+VyI11/
         RTw/V0Efer+t7CsO1JfIoyarxhtEGoeJ8ziNMOHPut1/aPFGqPVmWWFZP738KO49A0wX
         IEMGgLZujcKDF3oW6S9KVi87tk1rBR0gSXUvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQza3UddYXR6eO4r94ZTkx+KQP8jv7dR2DD0yefFXLQ=;
        b=F0YPfFACTTUvb85vDbA8PU0X/L7xE0zHAwWUUn3bne0XCG6N/IUOhyesJce+Kr7e+1
         HAN1xE6Caa/OXkvAD81eiPcrmeGIXWZwoeaGdWnlE9kGVG2DKlYLaeDJBQCA2amiU6g9
         sAU9d7axrnYlAAjecR+4EsqRR1yInf0aPeIxNf0R2dWhio8Gm+I+Oekq+W5IbwtGDREv
         EEBM9gYrBiGq0sFgTM+RXI+fC8NW9O8TziutzqIAV/9ReZe69x5M7hQe6Prpww6I4v6b
         bukqtEyJRkLkvJD4tuM3AxFCcLj82tdZRXLmWOb/ZdOXcISxT9oD7kHkkSjbnhL0PNJy
         dJFg==
X-Gm-Message-State: AOAM530tNo3TQSr7GrBv9kuVQOHH2/ayGZIWE5WU5o4ufYCGGE6VJaIB
        DTl5hmKcgn7uk1rqzCK0V6aeqkt1MVK4fQ==
X-Google-Smtp-Source: ABdhPJyOhr/9aPfEcSIqciQ5bU3xo8Eeu6UAohOT9Mig76dNe+MAN5k2AeO2EeEcMKh01NAJR3vMFA==
X-Received: by 2002:a19:500a:: with SMTP id e10mr26485986lfb.227.1609535523438;
        Fri, 01 Jan 2021 13:12:03 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w28sm6562521lfl.245.2021.01.01.13.12.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 13:12:02 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id b26so50635002lff.9
        for <linux-pm@vger.kernel.org>; Fri, 01 Jan 2021 13:12:01 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr25990869lfl.41.1609535521403;
 Fri, 01 Jan 2021 13:12:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gTcaKg5NeP8Se-YekKDq=pT4Bu81G1RTdvhucBL3MaFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Jan 2021 13:11:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
Message-ID: <CAHk-=wjoyBj-pfbS9OKkcGgZsPRNPg+dWckiFk90Bdw93GhVww@mail.gmail.com>
Subject: Re: [GIT PULL] Power management updates for v5.11-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 1, 2021 at 8:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Add new power capping facility called DTPM (Dynamic Thermal Power
>    Management), based on the existing power capping framework, to
>    allow aggregate power constraints to be applied to sets of devices
>    in a distributed manner, along with a CPU backend driver based on
>    the Energy Model (Daniel Lezcano).

This seems very much a non-fix thing.

Please explain why I should accept this outside the merge window.

                 Linus
