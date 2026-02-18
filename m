Return-Path: <linux-pm+bounces-42839-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIKnITsZlmkSaAIAu9opvQ
	(envelope-from <linux-pm+bounces-42839-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:55:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBEC159411
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04ECB300748A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B79345CB0;
	Wed, 18 Feb 2026 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2WwUqgn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E908731280C
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444535; cv=none; b=LiShPD1hUChanHOMNzWwzVbDaxeozLw3HefOcGlLF41u4goiDz64RjDT7HKdGjhUyNh6qYcfEprZ6xkbAG1KQV1G+nSFcpJXCADbabpn0JTMGlGuBhcLUmU9CbaMa0FCow0Ahk/0ZGnQew4Thfgsj2BWvMPLZ2ZFMtYF4CV/21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444535; c=relaxed/simple;
	bh=FDZCu1qhYN9VWtJ/BiJhHvAASttTVD4rdq7jh1Uk/Bk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S7ak8AldOsz2z/zsZgcQMw8qUm7plLR6+0Estr/ChvVHN4ueotb0X12PMub0kikFH08hOuH0SbdiNmGAJR8jbtlTyV978Qb+emol2903ay9zorHRuHcHJMI2MMaD5aJkpHTxXb9b2IU5JWBcq2XesP2+UN5rQfge8/dmJ3mriY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2WwUqgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DF8C2BC87
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 19:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771444534;
	bh=FDZCu1qhYN9VWtJ/BiJhHvAASttTVD4rdq7jh1Uk/Bk=;
	h=From:Date:Subject:To:Cc:From;
	b=D2WwUqgn4e6VGXKjI7oW1ffmYOzUKsDMxJIrYPrW1C54eBGThOzrVH2EgkS4iGT8T
	 XabwpaKOvkpcmArAMVivdEjVPNhBcaGt/9lf0LxNvoi96ZMB+emprOgy2jG5i0UcD/
	 U3X6HujGozfbwsBagKsKTGwdugGUFDIMOAaMGlFaHWG67Eu8h3NxDvxVk1cJz8EKMo
	 KPDq7/Yp8IfShozPYME9s5rnr5o90bRekmOTsBQC2vcV6RcOJlyW0Lhw5AFW/UyvWM
	 1gexh3PHZ6VXb/hLOnY2fRSlslSrG/T7x5Ld4I0gQA0Ym6VU7rJheahYhfiLzPYrbt
	 9ts1OtAuzUD9Q==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46391e91e16so108209b6e.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 11:55:34 -0800 (PST)
X-Gm-Message-State: AOJu0YxEQuST/ZeA+u2C1alvFkTPu6+k7QNDz4ZxikkcXoF3QaDPWJi2
	vdZh2Gj2ARyJoCUTabeOMwLO/dxG8ghaX/rXiekhvdQ91LvWrcY1234fzljCs46g6qxuyiqbhi7
	K4BSkPmNvLw2TAKwb9hy6qVdHR4URn98=
X-Received: by 2002:a05:6808:1911:b0:463:ad0a:2f38 with SMTP id
 5614622812f47-46410bb0fbcmr1698278b6e.23.1771444533918; Wed, 18 Feb 2026
 11:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Feb 2026 20:55:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hjJN0=wu9CSAOdhsbNUT26cF18uv==eKddCzdK1dHw4Q@mail.gmail.com>
X-Gm-Features: AaiRm50v9lmTRih-upbVizf1QBXgwwg-Rprws8bipLQpM4Pkr0yrjm1-dbuIwrg
Message-ID: <CAJZ5v0hjJN0=wu9CSAOdhsbNUT26cF18uv==eKddCzdK1dHw4Q@mail.gmail.com>
Subject: [GIT PULL] Additional thermal control update for v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42839-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FBEC159411
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.0-rc1-2

with top-most commit 15176b818e048ccf6ef4b96db34eda7b7e98938a

 thermal: int340x: Fix sysfs group leak on DLVR registration failure

on top of commit 0506158ac7363a70f0deb49f71d26ccb57e55990

 Merge tag 'thermal-6.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an additional thermal control update for 7.0-rc1.

This fixes a sysfs group leak on DLVR registration failure in the Intel
int340x thermal driver (Kaushlendra Kumar).

Thanks!


---------------

Kaushlendra Kumar (1):
      thermal: int340x: Fix sysfs group leak on DLVR registration failure

---------------

 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

