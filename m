Return-Path: <linux-pm+bounces-6878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99268ADCFD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 06:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968672830D7
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254CC1CAB3;
	Tue, 23 Apr 2024 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sendemailfast77.com header.i=@sendemailfast77.com header.b="cw4wgpDa"
X-Original-To: linux-pm@vger.kernel.org
Received: from sendemailfast77.com (sendemailfast77.com [144.217.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B71C2AD
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.241.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848204; cv=none; b=HA2RPmtr1njABQWrZrEkP4RWCcYwk+rcqfU6Zd+zow/P5UH86QIfqZPBqVk+9a9rFnmZj3NLKsVXjyuvpydVvNUfhl7dutuBMtLF6eXMbvLhfLJcbnqopMwR8FEv/toy752CH04dxhsLSzC/29bhg2EvQE4do7zv7PalXiGUMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848204; c=relaxed/simple;
	bh=zDEe5rGq4RUs51Fes9UeTv4jjGsR2LHXqDLxJvD7x1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixlKlv7S7l1m91GBuCyjJWG8ulyvbrOF/adLhVcB8VJBrwEVHlFW8Gmdei2Dv4sM4DZUyNQzha1rG359+D066DtdhUgSd7FlkU35gvfBUqTAeqJZq8yD90A0uABKwM9fgbf5MCLjmAekt8++6ebgZMxaiilNVXDbpZlLMUdlNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sendemailfast77.com; spf=pass smtp.mailfrom=sendemailfast77.com; dkim=pass (2048-bit key) header.d=sendemailfast77.com header.i=@sendemailfast77.com header.b=cw4wgpDa; arc=none smtp.client-ip=144.217.241.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sendemailfast77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendemailfast77.com
Received: from sendemailfast77.com (unknown [103.96.83.38])
	by sendemailfast77.com (Postfix) with ESMTPSA id 435601B6093
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:57:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sendemailfast77.com 435601B6093
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendemailfast77.com;
	s=default; t=1713787069;
	bh=zDEe5rGq4RUs51Fes9UeTv4jjGsR2LHXqDLxJvD7x1Q=;
	h=Reply-To:From:To:Subject:Date:From;
	b=cw4wgpDaS9Ax8Lfj5rgo4BtAFlVT97FjNzQj0Gqjwc2LBHmwMo5AHsV0gtCGq4qxv
	 0B6cmnGKJBxKc3LDVD1az5yEVB6JoC1sbKds/+3JGp7pZwJSzaWmCOfkKz2qY86CU0
	 DTajd27PHefK5EMWihDdLi8hujal3HG1UylbRN+DQ1Q9sAAouXwuCINGSvWkGnYr26
	 zpP0+boYpaqZNtf9SzP5lwBdGLKbmfY/s00vvybvRvbIm+QLGMWhI10Z18EXo+gTE/
	 Y8aI+YrsR5Gk23HLl+hLHPFUERsfMBFLmyuzceCr4jt6vNxcZHp6Fx9NgvsIDqpJke
	 Dxqa9Qwoijzpg==
Reply-To: stern.arnlund@gogreenwalter-se.com
From: sale@sendemailfast77.com
To: linux-pm@vger.kernel.org
Subject: New inquiry from sweden
Date: 22 Apr 2024 21:57:47 +1000
Message-ID: <20240422215746.539774695DF452D0@sendemailfast77.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is stern Arrnlund Head of Department, purchase. We would=20
like to know if you export to Sweden, as we need some of your=20
products for our client, kindly gives us a reply so we can send=20
you the full specifications and details of what we would like to=20
purchase.


We would appreciate your prompt attention to this request, as we=20
should begin a cooperation as soon as possible.


thanks & best regards.


Sten Arnlund

Purchase Manager


stern.arnlund@gogreenwalter-se.com


a: Veddige by 2, Holmerskulle, 432 68 Sweden.

