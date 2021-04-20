Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663BD365ACE
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhDTOGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 10:06:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:50115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhDTOGw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 10:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618927567;
        bh=/g1FtlevdHeTmhJUD/4gwA54JJzrpd4wSzl/1j3/RQM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZjwhifnciEYc53kj3KbQaO5HAGlQLsGqFwFRtAFCsLw9CneqliwFRzzAhuma2Oqsz
         eylHtLqEHO/ddmqdodOBS4oGcL+PTszUSrEqTM+hbIi9z7jSm787qb+BKt2NjUtYuL
         DkOOULSaKUoJ6bZnQpet960sfsabTxvIBd1O/kfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([92.255.135.33]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAwXh-1lO9e32nd3-00BIWF; Tue, 20
 Apr 2021 16:06:06 +0200
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
To:     Chen Yu <yu.c.chen@intel.com>, Borislav Petkov <bp@suse.de>
Cc:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        calvin.walton@kepstin.ca, wei.huang2@amd.com
References: <20210419195812.147710-1-terry.bowman@amd.com>
 <20210420020336.GA386151@chenyu-desktop> <20210420080701.GA2326@zn.tnic>
 <20210420131541.GA388877@chenyu-desktop>
From:   "Artem S. Tashkinov" <aros@gmx.com>
Message-ID: <a5637148-7a21-e4e1-a4e7-c470bbb3bfe0@gmx.com>
Date:   Tue, 20 Apr 2021 14:06:04 +0000
MIME-Version: 1.0
In-Reply-To: <20210420131541.GA388877@chenyu-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PlZr8/Llvn3WOZlKjQff9crOs58R16i0wLmavSQVfixKfcMU6g/
 WIGo8fjsBWGEBk0hjxNLDvjX9gBwFwhEU5ZInOiHSVyGZC0wxpUF2S0QYSGnQMLC2c2J7In
 gwqVyxqBzIXxtF3AuXuFk8TaF+wC2rxfoj1ynqNtgThF1nhyNUyXSjtx7cRvuKfJ6GKcwx/
 9Cfb2PmZx/i3cAnq68Ulw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iCXZzRyq6xo=:tEr6lA3vL6ZqLk5tgpi045
 jskD73l2WvZdJk1oH6cOLd8nmXN80b/Qe91fuE2KDR+hTW4hd8ALGb14N+ad567a0Ik9eGjmm
 jMebAIdz0DGKdB1gNqCVNSnme6pDxQwmgb+KLJChpJZskkoWnZseI01MzXYhM123szmsW3R95
 KXG94tcfhoZ3zaQYChkz7SlV7y1UMQYXzvKtUJuB6w2g8E5WWVBhA75ftENmdkQdG3I4q98qh
 e/dOb1EFVLyFsgXwMn8+Z5KpMo4w3NSFNuWPorPSTq3v1NMuRaAVY58y7FhuT/x5jRI4bfKg3
 71zO6SH+8ecxV4ICk3+NODzWDMzcgrPaFaeRF/P9Zfj/cCrTOps8mZzLsjIaYn9n0cIUO2j5e
 /WX2bLnLXXGIPypG2/9oAcpatYW4geHauprYklM1HCs9DICdGtCr5PqTbm2gudbgbLBc2nyrp
 0PVVqvE+CEQULe24C9+ohXKDiK3A5w08kBrevcdv6LYcf1hF/8Ilh/wsUXQCzaCnByGlTDk6q
 kn2rOS2hLfircYMUsW46Pejlo15PyXvg+WznR00P/ptHC30lRLcHCsoY7c5B0gY7P6e7HXER5
 MGZcuiLiJW+Vr9ulwHuRfXnZMFVx/RGyyvG+/3Niofj0Kfho6BdWfygrE7Z2nuJqG39p7URtQ
 Nj9tnZD+ntQh/H3GGAS9ZxZetQ3kBssVLoczyR/u7A8YDqTK+NoJR21QmcBRgBDDzR6OL6cBt
 02W8XAnXjxGtnQkiaGE0XvA3OWPCT8STquZpmztDiK1UZCEhyczTyqjanYlTKM1dWJggT8YZb
 1Q6B5QnmFV5ZH9YG05IIo6xArlxAp7MmGbEW1NG0rgZHIRYyTzxKQyQYNlqdR7Ax4QJmPh9GM
 NDUudDDkHUDPYqioFSjB68jBb6TX3DfKrQo7/xWzGwBjq7tkZQLV55G76du5lGii63OzFGU8H
 uaJTTUo0qIkN1vi2cCFdQT5LchxZeAWG9wqYkor1W/RGGfwZQJ2IrNBlUvjEnj19eW3xwlFxY
 GcaqUlqnl47BWNrhmbXZXN9Oaukf9P//S2k+PL8qFlMa+ATVH/SMglsTg7w1juKpuXEVmaDcb
 4arsLph3GSuyPyouLkMjoum9LOn5CaFxW7vSiORDktEP8LhjMWvysVA/pLGj50GKW6CVVeG6e
 Qm0zxjoN3QpOv0EzdLxf/LAiTpp+qf7aog6IH4PLXURGcjKFMNTb67zUJqzks7tsPN/ig=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/20/21 1:15 PM, Chen Yu wrote:
> On Tue, Apr 20, 2021 at 10:07:01AM +0200, Borislav Petkov wrote:
>> On Tue, Apr 20, 2021 at 10:03:36AM +0800, Chen Yu wrote:
>>> On Mon, Apr 19, 2021 at 02:58:12PM -0500, Terry Bowman wrote:
>>>> Turbostat fails to correctly collect and display RAPL summary informa=
tion
>>>> on Family 17h and 19h AMD processors. Running turbostat on these proc=
essors
>>>> returns immediately. If turbostat is working correctly then RAPL summ=
ary
>>>> data is displayed until the user provided command completes. If a com=
mand
>>>> is not provided by the user then turbostat is designed to continuousl=
y
>>>> display RAPL information until interrupted.
>>>>
>>>> The issue is due to offset_to_idx() and idx_to_offset() missing suppo=
rt for
>>>> AMD MSR addresses/offsets. offset_to_idx()'s switch statement is miss=
ing
>>>> cases for AMD MSRs and idx_to_offset() does not include a path to ret=
urn
>>>> AMD MSR(s) for any idx.
>>>>
>>>> The solution is add AMD MSR support to offset_to_idx() and idx_to_off=
set().
>>>> These functions are split-out and renamed along architecture vendor l=
ines
>>>> for supporting both AMD and Intel MSRs.
>>>>
>>>> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL d=
isplay")
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Thanks for fixing, Terry, and previously there was a patch for this fr=
om Bas Nieuwenhuizen:
>>> https://lkml.org/lkml/2021/3/12/682
>>> and it is expected to have been merged in Len's branch already.
>>
>> Expected?
>>
>> So is it or is it not?
>>
> This patch was sent to Len and it is not in public repo yet. He is prepa=
ring for a new
> release of turbostat as merge window is approaching.
>> And can you folks agree on a patch already and give it to Artem for
>> testing (CCed) because he's triggering it too:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D212357
>>
> Okay. I would vote for the the patch from Bas as it was a combined work =
from two
> authors and tested by several AMD users. But let me paste it here too fo=
r Artem to
> see if this also works for him:
>
>
>  From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Date: Fri, 12 Mar 2021 21:27:40 +0800
> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
>
> It was reported that on Zen+ system turbostat started exiting,
> which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
> offset_to_idx wasn't returning a non-negative index.
>
> This patch combined the modification from Bingsong Si and
> Bas Nieuwenhuizen and addd the MSR to the index system as alternative fo=
r
> MSR_PKG_ENERGY_STATUS.
>
> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL disp=
lay")
> Reported-by: youling257 <youling257@gmail.com>
> Tested-by: youling257 <youling257@gmail.com>
> Tested-by: sibingsong <owen.si@ucloud.cn>
> Tested-by: Kurt Garloff <kurt@garloff.de>
> Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>   tools/power/x86/turbostat/turbostat.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/tur=
bostat/turbostat.c
> index a7c4f0772e53..a7c965734fdf 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -297,7 +297,10 @@ int idx_to_offset(int idx)
>
>   	switch (idx) {
>   	case IDX_PKG_ENERGY:
> -		offset =3D MSR_PKG_ENERGY_STATUS;
> +		if (do_rapl & RAPL_AMD_F17H)
> +			offset =3D MSR_PKG_ENERGY_STAT;
> +		else
> +			offset =3D MSR_PKG_ENERGY_STATUS;
>   		break;
>   	case IDX_DRAM_ENERGY:
>   		offset =3D MSR_DRAM_ENERGY_STATUS;
> @@ -326,6 +329,7 @@ int offset_to_idx(int offset)
>
>   	switch (offset) {
>   	case MSR_PKG_ENERGY_STATUS:
> +	case MSR_PKG_ENERGY_STAT:
>   		idx =3D IDX_PKG_ENERGY;
>   		break;
>   	case MSR_DRAM_ENERGY_STATUS:
> @@ -353,7 +357,7 @@ int idx_valid(int idx)
>   {
>   	switch (idx) {
>   	case IDX_PKG_ENERGY:
> -		return do_rapl & RAPL_PKG;
> +		return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
>   	case IDX_DRAM_ENERGY:
>   		return do_rapl & RAPL_DRAM;
>   	case IDX_PP0_ENERGY:
>

The patch works for me.

Tested-by: Artem S. Tashkinov <aros@gmx.com>
