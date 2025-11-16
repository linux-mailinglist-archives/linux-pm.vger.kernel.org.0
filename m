Return-Path: <linux-pm+bounces-38094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1752C614CA
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A14EB547
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74542D9487;
	Sun, 16 Nov 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP1tqsce"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06CB2C2353;
	Sun, 16 Nov 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763296562; cv=none; b=sPs5pH0coa/n2fGsXGERIQL4fBaDwZIgW2Zxif+ZnoTzpTkR0AWwP+Zow8d+rH+9PzsTdMQ2DmGqnRsqXioh7SDAMPaNX6c/Pf+9ey6PZW3sUnO78NajFdxPipqW3iCZEUSiAMdC5gQSPLCksuSXPdIe8REN1f0aEbv7wUSy42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763296562; c=relaxed/simple;
	bh=qsMwye271cxAIlQGdYcWfd5RcSatajD+0ClysEuq8NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7jME4YDuhI8Cs3cvVoYMGH8TOReAutJcD1hNn+QdWIi+PnNMO2rfImHC79FzL9tvPu4tozjyuhRGPIJJIWQUAX7VZB0ux8JSES9EQKhjSYZ6dfA3G4Oo1eZESV8JLAtXXgsqJtorrKZJ1sW6yCAssQHSiRQHqKlCj13om0uijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP1tqsce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48264C113D0;
	Sun, 16 Nov 2025 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763296562;
	bh=qsMwye271cxAIlQGdYcWfd5RcSatajD+0ClysEuq8NA=;
	h=From:To:Cc:Subject:Date:From;
	b=gP1tqsce2PpNi+CaxFpl2jd2GIPuUFitGQMo+wVxeLEX05YOriI1X3rXD68kUMeCP
	 0Rm2GVlD6VXcAOjotNbVKkp1sPICvsUwRuFARB/owjQItG+jGBi3rIsePW4GuATBkk
	 iU+NDktqc+jiPC0l4nU+JSKUHnd8uRVIupyn2DRrkdoyV6aEuj0en1q9M0g6VLxdHJ
	 pK6Cl05GqhgbcUeTJkDdOwF45+LnivrDy3fqm43IKGpD7wby3/PJNnFFzyR6kLLmv2
	 5XBy6LTNMCRuUxcZLn3E2V3M7OPebr5V3lR15ytRExImAx99UD/XF3xHs8IVoDchYi
	 zTEiIYHJru5PA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] cpuidle: governors: teo: Fix and simplification
Date: Sun, 16 Nov 2025 13:31:24 +0100
Message-ID: <12810244.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi,

This series is based on

https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/

and the previous teo updates sent recently.

It fixes a reverse condition in teo_update() (first patch) and quite
dramatically simplifies the "intercepts" logic in teo_select() (second
patch).

Thanks!




