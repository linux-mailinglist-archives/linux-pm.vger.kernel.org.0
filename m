Return-Path: <linux-pm+bounces-17000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EED9BBDB4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E199AB227EC
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 19:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58161CDFCC;
	Mon,  4 Nov 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5O9sU7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0C61CC177;
	Mon,  4 Nov 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747217; cv=none; b=q/M4140XvlCVJYyo1W3cm0t23X0ymelcLOY9PDxrlCU/vu7QgfVADkuiPgord/gdXHiTznSnFMMc3dIazJry6qVMjSMblY1K6Ix2CnGWgt2EE6mpVVXN4eOKlR7s5bnK5U5+VMcKM1ARBJtZorFOsp8+zGf6I38vWUko6DRRsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747217; c=relaxed/simple;
	bh=8G3u0cAu8IlDEnmYeBDz9tZXjFHgHJuzJSxWPMhwjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O9S/zc8ITHPSSe5fHSc5Uo/v04H++68bwxp6iI7OxeqkcL4NsWWIeo0gCim+n1pDTyJNNYfWENJXIPm8V1hFDB4J1c3cEqIRDtAi+CZRwTSR855oR2jrLNNssKqE+9Prx52vuN5oCoMPuIuogz1kPWExnsUEDW74cInbYlkg2lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5O9sU7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7C3C4CED0;
	Mon,  4 Nov 2024 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747217;
	bh=8G3u0cAu8IlDEnmYeBDz9tZXjFHgHJuzJSxWPMhwjjg=;
	h=From:To:Cc:Subject:Date:From;
	b=l5O9sU7Otg3dNc3llfwWI6u76HxrMQktav2Et0rstTigHvr9333Ogfve2Wnrm78n8
	 kT5O0nDEZ51ausRHvMQIkCLHa/XTUJOynIYhE3yaQzR+QS4B/TpUNRg1heZsE6vDDH
	 CUrkqpfxQjrJywfsBQ1ubRLKHCDTXZ9LhjZ+oakxZV1Aa7Rr9gee07VX3RvJeHLTvv
	 q79ECJUryYypcF8zLgbXmTtMLrz+Z2WJtqKyjAJaAK0SdiYh/u1/UK/qqOeIbsZ3UO
	 WgqM0/lRx9lhmgnqtBHOuZx48GjpD1yyR+2Uvg5uHrzxXjuHtalqZKFrA2Tnb4g1Gb
	 UtP7oDrlt+qCw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:06:49 -0600
Message-ID: <20241104190650.275278-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7e9b996b47c8..bd5b18d1ca10 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1081,7 +1081,7 @@ static int of_count_icc_providers(struct device_node *np)
 	int count = 0;
 
 	for_each_available_child_of_node(np, child) {
-		if (of_property_read_bool(child, "#interconnect-cells") &&
+		if (of_property_present(child, "#interconnect-cells") &&
 		    likely(!of_match_node(ignore_list, child)))
 			count++;
 		count += of_count_icc_providers(child);
-- 
2.45.2


