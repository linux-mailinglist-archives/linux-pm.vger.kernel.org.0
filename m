Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B679218B77
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgGHPjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 11:39:08 -0400
Received: from cmta19.telus.net ([209.171.16.92]:50999 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHPjI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 11:39:08 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id tCA3jzWtbpULutCA4jlAgm; Wed, 08 Jul 2020 09:39:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594222746; bh=o5N79ZBHeiTcyL5ymZ08ngwvFVTh4xphD8Umxn4JnFU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=s5SXM0P+vErz8gOrpU01BkGjcxTzi9PQDDoER2OXr0jOfsT4JtbMKiwvCGJQciqYN
         6br6eGgCcHGf9R2euRI60arPXHWOhkGvHUQ3pJi7+AKBlkcwubRbFY/2JUkd/wY0i2
         /FVIiQXgWHBiljc6R3cwP/PWe+gFjBo704J8O9/Es71D/NRMwts2tSfhd1YtjJQvg3
         9sbTZOKELC4RbsGhaU/oUu7lbidP/oR2YUloo6qf0rDjO3Oz1Zq/jDBQBnz+BiToPH
         N7YWKjXJGId9ooQjnbLtnHXvL3+u8RZi+GFjFIltFcLSP2PCsgtSgGIV9byZYrkIl8
         F71IbVBDU8g/A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=T9TysMCQ c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=XF7CgRh_bXJ1lIju71kA:9
 a=peVjOHcpNOfjnLYI:21 a=NDR9TLrs6DQf6WNk:21 a=QEXdDO2ut3YA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'srinivas pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'Len Brown'" <len.brown@intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <2931539.RsFqoHxarq@kreacher>        <000001d6376a$03bbaae0$0b3300a0$@net>   <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>        <000201d63776$2d56f330$8804d990$@net>    <000b01d65535$d148b8c0$73da2a40$@net> <f49c960588fecc4a88891ded347b40370f5808ec.camel@linux.intel.com>
In-Reply-To: <f49c960588fecc4a88891ded347b40370f5808ec.camel@linux.intel.com>
Subject: RE: cpufreq: intel_pstate: HWP mode issue
Date:   Wed, 8 Jul 2020 08:39:02 -0700
Message-ID: <000c01d6553d$e9f59480$bde0bd80$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZVN7J7rlBfXP5BTdmqdsuXdUv+pAABOa2g
X-CMAE-Envelope: MS4wfIqI8C2bvIokoCyiFxe+V/U2mF6NN0MxtdTYIAWJGkA7UdcpFBiQuIO0M1AMM1C77BfXj9UwYj7buu8ziRpXH7+/WiZuUtHSiOEtTh55WwRTWfLr2hPL
 7mSDB17+ytG+D0h2PUbHfgQIU3PD1xFSYnpBfwmR/a/WYu0/OO3bGEAf05A8NLaAKm+y0G7qrq8Qn9fIgU9oWN2VUzr5fkAznmSNlDS2+kCarPVYFCGAC8dn
 LHK4JuZLbMIQOpB63JFoipR5i3eax5ITZDx8T6ddp1sCK2ZmRF0m2x034SK3SU0ZQ54pU/inT0LDdljFdEF9LTVZGdRCWz4VTNFqj/4qEaeEeXu1IpnkPF5F
 9DLasq3dYujid5vBJNVvfiHFefhBJQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.07.08 07:54 srinivas pandruvada wrote:
> On Wed, 2020-07-08 at 07:41 -0700, Doug Smythies wrote:
> > On 2020.06.30 11:41 Doug Smythies wrote:

...

> > > If the short sleep is somehow simultaneous with some sort of 5.0
> > > millisecond (200 Hertz)
> > > periodic event (either in HWP itself, or via the driver, I am
> > > unable to determine which,
> > > but think it is inside the black box that is HWP),
> >
> > I have been attempting to characterise the "black box" that is HWP.
> > In terms of system response verses EPP, I only observe the HWP loop
> > time as the
> > response variable.
> >
> > 0 <= EPP <= 1 : My test can not measure loop time.
> > 2 <= EPP <= 39 : HWP servo loop time 2 milliseconds
> > 40 <= EPP <= 55 : HWP servo loop time 3 milliseconds
> > 56 <= EPP <= 79 : HWP servo loop time 4 milliseconds
> > 80 <= EPP <= 133 : HWP servo loop time 5 milliseconds
> > 134 <= EPP <= 143 : HWP servo loop time 6 milliseconds
> > 144 <= EPP <= 154 : HWP servo loop time 7 milliseconds
> > 155 <= EPP <= 175 : HWP servo loop time 8 milliseconds
> > 176 <= EPP <= 255 : HWP servo loop time 9 milliseconds
> >
> > If there are other system response differences within
> > those groups, I haven't been able to detect them,
> > but would be grateful for any further insight.
> >
> > Otherwise, in future, I do not see a need to test anything
> > other than 9 values of EPP, one from each group.
> >
> Thanks Doug,
> I think they are enough. But there is no guarantee that every CPU model
> will have same results as the power curve will be different.

Yes, of course the response curve is different between CPU models.

However, the basic loops times seem to be the same.
Although I admit to having limited data from other CPU models.

... Doug


