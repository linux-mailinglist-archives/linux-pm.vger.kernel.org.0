Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC44325F97C
	for <lists+linux-pm@lfdr.de>; Mon,  7 Sep 2020 13:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgIGLbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 07:31:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbgIGL37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 07:29:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C3CF12FC;
        Mon,  7 Sep 2020 04:29:58 -0700 (PDT)
Received: from [10.37.12.62] (unknown [10.37.12.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316CF3F66E;
        Mon,  7 Sep 2020 04:29:56 -0700 (PDT)
Subject: Re: [PATCH] PM: <linux/device.h>: fix @em_pd kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <d97f40ad-3033-703a-c3cb-2843ce0f6371@infradead.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6de9dd19-3bbc-41a7-b36d-9f085eb2e548@arm.com>
Date:   Mon, 7 Sep 2020 12:29:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d97f40ad-3033-703a-c3cb-2843ce0f6371@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

On 9/7/20 4:42 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning in <linux/device.h>:
> 
> ../include/linux/device.h:613: warning: Function parameter or member 'em_pd' not described in 'device'
> 
> Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in Energy Model")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   include/linux/device.h |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- lnx-59-rc4.orig/include/linux/device.h
> +++ lnx-59-rc4/include/linux/device.h
> @@ -454,6 +454,7 @@ struct dev_links_info {
>    * @pm_domain:	Provide callbacks that are executed during system suspend,
>    * 		hibernation, system resume and during runtime PM transitions
>    * 		along with subsystem-level and driver-level callbacks.
> + * @em_pd:	device's energy model performance domain
>    * @pins:	For device pin management.
>    *		See Documentation/driver-api/pinctl.rst for details.
>    * @msi_list:	Hosts MSI descriptors
> 

Good catch. Thank you for the patch.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz Luba
