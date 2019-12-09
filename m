Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41C60116549
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 04:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfLIDTM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Dec 2019 22:19:12 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:21918 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfLIDTM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2019 22:19:12 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191209031909epoutp01d39e279d3ea2e5324acd03c0d022f5d2~elbrbfYln0212802128epoutp01J
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 03:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191209031909epoutp01d39e279d3ea2e5324acd03c0d022f5d2~elbrbfYln0212802128epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575861549;
        bh=Q3QpsGU7jR1eweE5LBcgNQBomTOvpKjfljutEUtPZPA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OIvemKyQIcZYdL4T84J+QQBj2BuvZ1Xtkrr+Kjqxta/XS3feXuUysGOCm1Gy+Qens
         LYicZL0uRWLrzSByFDUfkWPIlL8YpIsGc30eTH46EMoLSu7sAE+PTZMW0uDUnZEjgn
         +88rzumDAa9ly/mXObdPonXUbseZF5aFzUBlallI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191209031908epcas1p3f840e8a008403571a529bad6bdaa20bf~elbqoAce10221502215epcas1p3C;
        Mon,  9 Dec 2019 03:19:08 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47WT1k237TzMqYll; Mon,  9 Dec
        2019 03:19:06 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.F1.48019.A2DBDED5; Mon,  9 Dec 2019 12:19:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191209031905epcas1p30d78cf7bb8ed064966b11ad4b4de4e66~elbn-FL7j3035330353epcas1p31;
        Mon,  9 Dec 2019 03:19:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191209031905epsmtrp1bbe32affe15183b207d5a36ef774f975~elbn_UO2l0937109371epsmtrp1e;
        Mon,  9 Dec 2019 03:19:05 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-04-5dedbd2af25e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.57.06569.92DBDED5; Mon,  9 Dec 2019 12:19:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209031905epsmtip27caa03d735e61fba5a8b5b11355551af~elbnruT3r2189121891epsmtip2E;
        Mon,  9 Dec 2019 03:19:05 +0000 (GMT)
