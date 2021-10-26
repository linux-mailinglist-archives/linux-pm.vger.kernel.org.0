Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2061643B2F2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhJZNM1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 09:12:27 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38697 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJZNM0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 09:12:26 -0400
Received: by mail-ot1-f43.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso19707533otp.5;
        Tue, 26 Oct 2021 06:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9PrHpMnBVtvWr00+icxRV4av+NKqhl73Kg/aCTsavk=;
        b=lQT20vlzl1Ff2fFK4rfN1FZipKO1Ly7t1knjRSK6yHfoiqHosbRnwexZ2jK0QocNqC
         Sn7mOtq3/ZZVIIIAIxEBXwpOWuWz7UgIpDgBOfOMi3wbfzgh6Qta/7dPMyZoXuGELVXU
         V9XnjZgCJMKbql1bnJH/UqxG3E7GeJBKg49vFn9wUUz0CXiLeAkUSR6Sg0Tj6FIb4eV4
         l7H/wlUMEjv/XpINnoH1vHwwD+A9iqnjbVYEFoTJWw+9YxUeUcFrLbm2yCTDnwuy0I58
         Q/K/rbb9ZmE9pLDOY/q2O++Ch4YMKbV8sM0AKh3c4cpc9c25n2m+yEmYcO980AGv0QV1
         86yQ==
X-Gm-Message-State: AOAM5301NMpEkYy8kFM3CB1gxpsPdbzYwNRpMw/Rr1ita6SPoqKawkXF
        qa1ehwyw4kbP4Q7TQLCrPR0/llXnMB2+3pm4MJs=
X-Google-Smtp-Source: ABdhPJyhl16PtCJ+HSjPyqHkqzZ9nwX8Zpr5Oo2rkx14ciXc+GlrGiEh6rYdrqKtNPiQ5x6XYX0v1USyfvuNcD0FcgA=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr18935202oth.198.1635253802151;
 Tue, 26 Oct 2021 06:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <60a16c62-d14d-6943-f163-b2cc3d05c3b0@linaro.org>
In-Reply-To: <60a16c62-d14d-6943-f163-b2cc3d05c3b0@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:09:45 +0200
Message-ID: <CAJZ5v0imARUv4-eQZFzhxsA-J1DcNuLZOL-AcUoe4Fevmuqg_Q@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.16
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        liuyun01@kylinos.cn, Johan Jonker <jbx6244@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Yuanzheng Song <songyuanzheng@huawei.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 22, 2021 at 4:32 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
>
>   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.16-rc1
>
> for you to fetch changes up to a67a46af4ad6342378e332b7420c1d1a2818c53f:
>
>   thermal/core: Deprecate changing cooling device state from userspace
> (2021-10-21 17:35:11 +0200)

Pulled and pushed into linux-pm.git/thermal

Thank you!
