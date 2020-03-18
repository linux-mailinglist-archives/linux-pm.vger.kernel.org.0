Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF181894B8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 04:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgCRD7o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 23:59:44 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:58076 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRD7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 23:59:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200318035942epoutp045282733ad658df0356ad7d6b91209dec~9SfoIjN_M3104131041epoutp044
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2020 03:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200318035942epoutp045282733ad658df0356ad7d6b91209dec~9SfoIjN_M3104131041epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584503982;
        bh=rF8Nc0FWRFNClr9CXh8EhzVicDOxmlCv3lRGhO6uRZo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ssscSuh9NNYws0B+TZPJ2A6SMa58V1nqI/WQMCThccEzo3sLn4eBX4pf03oVZRAkg
         Scav6csX2FvPLdezI6x2gGOSZlJb58qv61uacxTs37hgP+oiXdhVQ1GucjZTLMYnou
         uS6AmM3Pzw8CAB2vZssksQniuZcstD4189qXbttc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200318035941epcas1p1e5ee90d94474aa52e0836c5afb299c1f~9SfnpI-0m0291402914epcas1p1N;
        Wed, 18 Mar 2020 03:59:41 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48hxBM0hM0zMqYlm; Wed, 18 Mar
        2020 03:59:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.23.04160.7AC917E5; Wed, 18 Mar 2020 12:59:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200318035934epcas1p2acdad1d395c836b1373d54c24946cd35~9SfhAJUbk0508705087epcas1p2f;
        Wed, 18 Mar 2020 03:59:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200318035934epsmtrp1eab0046e05c779b4ebad09fb6ca22f03~9Sfg-dJgd1081810818epsmtrp1O;
        Wed, 18 Mar 2020 03:59:34 +0000 (GMT)
X-AuditID: b6c32a38-2afff70000001040-dd-5e719ca774e6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.C3.04024.6AC917E5; Wed, 18 Mar 2020 12:59:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200318035934epsmtip27b4925559b8914c6ef4d83ab523de86c~9Sfg0H0e31728917289epsmtip2V;
        Wed, 18 Mar 2020 03:59:34 +0000 (GMT)
Subject: Re: [PATCH 05/17] devfreq: devfreq.h: get rid of some doc warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <430fe26d-8fcb-3f71-91d1-46ccbd8146ef@samsung.com>
Date:   Wed, 18 Mar 2020 13:08:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <c013b308c08b47d1208c22362ec1034ac148c1b6.1584456635.git.mchehab+huawei@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+Xm3uyktfy7Tk3+U3ugPJW23Ob091CIpSwOpKAjSXdxt2p7u
        btGDwKR09vAt5FKzlqYGPczKpFqYFJK9MCnMUNHeZZkVZZFtu4v873PO+R7O+f5+R0rIT5Jh
        0hyjlbMYWT1FBoiu3I6MiT5Tk5uhuHaJYEZvFSLmfv4HCXOy4LSI6e2oIZmJo12IGT7eh5jn
        +5vIFZKU1pYiMsVZXCFOKW5rQSkTrXPTRVt1y7M5VsNZwjljlkmTY9QmUKkbM1dlquIUdDS9
        hImnwo2sgUugktPSo1fn6N0bUOE7Wb3NnUpneZ5alLjcYrJZufBsE29NoDizRm9eYo7hWQNv
        M2pjskyGpbRCsVjlFqp12d32SYm5MWjXz0vHUB4qmXkI+UsBx8LnoXt+HpbjdgSvhhceQgFu
        /oJgYmxCLATfEdT1NxP/Ohxd+Ugo3EDgun1OJASfEDx/c5j0qGbhVCh9NeTlYKyD8frLpEdE
        4DYEv4veI0+BxFHgevPMKwrEEdD3Y8Sbl+FEGKic9LIIL4DBZ3VezWy8GbqvHPBpgqC7elTk
        YX+shrcNT7x5AodC/+gJP4HnwdWPNYRnMODXJLx/VO4neEiGb4WPfTwL3t1tkwgcBm9LCny8
        F5q7u0ih2Y6gzfVILBSU4GqocDdL3RMi4XzHIiEdAdd+1fqWmAlj346IPRLAMrAXyAXJfOgd
        euEbOwechUVkKaIc0+w4pllwTLPg+D+sHolaUAhn5g1ajqfNsdO/uxV5zzOKaUfXH6R1IixF
        1AyZ9II5Qy5md/K7DZ0IpAQVLHPmmjLkMg27ew9nMWVabHqO70Qq92uXEWGzs0zuYzdaM2nV
        YqVSycTScSqapkJlVU/1GXKsZa2cjuPMnOVfn5/UPywPnVpTW77j3cLYwUhnWe+2quG5UesO
        OoLXVkOfHStt7f0Dq0JOTWklPSH3S59c7yB7voc+dN48unbEftF6tVH9Yd/KpDu6urJx9dTZ
        yi2a4ZJBV89SdcgyFOhoaogbDMg/PxKfRo6b0hXrU1MTNvzxr96U9HIs6W78V2o7WyZ+2RxA
        ifhslo4iLDz7FzrWphu0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXnfZnMI4g8bD4hZPDrQzWpxtesNu
        sbBtCYvF5V1z2Cw+9x5htHg4+yqjxe3GFWwO7B6bVnWyeSzum8zq0bdlFaPH501yASxRXDYp
        qTmZZalF+nYJXBknO36xFywTrPi5eQZjA2M/XxcjJ4eEgInErCNNjCC2kMBuRol/HdkQcUmJ
        aRePMncxcgDZwhKHDxd3MXIBlbxllOi9eo0FpEZYwFtiwrMHbCC2iEC2xKJr08DizAJbGCUa
        dyZCNDxjlLh35Bs7SIJNQEti/4sbYA38AooSV388BlvMK2AncWfKLzCbRUBV4v6NeWA1ogJh
        EjuXPGaCqBGUODnzCdgCToEEiZdLrzBCLFOX+DPvEjOELS5x68l8JghbXmL72znMExiFZyFp
        n4WkZRaSlllIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOIS3NHYyXl8Qf
        YhTgYFTi4U3YVBAnxJpYVlyZe4hRgoNZSYR3cWF+nBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        p3nHIoUE0hNLUrNTUwtSi2CyTBycUg2MLOJTXzov91r0aXbKxNCjdm/K9ztcKP73/k9r0knN
        67K3gk/6nUien3pGNlrT/3b1pXn9WxaWfw29XXzyi+IvFx0RXufp1w4Xzu5ZHWf7oGqStVtf
        so6ww13N/ICIl5eMJ2xaediopK+gvux+kXX9XBduDS1ep9J/Tgsln/T1Op13O+U8R+66Ektx
        RqKhFnNRcSIAUqOZG50CAAA=
