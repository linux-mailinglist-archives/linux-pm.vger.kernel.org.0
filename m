Return-Path: <linux-pm+bounces-31444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56DB13325
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 04:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898561895B6E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405901FDA7B;
	Mon, 28 Jul 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="UzPT5M42";
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="HBzph/Wu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AE2D052;
	Mon, 28 Jul 2025 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670854; cv=none; b=Jyh5B6ag+4Jl3iLTmlbasqJet+mEFyNuv7/yCTa8E/2Ldk5Vog89B01kmQulqBu9H/K2nbGab5F2R/gJHVD7owES/D8Axmg4zbYY3YOCbmvPX+b4hjupgFaJJUMLNuFamygWhZEE9SK62k6SoITUB67S6/oCdkyAiGEtRleyCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670854; c=relaxed/simple;
	bh=BAAxqp9vI+vv9l8n78TpipaFS/tAj3zESdpvGUii4ZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dH23IQulATvH7UEaHhJkb6WPB4eUUWmb9Q+t2JG2/BFmSjt9CpdCktJa/+TKGI7uPIF2su0UhBrEx6aPBV50nQe0QM79FjKzBdzA0YF8BsKRMi+JGRpPwkKLOLNC0GfRxi5fZLx2tOWBVsRoaumQtmffDxZl1VVDP9BviCcf7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=UzPT5M42; dkim=fail (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=HBzph/Wu reason="length tag value exceeds body size"; arc=none smtp.client-ip=220.130.44.152; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753670841;
	bh=Aj/KlS5ZA8REOezi8S1UBVmo1gYS5o5doKhuSAWCKF4=; l=269;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UzPT5M42gsDGuItPUcrY233lx0obDfFzBlV5UbSGZbq+WiyVzutWwEcIDf6St8dYl
	 gLRRJJRYck65xV2sloUaG7wvh0NrRC197NLxwxwLbF+HoxaHccDKKcvlMZ+z/Gz8SZ
	 CGRLHd44Z8YNqsIwB7zybU8B1GiDrU+QenqlN9NxWo+CFIsAwgRBIj+pfcvmkHnoYD
	 Da5vQxXr0bTEwxgHm61UmMB9F6fY0RhxfVnvOntydcqc3cGFl1xJPxhCX201oRMJE9
	 un1u3HZJD0JORi5PGS3vor6PRoLTSPWwrYa/NMPs3BCjWTYrE3NsbQJo5+Lf3vPP+z
	 IOf19mRxeUM9A==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244605:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 28 Jul 2025 10:47:09 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Jul
 2025 10:47:08 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Mon, 28 Jul 2025 10:47:08 +0800
From: cy_huang@richtek.com
To: cy_huang@richtek.com,
	Sebastian Reichel <sre@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: supply: rt9467: Add properties for VBUS and IBUS reading
Date: Mon, 28 Jul 2025 10:47:47 +0800
Message-ID: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1752542001.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1752542001.git.cy_huang@richtek.com>
References: <54fd32fc23fd959da8aa6508d572ee96de5f6eec.1752542001.git.cy_huang@richtek.com>
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E717C21B; Tue, 15 Jul 2025 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com; s=richtek; t=1752542356; bh=nFc7sXSxrxXrn9CbhO94nNCIuL9JOjq3fHd1XbxNFLE=; l=1888; h=From:To:Subject:Date:Message-ID:MIME-Version; b=HBzph/WuA8cLgQDpZoE2w4LfTP2epfCOlVcGC94BMYegXUmrYEXYMZgWnrLSduaSL Rvn5Gh189VNU078dOpXd1rfMqS+zfzE1pnhtX+u7r5WIPchzGgNQJZkx3qDOHIaxhi U4nPegYOcDtJbF4WUrlHHJ/YRB0YYVtDt36sMZ5TDyE5V4s5SBwNPHsvINhMAhpCym fzp94lWsWdJvgIr5D8od4dURjjxbOrV3s5bjffEds4fri0OgoLHMe9lxMgyi7wiljK LkAzTCHEMQdsTwy6SXQc+s5EUU93dVK3JPKeNLnsgRSFGgPFxS4sOTIIW1eakfwz8m 1MjtFGU2LqjfA==
Received: from 192.168.10.47 by mg.richtek.com with MailGates ESMTPS Server V6.0(244604:0:AUTH_RELAY) (envelope-from <cy_huang@richtek.com>) (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 15 Jul 2025 09:19:05 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul 2025 09:19:05 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend Transport; Tue, 15 Jul 2025 09:19:05 +0800
X-Mailer: git-send-email 2.43.5
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

From: <cy_huang@richtek.com>

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Since there's the existing ADC function, add properties 'VOLTAGE_NOW'
> and 'CURRENT_NOW' to report the current VBUS and IBUS value, respectively.

Hi, any comment about this patch?


