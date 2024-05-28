Return-Path: <linux-pm+bounces-8203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E598D10BD
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B969AB2143F
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 00:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA18C4437;
	Tue, 28 May 2024 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cHgIgS02"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4B3D60;
	Tue, 28 May 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854817; cv=none; b=E2RjUz9AgVyxbjfzl2Ah1y15qEyXQo7AOzsyuiJbBsAQoDnlbqGLMIPIbprTw7mKwYoJvxkbln1VUUfk2sDUAGJ6smlsCMg1pZ6d376/ae6SLZiugyZG/af76+u3djDSKpCIe+MRtqzhFqscVQYg9Wdsm2vw0/XqDAq4LMI3swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854817; c=relaxed/simple;
	bh=nHIJF35gTseYvkKr6yqDBvEr0/gnk5iz6v2MRmHRJ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ctj2iFaK/8rIc36J3o9RoUGN4dxB5eJ0LWEKOZWc7QEU2uIIB9mWoiQLZj7S1QehoE9xSXLTV363inaZ7VvC0glkr0ZD8QXpexEZRbN8s+HxvekuXWQJOhIpfDf/Z6taaisJp/J6RxpfXd1oDenqOxerUu/7GujCKWf7QM/kftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cHgIgS02; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=comtV4uctll963daNsHHBdXUj8VKgmG78S0R3+GGfUI=; b=cHgIgS02r2+tmi8r
	KIt3n0GJh5gQr3f8gehfSWbehaK1bwr5CGKzQgBKX0IYfHd2o6hcfnpfPufDjvKmuCMkM6JJto72V
	kwDxzbP2OYuLH4ko4C09208N2fVK/S8+ZpACt3bBmQpoYl40DcFrNIQ5g3Dwq+yRdZf2ud+i+sI+M
	e2+0NR22WZ5gPC5fNA+CMyyExDVzE6SBXHDWPT9trrEEL4yVDProz9EqEajgG5z50iq930DyZehhP
	INsrWxHgz0Hnnlco5xU8XouDsEpwhjjvvgx9AEcKmXI3iEicIo5qfk/Cc4197pH6tme/XEPh9nQ0N
	y8Yubw6vHjLTdHProQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBkMf-002pjT-0V;
	Tue, 28 May 2024 00:06:53 +0000
From: linux@treblig.org
To: linus.walleij@linaro.org,
	mazziesaccount@gmail.com,
	sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/2] power: supply: ab8500: remove unused struct 'inst_curr_result_list'
Date: Tue, 28 May 2024 01:06:34 +0100
Message-ID: <20240528000634.196707-3-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528000634.196707-1-linux@treblig.org>
References: <20240528000634.196707-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'inst_curr_result_list' is unused since the original
commit 13151631b5bd ("ab8500-fg: A8500 fuel gauge driver").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/power/supply/ab8500_fg.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 2ccaf6116c09..270874eeb934 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -149,11 +149,6 @@ struct ab8500_fg_flags {
 	bool batt_id_received;
 };
 
-struct inst_curr_result_list {
-	struct list_head list;
-	int *result;
-};
-
 /**
  * struct ab8500_fg - ab8500 FG device information
  * @dev:		Pointer to the structure device
-- 
2.45.1


