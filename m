Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FA636E76
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfFFIW7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 04:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfFFIW7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 04:22:59 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4446020866;
        Thu,  6 Jun 2019 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559809378;
        bh=gKzN6z2+9cSG7vi6DKtDlhAy7Iw5t3nBvZYXPHQIj1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ngnHK3kNT6Ik+jknuJxz4usImOs/0J8Gk+RBc8GNl0AG2gjt4wv6RbT8zFJntNpXK
         eoEwFyqomKLEQZvuseLDDyPFqnRcSCi/wQ33maV+kohnGEdLOugSVFujy2X6Te0Vq8
         s8fceHyGR5sW63mBr6zWSlZ9uOgGck9w5ZO+UZfQ=
Received: by mail-lf1-f41.google.com with SMTP id a25so902750lfg.2;
        Thu, 06 Jun 2019 01:22:58 -0700 (PDT)
X-Gm-Message-State: APjAAAW8WFdIRwRt9SDiHMGc5P0mqL/ansGdDRxaq7J6LJJaSYjPgE8T
        NyM66RSuOGKbNIF5OR0khiInXgSB7qzy+z//7VA=
X-Google-Smtp-Source: APXvYqxpSKprvvtB2rb8p/kAr5+gW8AhO5iZBE7iucDogxLrho5mwGpIFgmnHkQoZ9aRJKhbX6ibXh991STqtmR31zU=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr8401245lfi.159.1559809376572;
 Thu, 06 Jun 2019 01:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190605165427eucas1p27610c38c96313dd80ab445472735a242@eucas1p2.samsung.com>
 <20190605165410.14606-1-l.luba@partner.samsung.com> <20190605165410.14606-2-l.luba@partner.samsung.com>
In-Reply-To: <20190605165410.14606-2-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Jun 2019 10:22:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdm3FG1KE+JmKx=P+7CK6NBWY3fOiO4OvTxibGsrUxWBg@mail.gmail.com>
Message-ID: <CAJKOXPdm3FG1KE+JmKx=P+7CK6NBWY3fOiO4OvTxibGsrUxWBg@mail.gmail.com>
Subject: Re: [PATCH v8 01/13] clk: samsung: add needed IDs for DMC clocks in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 Jun 2019 at 18:54, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
