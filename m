Return-Path: <linux-pm+bounces-27249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39CABA475
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E240C17399F
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24AF22A817;
	Fri, 16 May 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChYkz/Mf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B61D5143
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425967; cv=none; b=JK0f6OnxcR0R9qNxEuJGhJ8xrdyn5A/JJAOLTrsCnrPNVKwcCuWb7GUk5NoUkSRr3FUJc6MjLbX8kgGk0MYDHoY3CJqHep1ozGDGGcRTFLf2LallLKydaZBAjhPR/6YiXy8xdEiATcOgvv/k0ybLja9dcABmXsN2hBCGyIvqnNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425967; c=relaxed/simple;
	bh=1RilaV9AanlapytSMji8/44XEwPRcrX8Dnb1Uj9MwQs=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=eBWJaGLL5s6fwNU0sa7T70gqh9FH0PhPEhrizrlIpJHpZpfoylsuff6VCIjKdjS7x4Usvw4RDi41PxeZx4OMJ7lbN6EtvhzbpzEbnqNNOWFIiAF3iGI2abIWRJ1MJfkpAmMeOY9fF+0YHwgMKE3SQnWV+tBxjPoGlvuSHB4derE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChYkz/Mf; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so14181725ab.1
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747425963; x=1748030763; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RrCDbcyb51hrzxhbjwDp513lRT9XZn1GZU1MGJ7RiUI=;
        b=ChYkz/Mfi7mJJZwzZSqIULj6zeRTyL8RPCtYMiqRoKH/ekEfhQTVOhwMNFdV4Uwtya
         b00DE2tifEsJbM2Ks69KoWZO60K3D0fSGf6NkG3VRwmA3y9c6i2rE7H1RrBvlCve/Mj2
         MUL6oAQMaTBSQpi2KFvE8g20/q58/JyYsMmas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425963; x=1748030763;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrCDbcyb51hrzxhbjwDp513lRT9XZn1GZU1MGJ7RiUI=;
        b=RVTkNPvbWY040xu4SgSzm/f4CrAv1XEVG5u2J9+tbTMLXEbtI2jvsbML16xrUG+zMy
         e/mGvigxNrgxHYyPSo8RD0wQDH59Y53KATpZpanWbGcxPwzaCl02AjNA5ealSV0EjaFc
         9PpxdxmYljushnLbnRj6n8SWzMIFEvP42lFIZHpVzr0nfLWmBU158/SzeOlKUsATom6Z
         Y/X0Hg7p3Ld+oCFN8uRXCZyzDI1oHTjve+uv6gZmjol4usxtJDcQH4LV7LgcJ3prDGL/
         KiiTou/Oi+IwnbbLR/xn27tToqeKNnzpxYwbxboIcXkSvD65/pvUQSSSJoe8igJKNSmI
         nAvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHCewmP4C44/j4t/bYGboqXiyHFFTjCiA3/vC+2dyo1QHj5xjFDbakiFdtWS+Epmm0mF5Fph/Mgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnNZ7ZDq116cb41X3A3U2Sd4hY3133/cPYJ3KQDv8tHUbAU6g
	af08zvhmewO3x7FiHvHbhtFAT5NLed5/5nHHpqDHzwk/Ilq5luRfPDJSwzAluTnzn3E=
X-Gm-Gg: ASbGncsSqDJ8EHuS4qO2Og9ypkFVIqyaA/gJte5TWvZ99Nrvlzna/40x6gzMPFjrlpw
	f5MMFwq9YLQ2zBw+JampO7LVJHuAGFiSn2btq6R6Va8n4X7wckMDy27RdV+WIOHSB8FxFois8B5
	HB1rJ59yo74xNUm5yjHpmHvL9jnmzI3N9dSRwGT6KoCyVGYBSVqSGBnTgLPJwA4jKtMoJq/USuJ
	7kvtxD8wGlRP5XN4IRhvNIYcMSZ81jEPrUrxBBInXnwDO7iePWbgaDD5HSDGAu+ImVQdmPbgHxw
	YcdPE4uHGSYpUah7EpbMuZwqBftp90KBvwmoXp9MqgAN29Qz/XT8/t8xSSEtCQ==
X-Google-Smtp-Source: AGHT+IHX96qWKHcwxQ/QifPnZIDE23QvD654sy5yIWFzQRd+ifp8InaZzZuLKRu83JDuoz9BMiILhQ==
X-Received: by 2002:a05:6e02:1805:b0:3da:7176:81c0 with SMTP id e9e14a558f8ab-3db857b67cdmr36593125ab.22.1747425962729;
        Fri, 16 May 2025 13:06:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c88bsm537786173.92.2025.05.16.13.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 13:06:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------TMrgY07PXUnU0gl7Jko53ziz"
