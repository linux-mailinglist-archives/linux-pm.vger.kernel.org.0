Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005111CF64B
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgELN6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELN6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 09:58:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50101C061A0C
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:58:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so16960245wmc.0
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6We9F0Gl5i6dFB55TqViIVwO6PgjLYpYEaNQovKdPNk=;
        b=f6Nrlgw8UCeFoD5o8cR+YQiCKCYmqZIj47J/ddXCRLiBT2dJ14ERtJogi5vv4YRaVP
         DdOdfSdEPRWfH3VZDTL6qtcEuOpAl6zcS2aHXoLeO9T9OxdreTUPFeoXk95PQzM59cjT
         oiIsAr2xUt21mubwr8eYWwQlTKjYamkIbd4z0Qod13dJalTL9DFmYH5A3VoF2Zfj03Tp
         URKm8lP2zvsnOTcQWSAHzOf97wLEQV8JglXIfA3rqgtRJHp+/W4YYkadapu+NpANBdcO
         KT1UygHLxz9bFaAiq5sTd7qNhwWv+IY5MWT3WpCaex/qYlCHndsfgw81dFpxaVbSuqvc
         Gmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6We9F0Gl5i6dFB55TqViIVwO6PgjLYpYEaNQovKdPNk=;
        b=G+k93n1wzeysnb54HVIw+bqSqZX/xAgOWNNaPka/xaXPody9U89srEHidTwx7HvKc4
         O0zZC+xtQgM/z67V/BGJrNrVy7fmWyf5dD6j8fo/PWCBzSpz0DhDcbd0qL+CdXw2vBvk
         5qaVoQUW8/qwwKEtVnRcP8madyklY2OgCBfErnq1pDlwUCr7H0hX69+l+dwtoKEUq3PT
         HC33ZNnChRoroWQkcPomo0anxbyr8J3R+PAAxei6Lna2V2+YMZ4fKGXJ3O9axB8Z/P0c
         IRqGnQMF50QlgHptD7ar4A8Z79nva9mtehrZn+YZiNpuaGWZXm1NSFRqHgQrGygto7m/
         8HRQ==
X-Gm-Message-State: AGi0Pua4cyJHKFAdijJ+uLpsw7GvWqUq0c7XVrmf1yz7Qwqd1ls2Qfzt
        vkPKn7ux7F9jDmqnuJWuRYScRQ==
X-Google-Smtp-Source: APiQypJjRlOI0WgMaW9PI/tz98LbvmgkkDNcbr+q8RKiGAeM85CNu41OObsMGh78C+ggI9aYP6unNA==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr36318773wmh.96.1589291897718;
        Tue, 12 May 2020 06:58:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s2sm351084wme.33.2020.05.12.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:58:16 -0700 (PDT)
Date:   Tue, 12 May 2020 14:58:13 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200512135813.GA101124@google.com>
References: <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 12 May 2020 at 12:25:17 (+0200), Rafael J. Wysocki wrote:
> Still, IMO it would be fair to say that if uclamps are used, schedutil
> is very likely to be preferred.
> 
> Kconfig can be made select schedutil when enabling uclamps or similar
> to express that preference.

Right, fair enough. Making schedutil default to y when uclamp is
compiled in should do the trick (and avoid using 'select'). Would that
work for you?

> What you are proposing is basically to add complexity and the reason
> for doing that seems to be convenience (and that's not the users'
> convenience for that matter) which is not really super-convincing.

Forcing our users to build in their products something they don't want
to use tends to be a very real problem for what we're trying to achieve,
so it's certainly not just convenience from our perspective. I can
understand that yours might be different, though.

Thanks,
Quentin
