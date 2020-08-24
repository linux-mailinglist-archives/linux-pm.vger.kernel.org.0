Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C3324FBF5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgHXKvl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:51:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44038 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHXKvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:51:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id h3so7818320oie.11;
        Mon, 24 Aug 2020 03:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaesU/GdkZ04DU8qNrExZBjXz/BjdlAj4TsHXCHc50Q=;
        b=Utrs4989nVltPQByCkEyBckGlzXqxKPOSATeoPdH6+K5HTYEmng0+5+Nse5CbFNqjL
         9l0lfWOd54RHAuCRIjUScJDxZ3sGpZHaOvDWGbmppvOnrmZlDiae+N+Q/iEU1FhdjUqd
         roUGX3RPvpiDgRZSU4zWvTzVoep0yQDv4sqhoCXA3XapvtyXBsG6bk81MryJ6iKXlx/I
         G+gV/biCns1XBR2pW0Om5g+Ngs6r8k07upmsS0hzZWgwaJPla9OiO5Lb/2p0HrmSO9Wa
         uc1Rm0SGHqqr/1/RZ7K/aXxNrqt/Y8QhhwPZAwwNgXgx3D0rxYJo/lfmYlTBARUE1RYo
         1CUA==
X-Gm-Message-State: AOAM530oK/cfywFYkaB6QJPZJ+8rIaFVEe3Vs2DuQlfMsEMSlwJ7ncid
        anYZQbJVhF1dv7Pg7h8AdwCVCKOK8mRB23NBxN6o3muk
X-Google-Smtp-Source: ABdhPJxheq8dscielSi+i+foFrT2RVXUDgrUjkbPIgiOw/7dUEIf9Qqksn3nOw9GLkBaC2CCyXFOauj/B4K0r3DvK3Q=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr2872157oie.110.1598266299068;
 Mon, 24 Aug 2020 03:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <884e2ee2-7426-cda1-aae2-676062c67f10@infradead.org>
In-Reply-To: <884e2ee2-7426-cda1-aae2-676062c67f10@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Aug 2020 12:51:23 +0200
Message-ID: <CAJZ5v0jJqRb2FTSL6OpK+jh+=SKMfw8UTKhjbEyoHm5dBcswzA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix pm/intel_pstate build warning and wording
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 1:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix documentation build warning and sentence wording:
>
> Documentation/admin-guide/pm/intel_pstate.rst:568: WARNING: Unexpected indentation.
>
> Fixes: f473bf398bf1 ("cpufreq: intel_pstate: Allow raw energy performance preference value")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- lnx-59-rc2.orig/Documentation/admin-guide/pm/intel_pstate.rst
> +++ lnx-59-rc2/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -564,8 +564,8 @@ Energy-Performance Preference (EPP) knob
>  Energy-Performance Bias (EPB) knob. It is also possible to write a positive
>  integer value between 0 to 255, if the EPP feature is present. If the EPP
>  feature is not present, writing integer value to this attribute is not
> -supported. In this case, user can use
> - "/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
> +supported. In this case, user can use the
> +"/sys/devices/system/cpu/cpu*/power/energy_perf_bias" interface.
>
>  [Note that tasks may by migrated from one CPU to another by the scheduler's
>  load-balancing algorithm and if different energy vs performance hints are

Applied as 5.9-rc material, thanks!
