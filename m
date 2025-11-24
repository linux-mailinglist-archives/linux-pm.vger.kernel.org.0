Return-Path: <linux-pm+bounces-38514-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCD4C82D39
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 00:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EFF23AC3E9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D512773DA;
	Mon, 24 Nov 2025 23:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PDyBqciv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C62550D5
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027572; cv=none; b=JBKo9CmWqkEV7U+NPzGHKg7Dh+JgN8oAXKQB0QIjuvqak+oAaG0xjSxLQ57CtJUohXjC4Lse7ZGfMCVZuPemJtfoZO9kanlrg7GqtW/6D5ed8mmSV3vvW1gFZr6Ui6BbzCv8Oq5i0RL+B3XkuL+JNhoDvWjLPyl4hXAF/YizXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027572; c=relaxed/simple;
	bh=CKkQPfuA4mTQX3dIReMiDBEqCYXR6V0F5NfG/QjHkWI=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=GixSG6EAAvFmVGyxRbLU5eZDsMyZuDz6FNSYip2nXbAZBiUbKnzO7WDaGuGyn9Xip174qAN9j/Xk9nNGLJndpv5j9xQnvRXYJk6L0zWl9mNVllt2dOHqImnsAc+uPulULhnSB3iqcyeaX+PHLP3UgCTaDlRLME0miAkRnhbrdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PDyBqciv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee1939e70bso46907261cf.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764027569; x=1764632369; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=35ja3COrzf0ZOkygCs0UlseCqaTusSLOaezq4deeUYY=;
        b=PDyBqcivXEml36mbQjGT1yDB61H2aDBElA4vkCy3FdMLCGtpMnA32DRMcOPUQmu2Bh
         bAfAFJDXjnRenhbCYN8dOqkivFa1AE4PovvuuU2ppmNL0FrSge8t/yyVUSlDPQtUTN9B
         w2WzDRhoWTRIQFViwJD6ndXyJ1j/J83d9CzT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764027569; x=1764632369;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35ja3COrzf0ZOkygCs0UlseCqaTusSLOaezq4deeUYY=;
        b=lnVZbdyA3BklydLA4LAQ6+nbr2udaaT3fA4NRGbQ2heoFmcSfMR+9mmWMGlouqejjZ
         PRdl/iDwnzl5sR99W0R8WNjgHFZ3eVBxTXtsqtiOsp2quO0PZYc5dtvWPTBIh+8LrtkN
         olUzIx2cbrOOLOywx/5EvT4cGW/dLjSqsEm+TBYptr4qiMrjvyhjJjoBl29ZzHNbWfSm
         +/weTS8sIIXaZPybwb/SWnFJXCigp3toOcnH0U2ZGvNgxm7DeTUO5bOWB0aEOk95+YwS
         H4hhx45+KQCGkygm28NyVGB8aphyxm+Up6C49dZRNthU20tIPqZgtw4o88t66VcAYbQk
         xv0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO32i3Z3UBiuG0tSGj/NuU7edt7MdgytlVABI4yiLCgXX3Z/Bm96k6CPps0uYqRvFnuYSUz0S2Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7tzK3/4GEZrwqyDu8Tnp+oLZVLd+zGIJtLmtejrNeDmJ4xKd
	KOjwSu50ckZhnknhZu1xhSfyOSMDT+W9g3wNO7dzcb4TEmf3MkZcWN0oDLLWs4p9otg=
X-Gm-Gg: ASbGncu7yVUvOE3ZjC2y7VdMB+J1K93IGM0C0OdMIWRKeXbiYKnAsLXYWXl4tiGUZ8V
	OroAzO4VXfF8TvXQHdbyQ9y+/79brUwC4exE2NiaqhVQ0Co/kQ2kDCEUtVfHiQwW3QPzD8smcbF
	MUF1RYSn6davkT6IkvuZoLMWdcvbyv5MGRqgZvT66y2YDkfp+MWnSHl2bsV2Y2BbspWNogIrX3U
	5O/9L1G20/DzfDvK1CiAQWOXf9ZQOVrRSHH+dn6zxADoMnSF96vwE9i4GLfVAaHjXT5RSGajpWY
	uIkT+GUF1kHquR4I/D4fUgh/kbCQ61xygSTD2GMbvzIWhuSybDVfK2tTeDIqp4mb1m39C8UJu9U
	C4WrljOmF2Js198xmXbatxcKxCfLsvKsW5Todtc4u4wV8D30yZ0ENS8PETwuSxFP8Ld3/JkLbqP
	A/ypUsT7IA3vEJIOzf7uCNOYcVf9N8PyHlnye7gE3rVBZ3CrPBqiGR6TFExi6Y+QdlcjXvvdj7H
	99XGAa2fswx8xr95EbH/bxgRrVpO+iFMIRpXg4+8mSf
