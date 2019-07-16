Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486B96A115
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 06:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfGPEAI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 00:00:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:20439 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfGPEAH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 00:00:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716040004epoutp04ead273d7af2c3c39d36e1bbec4e92a71~xxzuUXRfj1121911219epoutp04I
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 04:00:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716040004epoutp04ead273d7af2c3c39d36e1bbec4e92a71~xxzuUXRfj1121911219epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563249604;
        bh=aDNCnD/M4XVzG7WU9bomWyyx8bcIFIBz3UHjVIKdLFc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wx52VE08m89iW/5HojH/YnU41027xgSdd8+npEliMjZPWAPKZ4ZfdCEZR5FpYJkda
         6HOLcb0XpjlxE2wfGyIRGQ8KIRq+3ewCmicg7zAT+zjzgJVNLeK4oBnhcLPlyQzioI
         MiK1pdRsgXT8nQtpyn64H9OZbWaIj0dBCZllU3s4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190716040003epcas1p1723a366f058fe1abe3f9c547fa1164f2~xxztvnvT00742907429epcas1p1j;
        Tue, 16 Jul 2019 04:00:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45nmrJ5WcyzMqYkV; Tue, 16 Jul
        2019 04:00:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.A1.04085.0CB4D2D5; Tue, 16 Jul 2019 13:00:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190716040000epcas1p3e60e79eb68e7c9cd3343774adf33f45c~xxzqmUrv50653406534epcas1p3_;
        Tue, 16 Jul 2019 04:00:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190716040000epsmtrp2a685f93ed63e20804bf50c09e22a394c~xxzqlasX92813328133epsmtrp2v;
        Tue, 16 Jul 2019 04:00:00 +0000 (GMT)
X-AuditID: b6c32a39-cebff70000000ff5-24-5d2d4bc05c6c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.CD.03706.0CB4D2D5; Tue, 16 Jul 2019 13:00:00 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190716040000epsmtip2b4c2f3e4ec98676416a39eb36a9e1710~xxzqVYIOv0528005280epsmtip2R;
        Tue, 16 Jul 2019 04:00:00 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] opp: core: add regulators enable and disable
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9acc7dd0-614b-ccd3-a485-eeca3dab494b@samsung.com>
Date:   Tue, 16 Jul 2019 13:03:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715120416.3561-2-k.konieczny@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmru4Bb91Yg4fP1C02zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5
        uVaGBgZGpkCFCdkZX7dtZy54JVQx7bZLA+Mk/i5GTg4JAROJ85NvMHYxcnEICexglNgyuZcJ
        JCEk8IlRYtJnUYjEN0aJzadOscN09E09yAaR2Mso8WL6WmaIjveMEncuW4PYwgIeEsevPGcD
        sUUETCUerW5gBWlgFrjMIjHt0SRWkASbgJbE/hc3wIr4BRQlrv54zAhi8wrYSTw7eZ8FxGYR
        UJU4emsDmC0qECFx6sg8FogaQYmTM5+A2ZwCLhKNx06AzWQWEJe49WQ+E4QtL9G8dTYzyGIJ
        gUPsEi9+rQBaxgHkuEh8b1OH+EZY4tXxLVCfSUl8freXDcKullh58ggbRG8HMFz2X2CFSBhL
        7F86mQlkDrOApsT6XfoQYUWJnb/nMkLs5ZN497WHFWIVr0RHmxBEibLE5Qd3mSBsSYnF7Z1s
        ExiVZiH5ZhaSD2Yh+WAWwrIFjCyrGMVSC4pz01OLDQtMkeN6EyM4bWtZ7mA8ds7nEKMAB6MS
        D++JPTqxQqyJZcWVuYcYJTiYlUR4bb9qxwrxpiRWVqUW5ccXleakFh9iNAUG9kRmKdHkfGBO
        ySuJNzQ1MjY2tjAxNDM1NFQS5533RzNWSCA9sSQ1OzW1ILUIpo+Jg1OqgXHqgcOqbG6BU5vK
        DHhPfDzxzK55Z+/i+cU/Nq489YTRJKLtwyG+7X4b7RySdNZE1FXlss5oda4/25G47TDj9aBG
        r7y0h+pzKgW/uGt9PpN5v0n0VLP+nISzPtHfHtx5Uf/f1C7dTL9RNO6C+M2cjeomx2ojLpnJ
        fBN+ZyvVf/CigVRBwaH/J5VYijMSDbWYi4oTAeopGYfxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7bCSvO4Bb91YgxtHBS02zljPajH/yDlW
        i759/xkt+h+/ZrY4f34Du8XZpjfsFpseX2O1uLxrDpvF594jjBYzzu9jslh75C67xdLrF5ks
        bjeuYLN48+Msk0Xr3iPsFv+ubWSx2PzgGJuDoMeaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6
        HL+xncnj8ya5APYoLpuU1JzMstQifbsEroyv27YzF7wSqph226WBcRJ/FyMnh4SAiUTf1INs
        ILaQwG5GiY9XRCHikhLTLh5l7mLkALKFJQ4fLu5i5AIqecsoMf1oI1i9sICHxPErz8FsEQFT
        iUerG1hBipgFrrJInN84B2roRUaJKY8tQWw2AS2J/S9ugMX5BRQlrv54zAhi8wrYSTw7eZ8F
        xGYRUJU4emsDmC0qECEx6dpOFogaQYmTM5+A2ZwCLhKNx06wgtjMAuoSf+ZdYoawxSVuPZnP
        BGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjOAI1tLcwXh5SfwhRgEORiUe3hN7dGKFWBPLiitzDzFKcDArifDaftWOFeJNSaysSi3K
        jy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoExvZ95xu1zoWcbrLLllzUY
        r2XdyBhbYnhdpdFazkqxYPPacOXCJeqSzq/ttzc9snx5Otfw0uZ/vQw7NII5uM+vqykVb85o
        cX5R/UpknZOknnTENYP2o0Gy6keezHA8abRU7gJzAnf48VxN7sntpbO/S0y4z5he7MzDbMPp
        vP7Qjggv13+VukosxRmJhlrMRcWJAIUiIRLcAgAA
