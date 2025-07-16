Return-Path: <linux-pm+bounces-30890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152C9B06B89
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 04:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EFD4A17EA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E79272805;
	Wed, 16 Jul 2025 02:04:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D422701DC;
	Wed, 16 Jul 2025 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631482; cv=none; b=iZ+fQV9Yd+oTN3UTIc+WOueIVHJptfMW2f87pWfw3mAs9WENPXl4IQQCLJtFbnoVu8J51DzshUdPFat2xBkCaC76scoTGswYFsgWNSTe9zaVmKD5qXgTmkjSxg8iCExJ8lkmGYy5vpvhviqWHoCziQti5GQ5pY8hiWBDIfpaWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631482; c=relaxed/simple;
	bh=QL/1MgBYeSPk9Lzm58uCKHoKPSsWn+wu+/SE+qLrTe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwr4KcQ6i/xgI3YDOzpkZHu5+vxVd3Ecw8+FFbJ4kLwCwozd4SRdzTJoMgs3VGDklRh8PYgZcuDHsdyWZeqOoFphCrp3vWaT8KYXgw9QzEARSUuw2WIDEQLU0Str05tvgW48cB04dPADLLdVxeHw5+GOA/Yxf9o06oqFkve49mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37f46c9861e911f0b29709d653e92f7d-20250716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:02022675-8772-4696-92c9-0a1a099c0a81,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:63f44a96740b67ed7dd09419d91e2980,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 37f46c9861e911f0b29709d653e92f7d-20250716
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1535533330; Wed, 16 Jul 2025 10:04:34 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 048F6E008FA3;
	Wed, 16 Jul 2025 10:04:34 +0800 (CST)
X-ns-mid: postfix-687708B1-893896271
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 58BFFE008FA2;
	Wed, 16 Jul 2025 10:04:33 +0800 (CST)
Message-ID: <79468a7f-061f-479a-9357-e48c69cadbb8@kylinos.cn>
Date: Wed, 16 Jul 2025 10:04:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: suspend: clean up redundant
 filesystems_freeze/thaw handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250712030824.81474-1-zhangzihuan@kylinos.cn>
 <9d35035d-c63e-4d11-a403-54c50e8b35c1@kylinos.cn>
 <CAJZ5v0g22fMDc21yV2svePf_4BWZRrcy+b3-efpbfAGLpa2=Lw@mail.gmail.com>
 <76a87abf-8fc9-445b-83d5-0daa33746014@kylinos.cn>
 <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <CAJZ5v0jKwHZUpsYLzUkcL4=FDnewXoTeJo5e+ccyHw2bZ+ghTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/7/15 20:48, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Tue, Jul 15, 2025 at 8:12=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylin=
os.cn> wrote:
>> Hi Rafael,
>>
>> =E5=9C=A8 2025/7/15 01:57, Rafael J. Wysocki =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> On Mon, Jul 14, 2025 at 10:44=E2=80=AFAM Zihuan Zhang <zhangzihuan@ky=
linos.cn> wrote:
>>>> Hi Rafael,
>>>>
>>>> Just a gentle ping on this patch.
>>> I've lost track of it for some reason, sorry.
>>>
>>>> I realized I forgot to mention an important motivation in the change=
log:
>>>> calling filesystems_freeze() twice (from both suspend_prepare() and
>>>> enter_state()) lead to a black screen and make the system unable to =
resume..
>>>>
>>>> This patch avoids the duplicate call and resolves that issue.
>>> Now applied as a fix for 6.16-rc7, thank you!
>>
>> Thanks for the reply!
>>
>> Just a quick follow-up question =E2=80=94 we noticed that even when th=
e =E2=80=9Cfreeze
>> filesystems=E2=80=9D feature is not enabled, the current code still ca=
lls
>> filesystems_thaw().
>>
>> Do you think it would make sense to guard this with a static key (or
>> another mechanism) to avoid unnecessary overhead?
> Possibly, if this overhead is significant, but is it?

We've done some testing using ftrace to measure the overhead of=20
filesystems_thaw(). When freeze_filesystems is not enabled, the overhead=20
is typically around 15=E2=80=9340 microseconds.

However, when freeze is enabled, we observed that filesystems_thaw() can=20
take over 3 seconds to complete (e.g.,=C2=A03,450,644=C2=A0us in one test=
 case).

freeze_filesystems=C2=A0 not enabled:

# tracer: function_graph
#
# CPU=C2=A0 DURATION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 FUNCTION CALLS
# |=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0|=C2=A0 =C2=A0|=C2=
=A0 =C2=A0|
 =C2=A0 4) + 15.740 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A011) + 16.894 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A010) + 17.805 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0 8) + 37.762 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0------------------------------------------
 =C2=A011) systemd-54512=C2=A0 =3D> systemd-66433
 =C2=A0------------------------------------------

 =C2=A011) + 15.167 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0 6) + 16.760 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0 7) + 14.870 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0 3) + 16.171 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0 1) + 16.461 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();
 =C2=A0------------------------------------------
 =C2=A0 3) systemd-71984=C2=A0 =3D> systemd-73036
 =C2=A0------------------------------------------

 =C2=A0 3) + 28.314 us=C2=A0 =C2=A0|=C2=A0 filesystems_thaw();

freeze_filesystems=C2=A0 enabled:

 =C2=A010)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
filesystems_thaw() {
 =C2=A0 2) $ 3450644 us=C2=A0 |=C2=A0 } /* filesystems_thaw */
 =C2=A0------------------------------------------
 =C2=A0 1) systemd-72561=C2=A0 =3D> systemd-99210
 =C2=A0------------------------------------------

 =C2=A0 1)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
filesystems_thaw() {
 =C2=A0------------------------------------------
 =C2=A0 7) systemd-71501=C2=A0 =3D> systemd-99210
 =C2=A0------------------------------------------

 =C2=A0 7) $ 3429306 us=C2=A0 |=C2=A0 } /* filesystems_thaw */
 =C2=A0------------------------------------------
 =C2=A0 7) systemd-99210=C2=A0 =3D> systemd-100028
 =C2=A0------------------------------------------

 =C2=A0 7)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
filesystems_thaw() {
 =C2=A0------------------------------------------
 =C2=A0 4) systemd-53278=C2=A0 =3D> systemd-100028
 =C2=A0------------------------------------------

 =C2=A0 4) $ 3270122 us=C2=A0 |=C2=A0 } /* filesystems_thaw */
 =C2=A0------------------------------------------
 =C2=A0 7) systemd-100028 =3D> systemd-100720
 =C2=A0------------------------------------------

 =C2=A0 7) $ 3446496 us=C2=A0 |=C2=A0 filesystems_thaw();
 =C2=A0------------------------------------------
 =C2=A0 7) systemd-100720 =3D> systemd-112075
 =C2=A0------------------------------------------

 =C2=A0 7)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
filesystems_thaw() {
 =C2=A0------------------------------------------
 =C2=A011) systemd-66433=C2=A0 =3D> systemd-112075
 =C2=A0------------------------------------------

 =C2=A011) $ 3454117 us=C2=A0 |=C2=A0 } /* filesystems_thaw */



