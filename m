Return-Path: <linux-pm+bounces-17020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF49BC8D3
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 10:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D7A2825FC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C8D1CFEC2;
	Tue,  5 Nov 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GkakHc+k"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198E1CF28B;
	Tue,  5 Nov 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798109; cv=none; b=kY/qftW7GZnTgli35JHQHAl/YJ8EjlgFyAGscNlSRo+XZDHPmDaLEn6CrukjWdFGrLpP/G0yl+y3h2Pmi9jyJ2cIlwThzPmSTclomx3VarAFqZ8jIE6Utnv4n6xK8l0GJCojKefMW6c0e4hbVXf/PQWvW17bFW7ELRDXHZltFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798109; c=relaxed/simple;
	bh=3P46o0j1boPq47979gi5/Zs5Hid9KuIAHBkIlRk8teQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGYxHGTTd67eaWmLLo8/Etp+HnLn2kbbQHnOWv8uVtGluw5KHhWLFveMH3CX7NpJaOTdTft4sUcepGTRN8CXhV1nOJciaT+NlQEalkIBxvOYtLhvja4KjV+tDbtaHrXvEDawAvnKFksY+U4TlhA/UPR850bpMGd4ZnIkTxDPZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GkakHc+k; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A59EvOe054097;
	Tue, 5 Nov 2024 03:14:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730798097;
	bh=GsBEnIeM0ClFMrKKZeG8lCafRcbNksm47uQYOf90CDk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GkakHc+kTyeQ3+hYO5WlLi45e9rczsQ3a1/vU/gtWJWX2DHEEoJjVWUUKjW5jmE1f
	 /Er9nwM2AVdj+SuDcJ92mly2XMUOIZMcJCmmvUCXwxbPUX59ornVtdB59kwZ1alsw0
	 ZhFqhdpHBGicXQglAEdCt6kYBA7deMHMThj/NTdA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A59EvRV002378
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 03:14:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 03:14:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 03:14:56 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A59Er9K091006;
	Tue, 5 Nov 2024 03:14:54 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH V3] arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
Date: Tue, 5 Nov 2024 14:44:47 +0530
Message-ID: <173079800515.66204.10332098378075075871.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104063707.3604302-1-d-gole@ti.com>
References: <20241104063707.3604302-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Dhruva Gole,

On Mon, 04 Nov 2024 12:07:08 +0530, Dhruva Gole wrote:
> Add another entry in the wkup_conf for the syscon node, and then use
> that for the syscon in opp-table.
> 
> Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
> be addressed similar to how other child-nodes in wkup_conf are implemented
> in the same file.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
      commit: 767b6a0d0900c951e8b42306bd636268481a97ae

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