X-CMS-MailID: 20200318035934epcas1p2acdad1d395c836b1373d54c24946cd35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200317145506epcas1p4fe623186134d80a24d32b9f91fb24804
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <CGME20200317145506epcas1p4fe623186134d80a24d32b9f91fb24804@epcas1p4.samsung.com>
        <c013b308c08b47d1208c22362ec1034ac148c1b6.1584456635.git.mchehab+huawei@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/17/20 11:54 PM, Mauro Carvalho Chehab wrote:
> Mark "void *data" as literal, in order to avoid those doc warnings:
> 
> 	./include/linux/devfreq.h:156: WARNING: Inline emphasis start-string without end-string.
> 	./include/linux/devfreq.h:259: WARNING: Inline emphasis start-string without end-string.
> 	./include/linux/devfreq.h:279: WARNING: Inline emphasis start-string without end-string.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/devfreq.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 82630fafacde..57e871a559a9 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -158,7 +158,7 @@ struct devfreq_stats {
>   * functions except for the context of callbacks defined in struct
>   * devfreq_governor, the governor should protect its access with the
>   * struct mutex lock in struct devfreq. A governor may use this mutex
> - * to protect its own private data in void *data as well.
> + * to protect its own private data in ``void *data`` as well.
>   */
>  struct devfreq {
>  	struct list_head node;
> @@ -256,7 +256,7 @@ struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev, int index);
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>  /**
> - * struct devfreq_simple_ondemand_data - void *data fed to struct devfreq
> + * struct devfreq_simple_ondemand_data - ``void *data`` fed to struct devfreq
>   *	and devfreq_add_device
>   * @upthreshold:	If the load is over this value, the frequency jumps.
>   *			Specify 0 to use the default. Valid value = 0 to 100.
> @@ -276,7 +276,7 @@ struct devfreq_simple_ondemand_data {
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
>  /**
> - * struct devfreq_passive_data - void *data fed to struct devfreq
> + * struct devfreq_passive_data - ``void *data`` fed to struct devfreq
>   *	and devfreq_add_device
>   * @parent:	the devfreq instance of parent device.
>   * @get_target_freq:	Optional callback, Returns desired operating frequency
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
