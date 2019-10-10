Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A10D33A0
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 23:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfJJVtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 17:49:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51519 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVtA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 17:49:00 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a3d10e737c4e1cf7; Thu, 10 Oct 2019 23:48:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Todd Brandt <todd.e.brandt@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        todd.e.brandt@intel.com, len.brown@intel.com
Subject: Re: [PATCH] pm-graph info added to MAINTAINERS
Date:   Thu, 10 Oct 2019 23:48:58 +0200
Message-ID: <5736249.VvcQulKspP@kreacher>
In-Reply-To: <20190919190912.8386-1-todd.e.brandt@linux.intel.com>
References: <20190919190912.8386-1-todd.e.brandt@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, September 19, 2019 9:09:12 PM CEST Todd Brandt wrote:
> Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b2326dece28e..309ab30d3f07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12944,6 +12944,15 @@ L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/pm8001/
>  
> +PM-GRAPH UTILITY
> +M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
> +L:	linux-pm@vger.kernel.org
> +W:	https://01.org/pm-graph
> +B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
> +T:	git git://github.com/intel/pm-graph
> +S:	Supported
> +F:	tools/power/pm-graph
> +
>  PNP SUPPORT
>  M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
> 

Applying as 5.5 material, thanks!



