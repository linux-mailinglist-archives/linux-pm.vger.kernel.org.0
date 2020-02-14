Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28815D169
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 06:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgBNFPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 00:15:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgBNFPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 00:15:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so3980456pgb.10
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 21:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QRk5Zljn1lKIjPz15k6H1gsb9lvPh6I6NgMh2RdI9TI=;
        b=ryq/cbkron/mmKV6fSfBuR6oUB0Bd7ESe5T7f9weFELJcLnB0dRvMe7AmxyVxS8HLu
         W1kS2oQbBnocOqdJPWW2DrhCXWs0HVQBV25lL7SyMNAhKd/qp1zrjAoXazXikUUFQdMk
         0o/eJ2Oqxjs+eyr54jJwQCpJ9yXRAzbut5gAOf2LGAnZkaUIgricWQl9yfie8F6aV7/v
         gJsm+ePQB5wfWkjsiyiEf5pivS9Cs93M60F98xveIhb8m4e5rbn5iV5j/ENrMWMNM8+H
         hJuDFKP98L2AcXq6OPsv/0ejkyGkBM8zyc34f9xWc8ApG+rR2kWslqsPB9DlQPYlp8TD
         rYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRk5Zljn1lKIjPz15k6H1gsb9lvPh6I6NgMh2RdI9TI=;
        b=A3LHljPWFKoZb+qker653lweLK2EK4dujQ2sROPt1VNRrq5GRknjsNqaOr7CxylvkZ
         2lRNK+9/LVmsr3e8Za5NRYkLA2sB6orPr42OObcWU2fvVdyeq+z0fe70p88oP4x3IDya
         xOop8d8HQ5mXZjLIA/icWEjFSNm2zj8tfIoML3qGqzb+pZV6ANTtryfss9bcL0772Qc8
         2PoFaUXfJchUvZJlrNjW2zNwP+8yXO7+b0Jje4M+rnlHLVOWT9bH1a9svOyU8AO95wdc
         FfpIxotLzQKCWmAA2vayLJ62aPZOhO0YKaYWlWHh25WcvkEDIPbLPVO+MVEGtpkQKhCQ
         8pCg==
X-Gm-Message-State: APjAAAUzIvxeYxEIjJ29O8Z66deWQLq3xudmemwLXmdivr/5GBUSUz3u
        QLLLYdo/5h0yo+wzPJFZd6PYFw==
X-Google-Smtp-Source: APXvYqwkGwn6+atEIvz2J/22MKHTjW/+k4K/B+LIvMiCr7myGXbqYOBSx4dBYnQsg30G6nYfrbwpgg==
X-Received: by 2002:a63:cc4c:: with SMTP id q12mr1501628pgi.443.1581657349107;
        Thu, 13 Feb 2020 21:15:49 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm4917435pff.151.2020.02.13.21.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 21:15:48 -0800 (PST)
Date:   Thu, 13 Feb 2020 21:15:46 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
Message-ID: <20200214051546.GS1443@yoga>
References: <20200214004413.12450-1-john.stultz@linaro.org>
 <20200214021922.GO1443@yoga>
 <CALAqxLWSXGQ0eD-1cxdB-mkJkyySRLo2MqZ4Y0YokhSZJJ6f-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWSXGQ0eD-1cxdB-mkJkyySRLo2MqZ4Y0YokhSZJJ6f-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 13 Feb 20:05 PST 2020, John Stultz wrote:

> On Thu, Feb 13, 2020 at 6:19 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > The purpose of 25b4e70dcce9 ("driver core: allow stopping deferred probe
> > after init") is to ensure that when the kernel boots with a DeviceTree
> > blob that references a resource (power-domain in this case) that either
> > hasn't been compiled in, or simply doesn't exist yet, it should continue
> > to boot - under the assumption that these resources probably aren't
> > needed to provide a functional system.
> >
> > I don't think your patch maintains this behavior, because when userspace
> > kicks in and load kernel modules during the first two minutes they will
> > all end up in the probe deferral list. Past two minutes any event that
> > registers a new driver (i.e. manual intervention) will kick of a new
> > wave of probing, which will now continue as expected, ignoring any
> > power-domains that is yet to be probed (either because they don't exist
> > or they are further down the probe deferral list).
> 
> Hmm. I'll have to look at that again. I worry the logic is overloaded
> a bit, because the logic in __driver_deferred_probe_check_state() will
> only return -EPROBE_DEFER before late_initcall otherwise it returns
> -ETIMEDOUT or 0.  So if we call__genpd_dev_pm_attach() after
> late_initcall and the pd isn't ready, the driver probe will fail
> permanently and not function.
> 

Correct. And the motivation for this is that if you use a dtb from the
future it might describe a power-domain provider that is not yet
implemented in the booting kernel and as such the purpose is to fail
fast - in a way that drivers can ignore, rather than probe deferring
indefinitely.

> I'd think in the case you describe (correct me if I'm misunderstanding
> you), modules that load in the first two minutes would hit
> EPROBE_DEFER only if a dependency is missing, and will continue to try
> to probe next round. But once the two minutes are up, they will catch
> ETIMEDOUT and fail permanently.
> 

This extends the time that probe deferral is functional from
late_initcall to 2 minutes from boot, which should solve all practical
problems you and I have with the current situation.

But the specific detail that your patch is missing is that drivers that
probe defer will end up on the deferral list and this list is only
processed whenever drivers are added or some driver succeeds to probe.
So before the 2 minutes the deferral dance will stop and you need one of
these events to kick off the dance again.

> > You can improve the situation somewhat by calling
> > driver_deferred_probe_trigger() in your
> > deferred_initcall_done_work_func(), to remove the need for human
> > intervention. But the outcome will still depend on the order in
> > deferred_probe_active_list.
> 
> Ok. I'll take a look at that.
> 

Cool

> Thanks so much for the feedback!

Thank you for working on this, I've spent days debugging subtle issues
because of this feature...

Regards,
Bjorn
