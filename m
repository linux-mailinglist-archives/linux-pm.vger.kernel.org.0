Return-Path: <linux-pm+bounces-35428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A650FBA242E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FF41C2805A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94F263F32;
	Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKre2adY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB852262FD2
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855267; cv=none; b=Aw0fVsSsNv2arqSB9tZ5Ht0x4peyW0nqYNGLpYOXSQvpI5ypDpMXSvR/bRpjexNP9jY9bbOmOZYWC/qrJol6LYuDrw1xFSsBk0cAVFx8NDe7LbqF4A4FUnpL2gyrB/eJB52R76TXVzBVuA59R5oSKktMUa7jlnF9kP9KGqmNSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855267; c=relaxed/simple;
	bh=yN7a93aI2j95F+uItSl7wq0h9Mva6+dghIxid1nrhTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Re9Q2CypEIbA6gyw5Sj0Zrbm0ESKz036v6x3SixGeATlHwTmij7BHjNmfO9keNyQGfqVg48fDSBSAqDibi2ghERrS2GEA7QzRqm6BXpF6HknzE//kNAMs0+d6VUAQcBaHNeL/AfGsjnpaVHM3Pze/N5gR9HUOqKnmnUXQZ9jE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKre2adY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE646C4CEF0
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758855266;
	bh=yN7a93aI2j95F+uItSl7wq0h9Mva6+dghIxid1nrhTY=;
	h=From:To:Subject:Date:From;
	b=fKre2adYWof45WjY811O2gDsd3XWt/ChznAG1UFDT8MUVbYqnNjid+L1Rwzxvcdko
	 B/X/x4NRUiNNDn+Lmt1R2pvlb5gVSM7561oEQ890Gh7ZCXeGxOq3QvtSdkJpVlGxdc
	 JHpqPT4baBcWbSbLkpcIXGomKU6d6zEsQXeslaeLKKH4Qs69cRudX0xVzhIbYtTADt
	 BVaVNzXwUScfB3GPsnQbtOYQrfXQaPZot/fmaabPd624oA57SoFb8c7hLUhO4RRli3
	 vOdkBKBafOqcgXVXB3cSqjhmSjwy10X4VbSxwPcj6Ybl+h4BXblk8OL5XrkBmwPbbi
	 EJg7c4zn++7oA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/7] tools/power x86_energy_perf_policy update
Date: Thu, 25 Sep 2025 22:51:02 -0400
Message-ID: <20250926025422.73800-1-lenb@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a latent bug in the x86_energy_perf_policy utility
that caused confusing results on an upcoming platform.

Please let me know if you have any troubles with it.

thanks,
-Len


