Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71C91E9936
	for <lists+linux-pm@lfdr.de>; Sun, 31 May 2020 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgEaRPl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 May 2020 13:15:41 -0400
Received: from cmta20.telus.net ([209.171.16.93]:49005 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgEaRPl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 31 May 2020 13:15:41 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id fRYejxD9XdVYHfRYfj1Igl; Sun, 31 May 2020 11:15:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1590945339; bh=gHPwn1OcTHhdSrhZ8BI6iI7LtlE4NtMCBN9Y+hq/vjM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=me8aiIgqeRWLYY+KzeLiUlb0YoOBssaK6+6lhiIBhbaFrACDBoEYkUR3X/GSFRwku
         oBHzjOfXJo3nL2GLgyBXsP0cybfcDb51K06HVTc6IkgJLNZzky6fBxvwXrwZTLxBQP
         liv6/f4zafRallyaFwC41G8U1qbODORAITRpnjPDURvMZ8zyZogi//kRlxJKbFfV/5
         dQorQPqZFYHTr4MvHlVDidbJGTi9eXzDX4W6AV1w7FI8t3/dsdTQSSaOlrV7X2H+b/
         Rd40udxAfNxNCLGrSB6dICjYh2gUfYRbjHZlbo0wBKYVklOLDUA7kUUQLBTqUOAvS3
         FZX4rWTp0DDRQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Y5CGTSWN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=5-8LpdpG0Cjq0NOrwpYA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2931539.RsFqoHxarq@kreacher> <000001d6376a$03bbaae0$0b3300a0$@net>
In-Reply-To: <000001d6376a$03bbaae0$0b3300a0$@net>
Subject: RE: [RFC/RFT][PATCH] cpufreq: intel_pstate: Accept passive mode with HWP enabled
Date:   Sun, 31 May 2020 10:15:35 -0700
Message-ID: <000101d6376f$1adf07d0$509d1770$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdYzimEBSb+8wZd2QXK6gu6IWqSeRQBbEZjAAJ31enA=
X-CMAE-Envelope: MS4wfGDpAzahBSWX9L6tPkm7yFmTZTk5WHG8lM1AaKURu8V3/yaIPhk2X8JYHTZRtLdv/Zu5uU56T4IxqWlNlU7r6t/+Ov5FoE7VPFszTqwYSEfqwmUyfVsj
 qZowr8JKM1KA+lJprPy7iZWz94e5Ef2vwlkPWMYuQGwYwG2W1JQIjz6cw/k8eOVTAXt2rL4dvqWtfJXzroJYny4hHmF/NxEJMFjctZnhy4fzFgWpT/DbwX+9
 IHVYJT51adRBR7YjBy5twXOCtKltNzdR20/UPKramEW/jkZSGi6cekgLrSofObHj0gTL/DHQiT/8csCwBKs2MKhUS2bDFVImXDHelvhPIRo/Dpy6KP3unmvb
 mjPvNu2rk/V+35E3Z3pOPaXy0p4wdXCaPs9sdCp6SS/pKNMNEswuqivEsliH9mGM1cLwcpgo
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Correction:

On 2020.05.31 09:39 Doug smythies wrote:

> The overruns and use of idle state 0 are exactly correlated.

Should have been "idle state 2":

The overruns and use of idle state 2 are exactly correlated.


