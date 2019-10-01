Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B69C3ED4
	for <lists+linux-pm@lfdr.de>; Tue,  1 Oct 2019 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfJARmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Oct 2019 13:42:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45977 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfJARmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Oct 2019 13:42:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so5822393pls.12
        for <linux-pm@vger.kernel.org>; Tue, 01 Oct 2019 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YFxRATsNQaGZQ2KW4IdFsbHZlAeW0PIeqLRycQhx35w=;
        b=EuM4Q0z1OahXXHkGjQfyNSGZ1+CO/NpKjlblsrTfRm5BrRkcK+aVXim9KLPIKlID18
         b3H3pHd4q+mjbkN5ppIOULKrRFEUmV4ipMxiTo5nKspuWP2TFReXJsfG0FRf7OvxXTeM
         4hhMDgrk8tPcJNfqBpMeWTWEdCC0yuzU25BFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YFxRATsNQaGZQ2KW4IdFsbHZlAeW0PIeqLRycQhx35w=;
        b=Nsnt1ttO2qcpOaEloEKsrVlHxWe0f+l5E6gIbnetXALR2OMF8ryHgvoSMxRgNb4JpY
         wkwHVGsfg66gRiyX/jMtxH54BP15XaSSndmMOTqKaNaGMKKBcini/BTZXMl+/pVAmM2y
         B0zOXXvIZgvLnVEd5i9eUFyXQhBp7Rd73UDhT11UaSbq+2Lfumj6LMim9Dgsu/KuW4Gg
         8s0y5af8TNd4v8p5vZrFXP91eVD1487RS0VaNEHU9SeS4aRZaml6wyfiGhher8XgXzS5
         RJ6xQPhG7k2nKOyZ0+IfFgwfnPrVxkw87f8cWDTxxCxk2zEf3lh0WmncQkRf6PgBO8K7
         AlBA==
X-Gm-Message-State: APjAAAWY2MtqCAlQgveAH9fRrqMyT5mFhSNt+4WVUNaFMvtmw+BtdzI5
        /rleXw3QHZNNnIXD8c2/6HjuhyMzQ/8=
X-Google-Smtp-Source: APXvYqyisXQ1TNjFshaU4wTjOi7PUBwRw4IyhoZPQeAeY44k/fmfqYg+kNWQ337Jxz2KS1UwCR7Lnw==
X-Received: by 2002:a17:902:9346:: with SMTP id g6mr27688893plp.0.1569951757581;
        Tue, 01 Oct 2019 10:42:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id g24sm27852167pgn.90.2019.10.01.10.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 10:42:36 -0700 (PDT)
Date:   Tue, 1 Oct 2019 10:42:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20191001174235.GC87296@google.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
 <20190927044239.589e7c4c@oasis.local.home>
 <20191001163542.GB87296@google.com>
 <20191001130343.4480afe3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001130343.4480afe3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 01, 2019 at 01:03:43PM -0400, Steven Rostedt wrote:
> On Tue, 1 Oct 2019 09:35:42 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > How about this instead:
> > 
> >   Add tracepoints for genpd_power_on, genpd_power_off and
> >   genpd_set_performance_state. The tracepoints can help with
> >   understanding power domain behavior of a given device, which
> >   may be particularly interesting for battery powered devices
> >   and suspend/resume.
> 
> Do you have a use case example to present?

TBH I'm not looking into a specific use case right now. While
peeking around in /sys/kernel/debug/tracing/events to learn more
about existing tracepoints that might be relevant for my work
I noticed the absence of genpd ones and it seemed a good idea to
add them preemptively. Conceptually they seem similar to the
existing regulator_enable/disable and cpu_idle tracepoints.

As an abstract use case I could see power analysis on battery
powered devices during suspend. genpd_power_on/off allow to see
which power domains remain on during suspend, and might give
insights for possible power saving options. Examples could be that
a power domain stays unexpectedly on due to a misconfiguration, or
two power domains remain on when it could be only one if you just
moved that one pin/port over to the other domain in the next
hardware revision.
