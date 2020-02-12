Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6CC15A609
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgBLKQj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 05:16:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41999 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgBLKQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 05:16:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so1346431otd.9;
        Wed, 12 Feb 2020 02:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSd7L1WcqmA7Rn1t/qtLYAH7L9DL0l8H2ANtY/V6cDc=;
        b=gReBd1Ywov8ljWD1+wSAQA4uHUVj9uIy8Je3MtzuZ/kZ3CfR+97pLCp1EsVr5huVDr
         GR1VRClCJVP8AW3Cgyi0H6jaJPPDkO6FHevE1c0xsjAUH+YCMWbbnM8W18oqECMsbpSS
         qOrcI90WIJqKOlMLWXwOVANoe0XBIukrGCGw75mUIfdtfGYXgR/bnthuX2UjDT0oosSa
         TUV4X4oS99IFidi2xfF1cA9lGHIsup04ePZnAUtJF3f1To/aBZWLyhII/OADy4If9B8F
         qP+xKFU5uPIq9FPY9CkPOUF9nPlyte7zT8A8gfwTR3NplT58yHbFGktJ+484YJcC57ID
         AIGA==
X-Gm-Message-State: APjAAAVIwgvvVF/6r0CnFL3O11z7Eus+JKxJ72EJEMjywrs58Pn/WgDG
        76MmwOtaRzj8ReakPVliPuZPgQjg4+LABMt/u6o=
X-Google-Smtp-Source: APXvYqyfmunP1o2BTpeb9JU1HjP2UYYEVp4pQeJQcvu4Jqvu9FNFexZwM5K2BHzwypUIBN4OQGyWST7sYQ52txz7keM=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr8759446otn.262.1581502598886;
 Wed, 12 Feb 2020 02:16:38 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <197693303.hiACyxC3Vm@kreacher> <20200212100810.GA4028@sirena.org.uk>
In-Reply-To: <20200212100810.GA4028@sirena.org.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 Feb 2020 11:16:27 +0100
Message-ID: <CAJZ5v0i8DsjQkf_4ezOYMrvB47ZuxsgNmTbHQB-JEK8bMHUpPg@mail.gmail.com>
Subject: Re: [PATCH 24/28] sound: Call cpu_latency_qos_*() instead of pm_qos_*()
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 11:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 12, 2020 at 12:34:15AM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Call cpu_latency_qos_add/update/remove_request() and
> > cpu_latency_qos_request_active() instead of
> > pm_qos_add/update/remove_request() and pm_qos_request_active(),
> > respectively, because the latter are going to be dropped.
>
> What's the story with dependencies here, I only have this patch and not
> the cover letter?

The cover letter is here:

https://lore.kernel.org/linux-pm/CAJZ5v0h1z2p66J5KB3P0RjPkLE-DfDbcfhG_OrnDG_weir7HMA@mail.gmail.com/T/#m92ce7ffd743083e89e45c0a98da8c0140e44c70b

Generally speaking, this patch depends on the previous patches in the series.
