Return-Path: <linux-pm+bounces-9430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F490CB68
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C436128B248
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4D13C66F;
	Tue, 18 Jun 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyD593e/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74A77F2D;
	Tue, 18 Jun 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712826; cv=none; b=lLpQhnbBk1Xa++5LRK9QYc089pmQNqmmCVKcCaHp+KU4LiUBaXXqNXyjrGaIdYf7E3LmP5N115QAi5Agqyibw4cGzkxcJ2rf7/FKOUX8dbtN7BPVzzR2MRK9Rv9BbLUWXyPi1WmSDw/HQcPabHrmXAV3S13Jus1Jrtm4mosmIIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712826; c=relaxed/simple;
	bh=yqMqjBqJNsTuMAiurXe6mhlX+bvAkmBH1VT50VqYzp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjXKTp2Q3mgvfYryNW+v8bA0mBKCEQ2A7e/G5ajb/kytj/Vsmnf8veFk1JuDIfsGMibzEV7Bky3HWVDMrzDUwnN9UOabkgk1a5xSwduuLstKj+bpzwjC01KjyY9C6uM/6aEUGjjcpgZdJH2Z9LY232AtG6Z3OVvuIO6+Fb9eUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyD593e/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718712824; x=1750248824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqMqjBqJNsTuMAiurXe6mhlX+bvAkmBH1VT50VqYzp8=;
  b=NyD593e/xKfIwOY2IcqbIbMRkp4EagNXKOy4UULMhrgNC25Sl9yiCnCo
   i51k0Y6xqGAvLu/do4+ykVtJW1CyICufec6KIMM3mw2QveC+xlLisPMOp
   FQFDXr8beOBwYf48OaccajVycPJ1j25Dr8MJ/iRg9E0ZL528ETexhugKi
   swoNWjru1yunO6NjoaGwLkJ74qWa8H4SR0js4XlOgRr8e3Wr9LrxsH2Ib
   Dd+G4AfMCor9uiC7LBfC69uT8hXsTcxDl+6KyzluTXy6qkaXclB1wSJj3
   Gm51oH/w8eDXiaM2pZWepr2x5fb12ZW1lWeRd7HcD+8vWY46VzdIOEuvh
   g==;
X-CSE-ConnectionGUID: QUrzAvGBQ/uq4xXFrr/qUw==
X-CSE-MsgGUID: hdDqqoRETOWoLjUM3Ub2uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26214651"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26214651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 05:13:44 -0700
X-CSE-ConnectionGUID: WafMQi84SWCty/blZGokvg==
X-CSE-MsgGUID: rxiZoslnQ6WKThW0ogBZ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46072092"
Received: from leegavin-mobl.gar.corp.intel.com (HELO localhost.localdomain) ([10.246.105.197])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 05:13:41 -0700
From: Kaiyen Chang <kaiyen.chang@intel.com>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	gregkh@linuxfoundation.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kaiyen.chang@intel.com
Subject: [PATCH v2 0/1] PM: Start asynchronous suspend threads upfront
Date: Tue, 18 Jun 2024 20:13:26 +0800
Message-ID: <20240618121327.2177-1-kaiyen.chang@intel.com>
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


