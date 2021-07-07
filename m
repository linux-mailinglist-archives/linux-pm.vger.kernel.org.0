Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F13BED34
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGGRlI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhGGRlH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146CD61CC8;
        Wed,  7 Jul 2021 17:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625679505;
        bh=VdWGklJl76w2+5As284YnVoqg9YaGih2Y+9+nhmWedA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi9PqcMNUDctpI27yEYxhHVhmx0AWnakpWaFczqny3dFgzR+POOeTLY0k++DgXGJ4
         dVQDMuI5sqvtYFoJbw/srkySRVeC3rvmck5p1165FRARFYagil4AXMxXwriEWsIhvK
         qokpVgKLyriGStPk/m68ZCSlFbzMXfFnJUULl//0=
Date:   Wed, 7 Jul 2021 19:38:23 +0200
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
Subject: Re: [PATCH RFC 1/2] driver core: Add ability to delete device links
 of unregistered devices
Message-ID: <YOXmj9im7s7e2DVq@kroah.com>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707172948.1025-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 07, 2021 at 08:29:47PM +0300, Adrian Hunter wrote:
> +void device_links_scrap(struct device *dev)
> +{
> +	if (WARN_ON(device_is_registered(dev)))

You just rebooted a box if this was hit, never add new WARN_ON() please.

greg k-h
