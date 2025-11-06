Return-Path: <linux-pm+bounces-37504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBDC3AAE4
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBAE3BDA5B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA430F55F;
	Thu,  6 Nov 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gO8jBrtQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6260830EF90
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429190; cv=none; b=DCJXgxeN/paZtJKSkjpdnmrwWdMqK7k+tSsYvDfUtGSqBwa+2bW2i5mtWxn355TXlwtqPAW9lvHRd8ql8cNyPLb8/CzFfVMFzxPttgHhQW+R50MWkTO4vaNvT0OmwONGl6aAlm7xVnQeXA6CUkawDQc+P7Lz2J7pQ52FxtdigM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429190; c=relaxed/simple;
	bh=xKQgE19/4VudRw6OhSpGGYP/lLdM3l6nuvqMnfXUUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=cUHx2znk4LKh8I53MpKbCaKqKtRLfDn6rYhoRol1f/xxLLSCrjZQ6k3SwfDglYdo3lSN6DHR8Fuu4s1y4tufi7HAGhFb7HtqMW4cD3RYFZ5tUL2BJNg3oHPDqzJlGmOEu1GO6uzmP7ty9LbsrR/RQqIgcidBOatTI5F3UMuNlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gO8jBrtQ; arc=none smtp.client-ip=98.137.69.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429189; bh=2Jgz6JuZ4+ppvr2Xjv1GDz/VQcvYt0rJmz1ePYg06lw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=gO8jBrtQknJIthCfAmGdDy9psh6NHb3vaxUE5xjPa6jZxvmvycamIjK4eLIrpInkVW/F8+u15grVZb6j4qYBj+MnXXWM32ZOdzZbpLT/HFWg7bmKHczdeB9k8LXCawVdNxrNHmM1avkVzOzHg1AZA3PaG4QBo4Tc2UFamNs45Va/6haUQ/R+ElQqO93abL+02RXCP7BPnK5LcCC1ZcUTDqatqRaPvO5lWZsWR7Aole3WIsf38hwOqiyVGZD20NXPNXNCaNxte3Vde2JZawJIqYY30h3dMpW/eXu4wbxC08W1JKxRiBvG4VioV8FuTYHceqxjTHnCsszPzUD7jMvFtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762429189; bh=RU3GcLgVhtrodLJcohf6rcGvOLdmCRHaJd5ZXruwJOH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WmfF406VBvxt3RpVeVvDgPi1mRi2Gd9/fIZ2ITEHkFS8icT8fX/ZNf1BKBbhe1+5vvEWx01/CfWk6wnV7YaX9qg18EuLTxzlWL+XrilTfkD6rN/oRWGtBIAULiezjdGI9ct28E9tgs8nQnZFsLYuKqGruR3v3gu1EZduKhs3FQLq5LhVuXTR7nfiWo1xrpw9u0iVFMV1lQDjdzxBMO3aBql8m8sOqofwJ+H27DpYe/Rca0556gwWZB6huRHAoVQutInCPfwk3spdCqeYx50La65JpPWaqjcQ0ipw5xkD5pimI6Fibu7VAvX+7rVx7R0zWBBf1Yog978iaZXlGYigvg==
