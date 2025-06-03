Return-Path: <linux-pm+bounces-27999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE62ACC3E0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467A6160F5A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D81684A4;
	Tue,  3 Jun 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b="QP31pX6E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FE1FBCAA;
	Tue,  3 Jun 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944904; cv=none; b=VDSFhc6pZnACp/rs4eMWAtl8B3oIiPqedjE/HWBAb2fGPuLc5UQP4UAHXHUxLznhZ0vKE34S+DOAQLS2gDR0UbZQbTtNVaLb8Arjfj2Q9pejQIbJAm71G1rBYF2DiSe8QNXthVD5lmF39jCoORHSbMsttIhJv919jKp6g4AAsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944904; c=relaxed/simple;
	bh=nCeqPXWEeQGgg8PQ5vWOHsYXK+FLWcyCgzaPhfe2CpU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0l7SrAXSpM6o+rdbSOqKOxT6zPyEnJR8Iuz0ie6j7+WRXgohd7e8Js4xiY/YxhK1v+wkUrxdOD9/5UE83L5+tx7CO4SIBHWMpi7Qa8rQx6vtpyuoyChf4/LsIsqLUlZsh3PIcgy0RvbP9UBq1I0QytYozq7uZYK2M8/K+Ee5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie; spf=pass smtp.mailfrom=nxsw.ie; dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b=QP31pX6E; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxsw.ie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
	s=protonmail2; t=1748944897; x=1749204097;
	bh=CBAH/23nxlGM/ZU/D/m7DXgdjxhIQMXn6Xg7PJlyxmc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QP31pX6EMqJiIyY6ciLORrW5ZjTg7jPcfvbJkb4CcNDLoe9Gy5vFCz4FN/7tnYwBf
	 PDUCksJjO6qiXzm5rhpddUMmG/j0+jOUXeaGODxQeQb7d0gquC9GSVLdum3If8pO1c
	 Jvt2BoRAhrxeRJ6kwuZU86YSzol/XGB5a3ZP9p9/KOie5e/1eCwqRkuewvJZrKn//L
	 dqCl0OMT0lhZn0p3uj9hSbf7FgC4llqfttzFFsGQf1C4Eptg4D+SxAMFv5O9ggQeFu
	 JBKhl7EOk0AXTgOVrydcEA8wHVSrkUFvKwsqXXZr+T8f3rpcnmRNT8/zvWtvLFCPoK
	 QrTBxMJ44gScQ==
