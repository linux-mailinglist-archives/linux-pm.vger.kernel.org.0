Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF9FBD5E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfKNBRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:17:32 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:41987 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfKNBRc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:17:32 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191114011730epoutp01c420f56fa651afb8a1ba78c043647cfd~W4pUwIAUV1083910839epoutp012
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2019 01:17:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191114011730epoutp01c420f56fa651afb8a1ba78c043647cfd~W4pUwIAUV1083910839epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573694250;
        bh=FXBWpKlesXfLLw3BqLNBcPCoTpNabhJYTRJ9xcKy+2s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mkMgCkh7haAsJsDxoNUTG5lTAJamuYbXWULXUnWZZjPNh11n8rhY3hokj+wWkMuZS
         /eEWnaji/JfhVh7YymU8CddAeRYucpSfyb9wKaTK97tyytyLE/qStZ8RTPwbOE0B0r
         goh2BSuU4nXo2PPEEbu7JtMg3Kb0G7clJ27u7UXI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191114011729epcas1p4b78b1369c535049f005d7e52a60c58b9~W4pTyfXwJ2168921689epcas1p4L;
        Thu, 14 Nov 2019 01:17:29 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47D3Vt6J7zzMqYkm; Thu, 14 Nov
        2019 01:17:26 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.2B.04144.22BACCD5; Thu, 14 Nov 2019 10:17:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191114011722epcas1p21cf9970859318b0dec0e9ab652f4e29a~W4pNo2ez71298012980epcas1p2v;
        Thu, 14 Nov 2019 01:17:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191114011722epsmtrp2bcd573bbe8670ed4a7673f4a58ea9ed3~W4pNm8Fey1353513535epsmtrp2V;
        Thu, 14 Nov 2019 01:17:22 +0000 (GMT)
X-AuditID: b6c32a35-2c7ff70000001030-67-5dccab22a2d5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.6D.24756.22BACCD5; Thu, 14 Nov 2019 10:17:22 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191114011721epsmtip21e0a9e40911214b7cbef6ffecba0a490~W4pNEKs0R2018120181epsmtip2P;
        Thu, 14 Nov 2019 01:17:21 +0000 (GMT)
Subject: Re: [RFC PATCH] PM / devfreq: clk_get_parent_by_index() can be
 static
