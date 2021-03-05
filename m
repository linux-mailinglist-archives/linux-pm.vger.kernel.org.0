Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054D332EE3D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCEPS2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 10:18:28 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45236 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCEPSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Mar 2021 10:18:21 -0500
Received: by mail-oi1-f176.google.com with SMTP id m25so2817084oie.12
        for <linux-pm@vger.kernel.org>; Fri, 05 Mar 2021 07:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKVK3J8sCEVPtYi5YmozPChMITXyJkQNGr1VeTesdaE=;
        b=L1yV9EZ1bidjny04xn3wFvUpaX8CeYbuZFWWXzDckv1bGhfjdLnwlku9bzfkdwDeAk
         cLMCdJWjDBS27X11NHjo2vgZV8T5A9HkQJaxRn3c6VypsvLHkH66b2nIcgIjc95RZ/Np
         DyqatQxNCcIVJgyWcgb6npTl5cDTFoh9aNgP4sjcEyqRSS+UM16zZDYEdAwn4Ld0JtPg
         kzcGkHumF+LdtC1P0jL0iXis6EAlFOnC7jHTDpBGH+BEuyM/vK9l2j6sNzF0R8nQI23Q
         PxzHB8ZGsGVxbgWjVlGh/OPw3ImxbNgddeEpa8V9oNPZeJJAjaBm0OmtpaMXbmiOKP/E
         u+pA==
X-Gm-Message-State: AOAM5314hkHec+LanVIATLwKBbJBS3xD2mOPITMnYnXwrTxOFws8rSr4
        2syrK2MB9gwwqpgYNGgQ2oIOltXfk2ygrTNjevFZsnKzbV8=
X-Google-Smtp-Source: ABdhPJx9QCzWbYLw8F2y9NCr6CI4MP6E1XyP/O8p/3rBlnUBDKFpin2JHbil+tnhcqBt++uKyXpSMtdTKH09aXPywFs=
X-Received: by 2002:aca:f245:: with SMTP id q66mr7271371oih.69.1614957501174;
 Fri, 05 Mar 2021 07:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20210305080748.GA17954@lst.de>
In-Reply-To: <20210305080748.GA17954@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 16:18:09 +0100
Message-ID: <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
Subject: Re: driver notification when switching between battery vs AC power?
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Christoph,

On Fri, Mar 5, 2021 at 9:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Rafael,
>
> do we have infrastructure that notifies the driver when a system is
> switching from batter to AC power?

On systems with ACPI that can be done through an ACPI notifier, see
amdgpu_acpi_event() for one example.

Adding Rui who's likely to be more familiar with this topic than I am.

> There is a proposal to make the
> Linux NVMe driver power management match the policy used by the
> Windows driver more closely, which does this and we'd like to prototype
> that to check what difference the policy makes.
