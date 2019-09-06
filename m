Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0573CABF0C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbfIFRzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 13:55:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:9972 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388384AbfIFRzu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 13:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567792547;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=le0i+C3WnJJ1pNcpGn6EKP8MS/2QDXn4lZNvB0jm46I=;
        b=QDpoVKvqt6915dyUTD+lH3OqId+5Uc4wxacuz+IjP8LKaWrUMdMSN7J/dyeEDk5uiN
        HU3z/eHIuJ+Jx59C8WoHxVTSTMZtSS4PrzZ2+ITJ08DGKbjGc/dXSpPkyIdeoC+EhlK7
        gmRZdan+nEqWYgMSnN6e3JXC/yR1rxb+FVk/NT9bPgI9M0DldZeF9h8xeHBTEmSWKGTO
        2w42kLWtItN/bM0W1s0NC6d3l2mfp8RA0LN0Is1TLgxZp1OwYy+ljx/XoxK+ObrmQr81
        ycbv+Tdf82NzAOy/pcWyEf0tBlTS7IuB5SrQyt0DhPTh26wZdeTrRRNOotG+IrF50Xv3
        5xGw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PqwDqp5w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v86Htepil
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Sep 2019 19:55:40 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190906172403.GG52127@atomide.com>
Date:   Fri, 6 Sep 2019 19:55:40 +0200
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Transfer-Encoding: 7bit
Message-Id: <17A56ADB-2217-41CC-BE0B-C3899815F10F@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com> <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com> <20190906154732.GC52127@atomide.com> <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com> <20190906172403.GG52127@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 06.09.2019 um 19:24 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [190906 17:09]:
> 
>> BTW there is also some code that does special SoC detection based on
>> soc_device_match(), mainly in omapdrm/dss.
>> 
>> If we were to use this mechanism in the ti-cpufreq driver we could
>> match it to ti,omap3 and could avoid all these changes.
>> 
>> But make it less maintainable and code more complex.
> 
> Hmm right, yeah using soc_device_match() would remove this issue.
> It might be worth doing as these SoC variants do not change
> much and the code should not need updating. Up to you to
> decide.

I have looked through the structure of the ti-cpufreq driver but
it assumes that each set of register offsets and bit masks
has its own compatible so that it can just switch descriptor
tables.

There is no provision to run soc_device_match() instead.

So let's forget this idea...

BR,
Nikolaus

