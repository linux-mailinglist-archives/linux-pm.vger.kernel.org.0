Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F97517405
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 10:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEHIhL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 04:37:11 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35061 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfEHIhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 04:37:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190508083708euoutp010dbad9a4def17a2ed490799f85d4b8b0~cqE8f6fAl3260832608euoutp01Z
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 08:37:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190508083708euoutp010dbad9a4def17a2ed490799f85d4b8b0~cqE8f6fAl3260832608euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557304628;
        bh=F3hQPMWOwaji0kBc2pg5RjljvpKabT6uMTMspmYFhOs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Iw7wxEbuRT5A/IMIbZj8Vh3pOgnSkxVygAO6g9SCn1u2Z4fbySTGE1oNzc0ZvBbnV
         x/zaWKlEjIplZxsKacDT82HRpqvRljqFjxAS2+Fohr9i3Lg14ruEMuytqHlIdVfoXO
         EiB3RlYLKkR7a3CNIz0H16FXoKjYwJRDW5rbMfzo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190508083708eucas1p189f0865c3609ac36d585abb57ee7546e~cqE7xrJZT2103621036eucas1p1C;
        Wed,  8 May 2019 08:37:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F9.FF.04298.33592DC5; Wed,  8
        May 2019 09:37:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508083707eucas1p21512b3ba36832c438f5fa84b349825cc~cqE66jLb82357823578eucas1p2H;
        Wed,  8 May 2019 08:37:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190508083707eusmtrp24e8bc6cb5578878c2c24721e347d8948~cqE65wZe11036210362eusmtrp2c;
        Wed,  8 May 2019 08:37:07 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-7f-5cd295335a98
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DB.BF.04146.33592DC5; Wed,  8
        May 2019 09:37:07 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190508083706eusmtip16972ae35246c4fa91bb13324925bcbda~cqE6LTCLv1756717567eusmtip1a;
        Wed,  8 May 2019 08:37:06 +0000 (GMT)
Subject: Re: [PATCH v7 05/13] dt-bindings: ddr: add LPDDR3 memories
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <8ace8d5a-9cb2-4b41-0ed2-bcb33b349d69@partner.samsung.com>
Date:   Wed, 8 May 2019 10:37:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507170004.GA20489@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUxTURT09q0QSi6tyokajQUSl4gSTbyKC8at0Q/90MQoRqo8EaUF+lhU
        NKnggsjqBhYR/CA1IAErAUTcWmRxq6AGBBEFElEBgVKjQUXLg8jfnJk5OTPJ4SlFPzOND9VF
        CXqdJkzFutJlNT9tCxZfagxc5EhYTG5lFTOkaegTQ3KrXzCkcKATkQtPcmTk2TktSev8ShGb
        rYQjz+N7OPKq8ipL7CnViGTZ7stIUXUbR1pP3GDJSFUFR6w9Zxjy4PUm0jrsTr7XdaAApfq7
        4zytzjY00Oo7xjZObS44y6pTEvpYdWppAVLffhqntptnbuV3uq4IFsJCYwT9wlVBrgcG6+LZ
        iCR8uNzewhlQijwJufCAl8C1zIcoCbnyCnwDQcfge1oahhC8qfpKSYMdwcXBU+z4SmbvZ5kk
        mBCYihtYaehFYP5WOOpS4rVQbrEhJ56MZ8Pw6cuM00ThexTYuz7+E3iexb5QURDp9MjxBug3
        PeacNI294ckHLyc9Be+A9poSRrJ4QP2VLtqJXfB8qP+cLHNiCntCS1fuGJ4F5b1XR1MDzuGh
        qu8HI6VeB+aS+LEGSvhSW8pJeAaM3JGWAYtgSLmOJHwMOtNyxjz+YK1tYJzZKDwXiisXSvQa
        aDnZN9oEsDs093pIEdzhfFkmJdFySDytkNxzoDT55dihqWC6eZlLRyrjhGLGCWWME8oY/9/N
        Q3QB8hSiRW2IIPrphFhfUaMVo3UhvvvCtWb07w+f/qkdrECOxr0WhHmkcpN3RzQEKhhNjHhE
        a0HAU6rJ8qaMxkCFPFhz5KigD9+jjw4TRAuaztMqT3ncpA+7FDhEEyUcEoQIQT+uyniXaQY0
        S5PbzVi7jwdtJNXpm7f8aV76ht627DpLmwyyR0zlymNurzJaHlUkegQH6prf/UqIPamzN8p3
        VPUPmPLnHRxed9dPVjeknD/QFBCUGr3+4/60zOxrSh9r9/ZdoQPJ4FG2vDTP59nv3d9GvCN+
        vA23BgU4Mora9ZGJ/g631V7DhnwVLR7Q+M2j9KLmL0xG+NCDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4XV3jqZdiDPa+5bHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aLyafmMlmc6c616H/8mtni/PkN7BZnm96wW1zeNYfN4nPvEUaLGef3MVms
        PXKX3eJ24wo2i/97drBbHH7Tzmqx/4qXxe3ffBbfTjxidBD2+PZ1EovH7IaLLB47Z91l99i0
        qpPNo7f5HZtH35ZVjB6bT1d7fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hs
        HmtlZKqkb2eTkpqTWZZapG+XoJfx6UQTW0GXQMX2z7fYGxh7ebsYOTkkBEwkpr99ydTFyMUh
        JLCUUWLt7B+sEAkxiUn7trND2MISf651sUEUvWaUuN94hwkkISzgLLH90HlGEFtEQFHid9s0
        VpAiZoG9zBLrd82F6mhgkmjo3wo0ioODTUBPYseqQpAGXgE3iQ/Lj4KFWQRUJE49UAYJiwpE
        SJx5v4IFokRQ4uTMJ2A2p4C2xMmXPWB7mQXMJOZtfsgMYYtL3HoyHyouL7H97RzmCYxCs5C0
        z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEpoBtx35u3sF4aWPwIUYB
        DkYlHt4JeRdjhFgTy4orcw8xSnAwK4nwXp94KUaINyWxsiq1KD++qDQntfgQoynQbxOZpUST
        84HpKa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUAyNnhWfF5bhd
        GmeiWxmvfIn+9DZ3367mlHcdN4pbOD69z1vzNLw4mnGBLPsf9yT1tcmzkh3TPrBK77r7V+B1
        sfsj0/Ubt5YZlBZsms739UTC5V1r1z2ZpRb+Vkw3nG/XnhJHz5zcRQ6Lg7zzVt3fFZF+T/yB
        /pmrjut6Ao/9n/eex75jaWnm5zwlluKMREMt5qLiRAAiXRQUFwMAAA==
