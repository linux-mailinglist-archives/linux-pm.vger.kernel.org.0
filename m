Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC36504B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfGKCrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 22:47:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:36651 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfGKCrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 22:47:05 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190711024701epoutp012fc4f95f3ff7681316400484f05ac26a~wOlhL34SP1715117151epoutp01k
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 02:47:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190711024701epoutp012fc4f95f3ff7681316400484f05ac26a~wOlhL34SP1715117151epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562813221;
        bh=1wGcXvZOX+6VVvBcfB3TBbo5h+k9SWIncQbkwIsXMfE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CIXfPm04yQLnavK6BZypaP377R6pLVHlcrz14rxu/kZeR5mkDmEWdpSFax68LiuyJ
         2WoCOpzMudy2E7Nrqey62jp3cZaADoTrwA3IcHSQ3vpshXOKwiCRFw7ibqpDad3Aix
         y1TwjSShFK52i2qjJ55fokv56B52eOBPoW9vIBhE=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190711024658epcas1p3a52cfed6c3111461fe5689f661dcb24b~wOlelY57M3244632446epcas1p3T;
        Thu, 11 Jul 2019 02:46:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.8F.04143.223A62D5; Thu, 11 Jul 2019 11:46:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190711024657epcas1p228c9ed5db4a37970fe95511019d860d4~wOldtElr82016620166epcas1p2p;
        Thu, 11 Jul 2019 02:46:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190711024657epsmtrp196202ce3efc9b1b7e7ae58f7bacc860c~wOldsO6zs2470024700epsmtrp15;
        Thu, 11 Jul 2019 02:46:57 +0000 (GMT)
X-AuditID: b6c32a37-f31ff7000000102f-37-5d26a322f923
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.FF.03692.123A62D5; Thu, 11 Jul 2019 11:46:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190711024657epsmtip2b91dd300dca37759574381c784813ac7~wOldfcx5E1722817228epsmtip2W;
        Thu, 11 Jul 2019 02:46:57 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: Fix kernel oops on governor module
 load
To:     Ezequiel Garcia <ezequiel@collabora.com>, cwchoi00@gmail.com
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>, kernel@collabora.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <16d08fb2-da04-8920-93d0-43f479d2bbe0@samsung.com>
Date:   Thu, 11 Jul 2019 11:49:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <85fb2cb764961845a32b8af51e8c6ccebf60c703.camel@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm8+xsR2n1NTPfBGudMtSw7ThXp9ISilooufBPCcsOenKyKztb
        ZQVdJFOz+49qUhkVphTllU3UxdKkmyRqdEHIstLsQqUZhdC2Y+S/53uf5+F5n+/7KEJRJY2h
        Cq1O3mHlzLQ0QtJ8L0GVRF9dYlC31qjY951L2Zuv/Ij13hmTsQ3dFST75PAnGfvjeAdiXx26
        IU2X6TwD15DO6x6Q6U401iLdj/r5ekmOKdXIc/m8Q8lb82z5hdaCNDojO3ddrna5mkliVrIr
        aKWVs/Bp9PpMfdKGQnNgAVq5izO7AiM9Jwi0ak2qw+Zy8kqjTXCm0bw932xfaV8mcBbBZS1Y
        lmezrGLU6mRtQLjDZOx2+2X2hqg9k1dKyIPoAy5H4RTgFDhX3BJWjiIoBfYgGHSfI4KEAn9H
        UPc8ViR+IvA8rpb8c0yOjUw52hC0XRknxcNXBL9OFcuCqkicBRX9DdIgnoPT4fatIVlQROBe
        BG/KhskgIcWJ4Bt+HhLNwguh/9dbFMRyvAb+9HSH5hIcB/UTnaGdovBWeNhxSSJqZsODC0Mh
        HI4zwFd8LKQncDS8HLocJuIFUNxUSQSDAY9K4dnIFyR2WA91R/um+kTCx65GmYhjYORkyRTe
        BzUPOqSiuRRBo+8pKRIa8F0/G0igAgkJcLtFJY4XgvfPRSQGz4Qv4xVkUAJYDqUlClGyCHpf
        D4SJeB5cPVomPYVo97Q67mkV3NMquP+HVSFJLZrL2wVLAS8wds30565Hod+ZuMKD7nRn+hGm
        ED1Drh+MMyhIbpdQZPEjoAh6jrx94yKDQp7PFe3lHbZch8vMC36kDdz2aSImKs8W+OtWZy6j
        TdZoNGwKs1zLMHS03DgYa1DgAs7Jm3jezjv++cKo8JiDaLf+m6617gC1Ja151Nd+pETd7vF6
        KoXhos/kzljD2rnbTZ6okeOunB05Q4YtHZ0LsltN4zdnzkri3rlaXkZu7jnSs//kZNbYi75N
        8XGP0k1Ni8vwiYnrvsj+tk33J5Tk5rzy2urzxJn4hLve0uTRQ9tWj3elGvsyf3fp0qv7z6hW
        0xLByDGJhEPg/gJzfCFwswMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42LZdlhJXldxsVqswY+FuhbPjmpbrLl9iNFi
        54Yv7Babz/WwWpxtesNu8bn3CKPF7cYVbA7sHjvuLmH02DnrLrtH35ZVjB6fN8kFsERx2aSk
        5mSWpRbp2yVwZZybdYi9YLNoxd+FbawNjM8Fuhg5OSQETCT+fnnJ1MXIxSEksJtRovnrf2aI
        hKTEtItHgWwOIFtY4vDhYoiat4wS32buYASpERbwlbj7uZsNxBYRcJBYv/YJO0gRs8BlRomN
        dycwQnRMZ5LYfWkTK0gVm4CWxP4XN8A6+AUUJa7+eAw2iVfATuL3xXNgcRYBVYlN34+CXSEq
        ECEx6dpOFogaQYmTM5+A2ZwC3hL7myE2MwuoS/yZd4kZwhaXuPVkPhOELS/RvHU28wRG4VlI
        2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCo0hLcwfj5SXx
        hxgFOBiVeHgDHqrGCrEmlhVX5h5ilOBgVhLh3eeuHCvEm5JYWZValB9fVJqTWnyIUZqDRUmc
        92nesUghgfTEktTs1NSC1CKYLBMHp1QDo9ndjlfbzpf+Df+V3VZwkP//aVejx8rOa4p/HckU
        1TK5G8BdU2f3d/3C6MP7DuxyvxO6cXbRhzPXfXcrnFR99FaJ9/u6z1Nef3I32liufWrix4u3
        nA46xk9/tNRmypSy76ev7Fy9+F+X9jStlfPEpGfMm3phK8eaW0vKL/b0+qp4hR/S0ptifUpa
        iaU4I9FQi7moOBEA88uFP54CAAA=
