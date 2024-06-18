Return-Path: <linux-pm+bounces-9420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA4D90C81C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4CB1F249B3
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259C1D3626;
	Tue, 18 Jun 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3k7NJPQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD813B587;
	Tue, 18 Jun 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703327; cv=none; b=VhoBCZyvUIqSETdJpVF0Y9hqxwayIIrWGIv9tWHA/KO9K1Upl0IItZjfA6ZhAQ6HOOu/tR6XnFSnBnEUH5ysi5xTRl+7mEFhvmUOdbS3zgQGKoBq3kGIueAnG1X+BPiYLe/KDOWrVKZtLCAv4aGfloePFx0eAiI4E27ZYdjb62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703327; c=relaxed/simple;
	bh=yqMqjBqJNsTuMAiurXe6mhlX+bvAkmBH1VT50VqYzp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbV5t9I+OSaZLuhljSgSfp0M+1LByGwHULz2PZNstoCHpK+CwR5XM1HU0ZIf1oh3k6aRQlUY2eMHAR3dR/nZPAdexPNjMnmULbUVDLXd98cyiCmMt6SoWGr1yQSrpiDIDxsQntqJholPXddHIxWFGTXgXGnGPhq9VO7iwj+Fpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3k7NJPQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718703325; x=1750239325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqMqjBqJNsTuMAiurXe6mhlX+bvAkmBH1VT50VqYzp8=;
  b=P3k7NJPQiOw5LB1vcBFkH8nOSzJOlFaeKQZDrJlIWSrso/yvbrTmLZ9h
   Ybaa9URPzeLH9Z9Q8vy5sEzk+4/aUkt0NF46zAVCQ4QyAKQT7kzSfhYXk
   vkhByqWWvh7iheY9xnLLTtUcpgC7XquuCcMLdWINpeIOtuBNG7L6/W49B
   0K9sd4kbgg8lsB7jh79dEtwX3KcJNBURdCqI0rwmX1nIjHGWkytjCH8QJ
   Gt7tqinFG6wDrjzirSMic955i6fNC2eQ4HdMcDqYexvj7txIXSsjhFnFh
   0pF56CwwljkI3ANXyyUiNzmybUyg8EVY2sSrSainUKyDVsju5vTK2nE4/
   w==;
X-CSE-ConnectionGUID: pB4J1+upQu2sj2Wv+1pehA==
X-CSE-MsgGUID: dgkjerI9Rk2NZyrzQQ3/8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15400064"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15400064"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:35:24 -0700
X-CSE-ConnectionGUID: ewwaC2dOSaaqUXaMth0oAA==
X-CSE-MsgGUID: 9RGg/C5SQtaGJ8qsOR+2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41968667"
Received: from leegavin-mobl.gar.corp.intel.com (HELO localhost.localdomain) ([10.246.105.197])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2024 02:35:22 -0700
From: Kaiyen Chang <kaiyen.chang@intel.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kaiyen.chang@intel.com
Subject: [PATCH 0/1] PM: Start asynchronous suspend threads upfront
Date: Tue, 18 Jun 2024 17:35:06 +0800
Message-ID: <20240618093507.2143-1-kaiyen.chang@intel.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Kaiyen Chang (1):
  PM: Start asynchronous suspend threads upfront

 drivers/base/power/main.c | 90 +++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 33 deletions(-)

-- 
2.34.1


