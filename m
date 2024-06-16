Return-Path: <linux-pm+bounces-9246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A58909C5D
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 09:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2913DB2174C
	for <lists+linux-pm@lfdr.de>; Sun, 16 Jun 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B36181CE7;
	Sun, 16 Jun 2024 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="Ri4hkGLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A7B180A96
	for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718524208; cv=none; b=JsOrZJIM9RLrwY2aiUbKriOMzLm2o44ULDkcI9tyLQYEugkYlwhQh82vk/WNBOmzYCTqCM1pbHPEvvUTpM+wkjE5XRClqj3fuIDrLaNtAEM4yZQK7qoHdpTjoUphSlF41mogcJovTkkrlKDQoWhJBqHYZjlXSA85ObqaQB3mWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718524208; c=relaxed/simple;
	bh=lL/3Gk7JOk5hvvh1t0hx9ZCAjxnUHlpLEviBVGFzuKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1sPT+FWp9o4Pk0UdYyq1rPQ+KvDjdw0cGC5iZJxvk0xQr08tfkpgRziZmmIfXxbl4fpoKbUaHWl7TJHzMtxJfwLk8+Cc+p70++PyT+h5XxD+D2BBu8Vi0PEUAMuLqOX5q+07qHMS0HW+yEOoP+LwjIZ+zxCdiROgbVpiuQplrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=Ri4hkGLe; arc=none smtp.client-ip=77.238.178.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1718524198; bh=CgRzjm/nwd78x1rt0gIv5aEFf3uVyoARkr0H9nC1Zzs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ri4hkGLePaQ2AVAhMc0pzBdvcOb3kqkG9Y/X/XJ0uYs/FJta6ctMphoY0qxD7Saar6cInZc0/5ZVbO/V4BvNE3PYqWfp25i/ZZJ8TVucvzG8gdryOOwHCpDXnkdnThoNCAm/DNAaK9kYpDPbdtI5AE6B7KpoCCtHuNBIulmZOadZIOSFrpo4iWYH35hsIQ1WYT7rNeb6TdySx7FvzoH6/0LfgzZRGjq0G6vvR7C1aw/3MOKsodBRk2qUyhRk43IrLq1n3igP6MLl8UxdDLe0R48xEKwqSjjMpTzmnp2kUf6dfjVUq+0qPvHO16Tit+cwkRn6JaaaA+X/sCgHwoBR5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1718524198; bh=Dti2NsSaeMdxbH8VRYVTjjq+mxGLLSO7kSU+hEJfYKU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gZJ2s4URD9DYM8N5dFcki7CBIKFp0YN7NflOWYVJ5BFYNdakC+bVFUeEF1HC01OtoCCI10WyncIh4M/Njpd4Co3nBOyMVuggy7/52quAMzz4KD1xpKaJAfLD/EAN+jsWVN1Uxy5k80R3Xz64YC1NqmiyTknDae2Z+1pIYC34tchQv3iV+wR0dLCNVHtkdhWIHD8KsBRFMKmTtmlcOPRoqkUWRmvE6SE+ttey6deUc1vLMqPziC69YX2NdJi1l4GUUfoxSyYt0U0vS4Yi6hpDW6mDZ7/FDz2hAQPSWGdjoag2pED+4dH7Dz8DcOzJGI8OCfwXg5e3FhHNFGBgqmFXEA==
