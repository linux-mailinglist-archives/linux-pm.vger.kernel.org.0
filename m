Return-Path: <linux-pm+bounces-9766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112F9128A6
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143F4B24A19
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FBD376E6;
	Fri, 21 Jun 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="A8MqPuPX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269672E414
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981813; cv=none; b=pDhDHSvRiUOhCcyQSNpGx6gJPHoTC+kdYigGareMHYjMdIRrOujwABc2XHcWxWGbMIMFX7KfGkvO+yjWt6CSie4WI30h0aNLQvf9tjkdOpCs+GbGczHRQ1YQ05nfP0pQoyH1uSviXMbUqgsXDNzfX/1BFXtcFrL39EkXK6G0LAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981813; c=relaxed/simple;
	bh=YlfyVfvR8g8di0NZcZ9ZzpZDM72bHswIAvDS32cTeKY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LPcq4Z1qd6ujdkYVz+8FHfE1kq2hCQ9OywuLGwl2zu/3aS1PLwmgOJr53CiPJDLq3vwI+gCLigrOQtec0MpjvDoUC7CGiEqdxcornLgbMFhmNU0SYJUJXZHxr4aoLYdVvW1gCCHMMdsYP6zW4wcAru6zYI6ciI4jG2etk0YqNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=A8MqPuPX; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718981809; x=1719586609; i=toralf.foerster@gmx.de;
	bh=QT+LHpDMgvNSYyirFUbDAO2z39YqvD0jWfXSzpU9nkU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=A8MqPuPXa6FxBS1BAb1AM1+CspjL1Ae1QDU0JPDFOD42NNmFhDwnpuDJyisUZVYA
	 57gETAK6WmiqqOjdvCwCCxtQNh8i0mZlj+D3y3Z3YzMsfbvMNTTg+G85vCoKCcgfe
	 p5QdoR+T/pFqOFmTNVwmJXm1isZ1vbtikre9TvUkSiuxsEZbjeLL6Tn9IUTea7laI
	 jYpInlw2ucohR3VvXt+SheTDMmW/uUTVC5ATING3aieXLXteHR/AeIn9ibT2DaD3u
	 KCMsM59u4Ji48uuzhI5F7S9j6iqzx+O5kC9jLTg16QT26niftcA3JbiEbkK8GC341
	 XnRnX8gsF4AUvuX61Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([78.50.112.132]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My36N-1sZAPG0dcF-00wKLr for
 <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 16:56:49 +0200
Message-ID: <c79f805f-632e-4747-9c97-76b757325b44@gmx.de>
Date: Fri, 21 Jun 2024 16:56:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-pm@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: 6.9.5->6.9.6 regression
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+9UqX8FOfECkkr6eCz8VdVDUVhhnLaJr5oVs63zy4qDbm6kV8tc
 oIBvIRa9j9a52QDRy6xhpMbQGX2NhjO4hgEbVpa70oL9Mbc+hxAY8R3z4r2sLL98UxhmO6y
 ATJC+tznqqA7h5QGskgWxC6JFgocO3rdt31K3tLh/WQiEAIfLzEZTIQhbebou7yiSxriOuL
 Ngxf3rGeUEyzsYJAw+4Ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QM4jC4t81yg=;rlCFaeB+XMC9dUIDWy8sBZPE+fo
 6hpy0kSDz6U9N9lLTajP+E+8RH+2Vh0TnKdO/1g+qqE3/MlRUNZC74yQzl8wuzHbyDl8qGUuK
 4NcalFGImBY1t/2j61viJefoA/qggVb2/8z2viImghpyX/09oPnhsvUH6nuiq2OOVnZyKbgYO
 BxaWyX99428EEMI0ymebsh147h2/WM6qCSmedTHFQVPr8o7akxVi5OeclKMQw5OG1Y04K6I3p
 6hr0CIey51+PitHUpP7TQKR0n4b/fMtXSPI+RE1iO/pEC1Z+xW2pokPhVLtb6ZWs8Jh81Kooo
 H2grCUvDhN1fsLf2PkSn4rTMQyxrGwatwY/hg7PmBawJIvzLGswq3yWsajaHAtGLgrux0mesm
 6caoslrQh4GzMTv5UCCirdc/NbxIXK08c9MriHxnjxDx7i4mk2DOTgqLKZaEB+oCfdnclP2Jm
 WAUy8kcgIOWv5R2wyKjpdI7TYHOygzteulBoLxb7miviCTBESZ9A06CnhZ1NwHjgoP4UG7bXc
 7ctI03mQ8waodcyLRl7B35Fxyb5tpti1tCTHKvfIJHMDZUcxx97z3GRvAFmbSuERHrtd6+0jA
 s+q5CS3tmFO92oEfujr3+HK5sl08aNSRQDJTCZ13dj+ArCXv5PslDV3364ryMGvWurq0dLgDt
 O6EO8A+e9e33ZP2L/WtbPwRkD46JCkvMkG/rSy6tS7807bSSXVKtrNpaCmsga/BuYffcuEHBV
 CFPAiHBlNWnCgLrf8K4XdqVsANwGc7KX+4+IgWKRe1GI3WraFMsZfsv08oLJurPv6lk9x+qdx
 2BySeuuvqmftCp6NYsrBrM6SRe4l0yW11FGXSMfmxKsr0=

At a hardened Gentoo Linux:

Linux mr-fox 6.9.6 #5 SMP Fri Jun 21 14:17:45 UTC 2024 x86_64 AMD Ryzen
9 5950X 16-Core Processor AuthenticAMD GNU/Linux

I realized a diff of amd_pstate_ut_check_freq between both kernel patch
level versions:

$ grep amd_pstate_ut dmesg-6.9.?
dmesg-6.9.5:amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid     success!
dmesg-6.9.5:amd_pstate_ut: 2    amd_pstate_ut_check_enabled      success!
dmesg-6.9.5:amd_pstate_ut: amd_pstate_ut_check_perf cpu0 highest=3D231 166
nominal=3D111 111 lowest_nonlinear=3D57 57 lowest=3D19 19, they should be =
equal!
dmesg-6.9.5:amd_pstate_ut: 3    amd_pstate_ut_check_perf         fail!
dmesg-6.9.5:amd_pstate_ut: 4    amd_pstate_ut_check_freq         success!
dmesg-6.9.6:amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid     success!
dmesg-6.9.6:amd_pstate_ut: 2    amd_pstate_ut_check_enabled      success!
dmesg-6.9.6:amd_pstate_ut: amd_pstate_ut_check_perf cpu0 highest=3D231 166
nominal=3D111 111 lowest_nonlinear=3D57 57 lowest=3D19 19, they should be =
equal!
dmesg-6.9.6:amd_pstate_ut: 3    amd_pstate_ut_check_perf         fail!
dmesg-6.9.6:amd_pstate_ut: amd_pstate_ut_check_freq cpu0 max=3D5084000 >=
=3D
nominal=3D3401 > lowest_nonlinear=3D1743000 > min=3D550000 > 0, the formul=
a is
incorrect!
dmesg-6.9.6:amd_pstate_ut: 4    amd_pstate_ut_check_freq         fail!

Anything I should check?
=2D-
Toralf

