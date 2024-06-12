Return-Path: <linux-pm+bounces-9034-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71E905A44
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8251F24B3F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2024 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8106181333;
	Wed, 12 Jun 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zHkmsg6A"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87AAFBF3;
	Wed, 12 Jun 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214909; cv=none; b=P8D+jjmp9yPn10E6hoRlzap1p8ppbSQSTKne1ZhuX2gxxhAT3Y+eEo2L04vf16ZitU66pvl6sQgXWnGPk54YRs4asYYRQlwqpF5xHJql9V/ZIUK7bXttQZ7oUXUZCUp5jXd7LNsFD5LPfNXauiLwjxTFTcU+JqPfkiKVrvGVU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214909; c=relaxed/simple;
	bh=VqUGFelUc+HYeis6jtgBeWXp71F6ifc31vMuMY5Ac9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF+toHZgj7ZJC3JB3NSdepiznP53FANeTA77LSdZlfBLeSKi4GN+IW5u+clfTxqoIcV7ITY+soqn0qKMFqAMFySZxSTEgdMBdeT2EnJZecV6yY7AFK1TgyyEk86Bgi1NJUZMHVKCXaYtY13g70Zqji7o5jqr6FE5hHhUndbvxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zHkmsg6A; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CHsvbX055304;
	Wed, 12 Jun 2024 12:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718214897;
	bh=EtQt1y41w+i0eABY5up/EAejlkwfhzYydG/WhSqbVsI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zHkmsg6AAWm+NHJNLl9z7HX/yXEU+frJGLl8Nh0rbB/avHtYy+aHmXLk1QIHuPDuB
	 eAOsx+iw1Ty1mXTrFj0OCdhjYuLWW55bPB3gASJEvn8rfb+CAuE3tSFPO8w8GRYXuw
	 j6drJ4SPdiSPdUjfokRxAX/6AmchVhlXNSr8IH4k=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CHsviO094132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 12:54:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 12:54:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 12:54:57 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CHsvNl077238;
	Wed, 12 Jun 2024 12:54:57 -0500
Date: Wed, 12 Jun 2024 12:54:57 -0500
From: Bryan Brattlof <bb@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/5] DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp
 table compatible
Message-ID: <20240612175457.b6q37nm6x4vsdnks@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240612-ti-opp-updates-v1-0-3551c31d9872@ti.com>
 <20240612-ti-opp-updates-v1-3-3551c31d9872@ti.com>
 <20240612-unranked-unsalted-b32674a98d4a@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240612-unranked-unsalted-b32674a98d4a@spud>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On June 12, 2024 thus sayeth Conor Dooley:
> On Wed, Jun 12, 2024 at 11:41:52AM -0500, Bryan Brattlof wrote:
> > The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> > WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> > various components on TI's K3 SoCs. Add a compatible to allow the
> > cpufreq driver to obtain the data to limit the maximum frequency for the
> > CPUs under Linux control.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> 
> $subject: DONOTMERGE: dt-bindings: mfd: syscon: add TI's opp table compatible
> 
> Okay, if this isn't for merging then I won't Ack it.

Ha! Nice. If I don't hear anything from anyone else I'll send a v2 in a 
few hours.

~Bryan

