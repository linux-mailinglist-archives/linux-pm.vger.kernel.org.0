Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7993C351D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGJPWW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 11:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhGJPWU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 11:22:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D66DC61357;
        Sat, 10 Jul 2021 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625930375;
        bh=wmv3i0bl05QfU7AkJuYqTwOAkbHj2WKCpijd4L8v89o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpG4z3cw9rrZJclLN3ssfKpvpPk1dox9uREMy0NmNPE8+zRurQIXLW1cy6IW9FmOU
         unSLInVbK+LyclIki/b+qOa+7Ec0xhLau1oeLFUOYe4pKXDk52tg02nuoPNv4sS74H
         LvVv+rf6a1gm17ZrEHvaj0wxz5hizFecXclCU9BA=
Date:   Sat, 10 Jul 2021 17:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] driver core: Prevent warning when removing a
 device link from unregistered consumer
Message-ID: <YOm6hWQ+RL7ILm3p@kroah.com>
References: <20210710103819.12532-1-adrian.hunter@intel.com>
 <20210710103819.12532-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710103819.12532-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 10, 2021 at 01:38:17PM +0300, Adrian Hunter wrote:
> sysfs_remove_link() causes a warning if the parent directory does not
> exist. That can happen if the device link consumer has not been registered.
> So do not attempt sysfs_remove_link() in that case.
> 
> Fixes: 287905e68dd29 ("driver core: Expose device link details in sysfs")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/base/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

No Cc: stable for this?  Why not?
