Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13197A435F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjIRHp7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbjIRHp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 03:45:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F87CCD6
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695022978; x=1695627778; i=quwenruo.btrfs@gmx.com;
 bh=zsHbVslkKUpeqHCYPdi9AmXfOMbUYQ5LUQotHDZLPxM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Q1NyM4RDEYtQRl/vVE9CwUo4jGUk5zeA1ba99H0ZVDMKEfAk3C7Oib6N+WZzmn1Ivo1KRZqE2zl
 aWNB0nEgji70ig5cVlo2WSQ+XuFVtKAdQqrlqcY0wOfU8mVE7fOpOghwoSYTs5ORaZFzeLLvaJ9k3
 PY3tH6zL2gG4vRUmP3bcvF7ZmmkKgdrKtMdHVlhlz0/sLzZvylEiMDiqKTD/Kprw8OYHHxoN5zRMd
 BWdb7iRZ4Xc8izrBAO1QiX8mKf1f/ht9Nvbw3efUJd/Vx8PsFy6f04xP5q2xZySob0wXNYWRoQaLv
 xhcAT3O3DTVH2UCT5tpL0t4uU516WymfaMXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiPl-1r9FWB039p-00TzOw; Mon, 18
 Sep 2023 09:42:58 +0200
Message-ID: <5daf7b58-7070-4e50-bf7d-ba7de835d533@gmx.com>
Date:   Mon, 18 Sep 2023 17:12:53 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to disable AMD cpu boost using amd-pstate driver?
To:     Huang Rui <ray.huang@amd.com>, Meng Li <li.meng@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <5b410ac7-ea26-4f26-96a0-84451943c83a@gmx.com>
 <ZQf8o8bZOzF+bCn/@amd.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <ZQf8o8bZOzF+bCn/@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/rr87b9styCSwShRUdO2A9RtClK0sFckdmIgx+4hkJajuVr8v0x
 q0yoOLotI0yVRVYPcpzGAqxREmKlxtOK6ZAGSgrqhYNjybjRkReboZvTVCttRVHJ3iR91Z/
 AnBgocBNjkUEnp4R46h1kd6lxrDRjUH06AvNFY3sD95d5aVmmP2pZT1RrtDpW4RAB35dekB
 L1Go3edEIkCGH3S1+DOcg==
UI-OutboundReport: notjunk:1;M01:P0:Vr7gq33S6nA=;v6cBuJsH5CU63u0VWsHWSQkKUvT
 os4f5Hdg39fVD4e2Nw9eckhgxMtOr2ws1JBgnIlg/n83rhNQgaG/URicF8U2tvUFFoy6ywSx7
 Rn7N79RjxOlLYoGoMsKLCRPUG6m7+AsjVBpjY2WpWEiAJV3/oUmfyqnmKvMVfC+y5fJEXMa2s
 Om+ZpYLTjaATVHoZe9114+CPMjNRwNvhEMaaFpIvJ94lt9nbpi3QVmFR/LBDqSK9GFmtdP87g
 uamOdEtgEDvSQncr84hfQKHKMc2cCfjr3ZB032t4Fg/TcMLK8lG9NhfEEoVMq9DKapNZP3UhB
 UFDMj7/yt6Rm0d6zc4spWztNW3T3vTXP26WNlX42Ci8mJXslgphio3DLa2UKhY6uFiFo73xaC
 EQrc+qcAZt1RY54KgOEBGLCXmOUEfv3iiuRIKOhFNzoc9CQI647SJzoiGpg9IEFefOQbiNr0K
 Ix/T6eAZRH3UdVVacDqj3pEpQj5uTp7lK10jb5NoYuoIX7PnpY0DlrowkA6PVg0nZ+gruUQSk
 Wd63M3+eobVPzkaXLp5s3T//H75hMwstxjHFcky0Z/5cMo3GP940yzydU0Kev0JwdR99KZcfS
 kMk8fG4iVET2OXv9G4p5LtTExVzvOKgLi2gSA2LjVPFs8qp3jiqye1AXkPsTZeQDVtkKsgi5D
 uGc1E8jU2pUsKw0ETab4Dcr881QgLSYmXYy6JJv3HHDBz5WGDGkM1gfEE55iHRjTMAHvIoP/C
 doxxT5crxSn65uPjV6/wZUbBGKzxM95rzoYY67qsWUL00LXByE2+OCHsltcOzqdv77AGjrdik
 2SbsjHh823YtX3OMsHY/uzrOc4DOVyQlgSK4u+YXrdtYJZfdf/LXGhEqgQHaPXltBVVh2IJjx
 /9D1gd6zfuQZTxwwrWuG87suI4WbSVa/WzDOSaScw4EGRe8usKz/oLcRvldHPMImJ0ic3CSSZ
 +GnxV5cZGqe56ZMnOY0jjRu8Exc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2023/9/18 17:00, Huang Rui wrote:
> On Sun, Sep 17, 2023 at 05:52:06PM +0800, Qu Wenruo wrote:
>> Hi Rui,
>>
>> Thanks for your hard work maintaining amd-pstate driver first.
>>
>> However it looks like if amd-pstate is used, there is no way to properl=
y
>> disable the CPU boost (this becomes obvious especially in Linux 6.5, as
>> amd-pstate is enabled for my 7940HS CPU by default).
>>
>> Previously using acpi-cppc, there is always a file named "boost" in
>> /sys/devices/system/cpu/cpufreq, and echo 0 into that file makes my CPU
>> temp never cross 75 during gaming sessions.
>>
>>
>> But in Linux 6.5, with amd-pstate, I have to go amd_state=3Dpassive to =
get
>> that file back, and echoing 0 into that file makes no difference.
>> I still easily got 90C during the same game.
>
> Have you tried amd_state=3Dactive and set balance_power? We can support =
EPP
> and the EPP_INDEX_BALANCE_POWERSAVE maybe fit for your case.

Yes, tried both balanced_power and balance_performance, none of them can
reach the old temperature (less than 70C during Armored Core 6 play).

Thanks,
Qu

>
> Thanks,
> Ray
>
>>
>> For now I have to completely disable amd-pstate and rollback to acpi
>> driver to get a sane temperature.
>>
>> Is there any proper way to disable the boost using amd-pstate?
>>
>> Thanks,
>> Qu
