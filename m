Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DCF383647
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 17:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbhEQPbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 11:31:11 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43951 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbhEQP2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 11:28:10 -0400
Received: by mail-ot1-f43.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso5857159ots.10;
        Mon, 17 May 2021 08:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZchp1Yf1GVmWnCUsrOiK0XjGAYstQKHWudIigD+jL8=;
        b=BTrKa0//DFRPpeyzD824lCvX84JX/ZLtrEkIlMxAPqV0Gk+ZNTulALfQnV+mP9/7Qf
         lXXhXjLyVkliD0owm71H7GEvV9eBKI62Xc+3yTvsW4FkGpsW7HbYqPm65EaYV+MXVcw6
         dBrk1IQohco5kM4tr3aEzJrzpbjA1uqIT853G0mkS+C3+6cdNY07Y5qhsBLX+t0w6Jka
         Lwti5u27+T+mYqESI34jvD9StxlNJE3sJDVjgsSnVIJQBc7YN11Xbd0rT38rRN2poMDS
         mEjIFgKaZYR1GenXaRbHoupMicfT7xwwVhkXeNZU7vtUzk8/usqd813z5RgHbUiclqrw
         7M6A==
X-Gm-Message-State: AOAM531wsBvU4MZ4rjWXtUymq3+12qowpbKnBX6smzaWF8iSHM54jxS9
        igFrU/bhl3u2Q45/XzmcaalVZzy1MBm+OkUT3Ao=
X-Google-Smtp-Source: ABdhPJwyVUsmk+27ZZTxl+ZL5cYi68KOh4QXyIRpDYJSmFILWYFE4IBTh35Xy83JjG8y+8U+SN6qDGbK9WZ+I+JnX6o=
X-Received: by 2002:a9d:1e1:: with SMTP id e88mr121644ote.260.1621265213424;
 Mon, 17 May 2021 08:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com>
 <20210513132051.31465-1-ggherdovich@suse.cz> <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
In-Reply-To: <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 17:26:42 +0200
Message-ID: <CAJZ5v0g5_BY3DCi=VxqkRh+TYPS5nkJ-J96EzPVrc975uiWf3Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 14, 2021 at 5:31 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi All,
>
> Can I on-board to this patch or do you want me to submit another?

Please send another one.
