Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AE4A9948
	for <lists+linux-pm@lfdr.de>; Fri,  4 Feb 2022 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358810AbiBDM2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Feb 2022 07:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiBDM2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Feb 2022 07:28:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFDEC061714
        for <linux-pm@vger.kernel.org>; Fri,  4 Feb 2022 04:28:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id k13so12279658lfg.9
        for <linux-pm@vger.kernel.org>; Fri, 04 Feb 2022 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5EE+DkLgmN23BbMUE4nz7OGjEySA8/7jVCGdyEuQd4=;
        b=l8iWC5a2b+sRIY7ZfxlfUPFTxvMH0CELbAuWVa9q815d/EK454CqeyWsNWJjCI9bl9
         s1Odh8R1pOW0uN0YRnccOsWreV3t8GUcThTUiLUSMv5BWfNBNvyPL25+S9bn8oI6QB+B
         yKlJXvcCk25Nm8qAuLZlHdfEUF7wf2zsPx8MrHkRWVB76FwvRbW73QzTRzSyqCI90xMw
         J5MRctd43fhRsfT+boL4RV5ziKMcPD0EJLbVVkhTfNmAA9ZUguhSqPHU7MCV0Fi7W8kd
         qaMf0mGSnD1XnRvY799LQaKjbNowpbQX39rCPeTtcVtPEST+9aYi9qu2fsqIHV4KeSyT
         g6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5EE+DkLgmN23BbMUE4nz7OGjEySA8/7jVCGdyEuQd4=;
        b=uLYfOlYYWu/2bMiHrOZRopHqd3fRStGh6jBXFIZyLv3MifVTUek2cf7yyBOIeuj/gg
         ttJrxcadWujtVsut+aYDDQ7jHbrv3c3jQXhjDYFmNg7ESTDMD2YgppEsYixxwTCUC8iK
         zDWGKVgb9+yb0Crcz6YFokIBjv1tuXr6hG2J4mujOQ+JElwnRHHzf0SXhDw7F5WE1zTL
         bonRdt25Kq9ARzMby1Zo4ccN5kkyWxqYLfKNXMm4KbPnIHZgMl1djm4/scZZhcNDoeM9
         4jJy0gwVyyJfwSF24aWNHT7uPDIAJ1cTuhxaGywzwQnAps46N2H9fabMgQWl9+Dr6vXH
         OEVQ==
X-Gm-Message-State: AOAM533DIf0U3qtq7+MjZYnOJGfm/vSNKRlxt9u09aVmmJdKltBT2w47
        gKRxcTtPkwLe0DQewFpqemkR878bjWmL+oFkXEMcU/oDv/+LnQ==
X-Google-Smtp-Source: ABdhPJxKiaraf1BxhQHs4VHBoTVENKbIOIstx8X8gx/Nh6NbS6taEj28l1A3fXhHQ2OUPqPHo2XxD9KaxtDCYCEMCWY=
X-Received: by 2002:a05:6512:ba7:: with SMTP id b39mr2169011lfv.373.1643977733643;
 Fri, 04 Feb 2022 04:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com> <20220125055010.1866563-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220125055010.1866563-1-kai.heng.feng@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Feb 2022 13:28:17 +0100
Message-ID: <CAPDyKFrtD28NKTyUAR-6Rt4PwYvkOuWcRhxZZWVAq4KcTNG7QQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>,
        Thomas Hebb <tommyhebb@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Jan 2022 at 06:50, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>
> Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't
> use pm_runtime_{get,put}() helpers when it should, so the RPM refcount
> keeps at zero, hence its parent driver, rtsx_pci, has to do lots of
> weird tricks to keep it from runtime suspending.
>
> So use those helpers at right places to properly manage runtime PM.
>
> Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> Cc: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

The runtime PM reference counting for the mmc host device is managed
by the mmc core. Have a look at __mmc_claim_host() and
mmc_release_host().

In other words, the runtime PM reference counting should not be needed
in the mmc host driver, unless there are some specific cases, like for
example during ->probe|remove().

So perhaps it's only the changes in the ->probe|remove() functions
that you need to fix the problems? No?

[...]

Kind regards
Uffe
