Return-Path: <linux-pm+bounces-28393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D843BAD3D9A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0521172C36
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46F223F291;
	Tue, 10 Jun 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ON2vEwHa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E38238D51
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569840; cv=none; b=gcN9cH3DlcaLc9Qqs/xjdS683wFj/R0CWG5N6Xo+gYCC0j3AhWIy/VmIzzCAKsX94JWrOx+S+mZpPTzqNwAyh5HCSnOiMH4ecJAd4i363ISa5HKlZOYBcbr8vGpFIBV8o32oOh2EKz39tCD+6kL3NhCaKJwCxy0iLo5fkOjVhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569840; c=relaxed/simple;
	bh=Ge1LFO3GJbt9hd5N8cGDfDJg7Ju9ZPGoCT0kFFxY694=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=Omn/QBg3FbrULXbp/RWOjC+JBUri/EMZnRlSG3PFdA/95VkLHc3Wg6sZTg/oszyZ7dVFxVXLFdmCAyly19S/svaNwO8jCPXnN4rOGkYklXbYb4PyTN0wFK4l1KLDvHeVS5pXHM8MiKGLmrI5ohc9I33pStns+gIjMWeQ1tTXmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ON2vEwHa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5ae2fdf4eso61854661cf.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1749569837; x=1750174637; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nh+mGpHpRQJpNMq16cUvVk7l1gQB7lXYTYB8ff8wx5k=;
        b=ON2vEwHa6wpDttnIQUUM1hkDGhGAF48c1oOwgFGzl9uxk8+GxucSGtA0nwumkRqmT3
         om+D5offFKK8MGcLDRm+uYK0jqBW0L3Z/ReRxZfP2TNVtSWDrMYU0vlf64Z9Te3LMdti
         dLiTCVwCofbWAVjI0tJDyNVKoo56oFktIhUFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749569837; x=1750174637;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh+mGpHpRQJpNMq16cUvVk7l1gQB7lXYTYB8ff8wx5k=;
        b=LR8CW3WWoxYrRjtHAy3mF+df5HEGT+Rx+4gW4WGTmqW0tMS3HFKbzi8yOtiGCiWRti
         XXmE3TpqDHx8rBfDMMxypEywb7EAAsM4vz15RKxg+3LxJ5O/vZRoDvZWRyMheyMqxhGN
         TQQqa0INqK5wuDXzRdtMtQRsmgtej/ReAknRLx5AbYs+iTm5n9VvrihquYfXPD+RHiTT
         mwX33scrMVY/DqzzmhxF9PrsVKygzGVHfsG0jWJBw9MD5t/j4QnrotfyK+yWg6tEATkJ
         zuOjq98Kjy78XCr1GluU3/wx8Kcf2HIn2iHTxeWe6/rHtlAnGog5BBoHeRtZx/Nk9FPn
         8ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVPe29YB26wnTlxu51Hrp8O+VFNmLoXdpoGFKoi+GY1VEMDyXC5keYWAV6E0TYdD96MhmJUD++aSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdtJ/OJ5dRhBrz6uf3TPqzYjEg4rQCwq6/ZoOasqrgEs3rqb/a
	xzzmkzX6zmgJgYjLRwtglwaEaHj21ryDQZ/4AA6W9pOPCK2Ujq2HILXhu1xNhx61zto=
X-Gm-Gg: ASbGncvwlO7sSFFLiF3sh0H6+hj29DBkhJQUaXsWLBOMojil+9BKykMypMeBxOzk7XU
	gQVwBYBg4JTbwn28R/J/VAR6iEJEViWh0ftkkjcSjj8loPiCfamQ/R9qL0YSNSAY2BmbckhTWOe
	0Sxpf48DEnsNI9w0xYaRztsdNTjjTfLRqv6urnEVfRBVrECcuMCTEqHcGCKTg0s85D2SlE7Xt57
	WSiF94PriHvzhstOVyu4nyfbe5B1WyPp0aAMsgSYPRYHcD1xy4gwRmsFx5zJFdhDlDK80an9f6K
	vOJ1V8iFH8emvTYPhtCJ7vcQBok3i90cULe4WYnPROsUJnnU9emsSk3Pg+35gM3YbHWy/6HxQMJ
	c8NvKetRSsKs=
