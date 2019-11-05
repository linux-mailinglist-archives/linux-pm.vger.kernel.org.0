Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3DF0646
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 20:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfKETur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 14:50:47 -0500
Received: from cmta19.telus.net ([209.171.16.92]:41550 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfKETup (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 14:50:45 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id S4qeirvDnhFQMS4qgivPix; Tue, 05 Nov 2019 12:50:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1572983443; bh=4nipMFIVUYVa2Rzi5oeSsWOIRTV+jEBG1Ze4cDIV6sI=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Mwwp8juUdXFBV1pdJqVtRbv+deZQVi0NOIL1zHb6uSMzldSxv6UucTT4ISdY/jtLF
         JqseHJe/7jA6t78VjbG5Ish9wbZvz23lH4vXdh/siOtVdYLwQNC0X7/PVzNd3ZIOO9
         HRyqBtlsKMeInfoyXGvCMpNyQHFiQsefZ+Tk9muA2Y3Lh3VI0nfzeD6Eo5qhRtffuD
         89/gj3xEEKyKY1bE5FbQbTVLVYVLRwT4MJFTXBjU8bgdNOUSjSj2Yy/G0xe55Zj/UZ
         UsfYHtJQ3bIl+sDns7NLO6TpkuOmI6/Pjji9LSwHrGGgjcgngsvAjqctVDGQcl7pt5
         gdQigLDVznJEQ==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=ZPWpZkzb c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=aatUQebYAAAA:8 a=mjZFaR_t0tJU7jn7M2kA:9
 a=o2NKi5_p4FmsFgPr:21 a=ywaIEIEXYrz5VVYD:21 a=CjuIK1q_8ugA:10
 a=7715FyvI7WU-l6oqrZBK:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>
References: <60416800.X4hXmAfbqi@kreacher> <2237950.TTgtiEjdez@kreacher>
In-Reply-To: <2237950.TTgtiEjdez@kreacher>
Subject: RE: [PATCH 3/4] cpuidle: teo: Consider hits and misses metrics of disabled states
Date:   Tue, 5 Nov 2019 11:50:38 -0800
Message-ID: <001601d59412$4db298d0$e917ca70$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdV/ssHSvebJTpp6StGpb6BoKW0LdgUXb9jA
X-CMAE-Envelope: MS4wfMt7vg37gU8cWreyDec46ptMhXQlsOk6uYgSx+DXhGcbqI6cBROQWq/nrxOH1hg8jw6SN4mh3dI99sHbH2SO/p7tFV+ngi12MaGXwN0UDkBKgejfMYam
 PsnM2pop/MZup2Hk2d5Zfvy52FYC2GC5OFgJZQw6J0HBJOo6yuRCLw2Kf0rlcT8OIrqRqjjO7hC25xOAEz1mPBDigcS87kIoYipEadXYJpdkMcWoTfe6kjlu
 LfzkZkdBsptBgt8hQieuwnrO6Sy1kB5cxr9UnAnNNtpRyEcITpL/3wt79qUKIZf/dckrZHCaerK58Te/A71MMCvHlmlVeRviQ5JMVggbHqTt5jwzhQCCCPK0
 o+p2FRQj
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2019.10.10 14:36 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The TEO governor uses idle duration "bins" defined in accordance with
> the CPU idle states table provided by the driver, so that each "bin"
> covers the idle duration range between the target residency of the
> idle state corresponding to it and the target residency of the closest
> deeper idle state.  The governor collects statistics for each bin
> regardless of whether or not the idle state corresponding to it is
> currently enabled.
>
> In particular, the "hits" and "misses" metrics measure the likelihood
> of a situation in which both the time till the next timer (sleep
> length) and the idle duration measured after wakeup fall into the
> given bin.  Namely, if the "hits" value is greater than the "misses"
> one, that situation is more likely than the one in which the sleep
> length falls into the given bin, but the idle duration measured after
> wakeup falls into a bin corresponding to one of the shallower idle
> states.
>
> If the idle state corresponding to the given bin is disabled, it
> cannot be selected and if it turns out to be the one that should be
> selected, a shallower idle state needs to be used instead of it.
> Nevertheless, the metrics collected for the bin corresponding to it
> are still valid and need to be taken into account as though that
> state had not been disabled.
>
> For this reason, make teo_select() always use the "hits" and "misses"
> values of the idle duration range that the sleep length falls into
> even if the specific idle state corresponding to it is disabled and
> if the "hits" values is greater than the "misses" one, select the
> closest enabled shallower idle state in that case.
> 
> Fixes: b26bf6ab716f ("cpuidle: New timer events oriented governor for tickless systems")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Great thanks.

Acked-by: Doug Smythies <dsmythies@telus.net>


