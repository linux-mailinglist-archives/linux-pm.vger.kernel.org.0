Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C71E145F
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbgEYScP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 14:32:15 -0400
Received: from cmta17.telus.net ([209.171.16.90]:47709 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389507AbgEYScO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 14:32:14 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id dHtPjpLAEmjwfdHtRjRAEl; Mon, 25 May 2020 12:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590431532; bh=DwnlgWYFEihSUuio0v01s3xTbjhMAeUb4PFpGrp4bzA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=odVXyK1lhlR7GKXmOmPIXqLafNJylQPzNHQOUpZOlhJ1dPRAu8BU11Os9UcF+GA+4
         XcKiz78SZ984L9O6G4GvLrzRELImoq4CrpOhRoHhk9VJU2kj+QMIt91HOqzJOdd5iW
         JwhVnh+3RHNQICM3S80qFkKujXP6rPbXmdGNkleHMsgMYGbhKx0LoVTqSvHKHuYV4O
         PyWxNcCmIhyL2hvFi9OlsMtjX8nBjy8SNcjvRijDHTChBzgX5UdqhEU9TDkcFyq+vw
         XjPb2mab2WOABR/5WUZ+kiAF7V+dRtDsyk+gQ+YDOL82Kz8OTughRtwAGyAHv55In/
         Wb19bVINUfi3A==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ea5DgIMH c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=D19gQVrFAAAA:8
 a=8GfnRiUhAAAA:20 a=FGbulvE0AAAA:8 a=6A1WGPImOnARz27ZNyMA:9 a=QEXdDO2ut3YA:10
 a=W4TVW4IDbPiebHqcZpNg:22 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Pratik Sampat'" <psampat@linux.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <rafael.j.wysocki@intel.com>, <peterz@infradead.org>,
        <daniel.lezcano@linaro.org>, <ego@linux.vnet.ibm.com>,
        <svaidy@linux.ibm.com>, <pratik.sampat@in.ibm.com>,
        <pratik.r.sampat@gmail.com>
References: <20200511141055.43029-1-psampat@linux.ibm.com> <000101d62c76$a16ac360$e4404a20$@net> <fca35bce-b1ae-7137-4bf8-aa385c371be4@linux.ibm.com>
In-Reply-To: <fca35bce-b1ae-7137-4bf8-aa385c371be4@linux.ibm.com>
Subject: RE: [RFC 0/1] Alternate history mechanism for the TEO governor
Date:   Mon, 25 May 2020 11:32:06 -0700
Message-ID: <000901d632c2$cda7f8b0$68f7ea10$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYvYELpjVNlGEUnTX63IAsG8BP+SQDX7CYQ
X-CMAE-Envelope: MS4wfIddEKNJ3KXDE3ES5FExA9vWHLzTR8M0Zb3Hc/T0BPqdq78mItLU8YlIRa2nFqyA9lrY/T5CgEdyYTsmyIcxtVAwE3WQJ+csbijtLSWUgV6z2L9oa91+
 CcAg8Z9mzMIx0nRbtZh/7yK9vlXZuBlNyn0+GF8cjJLV1S51o6Sy5jCYGTzueNy9d5qV81dMKzYOJp3OvI28t6uw/1yMGwScH/ZDLXjGEK+Xcj7/K4Xa1NNA
 rb+NNvr5bShsdSR3PEl0dRWaUyMSr+RwN/u9E4ao9oSqScHmdYZ+PoS5J2imsyS6QG5DTSaudmRIJiY4NLKrNagj1GbfEqLOpYxQIN6ZGcF7vp1OUu+c5Whp
 XdoTTBCFVwEY3pX3OFgOAQIGG2iWlf+tZ3G6iB7OzbhCR9Bm7eKf4hGyrqjF2xh6bc+W7wt+J53MEhrBZYHIajtsdjXTw3ktmtqhWtuyTYf7SvwBV7QYlpyn
 kQscPhzvYfFNDqk5vQDF7U2EoDtH7h0gI+c2lg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.05.21 04:09 Pratik Sampat wrote:
> On 17/05/20 11:41 pm, Doug Smythies wrote:
> > On 2020.05.11 Pratik Rajesh Sampat wrote:
> >> First RFC posting:https://lkml.org/lkml/2020/2/22/27
> > Summary:
> >
> > On that thread I wrote:
> >
> >    > I have done a couple of other tests with this patch set,
> >    > but nothing to report yet, as the differences have been
> >    > minor so far.
> >
> > I tried your tests, or as close as I could find, and still
> > do not notice much difference.
> 
> That is quite unfortunate. At least it doesn't seem to regress.

Yes, while I have not been able to demonstrate improvement,
I have not found any regression.

> 
> Nevertheless, as Rafael suggested aging is crucial, this patch doesn't age
> weights. I do have a version with aging but I had a lot of run to run variance
> so I had refrained from posting that.
> I'm tweaking around the logic for aging as well as distribution of weights,
> hopefully that may help.

O.K. I am putting this testing aside for now.
I like the set of tests, as they really show the differences between menu
and teo governors well.

> >>
> >> Sleeping Ebizzy
> >> ---------------
> >> Program to generate workloads resembling web server workloads.
> >> The benchmark is customized to allow for a sleep interval -i
> > I found a Phoronix ebizzy, but without the customization,
> > which I suspect is important to demonstrate your potential
> > improvement.
> >
> > Could you send me yours to try?
> 
> Sure thing, sleeping ebizzy is hosted here:
> https://github.com/pratiksampat/sleeping-ebizzy
> 
> >
> > ebizzy (records per second, more is better)
> >
> > teo		wtteo				menu
> > 132344	132228	99.91%	130926	98.93%

O.K. yours is way different than what I was using.
Anyway, results still are not very different
between teo and wtteo. Some tests are showing a little difference
between above/below statistics [1]

[1] http://www.smythies.com/~doug/linux/idle/wtteo/ebizzy-interval/2_below.png

By the way, and likely not relevant, your sleeping-ebizzy test
seems extremely sensitive to the interval and number of threads.
It is not clear to me what settings I should use to try to re-create
your results. [2] is an interesting graph of records per second verses
intervals verses threads.
 
[2] http://www.smythies.com/~doug/linux/idle/wtteo/doug08/sleeping-ebizzy-records-intervals-threads.png



