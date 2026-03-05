Return-Path: <linux-pm+bounces-43699-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FMhG3DGqWmcEgEAu9opvQ
	(envelope-from <linux-pm+bounces-43699-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 19:07:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC58216C85
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4236304AAD6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000CB3E5594;
	Thu,  5 Mar 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhoL4hzz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1153E3DBA
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733958; cv=none; b=tV4PGx7T9aTTLQU2ippyo6GD2mmSMM0ij7uUxuoS+QNRkuHiziM1ydNVJOw9bmjnXfDfzfk0Sp6/9FLRddZpsQRfGf7ykPPoHIPsMtzVCcmVWPOLPjki2Yhel5F/MmX+ddXtGk3YySVBAwY72uh6d5XL1b190JH/9Ya9Jn1dPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733958; c=relaxed/simple;
	bh=DMwga3k2z8PFyIn5rOhhuPrpuEm5q6rx7hL8KD9o8VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R3gDpTEvgz2PsQC02yldTi/oq6j6YjH+nw34DM9MrQxSoAX+IooWd3XVIN8QcIQLUC6sXcA3uAd5qUko1nCO17xyOcLLPNEgYTdIGm9ObR94qq6gzSCFFvtNZdCezIxjvOPfYGhmrwTHIleTRbp9W4ZJ948poEFHBgsrV0WUrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhoL4hzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938CBC4AF09
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772733958;
	bh=DMwga3k2z8PFyIn5rOhhuPrpuEm5q6rx7hL8KD9o8VQ=;
	h=From:Date:Subject:To:Cc:From;
	b=uhoL4hzzLbDSufHZ9pVhFqV1LozKNVSqhJPsnwh5ffgxcSXDL7Xnl9eYJAXMbV03G
	 w//HEGKtvLlrL/87WEDgle2PbZXlxIrCUw/qyHID7F/EnJS7AYUKOutbgC70APx94e
	 YVUwfM+zCAnv6UWNuSQ9Z2Nljnf8jLQIvL6KMJXK3LvmF8sfToo6HpS1JTLmrElRGx
	 OgWZUz3TWCT6EnOqt9F2bkiQO2FpFyVGLIKMWNinDofsLiEDU2tzsIj/1Zaj2tajF3
	 co+zZkV/sgkFFaElgM5aGuqD89C1Ls/irISNsikhOQnskh1Lb0zVYAGjyIE84YOgjp
	 ga/R2MAUx4Q/g==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40429b1d8baso1412402fac.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 10:05:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVnwFXu9+S+F73sWWbZU6wUmHC+8LzgSEPo1Lq1nWL3N6lvq48C7yeukKF5cDRi1CkZ2QvstyflQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdSdtpQXHHyqiHy+O6xwtzW3sPgYxgFy9AEu1lCO2rF3mLkmK
	2fby8mOeZsmhqcrQCfYOTUVpGKVEh53PT8thFUpaVuBN7Bc1Wxnj2gN4lZOxC+rTRc2JxFboAGg
	otcjopb3gKsLzfzMvp2sUuoLF7kpCjRA=
X-Received: by 2002:a05:6871:c90b:b0:40a:5795:153c with SMTP id
 586e51a60fabf-416aba44674mr4031088fac.34.1772733957623; Thu, 05 Mar 2026
 10:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 19:05:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h7iE4hg9ni=sCbbqsK+7uqa2+O07ve8T+s8xFa=E1E1g@mail.gmail.com>
X-Gm-Features: AaiRm507oOH02oHSrKhV6twZeWpKbdNaYVjjk57vqW_pAbvLrAnE2TjX5Bd-lhg
Message-ID: <CAJZ5v0h7iE4hg9ni=sCbbqsK+7uqa2+O07ve8T+s8xFa=E1E1g@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.0-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0CC58216C85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-43699-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc3

with top-most commit 084f843093bee5563b179fd4b630122ba820e0c7

 Merge branch 'acpica'

on top of commit 11439c4635edd669ae435eec308f4ab8a0804808

 Linux 7.0-rc2

to receive ACPI support fixes for 7.0-rc3.

These revert on problematic commit related to ACPI device power
management and update the _CPC object definition in ACPICA to
match the ACPI 6.6 specification:

 - Revert a commit related to ACPI device power management that was
   not supposed to make any functional difference, but it did so and
   introduced a regression (Rafael Wysocki)

 - Update the _CPC object definition in ACPICA to match ACPI 6.6 and
   prevent the kernel from printing a false-positive warning regarding
   _CPC output package format on platforms shipping with firmware based
   on ACPI 6.6 (Saket Dumbre)

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: PM: Let acpi_dev_pm_attach() skip devices without ACPI PM"

Saket Dumbre (1):
      ACPICA: Update the _CPC definition to match ACPI 6.6

---------------

 drivers/acpi/acpica/acpredef.h | 5 +++--
 drivers/acpi/device_pm.c       | 9 ---------
 2 files changed, 3 insertions(+), 11 deletions(-)

