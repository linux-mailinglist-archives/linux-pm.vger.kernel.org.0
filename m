Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4672C1B9FD0
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD0JYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgD0JYM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 05:24:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC1C09B050
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:24:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z6so6780143plk.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2020 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62sxPbsrxCm2fvIpJ8tpB4+O/E6FAUO1ubRiSS5aMQs=;
        b=PqkwdOV9sWGTFWFEwpK93utJLjznxrq9WB2g7q3+71ll4BiIeRtuPb+ynL2zXTe+Nr
         m1FfLsqEjWI8q0Ir9zWeZBQ1TzbPYwbUz1alfss91jOdDLIcQnVwOHgqhJnjSXatqq8n
         TCA/aUeHD5zilUdC3r50QHTAo7ow6caq+LkPzrGFb5FjU3YbfpUYUU0TvEQcBYSsfx08
         OsL3fcXvxI1Gcvat0hjax14vIxLSD/CeFJ0AMJ5SD3/IqM6mPuQxuU+KfC1JDHRmktRv
         bNwzP6r4PlUzL7vbiwLeUR6qcr+VJ26wQ5jfmfm7C/ODd3PFJ80O+/A9HzGO+7gkYSrL
         ISFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62sxPbsrxCm2fvIpJ8tpB4+O/E6FAUO1ubRiSS5aMQs=;
        b=XesmC1pDt/8BIcLX20IE76hZ8KsYetUcCUl4Cb62RGmUbjbrD8r1XPOcffjQEOyXUj
         GUqYoCQSjPQImM7hIDxSh1u1ulY1lbsI0ObnXrH7vLchTppC4RZy0pbMrPGdPWBMnw/0
         5YQ6kQ6uOPxEaN1XlM66U9sUH/rTeexCmyihTGSLXNQY9IBWpFFHt63hBhR0a/+Lwjob
         lWD9Qs7zUSj/Q1BISfmk+o57iDWITm9BDt3BGmDBpYh2R6q7k930CAmQ06YQLicFSt3b
         xUo5s0drEqgtTuZ/91KqDtZLUTkc6ZMiv5Zv/AVQK9l1C3FhMIw2bg9KBXzbK86vg5ya
         2Cvg==
X-Gm-Message-State: AGi0PuY3+Y3RcafGVEHFbMN68iyemhqTiwGj2lireyeHO3I/vA+oyijE
        OX7a6JopsifuKlC0CjAbHJFHtA==
X-Google-Smtp-Source: APiQypLoeg39tmPVj837ge/fvjEjwcaLKfMYIysT4UHtoPUQOPFkSmOF2zWgF54zZIpO9qIWwNDClQ==
X-Received: by 2002:a17:90a:1501:: with SMTP id l1mr21988435pja.82.1587979450837;
        Mon, 27 Apr 2020 02:24:10 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id l37sm10807183pje.12.2020.04.27.02.24.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:24:10 -0700 (PDT)
Date:   Mon, 27 Apr 2020 14:54:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 10/10] cpufreq: dt: Add support for r8a7742
Message-ID: <20200427092408.g2vpc6j2c6it4x2i@vireshk-i7>
References: <1587678050-23468-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587678050-23468-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV6J-_gBkzhUXtA8OrxhJVzyrAqjA8oeGJGBp86X-C3Nw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-04-20, 11:22, Geert Uytterhoeven wrote:
> Hi Prabhakar,
> 
> This patch should be merged through Viresh's cpufreq tree (CCed).
> 
> On Thu, Apr 23, 2020 at 11:41 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add the compatible strings for supporting the generic cpufreq driver on
> > the Renesas RZ/G1H (R8A7742) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Prabhakar,

Please resend the patch with all dependencies to me so I can apply it.

-- 
viresh
