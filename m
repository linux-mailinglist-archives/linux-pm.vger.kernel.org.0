Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8A1232F3
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 17:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLQQvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 11:51:21 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46062 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQQvV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 11:51:21 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so5867082oiv.12;
        Tue, 17 Dec 2019 08:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcVtd0PQXwawV2kFABB1V3X1mbUitghtCZjt3Z3mtPs=;
        b=lWC6UtxSoWLH+yUKo3hRs7a9kzsOvEh/n2qjLLWBCQZlr820zoa5IDQhY013Wdgeyr
         nYYI0gN01hsGekfo7ylo/d0fD3SXGG2/SdwVnWsTYcRQ39utxTTnR8AY6uuA+tZPfcrg
         5R/TADPMRwvaGOuGM8262sBrfoLYMKpSAijP6WJk36ViUvTUCPgN5bJZzaicOGg6TkXs
         Py1Y1rD/wSxRAVMQsp9dY1vdV8cPytEW4fOXOQRxAtpDDIIeZjIYQ0i54HOHV0SdSRwn
         5FrQ5mJoid5MegJFA9XqDGfWJjqaVOUVvYHATu4fqnTdsZZ6k1vrBC9XKYsNYP9Rfcwx
         byvw==
X-Gm-Message-State: APjAAAWDvswZIxFaH/JS7hwIqRUUGLtqtZL1MdaiyLD+Wai7ZiFLVdz3
        phPKM/T98zuUtaBpCj56NBaZZoNDmhDuI/scnGg=
X-Google-Smtp-Source: APXvYqxDoKJO/my3WhR6r0OHazOflJZTa5BuhPVYLFlrsFtii/atvi20YYByN9lvFhU35WIAryD5o7GaShaSfmcDBZI=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr1000217oig.103.1576601480290;
 Tue, 17 Dec 2019 08:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com>
In-Reply-To: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Dec 2019 17:51:09 +0100
Message-ID: <CAJZ5v0jmMwRGDY70EV3sqpw7uJ4R+VomoWtJ9rWzNTVuV3AUxQ@mail.gmail.com>
Subject: Re: [RFC] cpuidle : Add debugfs support for cpuidle core
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, svaidy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 3:42 PM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> Up until now, we did not have a way to tune cpuidle attribute like
> residency in kernel. This patch adds support for debugfs in cpuidle core.
> Thereby providing support for tuning cpuidle attributes like residency in
> kernel at runtime.

This is not a good idea in my view, for a couple of reasons.

First off, if the target residency of an idle state is changed, it
effectively becomes a different one and all of the statistics
regarding it become outdated at that point.  Synchronizing that would
be a pain.

Next, governors may get confused if idle state parameters are changed
on the fly.  In particular, the statistics collected by the teo
governor depend on the target residencies of idle states, so if one of
them changes, the governor needs to be reloaded.

Next, idle states are expected to be ordered by the target residency
(and by the exit latency), so their parameters cannot be allowed to
change freely anyway.

Finally, the idle state parameters are expected to reflect the
properties of the hardware, which wouldn't hold any more if they were
allowed to change at any time.

> For example: Tuning residency at runtime can be used to quantify governors
> decision making as governor uses residency as one of the parameter to
> take decision about the state that needs to be entered while idling.

IMO it would be better to introduce a testing cpuidle driver with an
artificial set of idle states (or even such that the set of idle
states to be used by it can be defined by the user e.g. via module
parameters) for this purpose.