Date: Tue, 03 Jun 2025 10:01:31 +0000
To: Gabor Juhos <j4g8y7@gmail.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Georgi Djakov <djakov@kernel.org>, Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: avoid memory allocation when 'icc_bw_lock' is held
Message-ID: <04ab699e-b344-4ba1-9ca1-04b6e50beefe@nxsw.ie>
In-Reply-To: <75a46897-040f-4608-88f5-22c99c8bed97@gmail.com>
References: <TIkPOGVjPeCjPzjVtlSb6V5CIcpaXf2-6WG6HjAyaOW59Hj01-9VK7Z8DKadakOKr6fJeQICi6h0Z8mft9DQyg==@protonmail.internalid> <20250529-icc-bw-lockdep-v1-1-3d714b6a9374@gmail.com> <ca9f7308-4b92-4d23-bfe7-f8d18d20de10@linaro.org> <75a46897-040f-4608-88f5-22c99c8bed97@gmail.com>
Feedback-ID: 136405006:user:proton
X-Pm-Message-ID: 6c201d29837aedc835aef573575e37b6eb34dd3b
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2025 10:15, Gabor Juhos wrote:
> Hello Bryan,
>=20
> Sorry for the late reply, I missed your mail.
>=20
> 2025. 05. 30. 11:16 keltez=C3=A9ssel, Bryan O'Donoghue =C3=ADrta:
>> On 29/05/2025 15:46, Gabor Juhos wrote:
>>> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
>>> ("interconnect: Fix locking for runpm vs reclaim") in order
>>> to decouple serialization of bw aggregation from codepaths
>>> that require memory allocation.
>>>
>>> However commit d30f83d278a9 ("interconnect: core: Add dynamic
>>> id allocation support") added a devm_kasprintf() call into a
>>> path protected by the 'icc_bw_lock' which causes this lockdep
>>> warning (at least on the IPQ9574 platform):
>>
>> Missing a Fixes tag.
>=20
> Erm, it is before my s-o-b tag.

Great thank you I see that.

> ...
>=20
>>> Move the memory allocation part of the code outside of the protected
>>> path to eliminate the warning. Also add a note about why it is moved
>>> to there,
>>>
>>> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation sup=
port")
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> ---
>>>  =C2=A0 drivers/interconnect/core.c | 14 ++++++++++----
>>>  =C2=A0 1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>> index
>>> 1a41e59c77f85a811f78986e98401625f4cadfa3..acdb3b8f1e54942dbb1b71ec2b170=
b08ad709e6b 100644
>>> --- a/drivers/interconnect/core.c
>>> +++ b/drivers/interconnect/core.c
>>> @@ -1023,6 +1023,16 @@ void icc_node_add(struct icc_node *node, struct
>>> icc_provider *provider)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&icc_lock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (node->id >=3D ICC_DYN_ID_START) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Memory allocation m=
ust be done outside of codepaths
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * protected by icc_bw=
_lock.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->name =3D devm_kasprin=
tf(provider->dev, GFP_KERNEL, "%s@%s",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no=
de->name, dev_name(provider->dev));
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&icc_bw_lock);
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->provider =3D provider;
>>> @@ -1038,10 +1048,6 @@ void icc_node_add(struct icc_node *node, struct
>>> icc_provider *provider)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->avg_bw =3D node->init_avg;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->peak_bw =3D node->init_peak;
>>>
>>> -=C2=A0=C2=A0=C2=A0 if (node->id >=3D ICC_DYN_ID_START)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->name =3D devm_kasprin=
tf(provider->dev, GFP_KERNEL, "%s@%s",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no=
de->name, dev_name(provider->dev));
>>> -
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (node->avg_bw || node->peak_bw) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (provider->p=
re_aggregate)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 provider->pre_aggregate(node);
>>>
>>> ---
>>> base-commit: 5fed7fe33c2cd7104fc87b7bc699a7be892befa2
>>> change-id: 20250529-icc-bw-lockdep-ed030d892a19
>>>
>>> Best regards,
>>> --
>>> Gabor Juhos <j4g8y7@gmail.com>
>>>
>>>
>>
>> The locking in this code is a mess.
>>
>> Which data-structures does icc_lock protect node* pointers I think and w=
hich
>> data-structures does icc_bw_lock protect - "bw" data structures ?
>>
>> Hmm.
>>
>> Looking at this code I'm not sure at all what icc_lock was introduced to=
 do.
>=20
> Initially, only the 'icc_lock' mutex was here, and that protected 'everyt=
hing'.
> The 'icc_bw_lock' has been introduced later by commit af42269c3523
> ("interconnect: Fix locking for runpm vs reclaim") as part of the
> "drm/msm+PM+icc: Make job_run() reclaim-safe" series [1].
>=20
> Here is the reason copied from the original commit message:
>=20
>      "For cases where icc_bw_set() can be called in callbaths that could
>      deadlock against shrinker/reclaim, such as runpm resume, we need to
>      decouple the icc locking.  Introduce a new icc_bw_lock for cases whe=
re
>      we need to serialize bw aggregation and update to decouple that from
>      paths that require memory allocation such as node/link creation/
>      destruction."

Right but reading this code.

icc_set_bw();
icc_lock_bw - protects struct icc_node *

icc_put();
icc_lock - locks
icc_lock_bw -locks directly after protects struct icc_node *

icc_node_add current:
icc_lock - locks
icc_lock_bw - locks
     node->name =3D devm_kasprintf();

After your change

icc_node_add current:
icc_lock - locks
     node->name =3D devm_kasprintf();
icc_lock_bw - locks
     owns node->provider - or whatever

And this is what is prompting my question. Which locks own which data here =
?

I think we should sort that out, either by removing one of the locks or=20
by at the very least documenting beside the mutex declarations which=20
locks protect what.

---
bod



>> Can we not just drop it entirely ?
>=20
> I'm not an expert in locking, but I doubt that we can easily drop any of =
the two
> mutexes without reintroducing the problem fixed by the change mentioned a=
bove.
>=20
> [1] https://lore.kernel.org/all/20230807171148.210181-1-robdclark@gmail.c=
om/
>=20
> Regards,
> Gabor
>=20
>=20

Right - if this were a struct we would declare what these individual=20
mutexes lock.

That's my question here, as I review this code, which mutex protects what ?

I don't think that is particularly clear.