Message-ID: <b8f0f04d-ce16-4be0-93fe-b2416ee08653@linuxfoundation.org>
Date: Fri, 16 May 2025 14:06:01 -0600
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
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.16-rc1

This is a multi-part message in MIME format.
--------------TMrgY07PXUnU0gl7Jko53ziz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower  update for Linux 6.16-rc1.

Adds systemd service to run cpupower and changes binding's makefile
to use -lcpupower.

         cpupower: add a systemd service to run cpupower
         cpupower: do not write DESTDIR to cpupower.service
         cpupower: do not call systemctl at install time
         cpupower: do not install files to /etc/default/
         cpupower: change binding's makefile to use -lcpupower

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.16-rc1

for you to fetch changes up to e5174365c13246ed8fd2d40900edec37be6f7a34:

   cpupower: do not install files to /etc/default/ (2025-05-13 16:06:28 -0600)

----------------------------------------------------------------
linux-cpupower-6.16-rc1

Adds systemd service to run cpupower and changes binding's makefile
to use -lcpupower.

         cpupower: add a systemd service to run cpupower
         cpupower: do not write DESTDIR to cpupower.service
         cpupower: do not call systemctl at install time
         cpupower: do not install files to /etc/default/
         cpupower: change binding's makefile to use -lcpupower

----------------------------------------------------------------
Francesco Poli (wintermute) (4):
       cpupower: add a systemd service to run cpupower
       cpupower: do not write DESTDIR to cpupower.service
       cpupower: do not call systemctl at install time
       cpupower: do not install files to /etc/default/

John B. Wyatt IV (1):
       cpupower: change binding's makefile to use -lcpupower

  tools/power/cpupower/Makefile                 | 13 +++++++++++
  tools/power/cpupower/README                   | 28 +++++++++++++++++++++++
  tools/power/cpupower/bindings/python/Makefile |  8 +++----
  tools/power/cpupower/bindings/python/README   | 13 ++++++-----
  tools/power/cpupower/cpupower-service.conf    | 32 +++++++++++++++++++++++++++
  tools/power/cpupower/cpupower.service.in      | 16 ++++++++++++++
  tools/power/cpupower/cpupower.sh              | 26 ++++++++++++++++++++++
  7 files changed, 126 insertions(+), 10 deletions(-)
  create mode 100644 tools/power/cpupower/cpupower-service.conf
  create mode 100644 tools/power/cpupower/cpupower.service.in
  create mode 100644 tools/power/cpupower/cpupower.sh
