Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6E1026E
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 00:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfD3WeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 18:34:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46974 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3WeB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 18:34:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id d62so6769759oib.13;
        Tue, 30 Apr 2019 15:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZTqCa3AIXQb20rc9OGWF2QrGei4mNnBxlrSSYSx/To=;
        b=GJuoz4GfJapIMVmfjXBooL0yBT2XxPJYKyvFZhcAhe2xS+WWQgYI8ERQgXJCY1Xi/N
         8jIqzj7BfYxl9yYI7ChYQbTaiyrb42LpyDxuy0bYqwbhM39ag28MHTvd6EA3ymIy0g+K
         0zjGCuVhyFV9jl5nbN6yLcZFAYu4E3ekDmuse2OKE55goJmAbFXBae+QwvirYhVbTrbJ
         Xfa7bQLrDapB8ojnk/SW5sgkX69KDPygBoY0pcUpg8QO3kl5q/jRL8YHxNcZ9X6fEvpq
         XtUkycY3VTfwnXIUgtAJ2DGpZJZda0Ct8B+VPUHtI3G2Y+oUAKud4CZOgZvg7iGoO350
         eKUQ==
X-Gm-Message-State: APjAAAW6UekNVB7xUtAs1BOY3TFTBzJpE/pmHbiVrcF91px1ocL1dd/0
        VR1f6bIzLRVgRxEz4y2ICQ==
X-Google-Smtp-Source: APXvYqyCsbTEtIZQBiuIBxBRvjzb3/jJTAiiTp7TDtDYWThj1hacxlTQvWm+ptlnPK+51osCgOUQAg==
X-Received: by 2002:aca:da43:: with SMTP id r64mr4612883oig.11.1556663640104;
        Tue, 30 Apr 2019 15:34:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm10782188otg.10.2019.04.30.15.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:33:59 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:33:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
  Unit for Exynos
Message-ID: <20190430223358.GA22052@bogus>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
 <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 19 Apr 2019 15:48:05 +0200, Lukasz Luba wrote:
> This patch add support of a new feature which can be used in DT:
> Performance Monitoring Unit with defined event data type.
> In this patch the event data types are defined for Exynos PPMU.
> The patch also updates the MAINTAINERS file accordingly and
> adds the header file to devfreq event subsystem.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                           |  1 +
>  include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
