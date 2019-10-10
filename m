Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31421D33BA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfJJWCv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 18:02:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57583 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJJWCv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 18:02:51 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 41b39622b0139b57; Fri, 11 Oct 2019 00:02:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: sleep: include <linux/pm_runtime.h> for pm_wq
Date:   Fri, 11 Oct 2019 00:02:48 +0200
Message-ID: <4465950.ddMAbEBQAA@kreacher>
In-Reply-To: <20191008104646.11658-1-ben.dooks@codethink.co.uk>
References: <20191008104646.11658-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, October 8, 2019 12:46:46 PM CEST Ben Dooks wrote:
> Include the <linux/runtime_pm.h> for the definition of
> pm_wq to avoid the following warning:
> 
> kernel/power/main.c:890:25: warning: symbol 'pm_wq' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  kernel/power/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index e8710d179b35..e26de7af520b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "power.h"
>  
> 

Applying as a fix for 5.4, thanks!




