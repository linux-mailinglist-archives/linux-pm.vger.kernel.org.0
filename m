Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4DDC0E8
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfJRJ3F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 05:29:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37000 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409726AbfJRJ3F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 05:29:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so3510152pfo.4
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V3RrnhLavTjOu4XjHWUy1bDOhkG5uBMC/iS8OEbXenw=;
        b=HnLBkQV0TcUy4MGD4CYNgCZJNMDfdyoYbbUYDRENkWjyB5g/6AV14CtgdFow1/0nnn
         T4FbNLbkpTMe15ww/JHfETzg97tP2HrfU+dikdh+zLj5XMZxcZ24bnR5bZTrAxz/SnDF
         dnA5n+TQdb6UgtdUDQEpH4OhTM1UqngIa42rKKyEKF28CgGOQHq8OuWQNY/Nq0rSzrr6
         bUnMC2Fi5HnRQ4xYxWZsNxrii73sy2u9aF7aLIyYO+mZW++NQpQodzzoZ2Q1z23fpxMQ
         eSZ2PmeaVrOQiWCXjDT9IxkvMtjyWn7pOYT0jdAGv4UyvbSj9rzYXTBx271Bj6c3Nlhu
         tgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V3RrnhLavTjOu4XjHWUy1bDOhkG5uBMC/iS8OEbXenw=;
        b=OrDNKq/TCbmHPVlMygziS4tegu9lioP/vIl6uZAMJUyDy8BLhWWuqEZfkd807cRE6K
         pv3B2++PgBHbkBlQ6ZZlmPVLvMLkfgIJyApbyJUbKYcolBa01LH9NgGg94CgI34R49hF
         KIfNy5MoTQiwLxn5NNhPeMo/LWtD0+sL9h3O9wLwHZT6jEtn5Z+2FIMh7bpw3OuZspU+
         4//OmPmL9c9szbmXCKOWZt/afIFIeHuA9vlThLPDawJ3KYLY/J5A+5rcnp5zWVgT7897
         aduWOf6/teIylV76Y7jfxbI/VsLD0bPhjMsspmL1Vc0KmgeuVGEKN8YFjFe43ouJgbPj
         mtkw==
X-Gm-Message-State: APjAAAVkqrRfeQACevWvVKYUjlsVdKItrBAz2RC07NFJ+Ss8cs3HYEdv
        TjmecHnNWQO6wOAuOPVCwuxcCw==
X-Google-Smtp-Source: APXvYqw2pNEJxmdkvdfTv8fX/QptHZcdXSaE3psqBWR24p0xffrLlhRgQZcP9hMfShxVkdT9xWXrqw==
X-Received: by 2002:a17:90a:32e4:: with SMTP id l91mr10004158pjb.48.1571390942762;
        Fri, 18 Oct 2019 02:29:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id ce16sm5416635pjb.29.2019.10.18.02.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 02:29:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:58:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFT][PATCH 0/3] cpufreq / PM: QoS: Introduce frequency QoS and
 use it in cpufreq
Message-ID: <20191018092857.dfg6n3xcbdsfjr4r@vireshk-i7>
References: <20191016142343.GB5330@bogus>
 <20191017095725.izchzl7enfylvpf3@vireshk-i7>
 <20191017095942.GF8978@bogus>
 <CAJZ5v0ixS8ZS93Fgj8XGUMGcLdAy+Fgwp5z3QirccNSiiwLtDA@mail.gmail.com>
 <20191018054433.tq2euue675xk4o63@vireshk-i7>
 <CAJZ5v0hpfvy5iELVRWFA3HS8NoAH0=py0cE+fLaUq2hDReCrnQ@mail.gmail.com>
 <20191018082745.3zr6tc3yqmbydkrw@vireshk-i7>
 <CAJZ5v0gR45YNwqrc8JQ_2qQBnYrxPeCHTnvQtEELD8VpXJrxLA@mail.gmail.com>
 <20191018092447.2utqazqfob65x4k2@vireshk-i7>
 <CAJZ5v0hZc5g+AUDSJUkaGSA92mKNSXGyHLd5Qxuf88wP1i4AdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hZc5g+AUDSJUkaGSA92mKNSXGyHLd5Qxuf88wP1i4AdA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-19, 11:26, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 11:24 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-10-19, 10:30, Rafael J. Wysocki wrote:
> > > On Fri, Oct 18, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 18-10-19, 10:24, Rafael J. Wysocki wrote:
> > > > > On Fri, Oct 18, 2019 at 7:44 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > >
> > > > > > On 17-10-19, 18:34, Rafael J. Wysocki wrote:
> > > > > > > [BTW, Viresh, it looks like cpufreq_set_policy() should still ensure
> > > > > > > that the new min is less than the new max, because the QoS doesn't do
> > > > > > > that.]
> > > > > >
> > > > > > The ->verify() callback does that for us I believe.
> > > > >
> > > > > It does in practice AFAICS, but in theory it may assume the right
> > > > > ordering between the min and the max and just test the boundaries, may
> > > > > it not?
> > > >
> > > > I think cpufreq_verify_within_limits() gets called for sure from
> > > > within ->verify() for all platforms
> > >
> > > That's why I mean by "in practice". :-)
> >
> > Hmm, I am not sure if we should really add another min <= max check in
> > cpufreq_set_policy() as in practice it will never hit :)
> 
> Fair enough, but adding a comment regarding that in there would be prudent IMO.

will do.

-- 
viresh
