Return-Path: <linux-pm+bounces-41191-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBLRJuvxb2m+UQAAu9opvQ
	(envelope-from <linux-pm+bounces-41191-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:21:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 318004C27C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 22:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A97AEAE1D27
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E413659EF;
	Tue, 20 Jan 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YU3ZaE4R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7433A9DD
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941678; cv=none; b=MihKsJCJuh8xyJwbwQs1+bcV5+us4CSmiKkXg/7omaFtfPcPYE/3Ma8c1ZAUv0iko2T5XhRmMGq5gs2Ozox6vDgnpFvxE+x0rAcQgb5xNkZE3tCArOSQX+Bo3oQRcnyH1wh1xFE+7AhacGWiZFNe7IX9CXOww114P1dJIEuXYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941678; c=relaxed/simple;
	bh=FbADzwAMmIhfgXwvxB6LpUjnRDWp9le1lahUNkx+13A=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=LpSjdH1Zoyd3MLApBotNIFSI2E9RXHHOyiAs4fkmZvHT28tT+nLeXTJCeMTvY3aXrjmo00oy89fdTDJbmRg6lxCFZxAVrRWaClXYqY3vPlUX8zOEWu4T1teO77/kpol350Fd+LeOfkO9rlwL7QwG/3oZ+78noULFXNF5afmT4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YU3ZaE4R; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d148f68357so115403a34.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768941675; x=1769546475; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jhsa0qjiIMta9ddUxGdhEG42ACi6czgAQoEWwGEHud0=;
        b=YU3ZaE4R0hk+avbYjeLGPMD7aT9mEMEKahg+l3lo0RDSCUS+HMiDFQa6/U3uNwPSr5
         nYYvDnmnwJVeaannWVxZNTsZI2M4j0UR06Lx9Fv7hmukMTGIJlbq0YnUThSRXjFT0pZR
         zxZyFpeSwxV3SBp6YdmnNW5wmGHqDyhxuAPFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941675; x=1769546475;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jhsa0qjiIMta9ddUxGdhEG42ACi6czgAQoEWwGEHud0=;
        b=vTeHF0BuckajHWOp5+oj242AtOsJhhpDcO8bgR7Mf0o8p3mGBhoKsOSicynG5w98VK
         wJ111JmyOvwf7rYOqfM4KbOGX2zb7D3yVE8FCgb02c1rU0pxHISEIH0MHCpo3s4WDwj1
         TqIrpvZCedJgrFof+9tGh+cgCWaHR/JoEiiA8OTtlbWKPkWxM0NOJMSF2n+AmJrx90kJ
         eQG37ydw/ewHZI8TSnqdx+jwaCmiwHY0N5BpNNW9jNkiKCJ9JKdONLtzUqb34xgerEp5
         UcHcAjThJq7Al3hw+fOI5rXnI8TiOYw5M4EL78E+7zTQfV2hA7f+vLdbFQorDcgKwSD2
         Xtxw==
X-Forwarded-Encrypted: i=1; AJvYcCWXuvqLagMeZmrE1sdi0W6PANjBeZzZurXJeLUDKYf/+ukildBuqXkobWHMHbN02fWDQTwW05c2pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkyOFSXGmMXjS2yo49ODFbQhgCYOObSIh0ChCUvRfib1eeyge
	KAltSORfRDuYyfNLbK+wtJnThkdbe+4EVO3WCcorWmGmNa7T2xk4OQb1IFFMJNt/YaasMZ8Qn17
	pCTAh
X-Gm-Gg: AY/fxX7K1Po6jFP5I8sMDYXV/Nb563YjFppfQR3/DDdhwO/idkW66z+isixUon79zzy
	9ocwozxBkNmnOIK2ReBZsEly4+ysfSu3k1bpPopQawpFP+Cn3ThH0dlIR8vvy79KJer98MJinZn
	xADqIipcoTSv6ayD5qAgacgfD1gtFF/SMm4bXe21e/4idBgyvs2T2JMtLM6PN2KYl2m/M8FTBED
	8+0IYcni9nh9X1Lte10eJ9zBh6FSBFnnUTh0rG/1F9bneZKcV7XfQM5qakNNxDX7ESKWS8B3NQI
	K7qIw5oa5ciXYSbzSqwL3EWrNX5dvvCVPAwhRAObtGJRj+pKyTf4UZTR6+NbuLFsm4Jt1nvzIai
	8v2KuAFVmn2aRuPOQ+5ZZl9XEjQOL6kg9YUzejMZ5K9Ef1LURS/qb4OpozEho4BaizFy4VsrPXa
	nNUbRPZZ1cZRhtugrE2O8GwQc=
X-Received: by 2002:a05:6830:61cd:b0:7c6:cf19:1df1 with SMTP id 46e09a7af769-7cfdee5d5a1mr7081252a34.30.1768941674992;
        Tue, 20 Jan 2026 12:41:14 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a696esm9120114a34.21.2026.01.20.12.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 12:41:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------tQquzoOLZru41ggz730W9hJo"
Message-ID: <8cd367ed-3b80-4233-ac71-77a88782ed2f@linuxfoundation.org>
Date: Tue, 20 Jan 2026 13:41:13 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower second update for Linux 6.20-rc1
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ATTACHMENT(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-41191-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 318004C27C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------tQquzoOLZru41ggz730W9hJo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

Please pull the following cpupower second update for Linux 6.20-rc1.

Improve the installation procedure by making this systemd step optional
enabling users to disable installation of systemd's unit file.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ff72619e11348ab189e232c59515dd5c33780d7c:

   tools/power cpupower: Show C0 in idle-info dump (2025-12-15 12:33:29 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.20-update-2

for you to fetch changes up to 7799ba2160e4919913ecabca8a7fc1aa4c576fb4:

   cpupower: make systemd unit installation optional (2026-01-16 13:41:26 -0700)

----------------------------------------------------------------
linux-cpupower-6.20-update-2

Improve the installation procedure by making this systemd step optional
enabling users to disable installation of systemd's unit file.

----------------------------------------------------------------
João Marcos Costa (1):
       cpupower: make systemd unit installation optional

  tools/power/cpupower/Makefile | 17 ++++++++++++-----
  1 file changed, 12 insertions(+), 5 deletions(-)
----------------------------------------------------------------
--------------tQquzoOLZru41ggz730W9hJo
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.20-update-2.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.20-update-2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggYTFkZjkxOTZkYzQ1Li45Njk3MTZkZmU4ZGUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC0zMTUsNyArMzE1LDE3IEBAIGVuZGlmCiAJ
JChJTlNUQUxMX0RBVEEpIGxpYi9jcHVpZGxlLmggJChERVNURElSKSR7aW5jbHVkZWRpcn0v
Y3B1aWRsZS5oCiAJJChJTlNUQUxMX0RBVEEpIGxpYi9wb3dlcmNhcC5oICQoREVTVERJUikk
e2luY2x1ZGVkaXJ9L3Bvd2VyY2FwLmgKIAotaW5zdGFsbC10b29sczogJChPVVRQVVQpY3B1
cG93ZXIKKyMgU1lTVEVNRD1mYWxzZSBkaXNhYmxlcyBpbnN0YWxsYXRpb24gb2YgdGhlIHN5
c3RlbWQgdW5pdCBmaWxlCitTWVNURU1EID89CXRydWUKKworaW5zdGFsbC1zeXN0ZW1kOgor
CSQoSU5TVEFMTCkgLWQgJChERVNURElSKSR7dW5pdGRpcn0KKwlzZWQgJ3N8X19fQ0RJUl9f
X3wke2NvbmZkaXJ9fDsgc3xfX19MRElSX19ffCR7bGliZXhlY2Rpcn18JyBjcHVwb3dlci5z
ZXJ2aWNlLmluID4gJyQoREVTVERJUikke3VuaXRkaXJ9L2NwdXBvd2VyLnNlcnZpY2UnCisJ
JChTRVRQRVJNX0RBVEEpICckKERFU1RESVIpJHt1bml0ZGlyfS9jcHVwb3dlci5zZXJ2aWNl
JworCitJTlNUQUxMX1NZU1RFTUQgOj0gJChpZiAkKGZpbHRlciB0cnVlLCQoc3RyaXAgJChT
WVNURU1EKSkpLGluc3RhbGwtc3lzdGVtZCkKKworaW5zdGFsbC10b29sczogJChPVVRQVVQp
Y3B1cG93ZXIgJChJTlNUQUxMX1NZU1RFTUQpCiAJJChJTlNUQUxMKSAtZCAkKERFU1RESVIp
JHtiaW5kaXJ9CiAJJChJTlNUQUxMX1BST0dSQU0pICQoT1VUUFVUKWNwdXBvd2VyICQoREVT
VERJUikke2JpbmRpcn0KIAkkKElOU1RBTEwpIC1kICQoREVTVERJUikke2Jhc2hfY29tcGxl
dGlvbl9kaXJ9CkBAIC0zMjQsOSArMzM0LDYgQEAgaW5zdGFsbC10b29sczogJChPVVRQVVQp
Y3B1cG93ZXIKIAkkKElOU1RBTExfREFUQSkgY3B1cG93ZXItc2VydmljZS5jb25mICckKERF
U1RESVIpJHtjb25mZGlyfScKIAkkKElOU1RBTEwpIC1kICQoREVTVERJUikke2xpYmV4ZWNk
aXJ9CiAJJChJTlNUQUxMX1BST0dSQU0pIGNwdXBvd2VyLnNoICckKERFU1RESVIpJHtsaWJl
eGVjZGlyfS9jcHVwb3dlcicKLQkkKElOU1RBTEwpIC1kICQoREVTVERJUikke3VuaXRkaXJ9
Ci0Jc2VkICdzfF9fX0NESVJfX198JHtjb25mZGlyfXw7IHN8X19fTERJUl9fX3wke2xpYmV4
ZWNkaXJ9fCcgY3B1cG93ZXIuc2VydmljZS5pbiA+ICckKERFU1RESVIpJHt1bml0ZGlyfS9j
cHVwb3dlci5zZXJ2aWNlJwotCSQoU0VUUEVSTV9EQVRBKSAnJChERVNURElSKSR7dW5pdGRp
cn0vY3B1cG93ZXIuc2VydmljZScKIAogaW5zdGFsbC1tYW46CiAJJChJTlNUQUxMX0RBVEEp
IC1EIG1hbi9jcHVwb3dlci4xICQoREVTVERJUikke21hbmRpcn0vbWFuMS9jcHVwb3dlci4x
CkBAIC00MDYsNCArNDEzLDQgQEAgaGVscDoKIAlAZWNobyAgJyAgdW5pbnN0YWxsCSAgLSBS
ZW1vdmUgcHJldmlvdXNseSBpbnN0YWxsZWQgZmlsZXMgZnJvbSB0aGUgZGlyIGRlZmluZWQg
YnkgIkRFU1RESVIiJwogCUBlY2hvICAnICAgICAgICAgICAgICAgICAgICBjbWRsaW5lIG9y
IE1ha2VmaWxlIGNvbmZpZyBibG9jayBvcHRpb24gKGRlZmF1bHQ6ICIiKScKIAotLlBIT05Z
OiBhbGwgdXRpbHMgbGliY3B1cG93ZXIgdXBkYXRlLXBvIGNyZWF0ZS1nbW8gaW5zdGFsbC1s
aWIgaW5zdGFsbC10b29scyBpbnN0YWxsLW1hbiBpbnN0YWxsLWdtbyBpbnN0YWxsIHVuaW5z
dGFsbCBjbGVhbiBoZWxwCisuUEhPTlk6IGFsbCB1dGlscyBsaWJjcHVwb3dlciB1cGRhdGUt
cG8gY3JlYXRlLWdtbyBpbnN0YWxsLWxpYiBpbnN0YWxsLXN5c3RlbWQgaW5zdGFsbC10b29s
cyBpbnN0YWxsLW1hbiBpbnN0YWxsLWdtbyBpbnN0YWxsIHVuaW5zdGFsbCBjbGVhbiBoZWxw
Cg==

--------------tQquzoOLZru41ggz730W9hJo--

