Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8C4767B5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Dec 2021 03:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhLPCHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Dec 2021 21:07:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:50651 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhLPCHB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Dec 2021 21:07:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211216020700epoutp03a0be71d77ce17333a253582c2dcfdd32~BGhXK8tzJ1258412584epoutp03z
        for <linux-pm@vger.kernel.org>; Thu, 16 Dec 2021 02:07:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211216020700epoutp03a0be71d77ce17333a253582c2dcfdd32~BGhXK8tzJ1258412584epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639620420;
        bh=wBrNla7Q/idEOugD6hQxRtGTv1bbK5zq7g3N6D8ADJw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ndDa09I7gMD9hgW8UdFigWtQCVUIIqmscbqQBYVim0S+YSw/CXGLjqgWn4uzm9CkC
         QCgSs+ILJcNEsl7NwisXn3gS9b4aHGOCPDSST36nTR8KQvqXKKcHuBpJNHa8mp8dWz
         hnvOyHjkeKBbbbONy5HyL+GQYuOBm0n3FmwqkOT0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211216020659epcas1p216dbbfaab7f20073a4370dc4f09d1272~BGhWlqXDn1059410594epcas1p28;
        Thu, 16 Dec 2021 02:06:59 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JDwTh2BCmz4x9QM; Thu, 16 Dec
        2021 02:06:48 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.CC.09592.50F9AB16; Thu, 16 Dec 2021 11:05:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211216020646epcas1p373a1025743091a376b189df29f68fc9f~BGhKq5vuX3152331523epcas1p3q;
        Thu, 16 Dec 2021 02:06:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211216020646epsmtrp227af5b3d400d587cbc85f20d74f0367b~BGhKqRo0l1563215632epsmtrp2q;
        Thu, 16 Dec 2021 02:06:46 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-53-61ba9f057afc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.DE.29871.53F9AB16; Thu, 16 Dec 2021 11:06:46 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211216020646epsmtip274ddc1c68c7a2e44b6846aa01299d6ad~BGhKcQnSF2619826198epsmtip2N;
        Thu, 16 Dec 2021 02:06:46 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Reduce log severity for informative
 message