X-CMS-MailID: 20190508083707eucas1p21512b3ba36832c438f5fa84b349825cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151214eucas1p17114a7dce506c77ae0bb96b93fd2d838@eucas1p1.samsung.com>
        <1557155521-30949-6-git-send-email-l.luba@partner.samsung.com>
        <20190507170004.GA20489@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/7/19 7:00 PM, Rob Herring wrote:
> On Mon, May 06, 2019 at 05:11:53PM +0200, Lukasz Luba wrote:
>> Specifies the AC timing parameters of the LPDDR3 memory device.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/ddr/lpddr3-timings.txt     | 58 +++++++++++++
>>   Documentation/devicetree/bindings/ddr/lpddr3.txt   | 97 ++++++++++++++++++++++
>>   2 files changed, 155 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
>>   create mode 100644 Documentation/devicetree/bindings/ddr/lpddr3.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
>> new file mode 100644
>> index 0000000..3a2ef3a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ddr/lpddr3-timings.txt
>> @@ -0,0 +1,58 @@
>> +* AC timing parameters of LPDDR3 memories for a given speed-bin.
>> +
>> +The structures are based on LPDDR2 and extended where needed.
>> +
>> +Required properties:
>> +- compatible : Should be "jedec,lpddr3-timings"
>> +- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
>> +- reg : maximum DDR clock frequency for the speed-bin. Type is <u32>
>> +
>> +Optional properties:
>> +
>> +The following properties represent AC timing parameters from the memory
>> +data-sheet of the device for a given speed-bin. All these properties are
>> +of type <u32> and the default unit is ps (pico seconds).
>> +- tRFC
>> +- tRRD
>> +- tRPab
>> +- tRPpb
>> +- tRCD
>> +- tRC
>> +- tRAS
>> +- tWTR
>> +- tWR
>> +- tRTP
>> +- tW2W-C2C
>> +- tR2R-C2C
>> +- tFAW
>> +- tXSR
>> +- tXP
>> +- tCKE
>> +- tCKESR
>> +- tMRD
>> +
>> +Example:
>> +
>> +timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@0 {
> 
> Now the unit-address should be @800000000
Added @800000000 to the both files.
> 
> With that and the other example fixed,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Thank you.

Regards,
Lukasz