X-Google-Smtp-Source: AGHT+IHZRFV8Mnfm66KxgqbQ+xn/V03aqh6SUiPn4eSw5iLcmKe2WvnZXGgaVLUZu9Zeyu5/wNzwfA==
X-Received: by 2002:a05:622a:5587:b0:49c:d64b:3d5f with SMTP id d75a77b69052e-4a708ce76e9mr56271861cf.9.1749569836627;
        Tue, 10 Jun 2025 08:37:16 -0700 (PDT)
Received: from [10.212.144.179] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6ef785c23sm57361681cf.35.2025.06.10.08.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 08:37:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Zvf7rR069wIOZjcyzA1npCtG"
Message-ID: <ab7fe518-0177-4178-a40d-51e0a5fbe8aa@linuxfoundation.org>
Date: Tue, 10 Jun 2025 09:37:15 -0600
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
 Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower urgent fix for Linux 6.16-rc2

This is a multi-part message in MIME format.
--------------Zvf7rR069wIOZjcyzA1npCtG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull this cpupower urgent fix for Linux 6.16-rc2.

Add unitdir variable for specifying the location to install systemd
service units instead of installing under ${libdir}/systemd/system
which doesn't work on some distributions.

Note: I meant to send this during the merge window and ran into some
merge conflicts during the PR test. Decided to wait on it until rc1.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.16-rc2-fixes

for you to fetch changes up to e044b8a9545cd8265c7110c179aeec2624c16455:

   cpupower: split unitdir from libdir in Makefile (2025-06-09 10:17:46 -0600)

----------------------------------------------------------------
linux-cpupower-6.16-rc2-fixes

Add unitdir variable for specifying the location to install systemd
service units instead of installing under ${libdir}/systemd/system
which doesn't work on some distributions.

----------------------------------------------------------------
Francesco Poli (wintermute) (1):
       cpupower: split unitdir from libdir in Makefile

  tools/power/cpupower/Makefile | 9 +++++----
  1 file changed, 5 insertions(+), 4 deletions(-)

