Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA9B12777
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfECGFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 02:05:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21969 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECGFP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 02:05:15 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190503055452epoutp0357e833ea161f281731331fbb3e05a639~bFo1U0t5c0389603896epoutp039
        for <linux-pm@vger.kernel.org>; Fri,  3 May 2019 05:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190503055452epoutp0357e833ea161f281731331fbb3e05a639~bFo1U0t5c0389603896epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556862892;
        bh=bh5XtgQ1qOIEzWQkUMF9WzZzfp+VhQ0jfzAUY192woc=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=m333RpsCP889JU8lfVpcSd57cHWQeIcL3ux3ZzBMMUc1ckp3i8ZuRjxRTrWtzJHwn
         Y5BFLyTOad6LV1c9k6A3A7iPaTSPMTEczJ+XF/vTwhBKEkKfvMr+MgSzh33zDV41cB
         RkKc9NUWV/YUHjPbZ4lukvci4Dnx9Pkz7E93zbWo=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190503055448epcas1p48321277e3d821f6de6163599d611b974~bFoxq3Zue1759217592epcas1p4m;
        Fri,  3 May 2019 05:54:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.2B.04139.6A7DBCC5; Fri,  3 May 2019 14:54:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190503055446epcas1p47a828dc5b5e17f6535ea5b85d29b7039~bFovcPEu62017020170epcas1p4p;
        Fri,  3 May 2019 05:54:46 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190503055446epsmtrp2b9c4d8e42e723295688c0a33414649ad~bFovblQaK0607806078epsmtrp2C;
        Fri,  3 May 2019 05:54:46 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-ed-5ccbd7a6fa82
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.65.03662.5A7DBCC5; Fri,  3 May 2019 14:54:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190503055445epsmtip1063f05784ff627b7cbea21b4603eec63~bFovP_EW-3064830648epsmtip1G;
        Fri,  3 May 2019 05:54:45 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Fix spelling typo
To:     =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <dad0fc34-480e-64c3-38f8-9b5e31210322@samsung.com>
Date:   Fri, 3 May 2019 14:56:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502182736.5587-1-gael.portay@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTV3fZ9dMxBlsWSVss2fWGzeJs0xt2
        i8+9RxgtbjeuYHNg8dhxdwmjR9+WVYwenzfJBTBHZdtkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        pRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRnfDvQw1qwWrii98AExgbG0/xdjJwcEgIm
        Es1n1jB1MXJxCAnsYJR4ufIYG4TziVFi/cOHrBDON0aJhzNeM8G09DfcZYZI7GWUOPbrKlTL
        e0aJjoNXmEGqhIGqnm+YzwJiiwisA6ra5ABiswloSex/cYMNxOYXUJS4+uMxI4jNK2An8XP+
        DLBeFgEVie5Tp8FqRAUiJO4f28AKUSMocXLmE7CZnED1ry51gdUzC4hL3HoynwnClpdo3job
        7DoJgR1sErOe/oI620Viz5+jzBC2sMSr41vYIWwpic/v9rJB2NUSK08eYYNo7mCU2LL/AitE
        wlhi/9LJQIM4gDZoSqzfpQ+xjE/i3dceVpCwhACvREebEES1ssTlB3eh1kpKLG7vhBrvIdFx
        eAM0sCYyStxftYR5AqPCLCS/zULyzywk/8xC2LyAkWUVo1hqQXFuemqxYYEhcnxvYgSnRS3T
        HYxTzvkcYhTgYFTi4ZW4dypGiDWxrLgy9xCjBAezkghv3EegEG9KYmVValF+fFFpTmrxIUZT
        YNBPZJYSTc4Hpuy8knhDUyNjY2MLE0MzU0NDJXHe9Q7OMUIC6YklqdmpqQWpRTB9TBycUg2M
        5Wx1O6Iipjx7se7yM+kpDypv6rJmPE3k2X059LuUwYcE0Q1b39UduZjylWW1svHiWaemMS0u
        uifnrJ0ot31N+iYZ1T+3dRacXrLhB/+X6OM7VRM+KQcnJDydn/vywgWbr19lfJv3mGxdYtF0
        dN2Vdm3L2ek3alOmS1X5NVm5rWZ2u6n95b22nxJLcUaioRZzUXEiAGN75bahAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO6y66djDNrXMlos2fWGzeJs0xt2
        i8+9RxgtbjeuYHNg8dhxdwmjR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGV8O9DDWrBauKL3
        wATGBsbT/F2MnBwSAiYS/Q13mbsYuTiEBHYzSsxoXcUIkZCUmHbxKFCCA8gWljh8uBii5i2j
        xLVvD9hBaoSBmp9vmM8CkhARWMcoMb3rHxtE1URGidmL34FVsQloSex/cYMNxOYXUJS4+uMx
        2AZeATuJn/NnMIPYLAIqEt2nToPViApESJx5v4IFokZQ4uTMJ2A2J1D9q0tdYPXMAuoSf+Zd
        grLFJW49mc8EYctLNG+dzTyBUWgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3i
        xNzi0rx0veT83E2M4DjQ0trBeOJE/CFGAQ5GJR5eiXunYoRYE8uKK3MPMUpwMCuJ8MZ9BArx
        piRWVqUW5ccXleakFh9ilOZgURLnlc8/FikkkJ5YkpqdmlqQWgSTZeLglGpg7HtfKMl0rXnK
        0ekLXENtjIrfWLSL/Vt9vz96s3j+x4DDZcHP/Y5rf174N/qCYIjIwavR7W3KK9Ol9e9wNfQl
        fZQ3erNZbt6LCJNrp6x+FIW+KLGvUnp2fuuz+wvFcxbzh19Zvotzfaa4aYNOu865S2p3Bb5F
        npvJ/dpxfSXPnAX1JxZwZFZvV2Ipzkg01GIuKk4EAMGaYYV/AgAA