X-YMail-OSG: hTHgnAsVM1kWXiUg3ipkxIWXfnSXIfUM_CORVXUSpGMZh2Q3ArqoLVGhEVHI9zV
 9n98uH3SKAnnFe.KiknOov.uAz9cZYPIM3SmFh9hIydspVF.5F5BftIUJ.JVMruuKQqX2bHZUXU_
 ZXUs35XJHYfTbwVTgsHYb5ZKPnmSXTCEDRj373TdgejQ4OxjfaUWHzvmhKxn2S1q4MKfMQWVP0jO
 Gps1cetZVZsNQLlorgfD3XhaQDZP8uPQAkrm2NFnhpvaRicobWmesDYC1l4BMtUfktvQ3GYB7W9E
 DTr4wvLuM8T8mECfTUHI7PAuHa7bSMOTqr3iWREB9y04SzW2dBAt.MqDdLLzAb52K.dD7iefeHbK
 qqbGV..7D7LsaqhWtaauR.7Rjv6BYYBHexSpaF3uQHGr8RzSqyKdeSSyVr1vu8Oe8EgcoIwVdvgG
 0tlbpojdlxMGyeRBWwNjWWKmNDU4u7SEB6kmJEoWW77shL8qhKXTezhY2CNtsQI_sVQs4_SThBVw
 mE2JB9IYm4ewOmwq8sk1ho5jFUJtK2MeMpSZl1MQnT1Kk6Sz0.ywZoA.CbL_dJJTDR79EtOxVr_H
 .at_6gZbU1tY46_D9SX2UY4dOxQhWIx.nH.LJ_lTrS2bYumoA98rBvRz10CNIhx2kwlbKNJhc_X.
 Zzb5bhmzDPUutIx3hq3OihIeAKVYinx3faxGQnUlL22u6brIixJLiRzVb9BZUAGkdz3hlInK4Ue0
 Xdwrsk91HwIA6nRJft3nlV1tKMOaZ3rUakASfPT3ddqrzTwkNF4YE1d1PvriK3JN2La6UvzBc4K6
 zSrMfuiH6sLh3bMlaN5Ws.3f0a9DDIFM_c2p05vRa5Z7RT7CJh0fdE9uF9FLh0oVpuoJAKrrf1ZP
 ym7KsUBy8UvlBo.B30B9ARNLG_932qVde3JtGovZMEMNh4isN11Iv62pLy.oVXSKOEm1DI19iV2n
 bHdCgVHwO7UpE.Pk7WHnLgHZCgsaB2hB.5ly_WZW5bQXlqt4TrbioYMilA.nbXywQdLvfZn48mRj
 ZD6tzrNQcyxikKL_gvn_Ck7ch3jlGGm8JWUlQ5AnclWGW2nTIyHonNdkdlvrQGothU7XhiMaCBxM
 1UZEskQ368p07f844rbTCv2YMlodV6pkk4HBJgPESD1Mrol0NZpM.Ai0kL81toyXLsSPVK_etvif
 cJRtysIQ3xyN6A7ksp86iO5MHBiU2Ht65NnRmhGmxIL70uZyr7spFJSpHl2oPy8oTOFlRORKkTbC
 YOnhokzM446.7GEzusriUcQqkXLHSyiMjsVN_nDLU5EMcI1cAcX9MtuhmQ8BfG3sPuDUgfwArNj_
 VfSvKwaCtgfjGx1W9hghf2RdlEfl7j4q7tOO8Lx59WcmEHjsLHSWbOCJro6oeMe9iuHzsvoRMF78
 T3QkRnJyd06w89NPo.kyG9ZDuyro469LblwF5MY2uDNuKTtOxDmntZwYWHAIQlJFdqtgZHRl4LB1
 RFu9W4yI1aDQy_mWgHdvgJc_fK1SLuZ.yAGdT2ojs91LE8NfdU252t2FSbv.lC1_2zHp4WOm2RxD
 980UTLUDKvIHAB0zVQXl_q7Hy0ktjaZO4KiZPjLi44.AUY6feasEeB0_gS5YcR.U0HuamG.uuMYW
 C3EMcunMGi7TSj5UkxNxLAh7QRFQgYqfDtRM8qVF3fMd_TV68vvNnYqTdgY9no8Cxa73QXnGxQTu
 w3UclkL8G9vvHf4Zp8pFq3xuGuQy.FCyaKOAuEG1SFiNxXagzvJF5trFKvzOmb6_ZagzZ3ChB1ru
 UgGamjsiYD3VXNBe5KRujUIOhG01MH8O4jy9809tqoauCd7Xf_kUMDzBpZNoJITOMTYxcI0TX4KA
 F2dypW1cwgPW6wunm.mUTg8gJKYnnJSyireHizOn4FpRTsO6W8PS9hqQExHATuy.qccSacSctRU4
 gXqOlQfvJKvZjDH9d4AwFpKtljOpROrzlOs7GrmXDbklLKR5.vBBRwwqcB4MPwp5t08qJKkMAoF3
 8.4IA9UrrwDIVqqw_ypxxIpWAo3MFPJNNhtD9deyBQMSBb4Lb5mcEYje1JhbNT8M_s0W5zRH4GeS
 rTMT_VkwP21ImKNtpy6q_t_Ty3gkvlFcPeVTscR9NiT_L5AG53eoRl1YpyCSjDG6SNIDw5xSlV3B
 AgtAeEL79PbXPzKnWTiA66FEFCkqCJweV1rdoX1Lue4G6IEb3_gnG56sN5yX1WEPhJj96r.8SDzt
 j7w4Zsd1R7ZadzgcX7AbOtfV6KETviMeWGCHOMu_5CBRaLF88FOoh8QE9ZVs-
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: 7e3e7412-d17e-47d8-bf68-24b5f07164a1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 16 Jun 2024 07:49:58 +0000
Received: by hermes--production-ir2-85cf877599-59p75 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b11e46e9905a001c20392fbd6c3c7e53;
          Sun, 16 Jun 2024 07:39:49 +0000 (UTC)
