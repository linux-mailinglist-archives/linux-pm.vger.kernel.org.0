Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFB19A244
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgCaXNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:13:31 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38567 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbgCaXNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:13:31 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200331231329epoutp015a95bbad00bed02f0e122ae269519445~BhnudHgTC1218412184epoutp01a
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:13:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200331231329epoutp015a95bbad00bed02f0e122ae269519445~BhnudHgTC1218412184epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585696409;
        bh=NT/waN1WxKqs2OMuNZobwvVMLut5DpCIlxECcN/KHs0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wh1USzc6K5Cq5VY3/SaExiSMwnBKyIG8DR2kf7ozo6wA3l9DtQ/fRy/EpnirIqxZS
         KuYJDeaaCMDaoMNv/YglOxEFa5FZat69bW/Z7WOBg1c7dtFsMFZR/Pl0IwmUCgNe58
         7AiZ08UmV4aqT/w+xzFFtoPR2Br9zKlmwMgiypTg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200331231328epcas1p1983b8a4359a003aaff08e227300747da~BhnttF8Bx0986009860epcas1p1R;
        Tue, 31 Mar 2020 23:13:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48sQ9f1dbpzMqYm2; Tue, 31 Mar
        2020 23:13:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.1E.04074.59EC38E5; Wed,  1 Apr 2020 08:13:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331231324epcas1p107bfd3412b713677290a810bbdf776b1~BhnqJCqrN0419604196epcas1p1-;
        Tue, 31 Mar 2020 23:13:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331231324epsmtrp2bb9b1fac3fa31042f76e8f77007f4b50~BhnqH3Kma1277512775epsmtrp2u;
        Tue, 31 Mar 2020 23:13:24 +0000 (GMT)
X-AuditID: b6c32a39-58bff70000000fea-b2-5e83ce956bf4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.A5.04158.49EC38E5; Wed,  1 Apr 2020 08:13:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331231324epsmtip2644286e363c458a2eea854e47e02c2d3~Bhnp54owu1925719257epsmtip21;
        Tue, 31 Mar 2020 23:13:24 +0000 (GMT)
Subject: Re: [PATCH v1 3/5] PM / devfreq: tegra20: Use
 clk_round_rate_unboundly()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8e62e4ac-081c-a1ac-f0a9-b4e882fcd3b5@samsung.com>
