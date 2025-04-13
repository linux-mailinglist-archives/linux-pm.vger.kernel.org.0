Return-Path: <linux-pm+bounces-25325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F14A8717E
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 12:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C1D1892088
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709019CCFC;
	Sun, 13 Apr 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDV4586M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CA2367B7;
	Sun, 13 Apr 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744539116; cv=none; b=ElmBATO8NB5+YW4FqbZWMbyQLFX2HssoP5oXtIFcvC3mcmJg6Gyqhboso/yt8lidM3RZ8Mt5yh3739+cZFpUe+VZl4GdwALsVlwuywqqwaAb+pYGIysvisyKZfxfZAKx6WEZMu756SCkby0zqizo+5ROJXPVvojLHoKkErR/n9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744539116; c=relaxed/simple;
	bh=gExjhGq0RicraFHTSpxAfHlYl7CYZ3m6ih1z9/sAZtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R1A2MwPzI8un41KpsTSG0RgOJsIiH8H24gNusSuW7cE2mD7txtUPJSPArsMglKKIdWj1B0qs6zOYkBEct4pyrLjwthnD7VL4AVrv+dqwTzYwcFFOJKpAvzCWDPYOtBSXiZj2sigwHeynOPk7CqDrG2S2DPKiMVHXuG9kN/iIFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDV4586M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C36CC4CEDD;
	Sun, 13 Apr 2025 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744539115;
	bh=gExjhGq0RicraFHTSpxAfHlYl7CYZ3m6ih1z9/sAZtk=;
	h=From:To:Cc:Subject:Date:From;
	b=kDV4586MaW2vyaPEwbGruENlUG/QM/hxyeEopqZSNoGXf9TIuesGeqLnZ9V023gp/
	 4X6hDwrztnMmim7jI/wlgH8eedUBEgPQtuYy/lJCABpDj/Ep9K2uvEBgdR3SAcGA9K
	 vxvRcU+KjDYmQdoWK0aDt81s7OrKosfWDcGbeNX0B7R8FJonpt1I4Cp82epnfoeqIa
	 PostLT/qDDFVwRqygxj61CQHSNMUIZ3Y3CKKSqNHA/RYtZhFKe0HJ9GAnkPg/nLUa3
	 VzyvhKsaUxUCCUo7OYF0e8Hs7bLnyioxLgrOTQU5J6YANeGDNTTMayG4TewFbW5hpI
	 cV3WurTpC6ZUA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1u3uJc-004wDv-QD;
	Sun, 13 Apr 2025 11:11:52 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: cppc: Fix invalid return value in .get() callback
Date: Sun, 13 Apr 2025 11:11:42 +0100
Message-Id: <20250413101142.125173-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Returning a negative error code in a function with an unsigned
return type is a pretty bad idea. It is probably worse when the
justification for the change is "our static analisys tool found it".

Fixes: cf7de25878a1 ("cppc_cpufreq: Fix possible null pointer dereference")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b3d74f9adcf0b..cb93f00bafdba 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -747,7 +747,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	int ret;
 
 	if (!policy)
-		return -ENODEV;
+		return 0;
 
 	cpu_data = policy->driver_data;
 
-- 
2.39.2


