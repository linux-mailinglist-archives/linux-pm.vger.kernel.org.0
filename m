Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C673C21F4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 11:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGIJ6D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 05:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232025AbhGIJ6D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jul 2021 05:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 524A8613CC;
        Fri,  9 Jul 2021 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625824519;
        bh=oxOI6439h5cX+VwikcChYO14Sr2hkUv1GrdsE5IiV8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCAoceGLyWaBy7pvfVJtnM5iqmOo8ag3m1wBI+6SANIZy/PJF0X896UDWX8O5J4iK
         QirtSzkEGI0gtANu2DpdvtoNm2f/N1vME+SXL66nf4RQEeDZ6dM9xEy1FVrB08u54/
         qX2VZDo09MFIOfUgvTtx4ckS1EaZYYeQRRJAogSU=
Date:   Fri, 9 Jul 2021 11:55:16 +0200
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
Subject: Re: [PATCH V2 1/2] driver core: Add ability to delete device links
 of unregistered devices
Message-ID: <YOgdBGBEYNndLLwa@kroah.com>
References: <20210709064341.6206-1-adrian.hunter@intel.com>
 <20210709064341.6206-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709064341.6206-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 09, 2021 at 09:43:40AM +0300, Adrian Hunter wrote:
> Managed device links are deleted by device_del(). However it is possible to
> add a device link to a consumer before device_add(), and then discover an
> error prevents the device from being used. In that case normally references
> to the device would be dropped and the device would be deleted. However the
> device link holds a reference to the device, so the device link and device
> remain indefinitely.

Why are you not just manually removing the link you just created?  You
manually added it, you know something failed so you need to clean up, so
why not clean this up too?

thanks,

greg k-h
