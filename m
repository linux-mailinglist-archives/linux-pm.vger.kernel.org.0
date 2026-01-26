Return-Path: <linux-pm+bounces-41493-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIWqG8zFd2nckgEAu9opvQ
	(envelope-from <linux-pm+bounces-41493-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:51:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E38CC64
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 420473007492
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A306E2882A1;
	Mon, 26 Jan 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQPVtOck"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6027F010;
	Mon, 26 Jan 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457097; cv=none; b=APE440oQB6D14aQ2FqtVrzDgVLeN3ELWIt3zlXnJfAuIg9PnKETiCPBHw3lezTrD4ZxvyEJUd3CrtaBgH/LdrctTiObulsqDuHE7d36KgUAK1hGYrn+BJj1muFtzVPbSkbJ+u0NnF8p157hrI5UAtMefgKTQ+lhtng4SKuNvUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457097; c=relaxed/simple;
	bh=Ol8aDY3Q49xnXUpvEH4jYDb4zehR7zBug6joZMftA1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FjJKDL2Es+vGSQbD5UFyUSX8KXBWkbeomSvBLiYUIUh4MHrEWIzCCI2gCkEmw6q+S7it5vDBaUeHGoQu1sh4U5k+VUBHckGchEfGRsevJIQjRG+yySvMNbcucF/fDFR6sJ5iMszSL/kwKx+pLm90JKPGd/xXNi5AhU2K4RLoku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQPVtOck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F59C116C6;
	Mon, 26 Jan 2026 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457097;
	bh=Ol8aDY3Q49xnXUpvEH4jYDb4zehR7zBug6joZMftA1U=;
	h=From:To:Cc:Subject:Date:From;
	b=tQPVtOckVBcwLkjFD2vX7Jw+x6rT1+luLK6HcN2dJWkQ5tnEvKYJTPeu15nAXX1uc
	 Rxx8TLqNKi8slIUbXJc44DO5pz01GDOfoMZXkKh9jeRf4a75WqDBRem1N5EgOg7NJf
	 CG7oc/9j5KijqM2QulKnQz+RMgBod8zPElU0LbqyMz3erdJQc9ishPH8EhfGUGPmV2
	 ya3i9ir/PGw709e5P4ED2d74BMF2WP5786FdOW7fYrB2bNfHm8fqOHNJnbGXzjKD7B
	 9W0DBKYVLF+TAmBv9aEpIdpP9ckJpvmg/zE+Smd7s3PEGDX4vMC94oqKswJ7ZEsDKS
	 FuyN6IgmTM/kw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v2 0/2] cpuidle: governors: teo: Wakeup events classification change
 and refinement
Date: Mon, 26 Jan 2026 20:41:25 +0100
Message-ID: <12831359.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41493-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 126E38CC64
X-Rspamd-Action: no action

Hi All,

This is a follow-up to

https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/

including new versions of patches [4-5/5] in that series.  The other patches
from it have been already queued up for 6.20.

Patch [1/2] changes the criteria used for classifying wakeup events as hits
or intercepts to (hopefully) make the classification work better for large
state bins.

Patch [2/2] refines the idle state lookup based on intercepts to first
consider the state with the maximum intercepts metric, so that state is
always taken into consideration.

Please see the individual patch changelogs for details.

Thanks!




