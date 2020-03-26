Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E958193E9D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Mar 2020 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgCZMG4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Mar 2020 08:06:56 -0400
Received: from ozlabs.org ([203.11.71.1]:37819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgCZMG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Mar 2020 08:06:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48p3ct2my5z9sSs; Thu, 26 Mar 2020 23:06:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d95fe371ecd28901f11256c610b988ed44e36ee2
In-Reply-To: <20200316135743.57735-1-psampat@linux.ibm.com>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com, ego@linux.vnet.ibm.com, dja@axtens.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in powernv_cpufreq_work_fn
Message-Id: <48p3ct2my5z9sSs@ozlabs.org>
Date:   Thu, 26 Mar 2020 23:06:52 +1100 (AEDT)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-03-16 at 13:57:43 UTC, Pratik Rajesh Sampat wrote:
> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> size overflow in 'powernv_cpufreq_work_fn'
> 
> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d95fe371ecd28901f11256c610b988ed44e36ee2

cheers