Date:   Wed, 1 Apr 2020 08:22:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200330231617.17079-4-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmnu7Uc81xBh/mG1is/viY0aJl1iIW
        i7NNb9gtPvbcY7W4vGsOm8Xn3iOMFp1fZrFZXDzlanG7cQWbxb9rG1ksfu6ax+LA7fH+Riu7
        x85Zd9k9Nq3qZPPobX7H5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM9b1vmQp2MNfMfvDVpYGxgs8XYwcHBICJhLH
        Fjp2MXJyCAnsYJQ42svSxcgFZH9ilLi3ciIzROIbo8T05cYgNkj9rHV/WCGK9jJKbPw9A6rj
        PaPEi+/7wTqEBYIlZvdPYQJJiAgsZpJ4vXkuC0iCWaBEYvfEI0wgNpuAlsT+FzfYQGx+AUWJ
        qz8eM4LYvAJ2Ev03J4LZLAIqEouXTQKrERUIkzi5rQWqRlDi5MwnYDM5Bcwklk/qZoSYLy5x
        68l8JghbXmL72znMEGdPZpdoWSUBYbtIHJ7xjhXCFpZ4dXwLO4QtJfH53V42CLtaYuXJI2wg
        D0gIdDBKbNl/AarBWGL/0slMoLBjFtCUWL9LHyKsKLHz91yoG/gk3n3tYYUEL69ER5sQRImy
        xOUHd5kgbEmJxe2dbBMYlWYh+WYWkg9mIflgFsKyBYwsqxjFUguKc9NTiw0LTJHjehMjOOFq
        We5gPHbO5xCjAAejEg+vglVznBBrYllxZe4hRgkOZiURXjb/hjgh3pTEyqrUovz4otKc1OJD
        jKbAwJ7ILCWanA/MBnkl8YamRsbGxhYmhmamhoZK4rxTr+fECQmkJ5akZqemFqQWwfQxcXBK
        NTB2N7xUjVhSUN10JsP6wNKeF49nfdZe++4Xd3jZBIlC8z+ZcgwcNTVcKx6ytIUI9/B76y7/
        s/xjtqfoNt79O7KmJX6ODZKdrjPVb/H3JB65e8bBK6YJpCpt65RfxftvWVlJzcFvR4PqVNg2
        xh3/fnOC5n3ZbZtObEoI2mQpqaqj1HDLU0TNXVyJpTgj0VCLuag4EQDDSbCnzgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvO6Uc81xBgt+K1us/viY0aJl1iIW
        i7NNb9gtPvbcY7W4vGsOm8Xn3iOMFp1fZrFZXDzlanG7cQWbxb9rG1ksfu6ax+LA7fH+Riu7
        x85Zd9k9Nq3qZPPobX7H5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ63pfshTs4a+Y/WEr
        SwPjBZ4uRk4OCQETiVnr/rB2MXJxCAnsZpTYe/4PO0RCUmLaxaPMXYwcQLawxOHDxRA1bxkl
        rp7dxApSIywQLDG7fwoTSEJEYCmTxIqbX8CamQVKJE48+wc1dSujxLqFc5lAEmwCWhL7X9xg
        A7H5BRQlrv54zAhi8wrYSfTfnAhmswioSCxeNgmsRlQgTGLnksdMEDWCEidnPmEBsTkFzCSW
        T+pmhFimLvFn3iVmCFtc4taT+UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHIFaWjsYT5yIP8QowMGoxMOraNUcJ8SaWFZcmXuI
        UYKDWUmEl82/IU6INyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMH
        p1QDo8qG9Ctqu9TrJ3PohP++qpaVb88aFFIvcetN2J1qZhZZmaMWkqf36zteZ+7w0H1zYdss
        scXnUoJP+24y/O6iermG62p0RBnn7/4LorNXRmWcfzLp1TTDg5or4q45CoS0HH9voHfWWTa2
        8eyy8p/83OfePj5w972ar4ndmzjNhgk+BpwXJLY7KbEUZyQaajEXFScCAIZvho+8AgAA
X-CMS-MailID: 20200331231324epcas1p107bfd3412b713677290a810bbdf776b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232035epcas1p4dc533fd4e30d543a1cd12ebb5c5e80b3
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232035epcas1p4dc533fd4e30d543a1cd12ebb5c5e80b3@epcas1p4.samsung.com>
        <20200330231617.17079-4-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
> The clk_round_rate() doesn't work for us properly if clock rate is bounded
> by a min/max rate that is requested by some other clk-user because we're
> building devfreq's OPP table based on the rounding.
> 
> In particular this becomes a problem if display driver is probed earlier
> than devfreq, and thus, display adds a memory bandwidth request using
> interconnect API, which results in a minimum clock-rate being set for
> the memory clk. In a result, the lowest devfreq OPP rate is getting
> limited to the minimum rate imposed by the display driver.
> 
> Let's use new clk_round_rate_unboundly() that resolves the problem by
> rounding clock rate without taking into account min/max limits imposed by
> active clk users.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra20-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> index ff82bac9ee4e..1bb10ef11dfe 100644
> --- a/drivers/devfreq/tegra20-devfreq.c
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -149,10 +149,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  
>  	tegra->regs = mc->regs;
>  
> -	max_rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
> +	max_rate = clk_round_rate_unboundly(tegra->emc_clock, ULONG_MAX);
>  
>  	for (rate = 0; rate <= max_rate; rate++) {
> -		rate = clk_round_rate(tegra->emc_clock, rate);
> +		rate = clk_round_rate_unboundly(tegra->emc_clock, rate);
>  
>  		err = dev_pm_opp_add(&pdev->dev, rate, 0);
>  		if (err) {
> 

Firstly, patch1 have to be reviewed for this patch.
I have no any objection. It looks good to me.

If patch1 get the confirmation from clock maintainer,
feel free to add my acked tag:
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
