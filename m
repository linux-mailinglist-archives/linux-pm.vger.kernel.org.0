Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CE2DA0AD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502596AbgLNThu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 14:37:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42406 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502451AbgLNThr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 14:37:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id l200so20461222oig.9
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 11:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3Y3MRHewvnYNtfnxAdgfHaCuyRDM8NoARfsKa7K9RA=;
        b=R5BsZncppdjxR2+GTRYmLYVnVpV+tyRmn/XGZTgy7nq5xowAUUVcAWKFryxZpvkhZL
         w1ar8UY3nyY5wvniLQ/GFJk+4ad/0IPC3amNSyNJyBjY1mku/dWUT2KHzWr/aaJHW8m+
         ZQxLXLfCG6VcEilTyKlu1SFnTplSFtIhJtFj+/0RX69jkoIHGhIdmKRI/6jscnuwXt7m
         bbI8hOrB05x8VA8COIgtuX39Ta9QyukA+VoPkm5qd9vCEJUFufNdra4z8RGXLELu0RqH
         ym9nWf3pul2Hy8cj07BAu6Xyh6MMjg7cSatWLM7sidxqofXfyObQrfuQBkJ96C4qaqEo
         fcfA==
X-Gm-Message-State: AOAM532NRt0omTaSkUdRxyiqoEGPOIf7lezIln1u5kShVMr6KGjeMXZG
        snCuPqmXdZ3gmZWrPQ+1EHymwqX5Vzq1YwpuGoY8xDHy
X-Google-Smtp-Source: ABdhPJwTDN94zrL7d40Cu2AO8dLu2ZOnFavC+USlVsoc9cCeGnjs6JbRo7PSoeWymG8zRm5sKb8nxu4UOXEl47ezRdw=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr11293025oie.157.1607974626287;
 Mon, 14 Dec 2020 11:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20201214111446.xz5hrfamjm3tyesq@vireshk-i7>
In-Reply-To: <20201214111446.xz5hrfamjm3tyesq@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Dec 2020 20:36:55 +0100
Message-ID: <CAJZ5v0hT2A4qsNWEst05vgTwdc-wZxH2uxJ6jj6mU3hxWDZ5kw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 5.11
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 14, 2020 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following updates:
>
> - Allow empty (node-less) OPP tables in DT for passing just the
>   dependency related information (Nicola Mazzucato).
>
> - Fix a potential lockdep in OPP core and other OPP core cleanups
>   (Viresh Kumar).
>
> - Don't abuse dev_pm_opp_get_opp_table() to create an OPP table, fix
>   cpufreq-dt driver for the same (Viresh Kumar).
>
> - dev_pm_opp_put_regulators() accepts a NULL argument now, updates to
>   all the users as well (Viresh Kumar).
>
> -------------------------8<-------------------------
> The following changes since commit e0df59de670b48a923246fae1f972317b84b2764:
>
>   opp: Reduce the size of critical section in _opp_table_kref_release() (2020-10-27 13:21:03 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 2c07b0fd9bf6dfb0bdf05aac018e6b3242d60822:
>
>   Merge branch 'opp/empty' into opp/linux-next (2020-12-09 11:24:12 +0530)

Pulled, thanks!
