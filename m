Return-Path: <linux-pm+bounces-24535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC6CA71DB2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2F71897017
	for <lists+linux-pm@lfdr.de>; Wed, 26 Mar 2025 17:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37CA23FC52;
	Wed, 26 Mar 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JvPU8+Q3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EF2405E7
	for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011210; cv=none; b=Ta76L5WPdXjAznddY6TkjWn5THohovAwNI+KXIevreCMw+/tWAtZ4oAjwaAMH5qy4p0EvRzw9hxIoAO5GNEjkyEc9Dek44npD7NHHPoqOtVsFdg1wmoL3qgsa7vqc9142KKsErduyUzc129W1MdE+hromKI9fgJg7s3i63V3q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011210; c=relaxed/simple;
	bh=uOnUbusdxLPfaLLXwy8bMUPxzSL/WJI0OMMcpStIZNE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sDLa2sGD8QiAP3Y53TisWdyFEzVbApomV1aPBj00apqOJqzUC4wwKUbcwpNLkoMY8BxJLaMx7iq8QapK/wAB3IC0DKJRnOG+Z+v61TrExAQlMSdqGrweTbydgJHaYOu88vod1Ld/e++tmdOGtO56pU6Nh47xXcylNI0XbgHGJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JvPU8+Q3; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B40FF2082E;
	Wed, 26 Mar 2025 18:46:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iCgHHvP5Vevf; Wed, 26 Mar 2025 18:46:39 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1A3252074F;
	Wed, 26 Mar 2025 18:46:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1A3252074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1743011199;
	bh=uOnUbusdxLPfaLLXwy8bMUPxzSL/WJI0OMMcpStIZNE=;
	h=From:To:CC:Subject:Date:Reply-To:From;
	b=JvPU8+Q3n4+lco+VjuZFwZq8+8K1uKPVbnMleiIGeA7ZwEywW/1/Cx+Gyv7mrsQG+
	 7Xw4om4scdopyMYYs/69uZSCKF/5z7JcourvBYMryFvvOXRDwT7+zc+8f5q7P3a+rN
	 YRcmiGAt14+A7yblZIdiUFO9IzmYtzvMQLhw9Cu8SRKxTZX66gQ6ux7k6zi3i3r/a3
	 gp1Ve/x84xXJ5xz3+gqOhAI3cVAKzEeylX9lIKMahWWw/eoBo89a7Mj59LuVyCg9D4
	 R2GKrc/2aLZDJ8X96PUm/TzOgjmzHqJgFv7gc6+Flx7h23LynLkPzEjHpCDXrQWpXX
	 MFx2q9of6Jt8g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Mar 2025 18:46:38 +0100
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Mar 2025 18:46:38 +0100
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.039; Wed, 26 Mar 2025 18:46:38 +0100
From: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
To: "rui.zhang@intel.com" <rui.zhang@intel.com>
CC: "17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com"
	<17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "Wassenberg, Dennis"
	<Dennis.Wassenberg@secunet.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"Gwara, Mateusz" <mateusz.gwara@secunet.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "ricardo.neri@intel.com" <ricardo.neri@intel.com>,
	"srinivas.pandruvada@intel.com" <srinivas.pandruvada@intel.com>
Subject: Re: TCC cooling on Meteorlake
Thread-Topic: Re: TCC cooling on Meteorlake
Thread-Index: AdueTC2FeiaDZ7NlSpi4yQxAiQkLXQ==
Date: Wed, 26 Mar 2025 17:46:38 +0000
Message-ID: <b7c2e49c84d94b9e93f3156250346ec8@secunet.com>
Reply-To: "17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com"
	<17a637f633a7560ca87d7461fc56632e5f9e41cc.camel@intel.com>
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

>> The offset is set to 14=B0C on a Meteor Lake CPU.

> do you know who sets it?

On most systems this value is being set in the BIOS by the OEM to match
the cooling system performance in which the CPU is used in.


>> We run our Raptor Lake devices with a TCC Offset of 3=B0C which is what
>> is usually set

> and who sets it?

This value is derived from what a OEM (in our case, Lenovo) sets in their B=
IOS,
but as we experienced problems that occur after thermal events or system su=
spend/recume cycles
we have our own service runnig on our custom linux based operating system
that makes sure the value is always set correctly.

> I have applied this patch on a couple of machines that I can access but
> unfortunately they all have TCC offset bit locked. So please check if
> it works as expected or not.

Will do gladly. Thanks for pointing this out. It's possible that other OEMs=
 won't allow to change this value.

> And FYI, both intel_tcc_cooling and the proc_thermal
> "tcc_offset_degree_celsius" attribute are based on the same tcc
> helpers, so I don't think there is any difference between these two
> knobs.

That's true. I've seen that they point to the same address.

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


