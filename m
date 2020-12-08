Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1263E2D2244
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 05:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgLHEsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 23:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgLHEsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 23:48:52 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4637C061793
        for <linux-pm@vger.kernel.org>; Mon,  7 Dec 2020 20:48:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id f9so12104129pfc.11
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2020 20:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+a4JfEuJPj+G4wzsoHlVwRdBKRoQxlLRdwTZTqYHQo=;
        b=lFgivkchqxY+Z3ILx+m5I4AbOsApyKCEV7/UL01AiN17xt15DXRzocH4To2uskZC1c
         2KPNzAfAB8RTnLPPf6/xnmgbsJFI94ed4Z7UEcaUQ3+X3lSM7s9qCARTk/8DKf4wfK1o
         8TRFopWB7XtoekvbBhg9DNiyf16PCOCvxQdYVxZXW7Qz6WCAYJAE6SEb/PHbocCQKdWQ
         vfA4jvdH8J3arjARX3I1Fc3uzmwbdeyq1KGq0VeVaOnvXbaGKth4XN/AnOZbdMcBqxa6
         5owlfUXlBl9YtxTeDF4VUAmsQiUP/kUuiLtjSOoCg9uzgsuTA0imYU1zYAQvNBTg1S7T
         Jrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+a4JfEuJPj+G4wzsoHlVwRdBKRoQxlLRdwTZTqYHQo=;
        b=hRzCcn48uffMWv9L3lssksl/5t/L+NyrGZawn9lG5wA2kVCtfY2zZ+/NYAHGL31T9W
         LJf4n/bNn7+rKss9ftm3PDLr6ssmCHUwIxRnBgc7iF12DuVbZzIJGIYKHLKGJolEJetz
         yCVN3sJeb/jK6TKHLHnAUsyT88JnwY2aB/njJi7tK5KqTjoSiqN63SFDUPO2JvX5Hqsh
         Uo1nSiectf/cJUdpSKDItSkPYGtewdfiPt7cHYU1CQkj/ZqHa3N9yPMDCISTX7cUJzTt
         b+JV0to4ctu6k5m6L0wZ8nIFE+0K1MYuOWfnwxrQu9Kgad0sHvTfbjiWIcatki1ZFqAP
         DJiA==
X-Gm-Message-State: AOAM531OnDNekYbv1onNlsWdNg5vvkt1Ei7OSL5sawdmeJ07Iax6JPgu
        oIpN/IrLbn7OGSFh3CL4eaD6fw==
X-Google-Smtp-Source: ABdhPJyWymG7nJBYFow8xJNbQNgwTbl9wnPqUCrx1NSPFIYqppsL6InNpbtQXg45ieSc80LvfZWlzA==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr2413112pjr.231.1607402886491;
        Mon, 07 Dec 2020 20:48:06 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id 65sm15747595pfd.184.2020.12.07.20.48.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:48:05 -0800 (PST)
Date:   Tue, 8 Dec 2020 10:18:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Dietmar.Eggemann@arm.com, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, rafael@kernel.org
Subject: Re: [PATCH 0/2] SCMI performance protocol power scale interface
Message-ID: <20201208044803.6kepfqvoz3pov4c3@vireshk-i7>
References: <20201124104346.27167-1-lukasz.luba@arm.com>
 <20201207071308.rm7x6ro7i4qtmm7h@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207071308.rm7x6ro7i4qtmm7h@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-12-20, 12:43, Viresh Kumar wrote:
> On 24-11-20, 10:43, Lukasz Luba wrote:
> > Hi all,
> > 
> > The Energy Model (EM) supports power values expressed in an abstract scale
> > via new API. The SCMI performance protocol provides the information about
> > power scale. This patch set implements the needed interface and updates
> > cpufreq driver to set the right scale in the EM.
> > 
> > It is based on top of patch series adding milli-Watts flag in EM [1]
> > (next-20201124 was used as a base).
> > 
> > Regards,
> > Lukasz
> > 
> > [1] https://lore.kernel.org/linux-pm/20201103090600.29053-1-lukasz.luba@arm.com/
> > 
> > Lukasz Luba (2):
> >   firmware: arm_scmi: Add power_scale_mw_get() interface
> >   cpufreq: arm_scmi: Discover the power scale in performance protocol
> > 
> >  drivers/cpufreq/scmi-cpufreq.c   | 4 +++-
> >  drivers/firmware/arm_scmi/perf.c | 8 ++++++++
> >  include/linux/scmi_protocol.h    | 1 +
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

More scmi stuff came in which I had to apply and so I applied this to
the ARM tree.

Rafael: I had to rebase this over one of the patches from your tree,
which was based on rc3:

commit c250d50fe2ce ("PM: EM: Add a flag indicating units of power values in Energy Model")

I hope you won't rebase it any further.

Applied. Thanks.

-- 
viresh
