Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312F833958
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2019 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFCTzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jun 2019 15:55:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34457 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfFCTzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2019 15:55:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so5727009qtu.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2019 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KV1EL2zWlz4BNwMzZsPPlusL/bx0yMiXCoqZlXd458=;
        b=f/VSrUxboXoGFGdWMMd2FDeP8+ypIq64epfnLR1+dKU5NMMKQvoEkLcb1gXkzsU7wz
         Jn/pM2dph432cJm0hpfUrbOa2Iqat6S2Hn2aMVwbuIRid7V89u8IdB8eypsxoOh4PeC4
         rCN8Cqwz/u6w2Yn0EgkhmvpUsMx+j0EiV1hm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KV1EL2zWlz4BNwMzZsPPlusL/bx0yMiXCoqZlXd458=;
        b=KpFcFod6jkuoLucMr2P/98BLKVLG4Z+AlwEbYh4IERcPjJkb5LC5Sm9LuyfBEGQo1+
         uM9KBMKLgAT7uWWrvHtAUK3Aj0UJk/O7oTHGm0ndxPfgzMOl19PYxzT2zwVE9s4XZswK
         WzTxnV1OOW6GG/GLxIkorZUCE3MPPWywsRzkAXK7ZQ/YGQnNhEIhYYvCP41QtvXxr8Yi
         eBIGGDrh0UjZfUYc9rMZ/qCDcMHuFwfiWtfvTLTzUSzuWf9VwZeM5qVCzFmTCFUc/WUC
         TSoeI6qZblujQHrlJQOzRuO6BxwOVBP4JTzUj6LER73Qwvv21sePRjem2NHY6hl1uFLX
         XUBg==
X-Gm-Message-State: APjAAAVlHBbE0EEaj0E7Rkg3iXiqevCpkgTMScZaAmsvHv4EUAYoodrx
        b9F89G+5P0osXVvXntcL/rfVRwsFCb+IGG4rVLSUqQ==
X-Google-Smtp-Source: APXvYqw9CyjBN9zLt670R7s4Nqh+tF2Uw/nqdK92LwjcIbHrzECu2UzbVydDyKivYV7rqUCst1Zpy0CU03QqWZF+nkw=
X-Received: by 2002:ac8:2906:: with SMTP id y6mr4604304qty.138.1559591717763;
 Mon, 03 Jun 2019 12:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190522184547.31791-1-f.fainelli@gmail.com> <3734641.73qX0VsHyn@kreacher>
 <013ec7c0-0984-cfc9-ea3a-0180719f5ac4@gmail.com>
In-Reply-To: <013ec7c0-0984-cfc9-ea3a-0180719f5ac4@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Mon, 3 Jun 2019 12:55:06 -0700
Message-ID: <CAGt4E5tZ1YLbtCDJDXTTZrH5S4Jmw_BVOfz+i-KF=TUjA=yvkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: Couple fixes
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <code@mmayer.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM STB AVS CPUFREQ DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:BROADCOM STB AVS CPUFREQ DRIVER" 
        <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 29 May 2019 at 10:02, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 5/27/19 3:51 AM, Rafael J. Wysocki wrote:
> > On Wednesday, May 22, 2019 8:45:45 PM CEST Florian Fainelli wrote:
> >> Hi Rafael, Viresh,
> >>
> >> These patch series contains two minor fixes for the brcmstb-avs-cpufreq
> >> driver.
> >>
> >> Florian Fainelli (2):
> >>   cpufreq: brcmstb-avs-cpufreq: Fix initial command check
> >>   cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency

To both of these

Acked-by: Markus Mayer <mmayer@broadcom.com>

My apologies for the delay.

> >>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > These look straightforward enough to me, but it would be good to get an ACK from the
> > driver maintainer for them.
>
> Adding Markus' other email address.
> --
> Florian
