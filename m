Return-Path: <linux-pm+bounces-8423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2048D4A12
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401CB1F223E4
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2024 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC016F0DE;
	Thu, 30 May 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="GtVpZpIG"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615412BE91
	for <linux-pm@vger.kernel.org>; Thu, 30 May 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067414; cv=none; b=NPdkkDpSPpTERruYTD+wVL13JvRpam/gJPkNMA89NJrWYZ376ZsbVaBAvaZt02EBofxKpAvTwwdugRt3SvVRzeSapyf9/i1EVTNoNmhHOt0SXio+Eo8rmLzHh8KDjfp2VnJ4lW43b3Bgz+gLDQGHYeVJ7cY/LZz4hwokTI8jaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067414; c=relaxed/simple;
	bh=7aybtSefWX7qOkDAv6IB5StKPRuL/tJxPJ6SrdpSMbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhGvNV3SsSH2CEJJQv4sHZwW2zttgU3m9mywqVff/tqKuL5HBYb1gxtWIMS7A2dH7d3SBGzDeShdMTHFeE1CQHj2tf+HHzav6qe5E4fNsjCSXhK3wCNkpjEREGw2qMJSWs3/vevCxsHzg+Ajh8zW2e8fFi5/XK4j2Jx09TMTdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=GtVpZpIG; arc=none smtp.client-ip=87.248.110.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1717067410; bh=iETrNB+qFsCwf3l9yJ7zi5gWG9hU7iH9KF33EbrTrnc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GtVpZpIG6vEzffPzcSpK0xdtjB9l0sKRXjznL8JRJhUQ/Z1YvSpd2ukRmf/lo4YiQO9+XCElZkSfUyTtbf2oCLlu82H+4K1wavFJYgLs5GC3rBMFGc/j1tQZKoj+afn9Au+LbrNbAye+ueBp3JLds6R/4i6CIe9Sr3nPOSS30MkzblI2YAS+da63hlbmjbKDxDy9mWj/eldiy3wR0h9aEOWbR/mqVn14tVm5HpNseY5JN42HSbFNtD0xExmSMNmUEJXArZjq2dl+nsjJa9dvQ9JiwMbqVOt/U1aZtVw46Y9t7hW4NmbWtdmAkNlno1SNDFjdZtbG7QQSriGx+RUsZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717067410; bh=qN/73ARWOVD7b8JLgBwn8UmN12K/zYv+TSM/mGKLUuw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uI4Q6lk5VuJv48NcilSVyJBD2ZrzzvkcjtRvjWyLJ8BuNFgcuc4foWzonqAE5FqdDt8BSv8Btdjmcxb1aQB5yFOw4gyINfIYKzZXG+aQcPUNA8qcg0MoRgDXtRSercjuAPgKHn2HqpQzRsEXvksHSSPYLYUKO3jg0m49j99gsDIFUhggn2cGgBIDg+5URwwZpCA3UPQxINHe/TkVSx7w+a6IUCB8avJ1GtNdf26mrQTjXG1c+9959jOXG/aMwdmv1/tx0lrATW6fWHPo123MoJjsLtt7+HphcV5RWPqNmYxHCiCIzfpYJx1EMgODsFmz92rujkl+Gu9DPRdRWbMOgQ==
