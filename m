Return-Path: <linux-pm+bounces-13369-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D59690A6
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 02:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D49282D1D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD710E4;
	Tue,  3 Sep 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VqieKP1Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB8A32
	for <linux-pm@vger.kernel.org>; Tue,  3 Sep 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323356; cv=none; b=fRGj1kh9rLj9MVHQQKnPZZlmmZoF4y6bhCRwXY/0xMLHFj6GdNvQpTbRTfe1Vi3hfQC+zmnFHXXleWmwfNugjwGLfgyHPx7uq/jDpaKcz7pJBHCKkw8ZDEmWn2C7cPgj/MxgdiDNU6KClPONj3aJG3nNt04jID39MPrek5ThwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323356; c=relaxed/simple;
	bh=MkaWKqdqmyoffz6eJqLAGFw46VoYHSslphTHOF+YqBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePwLcU2wRcPLMP8Lu02p1qUBwmjtKSI9pXI0djJy+TVaPZpxT8ujypRammmYK5GVlJckQ0r+tvbROf0J63icuPAWKN1Epx0/Yj+Zn6WGZMCrAxPpphX9uAuVVj4LI78p79WavuaFWcDUBB6mSCEJ/X/Cx/psK8Sv8nAz/zLW8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VqieKP1Z; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725323345; x=1725582545;
	bh=O7tE1+2e0p0q7x130dJCWIRxXiEg9o9S81ENj//mYiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VqieKP1ZwrLNW2I1je3Q9RumfW5vXqzRoJI7mTtxD+Arq8tXWgZHg+yDDTdIb56sR
	 VEH2jmdMnpRDWz43FbTdRdWhztkG2KNGljtftSYbL5hrAIpFutjZLhqyLtckgbytch
	 Dt6ltfb3ai0PzbH8tEW292WpxSnHCZA/XjvHpuRE48rUK/Q2qNPETyzd49HY610IRS
	 rPDPvsg2n6MtQLaIzcnn20aGScvKQzAL6hzU/M3RuwfeHXJsFXZce7ZnU1HYPfVBRN
	 tY1A4YFNXYLHZnen7UicAFiO42szhJl7Sqq8HYBeEl2qKLRbIGbgbAfniHwfFJyq02
	 ej+zhhSHefaZg==
Date: Tue, 03 Sep 2024 00:29:01 +0000
To: John <therealgraysky@proton.me>
From: John <therealgraysky@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: amd-pstate-epp: CPU freq never hits minimum level booted into OpenWrt but does under Arch
Message-ID: <AOCLyhhxv04URR3y8S7MG84lw3266oGs7JuqDT_vVjRzjzMcxAOcAt3Jh16fVWHFDmTpixyM6IWq5i5c8ykz5zo4kMJUiVEfr4YhWGstFpA=@proton.me>
In-Reply-To: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
References: <rc3yUl_FpebZCJhCPscpyJ2UtuKGSwB7B4E4mr4OjdrJFIkftiWJvWrRBwXzMfqICV_NZWqMvyey5Iw3XqyhIhQ3k9beU2p_V8NARfUdQ-M=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: 937322c3a403890e6a17dbfdeda4e0d3ebb515b0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Replying to my own post with what I believe to be the solution: the current=
 OpenWrt kernel is not using a tickless timer.  When I modified the config =
as shown in the PR referenced below, the CPU now reaches idle state with al=
l cores @ 400 MHz.