X-YMail-OSG: rfTIjW8VM1mTDeYmdKauX.7pLeXJMYigBwDn9kIcW2E6yoEsUdiH1FHSASvaUm9
 aDWZULO6IxrUPQ5HLEgd1ZWC16CkXytqcvjbQhsKf4hIhsyAzc_txRCauMz5QY3O6UiukOfjTY2j
 1ob.HdgMGQyyXzc3kTiNmV3hzrgIsfl47RpKGTnGz0aJ8jpyAEGCZWvAoEfK1JC9ulQcx5nEpjvg
 9xXJ86G53zrvzpyMbwTUgYZXGDtNRR9H3JL_E5CDkQFV4FYZHfz.l.6ig0e4SFEBRSxvE7OMqEVO
 j8TDW91Pj3IHPp2VN8Wk3EJv.4nylvZ50Rlxa0X6q6ArxVGIM8rkMzSXiNjowwnekqHvR3gSql50
 RK4ZdahiQ01TbAg5ZQcPkkDuVbE.pzi6c8_YGg7baphZzZlxY9mlf8eeNQOA0zTJOyjBq0_lD0Ub
 uy4BNDOWWtnxSo.wF8yMuei0YCVGktR4WXHzMS777HmoFbyi384F3H3GxybkWXKqDYltOFBBSeD7
 D0CkUjUpeR0OizK5joRHHV443uPvh3ds7F_SVfAfwAPqVu28R.4A25AyxFXdq0juz289qzqrf6FO
 f6Y3qLFMLaLwjgCp714pycBsNnq1NTkNh7g7Kh6q3RlQDN7R.IYXGaQ8RgRvOvdJbAHTaIo2jfnI
 zoxznWhokDUemDSikRcA41ORusDWF2OxpvaOPSOMjm.d243rv._nCZgPniLMd49Hk9XJrBLzwYqA
 bZSlB.OGr0_0jOHzG9MSaizoLf34dsOcUno1hCw7IAP0u323hmB22_WYJOW7LH91NyPAPSG.blTv
 Lr4EfA7bwsno66RgOnhdiLHa2xWqGdXCxgbdOSBsPb44P1fzMuVkLC3DE2aQl2gqwCdB0CfJi3MI
 Rjxp94gBzhTWQnSyECo2sMx6Mn24hy6RSBxLvlaVEFzPPScMDIseW16hOapUEH8X1FSUhqSyxEMI
 HirvDSqQM9lL95VW7XrK4kT41BkSHajdIgQt_2Ow7MdlZOWFas2HPDfehKpkD.JvsUHES3xitELF
 qWhnPwdYBnY0IWDfvZEcH3jsGhuKWA2Nvx.m1oefrj5sRh1t75YdhyaO.wVPESH_9rG6oSjEG7lF
 TR_23t8tFjUcEa3pxuHf16dnveBdSXn7Jj2jTOBbiQ7U_fJXcGQloXjNVHN_wWdGVi3a69CLP2Se
 I73Z0Wi_RQ3klayfCyY9lLwsJZ2BVF0jisiF1uS0mOiRRem.mZR9ADCvVQUGedRYXmDI_pCiukaN
 s0uu_yOz3UErCfBZMAfqCWIC5BiU9B7O5Q2CDwZMCTpjDgXN7n4.cXvn.H6.uJV5S6I3HmHgBPoY
 fvN5wQcYY07H6zvi5i9XqxVf2luNmRX9kG0ssqBRSA6Gn0chbfVOhMgweFGnJNH6mexuL1trAGwG
 xFm9q1Ta2l1_WryL0BpU84ApFkYeIyXIfVWKAAm73DyJvqEIzc4V9XfMb3doL2MBMT7CinIUF46h
 ouPDm__A.e.TjVoA2_e0j3btFvXicmGMYu9Ik8FDX7Qxmy20TTEO83qpgiJiZl87Qu2wamTqcx_g
 t3KiGjJ7usJDyD82nEr9ZQdjEYQmiMrAt_D3bZuSQY6MgHrxX0L1H2E1f5PIOLaE9UsJh1Fqv.nA
 ZLl7irSTLGmyGtxo0bPoSQ64wZv69LrihFmc9t8gVMvu2MwJpBkZcQL04maJi8vohcmBMbA4g6l1
 mA11id6XBpah4ZTN3GJlXyHPJkLRcgLmxCHATSQcrN5CoDmHcVIhG5lFy8sJZOztpYGWnGJXA3UI
 Vwe4GuacH_SeaG0guZvtWm0aAg_K35uAnjgL.TUlW.kbanhaqWsKWYMki2QeKHvZ8Is030y31uDC
 5RGU2bK1xayXCD4fEdPWQZZSyX6QRTxh.4A0PQ6b9px8uh4l_RvywXUreiWLGiUSvouYLwpcDuPc
 nXKgLYLrOW1pyYdOyk3FZBOmFfqsBemJZuoMcCljByU.lmXyhzrb_Nd5lxa2_s7nL8MluDFsBrEr
 b4yXxrcCplestzdAteaa_ClIC0twOd_T5E.iBtInd10Wc.vqeKi6t2QTur2QB0T.cERJoBFm6fZF
 9jUfV29pmVfFLPBm1EQUl7ZDyzqlGWdqADSmyq49JKLMMeZBA9kYkBNeqgtMYr5kKjZBJVQJrOpF
 V2QxfyceD1dk_WFFh.CLBx8Yz9grKXPlNOzHq84ufAAw2zb0jkjLIM1uTCu4Gn7F9KCsP0UmT.EX
 LZbMJB26uFdy8i33RHbXokkUi8TYLbHdS9aMiRLWtM_i0HBcfS0CuwsnNud7km047Qku6SbtkGEq
 SWwN.bh4aFzr6QGY8
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: ced1120a-d03f-42fb-adb3-e234ba25bbf0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Nov 2025 11:39:49 +0000
Received: by hermes--production-bf1-58477f5468-vjcpj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a2a71f3be34b9b294192b02c80d46421;
          Thu, 06 Nov 2025 11:39:46 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH 0/2] Fix kernel-doc warnings in power and time
Date: Thu,  6 Nov 2025 12:39:36 +0100
Message-ID: <20251106113938.34693-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251106113938.34693-1-adelodunolaoluwa.ref@yahoo.com>

Hi,

This small patch series fixes kernel-doc warnings in kernel/power/swap.c
and kernel/time/tick-oneshot.c by adding missing parameter and return
value descriptions. These changes improve documentation clarity and
remove "No description found for return value" warnings during doc
build.

No functional changes.

Patches:
  1/2 power/swap: add missing params and Return: descriptions to kernel-doc
                  comments
  2/2 time/tick-oneshot: add missing Return: and param descriptions to
                         kernel-doc

Thanks,
Sunday Adelodun

Sunday Adelodun (2):
  power/swap: add missing params and Return: descriptions to kernel-doc
    comments
  time: tick-oneshot: add missing Return: and param descriptions to 
    kernel-doc

 kernel/power/swap.c        | 35 +++++++++++++++++++++++++++++++----
 kernel/time/tick-oneshot.c | 20 +++++++++++++++++++-
 2 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.43.0


