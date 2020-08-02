Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE5123574D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Aug 2020 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgHBOA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Aug 2020 10:00:28 -0400
Received: from cmta17.telus.net ([209.171.16.90]:53182 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgHBOA2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 2 Aug 2020 10:00:28 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 2EXHkM4i8Ygvr2EXIkBLUO; Sun, 02 Aug 2020 08:00:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596376826; bh=SzDoSBafKB3dI1ZEPVpUunrs6xSnoYFOgu5PBlceFsE=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=k2AcceSDKEJecK3UJv7fhRcgVN+TnL/0ouYqEOi5e3xZDRtxx1ZMyxxZR0kK4rpzG
         c60RUAi46Fe+YwK+mRS7QotUCm+ZcOasSqQ4tbJ1emhRQ4U/cOIxuddw/9zj5Mm7QU
         hqJCnwpRvG/Sh/sdHvk/fh2nFMMAmSAbEz8+tEbkZsJGw9awWP56KYTsKA5v6wzl/1
         MLMN4EwYCpigA2aoaWYEOWu3jcKv9s2QRqDZCA34ezE/GDeQhwMyA6l3IpSzgPqlhr
         bsYZoxRxvEVsfxorcHstn28Jbnnc4ryEEbZLLM4ZglzLkjexR78egSe/94P4Okz11N
         A7Iz86HrZ+sAw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=MIQeZ/Rl c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=ZIabrx5NIckfTXfnIBUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher>  <13207937.r2GEYrEf4f@kreacher> <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
In-Reply-To: <6febe0592d1830dac04aab281f66b47498dda887.camel@linux.intel.com>
Subject: RE: [PATCH v4 0/2] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Sun, 2 Aug 2020 07:00:22 -0700
Message-ID: <000301d668d5$45c10a10$d1431e30$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZoIlWzA7o73WknRLGs71sfWuU6HAAsJj+Q
Content-Language: en-ca
X-CMAE-Envelope: MS4wfDgAdYFHDxR5qZ0kyPgr3n9h2BxbW6s44BQp71VL3BZml3hb67guShWx5fqnpSkKJZhkA1SrDe57T5SH3KrrzKh4qPlJwbxCV+MZEMy0KWls7qjRulwB
 sqKfQ7882w3ie5AxWh5IUgwws2F3eBuF9WIrgcyi6YXPUN2dvzrrO1fBpMb4oESwBrrYjmNDcQhfZL2nkRUoEVH/6sp7SoSeSTI4egS9t3eV2xe/vS54c7OG
 FQ8Js7N7PpHFg1ipeBR2JWVcq16MuIHTHGEG19sU9Kli0jQG3koA0pn4RR3u+0nr08sKY48TOSAYS0LdimPFGlz1Ui1v2BdOc1MLPQbQFRXjNDy8Z9m0RJMZ
 qrnwgCZGJ++cYo2s6RbPiXtQA/oGNetymxP/bTx3CEakeI1HOUIMCY7iUwnnz83ht7cku2/pmbIu4yQ+EBNTP195TVqZWQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.01 09:40 Srinivas Pandruvada wrote:
>> On Monday, July 27, 2020 5:13:40 PM CEST Rafael J. Wysocki wrote:
>>> On Thursday, July 16, 2020 7:37:04 PM CEST Rafael J. Wysocki wrote:
>>>> This really is a v2 of this patch:
>>>>
>>>> https://patchwork.kernel.org/patch/11663271/
>>>>
>>>> with an extra preceding cleanup patch to avoid making unrelated
>>>> changes in the
>>>> [2/2].
>>>
> I applied this series along with
> [PATCH] cpufreq: intel_pstate: Fix EPP setting via sysfs in active mode
> on 5.8 latest master (On top of raw epp patchset).

Hi Srinivas,

Would you be kind enough to provide a "git log --oneline" output
of what you did.

I have been trying unsuccessfully to apply the patches,
so somewhere I obviously missed something.

> When intel_pstate=passive from kernel command line then it is fine, no
> crash. But switch dynamically, crashed:

I'll try to repeat, if I can get an actual kernel.

> Attached crash.txt. I may need to try your linux-pm tree.

I also tried the linux-pm tree, same.

... Doug


