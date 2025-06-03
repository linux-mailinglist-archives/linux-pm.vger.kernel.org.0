Return-Path: <linux-pm+bounces-28032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45191ACCB2E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F0C16CFAF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C87C24168D;
	Tue,  3 Jun 2025 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hYNGNbqz"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7423F41F;
	Tue,  3 Jun 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967747; cv=none; b=Xl0+pxkErgKRHvJJ7UQKwfuVRRpKFLJvDx6n90WX2zx3LEFSW+pvSUXdZ1KRO+b7pD95I/9w4HGwQQvQR0QUGdItonrFIrXr65xcm8qOd260ig8g7ZvFZlrhf8orgk8TQnRexfoHaT92+8YDBc0H63K9y5lehW/jRSRv2hqE1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967747; c=relaxed/simple;
	bh=NUifpzHDnHNDPNl6Q5xZ0+qSJf33uWp+49wVHTW6OfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tpn8HQ2MTpLkiVOzCJAohAPIavU+xqv7z8yxAyADLpPgFUaM2JXi6mIEmAiYbxLYFJKDe0iqW9/p46f/Z2o3Y7C/MO9V3iIJ8PkO3Ow6jmXdQSuBLa1fxbxWTLLm7Sz2g5ot1ePs8w1S3noNt0/6iUZJYR1CMLbhnSV6ae8xi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hYNGNbqz; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 76F6766BE05;
	Tue,  3 Jun 2025 18:22:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1748967737;
	bh=NUifpzHDnHNDPNl6Q5xZ0+qSJf33uWp+49wVHTW6OfI=;
	h=From:Subject:Date;
	b=hYNGNbqzHCPIPt+tKqvN3NNKgi16BNFkdR5DSPbibFIgpWWTcz1oTWTw7U2R1ZulB
	 ij04DFCV+QS+jn+mCOy9Cx5YCAIwYXuiBWAAvQ0rlS2CovR67UB/3xSgW8ZDqSCYc0
	 isGM9L7xsptB0ZUsNz+E+lnxPFiNyaCsKck6f3dpSKWAE16JJK8kf6XS5NTGPT8p4Q
	 Gzbgv8oMeYffgqnF7ATTXtMZzqJYXDNONudr8IAXkgCn+fk2PrtCzKIyfch4nWpm9D
	 zZiwNwMAleSidcuDDPDSr6TkYvBm4xf4rg1xY4/+Xk0j9yRDOIDlZEj9EOLnr1LGso
	 bRBL6PERRkG4A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v1 0/3] PM: sleep: Fixes related to aborted suspend handling
Date: Tue, 03 Jun 2025 18:16:18 +0200
Message-ID: <6166108.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEjkZYBjFYBp2cBJuVnU/BKOuLwg9+gEpedEOqZJbV3rOrfcF1V6bVJuOosJ1C9zw+HDh7uqdl4gu7IqwK6zj2VVFz20cfG5s2LTeySOY4CG/+lY24EOYHtgk5wO2JqhrChKHOC5au+c5n2UjgUAa5KjMrUTwTVJk4a4R9uJMa2h5r1lnK29KrEonCg9ER4FuvtN1lKuLcEMJREhQ4vsF2e4MwNLjzTGq3eVmEYvENM64d3wL26+awiykHqARX5DSAuDTBgoOq1LtJ3DaFdO1xEzUx9ut+OHCt0bTcuUkR5Zj/u+mxzBeBrsL/qgnIKFtmBuj+JRRVr6G4WJAZqX70nBl4XqhKALJRC2/M1tFTDrBj4jqy88LclwIH6i7zMkWKRX8Rt11W/zX0T+YVs2fi0xokbCZ3bHDMQIJD19T3og6m2OrZcRo4vCDkJoMLMMbepHK7ng8Rw/GC+Zc++hSK4zqLt6Z0M62HmOWBKsXatZjxL0OImnIrShLXN+VLmaAQna7jkcPpbGmz/HZKuWdZScRhX4dkitnVMiT1G79cegQSjG5lE4kjZ+zFdsLSIK9zDh61txLnnyLm07KK/oRKHY/TQfvtpEHs5sQXTyjSN3q47bs0Tt21dRJb3q3PCTUxXLd6hqY7J3vYEWHqSJbwGPFhNYK1JNe4ER0RTYBFONA
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

Recently merged updates of the PM core have introduced three issues that
manifest themselves when system suspend is aborted and the patches in this
series fix them.

Please refer to the patch changelogs for details.

Many thanks to Chris Bainbridge for reporting the issues and testing the
fixes.

Thanks!




