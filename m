Return-Path: <linux-pm+bounces-17021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643399BC8DC
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 10:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958781C2335B
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2A1D14EF;
	Tue,  5 Nov 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xmGDr2Rq"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222171D04A9;
	Tue,  5 Nov 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798121; cv=none; b=sj9cFUdUCe4pRMBYzd+grHO7nl4Hg8TuVA4i2HeynTX7kDYT3O6NG+Rqj8TRZmitDJQbmmtbAnj0zSyHgLyin7BWIO0xHqhNbnD6bI/MKcvCTAMNxzP+N+ySodwVhjdcDbaq7D2MIV4ORj+FihR5iG9ODnQvZB2V2OReUYAi7A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798121; c=relaxed/simple;
	bh=LbHcDwdEHOAkqpNM3+AWQqe1rS7CHurnMFLjWtKSxgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG1Q1t8+1Pw4O2k5ivYavBvM2oc3VAQXbT/8FEMEt26IsW7EdkWCdC7BgQHaot5ljditM76q3NkBnAmnuwOx4T8OmA0T4ty2IwPmfXOrP+bg2JdSOUL4xvp7MCVely4gvjh7dwk1XaQ65/6v5lTH8uwhZ+QHJtcfvXqReFhdj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xmGDr2Rq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A59F1J9049673;
	Tue, 5 Nov 2024 03:15:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730798101;
	bh=k56lFvEOKH32JIgIFyzcC92zIpf3K+3SQ3N0wnbsXNk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xmGDr2RqKjv83x+1Y9PDN/1Ngml+S6OSugilnMOIm3G/k+M5F2aaaMVbSb1iDsxfL
	 b7klEZ3Y8I9nQpvTE9CH0mxbM176OORTJmtykiMxIHMYTr8YEUDlTzVdADUuXZ8zlp
	 3syV9OxUh/rhoR2GID447KQ3mFSAMsDKQ/gjcOVY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A59F1DQ051675
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 03:15:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 03:15:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 03:15:01 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A59Er9L091006;
	Tue, 5 Nov 2024 03:14:58 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Dhruva Gole
	<d-gole@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH V8 0/4] arm64: dts: ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Tue, 5 Nov 2024 14:44:48 +0530
Message-ID: <173079800515.66204.13724466415704123785.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241008132052.407994-1-d-gole@ti.com>
References: <20241008132052.407994-1-d-gole@ti.com>
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

On Tue, 08 Oct 2024 18:50:49 +0530, Dhruva Gole wrote:
> This series adds in the OPPs for the Cortex-A53s on the AM62Ax and
> AM62Px SoC families along with the defining the
> WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID which we can use to to properly
> limit the OPPs available for that variant.
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62a: add opp frequencies
      commit: aeedca40159c7017f3f0cfbd1ac2066e091e784c
[2/4] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
      commit: 5dae00dfaf8e4a40c68c8a4d9e453cd06bc5bf19
[3/4] arm64: dts: ti: k3-am62p: add opp frequencies
      commit: 76d855f0580148d8f07f1c0aa96f33cad382e6cc
[4/4] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
      commit: 50f5ad2cb52f322d472dfb451881bea7d7d78d32

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


