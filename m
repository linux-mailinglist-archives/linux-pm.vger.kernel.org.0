Return-Path: <linux-pm+bounces-29653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD5BAEB6D4
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 13:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2043A7F32
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B21922FA;
	Fri, 27 Jun 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dKcVtaFm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D51DDC1E
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024857; cv=none; b=Ui/KRBzp0CI1gljxlaljMdM/+L3yXA2N1GlgD8NEOld7ZnH2xj/n1UueO483XOQuciCc99ujbr4hWe3zkWuVuRzd88L6lQMAkU7EpYCCO6Hdg3oMNIDWnYrMIb2pbvjzb5gYgZfLVAc8AsglwN2LGNF5VJ9A9EOy3gnFFH8JYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024857; c=relaxed/simple;
	bh=nXAtJr1zuW96ot66+9iRi9k7hOcZywkm9pkzIfsra2k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rqP54JPfxhx8gpLMLWDBnYSITyMY62/bggUXrVXHOnwESK56p6cCWTyFZHuuMEHU54I3kyIlSnUcoia2qKznFXq4Jk8b6q0m85mQVbUo8UQ+8LQ7CWq1sTkZIt3Gmc4J48id4N3d3KBDD5zh4+UXz7fx+Hv6IM0uEB8xI45dJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dKcVtaFm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 507A820860;
	Fri, 27 Jun 2025 13:47:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GuJDU5XaBaoL; Fri, 27 Jun 2025 13:47:25 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B1A9D207B3;
	Fri, 27 Jun 2025 13:47:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B1A9D207B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751024845;
	bh=401e3I6KyDAI29Obk+WjaDRf0d3vYeUk0cY4niFk96I=;
	h=From:To:CC:Subject:Date:Reply-To:From;
	b=dKcVtaFmq2nwCh78zn0Ws6l0qGenWRHb8G/u+aTuV2cZ0IaFKv6cOWEasqupu/Ijw
	 lymjjHtq4uWkRwqOrqsc8JHa++yRmWNll9d5aDddeE3x4s195r+GymYmve33HgYYv3
	 CGWFZEjv/qKkPYT7Cv4Tck87VhWlkFCRYDnIT8uKQE3wi2tNdqw+WJ2We2eL1kFHCT
	 WGWUCN5t2Kz/993gHfzPMbLPBBlynMX+XLusmB+rE3QWgWhekXQKfNsFwX3iktvJ1g
	 R4M06q4WoUWP7S1U7hka9fL+XJTSULEOG/UXTmGkKsr7rqjPUr8By+5LCSRvxk7fqz
	 J1upiwGKYi/Tg==
Received: from mbx-dresden-01.secunet.de (10.53.40.199) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 27 Jun
 2025 13:47:24 +0200
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 27 Jun 2025 13:47:15 +0200
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.039; Fri, 27 Jun 2025 13:47:15 +0200
From: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
To: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
CC: "17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com"
	<17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com>, "Wassenberg,
 Dennis" <Dennis.Wassenberg@secunet.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "ricardo.neri@intel.com"
	<ricardo.neri@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"srinivas.pandruvada@intel.com" <srinivas.pandruvada@intel.com>
Subject: Re: TCC cooling on Meteorlake (and ArrowLake)
Thread-Topic: Re: TCC cooling on Meteorlake (and ArrowLake)
Thread-Index: AdvnWSh50GF/XET9RbiGRPCrO/Dctg==
Date: Fri, 27 Jun 2025 11:47:15 +0000
Message-ID: <336bd01fae0c4c0b8e1d94a6c66c7d86@secunet.com>
Reply-To: "b7c2e49c84d94b9e93f3156250346ec8@secunet.com"
	<b7c2e49c84d94b9e93f3156250346ec8@secunet.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, and sorry for the late reply.
I waited until my ArrowLake test devices arrived.

> I have applied this patch on a couple of machines that I can access but
> unfortunately they all have TCC offset bit locked. So please check if
> it works as expected or not.

I can confirm, that it works as expected on all current Lenovo Notebooks I =
had running on MeteorLake & Arrowlake.
As we usually use older kernel versions and mostly LTS versions I had to mo=
dify it for 6.8 kernel that we use on MetorLake only:

drivers/thermal/intel/intel_tcc_cooling.c
@@ -64,6 +64,8 @@ static const struct x86_cpu_id tcc_ids[] __initconst =3D =
{
	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
	{}
};

On 6.12 onwards your patch works without any changes:

On current devices the TCC offset remains at a stable value so that we don'=
t change/monitor it.
The offsets from the manufacturer are also very reasonable except for the M=
eteorLake devices I mentioned before.


--=20
Mateusz Gwara
Senior Software Developer
Department Network & Client Security
Division Public Authorities
secunet Security Networks AG

Tel.: +49 201 54 54-2934
E-Mail: mateusz.gwara@secunet.com
Alt-Moabit 96, 10559 Berlin
www.secunet.com
______________________________________________________________________

secunet Security Networks AG
Sitz: Kurf=FCrstenstra=DFe 58, 45138 Essen, Deutschland
Amtsgericht Essen HRB 13615
Vorstand: Torsten Henn, Dr. Kai Martius, Jessica Nospers
Aufsichtsratsvorsitzender: Dr. Ralf Wintergerst
______________________________________________________________________


