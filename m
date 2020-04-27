Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519CC1B9A5D
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 10:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgD0IhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 04:37:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbgD0IhI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 04:37:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ED90B1EA318D7A818CB3;
        Mon, 27 Apr 2020 16:37:05 +0800 (CST)
Received: from [127.0.0.1] (10.74.173.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 16:36:59 +0800
Subject: Re: [PATCH V3 0/2] thermal:Add HiSilicon Kunpeng thermal driver and
 Maintainers
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>
References: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
CC:     <linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>
From:   "shenyang (M)" <shenyang39@huawei.com>
Message-ID: <3d4a17ca-d588-a47f-4b89-40753f357639@huawei.com>
Date:   Mon, 27 Apr 2020 16:36:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1587455093-33876-1-git-send-email-shenyang39@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.173.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/4/21 15:44, Yang Shen wrote:
> Add HiSilicon Kunpeng thermal driver and Maintainers.
>
> Changelog:
> v3:
>  * remove tsensor devices enabled checking in probe function
>  * fix some comments
> v2:
>  * fix sizeof(* tdev) and sizeof(* tdev->tsensor)
>
> Yang Shen (2):
>   MAINTAINERS: Add maintainers for kunpeng thermal
>   thermal: Add HiSilicon Kunpeng thermal driver
>
>  MAINTAINERS                       |   7 ++
>  drivers/thermal/Kconfig           |   8 ++U
>  drivers/thermal/Makefile          |   1 +
>  drivers/thermal/kunpeng_thermal.c | 216 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 drivers/thermal/kunpeng_thermal.c
>
> --
> 2.7.4
>
>
> .
>

Would you have any comments?
Thx.
Yang

