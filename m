Return-Path: <linux-pm+bounces-33246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE104B39AC9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01361C23C95
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F930E0EE;
	Thu, 28 Aug 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsOPu0Xh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35930E0E9;
	Thu, 28 Aug 2025 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378794; cv=none; b=XIgfMcuXEsnFTzCI8W0ycicOuJzbFby1wLK/tzy2U7gDpXhvrBYgG9ZLBlUFBt14G/2Q2Chg5P3w6LEwEKKphqsmiSFg5UzsqA2RnJb9ffTIRPzhQ9O4bgh8svuGyPzl9cKiGLj44HWDWb5GX/c5Zh7mRp+CkElmURRBgXEyKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378794; c=relaxed/simple;
	bh=1gRhjJ+0oQRVXQFxuIsMueRQ6SrdNXINX/A2dvCOHK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBNiIVUwPhtxaEKS1oobcZzDlz2B9IOxaPM8tM8RD4Z5bgfcpWPZ+Wje2rPwqvODvjo0bboAKpaRAswcGqdRsQwnVggk75qgTVVowy77OTXHtDlBfYtERXBSgv12X7AmrAghx4KFpneaM2NgusjcSDoXlv9Te57N6pmvqhzFg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsOPu0Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DADC4CEF4;
	Thu, 28 Aug 2025 10:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378794;
	bh=1gRhjJ+0oQRVXQFxuIsMueRQ6SrdNXINX/A2dvCOHK8=;
	h=From:To:Cc:Subject:Date:From;
	b=WsOPu0Xhe4HHilIQNM3HthliI3BKpJ7af5iyV1z3swU1BiHJ0Yd88Prw3yRJrR/GS
	 PlRG+12+4zD5cCdwCLFCv3Cy4Io01cSVZYNTXSBZVF7Z0uO0pgFiYW7k0URw2FYTXo
	 QrriDRRUpmsK545sN+3izxGAVWwbTJCidsYXbj4tBBf/IoZcTN0y2SAwkvdi99uI76
	 AyIT4T1KFYskyE+A3c7P0LyDGaQEAivOX+WIygfgjSYagcE72sHMuiSbOdM/mxkRHU
	 wwK77Kf2/7mBU+5NQOTaZCI7LE9VxqN+1xz+kqkO3v68z1Te2C9eSqPX7tv8jt87G8
	 8vV+eX4KIdSAw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
Date: Thu, 28 Aug 2025 12:55:50 +0200
Message-ID: <12749467.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

Applying this series will cause power.no_pm to be set for faux devices (so they
don't get processed unnecessarily during system-wide suspend/resume transitions)
and power.no_callbacks to be set along with power.no_pm (for consistency).

Thanks!




