Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 329E815D323
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgBNHrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:47:11 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47143 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgBNHrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:47:08 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200214074706epoutp04e2ec8b4ba9078f78874d3cedc961adee~zNTwTN3z61159811598epoutp04Q
        for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2020 07:47:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200214074706epoutp04e2ec8b4ba9078f78874d3cedc961adee~zNTwTN3z61159811598epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581666426;
        bh=yIVXWaN11j/KrKNEfkYRph1Tnf0gGKLTiqJyZsYCH6k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PH5YVlnqNDmdranv9pqvWPzNcJVQ0angb8n3fpapqKPZa8BUSLCWV1xowPzJBaDfi
         ZmZtNqTmAc5BgJCdxjkBIthemKFJ19v3QfcliooAfXcb9BPnXrVkIA0h/0Ja/y/u+O
         pLUxPX4ai6+fYRghyI4tp6D/l1BA/rjmGy1TAaO4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200214074705epcas1p35c7b94380b54b5c21af44f9fdf92fb21~zNTwAFotW3161131611epcas1p3N;
        Fri, 14 Feb 2020 07:47:05 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48Jlp06VXbzMqYkh; Fri, 14 Feb
        2020 07:47:04 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.5E.48019.870564E5; Fri, 14 Feb 2020 16:47:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200214074704epcas1p25bad90e85dee5c8a7359e7a511b3d37c~zNTujC5jm1554515545epcas1p29;
        Fri, 14 Feb 2020 07:47:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200214074704epsmtrp26aba628644a3d73c387befbd50d0503a~zNTuiR8P63132131321epsmtrp2q;
        Fri, 14 Feb 2020 07:47:04 +0000 (GMT)
X-AuditID: b6c32a38-6b4789c00001bb93-2a-5e465078575d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.D1.10238.870564E5; Fri, 14 Feb 2020 16:47:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200214074704epsmtip16113a4ecbbd7882e7938c54e8519037f~zNTuUKVUW1216912169epsmtip1b;
        Fri, 14 Feb 2020 07:47:04 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Fix a typo in a comment
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7dd67d22-7fe6-ddfd-0752-a0771365d60d@samsung.com>
Date:   Fri, 14 Feb 2020 16:55:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200214060506.29500-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29mOR2v5tby8LSk9EaGg7qizk2UZpRj5YyUEBW0d9KTD3diZ
        S4vCwqyWWdGNlqJmVyWMpbaktKZQ/lDCG5UkalLSnazoRrXtLPLf8z3v8/C+z/u9FKE4TSop
        vcnGW02cgSZDpG1dsfHxJZosrep+Qyrb+qBGxrY+W8j2HngbxA60V5Ps9LFuxI7sv0ZmkNlV
        LY0oe9q1KHv6ebNMQ2wrWlXIc/m8NZo35Znz9aaCdHpjrm6dTp2qYuKZFexyOtrEGfl0en2O
        Jj5Lb/C2paPtnKHYS2k4QaATV6+ymottfHShWbCl07wl32BZYUkQOKNQbCpIyDMb0xiVKknt
        Fe4oKnzU2CSxVFAlTd/LyTLUTjpQMAU4BRxnvgQ5UAilwG4ErbVHkfj4hMDR0CXzqRT4K4LO
        kd3/HL/rHFJRdA/B5aGygP0DgnpnE/Kp5uM0eHPwF+HDYdgIZ39Weh0UReDt8LRrs48mcRx0
        Tj3xjxGKY2Do2wu/VY5Xw9gld5APS/FSmHj3x4/D8RboaSsPaOZBz/lJqQ8H43XwY7zOzxM4
        Ep5N1kpEvBhuv6smfLMBHiHhtuOPVEywHl5VXZSIeD68ftgSJGIlTL+/F9jLHrje002K5sMI
        Wjofy8RCMnRePiURw8RCc3uiSMfAnZ81gSHmwvsvlTKfBLAcDlcoRMkSGBh7Hmi7ABoOHSFP
        INo5I45zRgTnjAjO/83qkLQRRfAWwVjAC4wlZeZnu5D/IuNYN7rbl+NBmEL0HHlGWqZWIePs
        QqnRg4Ai6DB5V0yWViHP50p381azzlps4AUPUnu3fZJQhueZvfdtsukYdVJycjKbwqSqGYaO
        lI9vjdUqcAFn44t43sJb//kkVLCyDHVUfhrtfblvNhoG1+jK0o69mZ4d43RS/cROiyHq6s76
        /o+3JCvr84glY6PHQze55BVrXZ7P9ERU2nG7vk3bnaiaiPhuV+XSdGZFlftmxoWsKE5YS0zZ
        Xm/YPOtX7+D4jfCzV1wl9uFl+sjgOzp3bAa6PqhRruk7x/aX475dSbRUKOSYOMIqcH8BGw7m
        KKcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG5FgFucwec/ghZbD85ltdh6S9ri
        bNMbdovLu+awWXzuPcJocbtxBZsDm0ffllWMHp83yXl8vrueNYA5issmJTUnsyy1SN8ugSvj
        xKrVTAVtHBWrf7awNTDuYuti5OSQEDCR+Legi6WLkYtDSGA3o8Tb54+gEpIS0y4eZe5i5ACy
        hSUOHy6GqHnLKPGmcy07SI2wgJXE69Y/zCC2iECuRFvTRCaQemaBWIlHaxJBwkIC0xglTj8z
        BLHZBLQk9r+4ATaeX0BR4uqPx4wgNq+AncSDJTvARrIIqEo8evsfzBYVCJPYueQxE0SNoMTJ
        mU9YQGxOAWeJXw8XgPUyC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywk
        LQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgTHipbmDsbLS+IPMQpwMCrx8L4w
        d40TYk0sK67MPcQowcGsJMJ7WNEtTog3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQZG0au34uNqmjMy/l2+ZGHyZmmnelqA2emj3/Rz+r03TTv4Y31J9SSN
        6E2dXxiUDs44/Unwv64Ww/4zOm7T1Kd5nnr8fX2Gov2uhY/jsw9a8O61+79tq1EKH8v5qj2n
        /MPlZwjXGdXfXyHXly/oE9Y3ZUK5+Wsp7Z1SoYFvV0h2G3wO8sr78k5JiaU4I9FQi7moOBEA
        p2pyvJECAAA=
X-CMS-MailID: 20200214074704epcas1p25bad90e85dee5c8a7359e7a511b3d37c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200214060524epcas1p41d689fc376fa4f59d74f66147ce9f1d2
References: <CGME20200214060524epcas1p41d689fc376fa4f59d74f66147ce9f1d2@epcas1p4.samsung.com>
        <20200214060506.29500-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/14/20 3:05 PM, Christophe JAILLET wrote:
> 'govenror' was used in place of 'governor'
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/devfreq/governor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index c07ce77c253d..ae4d0cc18359 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -30,7 +30,7 @@
>   * @node:		list node - contains registered devfreq governors
>   * @name:		Governor's name
>   * @immutable:		Immutable flag for governor. If the value is 1,
> - *			this govenror is never changeable to other governor.
> + *			this governor is never changeable to other governor.
>   * @interrupt_driven:	Devfreq core won't schedule polling work for this
>   *			governor if value is set to 1.
>   * @get_target_freq:	Returns desired operating frequency for the device.
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
