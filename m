Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9166219D00B
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgDCGMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 02:12:07 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33381 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCGMG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 02:12:06 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200403061203epoutp042285d27da057d121ebe7d99274e7b730~COnwokQA12498224982epoutp04c
        for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2020 06:12:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200403061203epoutp042285d27da057d121ebe7d99274e7b730~COnwokQA12498224982epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585894323;
        bh=fZCfQRHeOXh0nkC8yiqwSIyweIhypVCIQ+CoI9WIkO4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BhvjXEz0BSR236XY52+1VEJHo9ScPcGcHCCM2XGLkCTCe2JvthoUkLNsfhL6h3GFs
         XxetqxDgzL+pk97r55UOnbEJincvE23uua2qGw9lBPIn5dxOA9xOIWduzdMtCkQX3T
         p1UhanlZ0CfFsVjzYdSms4eQnTmG2Y2Yzg6n7wAU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200403061203epcas1p28c033be108a180aa8f5efcdc3755cbc1~COnwIHJ2z2668526685epcas1p2d;
        Fri,  3 Apr 2020 06:12:03 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 48tqMh4lcfzMqYkf; Fri,  3 Apr
        2020 06:12:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.52.04648.8A3D68E5; Fri,  3 Apr 2020 15:11:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200403061152epcas1p30223ef1f198ea55f229afda8fb351ed3~COnmFA30b1198911989epcas1p3S;
        Fri,  3 Apr 2020 06:11:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200403061152epsmtrp23b7eda0cb9f8ceb29bd34619544b8df4~COnmEM1ez2852328523epsmtrp2I;
        Fri,  3 Apr 2020 06:11:52 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-92-5e86d3a85d7b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.E8.04024.8A3D68E5; Fri,  3 Apr 2020 15:11:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200403061152epsmtip2fd88b0f89267b299cdbf311c83b65f1d~COnl1pMdN0914109141epsmtip2M;
        Fri,  3 Apr 2020 06:11:52 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: tegra30: Make CPUFreq notifier to take
 into account boosting
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <705e0c78-30ef-978d-c63d-b6dc90e6e5e4@samsung.com>
Date:   Fri, 3 Apr 2020 15:20:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200402222448.8320-1-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmru6Ky21xBifmW1is/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8WBw2PnrLvsHr3N79g8+rasYvT4vEku
        gCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBh
        QnbG3tfT2AsO8VbsWfiesYHxF1cXIyeHhICJxJ0pb1i6GLk4hAR2MEo8e9DNCOF8YpS4v2QD
        G4TzjVFi/Z1pjDAtu2YsZIJI7GWUuLLvADuE855R4viSuWBVwgIpEr2rNrOCJEQELjNKLF30
        mgkkwSwQKXF452owm01AS2L/ixtsIDa/gKLE1R+PwZp5Bewkvs78CVbDIqAi8ejVFhYQW1Qg
        TOLkthaoGkGJkzOfgMU5BUwlTu3ZyAgxX1zi1pP5ULvkJba/ncMMcoSEwGc2iYn3p7JC/OAi
        saL9FRuELSzx6vgWdghbSuLzu71Q8WqJlSePsEE0dzBKbNl/AarZWGL/0slAGziANmhKrN+l
        DxFWlNj5ey7UEXwS7772sIKUSAjwSnS0CUGUKEtcfnCXCcKWlFjc3sk2gVFpFpJ3ZiF5YRaS
        F2YhLFvAyLKKUSy1oDg3PbXYsMAYOb43MYITqZb5DsYN53wOMQpwMCrx8DIcbI0TYk0sK67M
        PcQowcGsJMLrOAMoxJuSWFmVWpQfX1Sak1p8iNEUGNoTmaVEk/OBST6vJN7Q1MjY2NjCxNDM
        1NBQSZx36vWcOCGB9MSS1OzU1ILUIpg+Jg5OqQbGGoMnMpbmPNWb58Wf4VO9olsWZc+7zk8r
        5oLGPz+Xs4Xss+fGPfb5Mi+q8roU19Kyij3r1H7vkNvEVBOl+yj3g19/yQt3++I5whumN931
        uPXJ6L6L2m7NN18Wx9/cXHX273Pt9JPbG9uubu85Nsn9r8IvGf1H5SUnD0corLDIS6sN+aTs
        /PiNEktxRqKhFnNRcSIA2qT2SroDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO6Ky21xBstuCFqs/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8WBw2PnrLvsHr3N79g8+rasYvT4vEku
        gCWKyyYlNSezLLVI3y6BK2Pv62nsBYd4K/YsfM/YwPiLq4uRk0NCwERi14yFTF2MXBxCArsZ
        JV6u/8UGkZCUmHbxKHMXIweQLSxx+HAxSFhI4C2jxMnb/iC2sECKRO+qzawgvSICVxklFh6+
        yAiSYBaIlOiZu4UNYmgHo8TOy9/AhrIJaEnsf3EDzOYXUJS4+uMxWAOvgJ3E15k/mUBsFgEV
        iUevtrCA2KICYRI7lzxmgqgRlDg58wlYnFPAVOLUno1Qy9Ql/sy7xAxhi0vcejKfCcKWl9j+
        dg7zBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLj
        SUtzB+PlJfGHGAU4GJV4eBkOtsYJsSaWFVfmHmKU4GBWEuF1nAEU4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzvs071ikkEB6YklqdmpqQWoRTJaJg1OqgXHakfpv3ktOZL6b3nNy5rPN+SeeGPbO
        NXJVbDVcIa3U80QuraPER3PjfUezyd/U1y5R062fdiZfoEO4LEPuduCDXYEn+Ko67NLchE8Y
        J0y9Xr/u0NvCMN2a53rZXmnzdHcoGBiHL2d84L9wz7NDvhwvPn37c09Nb1OCZ4jI0m03zJpz
        HMIXyymxFGckGmoxFxUnAgAoDPjnowIAAA==
