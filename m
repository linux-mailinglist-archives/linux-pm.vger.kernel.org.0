Return-Path: <linux-pm+bounces-33648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE3B40598
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA711A81D8E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542B321F26;
	Tue,  2 Sep 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0LBUrv2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2C31E0FE;
	Tue,  2 Sep 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820743; cv=none; b=f4tyQg6pytBViGBTJJnzKDL10pax0Zi2tB/Wzs4apP6iNDbHzeLiwxR3w9Ocg98T/eTWQ/HkgD2n0sa2kPHvFH4hiwRmFcS2L9+YLFEaKfiA6aCZKnlzUA/p7ycagH7LCCkrWP54NWN4xIf9bFi0gscp9YwAH5tekensShMlCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820743; c=relaxed/simple;
	bh=xRPxCF6Wj8myZEoEb2RgB/w1CXFs7mHFM6BRbkQhhYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XK69mHon2PSAiQcZLy7viOmYkfqStrk6gEDwm4uX4V+pikZta2lfz+r8Jmc/Eb7XRKfQpnX8XRR48gA041BxeXNznobxCugjJajHWjuY6LfCEglThVGS9p3JwrUfllLAuezgpipQUSAim4BV/Aq/6BfA78iYw9m1wG41kaXbyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0LBUrv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E8C4CEF4;
	Tue,  2 Sep 2025 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820743;
	bh=xRPxCF6Wj8myZEoEb2RgB/w1CXFs7mHFM6BRbkQhhYA=;
	h=From:To:Cc:Subject:Date:From;
	b=W0LBUrv2VIlmuNlmE97OjNs32vUnlPSi7Q+qXjv4oL6I68zimEymCPjCG7uHFMQwm
	 7JwFL48+wH9uhd3YkGwekII19+jJstuAXeK1TondTbi0XWyCFEp6YKzJtva/anLYzJ
	 ILPtUPOi81U9bgSIebzLmC1MRxRe9BUYVGUtJJ80WyQaaIb1IRocS5AFse6CU864UH
	 RzCEPVHtnaqPDYlfbEpRINO5VGT8tLGy97p2IsR+h7N7HPMPK5VslpmMI7p4u8Z3PL
	 BN32QdmP1m3XjIOyc7ni8wrh1Gfydx1cBKjqHfs4xzBHfFO9H5ipr2S0Zx7Tnf1wzh
	 IxWtiP1OLsGQg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Saravana Kannan <saravanak@google.com>,
 Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v1 0/2] PM: core: Updates related to device link lists
Date: Tue, 02 Sep 2025 15:40:54 +0200
Message-ID: <6202205.lOV4Wx5bFT@rafael.j.wysocki>
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

The changes in this series clean up the usage of _rcu list walks for
walking lists of a device's links to suppliers and consumers.

The first patch changes the _rcu annotation of those list walks to
the _srcu one which is more appropriate because SRCU is used for
device link lists protection.

The second patch (which is not expected to make any functional difference)
adds two macros for walking lists of a device's links to suppliers and
consumers and updates power management code walking those lists to use
the new macros for more clarity and protection against possible coding
mistakes.

Thanks!




