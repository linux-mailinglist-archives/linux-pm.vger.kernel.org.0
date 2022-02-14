Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4443C4B458F
	for <lists+linux-pm@lfdr.de>; Mon, 14 Feb 2022 10:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiBNJXT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Feb 2022 04:23:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbiBNJXT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Feb 2022 04:23:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69060A85
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 01:23:11 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b38so5556506ljr.12
        for <linux-pm@vger.kernel.org>; Mon, 14 Feb 2022 01:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=356urLSOZJtLDmx8ZJRvuR2tZ/D2/VwMXst9vpTFk54=;
        b=Z+xboBH9ewqYE4OA7YRMAkbROwS4qmUA/yfeiKUplCmWDXxs4Ixnd71YT1Z1FVHX1D
         RkCKjqDifBlW1sghevfef0cvtx7R8YCnww/905OXD0bI3rBRFl3QG8H0AH3aOm6QPt9A
         lKSOK/lO3yAF2vQW5lnupEPLN4WpAriBQgSNOIM7pnAhzkzXlsB6uz50JDkkZTP0o9vr
         UXO1wgzj8oT0lw22CQsU4z6lTDyeeyinIDSh9gZBrYMoyXAU8y5Z+jvRZ8PvHEmmXmrT
         Ehu1UxASAf54ZIAA+ahcc5fRCdZq70qHcIl5Hd3aorS7zPq3pbPXFmDtYKzDlPHYvs4S
         d63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=356urLSOZJtLDmx8ZJRvuR2tZ/D2/VwMXst9vpTFk54=;
        b=pxO9FWji+cUnREeMfWHg8rHaI2SJs3Q7fk8JmRSdDJRW7jSRTqSv+EeWMvhfz5VSZc
         3rDx41Z7HrE+Mdv8G7oJn14qnmfQl/pq/DwMwLzM0Z/MrxD7tKajCexjH6mxc+t43W2a
         j3AjnjphRsOq4x3CFg73s/3ebPLHWkhdEs/ZsLT5po4gF05vuv85I3BYWpFnXr+N2ajh
         HzOJFBFLi0ypJ9G3q9BRlLa64JgOJkhcS+KnfxVM/MzocYuWS4ihrlR0rwZ5+5VJbE9I
         /3IpeuTdQaJSnqrqrK7/zlDGasCvZrIn4luPzapst+/Wubw6UrIhqndwZAjCSUT8hYep
         u56Q==
X-Gm-Message-State: AOAM5311ou2fJB2vAhF9noz53euH2UxXk6J56j5Tx9dK/5erAvM3h9z+
        b2qdVcRNvQ0dABfY1NXqz2iVm139vyTb3PX8cfzKHA==
X-Google-Smtp-Source: ABdhPJy3vcaD+3nckysYlkRQnrs/J9wyitdDSdd2mYpvMaa99GIJ/5A9elwqUUBT/4WzicPlZFl41eZtffOQOs7Mn7k=
X-Received: by 2002:a2e:850e:: with SMTP id j14mr8440677lji.463.1644830589879;
 Mon, 14 Feb 2022 01:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
 <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com> <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
 <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com> <CAPDyKFpLX0Jpz-tzYx3-g0YBZZNh6Bw731gQEFQub1SviLGoYg@mail.gmail.com>
 <2656099c-76bc-33a5-3b98-c46858025955@gmail.com>
In-Reply-To: <2656099c-76bc-33a5-3b98-c46858025955@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 10:22:32 +0100
Message-ID: <CAPDyKFokevJSYoH009t3PA4h48tx-LK+DaWVpC_14L6xZF3iZA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 13 Feb 2022 at 13:14, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 07.02.2022 11:43, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> In general, such changes usually are deferred from being upstreamed
> >> until there is a real user, otherwise there is a risk of cluttering th=
e
> >> code with unused features. Do you have a time estimation in regards to
> >> when STMicro may start to benefit from this change?
> > The STMicro folkz are working on it right now, but I can't give you
> > any estimates for their work.
> >
> > Moreover, I think the important point in this regard, is that the
> > $subject patch doesn't really hurt anything else, so then what's the
> > point of holding this back?
>
> If that work will never pan out, will you remove the unused code?

Sure, I will continue to monitor the situation, which is what I have
been doing for many years by now.

In the past we have agreed to add new things to genpd, even if those
didn't have in-tree users when the changes went in. The current
dev_pm_genpd_set_next_wakeup() inteface, for example, is still lacking
a user upstream. It's a balance, because I certainly agree with you,
that we don't want to carry around dead code in the kernel - unless we
have reasons to believe it's an intermediate step before there a user
turning up.

Kind regards
Uffe
