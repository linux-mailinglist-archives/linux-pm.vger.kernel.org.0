Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C872CFBD1
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgLEPnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgLEOvX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 09:51:23 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FCC02B8E7;
        Sat,  5 Dec 2020 06:50:33 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b73so8911036edf.13;
        Sat, 05 Dec 2020 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fE7hhQCsZ0dxRQftIk4H5MLE1LJWvrYc+nxt72jtj2c=;
        b=caEhGBt0PVlv8f9SxJ5d09x8H7ZVsXon9H7vfQMlQ4gZbfnZf+SMX4spPtf5O/FxaD
         SmuhzaqwR+zz5zKXtodJcoQfFiXwxx2Bdwbmx02XPsrPK2m0oCxG4QdHbHTNW5L+KtSF
         Idn9zHfayVE1PkzSI6U8y2081E9BEvIs+oXRGfNqPa5lN6AI2dV4Ec7eAKXH/ibQlskI
         kYVwVStaTIgeHbmzR9PKaVg8k2rRKNBvaHlZ/+b1JXjczClZORn4AemTQ2AABbjELFEN
         N6KRUTSsuG9mYBne36UTPYwqa9IHw8esXnkATEWDH+gYbVJXm4sFhXv5cC6WeTuQJPMO
         m55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fE7hhQCsZ0dxRQftIk4H5MLE1LJWvrYc+nxt72jtj2c=;
        b=hxTXQeYECoh3DwNBqslj64f3yvPylFNtRCrYytYHq0TlPOoc9RjWPN1NmXD+WMnDc/
         LGkUVoAQswIMxj3GfwONOsbPA4BiNAXUDRGR8wzkmKolgsT6XSliOBE+9ZcsiL1VOLzO
         4I74VwLj1W+Bgzaq0YYpoWPDjFj+Nrv586WhmTt8RUtyDySCeDLvOAmoN8p1pHabz2mk
         OCtnAU8eAUhjwltmrM30dQk++4ldI5QVBBvJos1jhyjEk5aAucRxm5y18xz1itb3soDl
         xizXycO/zpC1cmH+9gU0IAxqHu780d5Ff/s0doxlx7fgAOBhVstZFG0ohHPRcxcp6+tv
         Ggvw==
X-Gm-Message-State: AOAM532gJfD5tUElxV/OHF0QZSfdV3bgPpgnnB9Xd8c4j/zioftceR81
        kICL/REQ/cPBWtlqIU48ybap8z6BY2c90KGl8SE=
X-Google-Smtp-Source: ABdhPJwO6r2XwZQ4VgYoSwl6u3ZpXZ2lwSq6bLqK1/RkxaWHcw0xhvmV1lhhrnS+B+KwuEarPyXhgSt6sihPxLJJKZQ=
X-Received: by 2002:aa7:c0d6:: with SMTP id j22mr9178723edp.31.1607179832552;
 Sat, 05 Dec 2020 06:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20201204070901.24592-1-huangshuosheng@allwinnertech.com>
In-Reply-To: <20201204070901.24592-1-huangshuosheng@allwinnertech.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 5 Dec 2020 22:50:18 +0800
Message-ID: <CAEExFWvbNBg4hFZAHwh2X8mM+rMHrCN_gy5Vhh4z5rQyt512qQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: sun50i: add a100 cpufreq support
To:     Shuosheng Huang <huangshuosheng@allwinnertech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, jernej.skrabec@siol.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Maxime,

Any comment?

BR / Yangtao
