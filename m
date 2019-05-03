Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7112C27
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfECLTW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 07:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfECLTW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 May 2019 07:19:22 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83CED206C3;
        Fri,  3 May 2019 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556882361;
        bh=UYFh2fznuaQspBCzomd2OghwGe6Z9MYbCrTWM3XoNG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HG+Oy2VpgrIi1Cch6D4HchqpzLMZ46CRPTgAIZvUE1G6AQZFfMITgO02NydGVgooA
         CWnK+/SQ2OfdlS0TKVCLaFSSRwd/cR/y8LnOWA9aPJhO/KZyL0R5Z9/72GjL0p9bir
         RRERQz44i313wNP6/8Ze7BH7//smOtdYqEovLNB0=
Received: by mail-lf1-f46.google.com with SMTP id h126so4151783lfh.4;
        Fri, 03 May 2019 04:19:21 -0700 (PDT)
X-Gm-Message-State: APjAAAW1Cf+Q66nlACvDIJzjSZAHZ8jFbl87J6ZP2tiFhwA0KRxIUReD
        PKJyTKeoHY1XrdGHy2YW143WDEX+3XrGFbOciQs=
X-Google-Smtp-Source: APXvYqxjSiIsSkOWkFFKQc0VvX9PMx8wSsDNflixMMiDXvGvhtL+PIknt+H/jFFWa/8RyhTFVN8QLdwyEWRmisP8Bto=
X-Received: by 2002:a19:189:: with SMTP id 131mr3170741lfb.74.1556882359840;
 Fri, 03 May 2019 04:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190313193408.23740-1-abailon@baylibre.com>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 3 May 2019 13:19:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeOnrgnX=onMeX1izS2kYKAkD8TvFVykYTyW-v4NOv3vA@mail.gmail.com>
Message-ID: <CAJKOXPeOnrgnX=onMeX1izS2kYKAkD8TvFVykYTyW-v4NOv3vA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     linux-pm@vger.kernel.org, georgi.djakov@linaro.org,
        mturquette@baylibre.com, ptitiano@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com,
        ccaione@baylibre.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Mar 2019 at 20:35, Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This series implements busfreq, a framework used in MXP's
> tree to scale the interconnect and dram frequencies.
> In the vendor tree, device's driver request for a
> performance level, which is used to scale the frequencies.
> This series implements it using the interconnect framework.
> Devices' driver request for bandwidth which is use by busfreq
> to determine a performance level, and then scale the frequency.
>
> Busfreq is quite generic. It could be used for any i.MX SoC.
> A busfreq platform driver just have to define a list of
> interconnect nodes, and some OPPs.
>
> This series is sent as RFC mostly because the current support
> of i.MX SoC won't benefit of busfreq framework, because the
> clocks' driver don't support interconnect / dram frequency
> scaling.
> As exemple, this series implements busfreq for i.MX8MM whose
> upstreaming is in progress. Because this relies on ATF to
> do the frequency scaling, it won't be hard make it work.
>
> As exemple, this series implements busfreq for
> Alexandre Bailon (3):
>   drivers: interconnect: Add a driver for i.MX SoC
>   drivers: interconnect: imx: Add support of i.MX8MM
>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings

Hi Alexandre,

I am quite late but I just found your email.

This looks very similar to existing framework - devfreq, which purpose
is to scale the system busses based on performance counters/events. It
would be nice if we could avoid duplication of existing subsystems.

Best regards,
Krzysztof
