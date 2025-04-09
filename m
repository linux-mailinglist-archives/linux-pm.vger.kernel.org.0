Return-Path: <linux-pm+bounces-24998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878ACA82183
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5762616C467
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9F25D535;
	Wed,  9 Apr 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cwrItvD6"
X-Original-To: linux-pm@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665812B2DA;
	Wed,  9 Apr 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192720; cv=none; b=TScFuIkjUfZJVogwKF4ghfVfVl+za/qbl51D6kvCm5njf7fQBTcyy7+zAYod/MhQ0obzWQSprJh//sJdkoyR9wO81I5mRIvZuJu/NgHbpvxLs44zIgQQuZq+nWGOqEr7Sd3XvAPshvVZmvw2OYPinscX0oZT8wamHVUuT433rno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192720; c=relaxed/simple;
	bh=+3JfXT1Xs5fV6IP12sI9JzAAOim7iJsMfyQ6w0e5gxA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=X77FfHmXB+fYSTfJyYNdwj9ixWGgh/K3TIl6y0cgzjeuRNq95umvQZfBEwLo/sdn33mBMuVrijXnv5kn5l5s2CkpNkDo2OOPBlpv9gfVtB+JOqfpaTdAxCO4i2QjWFmvfF12QuSSsX4kw0JDRXcWdAfqIRzRxqC3/DKhooyvi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cwrItvD6; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744192706; bh=+lyAfonLE1WC9lkwgR5fNnzG/kCwzKlfRCzS5ujqlpw=;
	h=From:To:Cc:Subject:Date;
	b=cwrItvD6FrtHAYm0SuOuDYeuj5NWQs5VI52utkSpmpBwYd3dTvnOlac3ARXKUhApE
	 ayt31MIt0qZtTLm4tCfFHuKkOtmszFWcRFwFyPLlgKXGRleK/iUHVd0QYM5TaiMzhp
	 ore0gNQja84Z6QW8NlZsLP6PNqUZky0lFUpaLaIc=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id C71194AE; Wed, 09 Apr 2025 17:49:49 +0800
X-QQ-mid: xmsmtpt1744192189tzh3ku7q2
Message-ID: <tencent_D6C4728C5C687C042BA7C156B0F3ECF7AE05@qq.com>
X-QQ-XMAILINFO: MLQF5pNkQhvxiqkx6mdELVKIwLq3+oG8ZVIOq2Njw6DkGw45tjnxQoLppcwGyC
	 kX2Vy+O/6O/hEEL5PHfSDLMsNvDkvpP6gY59SRTODlsmX5aHEsakNUonbkva2xj+6te53r7OhkwB
	 3t8Q993M5iU7iBO9Fv7TyN9CFBM6X2v4o5s3LDHLjj5uL9q9A2hVu2VfSKs8WtZsyItJflyOPSOO
	 JpT4lC3PUy11nC59brIj8nlCsRp13g1swZQ6wYFEu1Mm3po+E5oR327UxAz8LQJAEzoFnWcW29ha
	 YJyz/jaVYxROdRSXTDBeVriXxuhHLEcDz7muziNqeVEqO/5Z5fv0T3a6PUULYD6hxhFU9ub0rzoA
	 ByTMCm1GpiKGObCPRi8yc83aW0NDegFqINhG/S8diTbruYYGipiVuFOj6erAifJX8cK/nteSIOzp
	 tWwkEm+fVh58xKtISGm281HM/XmqEzjoH16HmkvNG2UjzHFnQq/2hAqC17H4B14OcS4QAJJCl9Qy
	 j9LPpaA0WT9htPGUbbQTKlGyxJlryVoLeWuD1KE37un53DfuRhATbVBqPeIr++rk61Jon08aeTMH
	 NT94fqnPG1FdIVRo/cxPSV1OJ5kGwObNMAMVbMxKZdGziaxAtT++7NdUtTyCg0uO3MMSEZVOIguV
	 sWazrMy7lMhigpm2DeBzA4MiAT8AMLD3gz9HlyjaNPnPsMwumxNtbWTvhIqKKNyg211NqNelMG6b
	 GdldoKbojB2iAPxzrKToFi1b13LCZXyUpivo+EP2rdSmUGGw+BdoToavO3pF74xPBXVKlMRjlSxC
	 49NhYV8VA84WLsJDnQ5m/eaYUIFfBxKKPcnxz1HOdmhXV9vo61ypceiw9eJ3r70+8+S+lyVEZyVG
	 EDgJv8mqxACW0shN2ta0XWjSOHAazrzRpQGVtlycQwjkzL4Qj8kSlAdgSCWygXYSaxNwwDh3nzHN
	 9R6ttKlcebFZt7ny8umA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yaxiong Tian <iambestgod@qq.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	Pierre.Gondois@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 0/2]  Fix and optimize some comments in the CPCC EM model 
Date: Wed,  9 Apr 2025 17:49:48 +0800
X-OQ-MSGID: <20250409094948.1684994-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Commit <740fcdc2c20ec> ("cpufreq: CPPC: Register EM based on efficiency 
class information") introduced a very good feature. However, since commit
<1b600da510735a> ("PM: EM: Optimize em_cpu_energy() and remove division"), 
the energy calculation formula in the EM model has changed. Therefore, some
comments need to be updated and corrected to avoid misunderstandings.

I carefully analyzed the code theoretically and found that the new energy 
calculation formula doesn't affect the current code - in fact, it has brought 
some improvements. For example, consider four efficiency classes (1, 2, 3, 4). 
Under the old logic, there were cases where tasks would be scheduled to class 4 
CPUs instead of class 3 CPUs. This happened because the old energy calculation 
formula divided by CPU capacity, and since class 3 CPUs have lower capacity than 
class 4, it sometimes went against the original intention.

Considering that the comments about CPPC_EM_COST_GAP might be confusing, I've 
added some analytical comments before CPPC_EM_COST_GAP in the latest code to 
help other developers better understand. 

Of course, this is just my personal understanding - please point out if 
there are any mistakes.

Yaxiong Tian (2):
  cpufreq: cppc: Update and opt comment for cost calculation method
  cpufreq: cppc: Add comments for CPPC_EM_COST_GAP calculation

 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

-- 
2.25.1


