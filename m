Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9A15B082
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 20:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBLTNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 14:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBLTNf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 14:13:35 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7BCB2082F;
        Wed, 12 Feb 2020 19:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581534814;
        bh=1a9kGc2FHXHoP81cfgRKZPjCFj1Bh30cASvmFV8sBIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7TSwmeiJbixkv33KF/GJF/BoNHaJT+UaPopod9xL+DiFBFEYe6JJOjsyCMXgSTMX
         fltmZLPZ/66dPiU4SDru61fge96aNLc/6sn1v5kc0oYkMGKM8yIBzk1qWNZutWB1RJ
         x6o76PLkYCJc3JSzzEDOzZacnMh6N1tbBv3+czfI=
Date:   Wed, 12 Feb 2020 11:13:34 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 10/28] PM: QoS: Rename things related to the CPU latency
 QoS
Message-ID: <20200212191334.GA1987092@kroah.com>
References: <1654227.8mz0SueHsU@kreacher>
 <3305010.P0mNzRSuHC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3305010.P0mNzRSuHC@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 12, 2020 at 12:04:31AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> First, rename PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE to
> PM_QOS_CPU_LATENCY_DEFAULT_VALUE and update all of the code
> referring to it accordingly.
> 
> Next, rename cpu_dma_constraints to cpu_latency_constraints, move
> the definition of it closer to the functions referring to it and
> update all of them accordingly.  [While at it, add a comment to mark
> the start of the code related to the CPU latency QoS.]
> 
> Finally, rename the pm_qos_power_*() family of functions and
> pm_qos_power_fops to cpu_latency_qos_*() and cpu_latency_qos_fops,
> respectively, and update the definition of cpu_latency_qos_miscdev.
> [While at it, update the miscdev interface code start comment.]
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c |  6 ++--
>  drivers/tty/serial/omap-serial.c    |  6 ++--
>  include/linux/pm_qos.h              |  2 +-
>  kernel/power/qos.c                  | 56 +++++++++++++++++++------------------
>  4 files changed, 36 insertions(+), 34 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
