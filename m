Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD417D9B7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 08:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIHVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 03:21:10 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42437 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2020 03:21:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id i25so1585457vsq.9
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2020 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cx8KWbTHQ8LVzU6900j9HApFPF1eqQzLKFHLGTZF4y0=;
        b=sKkAdJB3LOgh7uFGimPxZ1gscSPejE14N0ra+Uo9OGDnSXFaEa29o/yH8kmvA/0+af
         L91vjnpfMtG/vRV1AvYZw8yddtPFMoWS8U+7x0UDkBnNHv9Nrjc/09urq98ILN10NW0j
         uVSB02cPuy+AoAuc1cg6aDLYWgKM1aIttbYKdIIWgep9FqQV+WwXkMHbAAPICU1Diejp
         gK/1Z6ksxYbK4KL+azFIhLQRjIJOV5ktGG8KReU40dwdG74cgOdCrvIQrYHaAVyMAVi6
         hQvVE3Wu29ID8RDnxkl1d+li5KQmn1IutPI078Uk+Wu+4KvNkZJ+8KPoJroOMhVzBaQ8
         JxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx8KWbTHQ8LVzU6900j9HApFPF1eqQzLKFHLGTZF4y0=;
        b=oP+z2ecRhIlEAatPL4a/A0/OQey55sIn5SwvyhpkPNNQ6kDwIn45NNO6zhz+l2haej
         X7DeUlvRUdCrhTLzVh+Sd8sYGtgf9WbT9BLHL8Qwz903OBZ5+Onvk1UCLZxkFfzYT5e/
         DuIoZnbOLnkyD0R3wATOffFT4EsOs2ij9kMrhFgjtOLY4XOdwH5o9GqhXJ1B09ZISnm4
         ZNJ2QKIT4xswGaFWfrgttScaZKtcPjt//r20+H/e/0lVm9SHzJeVFpQhBtdjrZbL2kDV
         ss7rP3/j7+BZ30ajDNVnkfX2H5OT7UA/Qz4gHBAEz3I2i6lztB6gW4FmhtyGrMM7GoCB
         fsnw==
X-Gm-Message-State: ANhLgQ2TlZCHlVAVrYhnKCxt+qpXDW6wI2cf17hXIQyYi5jEbR1mfF8z
        doqJ2q+CeI8M3Rzt/c4jjvUhJdWK+dw2+HatPU1qxg==
X-Google-Smtp-Source: ADFU+vsipqnmPJKju+fI9s8qcy9nJN3Z2moHXTZB8kl5l1YvdCh22HDbFpOdttDtAC+ifLbUQd9pkjzFTaIybbc7PBc=
X-Received: by 2002:a05:6102:4af:: with SMTP id r15mr8677756vsa.35.1583738467802;
 Mon, 09 Mar 2020 00:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200303203559.23995-1-ulf.hansson@linaro.org> <CAJZ5v0j86N5WgEJhCD6a7K2NG7NoK-wqG5h-vbc-Z7qH4fkySQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j86N5WgEJhCD6a7K2NG7NoK-wqG5h-vbc-Z7qH4fkySQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Mar 2020 08:20:31 +0100
Message-ID: <CAPDyKFo3o6k8kiXTG337_4OkcunQn9T1FgPM-PngO3t9Sg9eBw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cpuidle: psci: Some fixes when using the
 hierarchical layout
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Mar 2020 at 23:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 3, 2020 at 9:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v2:
> >         - Small changes to patch 3 and 4, see their changelogs.
> >
> > While collaborating with Benjamin Gaignard to deploy the hierarchical layout
> > for an ST SoC, it has turned that I have clearly missed to test a couple of
> > corner cases in recently added support to the cpuidle-psci driver.
> >
> > This series are fixing the issues we have found.
>
> I can apply the whole series, but I'd need an ACK from the PSCI driver
> maintainers for that.

Patch 1 and patch 3 is ready to go. Although, patch 3 don't need the
fixes tag and can be queued for v5.17 instead.

Do you want me to resend or can you pick them from the series?

Kind regards
Uffe