X-CMS-MailID: 20190503055446epcas1p47a828dc5b5e17f6535ea5b85d29b7039
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190502182729epcas5p3db445dcd9831a3a623ac3c1a6039e94a
References: <CGME20190502182729epcas5p3db445dcd9831a3a623ac3c1a6039e94a@epcas5p3.samsung.com>
        <20190502182736.5587-1-gael.portay@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 5. 3. 오전 3:27, Gaël PORTAY wrote:
> Add missing 'r' in "monitoing".
> 
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..20d1afa2d474 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
>   * devfreq_monitor_start() - Start load monitoring of devfreq instance
>   * @devfreq:	the devfreq instance.
>   *
> - * Helper function for starting devfreq device load monitoing. By
> + * Helper function for starting devfreq device load monitoring. By
>   * default delayed work based monitoring is supported. Function
>   * to be called from governor in response to DEVFREQ_GOV_START
>   * event when device is added to devfreq framework.
> @@ -418,7 +418,7 @@ EXPORT_SYMBOL(devfreq_monitor_start);
>   * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
>   * @devfreq:	the devfreq instance.
>   *
> - * Helper function to stop devfreq device load monitoing. Function
> + * Helper function to stop devfreq device load monitoring. Function
>   * to be called from governor in response to DEVFREQ_GOV_STOP
>   * event when device is removed from devfreq framework.
>   */
> @@ -432,7 +432,7 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
>   * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
>   * @devfreq:	the devfreq instance.
>   *
> - * Helper function to suspend devfreq device load monitoing. Function
> + * Helper function to suspend devfreq device load monitoring. Function
>   * to be called from governor in response to DEVFREQ_GOV_SUSPEND
>   * event or when polling interval is set to zero.
>   *
> @@ -459,7 +459,7 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>   * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
>   * @devfreq:    the devfreq instance.
>   *
> - * Helper function to resume devfreq device load monitoing. Function
> + * Helper function to resume devfreq device load monitoring. Function
>   * to be called from governor in response to DEVFREQ_GOV_RESUME
>   * event or when polling interval is set to non-zero.
>   */
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
