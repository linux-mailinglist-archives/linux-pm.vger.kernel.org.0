Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCCD8127123
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLSXD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 18:03:56 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:30403 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSXD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 18:03:56 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191219230353epoutp0388e4f74b6f56e96e2b2ab9e838ef6bcc~h6C8eG-5H2002720027epoutp03m
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 23:03:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191219230353epoutp0388e4f74b6f56e96e2b2ab9e838ef6bcc~h6C8eG-5H2002720027epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576796633;
        bh=ExdKVAXgbgQTjjhDCfChCkhQSmIxv86ZOAXt2nZx2is=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hO/I+c65w7L+zgsJhxJd+gE79wgpVCefpjUugw4x9zMXdtYT08EQFAuDruESUh0N7
         gKG8h0jQH469vgkWG+Pjj+NrRYtbJ6CqDbSFX7lsa4a8d3uTklvMpVaOT2WLBJ8vLq
         OD6AdLAvs2B61Ubgdpo16mH++EqU6FTIsoGkbunU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191219230353epcas1p4d306ad44dc3d2f33852d2f99f834aac5~h6C8Cr3ZG2203822038epcas1p4k;
        Thu, 19 Dec 2019 23:03:53 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47f6r575kszMqYlp; Thu, 19 Dec
        2019 23:03:49 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.33.48498.5D10CFD5; Fri, 20 Dec 2019 08:03:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191219230349epcas1p336ce638e09e2ed68852cce556dfb5429~h6C4w3CU91907919079epcas1p3B;
        Thu, 19 Dec 2019 23:03:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191219230349epsmtrp21676f12cfea754e68c9b0ad7370dcfd3~h6C4wLFlW2882328823epsmtrp2J;
        Thu, 19 Dec 2019 23:03:49 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-45-5dfc01d57dcf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.F7.06569.5D10CFD5; Fri, 20 Dec 2019 08:03:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191219230349epsmtip1fe0a72851a116d14b7b4e97d9cbcef9e~h6C4kORpB1097610976epsmtip1h;
        Thu, 19 Dec 2019 23:03:49 +0000 (GMT)
Subject: Re: [v8 PATCH] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        leonard.crestez@nxp.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6c00b0d8-af71-b211-d5bb-87c48e5d5db5@samsung.com>
Date:   Fri, 20 Dec 2019 08:10:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191219230919.16037-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmge5Vxj+xBov3m1vMP3KO1eJs0xt2
        ixV3P7JaXN41h83ic+8RRovbjSvYHNg8Nr7bweTRt2UVo8fnTXIBzFHZNhmpiSmpRQqpecn5
        KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RknDhxhL1giULGkYzlj
        A2MLdxcjB4eEgIlE23OBLkYuDiGBHYwSR1ftZ4ZwPjFKdMz5yALhfGOUOH/1PytMx5nVgRDx
        vYwS9/80MEE47xklmpatAyri5BAWCJGYtOoTO4gtIiAjMfXKflaQImaBHkaJzd9+M4Mk2AS0
        JPa/uMEGYvMLKEpc/fGYEcTmFbCT+NTVDWazCKhKTO9cD1YvKhAmcXJbC1SNoMTJmU9YQGxO
        AWuJTxdPgsWZBcQlbj2ZzwRhy0tsfzsHrFdC4DabxIdbNhC2i0T3h0vsELawxKvjW6BsKYnP
        7/ayQdjVEitPHmEDOVpCoINRYsv+C6wQCWOJ/UsnM4GCgllAU2L9Ln2IsKLEzt9zoW7gk3j3
        tQcaWrwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF5JtZSD6YheSDWQjLFjCyrGIUSy0ozk1P
        LTYsMEKO7E2M4CSpZbaDcdE5n0OMAhyMSjy8Dmm/Y4VYE8uKK3MPMUpwMCuJ8N7u+BkrxJuS
        WFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBCTyvJN7Q1MjY2NjCxNDM1NBQSZyX48fFWCGB9MSS
        1OzU1ILUIpg+Jg5OqQbGnu/7Tn375GuvbaAYdnH2srNXtzTM/qx5sqLD8u5th5dcD223LZ3Z
        nPpm+e7Zl7QvzWu3Ualb8mTlMc9LP7u02uKiAmYdlPDyZLhXbHSm1Tk0buqDPDP+5eu+Op62
        On7emu16wIuvWQejI3Kmc++weLC7xlPrm5f2kf1/e+JcBPUPh5a9vbjIXImlOCPRUIu5qDgR
        AEo+HuKoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJTvcq459Yg/6JKhbzj5xjtTjb9Ibd
        YsXdj6wWl3fNYbP43HuE0eJ24wo2BzaPje92MHn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xokDR9gLlghULOlYztjA2MLdxcjBISFgInFmdWAXIxeHkMBuRok7F5azdjFyAsUlJaZdPMoM
        USMscfhwMUTNW0aJ/2svsYDUCAuESExa9YkdxBYRkJGYemU/WC+zQA+jxM/r6hANjxgluje3
        gBWxCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfxqasbzGYRUJWY3rmeGcQWFQiT2LnkMRNEjaDE
        yZlPwBZzClhLfLp4khFimbrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELS
        soCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnC8aGntYDxxIv4QowAHoxIPr0Pa
        71gh1sSy4srcQ4wSHMxKIry3O37GCvGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliS
        mp2aWpBaBJNl4uCUamCcuHEWb61dr/KrO7y5K6ob/m7oKl+84+OP8sfql94I5y3cMfe72/fY
        x+tklNYeDeldt/rsVtFfitUi9W8ufZ/Wb7KvXtT4raKw1MOfNk0L1NQ2dPyaaHNAQayJaWPd
        h0i/R7kX720pcz1i8tj/oLSV2MsDb7tvsj5b9Phexzfuw87fYj51pjxoUmIpzkg01GIuKk4E
        AMFr6fCTAgAA
