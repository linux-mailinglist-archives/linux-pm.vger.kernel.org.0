Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319544DBAC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhKKSpJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 11 Nov 2021 13:45:09 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25751 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhKKSpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 13:45:08 -0500
X-IronPort-AV: E=Sophos;i="5.87,226,1631577600"; 
   d="scan'208";a="173415338"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-8691d7ea.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 11 Nov 2021 18:42:18 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-8691d7ea.us-east-1.amazon.com (Postfix) with ESMTPS id D8A13C08A0;
        Thu, 11 Nov 2021 18:42:16 +0000 (UTC)
Received: from EX13D37UWC004.ant.amazon.com (10.43.162.212) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Thu, 11 Nov 2021 18:42:11 +0000
Received: from EX13D19UWC002.ant.amazon.com (10.43.162.179) by
 EX13D37UWC004.ant.amazon.com (10.43.162.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.24; Thu, 11 Nov 2021 18:42:10 +0000
Received: from EX13D19UWC002.ant.amazon.com ([10.43.162.179]) by
 EX13D19UWC002.ant.amazon.com ([10.43.162.179]) with mapi id 15.00.1497.024;
 Thu, 11 Nov 2021 18:42:10 +0000
From:   "Balakrishnan, Anand" <anandbal@lab126.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>
CC:     "Healy, Christopher" <healych@amazon.com>
Subject: correct source tree to make contributions to Linux thermal framework
Thread-Topic: correct source tree to make contributions to Linux thermal
 framework
Thread-Index: AQHX1yvWy3qyuzSbLUWobh1b1ZbZYg==
Date:   Thu, 11 Nov 2021 18:42:10 +0000
Message-ID: <1636656130551.5237@lab126.com>
References: <1636488946043.43408@lab126.com>,<YYvuAU+d3TAS6fI7@kroah.com>
In-Reply-To: <YYvuAU+d3TAS6fI7@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.157]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello folks,

At our company, we maintain an internal thermal framework patch. We are exploring the option to up-stream this patch so we don't have to keep porting this from one Kernel version to the other. Looking for advise on the right device tree to get started.
Thermal framework code resides here: https://elixir.bootlin.com/linux/latest/source/drivers/thermal. What is the correct source tree we should use from https://git.kernel.org/??

Thanks,
Anand