X-CMS-MailID: 20190716040000epcas1p3e60e79eb68e7c9cd3343774adf33f45c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3
References: <20190715120416.3561-1-k.konieczny@partner.samsung.com>
        <CGME20190715120430eucas1p19dddcc93756e6a110d3476229f9428b3@eucas1p1.samsung.com>
        <20190715120416.3561-2-k.konieczny@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

On 19. 7. 15. 오후 9:04, Kamil Konieczny wrote:
> Add enable regulators to dev_pm_opp_set_regulators() and disable
> regulators to dev_pm_opp_put_regulators(). This prepares for
> converting exynos-bus devfreq driver to use dev_pm_opp_set_rate().

IMHO, it is not proper to mention the specific driver name.
If you explain the reason why enable the regulator before using it,
it is enough description.

> 
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> --
> Changes in v2:
> 
> - move regulator enable and disable into loop
> 
> ---
>  drivers/opp/core.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0e7703fe733f..069c5cf8827e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1570,6 +1570,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  			goto free_regulators;
>  		}
>  
> +		ret = regulator_enable(reg);
> +		if (ret < 0)
> +			goto disable;
> +
>  		opp_table->regulators[i] = reg;
>  	}
>  
> @@ -1582,9 +1586,15 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
>  
>  	return opp_table;
>  
> +disable:
> +	regulator_put(reg);
> +	--i;
> +
>  free_regulators:
> -	while (i != 0)
> -		regulator_put(opp_table->regulators[--i]);
> +	for (; i >= 0; --i) {
> +		regulator_disable(opp_table->regulators[i]);
> +		regulator_put(opp_table->regulators[i]);
> +	}
>  
>  	kfree(opp_table->regulators);
>  	opp_table->regulators = NULL;
> @@ -1610,8 +1620,10 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>  	/* Make sure there are no concurrent readers while updating opp_table */
>  	WARN_ON(!list_empty(&opp_table->opp_list));
>  
> -	for (i = opp_table->regulator_count - 1; i >= 0; i--)
> +	for (i = opp_table->regulator_count - 1; i >= 0; i--) {
> +		regulator_disable(opp_table->regulators[i]);
>  		regulator_put(opp_table->regulators[i]);
> +	}
>  
>  	_free_set_opp_data(opp_table);
>  
> 

I agree to enable the regulator before using it.
The bootloader might not enable the regulators
and the kernel need to enable regulator in order to increase
the reference count explicitly event if bootloader enables it.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
