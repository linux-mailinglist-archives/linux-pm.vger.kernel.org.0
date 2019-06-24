Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F055B519E8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 19:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFXRqL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 13:46:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34265 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXRqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 13:46:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so10438896qkt.1;
        Mon, 24 Jun 2019 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqvhv4+HocZvAFgQ886MQBeV76Way/6y27/WtDFCSes=;
        b=vHR3m7Cw0aO++OPfO86qU7byPS7zK+S7TvkfG3a2HodsI2oq3SB6b6zb73f0m4wAM1
         stii6+Wq5k+1gW2y52IOuohS6Ma3ZEvGxcMFkK5DFZDVcug8n4nRFmAAAGOw/t/W1Lvq
         etn4ME0A2n6n2MdOFmak5Sr+NwCWDGyC9UATjJzWsYTC8xPRGn6m4gx4JdttXNzknnBP
         UL/fbcMFmDgGWjk7f/C0WO38e8F4fQ2f21W2yNk3NYnYTeclq78/l3O38DXQpFcYaSAt
         YLpa0kjKCNAz21XYCRhpIzGjGqVqYnH5YF31CmdQ/6Xpw8NHOTwbbCwpELMicNNS9+9o
         cDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqvhv4+HocZvAFgQ886MQBeV76Way/6y27/WtDFCSes=;
        b=sfgFVk6HxbVuW4r58laowJNUn0iVbsh2SXkzZx4uCU6CNWT1qhsmUn+EGA6D08w7Hb
         pdyLlTfZy6HLs8eOv04/5CIyeWxHrhxKY+a4hnfUGnb0ITgIxg3skMJycu8Nd25TKoZU
         bW9SlxK/93xsv0E8UGdxctJRFTiHmItq2oXFOAWUX1gHTS37/n9zru2kkC3JFRoXxNYR
         18xhcWcRWC+1UvvTK06Wq8Wm6Tgz2Cilb7aBe1fQT+uK9GAQlb7tp6jKpV61YcuC/8Q6
         YPwRlLRrFQ21Dreb+ZZM2yseNcmih5Qr02oQJCl/CgRKy82qr71b/BXUkOEcY80wc4Ll
         y71w==
X-Gm-Message-State: APjAAAVHOkjtixWIHIt7DGkqC5xQx6Fchqns6BqWUN81ANMkQQFQJpet
        3ARn6l8WNOK97sRp4XM4Yrkq+7Sp
X-Google-Smtp-Source: APXvYqxX0bKL1ZZp233OQnZs7tJk5Ha00oreIjI+nAb4bDv2XkvCQ630hdwQSisX+Y/ep+WSTHRs+Q==
X-Received: by 2002:a37:9c16:: with SMTP id f22mr121696273qke.261.1561398369951;
        Mon, 24 Jun 2019 10:46:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2c48])
        by smtp.gmail.com with ESMTPSA id j79sm6894214qke.112.2019.06.24.10.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 10:46:08 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:46:07 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v10 13/16] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190624174607.GQ657710@devbig004.ftw2.facebook.com>
References: <20190621084217.8167-1-patrick.bellasi@arm.com>
 <20190621084217.8167-14-patrick.bellasi@arm.com>
 <20190622150750.GN657710@devbig004.ftw2.facebook.com>
 <20190624173405.enrxqalaqinbgsut@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624173405.enrxqalaqinbgsut@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello, Patrick.

On Mon, Jun 24, 2019 at 06:34:05PM +0100, Patrick Bellasi wrote:
> > On Fri, Jun 21, 2019 at 09:42:14AM +0100, Patrick Bellasi wrote:
> > > Since it can be interesting for userspace, e.g. system management
> > > software, to know exactly what the currently propagated/enforced
> > > configuration is, the effective clamp values are exposed to user-space
> > > by means of a new pair of read-only attributes
> > > cpu.util.{min,max}.effective.
> > 
> > Can we not add the effective interface file for now?
> 
> You mean just the (read-only) user-space API right?

Yeah.

> I found it quite convenient, even just for debugging.
> Moreover it allows a container to know what it's exactly getting...

I fully agree.

> > I don't think it's a bad idea but would like to think more about it.
> > For cpuset, it was needed because configuration was so interwoven
> > with the effective masks, but we don't generally do this for other
> > min/max or weight knobs, all of which have effective hierarchical
> > values and I'm not quite sure about adding .effective for all of
> > them.
> > It could be that that's what we end up doing eventually but
> > I'd like to think a bit more about it.
> 
> ... but I see your point and, since it's not strictly required, I
> think we can drop it in v11. Will check better if it's of any use
> apart from debugging/testing support.

Yeah, I just wanna figure out a plan which works for other controllers
too.  It could be that the right thing to do is just adding .effective
to everything but idk I need to think more about it.

Thanks.

-- 
tejun