----------------------------------------------------------------
--------------TMrgY07PXUnU0gl7Jko53ziz
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.16-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.16-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggODM1MTIzYWRkMGVkLi5iZThkZmFjMTQwNzYg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC0yLDYgKzIsNyBAQAogIyBNYWtlZmlsZSBm
b3IgY3B1cG93ZXIKICMKICMgQ29weXJpZ2h0IChDKSAyMDA1LDIwMDYgRG9taW5payBCcm9k
b3dza2kgPGxpbnV4QGRvbWluaWticm9kb3dza2kubmV0PgorIyBDb3B5cmlnaHQgKEMpIDIw
MjUgICAgICBGcmFuY2VzY28gUG9saSA8aW52ZXJub211dG9AcGFyYW5vaWNpLm9yZz4KICMK
ICMgQmFzZWQgbGFyZ2VseSBvbiB0aGUgTWFrZWZpbGUgZm9yIHVkZXYgYnk6CiAjCkBAIC03
MSw2ICs3Miw3IEBAIGJpbmRpciA/PQkvdXNyL2Jpbgogc2JpbmRpciA/PQkvdXNyL3NiaW4K
IG1hbmRpciA/PQkvdXNyL21hbgogbGliZGlyID89CS91c3IvbGliCitsaWJleGVjZGlyID89
CS91c3IvbGliZXhlYwogaW5jbHVkZWRpciA/PQkvdXNyL2luY2x1ZGUKIGxvY2FsZWRpciA/
PQkvdXNyL3NoYXJlL2xvY2FsZQogZG9jZGlyID89ICAgICAgIC91c3Ivc2hhcmUvZG9jL3Bh
Y2thZ2VzL2NwdXBvd2VyCkBAIC04Myw2ICs4NSw3IEBAIENQID0gY3AgLWZwUgogSU5TVEFM
TCA9IC91c3IvYmluL2luc3RhbGwgLWMKIElOU1RBTExfUFJPR1JBTSA9ICR7SU5TVEFMTH0K
IElOU1RBTExfREFUQSAgPSAke0lOU1RBTEx9IC1tIDY0NAorU0VUUEVSTV9EQVRBICA9IGNo
bW9kIDY0NAogI2Jhc2ggY29tcGxldGlvbiBzY3JpcHRzIGdldCBzb3VyY2VkIGFuZCBzbyB0
aGV5IHNob3VsZCBiZSBydyBvbmx5LgogSU5TVEFMTF9TQ1JJUFQgPSAke0lOU1RBTEx9IC1t
IDY0NAogCkBAIC0zMDIsNiArMzA1LDEzIEBAIGluc3RhbGwtdG9vbHM6ICQoT1VUUFVUKWNw
dXBvd2VyCiAJJChJTlNUQUxMX1BST0dSQU0pICQoT1VUUFVUKWNwdXBvd2VyICQoREVTVERJ
Uikke2JpbmRpcn0KIAkkKElOU1RBTEwpIC1kICQoREVTVERJUikke2Jhc2hfY29tcGxldGlv
bl9kaXJ9CiAJJChJTlNUQUxMX1NDUklQVCkgY3B1cG93ZXItY29tcGxldGlvbi5zaCAnJChE
RVNURElSKSR7YmFzaF9jb21wbGV0aW9uX2Rpcn0vY3B1cG93ZXInCisJJChJTlNUQUxMKSAt
ZCAkKERFU1RESVIpJHtjb25mZGlyfQorCSQoSU5TVEFMTF9EQVRBKSBjcHVwb3dlci1zZXJ2
aWNlLmNvbmYgJyQoREVTVERJUikke2NvbmZkaXJ9JworCSQoSU5TVEFMTCkgLWQgJChERVNU
RElSKSR7bGliZXhlY2Rpcn0KKwkkKElOU1RBTExfUFJPR1JBTSkgY3B1cG93ZXIuc2ggJyQo
REVTVERJUikke2xpYmV4ZWNkaXJ9L2NwdXBvd2VyJworCSQoSU5TVEFMTCkgLWQgJChERVNU
RElSKSR7bGliZGlyfS9zeXN0ZW1kL3N5c3RlbQorCXNlZCAnc3xfX19DRElSX19ffCR7Y29u
ZmRpcn18OyBzfF9fX0xESVJfX198JHtsaWJleGVjZGlyfXwnIGNwdXBvd2VyLnNlcnZpY2Uu
aW4gPiAnJChERVNURElSKSR7bGliZGlyfS9zeXN0ZW1kL3N5c3RlbS9jcHVwb3dlci5zZXJ2
aWNlJworCSQoU0VUUEVSTV9EQVRBKSAnJChERVNURElSKSR7bGliZGlyfS9zeXN0ZW1kL3N5
c3RlbS9jcHVwb3dlci5zZXJ2aWNlJwogCiBpbnN0YWxsLW1hbjoKIAkkKElOU1RBTExfREFU
QSkgLUQgbWFuL2NwdXBvd2VyLjEgJChERVNURElSKSR7bWFuZGlyfS9tYW4xL2NwdXBvd2Vy
LjEKQEAgLTMzNiw2ICszNDYsOSBAQCB1bmluc3RhbGw6CiAJLSBybSAtZiAkKERFU1RESVIp
JHtpbmNsdWRlZGlyfS9jcHVmcmVxLmgKIAktIHJtIC1mICQoREVTVERJUikke2luY2x1ZGVk
aXJ9L2NwdWlkbGUuaAogCS0gcm0gLWYgJChERVNURElSKSR7YmluZGlyfS91dGlscy9jcHVw
b3dlcgorCS0gcm0gLWYgJChERVNURElSKSR7Y29uZmRpcn1jcHVwb3dlci1zZXJ2aWNlLmNv
bmYKKwktIHJtIC1mICQoREVTVERJUikke2xpYmV4ZWNkaXJ9L2NwdXBvd2VyCisJLSBybSAt
ZiAkKERFU1RESVIpJHtsaWJkaXJ9L3N5c3RlbWQvc3lzdGVtL2NwdXBvd2VyLnNlcnZpY2UK
IAktIHJtIC1mICQoREVTVERJUikke21hbmRpcn0vbWFuMS9jcHVwb3dlci4xCiAJLSBybSAt
ZiAkKERFU1RESVIpJHttYW5kaXJ9L21hbjEvY3B1cG93ZXItZnJlcXVlbmN5LXNldC4xCiAJ
LSBybSAtZiAkKERFU1RESVIpJHttYW5kaXJ9L21hbjEvY3B1cG93ZXItZnJlcXVlbmN5LWlu
Zm8uMQpkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvUkVBRE1FIGIvdG9vbHMv
cG93ZXIvY3B1cG93ZXIvUkVBRE1FCmluZGV4IDI2NzhlZDgxZDMxMS4uOWRlNDQ5NDY5NTY4
IDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9SRUFETUUKKysrIGIvdG9vbHMv
cG93ZXIvY3B1cG93ZXIvUkVBRE1FCkBAIC01OSw2ICs1OSwxMCBAQCAkIHN1ZG8gbWFrZSBp
bnN0YWxsCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogfCBtYW4gcGFnZXMgICAgICAgICAgICAgIHwg
L3Vzci9tYW4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCit8IHN5c3RlbWQgc2VydmljZSAgICAgICAgfCAvdXNyL2xpYi9zeXN0ZW1k
L3N5c3RlbSAgICAgICAgICAgICAgICAgICAgfAorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KK3wgc3lz
dGVtZCBzdXBwb3J0IHNjcmlwdCB8IC91c3IvbGliZXhlYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBUbyBwdXQgaXQgaW4gb3RoZXIg
d29yZHMgaXQgbWFrZXMgYnVpbGQgcmVzdWx0cyBhdmFpbGFibGUgc3lzdGVtLXdpZGUsCiBl
bmFibGluZyBhbnkgdXNlciB0byBzaW1wbHkgc3RhcnQgdXNpbmcgaXQgd2l0aG91dCBhbnkg
YWRkaXRpb25hbCBzdGVwcwpAQCAtMTA5LDYgKzExMywxMCBAQCBUaGUgZmlsZXMgd2lsbCBi
ZSBpbnN0YWxsZWQgdG8gdGhlIGZvbGxvd2luZyBkaXJzOgogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
IHwgbWFuIHBhZ2VzICAgICAgICAgICAgICB8ICR7REVTVERJUn0vdXNyL21hbiAgICAgICAg
ICAgICAgICAgICAgICAgICB8CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorfCBzeXN0ZW1kIHNlcnZp
Y2UgICAgICAgIHwgJHtERVNURElSfS91c3IvbGliL3N5c3RlbWQvc3lzdGVtICAgICAgICAg
IHwKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCit8IHN5c3RlbWQgc3VwcG9ydCBzY3JpcHQgfCAke0RF
U1RESVJ9L3Vzci9saWJleGVjICAgICAgICAgICAgICAgICAgICAgfAorLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIAogSWYgeW91IGxvb2sgYXQgdGhlIHRhYmxlIGZvciB0aGUgZGVmYXVsdCAnbWFr
ZScgb3V0cHV0IGRpcnMgeW91IHdpbGwKIG5vdGljZSB0aGF0IHRoZSBvbmx5IGRpZmZlcmVu
Y2Ugd2l0aCB0aGUgbm9uLWRlZmF1bHQgY2FzZSBpcyB0aGUKQEAgLTE3Myw2ICsxODEsMjYg
QEAgVGhlIGlzc3VlIGlzIHRoYXQgYmluYXJ5IGNhbm5vdCBmaW5kIHRoZSAnbGliY3B1cG93
ZXInIGxpYnJhcnkuIFNvLCB3ZQogc2hhbGwgcG9pbnQgdG8gdGhlIGxpYiBkaXI6CiBzdWRv
IExEX0xJQlJBUllfUEFUSD1saWI2NC8gLi9iaW4vY3B1cG93ZXIKIAorc3lzdGVtZCBzZXJ2
aWNlCistLS0tLS0tLS0tLS0tLS0KKworQSBzeXN0ZW1kIHNlcnZpY2UgaXMgYWxzbyBwcm92
aWRlZCB0byBydW4gdGhlIGNwdXBvd2VyIHV0aWxpdHkgYXQgYm9vdCB3aXRoCitzZXR0aW5n
cyByZWFkIGZyb20gYSBjb25maWd1cmF0aW9uIGZpbGUuCisKK0lmIHlvdSB3YW50IHN5c3Rl
bWQgdG8gZmluZCB0aGUgbmV3IHNlcnZpY2UgYWZ0ZXIgdGhlIGluc3RhbGxhdGlvbiwgdGhl
IHNlcnZpY2UKK3VuaXQgbXVzdCBoYXZlIGJlZW4gaW5zdGFsbGVkIGluIG9uZSBvZiB0aGUg
c3lzdGVtIHVuaXQgc2VhcmNoIHBhdGggZGlyZWN0b3JpZXMKKyhzdWNoIGFzICcvdXNyL2xp
Yi9zeXN0ZW1kL3N5c3RlbS8nLCB3aGljaCBpcyB0aGUgZGVmYXVsdCBsb2NhdGlvbikgYW5k
ICh1bmxlc3MKK3lvdSBhcmUgd2lsbGluZyB0byB3YWl0IGZvciB0aGUgbmV4dCByZWJvb3Qp
IHlvdSBuZWVkIHRvIGlzc3VlIHRoZSBmb2xsb3dpbmcKK2NvbW1hbmQ6CisKKyQgc3VkbyBz
eXN0ZW1jdGwgZGFlbW9uLXJlbG9hZAorCitJZiB5b3Ugd2FudCB0byBlbmFibGUgdGhpcyBz
eXN0ZW1kIHNlcnZpY2UsIGVkaXQgJy9ldGMvY3B1cG93ZXItc2VydmljZS5jb25mJworKHVu
Y29tbWVudGluZyBhdCBsZWFzdCBvbmUgb2YgdGhlIG9wdGlvbnMsIGRlcGVuZGluZyBvbiB5
b3VyIHByZWZlcmVuY2VzKQorYW5kIHRoZW4gaXNzdWUgdGhlIGZvbGxvd2luZyBjb21tYW5k
OgorCiskIHN1ZG8gc3lzdGVtY3RsIGVuYWJsZSAtLW5vdyBjcHVwb3dlci5zZXJ2aWNlCisK
IAogVEhBTktTCiAtLS0tLS0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2Jp
bmRpbmdzL3B5dGhvbi9NYWtlZmlsZSBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdz
L3B5dGhvbi9NYWtlZmlsZQppbmRleCA3NDFmMjE0Nzc0MzIuLjgxZGIzOWEwM2VmYiAxMDA2
NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL01ha2VmaWxl
CisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2JpbmRpbmdzL3B5dGhvbi9NYWtlZmlsZQpA
QCAtMSwyMiArMSwyMCBAQAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
bmx5CiAjIE1ha2VmaWxlIGZvciBsaWJjcHVwb3dlcidzIFB5dGhvbiBiaW5kaW5ncwogIwot
IyBUaGlzIE1ha2VmaWxlIGV4cGVjdHMgeW91IGhhdmUgYWxyZWFkeSBydW4gdGhlIG1ha2Vm
aWxlIGZvciBjcHVwb3dlciB0byBidWlsZAotIyB0aGUgLm8gZmlsZXMgaW4gdGhlIGxpYiBk
aXJlY3RvcnkgZm9yIHRoZSBiaW5kaW5ncyB0byBiZSBjcmVhdGVkLgorIyBUaGlzIE1ha2Vm
aWxlIGV4cGVjdHMgeW91IGhhdmUgYWxyZWFkeSBydW4gYG1ha2UgaW5zdGFsbC1saWJgIGlu
IHRoZSBsaWIKKyMgZGlyZWN0b3J5IGZvciB0aGUgYmluZGluZ3MgdG8gYmUgY3JlYXRlZC4K
IAogQ0MgOj0gZ2NjCiBIQVZFX1NXSUcgOj0gJChzaGVsbCBpZiB3aGljaCBzd2lnID4vZGV2
L251bGwgMj4mMTsgdGhlbiBlY2hvIDE7IGVsc2UgZWNobyAwOyBmaSkKIEhBVkVfUFlDT05G
SUcgOj0gJChzaGVsbCBpZiB3aGljaCBweXRob24tY29uZmlnID4vZGV2L251bGwgMj4mMTsg
dGhlbiBlY2hvIDE7IGVsc2UgZWNobyAwOyBmaSkKIAotTElCX0RJUiA6PSAuLi8uLi9saWIK
IFBZX0lOQ0xVREUgPSAkKGZpcnN0d29yZCAkKHNoZWxsIHB5dGhvbi1jb25maWcgLS1pbmNs
dWRlcykpCi1PQkpFQ1RTX0xJQiA9ICQod2lsZGNhcmQgJChMSUJfRElSKS8qLm8pCiBJTlNU
QUxMX0RJUiA9ICQoc2hlbGwgcHl0aG9uMyAtYyAiaW1wb3J0IHNpdGU7IHByaW50KHNpdGUu
Z2V0c2l0ZXBhY2thZ2VzKClbMF0pIikKIAogYWxsOiBfcmF3X3B5bGliY3B1cG93ZXIuc28K
IAogX3Jhd19weWxpYmNwdXBvd2VyLnNvOiByYXdfcHlsaWJjcHVwb3dlcl93cmFwLm8KLQkk
KENDKSAtc2hhcmVkICQoT0JKRUNUU19MSUIpIHJhd19weWxpYmNwdXBvd2VyX3dyYXAubyAt
byBfcmF3X3B5bGliY3B1cG93ZXIuc28KKwkkKENDKSAtc2hhcmVkIC1sY3B1cG93ZXIgcmF3
X3B5bGliY3B1cG93ZXJfd3JhcC5vIC1vIF9yYXdfcHlsaWJjcHVwb3dlci5zbwogCiByYXdf
cHlsaWJjcHVwb3dlcl93cmFwLm86IHJhd19weWxpYmNwdXBvd2VyX3dyYXAuYwogCSQoQ0Mp
IC1mUElDIC1jIHJhd19weWxpYmNwdXBvd2VyX3dyYXAuYyAkKFBZX0lOQ0xVREUpCmRpZmYg
LS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9iaW5kaW5ncy9weXRob24vUkVBRE1FIGIv
dG9vbHMvcG93ZXIvY3B1cG93ZXIvYmluZGluZ3MvcHl0aG9uL1JFQURNRQppbmRleCA5NTJl
MmUwMmZkMzIuLjJhNDg5NmI2NDhiNyAxMDA2NDQKLS0tIGEvdG9vbHMvcG93ZXIvY3B1cG93
ZXIvYmluZGluZ3MvcHl0aG9uL1JFQURNRQorKysgYi90b29scy9wb3dlci9jcHVwb3dlci9i
aW5kaW5ncy9weXRob24vUkVBRE1FCkBAIC01LDE4ICs1LDIxIEBAIGxpYmNwdXBvd2VyIChh
c2lkZSBmcm9tIHRoZSBsaWJjcHVwb3dlciBvYmplY3QgZmlsZXMpLgogcmVxdWlyZW1lbnRz
CiAtLS0tLS0tLS0tLS0KIAotKiBZb3UgbmVlZCB0aGUgb2JqZWN0IGZpbGVzIGluIHRoZSBs
aWJjcHVwb3dlciBkaXJlY3RvcnkgY29tcGlsZWQgYnkKLWNwdXBvd2VyJ3MgbWFrZWZpbGUu
CisqIElmIHlvdSBhcmUgYnVpbGRpbmcgY29tcGxldGVseSBmcm9tIHVwc3RyZWFtOyBwbGVh
c2UgaW5zdGFsbCBsaWJjcHVwb3dlciBieQorcnVubmluZyBgbWFrZSBpbnN0YWxsLWxpYmAg
d2l0aGluIHRoZSBjcHVwb3dlciBkaXJlY3RvcnkuIFRoaXMgaW5zdGFsbHMgdGhlCitsaWJj
cHVwb3dlci5zbyBmaWxlIGFuZCBzeW1saW5rcyBuZWVkZWQuIE90aGVyd2lzZSwgcGxlYXNl
IG1ha2Ugc3VyZSBhIHN5bWxpbmsKK3RvIGxpYmNwdXBvd2VyLnNvIGV4aXN0cyBpbiB5b3Vy
IGxpYnJhcnkgcGF0aCBmcm9tIHlvdXIgZGlzdHJpYnV0aW9uJ3MKK3BhY2thZ2VzLgogKiBU
aGUgU1dJRyBwcm9ncmFtIG11c3QgYmUgaW5zdGFsbGVkLgotKiBUaGUgUHl0aG9uJ3MgZGV2
ZWxvcG1lbnQgbGlicmFyaWVzIGluc3RhbGxlZC4KKyogVGhlIFB5dGhvbidzIGRldmVsb3Bt
ZW50IGxpYnJhcmllcyBtdXN0IGJlIGluc3RhbGxlZC4KIAogUGxlYXNlIGNoZWNrIHRoYXQg
eW91ciB2ZXJzaW9uIG9mIFNXSUcgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSB2ZXJzaW9uIG9m
IFB5dGhvbgogaW5zdGFsbGVkIG9uIHlvdXIgbWFjaGluZSBieSBjaGVja2luZyB0aGUgU1dJ
RyBjaGFuZ2Vsb2cgb24gdGhlaXIgd2Vic2l0ZS4KIGh0dHBzOi8vc3dpZy5vcmcvCiAKIE5v
dGUgdGhhdCB3aGlsZSBTV0lHIGl0c2VsZiBpcyBHUEwgdjMrIGxpY2Vuc2VkOyB0aGUgcmVz
dWx0aW5nIG91dHB1dCwKLXRoZSBiaW5kaW5ncyBjb2RlOiBpcyBwZXJtaXNzaXZlbHkgbGlj
ZW5zZWQgKyB0aGUgbGljZW5zZSBvZiBsaWJjcHVwb3dlcidzIC5vCi1maWxlcy4gRm9yIHRo
ZXNlIGJpbmRpbmdzIHRoYXQgbWVhbnMgR1BMIHYyLgordGhlIGJpbmRpbmdzIGNvZGU6IGlz
IHBlcm1pc3NpdmVseSBsaWNlbnNlZCArIHRoZSBsaWNlbnNlIG9mIGxpYmNwdXBvd2VyJ3MK
K2xpYnJhcnkgZmlsZXMuIEZvciB0aGVzZSBiaW5kaW5ncyB0aGF0IG1lYW5zIEdQTCB2Mi4K
IAogUGxlYXNlIHNlZSBodHRwczovL3N3aWcub3JnL2xlZ2FsLmh0bWwgYW5kIHRoZSBkaXNj
dXNzaW9uIFsxXSBmb3IgbW9yZSBkZXRhaWxzLgogCmRpZmYgLS1naXQgYS90b29scy9wb3dl
ci9jcHVwb3dlci9jcHVwb3dlci1zZXJ2aWNlLmNvbmYgYi90b29scy9wb3dlci9jcHVwb3dl
ci9jcHVwb3dlci1zZXJ2aWNlLmNvbmYKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAw
MDAwMDAwMDAwLi4wMmVhYmU4ZTM2MTQKLS0tIC9kZXYvbnVsbAorKysgYi90b29scy9wb3dl
ci9jcHVwb3dlci9jcHVwb3dlci1zZXJ2aWNlLmNvbmYKQEAgLTAsMCArMSwzMiBAQAorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorIyBDb3B5cmlnaHQg
KEMpIDIwMTIsIFPDqWJhc3RpZW4gTHV0dHJpbmdlcgorIyBDb3B5cmlnaHQgKEMpIDIwMjQt
MjAyNSwgRnJhbmNlc2NvIFBvbGkgPGludmVybm9tdXRvQHBhcmFub2ljaS5vcmc+CisKKyMg
Q29uZmlndXJhdGlvbiBmaWxlIGZvciBjcHVwb3dlci5zZXJ2aWNlIHN5c3RlbWQgc2Vydmlj
ZSB1bml0CisjCisjIEVkaXQgdGhpcyBmaWxlICh1bmNvbW1lbnRpbmcgYXQgbGVhc3Qgb25l
IG9mIHRoZSBvcHRpb25zLCBkZXBlbmRpbmcgb24KKyMgeW91ciBwcmVmZXJlbmNlcykgYW5k
IHRoZW4gZW5hYmxlIGNwdXBvd2VyLnNlcnZpY2UsIGlmIHlvdSB3YW50IGNwdXBvd2VyCisj
IHRvIHJ1biBhdCBib290IHdpdGggdGhlc2Ugc2V0dGluZ3MuCisKKyMgLS0tIENQVSBjbG9j
ayBmcmVxdWVuY3kgLS0tCisKKyMgRGVmaW5lIENQVSBnb3Zlcm5vcgorIyBWYWxpZCBnb3Zl
cm5vcnM6IG9uZGVtYW5kLCBwZXJmb3JtYW5jZSwgcG93ZXJzYXZlLCBjb25zZXJ2YXRpdmUs
IHVzZXJzcGFjZQorI0dPVkVSTk9SPSdvbmRlbWFuZCcKKworIyBMaW1pdCBmcmVxdWVuY3kg
cmFuZ2UKKyMgVmFsaWQgc3VmZml4ZXM6IEh6LCBrSHogKGRlZmF1bHQpLCBNSHosIEdIeiwg
VEh6CisjTUlOX0ZSRVE9IjIuMjVHSHoiCisjTUFYX0ZSRVE9IjNHSHoiCisKKyMgU2V0IGEg
c3BlY2lmaWMgZnJlcXVlbmN5CisjIFJlcXVpcmVzIHVzZXJzcGFjZSBnb3Zlcm5vciB0byBi
ZSBhdmFpbGFibGUuCisjIElmIHRoaXMgb3B0aW9uIGlzIHNldCwgYWxsIHRoZSBwcmV2aW91
cyBmcmVxdWVuY3kgb3B0aW9ucyBhcmUgaWdub3JlZAorI0ZSRVE9CisKKyMgLS0tIENQVSBw
b2xpY3kgLS0tCisKKyMgU2V0IGEgcmVnaXN0ZXIgb24gc3VwcG9ydGVkIEludGVsIHByb2Nl
c3NvcmUgd2hpY2ggYWxsb3dzIHNvZnR3YXJlIHRvIGNvbnZleQorIyBpdHMgcG9saWN5IGZv
ciB0aGUgcmVsYXRpdmUgaW1wb3J0YW5jZSBvZiBwZXJmb3JtYW5jZSB2ZXJzdXMgZW5lcmd5
IHNhdmluZ3MgdG8KKyMgdGhlIHByb2Nlc3Nvci4gU2VlIG1hbiBDUFVQT1dFUi1TRVQoMSkg
Zm9yIGFkZGl0aW9uYWwgZGV0YWlscworI1BFUkZfQklBUz0KZGlmZiAtLWdpdCBhL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL2NwdXBvd2VyLnNlcnZpY2UuaW4gYi90b29scy9wb3dlci9jcHVw
b3dlci9jcHVwb3dlci5zZXJ2aWNlLmluCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAwMDAwMC4uZmJkNWI4YzE0MjcwCi0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvY3B1cG93ZXIuc2VydmljZS5pbgpAQCAtMCwwICsxLDE2IEBACisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisjIENvcHlyaWdodCAo
QykgMjAxMi0yMDIwLCBTw6liYXN0aWVuIEx1dHRyaW5nZXIKKyMgQ29weXJpZ2h0IChDKSAy
MDI0LTIwMjUsIEZyYW5jZXNjbyBQb2xpIDxpbnZlcm5vbXV0b0BwYXJhbm9pY2kub3JnPgor
CitbVW5pdF0KK0Rlc2NyaXB0aW9uPUFwcGx5IGNwdXBvd2VyIGNvbmZpZ3VyYXRpb24KK0Nv
bmRpdGlvblZpcnR1YWxpemF0aW9uPSFjb250YWluZXIKKworW1NlcnZpY2VdCitUeXBlPW9u
ZXNob3QKK0Vudmlyb25tZW50RmlsZT0tX19fQ0RJUl9fX2NwdXBvd2VyLXNlcnZpY2UuY29u
ZgorRXhlY1N0YXJ0PV9fX0xESVJfX18vY3B1cG93ZXIKK1JlbWFpbkFmdGVyRXhpdD15ZXMK
KworW0luc3RhbGxdCitXYW50ZWRCeT1tdWx0aS11c2VyLnRhcmdldApkaWZmIC0tZ2l0IGEv
dG9vbHMvcG93ZXIvY3B1cG93ZXIvY3B1cG93ZXIuc2ggYi90b29scy9wb3dlci9jcHVwb3dl
ci9jcHVwb3dlci5zaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAu
LmEzN2RkNGNmZGIyYgotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2Vy
L2NwdXBvd2VyLnNoCkBAIC0wLDAgKzEsMjYgQEAKKyMhL2Jpbi9zaAorIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorIyBDb3B5cmlnaHQgKEMpIDIwMTIs
IFPDqWJhc3RpZW4gTHV0dHJpbmdlcgorIyBDb3B5cmlnaHQgKEMpIDIwMjQsIEZyYW5jZXNj
byBQb2xpIDxpbnZlcm5vbXV0b0BwYXJhbm9pY2kub3JnPgorCitFU1RBVFVTPTAKKworIyBh
cHBseSBDUFUgY2xvY2sgZnJlcXVlbmN5IG9wdGlvbnMKK2lmIHRlc3QgLW4gIiRGUkVRIgor
dGhlbgorICAgIGNwdXBvd2VyIGZyZXF1ZW5jeS1zZXQgLWYgIiRGUkVRIiA+IC9kZXYvbnVs
bCB8fCBFU1RBVFVTPTEKK2VsaWYgdGVzdCAtbiAiJHtHT1ZFUk5PUn0ke01JTl9GUkVRfSR7
TUFYX0ZSRVF9IgordGhlbgorICAgIGNwdXBvd2VyIGZyZXF1ZW5jeS1zZXQgXAorICAgICAg
JHtHT1ZFUk5PUjorIC1nICIkR09WRVJOT1IifSBcCisgICAgICAke01JTl9GUkVROisgLWQg
IiRNSU5fRlJFUSJ9ICR7TUFYX0ZSRVE6KyAtdSAiJE1BWF9GUkVRIn0gXAorICAgICAgPiAv
ZGV2L251bGwgfHwgRVNUQVRVUz0xCitmaQorCisjIGFwcGx5IENQVSBwb2xpY3kgb3B0aW9u
cworaWYgdGVzdCAtbiAiJFBFUkZfQklBUyIKK3RoZW4KKyAgICBjcHVwb3dlciBzZXQgLWIg
IiRQRVJGX0JJQVMiID4gL2Rldi9udWxsIHx8IEVTVEFUVVM9MQorZmkKKworZXhpdCAkRVNU
QVRVUwo=

--------------TMrgY07PXUnU0gl7Jko53ziz--

