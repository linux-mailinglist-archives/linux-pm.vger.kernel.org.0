Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EE1479C2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgAXIyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 03:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgAXIyr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jan 2020 03:54:47 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D7020709;
        Fri, 24 Jan 2020 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579856086;
        bh=0xY6x9V00TP+QraY/L7nzfuOqHEO6nvqTQwrER0e3Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuIt2JgMidLItMGSneEjOjLaEAmYbQDtNOSJ77X4jm6dMcS6nNqRhW2jKfOejaUnq
         XEbKamI2R/rlHE3qvk8NnzcMCKYRCvWaztzt5ZFioGwAHCBMjhHLQ7pC/0uP117+i6
         jBZ+Ka6opDx+8LncDFqJh2y964etJCfDYctenPpI=
Date:   Fri, 24 Jan 2020 09:54:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Daewoong Kim <daewoong00.kim@lge.com>,
        Seokjoo Lee <seokjoo.lee@lge.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: core: Fix handling of devices deleted during
 system-wide resume
Message-ID: <20200124085443.GA2936887@kroah.com>
References: <2601275.1tEomSadG4@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2601275.1tEomSadG4@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 23, 2020 at 12:11:24AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a device is deleted by one of its system-wide resume callbacks
> (for example, because it does not appear to be present or accessible
> any more) along with its children, the resume of the children may
> continue leading to use-after-free errors and other issues
> (potentially).
> 
> Namely, if the device's children are resumed asynchronously, their
> resume may have been scheduled already before the device's callback
> runs and so the device may be deleted while dpm_wait_for_superior()
> is being executed for them.  The memory taken up by the parent device
> object may be freed then while dpm_wait() is waiting for the parent's
> resume callback to complete, which leads to a use-after-free.
> Moreover, the resume of the children is really not expected to
> continue after they have been unregistered, so it must be terminated
> right away in that case.
> 
> To address this problem, modify dpm_wait_for_superior() to check
> if the target device is still there in the system-wide PM list of
> devices and if so, to increment its parent's reference counter, both
> under dpm_list_mtx which prevents device_del() running for the child
> from dropping the parent's reference counter prematurely.
> 
> If the device is not present in the system-wide PM list of devices
> any more, the resume of it cannot continue, so check that again after
> dpm_wait() returns, which means that the parent's callback has been
> completed, and pass the result of that check to the caller of
> dpm_wait_for_superior() to allow it to abort the device's resume
> if it is not there any more.
> 
> Link: https://lore.kernel.org/linux-pm/1579568452-27253-1-git-send-email-chanho.min@lge.com
> Reported-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/main.c |   42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
