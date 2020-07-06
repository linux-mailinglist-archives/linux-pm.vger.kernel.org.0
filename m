Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF482157A2
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgGFMwf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgGFMwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 08:52:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC7C08C5DF
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 05:52:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q4so9449580lji.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 05:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/l418RqBKygT3XUaVVUWM37eZi8gQrBBNYXDXbn38k=;
        b=B1r3fG6dsH/qouMx2ubARUPAdcsyFNEgp1v1D8jfa52c8J7fRImq0ys4SnNlP6XrN2
         99Raf5nlxeqcQN1Tn47ilpKlji+mfh9L+e+Rup7zFPMbiIFcs8P2uqJ4ASVgCVZ66Hl3
         6/zGA4OKUhaVEjYmTMnmmU1m9r5vvu7tNcDRxLkBGD8VQXhgpGDcZzSvZFhoW7xr7Ugo
         seaC0JArz8AlAHcKsDf4KJxiCUXx/Jd+yuiCpMAl4YopCCdiTLEoUUy+wjdBQ17l/PUy
         FYI8QkWPGr6GT3rclGkWVFo64BXFXCZb4R0vyPT+BKs0jBiNdc13WXKOOvLxnvW2WDNJ
         xcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/l418RqBKygT3XUaVVUWM37eZi8gQrBBNYXDXbn38k=;
        b=fu+8zPW1OsmGp8rLVlkepfQeiB0hg2HJT0c39SAXDy60fZORcgjj31bmNoL2NxCFOl
         VqQbr440d4snX5WVg2OKzpLv8T4IcCdwkWIwJ+ImcHodPsq8lNl6AU+V83ncqz8YOTJM
         h4T/jPpaNOnhz4dbt3zPj1eeWiw5tHLFTn1PTvmrRgYbwzb/sEu+UBiggh+LXfEgrHW7
         TsX+V24LjRFLyNk6BSR9d0uaG4PteOz4DwJuyk2Rl59/l7hX8yvn1pekzabLFmEucnZu
         jM0re7TzpNNIh/3Z9EIV0/JJX+YDMHG7JQwZqpQtsMYWb1sHIEGVRj2axq7gdYrSx5VS
         +y2A==
X-Gm-Message-State: AOAM530BBfgait/V2VHL3NLX3AmBZV3rsgxqF7hcfjquq8/9RCq75iDe
        sFFaLFic2dawQyGhP/5gDoFKpS3SvP5erTIKQCj6qw==
X-Google-Smtp-Source: ABdhPJwjpTKLYWq+hR31eDYdmY+r8r9swuzWK5B3LmVV+w60tAqfgVu13/vDXFsFyS2tITflFJ5EFbHXt6vJDWkzwko=
X-Received: by 2002:a05:651c:3cf:: with SMTP id f15mr26115232ljp.365.1594039953375;
 Mon, 06 Jul 2020 05:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd> <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd> <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
In-Reply-To: <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Jul 2020 14:52:07 +0200
Message-ID: <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     Alexander Graf <graf@amazon.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 6, 2020 at 2:27 PM Alexander Graf <graf@amazon.com> wrote:
> Unless we create a vsyscall that returns both the PID as well as the
> epoch and thus handles fork *and* suspend. I need to think about this a
> bit more :).

You can't reliably detect forking by checking the PID if it is
possible for multiple forks to be chained before the reuse check runs:

 - pid 1000 remembers its PID
 - pid 1000 forks, creating child pid 1001
 - pid 1000 exits and is waited on by init
 - the pid allocator wraps around
 - pid 1001 forks, creating child pid 1000
 - child with pid 1000 tries to check for forking, determines that its
PID is 1000, and concludes that it is still the original process
