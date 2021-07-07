Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C193BED38
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhGGRm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhGGRm1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:42:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6062F61CC8;
        Wed,  7 Jul 2021 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625679586;
        bh=NslRH76i/hbV/A9scmjZZDgGzjzRzgIKHorn/EcZ2wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTDiEetQ92pV4HvL4v6T919GwtYVYqB887BNwSro7Y8TKe49tD5GFgh/rsCJ+ruOJ
         juCQBEOVSbz0hasdjlLA6yfaBhps/+T333BAr3ACVUBwLZdfyybZJuHv1ckK2pnu0+
         sLQgKH4BQyFlwzAOGp1v9te+zSbTHiu+HrcvCarE=
Date:   Wed, 7 Jul 2021 19:39:44 +0200
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
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
Message-ID: <YOXm4FuL/CW4lYDZ@kroah.com>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707172948.1025-3-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> been registered but can still have a device link holding a reference to the
> device. The unwanted device link will prevent runtime suspend indefinitely,
> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> the UFS host controller). Fix by explicitly deleting the device link when
> SCSI destroys the SCSI device.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 708b3b62fc4d..483aa74fe2c8 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
>  		spin_lock_irqsave(hba->host->host_lock, flags);
>  		hba->sdev_ufs_device = NULL;
>  		spin_unlock_irqrestore(hba->host->host_lock, flags);
> +	} else {
> +		/*
> +		 * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> +		 * will not have been registered but can still have a device
> +		 * link holding a reference to the device.
> +		 */
> +		device_links_scrap(&sdev->sdev_gendev);

What created that link?  And why did it do that before probe happened
successfully?

thanks,

greg k-h
