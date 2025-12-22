Return-Path: <linux-pm+bounces-39812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F2ECD71FB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 21:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 409A13062203
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E26347FEB;
	Mon, 22 Dec 2025 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7iwFAdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACA347FD7;
	Mon, 22 Dec 2025 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435902; cv=none; b=Lcw3KWdD7iLE4f99MoCjRUD/fxud7KPKynPU8huZAErs0C/DU2Kdq0GKsqUl7C/dErOK9FcNt4XqzhRS3Ug+ZALZz/756OhY2qOEq6TbzY3SnONDFHs5ColI/E18eysDlST4pKNMZvrdoOXg8aKNzM0NSriBHZ7ZPb8Y/DEsYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435902; c=relaxed/simple;
	bh=hle1nh7EfOgo8m6SkyoD8zOL0noHHIKRjWmUvjYtRIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Egjz3SxuiaV93X9ZJQgEt8RsMhsljsvSLPzX6g7DDix+beTbJEAiRkMMD352dhuAp574pswHd2+n7MxNFTUahmIAfP6727r0lRvSIKMQORrl7HHoSkjLHSAkdYBVX/TyZDGx0mHqg7NcQ6Sz1+u4TL4k/DEmZ1gLgt2ZS9NLoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7iwFAdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB4C4CEF1;
	Mon, 22 Dec 2025 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766435902;
	bh=hle1nh7EfOgo8m6SkyoD8zOL0noHHIKRjWmUvjYtRIo=;
	h=From:To:Cc:Subject:Date:From;
	b=N7iwFAdAHL52uSVrF3pICnG9NJFsum9ORhlhrYs/LE4dFPGlin2idwdkiq/Z2iPL5
	 CRrWIhvNRi/i5ltZfDfEzwU0tbhcbc/FJZDUhIDbjUZwAPqaAtxmzUOimGVVDfjfah
	 GtIzJgG+dvPBnRKGl2e8dZ0FEhazmQ2nsbYDbIeV2oetA+tt1oluTaS7ri8ZGdFqCj
	 Yel8GXZUkgtViki15FbxlKWpBwO85EopWzp4Xu3QRSOP+kkSAnfAjWz8n132JhkfPn
	 ijD5pcSdChbyAsclB5zyT1wyXHofiUHtmAPQ9pjbM1x2fqECH5em+9uBDjYtVvioPx
	 Wy7IGcjuFtVeg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Brian Norris <briannorris@chromium.org>
Subject:
 [PATCH v1 00/23] PM: runtime: Convert pm_runtime_put() to a void function
Date: Mon, 22 Dec 2025 20:48:11 +0100
Message-ID: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
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

This is something I have had on my todo list for some time, but it is
kind of tricky because the return value of pm_runtime_put() is used in
some places all over the tree.

Nevertheless, I think that it is worth doing because the majority of
users of the pm_runtime_put() return value are at least somewhat
questionable (in fact, IMV the only legitimate use of it is in the
USB core where it is included in a debug message).

This series goes through all of the users of the pm_runtime_put()
return value an makes them discard it.  Patches [1-22/23] are
independent of each other and they can be processed separately,
but the last patch (obviously) depends on all of them.  Each of
them will be sent to the respective maintainers and it doesn't
matter too much how they are handled, so long as they end up in
the mainline eventually.

Thanks!




