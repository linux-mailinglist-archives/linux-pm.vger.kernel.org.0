Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A37A546
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfG3J4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 05:56:46 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34808 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbfG3J4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 05:56:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190730095644euoutp025f3cd2707e5caeb87074fbc7f1d8f367~2JtIk2MjD1358613586euoutp02B
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 09:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190730095644euoutp025f3cd2707e5caeb87074fbc7f1d8f367~2JtIk2MjD1358613586euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564480604;
        bh=J7C6F6f1O10uZCnDYJbxnFenJZXCd4ywsRX9p5J/bJI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ocPceOKjrljaFUqntuL/BFOelIO2iOkDhreDIuRBt/wfZ2EbwWlOstbd7JspK9Imx
         SUaX+uA6a+gKhfZquA4B1Kv9BwokZpK3QMgI8YcwHO9EEr8IaSxFm7oMZm29HeJ3VX
         9KdGFC+EYuSBROS3DBJfHfa59tnoudh43+HceQc8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190730095644eucas1p2df5a42cb2746e120409167fcb59acba4~2JtIE7PQV2966429664eucas1p2F;
        Tue, 30 Jul 2019 09:56:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8D.27.04298.B54104D5; Tue, 30
        Jul 2019 10:56:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190730095643eucas1p1f82bec8062cc4dd353f82979fda1e96a~2JtHT8Hwz2725827258eucas1p1p;
        Tue, 30 Jul 2019 09:56:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190730095642eusmtrp1616e427a8e8bf2487c61708673510062~2JtHFswcc0349003490eusmtrp1R;
        Tue, 30 Jul 2019 09:56:42 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-15-5d40145b90c1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 30.54.04140.A54104D5; Tue, 30
        Jul 2019 10:56:42 +0100 (BST)
