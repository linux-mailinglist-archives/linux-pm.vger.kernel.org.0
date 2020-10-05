Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D74283509
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJELet (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 07:34:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39441 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJELet (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 07:34:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id c13so8377269oiy.6
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 04:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6gY4bhrfB6SUv7OxXWkkMPAGlGzZ2ouw3/MLXRT6Yk=;
        b=BBCIE15GJlDTN8pMucDK0es8XJe0/Gb+G5OzAGoEonJb0qcKMpBdh+s51eEfT3A31z
         LsZzRPDHqLtpw11JbsruIFNvTuC5w4ASjgytL+ZKQH6rIubI5jj7x4ZFQnMsPhB2VU4R
         5FgZoPEKfRH9lo6IrtFp+6VaTOe1LOtHOEr0vQQ6rnlCxkoJv3ku4/I6CpHj/8hLwOhk
         B9sX2laxxqjNW/KOALh6WaMR98L4Stp860DSoiKzBIlwvSW+bDIOzeouNo+U+BRRm/KY
         ljsdQTylM4aimbV+j8k1aVsVJHGDR1EWWW1bcD8M35Vu6Z9hdnqhnljRR+Jr/C5a0HE8
         fcSA==
X-Gm-Message-State: AOAM530ND6v3C//tPM+LxU6/mpM7WX1Z2qnSDSLiGeUsoNeVM2GhGIqT
        64UhbhqRiMgrTy7CP9Linf0fR0XLJlg2wsEyt8TSaxsa
X-Google-Smtp-Source: ABdhPJyc3yf5b+giWfAJR/IKrtMpOEKm9MkoB7Nig5gfHgljuX+Bz6FEPvX/7dvBpveqA8Wg8oy9g6CIr9kqTBf8XXc=
X-Received: by 2002:aca:5c84:: with SMTP id q126mr5566490oib.71.1601897688846;
 Mon, 05 Oct 2020 04:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201005112522.uzs2iax3umhxvtcl@vireshk-i7>
In-Reply-To: <20201005112522.uzs2iax3umhxvtcl@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Oct 2020 13:34:33 +0200
Message-ID: <CAJZ5v0gMU6wne6E70Wqs-6Shp8PUFpd4hqPnG4RxnVOGJUT_Eg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.10-rc1
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 5, 2020 at 1:25 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Return -EPROBE_DEFER properly from dev_pm_opp_get_opp_table()
>   (Stephan Gerhold).
>
> - Minor cleanups around required-opps (Stephan Gerhold).
>
> - Extends opp-supported-hw property to contain multiple versions
>   (Viresh Kumar).
>
> - Multiple cleanups around dev_pm_opp_attach_genpd() (Viresh Kumar).
>
> - Multiple fixes, cleanups in the OPP core for overall better design
>   (Viresh Kumar).
>
> -------------------------8<-------------------------
>
> The following changes since commit a4501bac0e553bed117b7e1b166d49731caf7260:
>
>   opp: Enable resources again if they were disabled earlier (2020-08-20 11:30:22 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to a5663c9b1e31c00e0bdfaf4d92eb51358fc3950f:
>
>   opp: Allow opp-level to be set to 0 (2020-09-16 14:02:34 +0530)

Pulled, thanks!
