Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE118CA74
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgCTJeN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 05:34:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbgCTJeN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Mar 2020 05:34:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 98BE1E213373F975596C;
        Fri, 20 Mar 2020 17:34:10 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 17:34:07 +0800
Subject: Re: [PATCH V2 0/2] thermal: Add HiSilicon Kunpeng thermal driver and
 Maintainers
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
References: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
CC:     <linux-pm@vger.kernel.org>
From:   Yang Shen <shenyang39@huawei.com>
Message-ID: <7b7dd94f-0e17-e192-f554-e578f80f5cc0@huawei.com>
Date:   Fri, 20 Mar 2020 17:34:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1584363301-15858-1-git-send-email-shenyang39@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/3/16 20:54, Yang Shen wrote:
> Add HiSilicon Kunpeng thermal driver and Maintainers.
> 
> Changelog:
> v2:
>  * fix sizeof(* tdev) and sizeof(* tdev->tsensor)
> 
> Yang Shen (2):
>   thermal: Add HiSilicon Kunpeng thermal driver
>   MAINTAINERS: Add maintainers for kunpeng thermal
> 
>  MAINTAINERS                       |   7 ++
>  drivers/thermal/Kconfig           |   8 ++
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/kunpeng_thermal.c | 219 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 235 insertions(+)
>  create mode 100644 drivers/thermal/kunpeng_thermal.c
> 
> --
> 2.7.4
> 
> 
> .
> 

Any comments?

