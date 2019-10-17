Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB5DA851
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405468AbfJQJa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:30:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46895 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393479AbfJQJa2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 05:30:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so1248141pfg.13
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhmzWijDe5yao7vgl7kT7tSRmrdD456yMAPTwvVZ6aE=;
        b=ON5RjH0pSpZU2Cd7Fz0YbphH0L/Em2TGlv7YnZJBvpgopaCB/FKNcHBXq8HKwYUg7P
         9zkm0CUSDi8v7DL/pyzSsR88zRdT+gXAfP2h3/W5kvOKlunjpsrKxnUOTDwT80UUeo50
         4D6r0R0NHfCVid/eMA8W/jEIqrs+6PGfUdVEPeKkuRyFGFdx81pc41weawhWqG27vqEO
         ueMpeFIhp2mICDuxVZfklOTuQxnr12o48mmafzWwEBS3QILVhVMTtY6n5DI3On4w/GId
         e3zbFJ3f17wCZh5HFUOnvhEslPT7wGccw26PeqA8E36a8zrcusugKBnVc2c7y91AH2U3
         ZCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhmzWijDe5yao7vgl7kT7tSRmrdD456yMAPTwvVZ6aE=;
        b=LmLFB41dH/BEK6QEhH5s4zzCIab2n5NpvBJJCLuQkk3lvvdohHq5oTcsodIluPGcQQ
         XUXURM916H5TF+ke/3xxugV92ZVSdCjX4PNukomnB/1ofVXdlp2LbbTa+hsrFfRd+oyo
         7vNJtISingMTxJcdCtIHZ9/YoiPzbHbxbWxlNpfE9NwuX/Zk+SVTnziwl60weXBJo2L2
         RqQbHcraCYQEdMMW8RdIfehjwo7zMMVDA8/yTx5FTeMUWIgXV4MuOA2dqf0XuNy31FCj
         PPu20gt3tnVSYg4/GDX04VpPmTggKjqabVXdWooQSAspaNsuK+uDol2dGcTsgDfbAYdf
         bn5w==
X-Gm-Message-State: APjAAAWjPNfEmRWUzwt2NzgxXJamuRAMmUR+I4zFqEbhdfQJUK+qVDrB
        NAyCNCUERCuQOIjmQdfB5bmSkg==
X-Google-Smtp-Source: APXvYqzE6ySNtpyo3AA5URWU3jKLTzHmlb++gJiGHbo4eEfHZNF4YHTd0p39zwIlMfLoeZpK1XK1eg==
X-Received: by 2002:a63:1c47:: with SMTP id c7mr2994536pgm.265.1571304627200;
        Thu, 17 Oct 2019 02:30:27 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id a17sm1897804pfi.178.2019.10.17.02.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 02:30:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 15:00:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017093022.du76n64kwzqibqhs@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
 <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
 <20191017092628.GD8978@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017092628.GD8978@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 10:26, Sudeep Holla wrote:
> On Thu, Oct 17, 2019 at 08:09:36AM +0530, Viresh Kumar wrote:
> > On 16-10-19, 12:03, Sudeep Holla wrote:
> > > arm_big_little cpufreq driver was designed as a generic big little
> > > driver that could be used by any platform and make use of bL switcher.
> > > Over years alternate solutions have be designed and merged to deal with
> > > bL/HMP systems like EAS.
> > >
> > > Also since no other driver made use of generic arm_big_little cpufreq
> > > driver except Vexpress SPC, we can merge them together as vexpress-spc
> > > driver used only on Vexpress TC2(CA15_CA7) platform.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  MAINTAINERS                            |   5 +-
> > >  drivers/cpufreq/Kconfig.arm            |  12 +-
> > >  drivers/cpufreq/Makefile               |   2 -
> > >  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
> > >  drivers/cpufreq/arm_big_little.h       |  43 --
> > >  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
> > >  6 files changed, 652 insertions(+), 729 deletions(-)
> > >  delete mode 100644 drivers/cpufreq/arm_big_little.c
> > >  delete mode 100644 drivers/cpufreq/arm_big_little.h
> >
> > The delta produced here is enormous probably because you copy/pasted things. I
> > am wondering if using git mv to rename arm_big_little.c and then move spc bits
> > into it will make this delta smaller to review ?
> >
> 
> Yes, I did a quick try but slightly different order. As I need the final
> driver to be vexpress-spc-cpufreq.c, I am thinking of first merging
> vexpress-spc-cpufreq.c into arm_big_little.c and then renaming it back
> later. Does that sound good ?

Maybe git can produce short diff even if you do this in a single patch. But two
would be fine if that makes me review lesss stuff :)

> 
> drivers/cpufreq/arm_big_little.c       | 78 ++++++++++++++++++++------
> drivers/cpufreq/arm_big_little.h       | 43 --------------
> drivers/cpufreq/vexpress-spc-cpufreq.c | 71 -----------------------
> 6 files changed, 68 insertions(+), 145 deletions(-)
> delete mode 100644 drivers/cpufreq/arm_big_little.h
> delete mode 100644 drivers/cpufreq/vexpress-spc-cpufreq.c
> 
> If we first rename arm_big_little.c, then we need change the final name
> otherwise we end up with same delta as the new name file will be merged
> into vexpress-spc-cpufreq.c



-- 
viresh
