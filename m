Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5567441F
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 05:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfGYDvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 23:51:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:48772 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390133AbfGYDvi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 23:51:38 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190725035136epoutp03b3b8318be86c6169ccb77488df8715ad~0if5TyHf21230712307epoutp03m
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190725035136epoutp03b3b8318be86c6169ccb77488df8715ad~0if5TyHf21230712307epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564026696;
        bh=qTrI9+HWCJEJXvAm5+OfcfASWfk5axEuKDIGAGVkh2U=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=oblSu7qvVOZjh2leOL48MJJR0covdZqPFb40j6rpDkaivk3lZQoUZ8U/TTQlCd4oH
         y3+++4b+z7Oh/u6ihNKCwbzSBjtE06oP6u7+SvOjQHTLswAY79g+Qo4gC0lo1rjbfZ
         LOFlLNJwLiFJ2wvIwCpJCI4ckxVG+WJOZPI1AU1U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190725035135epcas1p33010efd4a7bdbd71d5e889f9129b67b1~0if4vntQ02588825888epcas1p3R;
        Thu, 25 Jul 2019 03:51:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45vJDQ0NFLzMqYkR; Thu, 25 Jul
        2019 03:51:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.E5.04066.547293D5; Thu, 25 Jul 2019 12:51:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725035132epcas1p1ae2e5efb3a8e49abeb5606a81ba41cf4~0if2YaG_K2180421804epcas1p13;
        Thu, 25 Jul 2019 03:51:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190725035132epsmtrp19a6b04ec17ea92ae98733f8ecec45a26~0if2XuXoN1215612156epsmtrp1M;
        Thu, 25 Jul 2019 03:51:32 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-7e-5d3927452dfd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.01.03638.447293D5; Thu, 25 Jul 2019 12:51:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190725035132epsmtip2aefeaa6e44b2af2528327a2769b385e8~0if2OJqEL2652426524epsmtip2C;
        Thu, 25 Jul 2019 03:51:32 +0000 (GMT)
Subject: Re: [PATCH] devfreq: Correct devm_devfreq_remove_device()
 documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4006b5d7-7256-43af-d9ec-a9c8373d9f34@samsung.com>
Date:   Thu, 25 Jul 2019 12:54:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724185953.17545-1-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmrq6bumWswd0JTBbnz29gtzjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsWlVJ5tH35ZVjB6fN8kFMEdl22SkJqakFimk5iXnp2Tmpdsq
        eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhkaGBiZAhUmZGe0nT/NWvCcveLGVYsGxv1sXYyc
        HBICJhLz2m8ydTFycQgJ7GCU2D7rCTOE84lR4sikJhYI5xujxJbP29hhWp5OfMIGkdjLKLFm
        2xGolveMEhvPfQcbLCwQJHH0yD52kISIwE5GibbuC8wgCTYBLYn9L26AFfELKEpc/fGYEcTm
        FbCTOHf5K1icRUBVYt6iiUwgtqhAhMSnB4dZIWoEJU7OfMICYnMKmEqcenQGrIZZQFzi1pP5
        ULa8RPPW2WAXSQgcYJPY+mAxC8TdLhJPN3+BeltY4tXxLVD/SEm87G+DsqslVp48wgbR3AH0
        9P4LrBAJY4n9SycDbeAA2qApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzg
        LhOELSmxuL0T6gQPiZk/37BOYFScheS1WUjemYXknVkIixcwsqxiFEstKM5NTy02LDBGju5N
        jOD0qGW+g3HDOZ9DjAIcjEo8vBxJFrFCrIllxZW5hxglOJiVRHgDG8xihXhTEiurUovy44tK
        c1KLDzGaAkN+IrOUaHI+MHXnlcQbmhoZGxtbmBiamRoaKonzLvwBNEcgPbEkNTs1tSC1CKaP
        iYNTqoGxRKRwev4Krm/l15eJVO/ITfl2do/9Sz0bQdsFdbrrNJc1T/vzZtuj4qc6QkUSJ2/t
        3s0pc6alMfvqzR25k3cbZ73IMHi1ujDN2mnb0bhdntnyb50YpywIWxvmmiPDG1FU+ybzWtX1
        Pw0z2/5HHGr3PTAx+srhzcLBX2dwPWd5Ws96sPGs2rcjSizFGYmGWsxFxYkAVtt6BaUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvK6LumWswY1dBhbnz29gtzjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsWlVJ5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZbSdP81a
        8Jy94sZViwbG/WxdjJwcEgImEk8nPgGyuTiEBHYzSux6fZwJIiEpMe3iUeYuRg4gW1ji8OFi
        iJq3jBLLtnxiB6kRFgiSOHpkHztIQgSk+cvhTmaQhJBAB6PEmuNgNpuAlsT+FzfAtvELKEpc
        /fGYEcTmFbCTOHf5K1icRUBVYt6iiWCLRQUiJA7vmAVVIyhxcuYTFhCbU8BU4tSjM2A1zALq
        En/mXWKGsMUlbj2ZDxWXl2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5
        qeV6xYm5xaV56XrJ+bmbGMHRoKW1g/HEifhDjAIcjEo8vBxJFrFCrIllxZW5hxglOJiVRHgD
        G8xihXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTDyVBir
        as0qLz7L+Pev0xYfnstKszex62p8Ft+bbh9ULcA9y3WPr6NW4o+4a5Z5Ek8/nFiY4NJ+tcmP
        c+u8dzPnsM7dYRe/ueBPgvNtt+ryGba3rq7g++Jiv2eO16ZojsNSbhPllBbeqD569dJ39dVc
        LL2Wxz/vY55RlbT01D82pwf/dDXufO9QYinOSDTUYi4qTgQAX9Quh4ICAAA=
X-CMS-MailID: 20190725035132epcas1p1ae2e5efb3a8e49abeb5606a81ba41cf4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190724190003epcas4p29fa01d9bedd3b663c3bd10a68b52b778
References: <CGME20190724190003epcas4p29fa01d9bedd3b663c3bd10a68b52b778@epcas4p2.samsung.com>
        <20190724185953.17545-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 25. 오전 3:59, Krzysztof Kozlowski wrote:
> Correct the documentation for devm_devfreq_remove_device() argument.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/devfreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 784c08e4f931..446490c9d635 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -867,7 +867,7 @@ EXPORT_SYMBOL_GPL(devfreq_get_devfreq_by_phandle);
>  
>  /**
>   * devm_devfreq_remove_device() - Resource-managed devfreq_remove_device()
> - * @dev:	the device to add devfreq feature.
> + * @dev:	the device from which to remove devfreq feature.
>   * @devfreq:	the devfreq instance to be removed
>   */
>  void devm_devfreq_remove_device(struct device *dev, struct devfreq *devfreq)
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
