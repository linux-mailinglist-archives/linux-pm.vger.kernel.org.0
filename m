Return-Path: <linux-pm+bounces-23171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68041A49893
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1FE7A71A8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7725E46B;
	Fri, 28 Feb 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b="F27pfRlZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from outgoing59.jnb.host-h.net (outgoing59.jnb.host-h.net [156.38.154.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFF23E32A
	for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2025 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.38.154.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743598; cv=none; b=jDJTOfECLnH95gSZu0eMRNiC9HOuJ3ChGIZaBXei4OEhVRR9dichm7gKv0cDR2rj9OyItL+W1yzUeUYfms+ydeFein/NBRphDrUarDsz0Ql6ViWSXcpMXC14HsX+qYarkNM/SWZ0H+yQuS3QdJdsw196Mvi36iAMdyYBoMM99dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743598; c=relaxed/simple;
	bh=LnJAb5OtSiiPPpVmdSEicOxdfy335XXtHun9Lv2d8Bw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e9GS4lR31MjIgkV0Ao/cBT4piacLhzjMRrj3A9zGfyrapyZdx7hm5gUbyzLRGuOyBeEb9VrHEH39CebKQ9a5OHfpexdOnzifl3VeYzAUlQ8gbkLx3UmkX8R+31ieEMgu/w7yNbkcMVnhXCLU5qIJl+8v/L7JKrMsctqyITEH8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za; spf=fail smtp.mailfrom=coldcon.co.za; dkim=pass (2048-bit key) header.d=coldcon.co.za header.i=@coldcon.co.za header.b=F27pfRlZ; arc=none smtp.client-ip=156.38.154.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coldcon.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=coldcon.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=coldcon.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=t+qwmUT3iOAm1DfPM+nbVN5TXLHXkSwi3Xte37fm8Y0=; b=F2
	7pfRlZXZkhHhqcIeHFeH9X1NIVRTj1Ur5wPF5h6zNg21r5IDITHAup9X2Qw4x+wTBYqqJZXYoqr35
	Ix6vjgmVcnfnGdgdUCmJ/aq55khE64/bWhkwOlOF1drT6VPjUhwiGWIK0nAC0u+I7Sa71vf9JZxf6
	pMyK3nPy1sX70s0uX5KJpiyOW0cV6X/P+U1OsB+qK830xIziLtnNhJB3Q31o2d4r5qYKKmUGEGhXx
	EFpjf/WnaAWfFy/2KaaDWRZe2nEiJ28WDzk3JmQJP4bgQpYOeAN+104wn/OGeHl1xoKVzFXl3ccRn
	lGWMA1HWlaSRWHmM1cfYHR98FaWZ3kMA==;
Received: from dedi166.jnb2.host-h.net ([41.203.16.166])
	by antispam8-jnb1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnyvY-009Dgc-CY
	for linux-pm@vger.kernel.org; Fri, 28 Feb 2025 13:53:14 +0200
Received: from [104.192.5.240] (helo=coldcon.co.za)
	by dedi166.jnb2.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <avaril@coldcon.co.za>)
	id 1tnyvV-000000064WS-3314
	for linux-pm@vger.kernel.org;
	Fri, 28 Feb 2025 13:53:10 +0200
Reply-To: funding@investorstrustco.net
From: Iyke Nikolas <avaril@coldcon.co.za>
To: linux-pm@vger.kernel.org
Subject: Re: The Business Loan/financing.
Date: 28 Feb 2025 11:53:08 +0000
Message-ID: <20250228112431.7BADFA45012A6B15@coldcon.co.za>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: avaril@coldcon.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: coldcon.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@coldcon.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.88)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+CzanhUpQxxY0jGcn2Rs0cPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5w9+NB0706U/e5JSnH+B9KnW4h0KqOTIGbSh7sPxo0b07gN
 zB/4Jkrw1eDLcif59ftsSvV1/NQHUrcsn/Pk4jtugYVALhXkueKT79r7FRLqfRUEuoIDUKvgXwTY
 bAASksh+hJyAsgQN3+fJ25MXybLTEnn3R6339blD0gxjEMpUS7AKkWsSRB50P9i+7DDZoqbBl2zr
 hDc8rYm3k8VWZMvFfvQ0m3pmFgZmwTpeJG35MRTHswbbB/ha+ZWrSAi8SkwqWAikMcSxTAWn8RCv
 ieGEzRrIdLp/AwmQcey+hPKVq9dnf3S1NcNv3U2dp/UbPvviEnzvvDcGs5qmm9XDE2pd30eb89LE
 L2hMaNucijkaP8u7VqvFyzGqvqcVzolfUG+U/86+VeHQfEPfz3YUMMqBqSIGAS5g6SocktP6HR2V
 1Mnsv/4cfDtSkJz6hRSdrQzTHuxweXeDMpjWlleKrN32mP5wriU8jSHrtsnI5JD0GxR9Ovbqz/k9
 Jlx8RTZkJCspOMQJvQ/Ck3iiU+4DQAj366V+bW1tsfg2xPA2CLYwN3crIUQpaJi+vSc87VANffxa
 6/OByd93t7BSp9WyM5q4I2qmjKKBlq8TdxpQqSJLRvTJra/Rd6Vtd5fTmhM6nb8XlqtWoZXfDqNX
 VGm4yZ4d/OYnGZUQnca3k4Ez+h60/0M3P8ajsTOgcYvXp2lGYdjouGNWeyDDBMHTHZuluYeB3yVA
 kqJMXGMZ5q3RC4mcsQmogvtkuijgVgXwiIIzxgWjd2x4LjalswpRBG4b+FVJ2w6SeT5iO6UESHEe
 cJJTE9khVSx50aAGz/dpxdFKTmhtALl6tE9e8KCaN2ryngAyISXxK9AXhlIwWCh9wHMxqEy5oqSE
 MZ5ZQYqLIEpgXrLl6H5B8U/ulxTw1Gdtwyp22pb4i4DTkMZeMiNI9JSIyVqEjiLhM0soqLlZEw40
 8tzmFJqmfDsYdNRg0kZq4IUB
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

Do you require capital financing or low interest loans to advance=20
your business projects or growth strategy? We can provide with=20
the needed investments for your business. 

Get back to me if interested?

Best regards,


Iyke Nikolas
Managing Partner
Investors Trust

