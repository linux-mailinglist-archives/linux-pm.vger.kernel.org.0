Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C19A2B080B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 16:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgKLPBn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 10:01:43 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45588 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgKLPBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 10:01:43 -0500
Received: by mail-ot1-f41.google.com with SMTP id k3so5803158otp.12;
        Thu, 12 Nov 2020 07:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAUelRMcvAJXaXpipWJpdYSsCWDu43G8R6f9TrGJYRo=;
        b=lXTNSI73uEzOzPPNbIu2beTBM4W48v+ocB8uAtstrbiJUaevrLbSr6BgO8V6RJMCW5
         r4UjmWDDUTID/kRs8FEi11jKzqXMWE08O4WRDxT+18cN1mFbv+eDzetYsPuOkvHup1+9
         ur8BDpyznH3W9lGBCju8I3/45UeDlj5eVxqtjOpTzPNHL00RNXGVvbGRkci4EVVYKa96
         +HKkseB+YFJMWuAVpPnPpnbIP2Xylh3wAzwAGcegdX7IuvrC93If4/Pb00hohh4MNNa2
         ktiWdRcPHHSYuMYtIzluj2SPh8X337/OuIun1AdxRFMCu92S+UYsR3PQO1NKhAdNgYLc
         bjjw==
X-Gm-Message-State: AOAM531xwws5jv+gzSRC/ngGfC3u2aCTScSLH9K/KMc2qHBViUIlV70k
        e+DQpGBk8jL9oDeCqjDs4bbUvaTwY/9ULHZL8qb+lwXv
X-Google-Smtp-Source: ABdhPJyh+CQMhwVGiTecjsemaPnz6Y/GlLiHpgBP3QMFbhgwhmF8pcIqLWXomCAPJfpV6mjEhuBVtAkOjAq46MrscPI=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr22669238ota.260.1605193302680;
 Thu, 12 Nov 2020 07:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20201109032115.10610-1-rdunlap@infradead.org> <CAJZ5v0jhJcL6uJw_Cm02SeUMff_s1L-mKzX3haAyejcCkKihNg@mail.gmail.com>
 <20201111083041.698a561c@canb.auug.org.au>
In-Reply-To: <20201111083041.698a561c@canb.auug.org.au>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 16:01:32 +0100
Message-ID: <CAJZ5v0h3qD2M0L+4gh7fgL0B282O9oE0WF4arqOb+f_EHxei_A@mail.gmail.com>
Subject: Re: [PATCH -next v2] clk: pm_clock: provide stubs for pm_clk_runtime_suspend/_resume
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On Tue, Nov 10, 2020 at 10:30 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Rafael,
>
> On Tue, 10 Nov 2020 18:43:04 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
> >
> > Applied to the PM tree as 5.10-rc material, thanks!
>
> The problem is that the commit that this one fixes is in the clk tree
> not the pm tree, so this patch needs to (also) be in the clk tree to
> reduced bisect problems.

OK, dropping from pm then.
