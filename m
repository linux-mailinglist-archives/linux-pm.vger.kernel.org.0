Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766A2335B2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 17:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgG3Ph2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 11:37:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44024 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgG3Ph2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 11:37:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so9871275ota.10
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 08:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2G9V05Uu/lFGXS5tkPLUREaW27ero6f6QDUOuZvUI8=;
        b=Uf92xmWSBQ+ZNGnfc5BkjkeUQPXAbhage4pxBmIXgiyXDbs5ecXNmtrnOlXh8D8nCx
         hgbU0B1ykyzFfvwpsHzv41+XPd3yqt+ZA2rO4Cw1JtQ8SdP4m64UbPGufkoEYvrOKdqa
         QAt+QhuKjm7ZRhEOoOsJgqT7T4p2LdNfIm6xhAnfevk06/TnlGpc5jzscDpPeaupDy0M
         +/DczvnSUjqOmsRol9RGpfXS+LJAg275o2yIS/VrnanNSa4j4zYSupQnWyoznfbFJVT/
         N5cidRG7OfMut8BAxW7+8VBtlA43MWRDY+lnqvZglVj1YHm+6rhdG5Pb5tOvXGq5qv20
         jGug==
X-Gm-Message-State: AOAM530yApFgQ29XjTskZ36gTR4g3Jjeauor1fw0uSok+dGyyWURK63D
        ayL++bKG0HC/qV7TFVJcbiuAgoI7kWtbSsxSKJk=
X-Google-Smtp-Source: ABdhPJyxWDqjJJD7i8c/NtPlfbv8mPRk7YFbe34Z7TWr5wmZdglajjlftODyHOpYyHRXmGv1LDA51QjsBX1giLqkyyQ=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr2783662oth.262.1596123447642;
 Thu, 30 Jul 2020 08:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200730045842.v6sei7nh2jc3cjwo@vireshk-mac-ubuntu>
In-Reply-To: <20200730045842.v6sei7nh2jc3cjwo@vireshk-mac-ubuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Jul 2020 17:37:16 +0200
Message-ID: <CAJZ5v0iwua3JpSkG0psiuxgGjSQbO8UJ5fpLDy4eAdtGiKNCww@mail.gmail.com>
Subject: Re: [GIT PULL] OPP fixes for 5.9
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thu, Jul 30, 2020 at 6:58 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following changes:
>
> - Fix HTTP links (Alexander A. Klimov).
>
> - Allow disabled OPPs in dev_pm_opp_get_freq() (Andrew-sh.Cheng).
>
> - Add missing export (Valdis Kletnieks).
>
> -------------------------8<-------------------------
>
> The following changes since commit 6544abc520f0fff701e9da382110dc29676c683a:
>
>   opp: Increase parsed_static_opps in _of_add_opp_table_v1() (2020-07-16 08:50:54 +0530)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
>
> for you to fetch changes up to 06a8a059e88bd73ee81a4ad19e97c04766f84def:
>
>   opp: Allow disabled OPPs in dev_pm_opp_get_freq() (2020-07-24 08:05:54 +0530)

Pulled, thanks!
