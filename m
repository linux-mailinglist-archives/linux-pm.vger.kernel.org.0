Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9151AB675
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 06:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgDPEDl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 00:03:41 -0400
Received: from cmta19.telus.net ([209.171.16.92]:36657 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgDPEDk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Apr 2020 00:03:40 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id OvkUjbfUfFblkOvkWj2yjM; Wed, 15 Apr 2020 22:03:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1587009817; bh=Zn1xtELv6JCY8tNYhmpOgWYNjoqTG3j5w3+geDPacPc=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=gEkXV0oHPIHN9wUtxHnAZFKw5C+A4TiIMnFMCv0gmuy3crm+tB9x5JhCCnNuaGjYO
         635oFhrfzyr90AMDrpsOWBFPSr7V1LVbclQFNRZN+LB0DOQY+ld22MQ+s9UYPzwgdi
         ehP4B68C3nveG8AbojtKRmJb1dKocmRvHHda8pCUxPitw+3GdKLCALI3ovKeX9NrEQ
         xOukJhylGcjjwepwzrlFoFRogWakDAQnhnuAorlmpRceSrUB8A9cVXnAfEXDbjkEUl
         lxPXEnzOqGzLLMqPxWNC/dETuM/vDhxgolwqTDm3fyFPE6NEHMhXk5BoALci2QCkAk
         UwRBd6mDBeRJQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=BNTNU2YG c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=80HlKv23USs_H_yaKB0A:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Chen Yu'" <yu.c.chen@intel.com>
Cc:     "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <cover.1586782089.git.yu.c.chen@intel.com> <db96fd31afd0ff65e4041665293b96c984e675bc.1586782089.git.yu.c.chen@intel.com>
In-Reply-To: <db96fd31afd0ff65e4041665293b96c984e675bc.1586782089.git.yu.c.chen@intel.com>
Subject: RE: [PATCH 2/3][v2] tools/power turbostat: Introduce functions to accumulate RAPL consumption
Date:   Wed, 15 Apr 2020 21:03:34 -0700
Message-ID: <001901d613a4$010e0a70$032a1f50$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYSXDnMXkJ5RB5zStyDB6tksB289gBRJlyA
X-CMAE-Envelope: MS4wfBOnqG2ci47ZFLMGWqetE1328PnfGu28WGOKFsABayPB9upiYSGVZXppBbxXWifzyY+GYDvLMBtjnkN8OX/QvkqW+klj583SvoDZNlFanQxvpH6o9pU6
 0vtzr/HnF2Mc/L5+m1g/8PjJWTsYCxu/+YDOqVXJGCpDdm751DS5xLnVQDcJ3UXtCtAWXcXWEFcfjFQYACxEvT9czTHQcili5C6oU3iJVd4H9ojJLwiqHV+6
 LNm+PLEpByx0jDjcOMzt5Tc9/8pWqnaS4WEzdT0hx9I4XQRM0jTTNPVvdnEpIhT/
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.04.15 05:57 Chen Yu wrote:

...

> v2: According to Len's suggestion:
>    1. Enable the accumulated RAPL mechanism by default.

I am not a fan of this, but O.K.

>    2. Re-use the rapl_joule_counter_range to represent the
>       the timeout of periodical timer.

No, please no. It is too easy to still have an overflow.

...
> +	/*
> +	 * A wraparound time is calculated early.
> +	 */
> +	its.it_interval.tv_sec = rapl_joule_counter_range;

Would this be o.K.?

+	its.it_interval.tv_sec = rapl_joule_counter_range / 2;

> +	its.it_interval.tv_nsec = 0;

The way it was sent, this patch set does not work.
It still overflows.

Example, sample time calculated to ensure overflow:

Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
100.00  3500    3592125 80      9.72    0.12
100.00  3500    3587391 79      9.77    0.12

Actual package watts was around 65.

However, if this additional patch is applied (I only fixed one of them):

doug@s18:~/temp-k-git/linux/tools/power/x86/turbostat$ git diff
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 29fc4069f467..4d72d9be5209 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1350,7 +1350,8 @@ delta_package(struct pkg_data *new, struct pkg_data *old)

        old->gfx_mhz = new->gfx_mhz;

-       DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
+/*     DELTA_WRAP32(new->energy_pkg, old->energy_pkg);  */
+       old->energy_pkg = new->energy_pkg - old->energy_pkg;
        DELTA_WRAP32(new->energy_cores, old->energy_cores);
        DELTA_WRAP32(new->energy_gfx, old->energy_gfx);
        DELTA_WRAP32(new->energy_dram, old->energy_dram);

Then it seems to work.

Example:

doug@s15:~/temp-turbostat$ sudo ./turbostat --Summary --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 1200
...
RAPL: 690 sec. Joule Counter Range, at 95 Watts
...
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
100.00  3500    3592328 80      64.32   0.12
100.00  3500    3595195 79      64.37   0.12

... Doug


