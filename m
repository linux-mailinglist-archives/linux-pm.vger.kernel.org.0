Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B19762F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 11:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfHUJ3O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 05:29:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37073 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfHUJ3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 05:29:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190821092912euoutp029d3e0f6794af10c62100b4e64ab91146~85hX_lQ6d2499724997euoutp02T
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 09:29:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190821092912euoutp029d3e0f6794af10c62100b4e64ab91146~85hX_lQ6d2499724997euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566379752;
        bh=VUfly4VaDq+D6LwLjJfuJq0OMCOq6n6x1SHaNaEmr08=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t+1XNf6/S7qGiRz8UY04SVmmAcNFjKiI5aUlhprJtrudS3rq0yXBzznTviGQ0nyR9
         qCnGmjHc2kNJnKHH7D6PjQdpQp8hwsfME1II31I2ODxNhH6BEVJOM1gtFDgb/AW0h3
         IDsRmWomV1J8XKP5WaCf9sBQPKappCPN8a5olQJ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190821092911eucas1p241c599be5400e0e9cf692cc5472e48a7~85hW3Ey5h0660806608eucas1p2f;
        Wed, 21 Aug 2019 09:29:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 75.7C.04374.7EE0D5D5; Wed, 21
        Aug 2019 10:29:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821092910eucas1p1b38107511a80a4e870db991a2d356077~85hV9wt3Q0823408234eucas1p1o;
        Wed, 21 Aug 2019 09:29:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821092910eusmtrp23a29e749dd0908e9d433bef131ea886a~85hVvJfPr2265822658eusmtrp2Z;
        Wed, 21 Aug 2019 09:29:10 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-2a-5d5d0ee7d655
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.BE.04117.6EE0D5D5; Wed, 21
        Aug 2019 10:29:10 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190821092909eusmtip16720b115a41677bd81b358c676fa8c37~85hU2I9yy1555115551eusmtip1t;
        Wed, 21 Aug 2019 09:29:09 +0000 (GMT)
Subject: Re: [PATCH v12 6/9] ARM: dts: exynos: add chipid label and syscon
 compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <8cee8885-142f-d508-472b-334a73d30696@partner.samsung.com>
