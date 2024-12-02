Return-Path: <linux-pm+bounces-18373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682039E0B94
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD9280CCF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D301DE898;
	Mon,  2 Dec 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="tSf73ptz"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070A1DE3CE;
	Mon,  2 Dec 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166142; cv=none; b=iMbpnkOd+HeS379n4+Eq6piROQ38DQt3JwqqBzbIa/rIDf5qk/EyByHo5caDxTi95HLxKGFzW0u3f1KL5id4SmTLntPz43E3CrYt3K5E6s/Wit+b0nZDiDTP/MkqTJqGbjKP/XiEmrnPagY9ZGYpq5oF5snDZmfk0DZVq7XTanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166142; c=relaxed/simple;
	bh=Lw0cF1apHEYbyMDv0FlJULjHdocoRdy1EJZCufUNKiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBw0U9ncPgKT+Vlc/4b9Fk2OdtXb1uiJUItxiOEARt6nZ7xVsGO2WPkYPLi9G/DJOkiur3TCw0pchn8f1XaG6SleooT++WSAttxQCd8F2n6mmjm+URNJH2DBNbTJCkH24fxdt63bzHUBYECnwJOk2dDLDSQnP7x7A9m442z9PJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=tSf73ptz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166139;
	bh=Lw0cF1apHEYbyMDv0FlJULjHdocoRdy1EJZCufUNKiM=;
	h=From:Subject:Date:To:Cc:From;
	b=tSf73ptzoiI/IyAaxbLzcmgZum8vSUnezgdS9pFdaPTjEvG5wB0xn4zhpCXVFV63W
	 JTXmhVQHJR298xHoX0BoP/tfZDScN3FIrsNtxSTXOEwwtYQuj8slPd3CwxqB8cHkrc
	 70WbhdyG3xY5Q5Azye4A/nQLsTEAEmawXjqYHMq0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] power: supply: constify 'struct bin_attribute'
Date: Mon, 02 Dec 2024 20:02:18 +0100
Message-Id: <20241202-sysfs-const-bin_attr-psy-v1-0-f846430b8b66@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADoETmcC/x3MQQqAIBBA0avErBtQqaiuEhFpU83GwpFIorsnL
 d/i/weEApNAXzwQ6GLhw2fosgC3z34j5CUbjDKVNkqjJFkF3eElomU/zTEGPCWhbWxXV51yrbG
 Q8zPQyve/Hsb3/QA2VixTagAAAA==
X-Change-ID: 20241201-sysfs-const-bin_attr-psy-b6b95490c82b
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166139; l=1142;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Lw0cF1apHEYbyMDv0FlJULjHdocoRdy1EJZCufUNKiM=;
 b=QjMIX/yWXf5++PynwpYtLyfcxFXlxY16K8Of46voEWBlIgmI8ZT6HF5a6Jm9UbfBepdetKvrF
 UQwDnYuUGNPCVPihSTlLbNjtdQM4tMYr6OZLJzHElGhyEbx7h8Ibybh
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

The usage of read_new/write_new/bin_attrs_new is a transition mechanism
and will be reverted after the transition is complete.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      power: supply: ds2760: constify 'struct bin_attribute'
      power: supply: ds2780: constify 'struct bin_attribute'
      power: supply: ds2781: constify 'struct bin_attribute'
      power: supply: olpc_battery: constify 'struct bin_attribute'

 drivers/power/supply/ds2760_battery.c |  8 ++++----
 drivers/power/supply/ds2780_battery.c | 24 ++++++++++++------------
 drivers/power/supply/ds2781_battery.c | 24 ++++++++++++------------
 drivers/power/supply/olpc_battery.c   | 11 +++++------
 4 files changed, 33 insertions(+), 34 deletions(-)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241201-sysfs-const-bin_attr-psy-b6b95490c82b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