Message-ID: <3f5d01fa-f725-429d-b6a3-7b9617b8b561@yahoo.de>
Date: Sun, 16 Jun 2024 09:39:36 +0200
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
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
 <312649b1-eea9-4346-af93-76a821e88eb7@yahoo.de>
 <CAJZ5v0jfvRWK0M3Xf=36e74cVQ9rN5T1WdZZVnuk1XmZ=xu==g@mail.gmail.com>
 <78549853-1763-40cf-9974-3fc737fad093@yahoo.de>
 <CAJZ5v0h5pQDaA-bEOmcz_TpE87kFqWLFLJC+=OLjg5ZtF3hxpQ@mail.gmail.com>
 <91d94429-fc7e-4828-914d-1a251ee1ba99@yahoo.de>
 <CAJZ5v0gPZHDfuK1FRdTAG8Eqjf0NWUQdf-_GCWsWf6dCBE=1dg@mail.gmail.com>
 <543787c3-db5b-4f63-b5e0-df508300db73@yahoo.de>
 <CAJZ5v0h7jDw3yX689nZdB+YeJbCk0vFoUgVb4Yi0cqDxjL5chQ@mail.gmail.com>
 <40ec1e53-2bc8-48aa-9909-fac9072adb57@yahoo.de>
 <CAJZ5v0jtjXfvr4GXukjyO9XsEO6K2Nfux3otpFPP4vWS_9_qEQ@mail.gmail.com>
 <CAJZ5v0hcX0JAMBA+EVZURDH1BTQ2zL-W_4BjSx0a=1oRaR90ug@mail.gmail.com>
 <CAJZ5v0jGGV=i8Swu=c8f9bwo--AckUfqZrt0zeqDWKBijG+Z3A@mail.gmail.com>
 <bcac5925-fe2b-4570-83b6-182f4a301721@yahoo.de>
 <CAJZ5v0h7WnfQxhobA6B7S3Tvo-AnKTR9kP+5aexa6rixqpyHJg@mail.gmail.com>
Content-Language: en-US
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
In-Reply-To: <CAJZ5v0h7WnfQxhobA6B7S3Tvo-AnKTR9kP+5aexa6rixqpyHJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Currently I am running kernel 6.8.12 with reverted commit.
But yesterday I had a strange behavior.
After resuming from S3 the laptop registered a low battery, immediately 
after resume (notification in KDE Plasme). But as far as I could check, 
the battery level and stats where fine. Nevertheless, after 1 minute it 
shut off. I guess the low battery reading directly after after resume 
triggered it.

It is not directly related with the commit, because I have reverted it, 
but nevertheless, maybe it is helpful to understand the underlying 
firmware issue.

I' going to test your last patch and let you know.


Am 14.06.24 um 12:18 schrieb Rafael J. Wysocki:
> On Thu, Jun 13, 2024 at 10:04 PM fhortner@yahoo.de <fhortner@yahoo.de> wrote:
>> Am 13.06.24 um 17:14 schrieb Rafael J. Wysocki:
>>
>> Let's see if the ACPI thermal zone is the real culprit.
>>
>> The attached patch only adds the delay for thermal zone 0 which is the
>> ACPI thermal zone.  It also prints the ID and type for all of the
>> resuming thermal zones.
>>
>> Please test it (removing all of the test changes/patches tried so far)
>> and let me know what happens to the battery readings.
>>
>> Patch
>>
>> thermal-delay-resume.patch
>>
>> does not work. Output according to dmesg.txt
>>
>> Attached is a slightly modified version of the last patch I sent.
>> Please test it and let me know if it addresses the problem you are
>> seeing.
>>
>> If it helps, I think we are done with this at least for now.
>>
>> patch thermal-core-resume-prio.patch with .priority = -1 does work
>>
>> One more thing to try is the attached patch (independent of the
>> previous one) to lower the priority of the thermal PM notifier to make
>> it run always after the ACPI battery one.
>>
>> Please test this one too and let me know if it works for you.
>>
>> patch thermal-core-resume-prio.patch
>>
>> with .priority = INT_MIN does also work.
>>
>> If you need any further tests, please don't hesitate to tell me so.
> No, thank you, I think you've done enough and it is appreciated.
>
> I don't see any particular drawbacks of this approach and investing
> more time in trying to get to the bottom of the issue is probably not
> worth it.
>
> I'm going to submit the last patch as the proposed solution.
>
>> Thank you for your help!
> No problem and thank you!


