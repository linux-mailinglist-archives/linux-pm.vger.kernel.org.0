Return-Path: <linux-pm+bounces-30587-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A1B0030B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F31C4344B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0AB2E7182;
	Thu, 10 Jul 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeKNo4Pn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6959273818;
	Thu, 10 Jul 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153181; cv=none; b=XG0Vz7TIOam4Men5GiXbY52661a1Gyo3eiCUcL/h4L/hMK4c4AbS8ijZmeyysKea38rVqouN/+AR5hdnskz5j5HJ+v6U9N+6c2vDFaN2aGX8rnTtUtLPSQvhlC7+haN7uZBZ3IHhKhltDMb+JQLioIb/+jUqqZsOt0aspY/iR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153181; c=relaxed/simple;
	bh=G7DcbmMqL58QSRYvjU6ux4tXv5N0M2pspqDuxfXvmwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFTP4IYV+MurMDJgWErEhIBq/WdovIL9dqqj+GCs2Ljnlw0FXpJFtqiHWYRpzT+oA0bsaFzit4ktgzXJ+sfVMtTJgTCHon1xw5BgxcCMCbIkEGmGS2tkoyT1Kw0IsW51WRd4rwnKFpePySFf960/BBojbrajgJBLj8H8XuxbnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeKNo4Pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EABC4CEED;
	Thu, 10 Jul 2025 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153181;
	bh=G7DcbmMqL58QSRYvjU6ux4tXv5N0M2pspqDuxfXvmwI=;
	h=From:To:Cc:Subject:Date:From;
	b=SeKNo4PnRUeD1IItr4pG0/AKI2v46qPG5UEB0UWIikDIyYgIjSSn6wB0nrpxB7UVp
	 CLqTZahoWQ32TjMjoaTaPzL9mPvsUj053OB3u8GnYFcHqWlh6KavJRs2VlDGMg0EjD
	 fqvag2hAkjGHtUWceQHTuiSJJwX0syKisP3CFCy9oPr2+S+i67zheIwi6sk1AryxaV
	 g9flzqa+nsX4u+HT9Ljbf/rH3M1aMlYl0VbytabwmsOTsBjXeQryFbOacPqti2eX1d
	 ZclD4LEXw5H02FGEwezHxKZRIg7sIOVVccaLO4f1ntUIMDv9GKCL+I3DHgtDi8ohTK
	 3dK9Q0eVyPrFQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: kexec@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v1 0/2] kexec_core: Fix and cleanup for the KEXEC_JUMP flow
Date: Thu, 10 Jul 2025 15:08:58 +0200
Message-ID: <5046396.31r3eYUQgx@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,

These two patches fix an error code path issue in the KEXEC_JUMP flow (patch
[1/2]) and clean it up a bit afterward (patch [2/2]).

Please see patch changelogs for details.

Thanks!




