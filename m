Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435621CA1D
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfENORn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 10:17:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42136 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENORn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 10:17:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so8335294pln.9;
        Tue, 14 May 2019 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ArFnW1VY3ms9qyz4p1fVUAVmj/4GdKkZjXhkCrGDcic=;
        b=XPWJG741EQYNQPD+hgI3shXcsBj/Ku7w2rUJYu/EBxfP916HYq124NZroB7TfHv3Ie
         PTfiTc7nuPV6GfE1rww2RSetpQ8nL37LkRmf1Rb3mHS5xTyTPSEBrwoRtvOdq38MAJLo
         B9tPEVpZYCnt1S0jhdsX1X3u1yNJXuTV7M/3InB4zykPFLi1pV5ZVyler1Xai+zVXU0M
         4rAgLSD1hYKqWyqq08TtQ5Y2Sqvuv0i3OvnNHcdTsEF3m9n32kv9x6FH8nGe45iwOUpK
         FY281isLNjYAJL3T/ctd8waOPCEqkZdUq1Zz+iwWMdk0P9s3OH681FQdlwXFRBk1szPU
         Zbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ArFnW1VY3ms9qyz4p1fVUAVmj/4GdKkZjXhkCrGDcic=;
        b=D5BDs6+U/AvFqSV5Ae7Qe9tRyq9G7ApU6NGSDIXp28gGu0wud7bcYd6oaKoLYs5FrX
         jpttxCorYa7Xk81UOYQ6j0a7Fo8S5AtL1i2C/8QANYOSGCa5QVQGXBo8AX3KuMKFwG7P
         4TSD6c1c9a+qGYNTbWVdsG3pjgiqVtdmosNBoK93F2FN4K+/zfmUqXLYrjrRkPBFLUFG
         jAU5fR78P0nnuEjFbndKFuwKR3DsMQEJ81eIWb6jmDWflTIBg9iF1eyRX/ui6SJKqAp/
         mBSESm99Rq4wfiGugp4v8m7I8H9SmlJHUBMFIth177LI7lndmtD83xGB5Ms79t1dZiDp
         2+dw==
X-Gm-Message-State: APjAAAXRQWkqxOmDCUpytJ+8+qExo3/dTPdEZ7OjG3LAv/yNKZF3EKIQ
        7AM4AQGrzaVRpD2GwBgQPTY=
X-Google-Smtp-Source: APXvYqyEoNeXQY01NVeGJknPJkVArnV8DTbciFn5z6wBalJ/oPW7cEOETXrh7Dz2iEuMNL18s/0cEw==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr39294120plp.27.1557843462222;
        Tue, 14 May 2019 07:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id p14sm19852605pfa.112.2019.05.14.07.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:17:41 -0700 (PDT)
Date:   Tue, 14 May 2019 07:17:37 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190514141736.GB16968@localhost.localdomain>
References: <20190503094409.3499-1-quentin.perret@arm.com>
 <20190503094409.3499-4-quentin.perret@arm.com>
 <20190514034056.GA5621@localhost.localdomain>
 <20190514071506.ykjg67elsydaehlz@queper01-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514071506.ykjg67elsydaehlz@queper01-ThinkPad-T460s>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Quentin,

On Tue, May 14, 2019 at 08:15:08AM +0100, Quentin Perret wrote:
> Hi Eduardo,
> 
> On Monday 13 May 2019 at 20:40:59 (-0700), Eduardo Valentin wrote:
> > On Fri, May 03, 2019 at 10:44:09AM +0100, Quentin Perret wrote:
> > > The newly introduced Energy Model framework manages power cost tables in
> > > a generic way. Moreover, it supports a several types of models since the
> > > tables can come from DT or firmware (through SCMI) for example. On the
> > > other hand, the cpu_cooling subsystem manages its own power cost tables
> > > using only DT data.
> > > 
> > > In order to avoid the duplication of data in the kernel, and in order to
> > > enable IPA with EMs coming from more than just DT, remove the private
> > > tables from cpu_cooling.c and migrate it to using the centralized EM
> > > framework.
> > > 
> > > The case where the thermal subsystem is used without an Energy Model
> > > (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> > > frequency table which is already a dependency for cpu_cooling.c anyway.
> > > Since the thermal framework expects the cooling states in a particular
> > > order, bail out whenever the CPUFreq table is unsorted, since that is
> > > fairly uncommon in general, and there are currently no users of
> > > cpu_cooling for this use-case.
> > 
> > Will this break DT in any way? After this change, are the existing DTs
> > still compatible with this cpu cooling?
> 
> Yes, all existing DTs stay compatible with this CPU cooling. The EM can
> still be built using the 'dynamic-power-coefficient' DT property thanks
> to the recently introduced dev_pm_opp_of_register_em() helper, see
> a4f342b9607d ("PM / OPP: Introduce a power estimation helper"). And all
> relevant cpufreq drivers have already been updated to use that function.

I see..

> 
> So, this patch should cause no functional change for all existing users.
> It's really just plumbing. I can probably explain that better in this
> commit message rather than the cover letter if you feel it is necessary.
> 

Yes I would prefer if this info goes into the commit message.

> Thanks,
> Quentin
