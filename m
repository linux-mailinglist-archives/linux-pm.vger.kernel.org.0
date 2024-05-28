Return-Path: <linux-pm+bounces-8201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949ED8D10B9
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 02:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8B4282A12
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 00:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6A39B;
	Tue, 28 May 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pRAqlqMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE0364;
	Tue, 28 May 2024 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716854802; cv=none; b=nJ50FVYyAHdAOACOZ57mnoAVvdjwAIz+tgaKa4BRig4aFSq2IF0iVvgFyKxCMxRPzaLHndLE1DSNo9VloxP9vRUXQXw71jEt0vqDNmu+vn7SRetVli8mschSlcd7qDvZyMn4Q8FjJgreNIEkQoY4kXVEK/lEX2mCoYsZDSEnNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716854802; c=relaxed/simple;
	bh=DJqBCnaIiLZ6TV+q82PwY+BZfCuhkw0yr7KZ9Px9Pso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUR0q1TkSj2+Bx3U8CfgsOh7AmoBfjgiUiXcOxu7re0id2vNQ4JVNj0HMJ59YalsRH9mRDFHQ3NBOVsbTnr+/0E9kOI37cVxYWfqP6YVb3pTvGuErrLdxm39KGz63BtZ9FpBbQV3tT3c4leVUBsCWOS98D/UjBrU+LphCW0imug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pRAqlqMc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jOmEJNz30Q1WtP6buYZRM03BCS5my7pudHORUvDAbJo=; b=pRAqlqMctoBG9Grh
	Ld7s9D0Uyu0ecq96p6qFaM1SPTELgCdxLUl+6Tm9bZk5w5b5hP30KB69acAYppqHdriBX8EHqXzCN
	Flsbz22570iKW81bzmFQTr1h4YWVYwpYEQsga2E5P4RN7C2HhV4/kmxu0Y/J3+6U7nkA6CokfW+eL
	d5yafxLqZVWbWJV0A3s5F5ueajRIID5V6QlUU/3oJ5/twJvPqo3zaI3QkPkTyPuXvsEu3dqeRDCNt
	hJCI6moymwMaid2jnji864tNdUIEdRrCrpakDMNL1f3PLYjUw70JXzdTRYq2qpisipOoav6dUObPL
	Pm2f75+0KajnrIrS7Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sBkMO-002pjT-0j;
	Tue, 28 May 2024 00:06:36 +0000
From: linux@treblig.org
To: linus.walleij@linaro.org,
	mazziesaccount@gmail.com,
	sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/2] power: dead struct removal
Date: Tue, 28 May 2024 01:06:32 +0100
Message-ID: <20240528000634.196707-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

A couple of dead struct removals in drivers/power

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Dr. David Alan Gilbert (2):
  power: supply: bd99954: remove unused struct 'battery_data'
  power: supply: ab8500: remove unused struct 'inst_curr_result_list'

 drivers/power/supply/ab8500_fg.c       | 5 -----
 drivers/power/supply/bd99954-charger.c | 7 -------
 2 files changed, 12 deletions(-)

-- 
2.45.1


