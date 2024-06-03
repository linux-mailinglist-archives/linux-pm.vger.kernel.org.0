Return-Path: <linux-pm+bounces-8539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEB8D89EB
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7711B1F25DBC
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8122F14;
	Mon,  3 Jun 2024 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="cS/RSmWP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF823A0
	for <linux-pm@vger.kernel.org>; Mon,  3 Jun 2024 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442428; cv=none; b=tmJyyNAQ7q0EZ5Fb6ezhGNV/NbAbfZTE07Loz/excFCdrfklQXP2iwliHTVKgVr+z6LF1c2HLcGyNOCGc+mRFbTcLN8AFDRX5gj6Wr6tC6+rPZdlQKKcBEctc3aYCxumULG8Gmo3NE+6rFM98IPFh8TnA7/ZsBZKAqYk33BIas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442428; c=relaxed/simple;
	bh=KPYkAqhmju7XsyzBTxmcRoWn5S92tOqYTNT7Zf42wUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O19CKTWyY+bChU4D/WZ5+ok70hWlGMFE8EBTcanoSYao1P43I+de2WNo/bc7Whx42GPMMnWJuI2yI3U3SsKy0FYeQW66mAzXPkSjhwxz5nn2TBGIsIEPUB7tUaRjP2eopZdaSLNEmqQkX789VjrMepdN3QTChfStPLezNiL5W+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=cS/RSmWP; arc=none smtp.client-ip=77.238.176.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1717442424; bh=edWCNicz5SLkhidXgXtdvBzRygTru67Exq0izoAmB5E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cS/RSmWPubxjdrQN4nQqP3ZCcsA7Ltyk2AbM3ShsQcBnWbDQBOU1bFRHO/OA6B6AOS0cHKhSA2BizZMTctQlpfl6I5REw8B6SvjRHyEaplR0xYOG63MatIT7tWBTeJVU2WLoJEGtYJKbQUgO5yi0u4N2GR2vtgtV4YdtoEXiNJbq3qwAdn19O/Lo/r9mCWHAntXBsA+Us1Vs9p0jSqGmkDbgVEkKXlP72+Dip1ESRGQXWc7LMRUSObKU3zFkOw0CHOj4ez/uP4r6ro3cyr0s9QpyR+5m9Y2Ubpy62CCHGp4AXaX9CquCq7uKtLm0t0cnX0mi2STqA4IYydmFI7XxXA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717442424; bh=BH+09kuHjtL6jaAMnpWs4j4nBCDiUgbWy6dJqw0Hq6n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZWs4qOTff5LwdlJOuBcIIcX3zvjJJ8A9qgiGxx6hZKQNnCGFXaZyc++g+u7JN0AAZN/90edOa9hdlyCUJBg6I6PPY+thwVdeiRMe5Ry/j5pJBBqDSV5Bmc1VzizSbQMA8KqBOwgGK/T3E749MBX0TkKdFSjJAljdpRRgoTx0wYY0CqeB4f3y4bL0L+uukR9IercdZWMomAvUeZ/mXtPbFrMEuDQAz1qF+IYzIYgJDF02tqhu4Sucns1ZUSXeTpYNVey+dkLS1E8/b//ALvXKu6O3xY/cYLAM6iWNgzoDfaYZx1ywxzsglVaZjFXM5y01BVJtXBGujErzjSDL8YlnJQ==
