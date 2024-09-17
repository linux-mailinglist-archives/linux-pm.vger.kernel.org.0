Return-Path: <linux-pm+bounces-14366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175DD97AF47
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E66281AB6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0A015B14F;
	Tue, 17 Sep 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NP0JiFdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B261EB2E;
	Tue, 17 Sep 2024 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571553; cv=none; b=AZ41N7LKqTiVenhcTRE9Z3HHekjI66NNUmBJqF1hlTkLwWTwQUCYn6+31dfskM3N7lUhdj7XyJKInpCd7LUC9EzmaNV2Pvs0SIxM4T5ZSlXO00fgqlq1iMqultmGt4YNtWZybcdBcGlR4s4rPn5Qi59djn9zfbcXvao6lmcpnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571553; c=relaxed/simple;
	bh=th365aV1O+nGA5aBZf9Og6p5JVrbCH1uNZNXWEcsUt0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HANq31BgKoKIQwrIohFc7uE+9pzzkPw55WwtG3iP6PBJWmfCxy+386zScx6cJ2de9liuvRN1+bkw2K6vwVivKp/r74TDKLAV45NzUbG07WyGJZx0Bjw3qkExAuPTFB/b45aYfE0ARMu5ZlgwBZWfv3yj/jIVMJBic/lgqyDGh6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NP0JiFdP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48HBCHJY131051;
	Tue, 17 Sep 2024 06:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726571537;
	bh=O2qUyvxpXkDxiU3OGy1Na0UNA/PkdcD9I0rS5TupXEI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=NP0JiFdP4TS3JRsQ3CTOBFfs5I6YazreXl4s36RMWMPhLLRR7ez4VSAgx48WTXCnO
	 n1DyVZH16KAUlRVVeEGbxyVQK/mIVICujwJkB11Zj4qm7Q63s/jb0X7ljPKvp2QE35
	 ciErsbqHirTd4Pr6YC9u5Z6yTc4x7uCAI1LMCkAo=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48HBCHHL100603
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 17 Sep 2024 06:12:17 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 06:12:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 06:12:16 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48HBCGCm010375;
	Tue, 17 Sep 2024 06:12:16 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "Len
 Brown" <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Dave Gerlach
	<d-gerlach@ti.com>, Georgi Vlaev <g-vlaev@ti.com>,
        "Markus
 Schneider-Pargmann" <msp@baylibre.com>
Subject: Re: [PATCH v12 3/5] firmware: ti_sci: Add system suspend and resume
 call
In-Reply-To: <20240904194229.109886-4-msp@baylibre.com>
References: <20240904194229.109886-1-msp@baylibre.com>
 <20240904194229.109886-4-msp@baylibre.com>
Date: Tue, 17 Sep 2024 16:42:15 +0530
Message-ID: <87o74mlek0.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Markus Schneider-Pargmann <msp@baylibre.com> writes:
...
>  
> +static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> +{
> +	/*
> +	 * Map and validate the target Linux suspend state to TISCI LPM.
> +	 * Default is to let Device Manager select the low power mode.
> +	 */
> +	switch (pm_suspend_target_state) {
> +	case PM_SUSPEND_MEM:
> +		if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> +			/*
> +			 * For the DM_MANAGED mode the context is reserved for
> +			 * internal use and can be 0
> +			 */
> +			return ti_sci_cmd_prepare_sleep(&info->handle,
> +							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
> +							0, 0, 0);
> +		} else {
> +			/* DM Managed is not supported by the firmware. */
> +			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		/*
> +		 * Do not fail if we don't have action to take for a
> +		 * specific suspend mode.
> +		 */
> +		return 0;
> +	}
> +
> +	return 0;

Looks like this statement is unreachable, may be generating a warning as well.

> +}
> +
...