X-YMail-OSG: jPnIlbUVM1kGJcHFvgbED0RbmTTs1gsxA9pBsgR.7GO5JuGivNQxYdwwJcvB7EM
 0nOzIplJ5Xg96BJLjK9gvt8IGk2v3XB77CicaN1FzkMxKWY6FnVskGKH8wBg4t8nfUrg7FmnxURA
 .LS0iEIgVOD84GvWZwGBVhBH2DZRUe7Xp9Wh.44gCG8PuTuwHU_bs8N1b1VszVnexIS_bXUZFBfu
 _.XjLZHG8DLl6fhFUDCYyxF0lR4EoNmu53bObpy.I4kUBFYyHRHqUfO8gQCFQ1tENUfzZ4RYJN5d
 Yb.pM1FfmF8UJPJjETtMS5LekawUVKHy2galJ20meJ_9E5G5C4ShQep3mgnhCpALSop5kn5sWKdW
 zM.IF2FOyxmd8m0cZZczVTmPwcg809CJF8vTHcj9uxCx8HkEt4S541__u9X15SNNogCz9zykJY2b
 dzOMxrMUSd9OG2aWyKNXUPtIh_8wtaSuCww.hm91YdnW.69aIqjEocNIFt7XZ.NLcYNQG4w.c7Ov
 _qE9_N1c0GeEjcVchfrJQHFUCCcvbIv7UMvh2hKaE4MPnvWI8ZrH1E7xcSiZJ1yyoDuklQUvDlf7
 uMkwVdNok0jJFzREALmgMd6oKf1fBxlEtPtjSjvPXPeQFtDQrnOCdlSJIhqvXGStzFOOMYF0gTBe
 yDIFwQZmdgraoQJDwRw3nFB856ziOPWHDHQiGmnVQFhcA6xZ95XJ6Y3a12xrWb2nqsijzaARZeC7
 .wGwI8W646x9VQgPDtO0wIC5jRKExiKq3iVsbsC6IcYfPahJzzNXbj4ubIA.HHSq8fJ5xFsRQd6v
 FKoUsj3WdqlUXF44ys9Ao_G9j3UL41y_8VH99KIT8QO23W84rHkDWhQ_Hs_wXFy4VxgSFQRza8.x
 Re9cA0vm_bxPyix9lqIGNqdcGuiPAMjNGyegC6U.w.ukiqPM.HybvPmpuApQXTrOdiFvdt.lPNQO
 X71Q32m3_GPh5e9.JqRcRKhT60ZAJG_MAXmuJoZfKuvc_ZYjB9gPhjfR05vYMIBVR3Ca9N3xapB3
 ZkZhWPZH4t40zSbUUIUsL0Tu0LtyKP50BgIz_2dXmWjVzc_MCOaqytkGnEUygn9ZUW8ruKD63e.I
 JjMusee0NV1ZHZ9Op_KVZpS3.wzf0aq9_zPlH7oq6D9W76og.GyKek59abR3E0os7UAy1Kscr0Nb
 Rh1MWnMrxiytEc.ZxbFxZra4gK5x.O8PbPNZwkKh5b33kNokdN7Ci67qkkjtcwaLzieGHGjcuTp1
 OMfNRIm2P1rbzbJ7wjiSytQHfgqZtoNnFP39reDUWpIawhGY3PUM2Q1KTiHkjKokb5efGHjbSzm1
 r1bh4A6S7di6VwkEH8kgn6PWZI2RR1.2GsEgjn6ISsNhR2kws8mVTjLnySGKXtMlfLEqrT6c1u1J
 j2K_nripyC6wcZxueWuTqD3HTuE5LVyA6MnlESR4kDg0Kg9fzKdNAd9RygZi_SAGArbIVsnwIvNs
 ac6bDYuv9RTS_Un7IqRpHoR9xWf0FisbUHhFvtEoMnSwPv3AS45d..QNplndD68xkCuyLPzREvB.
 7AQbzBwAYoNyb02CexkvTr9.5MJQZ0jwwOkosLtdfdhfBGw4ZqicRLcES.loP5gJcL1HwttNMJsk
 _uhPPSD8xgM4QBaNbCuWa4tIfyjootj2.lI0Z1WvNF8.xUFg2ckFXE7khrnA1f8OwhsCKlKUUj0A
 LavwfR8.KD2Juclegt0.33OPjw086LZUSkJerbo64uTFo0092Ke2Hh2ysAKVGDSmfw6oUemiUjsg
 yRUNRkdWGCeBE9E8Abq4KxHugijQyNr_Gz4EPgcHQDfU2byos8xuSHE9XuBuZvC9VfuDk.oMGPCe
 olGnNvKl1BgYnJhIkXljLxokGeLYqb7AAoTA8IXsAbHaGb..Baw4tXmuZrhgzeodmD.jH7Hpcg4Z
 VH78LRQCX1rkqh7E6eG4oA82PXsePZRR98F6NXX5LZEan7D7tIzYrtjcvpWOkStmNWE4xqmIA7zW
 SXNrSfFe0sMSpDlNSoMUk7n7d4DDDkzF9xauV6Dd5_E7BUxioxXlnBkQmFuD2_y62BWhH08xKOhY
 6eoAa9nxA4zYRaMhBxpE434DOyRW2anJs76kZShlFwtsSE_Ky55fnPoQJo1VDtgNXX139pclpSMi
 4uQhki2uoJA1Lgl_lwPMQWP8YIKZXdsMuiGwpx4vRMLKaxgi1WpJSEFPmKEU0cQKfJYHGOrdj8Oa
 .L5Xn_eGK91xqa0W46mApHG67EyvW1iEet_esvZR0MOolmwd8CcUgOao7wRCT
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: a515d68d-f75a-4e76-824e-73db09aabddf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 30 May 2024 11:10:10 +0000
Received: by hermes--production-ir2-7b99fc9bb6-hcsdk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d50324578d537739bc53c7e42086909d;
          Thu, 30 May 2024 10:49:53 +0000 (UTC)
Message-ID: <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
Date: Thu, 30 May 2024 12:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
 <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
Content-Language: de-CH
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
In-Reply-To: <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Thanks Thorsten for the side note.

I have compiled kernel 6.8.11 with reverted commit 
5a5efdaffda5d23717d9117cf36cda9eafcf2fae.

Battery Status works fine now with reverted commit after S3 Sleep and 
Wake cycles.

Best, Reinhard


Am 30.05.24 um 12:21 schrieb Linux regression tracking (Thorsten Leemhuis):
> [adding the culprits author, LKML, and the regression mailing list to
> the list of recipients; changing subject, too]
>
> On 29.05.24 21:52, fhortner@yahoo.de wrote:
>> After bisection I have reported a bug according to thermal_core.c:
>> After "Resume thermal zones asynchronously" commit: Wrong Battery
>> Reading after Wake from S3 Sleep - Lenovo Thinkpad P1 Gen2
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=218881
>> Could you please have a look at it
>>
>> I have performed a bisection and the culprit is this commit: Resume
>> thermal zones asynchronously
>> git bisect bad 5a5efdaffda5d23717d9117cf36cda9eafcf2fae
>> # first bad commit: [5a5efdaffda5d23717d9117cf36cda9eafcf2fae] thermal:
>> core: Resume thermal zones asynchronously
>>
>> I have also verified it by compiling a kernel
> Side note: not critical at all, but would have been good if you had
> specified which kernel version you build.
>
>> without this commit.
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
>
> #regzbot ^introduced 5a5efdaffda5d23717d9117cf36cda9eafcf2
> #regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=218881
> #regzbot title
> #regzbot ignore-activity
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.


