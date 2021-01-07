Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10522ED55E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbhAGRUS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 12:20:18 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39751 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbhAGRUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:20:17 -0500
Received: by mail-ot1-f53.google.com with SMTP id d8so6977040otq.6;
        Thu, 07 Jan 2021 09:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+Zedt4k/T9pSHaf01QgRJf9DCdeN8yv0JnBO4IXQsQ=;
        b=gIHWSNcyps6sJiN4haxrknNS5G36/3EjDgvcCeIIQEsaJzgw9vhmkONoiaGLDu1gEs
         d2pxS9XOM2ESiF7SHNarpa1RVZ/nb3AobNBSE6obpGHuYmawovxNGfMSC6apb1f2TlFs
         3gAcplElaxOuz4GSLUbGePYH1fK0ZG4nzF35+UzpIdmIx4FRAvPtlBdc3fbcZA4QfGNd
         Wa9XYP3Z2XRL5cRhVTh72mmNJ2P7X+bT+RV0lx/XYgMLmTVlG835DYr24HVguoIkR4Ym
         k/lXmMPRHMxSFhlfZJ1VhgTZCToHwNnw4P/UhkASzvhxJ22+IaM/rBKMhbzX2mlYe99H
         eUHQ==
X-Gm-Message-State: AOAM530blphrrnnWHrvGuVHxKJ1FCRjN4bZwGN43P4yizdxmcBW3TESz
        5YYGTZz1owEC6MtF/PncZYxs5nKTViamZQE/GOI=
X-Google-Smtp-Source: ABdhPJxUIjQJEYhdFgaF38kovk00tM4dcDrDsWp+FsGXpzvsG1xeHU5Un6GHnb+5FEceU2naPb8TeZKDjdKwbsvLd4Y=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr7368214otn.321.1610039976931;
 Thu, 07 Jan 2021 09:19:36 -0800 (PST)
MIME-Version: 1.0
References: <X/V8zHPwlGiSxq1M@mwanda> <5cd25798-5dc1-4e8b-61a6-5a5f425f9473@linaro.org>
In-Reply-To: <5cd25798-5dc1-4e8b-61a6-5a5f425f9473@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 18:19:25 +0100
Message-ID: <CAJZ5v0gvT07A8Edf-NqwnBkcPnCciht52pm33VjDdbS=1qbEEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] powercap/drivers/dtpm: Fix an IS_ERR() vs NULL check
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 7, 2021 at 6:04 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 06/01/2021 10:03, Dan Carpenter wrote:
> > The powercap_register_control_type() function never returns NULL, it
> > returns error pointers on error so update this check.
> >
> > Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Thanks for these fixes.

All 3 patches applied, but as the original DTPM changes have not made
it into 5.11-rc, all of this is 5.12 material now.
