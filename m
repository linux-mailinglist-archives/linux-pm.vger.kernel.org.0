Return-Path: <linux-pm+bounces-41157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC1D3C3EC
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 10:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1897F52566E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 09:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9F3C1FF1;
	Tue, 20 Jan 2026 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J5ybInP7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB04341AC5
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901552; cv=none; b=Qocq6skoiCOChkEk5po87K7O/xjTN8FfYddAyFz0VYqHTUSUVU5jUI3OGYjZQk3jk5n4ilQJLGn6FsODX6FDkRqIR21iU6UhPBZ0TCz57npesLe1uXdMuwT06ZnRkqi6jmv6NV+LsIoJ7SkG7yfjwgDDdL2IpwlRbRlqXbUEVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901552; c=relaxed/simple;
	bh=yG7GXUi08TQqoQCXbjQXcb082rD2rXZIsm/XPFHnE+I=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=efB11k2ifmcICL3gVldaroXt/nYrfnyaUdrEVG7KLe7prRMpkokr8WloeXCjdzbasqrDrD/uoKBs/xp85j7J2oUmCEO3zCFuBA2JHb6TkurXnndIpLoB7yoyUVTq8Mh8XREoTtzegpi7mfgRJOmLwR/hDNFqMFRf1VEbjb4I2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J5ybInP7; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260120093221epoutp0260971896ea9f6cdc2d0df82cbc071b75~MZpSMb2c50783407834epoutp02b
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:32:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260120093221epoutp0260971896ea9f6cdc2d0df82cbc071b75~MZpSMb2c50783407834epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768901541;
	bh=yG7GXUi08TQqoQCXbjQXcb082rD2rXZIsm/XPFHnE+I=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=J5ybInP7eZRY6Rp7fvEVSn1vhyJ8FlqMP7oRyBna2fcUSA+tQDKUhtRNhpEl3kCQb
	 OlftLsBlHWDc5dYyrEIfECDltcXdtq11uTvk/cHsfAKAOp3a/qAY0t1B22TsWWnNGD
	 eWK2jQe4a9Z/74W0rSy+Mp/OyIyAzVSlr5mKbJqc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20260120093221epcas1p417f3ab15102c853661d950bac524cf57~MZpRqMsCt1241812418epcas1p4s;
	Tue, 20 Jan 2026 09:32:21 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.101]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dwMYJ5BHFz6B9m9; Tue, 20 Jan
	2026 09:32:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v1 1/1] PM/devfreq: Remove unneeded casting for
 HZ_PER_KHZ
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: Chanwoo Choi <cw00.choi@samsung.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kyungmin Park
	<kyungmin.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260120093220epcms1p528ac87fa1d924dae9981c4f049337571@epcms1p5>
Date: Tue, 20 Jan 2026 18:32:20 +0900
X-CMS-MailID: 20260120093220epcms1p528ac87fa1d924dae9981c4f049337571
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-361,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260114093125epcas1p17c29852c6b5b066057b60c9a7795be77
References: <20260114093115.276818-1-andriy.shevchenko@linux.intel.com>
	<CGME20260114093125epcas1p17c29852c6b5b066057b60c9a7795be77@epcms1p5>

>HZ_PER_KHZ is defined as UL (unsigned long), no need to repeat that.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>---
> drivers/devfreq/devfreq.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

PTAL, Chanwoo.


Cheers,
MyungJoo

