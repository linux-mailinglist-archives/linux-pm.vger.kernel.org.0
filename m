Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D9B45C14
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfFNMEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 08:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfFNMEl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 08:04:41 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCC52133D;
        Fri, 14 Jun 2019 12:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560513880;
        bh=kGiv727/oSO2xcvvP5CUDpg/Ry7P4YoUM9FlJGN0arI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pTpBBLV0MqxSpEyI9bzDDW8Zqjd6oothO2n0qrb6/E8VlRaIalUuyeuUZM01L/3z0
         7eExfwj1sMwzt+XccavUioo0XBT8AJ0hKMzo8UAig8BRYPtnD8Bc4UjYgtS2tbdmI/
         +XyoEVnqR9Q/ZYwGhl5X2kb3jNYxSxTTV3Uyj+n8=
Received: by mail-lj1-f171.google.com with SMTP id p17so2160916ljg.1;
        Fri, 14 Jun 2019 05:04:40 -0700 (PDT)
X-Gm-Message-State: APjAAAXyD5gihRCAole+pn+LWUDnCTkXbmnBXsL7TCg+kAzb5F2sz0qJ
        5SjCRuq7QGXGmzzrTjuF534lGdw5hjlnFhm9vtc=
X-Google-Smtp-Source: APXvYqyRrG8KU2Nodtv4PV8elpWy8ybJND0YDPhJ4V+FfX6qkFAt8W4A+VZMXPQ3fDrV2pshGC4N9PtVAltpOyJFO3o=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr14024186ljw.13.1560513878828;
 Fri, 14 Jun 2019 05:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095320eucas1p2919a6169c997bb81c80416e8a0ede538@eucas1p2.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-2-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-2-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 14:04:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeeVhHS62jiUgwySf5EYzW2Rkvu=HxyA7NjpGZFp=fWYQ@mail.gmail.com>
Message-ID: <CAJKOXPeeVhHS62jiUgwySf5EYzW2Rkvu=HxyA7NjpGZFp=fWYQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/13] clk: samsung: add needed IDs for DMC clocks in Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-clk@vger.kernel.org, s.nawrocki@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
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

On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

I do not quite understand why this patch is still being resent instead
of have been applied some time ago. Are there any issues here? Or are
there any issues with the entire patchset (except some review comments
to be resolved)? If not, then this is a dependency which should go
regardless of other patches. There is no point to keep it pending...
All other changes, e.g. DTS will have to wait for more cycles till
this gets in.

Therefore either please apply this or please comment what is stopping
dependencies from being applied.

Best regards,
Krzysztof