X-Google-Smtp-Source: AGHT+IGQoO2gdIQTLz+8vfxBG1I2uXtQleWM87APvrVKhuoU5l6Ej9oUjBSz51pRupK2hvvg93HX6w==
X-Received: by 2002:a05:622a:1a8d:b0:4ed:a7ba:69c with SMTP id d75a77b69052e-4ee58920aa3mr184152711cf.83.1764027569565;
        Mon, 24 Nov 2025 15:39:29 -0800 (PST)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e574918sm109238816d6.46.2025.11.24.15.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 15:39:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------5AnWd0Wj910PJFnlsio3GPhj"
Message-ID: <4f46bc24-1a27-4f59-b082-e634f46de0d5@linuxfoundation.org>
Date: Mon, 24 Nov 2025 16:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.de>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.19-rc1

This is a multi-part message in MIME format.
--------------5AnWd0Wj910PJFnlsio3GPhj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.19-rc1.

Adds support for building libcpupower statically when STATIC=true is
specified during build.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.19-rc1

for you to fetch changes up to 059835bbfa282918a1e8e5e2d9628aa600093052:

   tools/power/cpupower: Support building libcpupower statically (2025-11-05 09:56:01 -0700)

----------------------------------------------------------------
linux-cpupower-6.19-rc1

Adds support for building libcpupower statically when STATIC=true is
specified during build.

----------------------------------------------------------------
Zuo An (1):
       tools/power/cpupower: Support building libcpupower statically

  tools/power/cpupower/Makefile | 32 +++++++++++++++++++++-----------
  1 file changed, 21 insertions(+), 11 deletions(-)
