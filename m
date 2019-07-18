Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C24BB6CCD1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 12:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfGRKfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 06:35:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44610 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGRKfp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 06:35:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id v129so18735060vsb.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPsZyaY1avB4NmRKihmlAbRWMA/+wWnkWYAQnUJy/uc=;
        b=hRS9tdns/W1JgD4gXX9suvoW/sEfa10WszlqRMNyTDVGE4pvXMTTfwq/5kkohrxDM7
         W7+I5ziWAyIuiHrX/lcoOj0SJw+f5YG4xCubaO4tE70Z+vieiYB4B26jaOQUvlMI4S+U
         xyN1krAtJQAXe2Vz8klpfFqYJMDNdZ8cfzuW9QcUmMv6R4UjK1Kq/58lPsgA4sCtpTzA
         0qFoFw674o5/tuQ1z4FPQeyxpwMSw1+qVsC8O6HgdTQBOqM/uGIyiyS0Pf5HCXETQW4d
         5Gyb4/sUE+H9nH3Nb/q1LqBqKoM5Uq2R4rYtA1XYgsHvHKaCOvYtSeHXrL6RULNV1DnO
         IYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPsZyaY1avB4NmRKihmlAbRWMA/+wWnkWYAQnUJy/uc=;
        b=M7xdaOnFFVc+BuVhFPJGWT8Lx5irlMUib8rpZwMoh9C4RlWNdOu6trWY3znmj3ZWgd
         9aV7HGa0GUyefc6VbIiOXyq8ra8G+e4rphOolYCpPSn9//aNFiFjkrj6iSMktbhhJBme
         pOWWWXK7N6o0rxJLndWxgtQkkFW2olsb66xK24CWjB/+s2ISnxBseFmpdkaBahui+wuA
         RcmI2Du3qr/SbuH/vg4HAP2/dZ+l1AFq8u2o+Gts9KgbutPvIzZg49fJnpOVq1XJo3ST
         y+3TY9xnfazr+QYlRpS+4Y14cNEbvQSVQXSvq7Xy9EXrSXbq69xBSrzrgIjaij1mu0Yo
         8CQw==
X-Gm-Message-State: APjAAAXzZUR9Hol4X8UHSJqkFFrT3Yt0vgEW/68bOISB8jJzJ45fKyJW
        utYV0ZMGZjAfHTBjlDH7ATsHaSHEJYh4JjrWWHxtPA==
X-Google-Smtp-Source: APXvYqzSx0aR/M+aRW6giaR+8hf163WchtvCdbWRJMcDQ/HVNG1W8viO5bTF5uxNvGiQXgL7jxarygjbk3mkugNqF9Q=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr28548547vsp.191.1563446144144;
 Thu, 18 Jul 2019 03:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190513192300.653-1-ulf.hansson@linaro.org> <20190513192300.653-15-ulf.hansson@linaro.org>
 <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190716155317.GB32490@e121166-lin.cambridge.arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 18 Jul 2019 12:35:07 +0200
Message-ID: <CAPDyKFrJ75mo+s6GuUCTQ-nVv7C+9YJyTVmwuBZ2RKFOvOi3Nw@mail.gmail.com>
Subject: Re: [PATCH 14/18] drivers: firmware: psci: Manage runtime PM in the
 idle path for CPUs
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 16 Jul 2019 at 17:53, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, May 13, 2019 at 09:22:56PM +0200, Ulf Hansson wrote:
> > When the hierarchical CPU topology layout is used in DT, let's allow the
> > CPU to be power managed through its PM domain, via deploying runtime PM
> > support.
> >
> > To know for which idle states runtime PM reference counting is needed,
> > let's store the index of deepest idle state for the CPU, in a per CPU
> > variable. This allows psci_cpu_suspend_enter() to compare this index with
> > the requested idle state index and then act accordingly.
>
> I do not see why a system with two CPU CPUidle states, say CPU retention
> and CPU shutdown, should not be calling runtime PM on CPU retention
> entry.

If the CPU idle governor did select the CPU retention for the CPU, it
was probably because the target residency for the CPU shutdown state
could not be met.

In this case, there is no point in allowing any other deeper idle
states for cluster/package/system, since those have even greater
residencies, hence calling runtime PM doesn't make sense.

>
> The question then is what cluster/package/system states
> are allowed for a given CPU idle state, to understand
> what idle states can be actually entered at any hierarchy
> level given the choice made for the CPU idle state.
>
> In the case above, a CPU entering retention state should prevent
> runtime PM selecting a cluster shutdown state; most likely firmware
> would demote the request to cluster retention but still, we should
> find a way to describe these dependencies.

See above.

[...]

Kind regards
Uffe
