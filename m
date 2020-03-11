Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8818184E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgCKMmb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 08:42:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbgCKMmb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 08:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fxPDu0DtPhrHBO4sjTCx5egaowwjZD7MLKCyF4O/ftg=; b=XXJIaa9f6NAmA/jrdcvqBwQoRg
        2xfWm6DxdqpzOk71I975lJY0lwrkyVt1zZcMG+wi8d+ZgQr0Id8NnhRxzgdG3h8zou1cWBT+U+rOw
        kcXylEsvuEBVO7GdpyfAFg4/3v1oENoqEMLSsB5zOEWnWn8I4AKOo4YLjEq5JCk68Yld54xuXHn1Y
        WSG/TYoSPAnP7aayqffyFD3J4/hBw2ncQhmQZVT8edTrz9X8VO26HPyDMV2ZzgZtEtFPAzUgLxTzb
        uHMQHj36RoF9lSdmUkn8WPWC4cev+uPy5vLZ3V/o+z0TnK7XI9YM2a8KnjTmFGBxTF/2gqgGJlEkK
        lVikpg1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jC0gq-0006Kh-03; Wed, 11 Mar 2020 12:42:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ACCA3006E0;
        Wed, 11 Mar 2020 13:42:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFA6D20225665; Wed, 11 Mar 2020 13:42:21 +0100 (CET)
Date:   Wed, 11 Mar 2020 13:42:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 01/10] PM: QoS: Add CPU_RESPONSE_FREQUENCY global PM QoS
 limit.
Message-ID: <20200311124221.GO12561@hirez.programming.kicks-ass.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
 <20200310214203.26459-2-currojerez@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310214203.26459-2-currojerez@riseup.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 10, 2020 at 02:41:54PM -0700, Francisco Jerez wrote:
> +static void cpu_response_frequency_qos_apply(struct pm_qos_request *req,
> +					     enum pm_qos_req_action action,
> +					     s32 value)
> +{
> +	int ret = pm_qos_update_target(req->qos, &req->node, action, value);
> +
> +	if (ret > 0)
> +		wake_up_all_idle_cpus();
> +}

That's a pretty horrific thing to do; how often do we expect to call
this?
