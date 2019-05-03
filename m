Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDCE12772
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfECGCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 02:02:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41802 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECGCb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 02:02:31 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190503055415epoutp015e5d7da91e0d3bc30f3e2e53d4c70a43~bFoSeLsv80115801158epoutp01O
        for <linux-pm@vger.kernel.org>; Fri,  3 May 2019 05:54:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190503055415epoutp015e5d7da91e0d3bc30f3e2e53d4c70a43~bFoSeLsv80115801158epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556862855;
        bh=PbXn+gJvL9U25p+y8f6ycFgXJv6UhVW/0GSUS+T4QiY=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=e/NnPnfMozuG7BFSfItWsQq8YmgtZSOcUnN9ELApc733LLB2+hHQqF9j9PWyP5Yzc
         ZX0pbhOCv3vYAlTEwupZNN9y2K0TsjD/JOzWpOlxkSTurilDgNx/a/ZBoDAje9Md7n
         VtEvSqy1vVBHCQLPhFOs4euboPzq13zaeppwPZUE=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190503055412epcas1p2f4bee8c3416d7118091fab7a70eeef11~bFoP0D0ay3245432454epcas1p2l;
        Fri,  3 May 2019 05:54:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        AF.64.04143.387DBCC5; Fri,  3 May 2019 14:54:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190503055410epcas1p47b62e54945612ab9f13b4a3be4668843~bFoOjLeDe1493414934epcas1p4T;
        Fri,  3 May 2019 05:54:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190503055410epsmtrp15105965ad61aa65c3e695848426f8e47~bFoOico801800318003epsmtrp1c;
        Fri,  3 May 2019 05:54:10 +0000 (GMT)
X-AuditID: b6c32a37-f19ff7000000102f-dd-5ccbd783f68c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.65.03662.287DBCC5; Fri,  3 May 2019 14:54:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190503055410epsmtip23a0ced8c2d34fbf4130a7fb2eddbf061~bFoOZEqpU1931219312epsmtip2r;
        Fri,  3 May 2019 05:54:10 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: rk3399_dmc: Fix spelling typo
To:     =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b8035dc7-cdb2-d099-790a-14960c26f106@samsung.com>
Date:   Fri, 3 May 2019 14:55:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502184013.11836-1-gael.portay@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdljTQLf5+ukYgy2ThCyW7HrDZnG26Q27
        xefeI4wWtxtXsDmweOy4u4TRo2/LKkaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453j
        Tc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgLYpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yV
        UgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzLrbeZC9YwV6x/P4T9gbGt6xdjJwcEgIm
        Eo/enmHvYuTiEBLYwShxYf9RVgjnE6PEz5P/oDLfGCXOPvjKCNMy6fs+FojEXkaJ73+nQTnv
        GSUu3bvNDFIlLOAgse7qXyYQW0RgHaPEsU0OIDabgJbE/hc32EBsfgFFias/HgNN5eDgFbCT
        mL89ACTMIqAisfXoUxYQW1QgQuL+sQ1gt/IKCEqcnPkELM4pYC/RfaYPbDyzgLjErSfzoWx5
        ieats5lB7pEQOMAm8Xv/amaIq10kjqy6BvW0sMSr41vYIWwpiZf9bVB2tcTKk0fYIJo7GCW2
        7L8A1WAssX/pZCaQQ5kFNCXW79KHWMYn8e5rDytIWEKAV6KjTQiiWlni8oO7TBC2pMTi9k42
        CNtD4lv/JGiITmKU2L93JvsERoVZSH6bheSfWUj+mYWweQEjyypGsdSC4tz01GLDAmPk6N7E
        CE6KWuY7GDec8znEKMDBqMTDK3HvVIwQa2JZcWXuIUYJDmYlEd64j0Ah3pTEyqrUovz4otKc
        1OJDjKbAoJ/ILCWanA9M2Hkl8YamRsbGxhYmhmamhoZK4rzrHZxjhATSE0tSs1NTC1KLYPqY
        ODilGhhrbVInav7LDz5flCa4v6iF1Zk7J8U5bs/cVvdL3hV37/Xsub9ejiPk3Gy3H9uLF+Q5
        zAtwrKk0euRyuNhw4he3xhWxZotnpp9Tfd73WWpdTc5Jg2RBtdsnF61cmvk3s9D81DWbqdah
        5yvDMkRWv3B6KXDq9qn4jRJ6tVbCaZ7LVuS+Pi7jYK3EUpyRaKjFXFScCABxqia8oAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvG7T9dMxBq0/dCyW7HrDZnG26Q27
        xefeI4wWtxtXsDmweOy4u4TRo2/LKkaPz5vkApijuGxSUnMyy1KL9O0SuDIutt5kL1jBXrH8
        /hP2Bsa3rF2MnBwSAiYSk77vY+li5OIQEtjNKLFu534WiISkxLSLR5m7GDmAbGGJw4eLIWre
        Mkq0vX4A1iws4CCx7upfJpCEiMA6RonpXf/YIKomMUr0Nx1kBKliE9CS2P/iBhuIzS+gKHH1
        x2NGkKm8AnYS87cHgIRZBFQkth59CrZYVCBC4sz7FWA2r4CgxMmZT8BsTgF7ie4zfUwgNrOA
        usSfeZeYIWxxiVtP5kPF5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFR
        Xmq5XnFibnFpXrpecn7uJkZwFGhp7WA8cSL+EKMAB6MSD6/EvVMxQqyJZcWVuYcYJTiYlUR4
        4z4ChXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTBaV+hf
        sT76Q+iI16Tj53ZxeU+6EdXo9qF3x6w9Qu8+eBeHKsS23U8uTOXkyjp5OyYlJCCabdpPnXXl
        VTZcJU/+cp1Yv99o+osJQvonE5q2Hty0ZfE5HxEOyWW84kcL877zfCm+/9RMROAgs3Vg4Zqn
        N0oTM44ZvY1MZt8emfl3i921rx0H6nYqsRRnJBpqMRcVJwIA0+6jgH4CAAA=
X-CMS-MailID: 20190503055410epcas1p47b62e54945612ab9f13b4a3be4668843
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190502184022epcas5p4f4eb67065f0740a18c46f7a71c908eda
References: <CGME20190502184022epcas5p4f4eb67065f0740a18c46f7a71c908eda@epcas5p4.samsung.com>
        <20190502184013.11836-1-gael.portay@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 5. 3. 오전 3:40, Gaël PORTAY wrote:
> Reorder 'i' and 'v' in "drvier".
> 
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
>  drivers/devfreq/rk3399_dmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index e795ad2b3f6b..0d6d77b1a779 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -336,7 +336,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * Get dram timing and pass it to arm trust firmware,
> -	 * the dram drvier in arm trust firmware will get these
> +	 * the dram driver in arm trust firmware will get these
>  	 * timing and to do dram initial.
>  	 */
>  	if (!of_get_ddr_timings(&data->timing, np)) {
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
