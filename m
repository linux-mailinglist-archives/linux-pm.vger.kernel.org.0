Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB1255CF1D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2019 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBMGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 08:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfGBMGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jul 2019 08:06:30 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9660F21851;
        Tue,  2 Jul 2019 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562069188;
        bh=JMUvbK/LfOJhb6Ete6QNsOakQUnGfCiPzMOmNQ6+NCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HwC20ALa2Bz/YOW4FKBF/0iy/VmbQeOGBkAAkPTbw4EE8VmR2fSspfXMqIqwBdVc/
         zFjLG4As/+XHC/UKUp9UeDb1GP5DlrEAxFpWnUT/UA0QODaoSD5VDW5BRnZQkzNU7U
         H+wq0YOGmgvMgbg3tmtNjBKsB7mFNNQ1FiH5MGuI=
Received: by mail-lj1-f175.google.com with SMTP id p17so16648026ljg.1;
        Tue, 02 Jul 2019 05:06:28 -0700 (PDT)
X-Gm-Message-State: APjAAAUr1uZ4khOmwGJGEWjlGlNrEcklBi3a+VGqK2KhyTPKYszaSXmj
        C89t7oVNmtl3OeBRKrhrPO0hMOEeXpNxT1jeg3Q=
X-Google-Smtp-Source: APXvYqzUYFM/EIyZphFmV/SpQwmAz/C+DNi3kHPWXR6+ebp2/C/4bHX7aVTINZ72IbXpXBNvNjj3Ls2f2eDhzgGnXR8=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr16985058ljg.80.1562069186791;
 Tue, 02 Jul 2019 05:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190701131152eucas1p2c5ac5f1611fd07e3b7a4ad289abe3e81@eucas1p2.samsung.com>
 <20190701131138.22666-1-l.luba@partner.samsung.com> <20190701131138.22666-4-l.luba@partner.samsung.com>
In-Reply-To: <20190701131138.22666-4-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 2 Jul 2019 14:06:15 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcc3q4_GLg21TL=xNO5U1Kp9ZHqpSERHFVCi8OLasgm3Q@mail.gmail.com>
Message-ID: <CAJKOXPcc3q4_GLg21TL=xNO5U1Kp9ZHqpSERHFVCi8OLasgm3Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] drivers: memory: extend of_memory by LPDDR3 support
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 1 Jul 2019 at 15:11, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> The patch adds AC timings information needed to support LPDDR3 and memory
> controllers. The structure is used in of_memory and currently in Exynos
> 5422 DMC. Add parsing data needed for LPDDR3 support.
> It is currently used in Exynos5422 Dynamic Memory Controller.
>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/memory/of_memory.c | 149 +++++++++++++++++++++++++++++++++++++
>  drivers/memory/of_memory.h |  18 +++++
>  include/memory/jedec_ddr.h |  61 +++++++++++++++
>  3 files changed, 228 insertions(+)

Hi,

As I mentioned before in v10, I can take entire patchset through
samsung-soc but this one patch requires ack or at least reviews.

Best regards,
Krzysztof
