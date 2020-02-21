Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7771685D8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 19:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBUSC3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 13:02:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36691 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgBUSC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 13:02:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so3114127ljg.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=LtuqrNdxX93Kes55M7/V1nmMoOY/Am5rxlDligc40iz1+GEbCmeM7TuGyB0tTEcegn
         UDZiT2MxYZWEAGTE0LovTMS1jqfnFBkPD3xPTU2e30E6da/H/mQbYfgawXH18yg2Guvv
         l3o1EYHUu3z2m8B4mLtmpaElvsWWhBoRfpDBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=WxuczffaAQChmgUFIHNTG7qJZ/FaefB0Pvd7LF3hszI1FycgFxvfamS9ct6S+67frc
         UdnQi5aaRjGvPa0j6+7mm1uudLssFD24KmvrwjOCK1qj/HHVNBYeN2SEk6bvdRLvPod5
         RdkVqU0Dt47y7z+5NxrpWdhpoTuBaLKFUBkoQWLts7Sj7QyC+jEc2v+F2MrvgbOQ43oX
         0XcRhpvIqsVBfONB57FcwbHr2tcVUQTdjda1EJZ8KZbbh9ucT1U4SIT+IMaCNVcS4+lJ
         LmguAs1V8aM4euVJOUoNVVT9GdM7uRhwxrrtpjH0vcuXzeQ4UYoN9NcbJykp4T6pec1e
         eo5w==
X-Gm-Message-State: APjAAAUXuoQeHj+flOa7fC+BD4fFVZ4qbSeMNZYas3Y3GFLqGZloSrA1
        zB4KZ/SWllu1/ImCVSt9DdBU6eQToyo=
X-Google-Smtp-Source: APXvYqxB63QzQaQZ0jYgQu91l9Vp3s42rQcVih2xIeYUr64T2Lvlk4xgMBQKJ0W0dQz3W1fTLANe2A==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr23588650ljn.277.1582308146239;
        Fri, 21 Feb 2020 10:02:26 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 19sm2391201lft.81.2020.02.21.10.02.24
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:02:24 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id x7so3128312ljc.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 10:02:24 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr22906965ljb.150.1582308144004;
 Fri, 21 Feb 2020 10:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
 <10791544.HYfhKnFLvn@kreacher> <4974198.mf5Me8BlfX@kreacher>
 <158227678951.3099.15076882205129643027@skylake-alporthouse-com> <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 10:02:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 2:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pick up this patch directly if you can.

Done. Added Chris' tested-by too.

            Linus