To:     Tzung-Bi Shih <tzungbi@google.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc:     linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <639a5f91-b69c-c694-d993-1db8d2e70104@samsung.com>
Date:   Thu, 16 Dec 2021 11:29:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20211214063100.3066579-1-tzungbi@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmgS7r/F2JBm8mcFucbXrDbvG59wij
        xe3GFWwWey6+Yndg8ViwqdSjb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNN
        zQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAlikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVS
        C1JyCkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN6TxxmLJjKUdF7YTV7A+MTti5GDg4JAROJ
        5fe8uhg5OYQEdjBK/Pud1cXIBWR/YpR42HKdBcL5xiixd+tMFpAqkIaLr5YwQiT2Mkp8ePAf
        quo9o8SazjdgVcICARKbFtwBs0UEYiVW/pzNBmIzC8hI/H6xiBnEZhPQktj/4gZYnF9AUeLq
        j8eMIDavgJ3E8XdrWEFsFgFViRNzFoDFRQXCJE5ua4GqEZQ4OfMJ2HxOASuJlnfvoeaLS9x6
        Mp8JwpaX2P52DjPIcRICH9klvna+YId4wUXiydu5jBC2sMSr41ug4lISn9/tZYNoWMYo8Wty
        JxOEs55R4uWsTmaIKmOJ/UsnM4FCj1lAU2L9Ln2IsKLEzt8QQ5kF+CTefe1hhQQwr0RHmxBE
        ibLE5Qd3mSBsSYnF7Z1sExiVZiH5ZxaSH2Yh+WEWwrIFjCyrGMVSC4pz01OLDQuM4bGdnJ+7
        iRGcELXMdzBOe/tB7xAjEwfjIUYJDmYlEd4nEbsShXhTEiurUovy44tKc1KLDzGaAkN4IrOU
        aHI+MCXnlcQbmlgamJgZGZtYGJoZKonzvvCfnigkkJ5YkpqdmlqQWgTTx8TBKdXAdL3OPlNp
        dX9hFK/6Qr4dEV9Etq9rv3d5++zehXnvL3HMvOmgU2ObsZ4p3P9covTVCxsui+St2dC8OyKl
        8W75rfkPUxc3nH3WdXap+r7e1l06fa079n3gfZ7Z0np5W9XFI4zurckPpD3vb0v+enh2QD5P
        R+LukNtdGav3yB2etS/sYxvbldSe7xfSPvnleG5ar72mUH2Le3WcLot/gjCfq0xZ3pMI7nvt
        YueEc21zPAP+K+cytSe0TplSfnwfQ0piaVr03YTpy3Nf9W7oMFNREmPpFvcvrvU69K/41dy3
        kw9yqHtcE2kI0Uu6asTofm9hbl5sfLOkkM6vj3VPVvZwqjIF+7k/6UhuOv0x8IoSS3FGoqEW
        c1FxIgA2D3+MEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvK7Z/F2JBksLLc42vWG3+Nx7hNHi
        duMKNos9F1+xO7B4LNhU6tG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZvScOMxZM5ajovbCa
        vYHxCVsXIyeHhICJxMVXSxi7GLk4hAR2M0rMu7iTCSIhKTHt4lHmLkYOIFtY4vDhYoiat4wS
        KyZvZgeJCwv4Sdy9LAxSLiIQK3H73DtmEJtZQEbi94tFzBD1vYwSp45tYwVJsAloSex/cQNs
        Mb+AosTVH48ZQWxeATuJ4+/WgNWwCKhKnJizACwuKhAmsXPJYyaIGkGJkzOfsIDYnAJWEi3v
        3rNBLFOX+DPvEtRicYlbT+YzQdjyEtvfzmGewCg8C0n7LCQts5C0zELSsoCRZRWjZGpBcW56
        brFhgWFearlecWJucWleul5yfu4mRnBcaGnuYNy+6oPeIUYmDsZDjBIczEoivE8idiUK8aYk
        VlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwJTK8nvLjyYDk1/v
        Dnx9aFL34nnRnUzx+QL75W+/4xfh/Gu1K8/DJqgonv1XvNduxZmqgs/D2z+JPDC4/NN2u31U
        42r3xDbP/O4tFsyVBunecSseH9L3sLti9jTPZv22KWe0Py3kD7lq9l92qbCegVKV1KRs91Nf
        5JcyspjtaXu3eumEfMuS0r75dud79d5YxCyql9P6sNFYOneOdfw2lsanljyZynP2PzZ9kbU0
        37t0Oou0Y8+MAzsVV8ye9L9bLkbK5nqj0SHt78VlvJn8nYefP9lr/6Av5ubrE6uOXl6s5nrs
        aHlFvNzitcHm5eclP0p2O0us+dhdwnW2+t0/78sv1gQZFusXLnybWFwcqsRSnJFoqMVcVJwI
        AF/Tha36AgAA
X-CMS-MailID: 20211216020646epcas1p373a1025743091a376b189df29f68fc9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211214063114epcas1p38cfb009bda86839613bc5bc7ddc4bc2e
References: <CGME20211214063114epcas1p38cfb009bda86839613bc5bc7ddc4bc2e@epcas1p3.samsung.com>
        <20211214063100.3066579-1-tzungbi@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/14/21 3:31 PM, Tzung-Bi Shih wrote:
> Suppose devfreq_update_status() failure in devfreq_set_target() is not a
> critical error, reduces the log severity.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  drivers/devfreq/devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7906220d025c..a525a609dfc6 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -382,8 +382,8 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>  
>  	if (devfreq_update_status(devfreq, new_freq))
> -		dev_err(&devfreq->dev,
> -			"Couldn't update frequency transition information.\n");
> +		dev_warn(&devfreq->dev,
> +			 "Couldn't update frequency transition information.\n");
>  
>  	devfreq->previous_freq = new_freq;
>  
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
