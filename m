Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5869A6BA46
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfGQKdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 06:33:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41271 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGQKdK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 06:33:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so10635041pff.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2019 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9k7PEq3YaWLJm47OKEtp5j4oXp3rjTfBF0mMIsuiDAQ=;
        b=Dul4ANMNCdSpSs/j0ZxpHvioQBfiR4bXcwEQRW8s+ErgOSfdnx78Qt8agNUBZG2V3G
         tIua5SDC9I7sQA0/bT7Bx09ekRomkuC+GLFRBo+0UJuAznly6/B+tRlfGxcToEexpXOD
         WgTxMleNqwhWPq89fF2sDgVMGb6gzFtCu8Qfq9EZI/pb1EdKu+rUIDdAh+nZRL2ikDUc
         4zagx9uiklANQvb30ZF6DIQvy3C9aeD9V1a3dEhkPo0cz2VX6G/MHuVM5bzXFX0ydpey
         bHNpblAL973a8HGH7qAe0Q5tLQmKQYmXRKXDh6tFpzLkCUSUotfCdiJ0idFQNBYtcWn/
         cE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9k7PEq3YaWLJm47OKEtp5j4oXp3rjTfBF0mMIsuiDAQ=;
        b=ZozyoUAEqDaTu3sTbVZmz0AkxxZTO3w4RensnDJMpB3P3rQxOcyBig1Eycn+4F8poG
         BB9idbronKJqkwiEWja5MXCNxoV99JdK5bitFSoTS8sxl6aotJA0TYqtZvXLUG+Z2yZF
         tBBxil3pmJGFl48HTQ4uSjTzwJO/Zm5qIFrz8wS2zWs0emak3J6pVV/OfYFN97nTPX5j
         Kmsx5GdzEE67AVBPd7RizotL/draawDbJ54jNxkgc+ddhFn5AZCw169D6X57C/vylG7m
         G9jjcjxCd0eZuyGo81nU/eeoynsmFMAtSVaj5HJDF4vLyA+I1MUb92jwLicfvNmR8hrl
         IXxA==
X-Gm-Message-State: APjAAAVbx+nE9sA3vCu3IUguwXK84JgSPGvlRWFN6mXHZUamrqdhKElE
        wg/fduFqLNcjpYL1DNIwvWmi1w==
X-Google-Smtp-Source: APXvYqz/Sfxl0RQLtUc3wMREss8uX/59u3jEO2nzgrxKdE2umZKvMGiCYBh9eFTpkdk7pse+CuF5gA==
X-Received: by 2002:a65:690e:: with SMTP id s14mr26228230pgq.47.1563359590031;
        Wed, 17 Jul 2019 03:33:10 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 30sm58222326pjk.17.2019.07.17.03.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:33:08 -0700 (PDT)
Date:   Wed, 17 Jul 2019 16:03:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190717103306.r3wuqvvwr2b5z4ok@vireshk-i7>
References: <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
 <20190318122113.GA4834@apalos>
 <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
 <20190425123303.GA12659@apalos>
 <20190520112042.mpamnabxpwciih5m@vireshk-i7>
 <20190522070341.GA32613@apalos>
 <20190522070614.jhpo7nqrxinmlbcs@vireshk-i7>
 <20190610101918.sypafywc6fn4jsbo@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610101918.sypafywc6fn4jsbo@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-06-19, 15:49, Viresh Kumar wrote:
> On 22-05-19, 12:36, Viresh Kumar wrote:
> > On 22-05-19, 10:03, Ilias Apalodimas wrote:
> > > Hi Viresh, Gregory
> > > On Mon, May 20, 2019 at 04:50:42PM +0530, Viresh Kumar wrote:
> > > > On 25-04-19, 15:33, Ilias Apalodimas wrote:
> > > > > Hi Viresh,
> > > > > 
> > > > > > > > Also, during this week-end, Christian suggested that the issue might
> > > > > > > > come from the AVS support.
> > > > > > > > 
> > > > > > > > Could you disable it and check you still have the issue?
> > > > > > > > 
> > > > > > > > For this, you just have to remove the avs node in
> > > > > > > > arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
> > > > > > > Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
> > > > > > >  once i return
> > > > > > 
> > > > > > @Ilias: Can you please try this now and confirm to Gregory ?
> > > > > I am more overloaded than usual and totally forgot about this. Apologies.
> > > > > I'll try finding some time and do this.
> > > > 
> > > > Ping Ilias.
> > > Sorry for the huge delay. 
> > > Applying this patch and removing tha 'avs' node from
> > > arch/arm64/boot/dts/marvell/armada-37xx.dtsi seems to work.
> > > Changing between governors does not freeze the board any more. I haven't checked
> > > the actual impact on the CPU speed but the values on 
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor are correct
> > 
> > Thanks for testing it out. Lets see what Gregory has to say now.
> 
> @Gregory: Do you have any further advice for Ilias ?

Ping.

-- 
viresh
