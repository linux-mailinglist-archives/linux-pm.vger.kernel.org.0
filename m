Return-Path: <linux-pm+bounces-24147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81085A649F7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93C316B7A3
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7022257F;
	Mon, 17 Mar 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="tLMpNYNO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A0133987
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207503; cv=none; b=uJjHAM/uho/01f9T9odJ0Te/OwDRH5GzG20aKaqq/2iFq5cdoa5KsqFoqot6lDCw9HUJaPwwoOCBW0NuHO4DFBgEkmRu8y+Ets3TLZgDPEs3jxHxx9JliQ8ZkeQlY6l7B0QgOa0Ig/CLwo7uFRGilXHM2lgTf2jHPOFvRHiBoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207503; c=relaxed/simple;
	bh=Y3okHeux0/mHKX3oJujYmgngXvBu2vOAAWzxVP/oDeM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rjeF7+9oT0lsZLUOPmUqy+Bg7SMCjJ7/aQuTfiBEuWDz4bwre2bagvPOvE0s2RrFRvSZLj5BVtfRMabjCntf+4orpGXhEZyZatytpYEREAzw76g0CPa63tyCQgbkvfm3hjs8s0vMcUzhQx3hId+Fo1um2GKKaFILbxmboJZrbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=tLMpNYNO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5D24F2074F;
	Mon, 17 Mar 2025 11:31:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id al6y5ZLooTQ5; Mon, 17 Mar 2025 11:31:31 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C6E9120189;
	Mon, 17 Mar 2025 11:31:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C6E9120189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742207491;
	bh=Y3okHeux0/mHKX3oJujYmgngXvBu2vOAAWzxVP/oDeM=;
	h=From:To:CC:Subject:Date:Reply-To:From;
	b=tLMpNYNO7i0DcqTN8eo2MVPHl0G/POnamFRilFl+UPss0F9fVvfG2qI2z8LUJfdw0
	 98y/BaSp1CSTzCyLNtfrNcO6ofTccRKOYH2YurNNat3wE/EwZ1q8fe9vFUAcMKBOsc
	 6RyEkNVn/oustNg3rfx+66rHgP6H2KKC8pHGkE6/34CYD1KrdpWFiMJJI2Q335RbGe
	 4gHBkH/+C6BYC3dx0dhcYAgWms/yq9r7JWQksW2TX+BkDWX4nNv+hASYxQXzhGjg4V
	 x3iW8jPueFUcWOAGa0sQtgNCVU71kae2W/6+ElUrq4//HALKrlc+gcrDKsDPNeFDPk
	 7SM4Df+TNPPbQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Mar 2025 11:31:31 +0100
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Mar 2025 11:31:31 +0100
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.039; Mon, 17 Mar 2025 11:31:31 +0100
From: "Gwara, Mateusz" <mateusz.gwara@secunet.com>
To: "rui.zhang@intel.com" <rui.zhang@intel.com>
CC: "163ff391dc6d4f828ecff95e87f5003d@secunet.com"
	<163ff391dc6d4f828ecff95e87f5003d@secunet.com>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "Wassenberg, Dennis"
	<Dennis.Wassenberg@secunet.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
	"Gwara, Mateusz" <mateusz.gwara@secunet.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "ricardo.neri@intel.com" <ricardo.neri@intel.com>,
	"srinivas.pandruvada@intel.com" <srinivas.pandruvada@intel.com>
Subject: Re: TCC cooling on Meteorlake
Thread-Topic: Re: TCC cooling on Meteorlake
Thread-Index: AduXIcaE4XBbkGi2QAiWzDN54mFkAg==
Date: Mon, 17 Mar 2025 10:31:31 +0000
Message-ID: <24742814b1fc433cb778dc6ecb7c671d@secunet.com>
Reply-To: "5e9075f31acbd5a1ef549cc3cd2236173a41353a.camel@intel.com"
	<5e9075f31acbd5a1ef549cc3cd2236173a41353a.camel@intel.com>
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

> what do you see from
> /sys/bus/pci/devices/0000:00:04.0/tcc_offset_degree_celsius?

>It should return 0 if noone changes the offset.

The offset is set to 14=B0C on a Meteor Lake CPU.
This behavior applies to our custom kernel(based on vanilla 6.8) as well as=
 the regular Ubuntu kernel builds (tested with 6.8 and 6.14)


> tcc offset is an offset to tjmax, no matter what the tjmax value is,
> right?

That's true.
We run our Raptor Lake devices with a TCC Offset of 3=B0C which is what is =
usually set for those and generations before on a regular Ubuntu for exampl=
e.
This means we actively make sure this value is set to 3 as 0 would mean bei=
ng too close to tjmax and risking an uncontrolled shutdown(i.e. actually re=
aching tjmax).
Having this value so close to tjmax allows to prevent premature thermal thr=
ottling.
So, the much higher default value for Meteor Lake TCC offset basically canc=
els out their higher temperature range.

> yeah. We should add this. Patch will be submitted soon.

Thanks in advance!

Mateusz


