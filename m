Return-Path: <linux-pm+bounces-33245-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84632B39AC4
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF7C174891
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D930DEB1;
	Thu, 28 Aug 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igoU4tK/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709D17A2E3;
	Thu, 28 Aug 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378790; cv=none; b=ip9MEMUbLApYSwOB6QEiEKNX9WpjEpMXM0wCG2CgqEFeiLCAlGhJJgmCphcRdoXaClnFKCqnAnLVJpBxb0MTiUYCPPEq/eXnYV74IFfmonSIb68L846P70evpsdL9CO6f2hBpKbVobdN3rW3D304z+V/DewFkmvW77rLyr3MFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378790; c=relaxed/simple;
	bh=mXa4hTXE0pnYOMhOa57ICNpvT17lo5XMaqOh1iOxDMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q48EdhUssS3uW5MKZVXYT246/1JhH+Jo6y+Zz22O+jSMcyS2Xtb85kFkBkykj81oyFIsIHvcx35dz5fh61M5JbmHvX3l0FOV9XYjuFSM5wRcVheknCAZBbfIpe+F9pbLLnTw44CjavSeB1ieGWH2vtpC0PhZNPLnrD/xMcC/bcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igoU4tK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCA3C4CEF4;
	Thu, 28 Aug 2025 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378790;
	bh=mXa4hTXE0pnYOMhOa57ICNpvT17lo5XMaqOh1iOxDMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igoU4tK/+vKil+TuF7w96tyYakwpHoTWTzzS6yivyI6GxDz4fCf06NdM5EE5bZNjI
	 VRX490ljhpOp5yMhx+jxldSJRLvcfEsmNrIXP+Ipc2gvBAWJRCY079xraxhXGAfAFh
	 2g7f/OXrfeGUN7XnkWO7SaCyC4TFxo9GHpPuuDsGcy88X8KOGGR4XAcBYrhaveDiLO
	 rFFBbUuvES6XBgkcdYvjVZlEKRwbicEiUw1DixjaySGJJgvmOzIuNFtoQ1Pob7khr9
	 31i75boFfoRoFA+xzzFYuwWkdF6qQegjXldJAuRFL/N7/KMrSK2isclrEG0Y0qsHis
	 923bnAsHdk8mw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 1/2] driver core: faux: Set power.no_pm for faux devices
Date: Thu, 28 Aug 2025 12:56:41 +0200
Message-ID: <6206518.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12749467.O9o76ZdvQC@rafael.j.wysocki>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since faux devices are not supposed to be involved in any kind of
power management, set the no_pm flag for all of them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/faux.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -155,6 +155,7 @@
 		dev->parent = &faux_bus_root;
 	dev->bus = &faux_bus_type;
 	dev_set_name(dev, "%s", name);
+	device_set_pm_not_required(dev);
 
 	ret = device_add(dev);
 	if (ret) {