X-CMS-MailID: 20190711024657epcas1p228c9ed5db4a37970fe95511019d860d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190710183033epcas5p4845af2f6704e7e8e9b9c17fc651afe34
References: <20190621213949.27018-1-ezequiel@collabora.com>
        <CAGTfZH3WenT=t6bFWy7sZCKhcPaMBrzTs=00DeSFU-0Sm-qS=A@mail.gmail.com>
        <CGME20190710183033epcas5p4845af2f6704e7e8e9b9c17fc651afe34@epcas5p4.samsung.com>
        <85fb2cb764961845a32b8af51e8c6ccebf60c703.camel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 19. 7. 11. 오전 3:30, Ezequiel Garcia wrote:
> Hello Chanwoo,
> 
> On Sat, 2019-06-22 at 19:46 +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> 2019년 6월 22일 (토) 오전 6:42, Ezequiel Garcia <ezequiel@collabora.com>님이 작성:
>>> A bit unexpectedly (but still documented), request_module may
>>> return a positive value, in case of a modprobe error.
>>> This is currently causing issues in the devfreq framework.
>>>
>>> When a request_module exits with a positive value, we currently
>>> return that via ERR_PTR. However, because the value is positive,
>>> it's not a ERR_VALUE proper, and is therefore treated as a
>>> valid struct devfreq_governor pointer, leading to a kernel oops.
>>>
>>> Fix this by returning -EINVAL if request_module returns a positive
>>> value.
>>>
>>> Fixes: b53b0128052ff ("PM / devfreq: Fix static checker warning in try_then_request_governor")
>>> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
>>> ---
>>> Changes from v1:
>>> * Rework the fix as suggested by Enric and Chanwoo,
>>>   handling the return vaue.
>>> ---
>>>  drivers/devfreq/devfreq.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 6b6991f0e873..258f70c1e48f 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -257,7 +257,7 @@ static struct devfreq_governor *try_then_request_governor(const char *name)
>>>                 /* Restore previous state before return */
>>>                 mutex_lock(&devfreq_list_lock);
>>>                 if (err)
>>> -                       return ERR_PTR(err);
>>> +                       return (err < 0) ? ERR_PTR(err) : ERR_PTR(-EINVAL);
>>>
>>>                 governor = find_devfreq_governor(name);
>>>         }
>>
>> Thanks you for fix-up.
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> But, you are missing the stable mailing list. In order to apply this
>> fix-up patch,\
>> you have to send it to stable mailing list. Please send it.
>>
>>
> 
> If I understand correctly, you or any of the devfreq maintainer
> can simply add a Cc: stable@vger.kernel.org tag.

Originally, the author have to send the stable mailing list
with the required style. You can do it.

> 
> This is documented as Option 1 in stable-kernel-rules.rst.
> 
> The Acked-by and Reviewed-by tags need to be collected anyway :-)

This patch[1] was picked to devfreq.git.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/commit/?h=for-next&id=4f065f69ebc2bdf1fbe224816a3c471babd370dd

> 
> Thanks!
> Eze
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
