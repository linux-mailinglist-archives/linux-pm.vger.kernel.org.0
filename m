Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6764E75ED
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfJ1QQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 12:16:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729798AbfJ1QQq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 12:16:46 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFDE98331184E8A44F8D;
        Tue, 29 Oct 2019 00:16:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 00:16:37 +0800
Message-ID: <5DB71465.6050203@huawei.com>
Date:   Tue, 29 Oct 2019 00:16:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: cpcap-charger: Make cpcap_charger_voltage_to_regval
 static
References: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ping.

On 2019/10/21 23:40, zhong jiang wrote:
> The GCC complains the following case when compiling kernel.
>
> drivers/power/supply/cpcap-charger.c:563:5: warning: symbol 'cpcap_charger_voltage_to_regval' was not declared. Should it be static?
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/power/supply/cpcap-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
> index 40d96b8..c0d452e 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -560,7 +560,7 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
>  	dev_dbg(ddata->dev, "state: %s\n", status);
>  }
>  
> -int cpcap_charger_voltage_to_regval(int voltage)
> +static int cpcap_charger_voltage_to_regval(int voltage)
>  {
>  	int offset;
>  