----------------------------------------------------------------
--------------Zvf7rR069wIOZjcyzA1npCtG
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-6.16-rc2-fixes.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.16-rc2-fixes.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlIGIvdG9vbHMvcG93
ZXIvY3B1cG93ZXIvTWFrZWZpbGUKaW5kZXggYmU4ZGZhYzE0MDc2Li5jNDNkYjFjNDEyMDUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCisrKyBiL3Rvb2xz
L3Bvd2VyL2NwdXBvd2VyL01ha2VmaWxlCkBAIC03Myw2ICs3Myw3IEBAIHNiaW5kaXIgPz0J
L3Vzci9zYmluCiBtYW5kaXIgPz0JL3Vzci9tYW4KIGxpYmRpciA/PQkvdXNyL2xpYgogbGli
ZXhlY2RpciA/PQkvdXNyL2xpYmV4ZWMKK3VuaXRkaXIgPz0JL3Vzci9saWIvc3lzdGVtZC9z
eXN0ZW0KIGluY2x1ZGVkaXIgPz0JL3Vzci9pbmNsdWRlCiBsb2NhbGVkaXIgPz0JL3Vzci9z
aGFyZS9sb2NhbGUKIGRvY2RpciA/PSAgICAgICAvdXNyL3NoYXJlL2RvYy9wYWNrYWdlcy9j
cHVwb3dlcgpAQCAtMzA5LDkgKzMxMCw5IEBAIGluc3RhbGwtdG9vbHM6ICQoT1VUUFVUKWNw
dXBvd2VyCiAJJChJTlNUQUxMX0RBVEEpIGNwdXBvd2VyLXNlcnZpY2UuY29uZiAnJChERVNU
RElSKSR7Y29uZmRpcn0nCiAJJChJTlNUQUxMKSAtZCAkKERFU1RESVIpJHtsaWJleGVjZGly
fQogCSQoSU5TVEFMTF9QUk9HUkFNKSBjcHVwb3dlci5zaCAnJChERVNURElSKSR7bGliZXhl
Y2Rpcn0vY3B1cG93ZXInCi0JJChJTlNUQUxMKSAtZCAkKERFU1RESVIpJHtsaWJkaXJ9L3N5
c3RlbWQvc3lzdGVtCi0Jc2VkICdzfF9fX0NESVJfX198JHtjb25mZGlyfXw7IHN8X19fTERJ
Ul9fX3wke2xpYmV4ZWNkaXJ9fCcgY3B1cG93ZXIuc2VydmljZS5pbiA+ICckKERFU1RESVIp
JHtsaWJkaXJ9L3N5c3RlbWQvc3lzdGVtL2NwdXBvd2VyLnNlcnZpY2UnCi0JJChTRVRQRVJN
X0RBVEEpICckKERFU1RESVIpJHtsaWJkaXJ9L3N5c3RlbWQvc3lzdGVtL2NwdXBvd2VyLnNl
cnZpY2UnCisJJChJTlNUQUxMKSAtZCAkKERFU1RESVIpJHt1bml0ZGlyfQorCXNlZCAnc3xf
X19DRElSX19ffCR7Y29uZmRpcn18OyBzfF9fX0xESVJfX198JHtsaWJleGVjZGlyfXwnIGNw
dXBvd2VyLnNlcnZpY2UuaW4gPiAnJChERVNURElSKSR7dW5pdGRpcn0vY3B1cG93ZXIuc2Vy
dmljZScKKwkkKFNFVFBFUk1fREFUQSkgJyQoREVTVERJUikke3VuaXRkaXJ9L2NwdXBvd2Vy
LnNlcnZpY2UnCiAKIGluc3RhbGwtbWFuOgogCSQoSU5TVEFMTF9EQVRBKSAtRCBtYW4vY3B1
cG93ZXIuMSAkKERFU1RESVIpJHttYW5kaXJ9L21hbjEvY3B1cG93ZXIuMQpAQCAtMzQ4LDcg
KzM0OSw3IEBAIHVuaW5zdGFsbDoKIAktIHJtIC1mICQoREVTVERJUikke2JpbmRpcn0vdXRp
bHMvY3B1cG93ZXIKIAktIHJtIC1mICQoREVTVERJUikke2NvbmZkaXJ9Y3B1cG93ZXItc2Vy
dmljZS5jb25mCiAJLSBybSAtZiAkKERFU1RESVIpJHtsaWJleGVjZGlyfS9jcHVwb3dlcgot
CS0gcm0gLWYgJChERVNURElSKSR7bGliZGlyfS9zeXN0ZW1kL3N5c3RlbS9jcHVwb3dlci5z
ZXJ2aWNlCisJLSBybSAtZiAkKERFU1RESVIpJHt1bml0ZGlyfS9jcHVwb3dlci5zZXJ2aWNl
CiAJLSBybSAtZiAkKERFU1RESVIpJHttYW5kaXJ9L21hbjEvY3B1cG93ZXIuMQogCS0gcm0g
LWYgJChERVNURElSKSR7bWFuZGlyfS9tYW4xL2NwdXBvd2VyLWZyZXF1ZW5jeS1zZXQuMQog
CS0gcm0gLWYgJChERVNURElSKSR7bWFuZGlyfS9tYW4xL2NwdXBvd2VyLWZyZXF1ZW5jeS1p
bmZvLjEK

--------------Zvf7rR069wIOZjcyzA1npCtG--