Received: from [106.120.50.63] (unknown [106.120.50.63]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190730095642eusmtip23307ea8f285288414be5926a07bbe00e~2JtGoEhiV2616526165eusmtip2k;
        Tue, 30 Jul 2019 09:56:42 +0000 (GMT)
Subject: Re: [PATCH] driver core: Fix creation of device links with
 PM-runtime flags
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2e1d36f6-338b-e0a1-fbcd-1ea082159bda@samsung.com>
Date:   Tue, 30 Jul 2019 11:56:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7674989.cD04D8YV3U@kreacher>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe7x3d3ejyeM0PKgUDgozfKOCSws18cM+FCZBQma68qLWnGNT
        UysQFV+WYmg2G6bigsTSkfj+gm5aq9SRE8UiQ0mxF2eaSSgqtd0yv/3OOf//c84fHpoQm3he
        dIoynVUr5QoJJSQ7Xm5YA2I9wuOCu54HME9XPyEm32CkmAJ9A8lM9NRQzFrZMGI+L3ozoyM2
        HqM1b1OMpTkmXCDr1s/wZfWtGbIPU32UbODRM76sLH+ZkrVNFpGytdaDsuqiDt55+pLwdCKr
        SMlk1UGhCcLkrb4CpFp0y/r4xUTlohpXLRLQgE/ASkmxixYJaTFuRPAud5Tgip8IGgZNPK5Y
        Q7BVVUDtWoY2CQeL8RME691ZnMiOYGnyjVPkji/CWtmskz3wFTDUTjifJXCRC7Qv5DndFA4B
        rV3rFIlwKOhMBcjBJD4MxlUrz8EH8GXoXiolOI0bvH44T2oRTQuwP1QORznaBD4EnfYagmNP
        eD9f58wDeIoP5XlmxF0dCbYqI8mxO3y1tPE59oGRylKSM+QjmLM287miFMFEXvVftxSGLOM8
        x2YCHwVjTxDXPgPbukLnQYBdYdruxh3hChUdOoJri6C4UMypj4De0rK71vTWRtxDEv2eZPo9
        cfR74uj/761HZBPyZDM0qUmsJkTJ3gzUyFM1GcqkwGtpqa3oz8ca2bH86ELrtqtmhGkk2S/y
        WwmNE/PkmZrsVDMCmpB4iAyeYXFiUaI8O4dVp8WrMxSsxoy8aVLiKbq1bzZWjJPk6ewNllWx
        6n9TF1rglYvKmhRRVOPc2ZNmVZSqMHpywXpq+ELFfOhOy6DuzliClJLOJdsN/b4VJb/Ufsd9
        zgnjX8QMhPV/Fy4peArDRpzvK8or9thCS+OYl3T87oxoubez3LVdld77bf261bZZd1/QaXqg
        SIrUx4TdjshpeayNrpxWeAS7SSOiamml7oiE1CTLQ/wJtUb+G41qxzRUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pRIg6xBsvumlms/viY0aJ58Xo2
        i5ZZi1gsLu+aw2bxufcIo8WL59IWZ05fYrXoOvSXzeL42nAHTo+ds+6yeyzYVOpx59oeNo/9
        c9ewe/Q2v2Pz2HK1ncXj8yY5jxnt21gDOKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUM
        jc1jrYxMlfTtbFJSczLLUov07RL0Mv7saWEseC5Yce/lQbYGxjl8XYycHBICJhIfDv9i7mLk
        4hASWMooceRKJxtEQkbi5LQGVghbWOLPtS42iKLXjBKzrh0AKxIWCJO48WMpWJGIQJzEufsv
        wYqYBdqZJNbu28gEkhASqJV4tHETM4jNJmAo0fW2C6yZV8BOYvrBFkYQm0VAVWL9x3Ngg0QF
        YiT2ndnODlEjKHFy5hOWLkYODk4BLYnJR/xBwswCZhLzNj9khrDlJba/nQNli0vcejKfaQKj
        0Cwk3bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgRG67djPLTsYu94F
        H2IU4GBU4uHV+GAXK8SaWFZcmXuIUYKDWUmEd7G4fawQb0piZVVqUX58UWlOavEhRlOg3yYy
        S4km5wOTR15JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBkZHb73S
        gOUGG5de9VSW42eoT83e17LZcXLoxXbJk0wz9/xhTnnbtcYibTN3tW/7jXAj6yMui69HLb4/
        v1LwTn9lYMrvib/dRZXNOPrs/F+r100NLmzr+rW3sk5uVWtP+Vbf+1Mc/mccvFxmbPNsYxhj
        1Ier57cnHLzpcuSO58VlpyqDrlz/3qLEUpyRaKjFXFScCABorYj25gIAAA==
X-CMS-MailID: 20190730095643eucas1p1f82bec8062cc4dd353f82979fda1e96a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190730092907epcas2p486e986eff88d4b52f707b8cde71fb879
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190730092907epcas2p486e986eff88d4b52f707b8cde71fb879
References: <CGME20190730092907epcas2p486e986eff88d4b52f707b8cde71fb879@epcas2p4.samsung.com>
        <7674989.cD04D8YV3U@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2019-07-30 11:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit 515db266a9da ("driver core: Remove device link creation
> limitation"), if PM-runtime flags are passed to device_link_add(), it
> will fail (returning NULL) due to an overly restrictive flags check
> introduced by that commit.
>
> Fix this issue by extending the check in question to cover the
> PM-runtime flags too.
>
> Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

The merged commit also has my 'tested' tags, but I did my tests on v1, 
which worked fine. The offending check has been added in v2 while 
keeping the tags. Thanks for spotting this and fixing the issue, due to 
holidays time, I didn't manage to test v2 before it got merged.

> ---
>   drivers/base/core.c |    6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -213,6 +213,9 @@ void device_pm_move_to_tail(struct devic
>   			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
>   			       DL_FLAG_AUTOPROBE_CONSUMER)
>   
> +#define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
> +			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
> +
>   /**
>    * device_link_add - Create a link between two devices.
>    * @consumer: Consumer end of the link.
> @@ -274,8 +277,7 @@ struct device_link *device_link_add(stru
>   {
>   	struct device_link *link;
>   
> -	if (!consumer || !supplier ||
> -	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
> +	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
>   	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
>   	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
>   	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
>
>
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