X-CMS-MailID: 20191219230349epcas1p336ce638e09e2ed68852cce556dfb5429
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c
References: <c0b332b85560e39d7dbb5e88b99bbed1d1b32373.1574458460.git.leonard.crestez@nxp.com>
        <CGME20191219230258epcas1p16ec64c3a06eafd9f0a3784d18541ce5c@epcas1p1.samsung.com>
        <20191219230919.16037-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/20/19 8:09 AM, Chanwoo Choi wrote:
> From: Leonard Crestez <leonard.crestez@nxp.com>
> 
> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
> frequency switching is implemented inside TF-A, this driver wraps the
> SMC calls and synchronizes the clk tree.
> 
> The DRAM clocks on imx8m have the following structure (abridged):
> 
>  +----------+       |\            +------+
>  | dram_pll |-------|M| dram_core |      |
>  +----------+       |U|---------->| D    |
>                  /--|X|           |  D   |
>    dram_alt_root |  |/            |   R  |
>                  |                |    C |
>             +---------+           |      |
>             |FIX DIV/4|           |      |
>             +---------+           |      |
>   composite:     |                |      |
>  +----------+    |                |      |
>  | dram_alt |----/                |      |
>  +----------+                     |      |
>  | dram_apb |-------------------->|      |
>  +----------+                     +------+
> 
> The dram_pll is used for higher rates and dram_alt is used for lower
> rates. The dram_alt and dram_apb clocks are "imx composite" and their
> parent can also be modified.
> 
> This driver will prepare/enable the new parents ahead of switching (so
> that the expected roots are enabled) and afterwards it will call
> clk_set_parent to ensure the parents in clock framework are up-to-date.
> 
> The driver relies on dram_pll dram_alt and dram_apb being marked with
> CLK_GET_RATE_NOCACHE for rate updates.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> [cw00.choi: Edit the COMPILE_TEST module dependency in Kconfig]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v7:
> - Squash patch[1] to this patch
> [1] https://patchwork.kernel.org/patch/11303869/
> - [PATCH] PM / devfreq: imx8m-ddrc: Fix argument swap in error print

Applied it.

(snip)


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
