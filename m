Return-Path: <linux-pm+bounces-23841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E53A5C0B4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029367A2B3E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364372566EB;
	Tue, 11 Mar 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nxKwh2EK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C39221F17
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741695603; cv=none; b=Fp/cTxT8bpZtwtCn3Sx8tat1qEHbPoE3Js4kLjum/lA+Cv8Rb16X+9KyFGcAB7M4sm29NxjTRuR/T9usCu3qP6H9ZB3WybssbJeFBebHrnsq5J3kk6rGVX9d2c1nk+bwcseCfptBSLvYFGp4swmSMpJBSSWkw51S8SWrGqtp2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741695603; c=relaxed/simple;
	bh=2AeoFCNG9KzBBVZSD4nzcr2Yo7ZZ7n58IJVLdYd35g4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WGUh7VTvJeEyL0hD34qIrHbB8q8C3C7XpB53vA6TjiEQGBFTWBqn7/x9Zk4kIpYHvDLdXSTmN+VXwiujB416EcaWDT3rhhehltC+M4Kv2PaBtM3t1pfxf6sEKBYEo6DfLeJWPtZdQdPJGlI2vnBuJroJvqg4+PdS8o8PEKFccck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nxKwh2EK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6699220520;
	Tue, 11 Mar 2025 13:19:52 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EsWxI1XO0gHr; Tue, 11 Mar 2025 13:19:51 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CF33F20518;
	Tue, 11 Mar 2025 13:19:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CF33F20518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1741695591;
	bh=2AeoFCNG9KzBBVZSD4nzcr2Yo7ZZ7n58IJVLdYd35g4=;
	h=From:To:CC:Subject:Date:Reply-To:From;
	b=nxKwh2EK9gWGNLqctsydDDRUqGb/zLJsvYeqO9SuGRluGDizm2QLZvt/D9ZMl10rb
	 flsLZ3nkFLCHy/sU4HX+2qVhQEDWPY1RAAnpLkFwJa6MVxy17RANaYZ9A0UXGgeauc
	 jT3y4xzvsJBGfG+F5UAIOT3J42NVmb0XIwK31Z19OJ9r6VcC8XeN9Mk+04koiCJ9PN
	 7og0UUf3RmT7z51AIcfW04QvdFcwfyl7JJHJWi+7D9UvOiDOe7cL2U+5LHUY4Urx+I
	 4lQ9ytdupnH9KncH3i4rRZ412tOpyXb4cNjhpxKw/yzi+wBlvJ3cpiIj46QerzYLXJ
	 Cf23XbHwql2Jw==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Mar 2025 13:19:51 +0100
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-essen-01.secunet.de (10.53.40.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Mar 2025 13:19:51 +0100
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.039; Tue, 11 Mar 2025 13:19:51 +0100
From: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
To: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
CC: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lukasz.luba@arm.com"
	<lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"rui.zhang@intel.com" <rui.zhang@intel.com>
Subject: Re: TCC cooling on Meteorlake
Thread-Topic: Re: TCC cooling on Meteorlake
Thread-Index: AduSf3zXUhT47FfIT9KWQYQvuThKWQ==
Date: Tue, 11 Mar 2025 12:19:51 +0000
Message-ID: <af33f856b8414a5e93f11c8c65b46881@secunet.com>
Reply-To: "163ff391dc6d4f828ecff95e87f5003d@secunet.com"
	<163ff391dc6d4f828ecff95e87f5003d@secunet.com>
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hi,

I wanted to make sure that there is no confusion because there seems to be =
two sets of drivers handling TCC.
As the workings of drivers/thermal/intel/int340x_thermal/int3403_thermal.c =
are visible in
/sys/bus/pci/devices/0000:00:04.0/tcc_offset_degree_celsius
and defined in drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.c
do have a wrong offset, which does not take into account that Meteor Lake C=
PUs have a TJunction of 110=B0C instead of 100=B0C.

That's why I was wondering why the new definitions in
drivers/thermal/intel/intel_tcc_cooling.c
does not contain any Meteor Lake (or Arrow&Lunar Lake ) definitions.
Where the results should be visible in /sys/class/thermal as mentioned in t=
he initial post.

Regards

MG

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
Vorstand: Axel Deininger (Vors.), Torsten Henn, Dr. Kai Martius, Jessica No=
spers
Aufsichtsratsvorsitzender: Dr. Ralf Wintergerst
______________________________________________________________________


