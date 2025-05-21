Return-Path: <linux-pm+bounces-27443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACFABEB1F
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 07:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF18A4A62FD
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 05:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A722CBD8;
	Wed, 21 May 2025 05:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=urja.dev header.i=@urja.dev header.b="4Xq574aW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139242AA1
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804071; cv=none; b=ESMJggQ2tk1nth4/qEVFSSSO0rrkrEcC1qvuSv7IxHvS2BWZurItXA/jJotRze+i7IeG0onQ5+TRRiBMBQCw46F3vKjZ6etm3Yhxrkr0I1bHMVkFfCLasGZatXZI3DIkwEnqgywAk0mmWQY8JFrr+Js8Y+3EW+byobXDtabMiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804071; c=relaxed/simple;
	bh=EHxwybSUUWqWZkmGzW4LoBuZlYYgTXkmblF+vx8sHE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlSG77R+lV8QbQKHO9mw9Boxwh+KU0u6ODSaSwfkTo9lkrKLLGwA9qo9Mvo1LEyhWvVFjgJNmaG2mLaW8tmkOdIKWr4+5OQxAng3qpzldP+mKDHnEDtCox1W3D4EjURdtDQ+U9+uEdh/hhlEe2w2fdCOOhJEgzX/qBuo53o95C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urja.dev; spf=pass smtp.mailfrom=urja.dev; dkim=pass (2048-bit key) header.d=urja.dev header.i=@urja.dev header.b=4Xq574aW; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urja.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=urja.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urja.dev;
	s=protonmail; t=1747804060; x=1748063260;
	bh=EHxwybSUUWqWZkmGzW4LoBuZlYYgTXkmblF+vx8sHE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=4Xq574aWdnHwt9sC49d6+zrJn3m8rufK3gzf9q1131XQH5eXxpkqsKvgM9Uu4wNs/
	 WIzEzrxSof5Kf7YhpMDOhnNoaXIOCJxwNsdy2D5a2CatXvqNlvOH7J2LrCYbskTcV2
	 8ptXlT2fCAYGStfvTuBwvo1ypENOD+ArtktUUWDIUVjrAycSZcT09T20tYfxodNKr7
	 maaqT6CCOkQbgWzJyzMWlqBBDOfH6Phvo0SWuRY0XYQc52aLY6tGNAaE3njFmTtBz+
	 nNVGoITaINvADL7SdwzveJqRmoUIzPsvLaEjjpW4zJufXpUtPkAAZ6CyhwxTG4QbpM
	 PKT/A8hPeK5oQ==
Date: Wed, 21 May 2025 05:07:33 +0000
To: Robin Murphy <robin.murphy@arm.com>
From: Urja <urja@urja.dev>
Cc: ulf.hansson@linaro.org, heiko@sntech.de, mark.rutland@arm.com, lpieralisi@kernel.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pmdomain: rockchip: Relax SMCCC dependency
Message-ID: <shEYjcWUZ7485Ciik1zpXjOB8tWrdsemjjp3iOtj_OY54peVvLcRI6-AVZARFoQxjUb0QcwFfYcHGiCrPSX-589ZistaFvVfVEG1M73a3is=@urja.dev>
In-Reply-To: <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
References: <ab0476382e3342161beda94a45ddadb49b026dcd.1747760015.git.robin.murphy@arm.com> <6f0a38e596c0727d0de13a29c9224f71bc7d30f1.1747760015.git.robin.murphy@arm.com>
Feedback-ID: 82529409:user:proton
X-Pm-Message-ID: 23b511119bb5f75ff22627dfce245ca18591df6c
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Applied these, disabled PSCI, built it, ran it, the system works, so:

This patchset is
Tested-by: Urja Rannikko <urja@urja.dev>