Date:   Wed, 21 Aug 2019 11:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724171049.GA11333@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u3veLp72uNDX+3ZbVNYLmv1GXkeesXmZDcuiw6NaXXKPEP44
        Kiou7ZA6JUZTpxZpqZay7igdncZcanm7vCzSODHLW4/n0H+fz+f7+fy+38/2Y5TqXGoCE5e4
        W9AnahM0lBdRfedbW9Ab76ioUEcqga/lVZDY+fkNiYtsbSS+8tGFcOrFCgqfbC1U4HvHdPiE
        650SOxxXaXz/8Hsafzz+lMQP6woo7DbaEM5zNChwua2bxsXOdgVub12Guw6VUDj9po3G1vdH
        Sfzz8TUCNz5agbsGvfGXlpdoEfBl58oQ/2XARPD9Hek0f9bQTvC15m6ar7RkUnxjYRnNG1M/
        UHx2lQXx1+0HeHfllDUjI73CtwsJcXsEfciCaK/YrG8tdJJDtS/7RRFlQHfpLKRigAsD02Cp
        Igt5MWquBEFXdo6HfEbw69RbD3EjyDzs+hcp6DlGyIPLCLofW0iZ9CG4ZS1CksuH2wAOYwkh
        4TFcADh/fCUlrOTqCTCYxmchhqG4YKix7JJklouAQ0erFBImOD+oabH8sY/lNsKn51ZS9oyG
        u/k9hBRVcSFQ/2SG/KIvdPYUKWQ8FW70FSilc4DrYMDQWUvJRy+F3j47krEP9DZXecpMgl+1
        chg4EQzGCx7PQXCdKPR45oG1uZ2U9iqHqlTUhcjyYrCdciJJBs4bOvpGyyd4g6n6jFKWWcg4
        opbd/lB1/IFn0Ti4XJZL5yCNeVgv87Ay5mFlzP/3nkeEBfkKyaIuRhBnJwp7g0WtTkxOjAne
        tlNXiYZ+q/1n80ANavi+tQlxDNKMYqOdm6LUpHaPmKJrQsAoNWPYfQWRUWp2uzZlv6DfuUWf
        nCCITWgiQ2h82QMjnm9SczHa3UK8ICQJ+r9TBaOaYEC2AYPL1Mt1hodt7ohcuXnu+rWZCXH3
        Q7Ptg+Hlr1yxqfo58eySWVAaGzk4zd9kDJwTlxGE2IaRbdGhPq8DUH9xsWZ1fa7fwpOTc9jx
        5tvz0wIeVgde2dC47sb1s6pxayPcOr/qHZO7I+ovnc63To/fkdbq/p63cnlr40yD+tmqUruG
        EGO1MwOVelH7G6kNv/epAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsVy+t/xu7rP+GJjDc48YrfYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNu8bHnHqvF5V1z2Cw+
        9x5htJhxfh+Txdojd9ktll6/yGRx8ZSrxe3GFWwWrXuPsFscftPOavHv2kYWi/1XvCxu/+az
        +HbiEaODhMeaeWsYPb59ncTi8f5GK7vH7IaLLB47Z91l99i0qpPNY//cNewevc3v2Dz6tqxi
        9Nh8utrj8ya5AO4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYyunyfYC85zVvQ9nM/WwHiSvYuRk0NCwERizpNuli5GLg4hgaWMEudm9EMlxCQm
        7dsOZQtL/LnWxQZR9JpR4sqUKWAJYYFwifO9K1hAbBEBTYnrf7+zghQxC+xhkXi19AoTRMc7
        Ronlq/8DdXBwsAnoSexYVQjSwCvgJtHYvoUJxGYRUJXYcWIVK4gtKhAhcXjHLEaIGkGJkzOf
        sIC0cgroS+y5qQ0SZhYwk5i3+SEzhC0ucevJfCYIW15i+9s5zBMYhWYh6Z6FpGUWkpZZSFoW
        MLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEwo24793LKDsetd8CFGAQ5GJR7eHTejY4VY
        E8uKK3MPMUpwMCuJ8FbMiYoV4k1JrKxKLcqPLyrNSS0+xGgK9NtEZinR5HxgsssriTc0NTS3
        sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cB4KvD5s5UyFxlfsX64UMMt3xq9
        dgufrOmD3mXOMcWK3dPXPzcMDrjR+ELwotex/d5bO46YHNljw+SyqvPSX/cP7rUm1+151vw7
        sXKrgBzHzEMBDxv85iovOcJqXfVA2tqWJSP85eqaFUUS3wvn3+QVvi7WVmcrGbo2X7b1zMmw
        TQpNyhyPQtqUWIozEg21mIuKEwFlndL4PgMAAA==
X-CMS-MailID: 20190821092910eucas1p1b38107511a80a4e870db991a2d356077
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
        <CGME20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b@eucas1p2.samsung.com>
        <20190722094646.13342-7-l.luba@partner.samsung.com>
        <20190724171049.GA11333@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/24/19 7:10 PM, Krzysztof Kozlowski wrote:
> On Mon, Jul 22, 2019 at 11:46:43AM +0200, Lukasz Luba wrote:
>> Add the chipid label which allows to use it in phandle from other device.
>> Use syscon in compatible to get the regmap of the device register set.
>> The chipid is used in DMC during initialization to compare compatibility.
>>
> 
> I cannot find its usage in DMC driver.
You are right, it was used in the old versions. I will skip this patch.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>> index 67f9b4504a42..4801ca759feb 100644
>> --- a/arch/arm/boot/dts/exynos5.dtsi
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -35,8 +35,8 @@
>>   		#size-cells = <1>;
>>   		ranges;
>>   
>> -		chipid@10000000 {
>> -			compatible = "samsung,exynos4210-chipid";
>> +		chipid: chipid@10000000 {
>> +			compatible = "samsung,exynos4210-chipid", "syscon";
>>   			reg = <0x10000000 0x100>;
>>   		};
>>   
>> -- 
>> 2.17.1
>>
> 
> 
