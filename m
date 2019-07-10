Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C55D64B2E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfGJREt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 13:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfGJREs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 13:04:48 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55E3F21019;
        Wed, 10 Jul 2019 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562778287;
        bh=km9vPhTYYLcAIVJu82GKQsQYAIy+sydY/n0IPVosDgc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QEdrpaFHEh3zW9nuvHZ2o0yq4u5FY9FL+bVTPcBgZUHm4q/qQAxpw8MsX+rC4tNe8
         nmiubxPig3xHGBJxnnEDuewzemKphiwkiqIPluplYGE9HBxTmKssI2IJNqKwpxFm7N
         xGnFqer8J+u7KD4dmyfWWG/ZMt1mJyqMYso3iU+Q=
Received: by mail-lj1-f173.google.com with SMTP id 16so2809984ljv.10;
        Wed, 10 Jul 2019 10:04:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUmygMWAJMNm1/IjEaYwcRkrzqKmHGf6OmwQIUzVzcAEjpEoM6O
        N/TiXoe7xPSMy7yDhhknipBYyehfZND+/VdgwH8=
X-Google-Smtp-Source: APXvYqzfmGhkpnNV2qvF32P4a3uf1qBrtt+rh5QtV7zEQaa2I7op29+r7aQ7NFhCLGgPnbKn++N3IYyRGjYZWs6YKD8=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr17994402ljc.123.1562778285653;
 Wed, 10 Jul 2019 10:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141200eucas1p144ca3b2a5b4019aaa5773d23c0236f31@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com> <20190708141140.24379-3-k.konieczny@partner.samsung.com>
In-Reply-To: <20190708141140.24379-3-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 19:04:34 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfWr-2t_e3f6oi7E6KLLRAbskzgEKz26XyK5n_9C8wV1w@mail.gmail.com>
Message-ID: <CAJKOXPfWr-2t_e3f6oi7E6KLLRAbskzgEKz26XyK5n_9C8wV1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>
> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>
> Reuse opp core code for setting bus clock and voltage. As a side
> effect this allow useage of coupled regulators feature (required
> for boards using Exynos5422/5800 SoCs) because dev_pm_opp_set_rate()
> uses regulator_set_voltage_triplet() for setting regulator voltage
> while the old code used regulator_set_voltage_tol() with fixed
> tolerance. This patch also removes no longer needed parsing of DT
> property "exynos,voltage-tolerance" (no Exynos devfreq DT node uses

Please also update the bindings in such case. Both with removal of
unused property and with example/recommended regulator couplings.

Best regards,
Krzysztof