To:     kbuild test robot <lkp@intel.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     kbuild-all@lists.01.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <71305a8a-9bb0-1317-3618-0ad18295ea92@samsung.com>
Date:   Thu, 14 Nov 2019 10:23:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113140710.jynosjegdq7t6igk@4978f4969bb8>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc3ofvZBVL2WsR6JZubiEYQq9sOLZHPgYLjdxiWTLDDEheAM3
        hdBXeimyzWSgYTxFQdAMNmAZSGFMoBSBWYYwdBmvDQyVx3CLkAUXLE7oNMCIfbDIf9/f73y+
        5/c4ORQmH5eGUpmGbMFs4HUMGYh/f+ugSsVcG0tRd9XFoaGfu6XIPToC0LdTPwG0Xn0DQ4sP
        5gHquZiG6ocnCNTZNY+jb/ptJBovdQLUWt2Ho7t3O6Ro/NMVKbIuPCGQbdFJoCdlvxGoZKMF
        Q2ufDwP0+LPfSdT066QEOa0VBFrrWARocuRdNJ9vJdG1iUESjY1OEaigf1iKSoaekWjb2Ymj
        ZbsCdbq5t/Zz1SVWwLXVtQFudaZAytXmTeJcg83CXXX8IeFsrcUkd9/pILnS2m2c62o8z3W6
        eiXcoMsh4b54puY2boVw9ulCnCu3t4KkoA+zjmYIfLpgVgqGNGN6pkEbz7x3KvVYqiZOzarY
        w+h1Rmng9UI8k3giSXU8U+dZF6PM4XUWTyqJF0UmOuGo2WjJFpQZRjE7nhFM6TrTYVOUyOtF
        i0EblWbUH2HV6hiNB/woK2PqhzLc5CZzZ5sugTwwQpSAAArSh+D09W5QAgIpOd0L4Ib1IeYP
        /gawfP2mxEvJ6acAdjTve+4oz9/YgfoBzOvYkvqDVQBbKgeBlwqmk6B7rt6n99InYZur0efA
        6HYKVl14hHsPSDoSDizPkF79Ih0Gp/9d9BlkdALcWi/2aZw+ABtbVj08RYXQyXDUzfuRIHjn
        4pLvmgD6DdhU4fZ1itEKOLdUv6P3w54/L/nqQvoeBZcfDO8MnQjttaU7Ohg+vm2X+nUoXHP1
        k359DrbcGSb95iIA7QP3dgyxcKDpK4m3IYw+CNtvRPvTYbBv8zLwF34ButxlhBeBtAwWXZD7
        kXD4y8MFiV+/BK8WFpNfAqZm1zg1u0ao2TVCzf/FGgDeCvYJJlGvFUTWxO5+bRvwfaVITS+o
        mjgxBGgKMHtkP4aMpcgJPkc8ox8CkMKYvbIIgyclS+fPnBXMxlSzRSeIQ0DjWXYFFhqSZvR8
        TEN2KquJiY2NRYfYOA3LMgrZ281NKXJay2cLWYJgEszPfRIqIDQPOFbC/4pY/O5lsqWunZW/
        3zW40DxnyG04WXk/eVunXZk8FlWovLKVq12KII6rCz62KAKKj0RGKSJ7VLng9OaVd/KDz59z
        zJzFXot95XbRzcrqpxU53QFfzyfvOR2T+Ci4QD/5T8KBKmtZkdkWHRY0q+x5c2xzhQifDUr9
        4JP6wK5X+xhczODZSMws8v8BERQ1KGAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXcuO0qr01R8M0EcRCVoCn54oRIhqrcvFSViQdloxwu6KTtq
        KVJaSjhvCU3xklo60XnJTc075pyCOhUnniwrQ7uKl6RWISq5aeC3H8//+T2f/gwh7aA8mGhV
        AqdWyWNltDP5ckDm5Surt9zw15g8kGmoTYxsoyMA1VgHAfql7SLQwtwsQO3Ft1GFeZxChpZZ
        EhX1Gmk0li0ApNd2kmhiolmMxh4siVHt+zUKGRcECq3lfKCQZr2OQD9zzQAtPpynke71pAgJ
        tQUU+tm8ANDkyFk0m15Lo/rxfhpZRq0Uyuw1i5HGtEmjLcFAom+t7shgw8FeWKupBbihvAHg
        1ZlMMS5NmyRxpTERV/V8F2GjPovG74QeGmeXbpG4pfo+Nqx0iHD/So8I52/64/UBN9w6/YjE
        ea16cPngdedTCi42OolTnwi65Rxl7c4h42303Te6MpAGRigNcGIgGwjz0tcJDXBmpGw3gLlF
        ZcTO4RAsnBzcZmabXeDAAG+PpewygObue3Z2YS/C73ObjrorewWaBQtt3yHYNgYKNWX0zuj8
        ttAl0PYWzfrAvm8zDj7AesPpvwvAzhI2CG78ynIwyR6B1XWrpJ3d2DD4tX1mt3MQDhd/cuRO
        7EmoK7CJ7EywR+FGuZXYYXf49lPFbu4F25fLiMfApWSPXrJHKdmjlOxRKgGpB4e4eF4ZqeQD
        4gNU3B0/Xq7kE1WRfrfjlEbg+Cef4x1gqjrcBFgGyPZJXrlZbkgpeRKfrDQByBAyV8kx1XYk
        UciTUzh1XLg6MZbjTeAwQ8rcJZ9VQ9ekbKQ8gYvhuHhO/f8qYpw80kDi2rlnfT9WUjxdLyR3
        6E1LOWMvwvMaFU2rChBzvvOmJFUnSm0t9Kg3f/wdGagAvSjqz/M2/XSjQet9df/wTMYXr9RL
        nslb7rbyyogmXWiQIThGPRIx1Z4Rtlr5JJgPyV8sJXvHqk5Piay+oSHygubhp2yotnBIwZzh
        soT1fBnJR8kDfAg1L/8HdvbQcUsDAAA=
X-CMS-MailID: 20191114011722epcas1p21cf9970859318b0dec0e9ab652f4e29a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191113140815epcas1p194a07ca0cf4b2776d32a25ee71f804c4
References: <d33acdcc043ce12713a9279636e32d039da5ee54.1573595319.git.leonard.crestez@nxp.com>
        <CGME20191113140815epcas1p194a07ca0cf4b2776d32a25ee71f804c4@epcas1p1.samsung.com>
        <20191113140710.jynosjegdq7t6igk@4978f4969bb8>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Please apply this to next version.

On 11/13/19 11:07 PM, kbuild test robot wrote:
> 
> Fixes: f01e004107f3 ("PM / devfreq: Add dynamic scaling for imx8m ddr controller")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  imx8m-ddrc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 62abb9b79d8a0..228561de94425 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -122,7 +122,7 @@ static void imx8m_ddrc_smc_set_freq(int target_freq)
>  	local_irq_enable();
>  }
>  
> -struct clk *clk_get_parent_by_index(struct clk *clk, int index)
> +static struct clk *clk_get_parent_by_index(struct clk *clk, int index)
>  {
>  	struct clk_hw *hw;
>  
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
