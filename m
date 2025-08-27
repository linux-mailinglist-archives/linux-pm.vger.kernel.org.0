Return-Path: <linux-pm+bounces-33206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF96B38EB3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 00:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DDD366A35
	for <lists+linux-pm@lfdr.de>; Wed, 27 Aug 2025 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDB32E1C63;
	Wed, 27 Aug 2025 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b="ds4JIs3D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-107164.simplelogin.co (mail-107164.simplelogin.co [79.135.107.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FED30CD9C
	for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=79.135.107.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334965; cv=pass; b=fx+I63iEfm5s8i4iDjLcVBMBXp6+R8pfCNBXZ7etLVhQFpdG3c2DfyHmOz5bFSzVP90JPgg+JdfYJbXhDvmR4+axXZyRPRDihGj8/DkjAmkVwD+GmbmlxIuoq3y+AopSjulDZlq0/u0YpuxjfeJrQaUMw8oV7Gj3XIBBTtkvbtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334965; c=relaxed/simple;
	bh=WDelYLj/Ys+ODM2NUbxJyf4W98RhRVPFdhWip4Orgwc=;
	h=Subject:Date:In-Reply-To:MIME-Version:From:To:Cc:Message-ID:
	 References; b=Zt+kap8nvVwQF2kRtyiNOmMaNBDOAdZkTIaTI+4byezj31ZE6m5Qtv/oRzzdlYa/ZN4orVe3Z2g1NvWouAscujjqvHpZ+cKf6VAF4t2ksGYtU8oDW9vEdDuIXRY+LQBIM1WUsoWphljxmonPSp8yTMkKX65K59o0vABXrqB3JnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang; spf=pass smtp.mailfrom=willian.wang; dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b=ds4JIs3D; arc=pass smtp.client-ip=79.135.107.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willian.wang
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1756334043;
	cv=none; b=NNGQjDJXNcyXg/L9p0bxou9IatDDehPoCaFbFe8eZroFOY5urVYglwcu1ToUC7MUTICPd8mrjZVamYYjmKG5mCyQrNRRwOD3EVZbBhu4vHh4/BfmGoRzuU3Xaq4xpsYi36owGfRY2dy7HqxGvrCbXSiJcZcm33Yi8F9oqT5UgxOIHJmCz3Qus/icnT2AQ2RKAh+N7TMMfPgyPjSJTwzlGpBd3CXkw5NaA7oV/t67pZrhjt/xQKhjoUSSJpwkeLLh0DU/EqpWa0lz2VLLOG/n1TVoxJyltN13vuaFDwfKlt9oq3bublSwDcckGenFLNCCdUOHfvM+DePlKq07tVR7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1756334043; c=relaxed/simple;
	bh=WDelYLj/Ys+ODM2NUbxJyf4W98RhRVPFdhWip4Orgwc=;
	h=Subject:Date:In-Reply-To:From:To:Cc:References; b=W+z5yeu0/DNOuT1uemvn4cK7WRBGcV6EHHsBFhpUgIA9h1AVnZaWlrLmkftXAV6J+eF1dEYxZn3y58+8G6q77JFJUozAKqT8+a6LVbtOQAi+JF51HdVY+iU/OZHkuY99o/gCcy+Plvfc2nZXCY8IHGAkwE+MHZzzxHpgFQILRB51RNdnGQkira1TB2+ow1KuuY+JwwGdivUVAW9KsTonPKdWj81QEkQv3HqBMNZuh7WflqrHogzb63z3NvBiBtcaql5Jg1fHzLlndTFnTbOT31vrXzAfKAFgvq1uYdUFKOYyu4Va0hjEc/zY09cORZTa5LNEPHXjwsHy9mAnEV6U4g==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willian.wang;
	s=dkim; t=1756334043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDelYLj/Ys+ODM2NUbxJyf4W98RhRVPFdhWip4Orgwc=;
	b=ds4JIs3DBfS/4viiQdIyH1kSyuOxuVgdnsTJ5jXvda5U2+6jwsw5+ZAi2/opT8YUF04Pow
	KXe7ElIQbEfhDXjH1yCY2G1r4NBWdWz1fJTIfxLA7NPRBOg25cnIvLpHAWubU3aS4QjdJj
	oPfc3KyU97xIyVVxDTFWo2ULlmC9sEM=
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix a regression leading to EPP 0
 after resume
Date: Wed, 27 Aug 2025 19:33:50 -0300
In-Reply-To: <20250826052747.2240670-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Willian Wang <kernel@willian.wang>
To: superm1@kernel.org
Cc: 
 gautham.shenoy@amd.com,linux-kernel@vger.kernel.org,linux-pm@vger.kernel.org,perry.yuan@amd.com
Message-ID: <175633404301.7.5098740618527090955.875057979@willian.wang>
References: <20250826052747.2240670-1-superm1@kernel.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 875057980
X-SimpleLogin-Want-Signing: yes

Hi, I can confim that this patch works as intended. I only checked the value of "energy performance preference" field on `cpupower frequency-info` before and after suspend/resume cycle. If there are any other tests you want me to do, please let me know.

I'm using Fedora KDE 42, AMD 7840U, Tuned-2.25.1.


