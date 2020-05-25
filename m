Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6E1E1581
	for <lists+linux-pm@lfdr.de>; Mon, 25 May 2020 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgEYVJ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 May 2020 17:09:58 -0400
Received: from cmta20.telus.net ([209.171.16.93]:35762 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbgEYVJ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 May 2020 17:09:57 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id dKM5jEHnSdVYHdKM6jX09H; Mon, 25 May 2020 15:09:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590440996; bh=E6euisO0yE/Fs40IpuKFjZmhJuLZeL7J5pqllyIRrzQ=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=izo/GrihCTAyL7wxdUDzqoApjM9nfnrX1rqAD0v1gB0en1/Pr5qDq1xEbOCOPDDGN
         AExW7WcecmKO7ZG5yxbizxul6EG8JWPaAdlpBJ0ElaKMjZB+N+LoNj2QCyD3VwUfkw
         U06nBuRJWL5C2x4FdSYfUtkhA7FMO6246eMheVIaVVuiSCcwGsXYyRZ603rp8uCRYS
         ZyvNOOYZKVRMBV7XK4J7SDPWR3xwNoLSZi3OJOjuWrFplOy/8hfS07BbPlgWfbYx1g
         hGS7X7Tz2E2xuCX+ResHyWUQ1YF/TELTR4XgRKrUMHsrKZ0DEkc9VUzftLRojxV5B/
         L+7CKFyh8mD1w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Y5CGTSWN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=kAzHQTmmk_fIg6_RNCcA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>
References: <3169564.ZRsPWhXyMD@kreacher> <000801d632a9$6a586c90$3f0945b0$@net>
In-Reply-To: <000801d632a9$6a586c90$3f0945b0$@net>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Work in passive mode with HWP enabled
Date:   Mon, 25 May 2020 14:09:51 -0700
Message-ID: <001101d632d8$d6a01b30$83e05190$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYvk3X5bnwqpX6hRwi7ciAthJfS0ADBo0fwAA9F6bA=
X-CMAE-Envelope: MS4wfEucPqWNd1dMiC4Rfsb/loWX2wDsbH1jnGYnBd7z7rfnF8IkJe3mMjEq5QtGIPjwHJRbfkWeFH+/BcHigRmBrxdi+yNem7AUGSdwWrrPGGpIgLhDVjiW
 YOsCK6MayGljnaVmYc1R+ywIhRiOYL6SWnRAW8eAB4M2Z9Mj5iJFEjy6t7ms8ry80GVxQhGs37dwz9wQcbHQpTYVR1fEsJI3O9jgwJzJ82gK8K6xZynz4ktj
 M73J3gxWkBagvLkVcIxk2UczBbScFwIcQF5WblPyjCZEnTP1aEhetJZ/7Ct9mF4PEacLf/2POEti+hSabik5Vo+GH5+FNIlzJFvYk0s/YpGQ0cYIM5o1/vKO
 2WX5ZSiynZSeKLPRdgF0KM9VcoSy2OOosmUeuCxmqH6UgLTYBOmeSkIJX7DsekxUBsPEFbDl
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The INTEL_CPUFREQ_TRANSITION_DELAY_HWP = 20000
test results from this e-mail were incorrect.
The test and graphs are being re-done.

On 2020.05.25 08:30 Doug smythies wrote:

> 
> Legend - intel_pstate - powersave graph [2].
> 
> What? Why is there such a graph, unrelated to this patch?
> Well, because there is a not yet understood effect.
> 
> p_powe_stock : intel_pstate, powersave, stock kernel (5.7-rc6), hwp disabled.
> P_powe_hwp : intel_pstate, powersave, patched kernel (5.7-rc6), DELAY_HWP 5000.
> P_powe_hwp2 : intel_pstate, powersave, patched kernel (5.7-rc6), DELAY_HWP 20000.
> 
> Conclusion: ??
> 
> Note: That I merely made a stupid mistake is a real possibility.

Yes, that was it. However all DELAY_HWP 20000 tests were bad,
Not just this one.

... Doug


