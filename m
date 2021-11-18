Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1445635B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhKRTWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 18 Nov 2021 14:22:24 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22545 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhKRTWV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 14:22:21 -0500
X-IronPort-AV: E=Sophos;i="5.87,245,1631577600"; 
   d="scan'208";a="153046298"
Subject: Re: correct source tree to make contributions to Linux thermal framework
Thread-Topic: correct source tree to make contributions to Linux thermal framework
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP; 18 Nov 2021 19:19:21 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id 8E90A141135;
        Thu, 18 Nov 2021 19:19:18 +0000 (UTC)
Received: from EX13D37UWC004.ant.amazon.com (10.43.162.212) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 18 Nov 2021 19:19:11 +0000
Received: from EX13D19UWC002.ant.amazon.com (10.43.162.179) by
 EX13D37UWC004.ant.amazon.com (10.43.162.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 18 Nov 2021 19:19:11 +0000
Received: from EX13D19UWC002.ant.amazon.com ([10.43.162.179]) by
 EX13D19UWC002.ant.amazon.com ([10.43.162.179]) with mapi id 15.00.1497.026;
 Thu, 18 Nov 2021 19:19:11 +0000
From:   "Balakrishnan, Anand" <anandbal@lab126.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Healy, Christopher" <healych@amazon.com>
Thread-Index: AQHX1yvWy3qyuzSbLUWobh1b1ZbZYqv+sO8AgAHFa++AAKusgIAIkehV
Date:   Thu, 18 Nov 2021 19:19:11 +0000
Message-ID: <1637263151124.77301@lab126.com>
References: <1636488946043.43408@lab126.com> <YYvuAU+d3TAS6fI7@kroah.com>
 <1636656130551.5237@lab126.com>
 <5007f2fd-285c-73fd-21a9-ab0029578d4a@linaro.org>
 <1636755294516.66191@lab126.com>,<01d80851-f26b-0314-b1a4-2dbc3a620394@linaro.org>
In-Reply-To: <01d80851-f26b-0314-b1a4-2dbc3a620394@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.223]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sounds good! Thank you Daniel.
________________________________________
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Sent: Saturday, November 13, 2021 12:26 AM
To: Balakrishnan, Anand; linux-pm@vger.kernel.org; amit.kachhap@gmail.com; viresh.kumar@linaro.org; amit.kucheria@verdurent.com; Rafael J. Wysocki
Cc: Healy, Christopher
Subject: RE: [EXTERNAL] correct source tree to make contributions to Linux thermal framework

CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.



[Cc: Rafael]

Hi Anand,

yeah, actually it is a bit fuzzy because we did a small reorg.

You can either send to the tree pointed in the MAINTAINERS file or
against the tree I pointed below. I would recommend to use the later. In
any case it will be synced with the one in MAINTAINERS when we are close
to the release.

On 12/11/2021 23:14, Balakrishnan, Anand wrote:
> Hey Daniel,
>
> Thank you for for the information. In the future, If I have to find this information by myself, is there a document for this?
> I was looking at https://www.kernel.org/doc/linux/MAINTAINERS and there are several references to thermal here, but I did not see any mention of the tree you pointed me to.
>
> Thanks,
> Anand
> ________________________________________
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> Sent: Thursday, November 11, 2021 11:09 AM
> To: Balakrishnan, Anand; linux-pm@vger.kernel.org; amit.kachhap@gmail.com; viresh.kumar@linaro.org; amit.kucheria@verdurent.com
> Cc: Healy, Christopher
> Subject: RE: [EXTERNAL] correct source tree to make contributions to Linux thermal framework
>
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 11/11/2021 19:42, Balakrishnan, Anand wrote:
>> Hello folks,
>>
>> At our company, we maintain an internal thermal framework patch. We are exploring the option to up-stream this patch so we don't have to keep porting this from one Kernel version to the other. Looking for advise on the right device tree to get started.
>> Thermal framework code resides here: https://elixir.bootlin.com/linux/latest/source/drivers/thermal. What is the correct source tree we should use from https://git.kernel.org/??
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/
>
> branch : next
>
>
>
> --
> <http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>


--
<http://www.linaro.org/> Linaro.org Å Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