Subject: Re: [PATCH] devfreq: move declaration of DEVICE_ATTR_RW(min_freq)
To:     Kamil Konieczny <k.konieczny@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c2b9991e-212c-5ba5-a160-36d698e31bee@samsung.com>
Date:   Mon, 9 Dec 2019 12:25:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191206101129.15232-1-k.konieczny@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29nOjtbya2W92W2dgthiupMuj9YiKkrLQAj6Ucx10tM0d2Nn
        M7vSVU2qJUHpsgupZFqZssyksNYgBpWKFZVJN4MM190KimjbMfLf8z7f8z7v+3zfRxHK02QC
        VWBz8U4bZ6HJWGnrHbVOq7kZMup8NXFsc2WTjD37pVLGdnZekbP39w7K2Z72apL9ejiA2EuB
        Pjnbu6eeXExltDQcJDOO+BpQxteW6dnEusKF+TyXxztVvC3XnldgMxvoVWtMS036+TpGy6Sx
        qbTKxll5A70sK1u7vMAS3oBWFXEWd5jK5gSBTlq00Gl3u3hVvl1wGWjekWdxpDkSBc4quG3m
        xFy7NZ3R6ebpw8INhfmvX9TIHcHRxRcbJu9GzTHlKIYCnAJXGq/Ky1EspcRtCPx/9knE4guC
        z92PZWLxHcGesh+yfy3Hf99CEazENxFcrlkqij4iKKl9R0YOxuOV4OkakETwBKyFwbY6IiIi
        8GkJDB7vijqRWAMd755EG+LwTHj0803UVYEXQfP5UFhDUVI8G2p7cyJ0PF4Lwdb9w5JxEKzq
        l0ZwDDZA873yKE/gSfCs/4xExDPgWqg6OhfwRxI8VeekEU/Ay+Dh5ylimPHw/q5PLuIEGPCU
        DOPtcCEYIMXeMgS+jq7h9MnQUXdMEvEhsBqa2pNEeiZc/3VqeIex8GHokEwcpYCyEqUomQU9
        L/skIp4MNaUHyaOI9o5I4x2RwDsigff/sLNI2oAm8g7BauYFxpEy8q1bUPRvatg2dONBlh9h
        CtFjFKr0kFEp44qErVY/AoqgJyhqK94blYo8bus23mk3Od0WXvAjffiuK4iE+Fx7+KfbXCZG
        Py85OZlNYebrGYaepKB+dhuV2My5+EKed/DOf30SKiZhN/IqBmSZu1b7G01DmXHpwjHDPsOT
        U9vq8Ma3meoD0yzxC3YUN52Qf08tKEXyFeWpW3Zu7qz2JAaWt26uyLlcVLXWaNa/HapvXd1/
        bUN37O1KTWna4cDd3pev5q6oCK4vHkVkKTeFtOynnD7TNzA8X9LufiZ9vnjHVE+a+uTTXp96
        Di0V8jlGQzgF7i+YtiFNsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJXldz79tYg2VNqhYbZ6xntVjwaQar
        xfnzG9gtzja9Ybe4vGsOm8Xn3iOMFmuP3GW3uN24gs2Bw2PTqk42j74tqxg9Pm+SC2CO4rJJ
        Sc3JLEst0rdL4Mp4dH8xe8FJ7oo1qyQbGDdydjFyckgImEhM+3OAsYuRi0NIYDejxMo/U5gh
        EpIS0y4eBbI5gGxhicOHi0HCQgJvGSX2d+WD2MICXhL9F14ygdgiAroSb3YsZQaZwyywgEli
        /s2JLBBDJzBK/Hp+iRGkik1AS2L/ixtsIDa/gKLE1R+PweK8AnYSG5e/ZQVZxiKgIrHkdhxI
        WFQgTGLnksdMECWCEidnPmEBsTkFbCU2nukCa2UWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwT
        GIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4gLa0d
        jCdOxB9iFOBgVOLhVbB6GyvEmlhWXJl7iFGCg1lJhHfJxFexQrwpiZVVqUX58UWlOanFhxil
        OViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhgbDpxP4nnOky9199TK4wem7XP7Ka/yV+Xu
        go3urgUdDks3zFle8GXC729T957RFLEKtHu1P/W2zfTzq15PMNrZXFJrske1YL3h/+s3n9jJ
        rHylX6/gYGuXMTV6rc+VR1aKe+epai43dK+LPqZbZn48wvv2gz/687Maj39V4bvJs6Vew7Ui
        315HiaU4I9FQi7moOBEArTJX45wCAAA=
X-CMS-MailID: 20191209031905epcas1p30d78cf7bb8ed064966b11ad4b4de4e66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d
References: <CGME20191206101145eucas1p26ed05a4d6d805c26c8ad92ad6b602f9d@eucas1p2.samsung.com>
        <20191206101129.15232-1-k.konieczny@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kamil,

Looks good to me. Applied it.

On later, better to add 'PM / ' prefix for patch title
and use capital char for first word as following:

devfreq: move declaration of DEVICE_ATTR_RW(min_freq)
-> PM / devfreq: Move declaration of DEVICE_ATTR_RW(min_freq)

On 12/6/19 7:11 PM, Kamil Konieczny wrote:
> Declaration of DEVICE_ATTR_RW(min_freq) is placed after function
> max_freq_store. Move it to the correct place after min_freq_show.
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1786a86b1779..46a7ff7c2994 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1368,6 +1368,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
>  
>  	return sprintf(buf, "%lu\n", min_freq);
>  }
> +static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  			      const char *buf, size_t count)
> @@ -1391,7 +1392,6 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>  
>  	return count;
>  }
> -static DEVICE_ATTR_RW(min_freq);
>  
>  static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
