Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA152B8FFD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 11:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgKSKPx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 05:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgKSKPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 05:15:53 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37011C0613D4
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 02:15:53 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id q2so1664201uas.5
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUmWc2XKIjJhAgxg0BgLz+A6fjAIS+8ifWZYZHlV0nQ=;
        b=tVfxs5rYGV+5I4KM/S7o9qrAgrRbQDNUaPpL3Dit+Ylc6MPdqx5YbIgSeJ/t8WMut9
         8M66JnK+gyOTf1i29p2NPWj3zDHdHXEJi3AWvIOmp5YEGpE0hg16eszjySjW317LkNWw
         NLPI03IaIiDr1qXibEpwPyDQ7pzVoRqw+TtMUjFGDE+Ys8hwMF4xJyxtJPDS984GNNMm
         YbY+Ki4eL+YvIOGUQs9A8TX63nAeMUAb1E0LQqVA270lio/j3Dn6hYjFSqTZGM25SjMH
         BkukA/yE1K7Md49Ri3nJh4+8CuD7a5rUsamj0hWjo2JJ0csZeMpTBCbf5oTGd4cLxR1N
         bceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUmWc2XKIjJhAgxg0BgLz+A6fjAIS+8ifWZYZHlV0nQ=;
        b=NbqxkBw3bwJxfrBleJCWKS/LDjTnW3MK2HXrXD8UnD8gZsNleIBXwBmJqPqD1zUfEF
         ZQhF+rT7znrB9hGgLfB+Zng1R379f2otCMlJ88p7ZI1qd9Twmkluo9mJtgcGl4gMcmoH
         mkREfqoMYhGaXRwSZFAIfAQEM726uCAtuvMB6FbS+2FA2MWbOfzS5hhCIFo3udKSVI6Z
         6hqcz5Ds78CvCSB/obsTuXaOIWmHLO92zDJAlMxKPtmNxA3Nr06/f47KHFRdAToxfVQ9
         4fybYxRMYeec35DBNfb3t2MlEF7LHRVOpn15AuywPWEldJTGk2NonsSAAMSYzm3Iq5Tt
         o25A==
X-Gm-Message-State: AOAM533eW9ezUB5ySiyLwSwrYuxlkF8VT/wcrks59nEuAsv/hVSa59F5
        +x0cx1hlIQcN7Pw5BK2iOGVAG0MwUpufctxu3BJiqg==
X-Google-Smtp-Source: ABdhPJxoBl6cqBmyLED2zsGA36KTPasXoGegyZurZ3XSaVqXFD6afg5iUYvM4AwdnhHjazJ6GXLCRdFloYsnkcOejPg=
X-Received: by 2002:ab0:754f:: with SMTP id k15mr8175598uaq.15.1605780952243;
 Thu, 19 Nov 2020 02:15:52 -0800 (PST)
MIME-Version: 1.0
References: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
In-Reply-To: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Nov 2020 11:15:15 +0100
Message-ID: <CAPDyKFrxKhO0V-uTDLDV6RFQFwhjesE0zfnuBLfYs-n5bNxXtg@mail.gmail.com>
Subject: Re: [RFC] PM Domains: Ensure the provider is resumed first
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 16 Nov 2020 at 17:17, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi all,
>
> We recently ran into a problem on Tegra186 where it was failing to
> resume from suspend. It turned out that a driver, the Tegra ACONNECT
> (drivers/bus/tegra-aconnect.c), was being resumed before the PM domain
> provider, the BPMP (drivers/firmware/tegra/bpmp.c), and the Tegra
> ACONNECT was trying to enable the PM domain before the provider had been
> resumed.
>
> According to commit 4d23a5e84806 it states that 'genpd powers on the PM
> domain unconditionally in the system PM resume "noirq" phase'. However,
> what I don't see is anything that guarantees that the provider is
> resumed before any device that requires power domains. Unless there is
> something that I am missing?

The genpd provider's ->power_on() callback should be invoked as soon
as an attached device gets resumed via the ->resume_noirq() callback
(genpd_resume_noirq). Have you verified that this is working as
expected for you?

Note that, if there is no device attached to the genpd, the
->power_on() callback may not be invoked - unless there is a child
domain being powered on.

From the genpd provider driver point of view - why do you need to
implement system suspend/resume callbacks at all? Do you have some
additional operations to run, besides those executed from the
->power_on|off() callbacks?

>
> Now by default the ACONNECT is resumed during the noirq phase, but I
> have tried making it and its child devices, suspend/resume in the normal
> system phase but this does not seem to make a difference. So I am
> looking for a bit of guidance on how best to fix this.

The order of suspend/resume of devices are based upon the order the
devices get stored in the "dpm list" - unless there are child/parents
relationships or device-links that the PM core also takes into
account.

Kind regards
Uffe
