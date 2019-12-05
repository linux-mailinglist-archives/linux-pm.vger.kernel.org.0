Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52B71114167
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 14:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfLENVd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 08:21:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:21001 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfLENVd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 08:21:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 05:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="214123910"
Received: from yuanwan1-mobl.ccr.corp.intel.com ([10.249.174.225])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2019 05:21:31 -0800
Message-ID: <f1379986c3fc9380eba9fd1c5e969fde822b177a.camel@intel.com>
Subject: Re: [PATCH] MAINTAINERS: thermal: Change the git tree location
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org
Date:   Thu, 05 Dec 2019 21:21:30 +0800
In-Reply-To: <20191205121227.19203-1-daniel.lezcano@linaro.org>
References: <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
         <20191205121227.19203-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2019-12-05 at 13:12 +0100, Daniel Lezcano wrote:
> The thermal trees were merged into a single one shared with the
> maintainer of the subsystem.
> 
> Update the location of this group git tree.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8acaf4f205a1..10607a4f1b04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16082,8 +16082,7 @@ M:	Zhang Rui <rui.zhang@intel.com>
>  M:	Daniel Lezcano <daniel.lezcano@linaro.org>
>  R:	Amit Kucheria <amit.kucheria@verdurent.com>
>  L:	linux-pm@vger.kernel.org
> -T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> -T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> thermal.git
> +T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>  Q:	https://patchwork.kernel.org/project/linux-pm/list/
>  S:	Supported
>  F:	drivers/thermal/

