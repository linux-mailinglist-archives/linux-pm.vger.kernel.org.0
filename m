Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAF45D07
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfFNMj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfFNMj0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 08:39:26 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB3572177E;
        Fri, 14 Jun 2019 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560515965;
        bh=h4+jr7GFm2wkitjdD2lHltRkw9ikoA87cqaxH5FXp1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCx+2Pta3PtS85q5AlHrTvrSwcwe51L0/A90JL8ILfjHRek1cKA8fmZHGs8BKbVDI
         IuSxe8YbpEV+bLkVHT7S9jMd2bF3e60Zbvpxlmzr6HBT/AuMPTJKYHbKNkDWsT+Adm
         NFKlvZF4X0lGPvv7g/5zIqG3CPnUxzq9FvsEys+Q=
Received: by mail-lf1-f44.google.com with SMTP id z15so1606465lfh.13;
        Fri, 14 Jun 2019 05:39:24 -0700 (PDT)
X-Gm-Message-State: APjAAAX97+za6pRpmgAmHtMYCA2aR9MSkYXrakPoYke6SX/iwwM5jZLv
        nPD0ij/NauyB1Q7wP5HJ6orWvJ3Ul/7gmqe0NeU=
X-Google-Smtp-Source: APXvYqzU4BYkdLXQ14moDZGW0N4jlP+pEkPQkjyQ1iy7sxRkDPxMnVuLMevSUvxQZ+wiK8Z5zxc1nfEIFrx9/KR3t28=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr47042701lfk.24.1560515963169;
 Fri, 14 Jun 2019 05:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538@eucas1p2.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-2-l.luba@partner.samsung.com>
 <CAJKOXPeeVhHS62jiUgwySf5EYzW2Rkvu=HxyA7NjpGZFp=fWYQ@mail.gmail.com> <cbfa8fab-7cd0-1508-7b9b-482fefdb4de3@samsung.com>
In-Reply-To: <cbfa8fab-7cd0-1508-7b9b-482fefdb4de3@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 14:39:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfmy6jKVF5f0vy9YOvbH8y0s_DHAR=P6+QbsRRHvLNd_g@mail.gmail.com>
Message-ID: <CAJKOXPfmy6jKVF5f0vy9YOvbH8y0s_DHAR=P6+QbsRRHvLNd_g@mail.gmail.com>
Subject: Re: [PATCH v10 01/13] clk: samsung: add needed IDs for DMC clocks in Exynos5420
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, mturquette@baylibre.com,
        sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        gregkh@linuxfoundation.org, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 14:38, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 6/14/19 14:04, Krzysztof Kozlowski wrote:
> > I do not quite understand why this patch is still being resent instead
> > of have been applied some time ago. Are there any issues here? Or are
> > there any issues with the entire patchset (except some review comments
> > to be resolved)? If not, then this is a dependency which should go
> > regardless of other patches. There is no point to keep it pending...
> > All other changes, e.g. DTS will have to wait for more cycles till
> > this gets in.
> >
> > Therefore either please apply this or please comment what is stopping
> > dependencies from being applied.
>
> Indeed the first 3 (clk) patches should not be part of the series any more,
> I have applied them few days ago - https://lkml.org/lkml/2019/6/6/554

Ahhh, I missed that. Sorry for the noise then and thanks!

Best regards,
Krzysztof