----------------------------------------------------------------
--------------5AnWd0Wj910PJFnlsio3GPhj
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.19-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.19-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggYzQzZGIxYzQxMjA1Li5hMWRmOTE5NmRjNDUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC0zNyw5ICszNyw3IEBAIE5MUyA/PQkJdHJ1
ZQogIyBjcHVmcmVxLWJlbmNoIGJlbmNobWFya2luZyB0b29sCiBDUFVGUkVRX0JFTkNIID89
IHRydWUKIAotIyBEbyBub3QgYnVpbGQgbGlicmFyaWVzLCBidXQgYnVpbGQgdGhlIGNvZGUg
aW4gc3RhdGljYWxseQotIyBMaWJyYXJpZXMgYXJlIHN0aWxsIGJ1aWx0LCBvdGhlcndpc2Ug
dGhlIE1ha2VmaWxlIGNvZGUgd291bGQKLSMgYmUgcmF0aGVyIHVnbHkuCisjIEJ1aWxkIHRo
ZSBjb2RlLCBpbmNsdWRpbmcgbGlicmFyaWVzLCBzdGF0aWNhbGx5LgogZXhwb3J0IFNUQVRJ
QyA/PSBmYWxzZQogCiAjIFByZWZpeCB0byB0aGUgZGlyZWN0b3JpZXMgd2UncmUgaW5zdGFs
bGluZyB0bwpAQCAtMjA3LDE0ICsyMDUsMjUgQEAgJChPVVRQVVQpbGliLyUubzogJChMSUJf
U1JDKSAkKExJQl9IRUFERVJTKQogCSQoRUNITykgIiAgQ0MgICAgICAiICRACiAJJChRVUlF
VCkgJChDQykgJChDRkxBR1MpIC1mUElDIC1vICRAIC1jIGxpYi8kKi5jCiAKLSQoT1VUUFVU
KWxpYmNwdXBvd2VyLnNvLiQoTElCX1ZFUik6ICQoTElCX09CSlMpCitpZmVxICgkKHN0cmlw
ICQoU1RBVElDKSksdHJ1ZSkKK0xJQkNQVVBPV0VSIDo9IGxpYmNwdXBvd2VyLmEKK2Vsc2UK
K0xJQkNQVVBPV0VSIDo9IGxpYmNwdXBvd2VyLnNvLiQoTElCX1ZFUikKK2VuZGlmCisKKyQo
T1VUUFVUKSQoTElCQ1BVUE9XRVIpOiAkKExJQl9PQkpTKQoraWZlcSAoJChzdHJpcCAkKFNU
QVRJQykpLHRydWUpCisJJChFQ0hPKSAiICBBUiAgICAgICIgJEAKKwkkKFFVSUVUKSAkKEFS
KSByY3MgJEAgJChMSUJfT0JKUykKK2Vsc2UKIAkkKEVDSE8pICIgIExEICAgICAgIiAkQAog
CSQoUVVJRVQpICQoQ0MpIC1zaGFyZWQgJChDRkxBR1MpICQoTERGTEFHUykgLW8gJEAgXAog
CQktV2wsLXNvbmFtZSxsaWJjcHVwb3dlci5zby4kKExJQl9NQUopICQoTElCX09CSlMpCiAJ
QGxuIC1zZiAkKEBGKSAkKE9VVFBVVClsaWJjcHVwb3dlci5zbwogCUBsbiAtc2YgJChARikg
JChPVVRQVVQpbGliY3B1cG93ZXIuc28uJChMSUJfTUFKKQorZW5kaWYKIAotbGliY3B1cG93
ZXI6ICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvLiQoTElCX1ZFUikKK2xpYmNwdXBvd2VyOiAk
KE9VVFBVVCkkKExJQkNQVVBPV0VSKQogCiAjIExldCBhbGwgLm8gZmlsZXMgZGVwZW5kIG9u
IGl0cyAuYyBmaWxlIGFuZCBhbGwgaGVhZGVycwogIyBNaWdodCBiZSB3b3J0aCB0byBwdXQg
dGhpcyBpbnRvIHV0aWxzL01ha2VmaWxlIGF0IHNvbWUgcG9pbnQgb2YgdGltZQpAQCAtMjI0
LDcgKzIzMyw3IEBAICQoT1VUUFVUKSUubzogJS5jCiAJJChFQ0hPKSAiICBDQyAgICAgICIg
JEAKIAkkKFFVSUVUKSAkKENDKSAkKENGTEFHUykgLUkuL2xpYiAtSSAuL3V0aWxzIC1vICRA
IC1jICQqLmMKIAotJChPVVRQVVQpY3B1cG93ZXI6ICQoVVRJTF9PQkpTKSAkKE9VVFBVVCls
aWJjcHVwb3dlci5zby4kKExJQl9WRVIpCiskKE9VVFBVVCljcHVwb3dlcjogJChVVElMX09C
SlMpICQoT1VUUFVUKSQoTElCQ1BVUE9XRVIpCiAJJChFQ0hPKSAiICBDQyAgICAgICIgJEAK
IGlmZXEgKCQoc3RyaXAgJChTVEFUSUMpKSx0cnVlKQogCSQoUVVJRVQpICQoQ0MpICQoQ0ZM
QUdTKSAkKExERkxBR1MpICQoVVRJTF9PQkpTKSAtbHJ0IC1scGNpIC1MJChPVVRQVVQpIC1v
ICRACkBAIC0yNjksNyArMjc4LDcgQEAgdXBkYXRlLXBvOiAkKE9VVFBVVClwby8kKFBBQ0tB
R0UpLnBvdAogCWRvbmU7CiBlbmRpZgogCi1jb21waWxlLWJlbmNoOiAkKE9VVFBVVClsaWJj
cHVwb3dlci5zby4kKExJQl9WRVIpCitjb21waWxlLWJlbmNoOiAkKE9VVFBVVCkkKExJQkNQ
VVBPV0VSKQogCUBWPSQoVikgY29uZmRpcj0kKGNvbmZkaXIpICQoTUFLRSkgLUMgYmVuY2gg
Tz0kKE9VVFBVVCkKIAogIyB3ZSBjb21waWxlIGludG8gc3ViZGlyZWN0b3JpZXMuIGlmIHRo
ZSB0YXJnZXQgZGlyZWN0b3J5IGlzIG5vdCB0aGUKQEAgLTI4Nyw2ICsyOTYsNyBAQCBjbGVh
bjoKIAktZmluZCAkKE9VVFBVVCkgXCggLW5vdCAtdHlwZSBkIFwpIC1hbmQgXCggLW5hbWUg
Jyp+JyAtbyAtbmFtZSAnKi5bb2FzXScgXCkgLXR5cGUgZiAtcHJpbnQgXAogCSB8IHhhcmdz
IHJtIC1mCiAJLXJtIC1mICQoT1VUUFVUKWNwdXBvd2VyCisJLXJtIC1mICQoT1VUUFVUKWxp
YmNwdXBvd2VyLmEKIAktcm0gLWYgJChPVVRQVVQpbGliY3B1cG93ZXIuc28qCiAJLXJtIC1y
ZiAkKE9VVFBVVClwby8qLmdtbwogCS1ybSAtcmYgJChPVVRQVVQpcG8vKi5wb3QKQEAgLTI5
NSw3ICszMDUsMTEgQEAgY2xlYW46CiAKIGluc3RhbGwtbGliOiBsaWJjcHVwb3dlcgogCSQo
SU5TVEFMTCkgLWQgJChERVNURElSKSR7bGliZGlyfQoraWZlcSAoJChzdHJpcCAkKFNUQVRJ
QykpLHRydWUpCisJJChDUCkgJChPVVRQVVQpbGliY3B1cG93ZXIuYSAkKERFU1RESVIpJHts
aWJkaXJ9LworZWxzZQogCSQoQ1ApICQoT1VUUFVUKWxpYmNwdXBvd2VyLnNvKiAkKERFU1RE
SVIpJHtsaWJkaXJ9LworZW5kaWYKIAkkKElOU1RBTEwpIC1kICQoREVTVERJUikke2luY2x1
ZGVkaXJ9CiAJJChJTlNUQUxMX0RBVEEpIGxpYi9jcHVmcmVxLmggJChERVNURElSKSR7aW5j
bHVkZWRpcn0vY3B1ZnJlcS5oCiAJJChJTlNUQUxMX0RBVEEpIGxpYi9jcHVpZGxlLmggJChE
RVNURElSKSR7aW5jbHVkZWRpcn0vY3B1aWRsZS5oCkBAIC0zMzYsMTEgKzM1MCw3IEBAIGlu
c3RhbGwtYmVuY2g6IGNvbXBpbGUtYmVuY2gKIAlAI0RFU1RESVIgbXVzdCBiZSBzZXQgZnJv
bSBvdXRzaWRlIHRvIHN1cnZpdmUKIAlAc2JpbmRpcj0kKHNiaW5kaXIpIGJpbmRpcj0kKGJp
bmRpcikgZG9jZGlyPSQoZG9jZGlyKSBjb25mZGlyPSQoY29uZmRpcikgJChNQUtFKSAtQyBi
ZW5jaCBPPSQoT1VUUFVUKSBpbnN0YWxsCiAKLWlmZXEgKCQoc3RyaXAgJChTVEFUSUMpKSx0
cnVlKQotaW5zdGFsbDogYWxsIGluc3RhbGwtdG9vbHMgaW5zdGFsbC1tYW4gJChJTlNUQUxM
X05MUykgJChJTlNUQUxMX0JFTkNIKQotZWxzZQogaW5zdGFsbDogYWxsIGluc3RhbGwtbGli
IGluc3RhbGwtdG9vbHMgaW5zdGFsbC1tYW4gJChJTlNUQUxMX05MUykgJChJTlNUQUxMX0JF
TkNIKQotZW5kaWYKIAogdW5pbnN0YWxsOgogCS0gcm0gLWYgJChERVNURElSKSR7bGliZGly
fS9saWJjcHVwb3dlci4qCg==

--------------5AnWd0Wj910PJFnlsio3GPhj--

