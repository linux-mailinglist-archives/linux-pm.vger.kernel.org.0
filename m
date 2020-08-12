Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628B6242C6A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHLP4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 11:56:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:18906 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHLP4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 11:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597247792;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OSjvd7G+zioql212JD4p59KZiEpBAmk13HwupraTamg=;
        b=ck1I2Xw5jcVneUBZ9Qr+6SHMKqEva+gM1W5US6RC3aQ7FVnfrvXfqaphGLs/BL88Yf
        WgZUGCCX9TxT7frWn7bVZ8bV1nX1OVrf+bYBYyMNODtYQOQQocWNIp0cMfWWz+zOvfmn
        /DXo2zdgq4JgLAAiQ/dYLc8NLM8C5GrC3Z3HNEK9HywQXvtswVofBqHzYamPdKAGm5gd
        k0wRN6GiXeQjX+PLyV8F8CksuFSh/8pWk1Tz93rznaXOwk65yDwDEnGZUt63Znjtreo4
        XsJvscflepWZsY/IZ6gL/IpP9cKdyjFes2YVga+I0rgqVXUA1tPvuU8sF/OMjow9udU8
        hvcg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew7CFuUtTn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 12 Aug 2020 17:56:30 +0200 (CEST)
Date:   Wed, 12 Aug 2020 17:56:25 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20200812155625.GA1048@gerhold.net>
References: <20200727093047.8274-1-stephan@gerhold.net>
 <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
 <20200812105333.GA913@gerhold.net>
 <20200812150122.dennzvxfzk4fyxm2@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812150122.dennzvxfzk4fyxm2@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Aug 12, 2020 at 08:31:22PM +0530, Viresh Kumar wrote:
> On 12-08-20, 12:53, Stephan Gerhold wrote:
> > I have another small build fix reported by the kernel test robot,
> > but will wait with sending that out until Viresh had a chance to give
> > some feedback on the basic idea. :)
> 
> What was the issue that was reported ? I may end up applying V1 only
> with some of my changes.
> 

It was this build error on SH (for the second patch):

>> drivers/cpufreq/cpufreq-dt.c:36:29: error: conflicting types for 'cpu_data'
      36 | static struct private_data *cpu_data;
         |                             ^~~~~~~~
   In file included from arch/sh/include/asm/thread_info.h:27,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/current.h:5,
                    from ./arch/sh/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from drivers/cpufreq/cpufreq-dt.c:11:
   arch/sh/include/asm/processor.h:90:26: note: previous declaration of 'cpu_data' was here
      90 | extern struct sh_cpuinfo cpu_data[];
         |                          ^~~~~~~~

I fixed it by renaming "cpu_data" to "cpufreq_dt_data". (I could not
think of a better name so feel free to use something else...)

Thanks!
Stephan