X-YMail-OSG: RRRAq.cVM1n6crMbCT.spnjMTieSo.tt0qvtB4AOa0lp934HpKZRmcMBUd.S_Fs
 pqKphfUtzKyDdzA0YyYE_2_O5wds9gfEJHib7hAywVMfMKFSIYpdBpb9khpv0e0n.0UEnoPCdBhv
 O3wF1k7a7OzlcFMzX84f_cAo56wUB92GVfIeXQSWK9KSewfWkTE2Fadgap0U93tlS_ONLoqOldOa
 QNkeTZDtXt2cMCoZJP.be62Hm4fjUlCbxIpvkuo6FPXlbv7PyIZAbklVazvfFTW9JPAku1Nllhdh
 OaBDpvdiqdgZM7NjZeiWKNFOWDah2Xcurs2qLEbGPAK8.jD8wfSIkjPOHj00c8yepEQowSgPi_MW
 vBUlcUBLj5Oa5DCYwNg7KZb.6uyTBh1mDz14pv.gb9sp9OaYbLHMKGcikhLextuU0sfe9rvLP0Si
 _6SFGmQ7UwNqTK2YdjOJR62CQF3W5TnqYpJdKc0eyoHdGKwkFCrxpMiZTJ7hAbBvw2iETrABl8hr
 tvADER.UGLaUsf47f70aclGO7w1cAz7sngtu5tq.THxK2fyX8_PrXb2fKVHogj4JnXCuzokj8bI7
 7RJ56L82la.HeIumagtCCEf06xQ1HTyY1HmWivB_UWqDcSH9twW4awJim9pDZpbE2F.itilM3wr9
 e6HMUjnEcglfYUrKgQcdnUTw.cuwAztFaBu5c9HrpI3YJNQ3sySn4YvUMR7cbZKkm_JbVz9gz0kG
 FCTOT47xmaSw7y_HWcbgQqg0H94d5gTh0eAd5TeR6RVqHJm6fBvz7Yh3dt0e9bMwxR3ly_ambSPk
 7vnJHa9Ycg79VMdy2yGRKtBY2b9YQ3KgAMD0zn5VaR7xpD5ct3dN0_tYiv_Xgj6_TmZ41JU88ept
 3O3_R8MzeohgmAQ6jiBh_4LsuQVRCly5ZQzLLUkiUxNpNWbXhy0uhGde01.IsrRKL498bIUWTotK
 hlazkSrXHiISCeeDIC73LnFLwfWtHU.GHSsz30_Yp0dBoSqIxjKu32Y.jfQ.f2BNNPZmizE86FQf
 E..nYeW__tvIDYDiPv474VlxieQvJ260emljUo2DqB3Ehh13kUbBFnH7S4Zar5N10CUiY2QWl6jx
 fRRtKL6MjBopYdy46jpc43pOHvyuHFZv06J_e2Dbz4gGJ3sQSXywrcPBzcM_BDQeocn7rGUxpJnA
 B763QKOGlvPgTaYQmZiQWMxJB6QCNKG1k71265Unc33l.RYiu50HoFVlycBlID1rALmHvjKeLht5
 mMvvcV6pGOzDgHihvoUHiGR.wESEDOYKEzOzJt39H3i41vcR0zXxDY3dQ9Sgqia_6p8eON4ZA9eG
 Y.xx9baR.EFAS3HxTPaPq.0RFkxvGNHh5ZNv1r4GA6QeadYTdwTZr8SngRzw6P3r8a8MaLjcMNDi
 uVoCDx0BpKfk7CEFCupCJK8X2VjhNDTmpAdBE_zUMNdZ46QawukiKtVfATKS0vkVwADWcylZSdt_
 BxkLBol9tx3RWMuGNo7RNG7l9HPou49C3TbuIPNvrVgpZs4qn6_Hgbabmr.nOuJbqqzY5kbvMM2z
 DzkJ0HaQlz.wWfVfiU781crKod9984S8_eFAdaJKfrbBVpsbT02LInBFo3CaqQRYDwanjuVQrLJd
 f05E3qei4DnL.gKzlDsOdnh6WYH7kcXDAZB2nWd6Ty2nwK32ZKUD_keGuayhfvYFp72NSGNi_oki
 SD3npZa3yqP_1Lu8gKP_JajAa7F5zxjNvRnaaqY8T51weOQCTmUWNjI17FbCw.8js1DDbbkmuZeB
 SBWIfhzCESrYtg0Dl7zsW2hAH.SULdOxKK5Y55LlC7Va8qN1SNlWgOX44We9bxI3POXeJMu4M03j
 WeVYwgz3QKr5AGFHW.CKI19r.40xMIVC.Tv6fVWsdbThv6.kBB585UxEg4adCdTqO2WCAaeGRwPF
 tVcCtT6J.iZLb2OPLkA9tzg4e1XBa1h2jjInP_fTMUtC3ib5hhjnA8P2Chk9GQztEjJKAab6JlIv
 sixBpNiOvdzL3nxgrJ8as0Wzhc5WGHSRtzeGuF2OqizEUjqtbnL989FBQ8ealhkUvLgmrKoEv8zQ
 qC7ktR51sFka5I7Bmqohewtn51_zL5u4q57FahRZGq6yj54y6Mqu0yVWpWa_0v4pjIDAqPu9c5LC
 HfQ6wPD2pV7geth9K5w5.pfbloEKJzoPdxBqjxruAwMGAlVeVBUdIABkQDeyDMsQL18zmdRk7gLA
 QMb7xc0jYZBMBF2L3sAgZALgqeBuxzBr47wEvxPa_Z1_SHiO9LXUzluhM3AHm
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: 83e29caa-1270-46e0-bf41-7b4f52bbe70c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 3 Jun 2024 19:20:24 +0000
Received: by hermes--production-ir2-7b99fc9bb6-z99rq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID abd44bd1c36a5049a30287d79d773928;
          Mon, 03 Jun 2024 18:49:57 +0000 (UTC)
Message-ID: <829c478d-f547-4e12-9976-ed465dd8d4ed@yahoo.de>
Date: Mon, 3 Jun 2024 20:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
 <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
 <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I Totally agree, this was also my first thought, what has the battery 
state to do with thermals.
But at least, so far, we have in total three repros confirmed in the bug 
report. All of the same machine.
Thinkpad X1 Xtreme Gen2 = Thinkpad P1 Gen2. The only difference is the 
graphics Nvidia Geforce vs Nvidia Quadro

these are the types of thermal zones:

cat /sys/class/thermal/thermal_zone*/type
acpitz
SEN6
SEN7
SEN8
SEN9
SENA
SENB
SENC
SEND
x86_pkg_temp
iwlwifi_1
INT3400 Thermal
SEN1
SEN2
pch_cannonlake
SEN3
SEN0
B0D4
SEN4
SEN5


Am 03.06.24 um 20:38 schrieb Rafael J. Wysocki:
> On Thu, May 30, 2024 at 1:10 PM fhortner@yahoo.de <fhortner@yahoo.de> wrote:
>> Thanks Thorsten for the side note.
>>
>> I have compiled kernel 6.8.11 with reverted commit
>> 5a5efdaffda5d23717d9117cf36cda9eafcf2fae.
>>
>> Battery Status works fine now with reverted commit after S3 Sleep and
>> Wake cycles.
> Well, the connection between the battery status and the resume of
> thermal zones is somewhat unclear to me at the moment.
>
> Most likely, the commit in question changes the timing of system
> resume which affects the battery behavior and it seems to be related
> to the EC somehow.
>
> Let's first see what thermal zones there are on your system, so please
> send the output of
>
> $ cat /sys/class/thermal/thermal_zone*/type


