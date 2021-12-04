Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88704687FD
	for <lists+linux-pm@lfdr.de>; Sat,  4 Dec 2021 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbhLDWEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Dec 2021 17:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhLDWEo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Dec 2021 17:04:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F6C0613F8
        for <linux-pm@vger.kernel.org>; Sat,  4 Dec 2021 14:01:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y12so26253801eda.12
        for <linux-pm@vger.kernel.org>; Sat, 04 Dec 2021 14:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=RbFJlew0CJwUua0mcM+UwWlLfDB+SvHq+bCujY26qJe03tLD8T4/o4D3aQzet0lIxM
         H3P8ImGLhgxwRq6PMV/CnAHDQrV+LCLwuv5vpralfCkN3myC7aKDAR4fCTef9EthYPV4
         Xb49U5ntDeqmLcYHi3cs9bqWUa1oiHprIOu0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrArc/ifsgPokgBSC+Ea7AYzh1AFMkX0pvs51A3I4u4=;
        b=CjM3s3pjytd0iafrct/XccVD1Vf6wFYIsbXcCpvDYqAm4ZUvYJRkXhsjRH60xVL5Iq
         J3v5CNGC0h+LnH73D0o2zzx4/TX4n3nAHjs2hC8qpWFsvrH1VKgrZKt6pzaysN09YC78
         dhXkGCtzc+y1NDs/8ppQ1upJW2fPM+alcpZr/FO8e66t6lJaLHDbjSPh4ArGSDFJcAA/
         dNYVDX82aLz/iOTw0Bnp8KVJQkuOA3D+kz+HRsHgBoPFuM8ecu1rWU5zusKQ6eNXkx4F
         8/S1vXUN8zzycYUgm45F7Yhg/ecYIxRXD+nWz9v/j36wfpH6gV1tRZI97Kr9O90NlCea
         qeLw==
X-Gm-Message-State: AOAM531CQCxa8ybfEiO+rIrkGyU3ooJYBBKZTNXf9ETKzsT65LEfAmMr
        DW86G4WdbCv0zhOWZQHuGnuvbvNevxEA2Wsu
X-Google-Smtp-Source: ABdhPJwr0jQIb94Ywb2hVfaUtCUEAv+McBaygLdosfhhJnSA84EwyUN8y0+rVDJOzHFA2m5BEVrK+g==
X-Received: by 2002:a05:6402:5cc:: with SMTP id n12mr39281131edx.246.1638655276066;
        Sat, 04 Dec 2021 14:01:16 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id qz24sm4189970ejc.29.2021.12.04.14.01.14
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 14:01:15 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id i5so13735876wrb.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Dec 2021 14:01:14 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr31503846wrq.495.1638655273990;
 Sat, 04 Dec 2021 14:01:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
 <CAHk-=wiGbtmc+FoUjcgaQRavL=B=rfTmA_VhTtGpmhmk2873cA@mail.gmail.com> <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
In-Reply-To: <CAJZ5v0janj--CTeVndJAwiaset5tP8XYdXmeW1hHREcO4BefZw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Dec 2021 14:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Message-ID: <CAHk-=wjeN0FO7s+o=ZhxjCwTU6N17oT1h1WHRXtiysRRx5A1Uw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 4, 2021 at 12:11 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> but it is interesting that you can reproduce it.  I thought it would
> be rather theoretical.

Well, "reproduce it" may be putting it a bit strong...

It happened this morning, and after that suspend/resume was broken
until a reboot. But I've only ever seen it that one time.

              Linus
