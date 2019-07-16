Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539646A4D1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfGPJXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbfGPJXI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 05:23:08 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502BC2184B;
        Tue, 16 Jul 2019 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563268987;
        bh=PamZH0A4WsEwIpGHaPzQA18kP5r8wzqlzFCVBoiw//U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xaoSJGSp/bSa/YG2kHH4N9lDRwqjYMC15hNuRbpfjt1PL27vfozjZpg2y/f1MVaI4
         KoAqZb3ZvVgbb8Rp3lw+u9OBakMWl0TGyeWR7cToC8Ox2gZ7KeRpqxi9qjZw1Sdni0
         ZEfrxc+ivfEK4XLVW+v2JaQaFsv4vMjqSN/V1bV8=
Received: by mail-lf1-f54.google.com with SMTP id p197so13144142lfa.2;
        Tue, 16 Jul 2019 02:23:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUpRG9BFc6zTcL9dNiHGAizB/GsFybWEHn8Dr8GHNazjbokwmBL
        a9frjrIOgAzCoPzra7F0uYXMoPoZ4m8/5ayc8QU=
X-Google-Smtp-Source: APXvYqwMDnsmib1AtItDB/KKKIU5Xhb3gP22wpBTO6Xd7+TU89iu7Eafe6jZHcILHZmz92UTgmXNMvLw4jIxyvWAj04=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr13598688lfi.159.1563268985590;
 Tue, 16 Jul 2019 02:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190715120432eucas1p1b32d72d239420b861bf8596d4e8a053d@eucas1p1.samsung.com>
 <20190715120416.3561-1-k.konieczny@partner.samsung.com> <20190715120416.3561-4-k.konieczny@partner.samsung.com>
In-Reply-To: <20190715120416.3561-4-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Jul 2019 11:22:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd6a5aLf1CEhx9m7khPQOwruSuA22efkJb41BsaWXjM3A@mail.gmail.com>
Message-ID: <CAJKOXPd6a5aLf1CEhx9m7khPQOwruSuA22efkJb41BsaWXjM3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: exynos: add initial data for coupled
 regulators for Exynos5422/5800
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
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

On Mon, 15 Jul 2019 at 14:04, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> Declare Exynos5422/5800 voltage ranges for opp points for big cpu core and
> bus wcore and couple their voltage supllies as vdd_arm and vdd_int should
> be in 300mV range.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>

This one was previously from Marek, now it is from you. Any changes here?

Best regards,
Krzysztof
