Return-Path: <linux-pm+bounces-33900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B6B44BE6
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 04:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522B05A2AE8
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 02:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575B221DBD;
	Fri,  5 Sep 2025 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l+ry3tqc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4B7FBA1
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 02:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040724; cv=none; b=NStXezD7DfeXUdGudyg5XIlYeghYcJjiLv7mackBfEfGoVzg7OeyD0+3zCEOPaPqUjuIF4IxWrsxXa8KTLETpvwPyo1YRKS/YrEjovkRr2v6SUFwbliRcpP5OmLlSz1963ppgvOhNNmAfAJ/mvDzqMHpvMREmqe6TiCeaB2NpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040724; c=relaxed/simple;
	bh=jkkBaiu39aotMfqm6gNYSHgBEVc4PTPrUkiBE6mC2z4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RtgiIPTCz/QwHTAk5r+4B4giWXsyy9GvEufCdiieBMthiwukUwhYji5rj9OiNtvuAUkiVSwGvoAVd8gIGRGyZ+c0z+/JC6MZIZSjjmjphHTHrgw8Jqj7OtR9Eohq8QXdfeV7QhWqT1/HDCLIp1eeI6y4RHmfxHB4soc+Lu9lB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l+ry3tqc; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1757040718; x=1757299918;
	bh=jkkBaiu39aotMfqm6gNYSHgBEVc4PTPrUkiBE6mC2z4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=l+ry3tqcDEcIjqgGZUVJ1aOQyItabXZZRuAzQZ3sOEbg/6tKZ2EuCauCcg2w0B823
	 tUmaACWlYTam5iXwCxLoGGfLrzgmv8aOfGM6KFMffhfib056UAF9IllWz+pj4hLmjR
	 Ga1DdYvsRd4Ly+bky57rkim39sH0Jfd4cNd0fPQQH2GHQ6HPdQkhzo64G8nQD5RC7w
	 mXWAf2pAGmm9M1toncWE+4mRRMmvCxc4Q4D6+g2sgM6tx9xzfhyketqjxsceWfaGKt
	 zM8qXLP9KaWbT9EbnFHYFThFAXkxA52iCIrSBQo7NYhedJiKxJzZsuamTHVchujbiz
	 jF2NSS8oidhCw==
Date: Fri, 05 Sep 2025 02:51:55 +0000
To: Mario Limonciello <superm1@kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <v02CD0KPkF5AAcf8UtMCnQtlQ6-UL3YfDuqg-nLJuD1aDIvmY3DiKi3Bgg_6Ay2wY1dQpRPwYdo6qMQir0urvYQ3ch3xFhEmKexz5cmeDg8=@proton.me>
In-Reply-To: <5f958462-5fc1-4837-b5e1-65c0ad8badcd@kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me> <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org> <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me> <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org> <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me> <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org> <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me> <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org> <wkUEC8nqZzIcVXalYzsLi_YheAs0Tw07ug-73PAqUwKmquJr89CPnQKwBImSQLcDABIk4tfWPLCPKa00vG1jH8NpiH5f4yXVATYakltJAQI=@proton.me> <5f958462-5fc1-4837-b5e1-65c0ad8badcd@kernel.org>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: 64d22e2e03e0cc7d9476d4cab462974343b503d1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Can you double-confirm that with IRQ1 disabled that you still get GPIO0
> for keyboard wakeup specifically?

Sure!

https://paste.gentoo.zip/CSE5LMA6

