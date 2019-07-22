Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED27087E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbfGVSZ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 14:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731678AbfGVSYy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E6F2190D;
        Mon, 22 Jul 2019 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563819893;
        bh=d/tEmvkiAsbuh59I3c0+nGapaMRLa5TzYZx3yFSOv0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICGvJ3MCKpv8zqtrQLwbkGxPs1lLpIZLGhiMbXmqS2fqB5I4W9qT29c14PcuZ1yF3
         WjE3d7qNe3ayUOFrb5cMiv53eX3SV9M9t2cMUuaxiAv0yC2vduBseTlt6c9sIUQE+O
         AUS82cAcPu7wEje0vyiq+jsSK1iPmZkRYMbJnUqA=
Date:   Mon, 22 Jul 2019 20:24:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: Re: [PATCH] power: sysfs: Remove wakeup_abort_count attribute.
Message-ID: <20190722182451.GB24412@kroah.com>
References: <20190722170407.217178-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722170407.217178-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 10:04:07AM -0700, Ravi Chandra Sadineni wrote:
> wakeup_abort_count and wakeup_count sysfs entries print the
> same (wakeup_count) attribute. This patch removes the duplicate
> wakeup_abort_count sysfs entry.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-devices-power | 25 ++++++-------------
>  drivers/base/power/sysfs.c                    | 19 --------------
>  2 files changed, 7 insertions(+), 37 deletions(-)

Isn't this the attribute you add back in a later patch?

If you have 2 patches that touch the same file, always make a patch
series so we have a chance to guess as to what patch comes first.

thanks,

greg k-h
