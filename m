Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72A023D69C
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 07:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgHFFzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 01:55:09 -0400
Received: from cmta18.telus.net ([209.171.16.91]:47626 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgHFFzI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Aug 2020 01:55:08 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 3YrokNSMVqUs33YrpkBwBc; Wed, 05 Aug 2020 23:55:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596693307; bh=UdY9SBhzelhDfX04xJQMe/tnrZmIn+bwMhQh/d7gS14=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=M+qtjXCmrA7/G/ymG1TyeaJgy2oPWxHrtGABymuDkulMYUHYEQMRm72rghu6tr00J
         GeNOqke41SHjOELaOF4GAV8QVwnu26wbWCIEjehINnlesMVoIbp6LJAw4emlBHT33n
         uu8ivc0EN0J394QKemMHBPvSsKKrI+FrIYMrNU6sgX0/Hry66VunxBfUx4gRDzsTbH
         SJ4jQYm0RY0Q8rj01jjLgvXG74nzreIBfi8bGqNaXN0xXXXYsJ2GYvEBmUwTSI5Ohi
         EshHRPxqMW/k8xnjkABIyxUGj+JcODXWPDhH81fT/JCWtBauriO2h6/s9Y0mxNKndW
         52EjvC48f+CmA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Mo8sFFSe c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=BksG-UogcMQq9l1sBr8A:9
 a=WNjDzcG3-xvNU-Du:21 a=sI7P83wg1hG2aD_E:21 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <3226770.pJcYkdRNc2@kreacher>
In-Reply-To: <3226770.pJcYkdRNc2@kreacher>
Subject: RE: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Wed, 5 Aug 2020 22:55:03 -0700
Message-ID: <004701d66bb6$22a11410$67e33c30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZrSU4IfOy1pyhARg2cUO2gNUQGyAAbEZuQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfE4hLMxmYldtWQ0VrnqMmaky8OnCKk9AJ11DLo7lGr1p7mIp04Qio1Ieh3xJEu5B/w5yZyrcESGncqPlckt23ApEzliATAfPpUCKfWKbTU29WS9eMOOG
 Ifmh10zUQD19Lbp5dS3q6xnLUftetkQjOZqJ5MzhHqydyJovoM0OT1nDsY7KJspil15dMl0Gn5rC4E+1NVmkNi7bp00PgUwUYVgeyPRVV4shsoJHO9a9Adhx
 7jbAE0Kmpcnf5bGmwR5t9OnJp5E0AowyzTh0zvUC0DVdze5FoBPC/qWx+lYEfzFTmQ8g1Ocq9VmjFhD4iNCRYM5D96/ruSpprz0XE1QlkucD3PIf2OLpQO/8
 yVgv40IlP6llcuRGUkbUbaNf+g6LoXe66FRT5BNjoacWEBPmoZ5ETIt+AGbca657bVigugIyMtXVcI/RKoJuoN3iDH7HEI6/XtBJpEg5ugbz4fjGqLU=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.05 09:56 Rafael J. Wysocki wrote:

> v6 -> v7:
>    * Cosmetic changes in store_energy_performance_prefernce() to reduce the
>      LoC number and make it a bit easier to read.  No intentional functional
>      impact.

??
V7 is identical to V6.

Diff:

$ diff hwppassive-v6-2-2.patch hwppassive-v7-2-2.patch
2c2
< Sent: August 4, 2020 8:11 AM
---
> Sent: August 5, 2020 9:56 AM
5c5
< Subject: [PATCH v6] cpufreq: intel_pstate: Implement passive mode with HWP enabled
---
> Subject: [PATCH v7] cpufreq: intel_pstate: Implement passive mode with HWP enabled
76a77,81
>
> v6 -> v7:
>    * Cosmetic changes in store_energy_performance_prefernce() to reduce the
>      LoC number and make it a bit easier to read.  No intentional functional
>      impact.

... Doug


