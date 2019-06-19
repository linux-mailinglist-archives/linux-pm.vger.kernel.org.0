Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC514BB29
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfFSOT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 10:19:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38428 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfFSOT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 10:19:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so9757887pgl.5
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2019 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEI8Fh7ieFXqGBrFSnKZWlQnMv0luEiXTnHXkZ6G908=;
        b=Flnxb0rv5SjdEq2CKX8JHqbKsFM0KVjZtMPocQih0yh/tlHcXNp+gTJF1d3aatDuKG
         Nc0s++FslvZhpEtaargu2qhErlHO8T6DlrJomDt3JuVsYnib4Z04ZvwRAmoKoTpnlV56
         h2PhrigWUEQpjcUzByjv8A7f84QU/Iw9e44BFhVDUabu8HrtzZLlE15kBah3mIcWcCFE
         0OJqCPAq1yVhQoRxI5LOCY+v/m9Nt/Y+5QUVkoOTnhCn7RpD54S4i6rcpUjMZ1Ex6IgW
         pP0NL+qPzV2G9oMryq/+573XRpBVwpqLrrUzBVM4C0Y32h9GCbk4RcVQF3pgk1yWzQHA
         xznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEI8Fh7ieFXqGBrFSnKZWlQnMv0luEiXTnHXkZ6G908=;
        b=iKGPNWCcR9c2cfSZcce63qMntj4/jFYBs4PfltnWQ3o9p+hJR6sbpZvOpEFt9ypZRE
         RLmAbcu3l2Xt//ierEkcQBVqXBzkldB9ThDxwqvYMwROLtBxa2BuTn8lICyrKK5DHXZd
         nhA9FXn7mmNIIN/p6ZPmAyHxSm0nXoS0AQzQsaNZ4ED8sd35kYNhZ0hx0JYRYkijfj3o
         +jF8B6rA2yWvC8l7AhvFsB6kCEEaTZUknSaVulbYL6VHMTidfRs1Fxh0e0KxleQUQ7FF
         hR7QmifJWflV67jQLv5kIiq3OlDg2hguQbuaaOLOei6UqCfEIZ8JpoefKWUQX32XAW4j
         nKbw==
X-Gm-Message-State: APjAAAV9bAWr3WksH8AK9P1+h80drYRTqIhmwWFeuqvVLr/jk0N6Dzab
        d4dmxdpJhC/UZaTaqWqLC0vEW3imgTY=
X-Google-Smtp-Source: APXvYqxA6X8rzB/43IY/tGvTMR/odXg3L4My5wUefd93mYzS9onGsZtlYTlKN5dvV08YCESlYhOA0g==
X-Received: by 2002:a62:d0:: with SMTP id 199mr93025140pfa.253.1560953967461;
        Wed, 19 Jun 2019 07:19:27 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id e63sm21555025pgc.62.2019.06.19.07.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:19:26 -0700 (PDT)
Date:   Wed, 19 Jun 2019 19:49:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] cpufreq: Remove the has_target() check from notifier
 handler
Message-ID: <20190619141924.eud6hctk75ihgw27@vireshk-i7>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
 <4008d21f166accfb28180eb804cb8ebda6da4f4d.1560944014.git.viresh.kumar@linaro.org>
 <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iR8oBZ2mM2vdHzTBNcjsHa6QtJmN+Q17Q8ZD-ny3qy3w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-06-19, 14:25, Rafael J. Wysocki wrote:
> On Wed, Jun 19, 2019 at 1:35 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > cpufreq_notify_transition() is only called for has_target() type driver
> > and not for set_policy type, and the check is simply redundant. Remove
> > it.
> 
> Ah, OK
> 
> So this patch removes a check introduced by the previous one. :-)
> 
> Please merge them together.

It made sense to keep them separate because there are two different
issues I am fixing here. But if that is what you want, I will merge
them.

-- 
viresh
