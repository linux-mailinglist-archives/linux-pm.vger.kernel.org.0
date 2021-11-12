Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638E844EF20
	for <lists+linux-pm@lfdr.de>; Fri, 12 Nov 2021 23:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhKLWRs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 12 Nov 2021 17:17:48 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6138 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhKLWRs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Nov 2021 17:17:48 -0500
X-IronPort-AV: E=Sophos;i="5.87,230,1631577600"; 
   d="scan'208";a="151654841"
Subject: Re: correct source tree to make contributions to Linux thermal framework
Thread-Topic: correct source tree to make contributions to Linux thermal framework
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 12 Nov 2021 22:14:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id BDC358C362;
        Fri, 12 Nov 2021 22:14:55 +0000 (UTC)
Received: from EX13D37UWC004.ant.amazon.com (10.43.162.212) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 12 Nov 2021 22:14:55 +0000
Received: from EX13D19UWC002.ant.amazon.com (10.43.162.179) by
 EX13D37UWC004.ant.amazon.com (10.43.162.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 12 Nov 2021 22:14:55 +0000
Received: from EX13D19UWC002.ant.amazon.com ([10.43.162.179]) by
 EX13D19UWC002.ant.amazon.com ([10.43.162.179]) with mapi id 15.00.1497.026;
 Fri, 12 Nov 2021 22:14:55 +0000
From:   "Balakrishnan, Anand" <anandbal@lab126.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>
CC:     "Healy, Christopher" <healych@amazon.com>
Thread-Index: AQHX1yvWy3qyuzSbLUWobh1b1ZbZYqv+sO8AgAHFa+8=
Date:   Fri, 12 Nov 2021 22:14:54 +0000
Message-ID: <1636755294516.66191@lab126.com>
References: <1636488946043.43408@lab126.com> <YYvuAU+d3TAS6fI7@kroah.com>
 <1636656130551.5237@lab126.com>,<5007f2fd-285c-73fd-21a9-ab0029578d4a@linaro.org>
In-Reply-To: <5007f2fd-285c-73fd-21a9-ab0029578d4a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.157]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Daniel,

Thank you for for the information. In the future, If I have to find this information by myself, is there a document for this?
I was looking at https://www.kernel.org/doc/linux/MAINTAINERS and there are several references to thermal here, but I did not see any mention of the tree you pointed me to.

Thanks,
Anand
________________________________________
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Sent: Thursday, November 11, 2021 11:09 AM
To: Balakrishnan, Anand; linux-pm@vger.kernel.org; amit.kachhap@gmail.com; viresh.kumar@linaro.org; amit.kucheria@verdurent.com
Cc: Healy, Christopher
Subject: RE: [EXTERNAL] correct source tree to make contributions to Linux thermal framework

CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.



On 11/11/2021 19:42, Balakrishnan, Anand wrote:
> Hello folks,
>
> At our company, we maintain an internal thermal framework patch. We are exploring the option to up-stream this patch so we don't have to keep porting this from one Kernel version to the other. Looking for advise on the right device tree to get started.
> Thermal framework code resides here: https://elixir.bootlin.com/linux/latest/source/drivers/thermal. What is the correct source tree we should use from https://git.kernel.org/??

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/

branch : next



--
<http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
