Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4092AD67C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgKJMjX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Nov 2020 07:39:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJMjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 07:39:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id n89so1116660otn.3;
        Tue, 10 Nov 2020 04:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ntfMxseYHJ8sQ5EnfS7MGclsAfjZCwuywLaPjxhl4Y=;
        b=boi8TLSE8RZTqzP2bxFJocipHAfQN3qaBTC5k8pfTd/2rwR3hrE5gfpDN/xbaSNcKa
         9YDsdKhFQKl7Mg+3m9OhiKlRCa1w7uFP0JQwH3u5NaKlE8C7uvW9RrQ2vr8PEsJXF/1l
         TWGpZo2yYHpyyXtY+iuVzwQ6od7wwXkFJJzbAaLMCrlYjB9V4qD/fWApboemb+MIgXXY
         9CqOOpA533kLM9mlpPQv86J2IZdZ9pSQyrcGKotyS+M7H3CkMBEPPzpqoIjnrUGQoUWc
         +dmp4ziN+xeWfWm5Pw9CIgX9DnysoW/PxoYS0+CE5Om44KgrMtsF682bV7xJ4vk9yTp/
         keZw==
X-Gm-Message-State: AOAM531inxPrDpwyzEmLM8R+LvH+caCiEzaDf56FdkmLWR5TEWEdKCVi
        gXhFAcQiGKNHFiI1VpCpmDLWwI0wDCwfBzE2pWndUWos
X-Google-Smtp-Source: ABdhPJzY5vTOKEcWAySwIbx4J/9uz/lwdAUnk+DiCiXpZgzbOD34rnjpWMllG6b+gC4pOp2VQPlCBa6Mbl6K2abCA8E=
X-Received: by 2002:a9d:171a:: with SMTP id i26mr14529699ota.260.1605011962037;
 Tue, 10 Nov 2020 04:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20201103151139.29690-1-pali@kernel.org> <CAJZ5v0gxRHUt7dij7zFomXxmCEPVxiTEv+qu8kZESbsE3A+bBQ@mail.gmail.com>
 <20201110023507.ftw4slfp6zn7txe2@vireshk-i7>
In-Reply-To: <20201110023507.ftw4slfp6zn7txe2@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 13:39:09 +0100
Message-ID: <CAJZ5v0jZWvxtgk2cB5EKQkXZvQuDzyvYYnA=rNdZMGvKVOyo1w@mail.gmail.com>
Subject: Re: [PATCH 0/9] cpufreq: Add missing modalias for tristate drivers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 3:35 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 09-11-20, 15:18, Rafael J. Wysocki wrote:
> > On Tue, Nov 3, 2020 at 4:14 PM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > Some of cpufreq drivers are tristate, can be compiled as modules, but do
> > > not have defined modalias for automatic loading. This patch series add
> > > for all those cpufreq drivers missing MODULE_DEVICE_TABLE macro, based
> > > on OF definitions, or MODULE_ALIAS for platform drivers.
> > >
> > > MODULE_DEVICE_TABLE is not explictily added only for speedstep-centrino,
> > > speedstep-ich and speedstep-smi drivers as it was removed in commit
> > > b11d77fa300d9 ("cpufreq: Convert to new X86 CPU match macros").
> > >
> > > Pali Rohár (9):
> > >   cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: highbank: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: st: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
> > >   cpufreq: loongson1: Add missing MODULE_ALIAS
> > >   cpufreq: scpi: Add missing MODULE_ALIAS
> > >   cpufreq: vexpress-spc: Add missing MODULE_ALIAS
> > >
> > >  drivers/cpufreq/armada-8k-cpufreq.c    | 6 ++++++
> > >  drivers/cpufreq/highbank-cpufreq.c     | 7 +++++++
> > >  drivers/cpufreq/loongson1-cpufreq.c    | 1 +
> > >  drivers/cpufreq/mediatek-cpufreq.c     | 1 +
> > >  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 +
> > >  drivers/cpufreq/scpi-cpufreq.c         | 1 +
> > >  drivers/cpufreq/sti-cpufreq.c          | 7 +++++++
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
> > >  drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
> > >  9 files changed, 26 insertions(+)
> > >
> > > --
> >
> > Viresh, any comments?
>
> I found the patches to be fine and marked it to be applied soon in mutt. I was
> waiting for the maintainers of the drivers to respond, after that I would have
> applied it for 5.11.

OK, so please take all of them then (some of them are not ARM-related AFAICS).
