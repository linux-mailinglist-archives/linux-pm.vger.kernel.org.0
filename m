Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBD391D9F
	for <lists+linux-pm@lfdr.de>; Wed, 26 May 2021 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhEZROS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 26 May 2021 13:14:18 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35703 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhEZROQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 May 2021 13:14:16 -0400
Received: by mail-ot1-f50.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so1702753otg.2;
        Wed, 26 May 2021 10:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TBOemGopDfiBmIqH0OnacL3v5GkpKCDhQTWQv9aQog8=;
        b=lQoO4ue+Imggi6nLmtN1/4wz3CyLBEDzvZQXdH6adKI2YhhW02kbXXwy67CrRRin2a
         QtZnb7dC7dtJhKiPyk4W6edBjn6ZJh2KWjMj7cZCIIMMGXQ7v5kW/4sqxnzmFr1Z/9KP
         fEeUTCCNrh5tUzrQ1YNfamm5aWpJdqbPtaawtzl+28mi+MaKEwBPPabECuP2jLWYbbjA
         zmiacVZR1iG3nj7OIM3Ih0ywAisWCTAXCAhIHZSuYZIwWcp3HTf1L3qIml6UXZ6mFwAm
         zJh9BYURHo+mf3CTDgPV5mZQ4KiN5f9Pyel6wFXOlHLxQl05LgEfiShXNHoDyCrqf3Tm
         tRhg==
X-Gm-Message-State: AOAM530S8oAm0xM0WAMln1Fg26jdfimrLWKB2PYGiM3ozq0EACsXdfrk
        h0JgYKJFJ/K+9wH8cv6rBn1hk/INMp91usSszNc=
X-Google-Smtp-Source: ABdhPJx2CfuGHBFZSKfg02/GeSLyTmj5dZLTLY59d+seNRb/QpvUHN1FK+1jkrTFalLrMzHF7mQHe/GGVUiqj1pIV/M=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr3321117otc.206.1622049164811;
 Wed, 26 May 2021 10:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <4337451.LvFx2qVVIh@kreacher> <4f0f3e94-d42a-a0fd-ced6-bd1edd6d471b@infradead.org>
In-Reply-To: <4f0f3e94-d42a-a0fd-ced6-bd1edd6d471b@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 May 2021 19:12:33 +0200
Message-ID: <CAJZ5v0iVS0YR67M0b6V4p6Bk9gDR_x5YPVB0JYB8jBfQj0eKUw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: hybrid: Fix build with CONFIG_ACPI unset
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 26, 2021 at 6:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/26/21 8:01 AM, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > One of the previous commits introducing hybrid processor support to
> > intel_pstate broke build with CONFIG_ACPI unset.
> >
> > Fix that and while at it fix up empty stubs of two functions related
> > to ACPI CPPC.
> >
> > Fixes: eb3693f0521e ("cpufreq: intel_pstate: hybrid: CPU-specific scaling factor")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Hi Rafael,
>
> I still have this build error:
>
> ../drivers/cpufreq/intel_pstate.c: In function ‘show_base_frequency’:
> ../drivers/cpufreq/intel_pstate.c:950:10: error: implicit declaration of function ‘intel_pstate_get_cppc_guranteed’; did you mean ‘intel_pstate_get_epp’? [-Werror=implicit-function-declaration]
>   ratio = intel_pstate_get_cppc_guranteed(policy->cpu);

Well, I did too much in this patch, will send an update shortly.

> BTW: s/guranteed/guaranteed/g

Right.