X-CMS-MailID: 20200403061152epcas1p30223ef1f198ea55f229afda8fb351ed3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200402222645epcas1p499a7ebecb0dcd60a7b2e5960790de4e9
References: <CGME20200402222645epcas1p499a7ebecb0dcd60a7b2e5960790de4e9@epcas1p4.samsung.com>
        <20200402222448.8320-1-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/3/20 7:24 AM, Dmitry Osipenko wrote:
> We're taking into account both HW memory-accesses + CPU activity based on
> current CPU's frequency. For memory-accesses there is a kind of hysteresis
> in a form of "boosting" which is managed by the tegra30-devfreq driver.
> If current HW memory activity is higher than activity judged based of the
> CPU's frequency, then there is no need to schedule cpufreq_update_work
> because the result of the work will be a NO-OP. And thus,
> tegra_actmon_cpufreq_contribution() should return 0, meaning that at the
> moment CPU frequency doesn't contribute anything to the final decision
> about required memory clock rate.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> 
> Changelog:
> 
> v2: - Made commit's message more detailed, which was requested by Chanwoo Choi
>       in the review comment to v1.
> 
>     - This patch is now made to be standalone because there are no dependencies
>       in regards to this change.
> 
>  drivers/devfreq/tegra30-devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 28b2c7ca416e..dfc3ac93c584 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -420,7 +420,7 @@ tegra_actmon_cpufreq_contribution(struct tegra_devfreq *tegra,
>  
>  	static_cpu_emc_freq = actmon_cpu_to_emc_rate(tegra, cpu_freq);
>  
> -	if (dev_freq >= static_cpu_emc_freq)
> +	if (dev_freq + actmon_dev->boost_freq >= static_cpu_emc_freq)
>  		return 0;
>  
>  	return static_cpu_emc_freq;
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
