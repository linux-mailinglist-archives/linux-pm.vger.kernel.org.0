Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E34376273
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhEGJAP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 05:00:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235546AbhEGJAP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 May 2021 05:00:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B198D106F;
        Fri,  7 May 2021 01:59:15 -0700 (PDT)
Received: from bogus (unknown [10.57.33.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359DD3F718;
        Fri,  7 May 2021 01:59:14 -0700 (PDT)
Date:   Fri, 7 May 2021 09:59:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     cristian.marussi@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nicola.mazzucato@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scmi: Fix an error message
Message-ID: <20210507085911.yqdwutmn5rev7xdv@bogus>
References: <b0c09698216af60d97bfd30b55bad89dc0f70112.1620328067.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c09698216af60d97bfd30b55bad89dc0f70112.1620328067.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 06, 2021 at 09:09:48PM +0200, Christophe JAILLET wrote:
> 'ret' is known to be 0 here.
> The last error code is stored in 'nr_opp', so use it in the error message.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
