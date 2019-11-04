Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7FEDE08
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKDLwH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 06:52:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDLwH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Nov 2019 06:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z45EwIm/nVJd7d8qmHSBF95/M8CehBnDBQi1wTICEOU=; b=YjUYLUPTB/RXa6Ktkoz1wCjTz
        4MwPhuteCIwgB1TZ1JwEvX+IhXAVoZOOKoeDptaDYKIShVe3JtHyY9YqCAHH4MobpRws9984uz2HU
        fPYfKCYTgBC2e3J+JYA0hVDhGrTeaQQDCJu2vaGesZmbUynrnhEV6dpeanDQnGpZTERFZSE/o3k5+
        i3Xw3FU7OLMpZMBewKCYOWRs7sAGVEQMTPs0DomKXKGT8GoOSj+oiwjFfIoFRDabIzMHLMSDrvogH
        iquYwc7lBREVKR1QYHI0yG5nY5ms2KRZq0WiQvynjqPxu/FYvWX8c25lxNyOESynm3P8KVPY+h2u4
        YABuW4BZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRatv-0006On-RA; Mon, 04 Nov 2019 11:52:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F052305FC2;
        Mon,  4 Nov 2019 12:50:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51D022B4220F7; Mon,  4 Nov 2019 12:52:01 +0100 (CET)
Date:   Mon, 4 Nov 2019 12:52:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpuidle: Consolidate disabled state checks
Message-ID: <20191104115201.GG4131@hirez.programming.kicks-ass.net>
References: <2717750.dCEzHT3DVQ@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2717750.dCEzHT3DVQ@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 04, 2019 at 12:16:17PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two reasons why CPU idle states may be disabled: either
> because the driver has disabled them or because they have been
> disabled by user space via sysfs.
> 
> In the former case, the state's "disabled" flag is set once during
> the initialization of the driver and it is never cleared later (it
> is read-only effectively).  In the latter case, the "disable" field
> of the given state's cpuidle_state_usage struct is set and it may be
> changed via sysfs.  Thus checking whether or not an idle state has
> been disabled involves reading these two flags every time.
> 
> In order to avoid the additional check of the state's "disabled" flag
> (which is effectively read-only anyway), use the value of it at the
> init time to set a (new) flag in the "disable" field of that state's
> cpuidle_state_usage structure and use the sysfs interface to
> manipulate another (new) flag in it.  This way the state is disabled
> whenever the "disable" field of its cpuidle_state_usage structure is
> nonzero, whatever the reason, and it is the only place to look into
> to check whether or not the state has been disabled.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Much thanks, that always bugged me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
